Return-Path: <stable+bounces-103422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 065999EF7A1
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DA4189DF37
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DA9222D4C;
	Thu, 12 Dec 2024 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R+ev+j4A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D7E222D46;
	Thu, 12 Dec 2024 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024520; cv=none; b=HyPfWp7n0Y84GKptCiocg8ik9rAn2eVuZ4Tsi2Cfn9GrG6Lb+AAdQ0WXoGOjvk3iUDHadUHGpfYMVFYIQ5rE/T/csBMsFkCVAXp7FAOyQR63lYcl37S3n/gJZm3q5TNbBe0wqpVKHYLhobtukHMDHkthtCm8f50FpQTKIoSfsMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024520; c=relaxed/simple;
	bh=PweHcaavH/1AoaRWq5d/cDMu/WOFI3AhYjCJJe9qx0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfRxrrgDHDd5aRq/4Sr0VLdLPEw48uhKKugaTlFEgXZTAPb38Rcx91Eu6nR31MFgUD7gmu+TEtNk1M3xk242gaJABs692wd/qR7eOnFiCKFcShcnpuFdBd4tmMpSdkf1qp/1dO+aWYgW81zZRkWWk0FwfiBBv6BdorxGgiaOsG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R+ev+j4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD2BC4CED0;
	Thu, 12 Dec 2024 17:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024520;
	bh=PweHcaavH/1AoaRWq5d/cDMu/WOFI3AhYjCJJe9qx0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+ev+j4A8MzQpPnhbuZFG7p0bQhoNPtG6z6ni4IVxRIC78Qqufi1B//h1/8uEb4BJ
	 vqrABIqzCFQFzN9NH+1d6+9Nf2GEyL5U5MdrDbWaByFK5ob99yW3phQ0GcTJk7db5l
	 gtJ+gpZjh4cl7dddbV23q3I1wgjCmGXyz9trYcNc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Gmeiner <cgmeiner@igalia.com>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 5.10 324/459] drm/etnaviv: flush shader L1 cache after user commandstream
Date: Thu, 12 Dec 2024 16:01:02 +0100
Message-ID: <20241212144306.460291486@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lucas Stach <l.stach@pengutronix.de>

commit 4f8dbadef085ab447a01a8d4806a3f629fea05ed upstream.

The shader L1 cache is a writeback cache for shader loads/stores
and thus must be flushed before any BOs backing the shader buffers
are potentially freed.

Cc: stable@vger.kernel.org
Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/etnaviv/etnaviv_buffer.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_buffer.c
@@ -481,7 +481,8 @@ void etnaviv_buffer_queue(struct etnaviv
 	} else {
 		CMD_LOAD_STATE(buffer, VIVS_GL_FLUSH_CACHE,
 				       VIVS_GL_FLUSH_CACHE_DEPTH |
-				       VIVS_GL_FLUSH_CACHE_COLOR);
+				       VIVS_GL_FLUSH_CACHE_COLOR |
+				       VIVS_GL_FLUSH_CACHE_SHADER_L1);
 		if (has_blt) {
 			CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x1);
 			CMD_LOAD_STATE(buffer, VIVS_BLT_SET_COMMAND, 0x1);



