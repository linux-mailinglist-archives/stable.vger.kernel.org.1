Return-Path: <stable+bounces-62170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF3B93E673
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054FD1F219C6
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CA9126F2A;
	Sun, 28 Jul 2024 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQfCyTn/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B3886AE9;
	Sun, 28 Jul 2024 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181487; cv=none; b=d5zMqiQAyknRjcQkae8Hp1MFo+hTWq8ChxsoaOUtr5dC4N3k6Dnqhtl9JzzQNjC9aDpT81uj7J85GS1YnJYYvVjwwuTah1imoFJWSMNdtyGDQ5FPnxhJUhvDflnEKV0vwKXMGDbWn1lDbdiqT5nHl2w4igchFxjn+fZBzeNngQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181487; c=relaxed/simple;
	bh=FegstC6WxaJe/XJd+Gbxu8m87ingQNoL4dEP0GMn3Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTSnEAHQ8wW0kpSHNpZaEibCnM5U9n3hNUWwd+CO9f1Ch/A8t1dBM8WRD88Wx/ez7jOunvkK1KXSsjv+l9WlU7J9P8fngALnm7uoOWBXWXUVZo7D0kYLZBcXUFwYTE/oc0NkFmyDy8Kwt/7jGsI3JFAfZIz9VOhw3F77QIANE4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQfCyTn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30249C4AF0B;
	Sun, 28 Jul 2024 15:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181486;
	bh=FegstC6WxaJe/XJd+Gbxu8m87ingQNoL4dEP0GMn3Qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQfCyTn/542vBHiAu5JOYiygNmQurPsy/MKxUoi/fEEZzOA1ZKZctoTeLcSR6fdqj
	 XHxrjPBM29KoY45aU6s/unGWJVLRS2PFho/VvgyQe2u0BxRW4j5ExIcVogvsAn1KO7
	 jywTQfPPGkjfySqeoyfAgHWRkQnPCSEQdnn+rl5i9PYoeDsZ5Mkgkye9Y7ajOO4wBg
	 BlPIu+ykZzy1M60I/KDW6a9zavCkmU1xs+l7ZhRLPWMMaDRgzu5v333MCJ3+gg9FkF
	 iAqRH/hvIL0rYWaPthYsb6PBT7FbsfLHV7hlxadI+NHVDBrXG0ARDGkOQdLLCdCKKY
	 w18ypnmmyGbMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 26/34] drm/panic: depends on !VT_CONSOLE
Date: Sun, 28 Jul 2024 11:40:50 -0400
Message-ID: <20240728154230.2046786-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154230.2046786-1-sashal@kernel.org>
References: <20240728154230.2046786-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Jocelyn Falempe <jfalempe@redhat.com>

[ Upstream commit 1ac6ac9ec069ed0cfdb1c207ae23f6c40ac57437 ]

The race condition between fbcon and drm_panic can only occurs if
VT_CONSOLE is set. So update drm_panic dependency accordingly.
This will make it easier for Linux distributions to enable drm_panic
by disabling VT_CONSOLE, and keeping fbcon terminal.
The only drawback is that fbcon won't display the boot kmsg, so it
should rely on userspace to do that.
At least plymouth already handle this case with
https://gitlab.freedesktop.org/plymouth/plymouth/-/merge_requests/224

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240613154041.325964-1-jfalempe@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index d0aa277fc3bff..3e286236aa430 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -106,7 +106,7 @@ config DRM_KMS_HELPER
 
 config DRM_PANIC
 	bool "Display a user-friendly message when a kernel panic occurs"
-	depends on DRM && !FRAMEBUFFER_CONSOLE
+	depends on DRM && !(FRAMEBUFFER_CONSOLE && VT_CONSOLE)
 	select DRM_KMS_HELPER
 	select FONT_SUPPORT
 	help
-- 
2.43.0


