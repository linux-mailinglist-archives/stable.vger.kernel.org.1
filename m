Return-Path: <stable+bounces-119996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA8EA4A883
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 05:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACF1189C353
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 04:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F366D192B82;
	Sat,  1 Mar 2025 04:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWHUuqsc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09DC2C9A
	for <stable@vger.kernel.org>; Sat,  1 Mar 2025 04:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740802875; cv=none; b=KNCWoYrXThqxGlxSQN3L8MKTPK/Zo9siE/mM7W7BKK5os5rZ9hGNKYubN1x6cbxT7z1nbBsLCJSuPV1Vjij6A9maQI+IFoGJSMIRYjv69nJUuxX/CVYZ45WHmRNuegQRnhywCecVv+yMBpyorxV38SIkCbaVWGC2AuS9INKRA0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740802875; c=relaxed/simple;
	bh=2c3c8I9eLmw3/XJkDJJZ2yi6gC77AC0mrXWTvOxZfrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ct/h3+pTW3hrbVonSRGu0vLmGhh1aKYYUJJCqmBcCezQoKGAfKfasRHP7pxz7/rJ9HeeM8xnymrqkb5cqtPw0/c6IrxGJjYlkosJX2UXPmPYwMLULIhHAdTTkzuc0s933aXHjAgHszTOotLj/Y+XbHhSD3Ls2c+MkV5dG8UXISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWHUuqsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500E8C4CEF3;
	Sat,  1 Mar 2025 04:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740802875;
	bh=2c3c8I9eLmw3/XJkDJJZ2yi6gC77AC0mrXWTvOxZfrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fWHUuqscnzeLeR5LzVoTTNvNCPH8BTxkeuHX5UxG+NIc6kTvOUoya1+Z1N1y4HAuR
	 RYIP+6D13IvsENaW6K67ZNb/DNTcjKdDJyBxWdvzY7RH5PtVbGsQ97BDGL9tNcV/8p
	 AgXT9xwPp0cbZsh4q0I9xxzI0pgoeH1tLqqhGkTZdAcpYL60hx1l/kvsnYzCYhrYIe
	 OSkPCOW9ltTChAUaBiPCelUMKdVlCVKwbK25P3f9s3xFkRhnYfRkmZjelx50GmZLkU
	 0AtrvJeIlIzA5rfHqEbzJ6JRZfbii8q0zdL4PjSwKoXCN622gOe/IqxEqM1NdawH13
	 fQX/YOhiyHlbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ribalda@chromium.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] media: uvcvideo: Remove dangling pointers
Date: Fri, 28 Feb 2025 23:20:52 -0500
Message-Id: <20250228171826-c77ba78a63afe214@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250228084003.2730264-1-ribalda@chromium.org>
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
5.15.y | Not found
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-5.10.y. Reject:

diff a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c	(rejected hunks)
@@ -1577,7 +1612,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
 		if (!rollback && handle &&
 		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-			ctrl->handle = handle;
+			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
 	return 0;

