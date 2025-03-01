Return-Path: <stable+bounces-119984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE1DA4A877
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 05:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8847189AA57
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 04:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F7B1519BE;
	Sat,  1 Mar 2025 04:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3fqST1a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F7C2C9A
	for <stable@vger.kernel.org>; Sat,  1 Mar 2025 04:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740802857; cv=none; b=bkUH9m7rB/kaxVQBheWW3QnU6Qh9Q2jtz3ODABzWysaM1mAXCzD+3NbOqyQQ+74LIn0TODtQ6XkjG0WEvqr6qLzQnq4k3KeYNDy26XvD6xRWUlXrvgiAbzkjSllGY96YsI0sxroATaLunm7hapJEn1q8EZxZgdPyycG6fuJhEco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740802857; c=relaxed/simple;
	bh=Hh79bNyV7vChD8BN8GdPtSRS8wSY0vIqPSM2GG/LXs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCAlNq27RySVgVKYFNaw1PxZS+LfVDLp886TkPdt6vPaoR/rM1g5IR1z8PZbb3foIVewq7sLBQS0R5Z7pGf6JLDmULYOW0KF3ZHMxxoA/3JkAJtT64Tbbp3y78NIWHubqp9bAJJIQUICAxVcQY6oBMvOsCRvDPGkWYIVW5E0QzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3fqST1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF8DC4CEDD;
	Sat,  1 Mar 2025 04:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740802856;
	bh=Hh79bNyV7vChD8BN8GdPtSRS8wSY0vIqPSM2GG/LXs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3fqST1a2RX/ZoXKvbGVLM0+EDDY1oGCMkcuMzGRAi/cwr/XnRFHxwWLfgaTwbAbf
	 umcvEeb1/RYIfELWg2z6w+J3WlnGGzEgftRv0Mvp2sonuWA8A4N9b+mb5ZIM51MMNx
	 QkwmwQ1u6AQxnK/JITeFV0ZyzFb9/KeaKe0JtHekOfdQT/QmmKOkfoNzD1YB4OZYyx
	 Om2Q6drUw0qi6j6o2xbD5uL6d/PRu1Qj62n06Z1H7lzg34pZMu36yl34QrWbWCdowD
	 hy/MBscCdYAUpd5uzzkJxv1WbCWinaD+Wx5Ft7gcFJXGmb05GiBDerM77uzCxJ372V
	 Nwxzp0+kY2fbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ribalda@chromium.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] media: uvcvideo: Only save async fh if success
Date: Fri, 28 Feb 2025 23:20:33 -0500
Message-Id: <20250228182414-4ebce17510bb0f99@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250228081200.2672808-1-ribalda@chromium.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it
ℹ️ Patch is missing in 6.13.y (ignore if backport was sent)
⚠️ Commit missing in all newer stable branches

Found matching upstream commit: d9fecd096f67a4469536e040a8a10bbfb665918b

Status in newer kernel trees:
6.13.y | Present (different SHA1: e515ccef73e2)
6.12.y | Present (different SHA1: 34fb9eb31d66)
6.6.y | Present (different SHA1: 08384382e1db)
6.1.y | Present (different SHA1: 050053a7c0ad)
5.15.y | Present (different SHA1: cb6b5a03892d)
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  d9fecd096f67a ! 1:  d1be59fbb0d41 media: uvcvideo: Only save async fh if success
    @@ Commit message
         Link: https://lore.kernel.org/r/20241203-uvc-fix-async-v6-1-26c867231118@chromium.org
         Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
         Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
    +    (cherry picked from commit d9fecd096f67a4469536e040a8a10bbfb665918b)
     
      ## drivers/media/usb/uvc/uvc_ctrl.c ##
     @@ drivers/media/usb/uvc/uvc_ctrl.c: int uvc_ctrl_begin(struct uvc_video_chain *chain)
      }
      
      static int uvc_ctrl_commit_entity(struct uvc_device *dev,
    --	struct uvc_entity *entity, int rollback, struct uvc_control **err_ctrl)
    +-	struct uvc_entity *entity, int rollback)
     +				  struct uvc_fh *handle,
     +				  struct uvc_entity *entity,
    -+				  int rollback,
    -+				  struct uvc_control **err_ctrl)
    ++				  int rollback)
      {
      	struct uvc_control *ctrl;
      	unsigned int i;
     @@ drivers/media/usb/uvc/uvc_ctrl.c: static int uvc_ctrl_commit_entity(struct uvc_device *dev,
    - 				*err_ctrl = ctrl;
    + 
    + 		if (ret < 0)
      			return ret;
    - 		}
     +
     +		if (!rollback && handle &&
     +		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
    @@ drivers/media/usb/uvc/uvc_ctrl.c: int __uvc_ctrl_commit(struct uvc_fh *handle, i
      
      	/* Find the control. */
      	list_for_each_entry(entity, &chain->entities, chain) {
    --		ret = uvc_ctrl_commit_entity(chain->dev, entity, rollback,
    --					     &err_ctrl);
    +-		ret = uvc_ctrl_commit_entity(chain->dev, entity, rollback);
     +		ret = uvc_ctrl_commit_entity(chain->dev, handle, entity,
    -+					     rollback, &err_ctrl);
    - 		if (ret < 0) {
    - 			if (ctrls)
    - 				ctrls->error_idx =
    ++					     rollback);
    + 		if (ret < 0)
    + 			goto done;
    + 	}
     @@ drivers/media/usb/uvc/uvc_ctrl.c: int uvc_ctrl_set(struct uvc_fh *handle,
      	mapping->set(mapping, value,
      		uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
    @@ drivers/media/usb/uvc/uvc_ctrl.c: int uvc_ctrl_restore_values(struct uvc_device
      			ctrl->dirty = 1;
      		}
      
    --		ret = uvc_ctrl_commit_entity(dev, entity, 0, NULL);
    -+		ret = uvc_ctrl_commit_entity(dev, NULL, entity, 0, NULL);
    +-		ret = uvc_ctrl_commit_entity(dev, entity, 0);
    ++		ret = uvc_ctrl_commit_entity(dev, NULL, entity, 0);
      		if (ret < 0)
      			return ret;
      	}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

