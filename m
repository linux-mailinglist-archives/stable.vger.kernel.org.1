Return-Path: <stable+bounces-119993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC847A4A87F
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 05:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7A83BA1F2
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 04:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B089B1519BE;
	Sat,  1 Mar 2025 04:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6JfkGnx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD8D2C9A
	for <stable@vger.kernel.org>; Sat,  1 Mar 2025 04:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740802871; cv=none; b=lx8SqWomQMerMFA/JUMbBOuI/OAE4PvaRLOvNtb+D+v9S4bL3jZLZ0Q/cBr0pWfBJySZ9Z/+66LUQF7CY4cRojZKjMfECwQUgScuMGz8AX6ooep4mKzFUuw+eFc9QCoNLTwW8fWk28qCznsrGJ68St1GzsDDw+G9yjKMiQwl8pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740802871; c=relaxed/simple;
	bh=Dl7e7Bac9CYGxk511+kM4f5m/dfcF2CT0JVA0QOCxlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgLajLxV5xaa9WP7P44b1V2n3ZtS6bCUbEBm2zMN852jw7CbczoLjGAzBiRwHqwC9xgEUrbNJNOrb64V6/4g2z60z+2Ku7p7mcZwd2GnPXY+rshZDjHi5BZVwKNE87wCUr95pnzU1JHzccOeRlZxaAsVmb0B6OfNkvQkFTPIJ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6JfkGnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5C9C4CEF3;
	Sat,  1 Mar 2025 04:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740802870;
	bh=Dl7e7Bac9CYGxk511+kM4f5m/dfcF2CT0JVA0QOCxlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a6JfkGnxAR/dY8tiCDvbMqM0/ijIVhClXLPrHF5XckyrMGHMFeEpXaFIUlCSPi12M
	 cDeX+ltyR3uSwMf+9NZhSoQgKoKVAf3ZXVMvP++Gh9Rq7TI7rmbXzmMt4cYcBflfxc
	 a2ZzPBXrR2RAtngtEX4drlPMGlp6Y7KHJh0F2b0KLyU1cKtQxKl/mnMoeE3iIt6JWh
	 osWcedxTdrevOWayU5OCHHl4cE3A2o9tXuXBeDXsaIdsyyUTak+/niixqa8HjzJWNV
	 Dc/mKLSoKs4pju3P7vpWTR3URqVCTmZ7CGIQYSoGS4jqDfIqgGWKQE9X3j135ycDdx
	 PCWYaZyc5arcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ribalda@chromium.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] media: uvcvideo: Only save async fh if success
Date: Fri, 28 Feb 2025 23:20:47 -0500
Message-Id: <20250228183328-4e13853b3444773c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250228080746.2658174-1-ribalda@chromium.org>
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

Found matching upstream commit: d9fecd096f67a4469536e040a8a10bbfb665918b

Status in newer kernel trees:
6.13.y | Present (different SHA1: e515ccef73e2)
6.12.y | Present (different SHA1: 34fb9eb31d66)
6.6.y | Present (different SHA1: 08384382e1db)
6.1.y | Present (different SHA1: 050053a7c0ad)

Note: The patch differs from the upstream commit:
---
1:  d9fecd096f67a ! 1:  44f5b59535218 media: uvcvideo: Only save async fh if success
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
| stable/linux-5.4.y        |  Success    |  Success   |

