Return-Path: <stable+bounces-46148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 560B08CEF92
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 16:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E813F1F21216
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 14:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A135E091;
	Sat, 25 May 2024 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ulHhWUdG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE5542ABD
	for <stable@vger.kernel.org>; Sat, 25 May 2024 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716649129; cv=none; b=TEbcLGol+6FiPQv6rh7cNpPsA5k+mxQixuTZAZc1flRrXtvL1I+ouVlxbnIM6eS1hF5GBBS8xSCdSYT7Yy8OULU52Z5eVoUWdoDEnq5Wo+ZKhjyT4kTB5lw/5NTDLcf5NZ97KLIjdD6xVNK83O/SJ3FQnlwo9FyGwe9cV4sTjxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716649129; c=relaxed/simple;
	bh=lJfHo4VN9C+knEq2I3i8oYW5Cxms6Ajk4f0xDrX7/0I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LQ2KLlt6if4IgZaAz7TlTprlcLadcI8cD9VIAN2RaEb3CVDm9DJGBt6746OuF3lShPQofn/LfcibNL+rsswYBzjHq9QIAv0sU8LyHnSNLRF1e4bfaS2DegZ+mohfyzPkhG2Oqj9NzOi8QmalulKAfKYrTWXVnCBsddDuLxyNUT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ulHhWUdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125F1C2BD11;
	Sat, 25 May 2024 14:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716649129;
	bh=lJfHo4VN9C+knEq2I3i8oYW5Cxms6Ajk4f0xDrX7/0I=;
	h=Subject:To:Cc:From:Date:From;
	b=ulHhWUdGyoE7nWePNOPGwesSAvotIutnfudhWLKtEqSHCpsuq2B3OZl/XzAA+Maas
	 DSP0UEGIKjhf1F1w75ZEnRR8cU/HJEXVYs2o4a82QDC+tS0bDVBtPJ3tJvVZP70BfU
	 c7gWwUeHomLeebAncBFAUmszqQICknALPAt66qtM=
Subject: FAILED: patch "[PATCH] tty: n_gsm: fix possible out-of-bounds in gsm0_receive()" failed to apply to 5.4-stable tree
To: daniel.starke@siemens.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 25 May 2024 16:58:38 +0200
Message-ID: <2024052538-octagon-unleash-663f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 47388e807f85948eefc403a8a5fdc5b406a65d5a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024052538-octagon-unleash-663f@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 47388e807f85948eefc403a8a5fdc5b406a65d5a Mon Sep 17 00:00:00 2001
From: Daniel Starke <daniel.starke@siemens.com>
Date: Wed, 24 Apr 2024 07:48:41 +0200
Subject: [PATCH] tty: n_gsm: fix possible out-of-bounds in gsm0_receive()

Assuming the following:
- side A configures the n_gsm in basic option mode
- side B sends the header of a basic option mode frame with data length 1
- side A switches to advanced option mode
- side B sends 2 data bytes which exceeds gsm->len
  Reason: gsm->len is not used in advanced option mode.
- side A switches to basic option mode
- side B keeps sending until gsm0_receive() writes past gsm->buf
  Reason: Neither gsm->state nor gsm->len have been reset after
  reconfiguration.

Fix this by changing gsm->count to gsm->len comparison from equal to less
than. Also add upper limit checks against the constant MAX_MRU in
gsm0_receive() and gsm1_receive() to harden against memory corruption of
gsm->len and gsm->mru.

All other checks remain as we still need to limit the data according to the
user configuration and actual payload size.

Reported-by: j51569436@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218708
Tested-by: j51569436@gmail.com
Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
Link: https://lore.kernel.org/r/20240424054842.7741-1-daniel.starke@siemens.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 4036566febcb..72b82bf1c280 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2913,7 +2913,10 @@ static void gsm0_receive(struct gsm_mux *gsm, u8 c)
 		break;
 	case GSM_DATA:		/* Data */
 		gsm->buf[gsm->count++] = c;
-		if (gsm->count == gsm->len) {
+		if (gsm->count >= MAX_MRU) {
+			gsm->bad_size++;
+			gsm->state = GSM_SEARCH;
+		} else if (gsm->count >= gsm->len) {
 			/* Calculate final FCS for UI frames over all data */
 			if ((gsm->control & ~PF) != UIH) {
 				gsm->fcs = gsm_fcs_add_block(gsm->fcs, gsm->buf,
@@ -3026,7 +3029,7 @@ static void gsm1_receive(struct gsm_mux *gsm, u8 c)
 		gsm->state = GSM_DATA;
 		break;
 	case GSM_DATA:		/* Data */
-		if (gsm->count > gsm->mru) {	/* Allow one for the FCS */
+		if (gsm->count > gsm->mru || gsm->count > MAX_MRU) {	/* Allow one for the FCS */
 			gsm->state = GSM_OVERRUN;
 			gsm->bad_size++;
 		} else


