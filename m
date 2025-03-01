Return-Path: <stable+bounces-120001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4011A4A888
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 05:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB90175BBA
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 04:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDE9191F77;
	Sat,  1 Mar 2025 04:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcU0AQGc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC42C9A
	for <stable@vger.kernel.org>; Sat,  1 Mar 2025 04:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740802883; cv=none; b=Tuwu4j53B1QT+4G7m1k/qsyqfSQT29O6vKi0zEgEhwmWBAMiiuVqdaUR4nxhKRY4xo/d85GaSHigKYFSs0XkJ1OCN5QnfmDFCVA8CdWrw98PEHbNDCZJl+k16Dst+gtCqhP0X7lRV3Vx0MIxvBJGJ5t/wijCSvsVR3J5Yn0pXSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740802883; c=relaxed/simple;
	bh=Gl2wLHaush8TByPutRSvLjyMpg7mastTvTw98LqEQQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQGZc9eTE82PY7e1nfl2r+P7yPMmFV9x7yyL3e+ooW+TdgST7+/z0Vkm+TrrE79gZ14LEBYxvyIMBqhJcGS/w21RVThjdt4KZ41H4uwM20zVbtW6yt/kpj0YfKRVLEzPTe/A6BNb/DdCgKI0zHEUhVpx/FF4VfJFCgN6O6dqnnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcU0AQGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51230C4CEF3;
	Sat,  1 Mar 2025 04:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740802883;
	bh=Gl2wLHaush8TByPutRSvLjyMpg7mastTvTw98LqEQQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GcU0AQGcsdu2IJ2n4XIYwCp5E+X3RkXHs4ag6t0raRsUr7ZhjxjcukXRFR1fT8W0K
	 Nv7dIUsgnCy2c9uxe1lyLBA1vFc3d69gOSkh3Z5h3uMuBBNikbxHtES0Vv73x8DOET
	 i1nvZk9O7rcgku0f6uX5h3sIFKBp3dwsJsmd72l4FJ0IszM7XrORxSr8RkgPN7NFQz
	 kyUuKeM16q1pFtR0AWCMvK9x1wpULrH5RIfRlwOVGRHHLjyNn+X4JQV+TYWj5M/twZ
	 UjPDja/eRrkcWC/NBeWPyRdGWQKeWtdFK7cwbfUoLCjbxxRwhncDdkRZ++FZgC/R1A
	 Vx0tprAqLpKPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ribalda@chromium.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] media: uvcvideo: Only save async fh if success
Date: Fri, 28 Feb 2025 23:21:00 -0500
Message-Id: <20250228174620-850e8d4f355ba941@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250228081538.2678441-1-ribalda@chromium.org>
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
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  d9fecd096f67a ! 1:  5d6f315982bfa media: uvcvideo: Only save async fh if success
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
| stable/linux-5.15.y       |  Success    |  Success   |

