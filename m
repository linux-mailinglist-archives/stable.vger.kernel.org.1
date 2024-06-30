Return-Path: <stable+bounces-56138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B60C91D0EB
	for <lists+stable@lfdr.de>; Sun, 30 Jun 2024 11:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BCA1C209F5
	for <lists+stable@lfdr.de>; Sun, 30 Jun 2024 09:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4012B12D209;
	Sun, 30 Jun 2024 09:50:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C8B12D1E0
	for <stable@vger.kernel.org>; Sun, 30 Jun 2024 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719741035; cv=none; b=Y/PjDwiKHwrUyNG+Asg7sEYvKQfeYvVvNUQTcZHSb9pQTGhw/ixijXCoGuJ0EeoM8sxouS1OPrG1gJurTyex95tII6GazdC8WiFqDVnwcHJkhvMOLbrtu3ErRZD2Dr0GfLnhHRLRTpN9ebqEdpqACa+L0oQuNzbzaS+8nG6ePIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719741035; c=relaxed/simple;
	bh=bK1nQ7oQCWQFkB4OP3h6Jg1GwHreKh+GYLywUbn6HeE=;
	h=From:Date:Subject:To:Cc:Message-Id; b=ByG/ppo4o8thuzcipGlEjcdtvVK93uYWhsy+RSH2m42UBbXCPUk3dmcN3vRE3mMvzYWwKmVopFiYWrwlGeXAjSIBnGB0lZGoV46CwrCbvt1byWqvaOM2BkGGTq0wwMSjI4BJSqbjDNoDAuDBbZwUnyXW+UQuMVkRPRbRvFmbf1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1sNqlz-0007gO-1D;
	Sun, 30 Jun 2024 09:23:03 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Sun, 30 Jun 2024 09:22:44 +0000
Subject: [git:media_stage/master] media: venus: fix use after free in vdec_close
To: linuxtv-commits@linuxtv.org
Cc: Dikshita Agarwal <quic_dikshita@quicinc.com>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, stable@vger.kernel.org, Vikash Garodia <quic_vgarodia@quicinc.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1sNqlz-0007gO-1D@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: venus: fix use after free in vdec_close
Author:  Dikshita Agarwal <quic_dikshita@quicinc.com>
Date:    Thu May 9 10:44:29 2024 +0530

There appears to be a possible use after free with vdec_close().
The firmware will add buffer release work to the work queue through
HFI callbacks as a normal part of decoding. Randomly closing the
decoder device from userspace during normal decoding can incur
a read after free for inst.

Fix it by cancelling the work in vdec_close.

Cc: stable@vger.kernel.org
Fixes: af2c3834c8ca ("[media] media: venus: adding core part and helper functions")
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Acked-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/platform/qcom/venus/vdec.c | 1 +
 1 file changed, 1 insertion(+)

---

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 0d2ab95bec0f..d12089370d91 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1747,6 +1747,7 @@ static int vdec_close(struct file *file)
 
 	vdec_pm_get(inst);
 
+	cancel_work_sync(&inst->delayed_process_work);
 	v4l2_m2m_ctx_release(inst->m2m_ctx);
 	v4l2_m2m_release(inst->m2m_dev);
 	vdec_ctrl_deinit(inst);

