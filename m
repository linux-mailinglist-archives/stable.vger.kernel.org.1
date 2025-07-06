Return-Path: <stable+bounces-160309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CF3AFA4F9
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 13:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5053BD244
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 11:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A86202C44;
	Sun,  6 Jul 2025 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SVSxs8Sb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EEC14A0A8
	for <stable@vger.kernel.org>; Sun,  6 Jul 2025 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751802765; cv=none; b=VL+KAOrlp1QDYXBlMiBtqFPsX7W+mPleYZDtDei4hMvR9O9p4V1TBawvEYyoTUmDMzHZGKZTCAMS0sMIuiIkI2tlf6BBFA40awKaljz2A+opKmcQ/GJvQheGVZagTOIzrkEiVS01T3TJEzM44/fbg7OodLolUys5U2qhmMsUzrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751802765; c=relaxed/simple;
	bh=5jHdirISxS450MtdIGSiThghnHDk1QKMtGHjemTrCro=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a2AvpWybBM4YB9lxFJxgFJhcYVbCEbpmivj1jOoQnPJjNLgTOjVnrujJod4wE2g67S4SsRc3HPa9ETvSOoZTysDwKw61KvYJWY1ssROEpr6qbMIEDqj1EObecfM4kdLwYTefJ5xkKZkt6ilNfhYCNxrbqJfmVD770nojZEdPwwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SVSxs8Sb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F36CC4CEED;
	Sun,  6 Jul 2025 11:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751802765;
	bh=5jHdirISxS450MtdIGSiThghnHDk1QKMtGHjemTrCro=;
	h=Subject:To:Cc:From:Date:From;
	b=SVSxs8SbGEQ0XWmkfHoBrUIuHLv/YGMX7D3JL4VCszrBjwgXgLCD6IrtA30K9Fnxf
	 T7jjaw45I/dGqxhyBqdhdgd1nDSj+gt7Ckiiievq12AR9UthIMGbH/ZiWI7dAUIEOC
	 EMoVrur6ce7Xb8UCeC1lmT+sZNKca4id/+pPEKA0=
Subject: FAILED: patch "[PATCH] mtk-sd: Prevent memory corruption from DMA map failure" failed to apply to 5.4-stable tree
To: mhiramat@kernel.org,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 06 Jul 2025 13:52:35 +0200
Message-ID: <2025070635-mockup-amicably-51ad@gregkh>
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
git cherry-pick -x f5de469990f19569627ea0dd56536ff5a13beaa3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070635-mockup-amicably-51ad@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f5de469990f19569627ea0dd56536ff5a13beaa3 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Thu, 12 Jun 2025 20:26:10 +0900
Subject: [PATCH] mtk-sd: Prevent memory corruption from DMA map failure

If msdc_prepare_data() fails to map the DMA region, the request is
not prepared for data receiving, but msdc_start_data() proceeds
the DMA with previous setting.
Since this will lead a memory corruption, we have to stop the
request operation soon after the msdc_prepare_data() fails to
prepare it.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: 208489032bdd ("mmc: mediatek: Add Mediatek MMC driver")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/174972756982.3337526.6755001617701603082.stgit@mhiramat.tok.corp.google.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index b1d1586cf1fc..b12cfb9a5e5f 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -853,6 +853,11 @@ static void msdc_prepare_data(struct msdc_host *host, struct mmc_data *data)
 	}
 }
 
+static bool msdc_data_prepared(struct mmc_data *data)
+{
+	return data->host_cookie & MSDC_PREPARE_FLAG;
+}
+
 static void msdc_unprepare_data(struct msdc_host *host, struct mmc_data *data)
 {
 	if (data->host_cookie & MSDC_ASYNC_FLAG)
@@ -1484,8 +1489,18 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	WARN_ON(!host->hsq_en && host->mrq);
 	host->mrq = mrq;
 
-	if (mrq->data)
+	if (mrq->data) {
 		msdc_prepare_data(host, mrq->data);
+		if (!msdc_data_prepared(mrq->data)) {
+			/*
+			 * Failed to prepare DMA area, fail fast before
+			 * starting any commands.
+			 */
+			mrq->cmd->error = -ENOSPC;
+			mmc_request_done(mmc_from_priv(host), mrq);
+			return;
+		}
+	}
 
 	/* if SBC is required, we have HW option and SW option.
 	 * if HW option is enabled, and SBC does not have "special" flags,


