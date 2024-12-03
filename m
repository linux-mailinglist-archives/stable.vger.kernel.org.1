Return-Path: <stable+bounces-96772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B109E2993
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A57DABA17D1
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F08A1F75AE;
	Tue,  3 Dec 2024 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G15k2Utj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE081F4709;
	Tue,  3 Dec 2024 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238548; cv=none; b=a8Zgh66ARmy4MZXjguCQfkrDiUpcZepGyzjH2KGRvsxHiSd38PU6yuiW/6m8/tQQdruuC1cGkdBIEmX+JGLgpdBquJERDdfc8Fqtdx6UnUFbktKAYvMKA3oqzA9XVLZl9XE8s8KjUAFCznO3RNcdzYM9cj1l5Q1tcmRkzaaMYxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238548; c=relaxed/simple;
	bh=+9AJIQi1cW03YDZbrFKHhtm4rYXHnn89PezIjIeIGbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEIRXWtmcygTqgCZqjwQtp4UF3urt3WdHXILmBm2KPoID6zlLgy/2b46j3UknWFUQ5tY2Pz+Uyy8xEvFkEkLQA4Bx4qAdc4N+mHU+WB52lMtXQu6jcgY8OkAIJnlMBbJGI+lH/ACVW3aUSV4xOanx5w/WN8pwPC4hQhQWg+GBIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G15k2Utj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A58C4CECF;
	Tue,  3 Dec 2024 15:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238548;
	bh=+9AJIQi1cW03YDZbrFKHhtm4rYXHnn89PezIjIeIGbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G15k2Utj5U/Q9mpTjlgmKR8U84j+kuiBotsMGzbtKF2B7tW5Yx7XJFG/KHCCWdQcf
	 UFHZhDSI4irsadW572DgLOwKHhiJCOeymvTfLmLAa3leUa/p3ZhvKWn0AlaoXTcYJS
	 QjyJ23aKfUCNOk8vtJOy1hsK+GkwuDsPXss9fJr0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan Gray <jsg@jsg.id.au>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 316/817] drm: use ATOMIC64_INIT() for atomic64_t
Date: Tue,  3 Dec 2024 15:38:08 +0100
Message-ID: <20241203144008.153148401@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonathan Gray <jsg@jsg.id.au>

[ Upstream commit 9877bb2775d020fb7000af5ca989331d09d0e372 ]

use ATOMIC64_INIT() not ATOMIC_INIT() for atomic64_t

Fixes: 3f09a0cd4ea3 ("drm: Add common fdinfo helper")
Signed-off-by: Jonathan Gray <jsg@jsg.id.au>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240111023045.50013-1-jsg@jsg.id.au
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index f917b259b3342..26fc813d37edf 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -138,7 +138,7 @@ bool drm_dev_needs_global_mutex(struct drm_device *dev)
  */
 struct drm_file *drm_file_alloc(struct drm_minor *minor)
 {
-	static atomic64_t ident = ATOMIC_INIT(0);
+	static atomic64_t ident = ATOMIC64_INIT(0);
 	struct drm_device *dev = minor->dev;
 	struct drm_file *file;
 	int ret;
-- 
2.43.0




