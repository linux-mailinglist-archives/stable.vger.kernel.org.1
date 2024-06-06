Return-Path: <stable+bounces-48774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35E48FEA77
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EDC2289F59
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E071A01AA;
	Thu,  6 Jun 2024 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CkLMxNu9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2A21A01A8;
	Thu,  6 Jun 2024 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683141; cv=none; b=BdChamRKiHr1iKBE/tYYnPHLaEoMAjh8fURZklQ3kpFIar2k3u2+S97pSgj8umkSaf+oy/atXYqKBG9213ecGw0jhbiEJLfh+MHRTXNEZchgJg/6YztclgpZU0mllEtBFYqgbmZ/XEtf7nL2iRnewkT525NSg/xyYqfYZXaiWa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683141; c=relaxed/simple;
	bh=wiD2ak6qjxv/n9XISqocAiINHR4zJi6f8dhMirIP1Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDM7xaXnRy3wi0BBk+TbviGfsRZsBmmG/whl0stSsPdFnwV9SfPs6WHqy8Pe3/8N+vpksQMZypV2unPA66fPV7ot+rUuAf7GJ0TfCJ+1tTcfluTjJVYNb80Vtds7ccp3zFC4Zn9tgkdN9qk9ol9azfNWk5kLm/Oh7xN9foMcJb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CkLMxNu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2513C2BD10;
	Thu,  6 Jun 2024 14:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683141;
	bh=wiD2ak6qjxv/n9XISqocAiINHR4zJi6f8dhMirIP1Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CkLMxNu9ZHtpGu17dOLlAQJz2Y6nr08njQUsgerEewmJmlzyB9RUkAvmdQgXrUcen
	 ul5ZORb+vsXsLfshCGeGz+dnC3/2KV1jNWiDi0Iqo6Ie9GKGzZ1P8bLl6eNG+zUZ3W
	 3wWyYgUyPveXGmfDpYc0DwKwcVHKBBCTv1JlDhA4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 6.1 004/473] tty: n_gsm: fix missing receive state reset after mode switch
Date: Thu,  6 Jun 2024 15:58:53 +0200
Message-ID: <20240606131659.954139354@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Starke <daniel.starke@siemens.com>

commit 70d7f1427afcf7fa2d21cb5a04c6f3555d5b9357 upstream.

The current implementation uses either gsm0_receive() or gsm1_receive()
depending on whether the user configured the mux in basic or advanced
option mode. Both functions share some state values over the same logical
elements of the frame. However, both frame types differ in their nature.
gsm0_receive() uses non-transparency framing, whereas gsm1_receive() uses
transparency mechanism. Switching between both modes leaves the receive
function in an undefined state when done during frame reception.

Fix this by splitting both states. Add gsm0_receive_state_check_and_fix()
and gsm1_receive_state_check_and_fix() to ensure that gsm->state is reset
after a change of gsm->receive.

Note that gsm->state is only accessed in:
- gsm0_receive()
- gsm1_receive()
- gsm_error()

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
Link: https://lore.kernel.org/r/20240424054842.7741-2-daniel.starke@siemens.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/n_gsm.c |  133 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 92 insertions(+), 41 deletions(-)

--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -202,16 +202,18 @@ enum gsm_encoding {
 
 enum gsm_mux_state {
 	GSM_SEARCH,
-	GSM_START,
-	GSM_ADDRESS,
-	GSM_CONTROL,
-	GSM_LEN,
-	GSM_DATA,
-	GSM_FCS,
-	GSM_OVERRUN,
-	GSM_LEN0,
-	GSM_LEN1,
-	GSM_SSOF,
+	GSM0_ADDRESS,
+	GSM0_CONTROL,
+	GSM0_LEN0,
+	GSM0_LEN1,
+	GSM0_DATA,
+	GSM0_FCS,
+	GSM0_SSOF,
+	GSM1_START,
+	GSM1_ADDRESS,
+	GSM1_CONTROL,
+	GSM1_DATA,
+	GSM1_OVERRUN,
 };
 
 /*
@@ -2259,6 +2261,30 @@ invalid:
 	return;
 }
 
+/**
+ * gsm0_receive_state_check_and_fix	-	check and correct receive state
+ * @gsm: gsm data for this ldisc instance
+ *
+ * Ensures that the current receive state is valid for basic option mode.
+ */
+
+static void gsm0_receive_state_check_and_fix(struct gsm_mux *gsm)
+{
+	switch (gsm->state) {
+	case GSM_SEARCH:
+	case GSM0_ADDRESS:
+	case GSM0_CONTROL:
+	case GSM0_LEN0:
+	case GSM0_LEN1:
+	case GSM0_DATA:
+	case GSM0_FCS:
+	case GSM0_SSOF:
+		break;
+	default:
+		gsm->state = GSM_SEARCH;
+		break;
+	}
+}
 
 /**
  *	gsm0_receive	-	perform processing for non-transparency
@@ -2272,26 +2298,27 @@ static void gsm0_receive(struct gsm_mux
 {
 	unsigned int len;
 
+	gsm0_receive_state_check_and_fix(gsm);
 	switch (gsm->state) {
 	case GSM_SEARCH:	/* SOF marker */
 		if (c == GSM0_SOF) {
-			gsm->state = GSM_ADDRESS;
+			gsm->state = GSM0_ADDRESS;
 			gsm->address = 0;
 			gsm->len = 0;
 			gsm->fcs = INIT_FCS;
 		}
 		break;
-	case GSM_ADDRESS:	/* Address EA */
+	case GSM0_ADDRESS:	/* Address EA */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		if (gsm_read_ea(&gsm->address, c))
-			gsm->state = GSM_CONTROL;
+			gsm->state = GSM0_CONTROL;
 		break;
-	case GSM_CONTROL:	/* Control Byte */
+	case GSM0_CONTROL:	/* Control Byte */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		gsm->control = c;
-		gsm->state = GSM_LEN0;
+		gsm->state = GSM0_LEN0;
 		break;
-	case GSM_LEN0:		/* Length EA */
+	case GSM0_LEN0:		/* Length EA */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		if (gsm_read_ea(&gsm->len, c)) {
 			if (gsm->len > gsm->mru) {
@@ -2301,14 +2328,14 @@ static void gsm0_receive(struct gsm_mux
 			}
 			gsm->count = 0;
 			if (!gsm->len)
-				gsm->state = GSM_FCS;
+				gsm->state = GSM0_FCS;
 			else
-				gsm->state = GSM_DATA;
+				gsm->state = GSM0_DATA;
 			break;
 		}
-		gsm->state = GSM_LEN1;
+		gsm->state = GSM0_LEN1;
 		break;
-	case GSM_LEN1:
+	case GSM0_LEN1:
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		len = c;
 		gsm->len |= len << 7;
@@ -2319,11 +2346,11 @@ static void gsm0_receive(struct gsm_mux
 		}
 		gsm->count = 0;
 		if (!gsm->len)
-			gsm->state = GSM_FCS;
+			gsm->state = GSM0_FCS;
 		else
-			gsm->state = GSM_DATA;
+			gsm->state = GSM0_DATA;
 		break;
-	case GSM_DATA:		/* Data */
+	case GSM0_DATA:		/* Data */
 		gsm->buf[gsm->count++] = c;
 		if (gsm->count >= MAX_MRU) {
 			gsm->bad_size++;
@@ -2334,14 +2361,14 @@ static void gsm0_receive(struct gsm_mux
 				gsm->fcs = gsm_fcs_add_block(gsm->fcs, gsm->buf,
 							     gsm->count);
 			}
-			gsm->state = GSM_FCS;
+			gsm->state = GSM0_FCS;
 		}
 		break;
-	case GSM_FCS:		/* FCS follows the packet */
+	case GSM0_FCS:		/* FCS follows the packet */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
-		gsm->state = GSM_SSOF;
+		gsm->state = GSM0_SSOF;
 		break;
-	case GSM_SSOF:
+	case GSM0_SSOF:
 		gsm->state = GSM_SEARCH;
 		if (c == GSM0_SOF)
 			gsm_queue(gsm);
@@ -2355,6 +2382,29 @@ static void gsm0_receive(struct gsm_mux
 }
 
 /**
+ * gsm1_receive_state_check_and_fix	-	check and correct receive state
+ * @gsm: gsm data for this ldisc instance
+ *
+ * Ensures that the current receive state is valid for advanced option mode.
+ */
+
+static void gsm1_receive_state_check_and_fix(struct gsm_mux *gsm)
+{
+	switch (gsm->state) {
+	case GSM_SEARCH:
+	case GSM1_START:
+	case GSM1_ADDRESS:
+	case GSM1_CONTROL:
+	case GSM1_DATA:
+	case GSM1_OVERRUN:
+		break;
+	default:
+		gsm->state = GSM_SEARCH;
+		break;
+	}
+}
+
+/**
  *	gsm1_receive	-	perform processing for non-transparency
  *	@gsm: gsm data for this ldisc instance
  *	@c: character
@@ -2364,6 +2414,7 @@ static void gsm0_receive(struct gsm_mux
 
 static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 {
+	gsm1_receive_state_check_and_fix(gsm);
 	/* handle XON/XOFF */
 	if ((c & ISO_IEC_646_MASK) == XON) {
 		gsm->constipated = true;
@@ -2376,11 +2427,11 @@ static void gsm1_receive(struct gsm_mux
 	}
 	if (c == GSM1_SOF) {
 		/* EOF is only valid in frame if we have got to the data state */
-		if (gsm->state == GSM_DATA) {
+		if (gsm->state == GSM1_DATA) {
 			if (gsm->count < 1) {
 				/* Missing FSC */
 				gsm->malformed++;
-				gsm->state = GSM_START;
+				gsm->state = GSM1_START;
 				return;
 			}
 			/* Remove the FCS from data */
@@ -2396,14 +2447,14 @@ static void gsm1_receive(struct gsm_mux
 			gsm->fcs = gsm_fcs_add(gsm->fcs, gsm->buf[gsm->count]);
 			gsm->len = gsm->count;
 			gsm_queue(gsm);
-			gsm->state  = GSM_START;
+			gsm->state  = GSM1_START;
 			return;
 		}
 		/* Any partial frame was a runt so go back to start */
-		if (gsm->state != GSM_START) {
+		if (gsm->state != GSM1_START) {
 			if (gsm->state != GSM_SEARCH)
 				gsm->malformed++;
-			gsm->state = GSM_START;
+			gsm->state = GSM1_START;
 		}
 		/* A SOF in GSM_START means we are still reading idling or
 		   framing bytes */
@@ -2424,30 +2475,30 @@ static void gsm1_receive(struct gsm_mux
 		gsm->escape = false;
 	}
 	switch (gsm->state) {
-	case GSM_START:		/* First byte after SOF */
+	case GSM1_START:		/* First byte after SOF */
 		gsm->address = 0;
-		gsm->state = GSM_ADDRESS;
+		gsm->state = GSM1_ADDRESS;
 		gsm->fcs = INIT_FCS;
 		fallthrough;
-	case GSM_ADDRESS:	/* Address continuation */
+	case GSM1_ADDRESS:	/* Address continuation */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		if (gsm_read_ea(&gsm->address, c))
-			gsm->state = GSM_CONTROL;
+			gsm->state = GSM1_CONTROL;
 		break;
-	case GSM_CONTROL:	/* Control Byte */
+	case GSM1_CONTROL:	/* Control Byte */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		gsm->control = c;
 		gsm->count = 0;
-		gsm->state = GSM_DATA;
+		gsm->state = GSM1_DATA;
 		break;
-	case GSM_DATA:		/* Data */
+	case GSM1_DATA:		/* Data */
 		if (gsm->count > gsm->mru || gsm->count > MAX_MRU) {	/* Allow one for the FCS */
-			gsm->state = GSM_OVERRUN;
+			gsm->state = GSM1_OVERRUN;
 			gsm->bad_size++;
 		} else
 			gsm->buf[gsm->count++] = c;
 		break;
-	case GSM_OVERRUN:	/* Over-long - eg a dropped SOF */
+	case GSM1_OVERRUN:	/* Over-long - eg a dropped SOF */
 		break;
 	default:
 		pr_debug("%s: unhandled state: %d\n", __func__, gsm->state);



