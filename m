Return-Path: <stable+bounces-120000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DB2A4A887
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 05:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397AA175B63
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 04:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACBA192B82;
	Sat,  1 Mar 2025 04:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcWJIxBI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD8C2C9A
	for <stable@vger.kernel.org>; Sat,  1 Mar 2025 04:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740802882; cv=none; b=D55T2LIWGPrOB4J+0xU2j8/ibloS4hjfYhxhvttZqeTtDK6Rce31SA7NoiuzViSq+FLmTgzJrUdTgsclR5qHzMRyJARcjbuZVcSYIM4cyp1F75Iq5kj+g97FwDCE9A1SYV08L6kCq6AsXQ8gT1TLnP9ee6Xp5D7lInm1jhXXMUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740802882; c=relaxed/simple;
	bh=hAVkB2XxOtMkvJJ0rceDvWZF9q3wo8uvYlZoENILGRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0WTjGIKoX0BSNg3GoErrER6hPm5vPD3Cka0jAA+jRUYPCRV2qlpdEWp76cDYAWimxiEVcKWfR5djFnAvLz4lsV1+H1bf1inFW4oMr+3c+FTj3XCsCPdKv3annr0UPKovulBE3ZEojhCyzO15o8FuMnxR7nzDbrySHlmgWIEwvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcWJIxBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B03C4CEF3;
	Sat,  1 Mar 2025 04:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740802882;
	bh=hAVkB2XxOtMkvJJ0rceDvWZF9q3wo8uvYlZoENILGRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EcWJIxBI5UBd6mi3bSNZaFQguyvU/WXj/K//v4VmLd919gfCewV5B0iH1SPwzONiy
	 awEjLjs1N77u+1LPaEoPhPZSc43pfJSml55eRp0iJakhiWrrRRd4dhZ4VssKW51mRi
	 sleHhBitKOtbrHpoEDU5dSgP4OQHgk4foh3DW5YkXul71GCogv0UIS0ZkSfXRWLYIm
	 e/rhDdTaZVWzkJdS/QqdFk3d94hlJoHg+LPJvvKlaGQNiXKjwH/rJI7psy5k15+q99
	 wlGF/gyq9BbYPcNBzZEQnuGQnCEKIjtgxNlcaow5RgHCIgWjbxNO+sVehdZqT6hlCE
	 l9GN6tjCcqYaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ribalda@chromium.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] media: uvcvideo: Only save async fh if success
Date: Fri, 28 Feb 2025 23:20:58 -0500
Message-Id: <20250228173041-c4ef90437fbc1734@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250228082004.2691008-1-ribalda@chromium.org>
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

Note: The patch differs from the upstream commit:
---
1:  d9fecd096f67a ! 1:  03aa93bc2a478 media: uvcvideo: Only save async fh if success
    @@ Commit message
         Link: https://lore.kernel.org/r/20241203-uvc-fix-async-v6-1-26c867231118@chromium.org
         Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
         Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
    +    (cherry picked from commit d9fecd096f67a4469536e040a8a10bbfb665918b)
     
      ## drivers/media/usb/uvc/uvc_ctrl.c ##
     @@ drivers/media/usb/uvc/uvc_ctrl.c: int uvc_ctrl_begin(struct uvc_video_chain *chain)
    @@ drivers/media/usb/uvc/uvc_ctrl.c: int __uvc_ctrl_commit(struct uvc_fh *handle, i
     -					     &err_ctrl);
     +		ret = uvc_ctrl_commit_entity(chain->dev, handle, entity,
     +					     rollback, &err_ctrl);
    - 		if (ret < 0) {
    - 			if (ctrls)
    - 				ctrls->error_idx =
    + 		if (ret < 0)
    + 			goto done;
    + 	}
     @@ drivers/media/usb/uvc/uvc_ctrl.c: int uvc_ctrl_set(struct uvc_fh *handle,
      	mapping->set(mapping, value,
      		uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

