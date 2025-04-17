Return-Path: <stable+bounces-132936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D8FA9187D
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C096319E24C1
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 09:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EBF21C162;
	Thu, 17 Apr 2025 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l0yHRrD1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D844B1898FB
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883922; cv=none; b=XQ5f5s0ejOAnN8XO2WnrN/Mpxn3b6fG5GJR6J23My1ZFbeK/5UOpjBr6nkoBVsNomMtPaKyEQdbElIccsHGZ0Bf2y6+sv4TEFVXtZI33274oJlfccqs9koVHUu2UItXir6iU6C4gk7IpDSlkWwVIeunGjzbNBVJ0UCZ8Rlcu7GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883922; c=relaxed/simple;
	bh=XdifVv9xDMNPKrWnO2/3t7/sF/0aK987EkOYZ7cksCI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EOHDGMAj6qOujUAgaEUUdOCvDYUtHwCaZYRNjGTDCMd8ZdYTMsPXt915NVwmChMzrZa/8xb6dCThuon1C8NFJcq76H1gAQ+VoJJ3R8/1k/2ghZ7pWGEZku2RCuRAJaXat1PYMEFokU9HuOvo0d2yjR1UV82jjj9dUKYgKjImYqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l0yHRrD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7820C4CEE4;
	Thu, 17 Apr 2025 09:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744883921;
	bh=XdifVv9xDMNPKrWnO2/3t7/sF/0aK987EkOYZ7cksCI=;
	h=Subject:To:Cc:From:Date:From;
	b=l0yHRrD1TOrEFTZ7+fQRXvUV8eEflkPGQfZc/hUa5QO0iaMMT3c22QBx2quMsBzp2
	 PDS4nA2WWAmNsLnp/8nREUa/6+1jVe/5bZh035oHtqyf1Z34qu5/IBbSWMEn/zh+aL
	 VQnz5DfH5t8aq8/rtgBpkPaiIUCPtEswIyzpllPQ=
Subject: FAILED: patch "[PATCH] media: mediatek: vcodec: Fix a resource leak related to the" failed to apply to 6.1-stable tree
To: jiashengjiangcool@gmail.com,hverkuil@xs4all.nl
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 11:58:38 +0200
Message-ID: <2025041738-unfounded-kitten-3d41@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4936cd5817af35d23e4d283f48fa59a18ef481e4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041738-unfounded-kitten-3d41@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4936cd5817af35d23e4d283f48fa59a18ef481e4 Mon Sep 17 00:00:00 2001
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Date: Tue, 18 Feb 2025 18:58:09 +0000
Subject: [PATCH] media: mediatek: vcodec: Fix a resource leak related to the
 scp device in FW initialization

On Mediatek devices with a system companion processor (SCP) the mtk_scp
structure has to be removed explicitly to avoid a resource leak.
Free the structure in case the allocation of the firmware structure fails
during the firmware initialization.

Fixes: 53dbe0850444 ("media: mtk-vcodec: potential null pointer deference in SCP")
Cc: stable@vger.kernel.org
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
index ff23b225db70..1b0bc47355c0 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
@@ -79,8 +79,11 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(void *priv, enum mtk_vcodec_fw_use
 	}
 
 	fw = devm_kzalloc(&plat_dev->dev, sizeof(*fw), GFP_KERNEL);
-	if (!fw)
+	if (!fw) {
+		scp_put(scp);
 		return ERR_PTR(-ENOMEM);
+	}
+
 	fw->type = SCP;
 	fw->ops = &mtk_vcodec_rproc_msg;
 	fw->scp = scp;


