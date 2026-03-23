Return-Path: <stable+bounces-228674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAClLI9TwWkYSQQAu9opvQ
	(envelope-from <stable+bounces-228674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:51:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EAD2F551E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A3780305E6F9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FEC396D3D;
	Mon, 23 Mar 2026 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kGAss1u9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D1D3AD513;
	Mon, 23 Mar 2026 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276824; cv=none; b=U5SuiAzwlU1+hmQ7nIWe1+MMI+Hu+/RkobzekxPwWI0aMifCx4hkBUSPKXQcim5RhP7Afx1FBJEWyiXoyq8Nc+OWiUWhsWqYs/dbVTuBMYtdyk7zoOYEhMIwYUTvmbe7kVQOxObDaQL5rQGWLkGwGhO39eCSAnKh/yFxKwsrFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276824; c=relaxed/simple;
	bh=0AcuCKPvIzdXvenZKdmxL+L/P1tuIveYUCDDUtZ3KAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsmUhBiuO7Y5+9IIGDTo+hJuimNSbuu0XxiEjyPBdxG4Dc4kKoFoM2ovhsdjD53oacqN+TQ3KbnwpqohySc5MLrtt4Jm9vUjokm+ENnj1cB1BiEFy7wwZPnOziE3/Qru8XjSIq5/rw/odux56R27IcL+79WvJIfHcUffAIh0SXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kGAss1u9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186C8C4CEF7;
	Mon, 23 Mar 2026 14:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774276823;
	bh=0AcuCKPvIzdXvenZKdmxL+L/P1tuIveYUCDDUtZ3KAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kGAss1u9LetGFTjxJRrBI7R6UGttkjpB/mW+4hngReOJi1/UUF6JHhsBKdK11iJrK
	 w3H4Mjm0Dikt/upu64tGlEMx9CXFeBUl4wROW8fmliWZ6B71Dh2fJnYSg6PO/s912i
	 1xssLEQdn4F90r1XoT2zH/MxYdComJ1acr3jpf6U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6.12 217/460] i3c: mipi-i3c-hci: Add missing TID field to no-op command descriptor
Date: Mon, 23 Mar 2026 14:43:33 +0100
Message-ID: <20260323134531.836645432@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228674-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B8EAD2F551E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit ec3cfd835f7c4bbd23bc9ad909d2fdc772a578bb upstream.

The internal control command descriptor used for no-op commands includes a
Transaction ID (TID) field, but the no-op command constructed in
hci_dma_dequeue_xfer() omitted it.  As a result, the hardware receives a
no-op descriptor without the expected TID.

This bug has gone unnoticed because the TID is currently not validated in
the no-op completion path, but the descriptor format requires it to be
present.

Add the missing TID field when generating a no-op descriptor so that its
layout matches the defined command structure.

Fixes: 9ad9a52cce282 ("i3c/master: introduce the mipi-i3c-hci driver")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260306072451.11131-10-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i3c/master/mipi-i3c-hci/cmd.h |    1 +
 drivers/i3c/master/mipi-i3c-hci/dma.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/i3c/master/mipi-i3c-hci/cmd.h
+++ b/drivers/i3c/master/mipi-i3c-hci/cmd.h
@@ -17,6 +17,7 @@
 #define CMD_0_TOC			W0_BIT_(31)
 #define CMD_0_ROC			W0_BIT_(30)
 #define CMD_0_ATTR			W0_MASK(2, 0)
+#define CMD_0_TID			W0_MASK(6, 3)
 
 /*
  * Response Descriptor Structure
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -482,7 +482,7 @@ static bool hci_dma_dequeue_xfer(struct
 			u32 *ring_data = rh->xfer + rh->xfer_struct_sz * idx;
 
 			/* store no-op cmd descriptor */
-			*ring_data++ = FIELD_PREP(CMD_0_ATTR, 0x7);
+			*ring_data++ = FIELD_PREP(CMD_0_ATTR, 0x7) | FIELD_PREP(CMD_0_TID, xfer->cmd_tid);
 			*ring_data++ = 0;
 			if (hci->cmd == &mipi_i3c_hci_cmd_v2) {
 				*ring_data++ = 0;



