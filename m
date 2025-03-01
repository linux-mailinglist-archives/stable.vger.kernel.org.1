Return-Path: <stable+bounces-119986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1BAA4A879
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 05:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E83189AA23
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 04:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630161AF0D7;
	Sat,  1 Mar 2025 04:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEl5Du9N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2454A2C9A
	for <stable@vger.kernel.org>; Sat,  1 Mar 2025 04:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740802860; cv=none; b=lV8gY56vgUY7UwAvpQCZjDMTPtAyEs90ALDdgFnV9TjEKJ5fGrJ4vu8/D0R/NIp+kMNdTKuxs4nDpgRsAS1i84y8YVVZOis2FziLEhtLMN/kueX9cdMoyJOPVlzDKWC6ArQ+UBP/ipgetToAuQi8hfLg6tt+Q/ypzQGjuxPI+/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740802860; c=relaxed/simple;
	bh=fX1+EvXvnqGLFsga3vRdEGnCoMkWe66nTfCuLDMM53s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bWV8LzXppW5V957Y0kdm6aDOhTgANg9+zvyZAWfP1DsWi87j/xfXBhFcRg4PPj0iJnaAtrVFtRd5Dp0J5i8HJ+0cmhfYXxJJKCE3xa+vQA5hw7g+BjUIzE1Q+uiRflhICkMC1/rfO5Al9Qo9ULMtZ6VWT5JUGTUg0I+63i5FSSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEl5Du9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB14C4CEF3;
	Sat,  1 Mar 2025 04:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740802859;
	bh=fX1+EvXvnqGLFsga3vRdEGnCoMkWe66nTfCuLDMM53s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vEl5Du9Nvx7ixITr9HinqxK8Jy3+8LldDdsFJS0+RXklnIrnnz0/sKrcB5cF+098/
	 kS7C7PZnE2Ei66ZdzIiRNHbexYDRWDwTt1oVIMhEy/bJeNhCx+LIXkEa0Y4OsXGY39
	 hYOzJQHMwSGIEXLISbDYCCjEIiC8yQ+yqZVXVxzNDI3IPVTW7pzpjdoY0eKj5Zaf3R
	 SUE/dU3vJZ0HsUB561RtB9Dn0I3Ijue703kkB9mEkUuVaY9ifzRyOCp9D8hiZRnLfa
	 L6ZTdmfm2NEHtwKDPTTu7qpllTBRrXhAYW3imCHCgeOYF54I+fcfOKZjHk7hvn5+1j
	 cJ+eCKMSGXzBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ribalda@chromium.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] media: uvcvideo: Remove dangling pointers
Date: Fri, 28 Feb 2025 23:20:36 -0500
Message-Id: <20250228193340-6016db82aed38507@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250228084659.2752002-1-ribalda@chromium.org>
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
❌ Build failures detected
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 221cd51efe4565501a3dbf04cc011b537dcce7fb

Status in newer kernel trees:
6.13.y | Present (different SHA1: 9edc7d25f7e4)
6.12.y | Present (different SHA1: 438bda062b2c)
6.6.y | Present (different SHA1: 4dbaa738c583)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-6.1.y. Reject:

diff a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c	(rejected hunks)
@@ -1754,7 +1789,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
 		if (!rollback && handle &&
 		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-			ctrl->handle = handle;
+			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
 	return 0;

