Return-Path: <stable+bounces-145018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB09DABD0EE
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 09:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3315E3B7431
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 07:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBD725B1C5;
	Tue, 20 May 2025 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/YlApSs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E264F1DF75A
	for <stable@vger.kernel.org>; Tue, 20 May 2025 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747727541; cv=none; b=CXgDqNO0CCAUXFWfEOcC+CDhLXIaSQqEz0rJyn7m+tML6NhuEriRJXFP6sgLxvhdau1A2/FmIJY4SOx/sbhUiXmV1tdHhuD+Kfby5Gs+kCBGSYb2esR5tme3YGCP+/uCM0x4VMn7GNdmWzLGnU/nk9nF1mLliPaYsxycuVEaEKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747727541; c=relaxed/simple;
	bh=+qMyNAMw8rxWUGv67Ve7q4QM3Mcjgl+MJ9HTUQDczg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ohb49AEmyka/e3EvwSYf5xI6wy/3cIrc/zVHy7azZKMe3b7nFyAXrOhM6dhjtlcUAa3QfRRVQy9t2JHigC/UFydzYAr0d/MspUVOnHmzvfp9SVEbkBXkO+qkkh6ORMFwG3w/wt5HGJ4TV2hyL6UUFbOHk6eTaN2GXe79zOv8iT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/YlApSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC877C4CEEB;
	Tue, 20 May 2025 07:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747727540;
	bh=+qMyNAMw8rxWUGv67Ve7q4QM3Mcjgl+MJ9HTUQDczg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/YlApSsXZh/wTYZsZDkWoLC46ujJe0psmCfQFmxnynjzcaIdLixKtqakDqSsvM8X
	 hYxe+wn3TGZIEVYGr6Lu5X25B4qoSBk78W+WI0xS4ecalqNQwIkCkbqVb3O3Regvg+
	 mndR4k8+TmooIrrNPQXBCuQhpauoTMox4qbHEYGCyJp9RowqAogsSleONJYHqlNXDa
	 aSRwDiEIl+iZcuiM+ldXGSfQ6Iup9MUbPlHKoaNzTHcK7l3TfsVNypd74rV4bdp6zP
	 K1G9sJ1svHPrl+nCYHJ59MuYDp/VQp6wb5HiYwhIvmTjFyxaUCKkBnkNx0dsQhBXpa
	 5eM/sr5/niN/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Estevam <festevam@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 1/3] drm/fbdev-dma: Support struct drm_driver.fbdev_probe
Date: Tue, 20 May 2025 03:52:18 -0400
Message-Id: <20250519185335-41c114afcc080d60@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250519163230.1303438-1-festevam@gmail.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 8998eedda2539d2528cfebdc7c17eed0ad35b714

WARNING: Author mismatch between patch and upstream commit:
Backport author: Fabio Estevam<festevam@gmail.com>
Commit author: Thomas Zimmermann<tzimmermann@suse.de>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  8998eedda2539 ! 1:  97d835de614c2 drm/fbdev-dma: Support struct drm_driver.fbdev_probe
    @@ Metadata
      ## Commit message ##
         drm/fbdev-dma: Support struct drm_driver.fbdev_probe
     
    +    commit 8998eedda2539d2528cfebdc7c17eed0ad35b714 upstream.
    +
         Rework fbdev probing to support fbdev_probe in struct drm_driver
         and reimplement the old fb_probe callback on top of it. Provide an
         initializer macro for struct drm_driver that sets the callback
    @@ Commit message
         Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
         Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
         Link: https://patchwork.freedesktop.org/patch/msgid/20240924071734.98201-6-tzimmermann@suse.de
    +    Signed-off-by: Fabio Estevam <festevam@denx.de>
     
      ## drivers/gpu/drm/drm_fbdev_dma.c ##
     @@ drivers/gpu/drm/drm_fbdev_dma.c: static const struct fb_ops drm_fbdev_dma_deferred_fb_ops = {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

