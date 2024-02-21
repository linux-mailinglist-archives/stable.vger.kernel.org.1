Return-Path: <stable+bounces-21921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE14885D927
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9413F1F23E8D
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1230169DF2;
	Wed, 21 Feb 2024 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u90ze7pG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A7169DF6;
	Wed, 21 Feb 2024 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521318; cv=none; b=Ryo7ed12hvnPWuNTkcR6qDToQU+9AOSs2Pom0qW+NKDYEefJsJgCCHKPQybQsWjKARtPijeTdNs1i58NoazsqnLDgSXOQaNRX218euih3FaWBii1rtfix3Mr0X6UKsjLow/n8eZgnzuOu1PNS6VowtS42sFQKjT7rhNV/ioPLKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521318; c=relaxed/simple;
	bh=x0GmVb018WY1+mkDw7d3wOPH0kIgb/EHFBd1yTONMi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZ95nyl+8Cn0j6OWiu1uxYq28ao8zHDF1BsmVuwLzL39Sl/hTPEC5kRbFrtQmSeALh65M0p3TMccTgridz7CbxouDR8Pg6JgLuc2R6jb9CyxAQ5oZOKVZ3SIbxshr1uF7FODgcwGv7q8UuPZthq8jPM6uPEuzl2RXptdyHO8BIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u90ze7pG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCC1C43390;
	Wed, 21 Feb 2024 13:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708521318;
	bh=x0GmVb018WY1+mkDw7d3wOPH0kIgb/EHFBd1yTONMi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u90ze7pGUTyVnIaGFxQ6KhKjIvO9NfOJslMLeR4MJPklJK+XMqNP9qWALCAC5mJPQ
	 e32JX00fEn7+LLvjbriLEBCpgmaQXtNf9VWLVHUwwun7zfe8vaBArRPuAwTAvKQ9S6
	 pJNrc2+pp3Eo6DhKcg+oJehnhfDyi3ct3+btLf6U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Inki Dae <inki.dae@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 044/202] drm/exynos: gsc: minor fix for loop iteration in gsc_runtime_resume
Date: Wed, 21 Feb 2024 14:05:45 +0100
Message-ID: <20240221125933.228263358@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125931.742034354@linuxfoundation.org>
References: <20240221125931.742034354@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit 4050957c7c2c14aa795dbf423b4180d5ac04e113 ]

Do not forget to call clk_disable_unprepare() on the first element of
ctx->clocks array.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 8b7d3ec83aba ("drm/exynos: gsc: Convert driver to IPP v2 core API")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_drm_gsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index d71188b982cb..4a93d87c2096 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -1322,7 +1322,7 @@ static int __maybe_unused gsc_runtime_resume(struct device *dev)
 	for (i = 0; i < ctx->num_clocks; i++) {
 		ret = clk_prepare_enable(ctx->clocks[i]);
 		if (ret) {
-			while (--i > 0)
+			while (--i >= 0)
 				clk_disable_unprepare(ctx->clocks[i]);
 			return ret;
 		}
-- 
2.43.0




