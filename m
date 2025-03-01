Return-Path: <stable+bounces-119988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E8BA4A87B
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 05:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAEF43BA1DB
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 04:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC99192B82;
	Sat,  1 Mar 2025 04:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVnJZo/c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1022C9A
	for <stable@vger.kernel.org>; Sat,  1 Mar 2025 04:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740802863; cv=none; b=sdqhZnhvhkh7GtBUaaq9RQLCcqq3URPtUSAcOeOTlGWe+UR2t7JdxToke3KyJrD22c2chQUEqKCsl1UU3aoZGldeZ6JaM2ov8KBuApJXcmoa9rG0jelyqTpHH/zZYUbD5NL+9sL45r/6YUG0OeimAVw7LdGWs1sCDM2/AHbh7aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740802863; c=relaxed/simple;
	bh=uIeoJDctfKnbnURKPG//L+KCcKIo7kjSHfeziYNFQwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IapnDOYzocdCbBs/w7doFa8WXoO0y/rmBUl/mBH8uVCGhMHJHP4OtAKOXCG88uhOv9MpeX7Ru8cxePJyFPLljY0vm5gLpu5XKFfH3HG6FD/JNFzyikO9egITudiZLCot35ucyIiCQPgfGwbPMQlAsdofDi2ffvE6d5Lf/9ykHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVnJZo/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFCBC4CEF3;
	Sat,  1 Mar 2025 04:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740802863;
	bh=uIeoJDctfKnbnURKPG//L+KCcKIo7kjSHfeziYNFQwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rVnJZo/cUoBSjmYw64aMvv77WloSnf4xuc3r96vN6K5Fek8PFcS0Yfw8iqgjYUgu+
	 iAq2u5JCUFCWhIasATZnk7dBdYRCo7mZM2u/DDXCzLY+LSyCAF/hFMiXp+/FI9ektY
	 KlRKM6iEJn/Zz7WpCIw1aRmGZRpSII9yAOIvMzKBmWN+iGYbyiLyziL/zjyRNmM7uw
	 aYTE6Ens4NVZXxYWkPVAd6RJRU8To+Zv+mH7UO4oNUagMg5B+CJB5If0vJb5hB7xSa
	 dgyI6H7d9BhdYtAT5MnOohUozzNwFSSALatR1yZ9XGVhvd/WwX7PRxiWUsqVTS1IcN
	 YWngTfOHsRaEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ribalda@chromium.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] media: uvcvideo: Remove dangling pointers
Date: Fri, 28 Feb 2025 23:20:40 -0500
Message-Id: <20250228173400-7a1e9333cd4df318@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250228084424.2738674-1-ribalda@chromium.org>
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
ℹ️ Patch is missing in 6.13.y (ignore if backport was sent)
⚠️ Commit missing in all newer stable branches

Found matching upstream commit: 221cd51efe4565501a3dbf04cc011b537dcce7fb

Status in newer kernel trees:
6.13.y | Present (different SHA1: 9edc7d25f7e4)
6.12.y | Present (different SHA1: 438bda062b2c)
6.6.y | Present (different SHA1: 4dbaa738c583)
6.1.y | Present (different SHA1: ccc601afaf47)
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-5.15.y. Reject:

diff a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c	(rejected hunks)
@@ -1696,7 +1731,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
 		if (!rollback && handle &&
 		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-			ctrl->handle = handle;
+			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
 	return 0;

