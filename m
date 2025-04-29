Return-Path: <stable+bounces-137899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1400DAA158C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4EB1BC3C30
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A49A2B2DA;
	Tue, 29 Apr 2025 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bYF2uQOX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB84221ABDB;
	Tue, 29 Apr 2025 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947471; cv=none; b=TQtut0y9NX8299m2QSz8MdOjztVb4h4yHaz4oWZKGRnOqOMsmSvqBQGmhksLGIQI2hlblamhb0pBhjDqEsI/KVo5sCi/UcGEuAuA3VP2Z5ybRsgy/c6X5YPcxZNdnW2D7yrXTSqkBlrsVtzy/GDQXWZm3ko6fIhurLQ/RmUN9WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947471; c=relaxed/simple;
	bh=qoNMDEqMhTDa+9tdgaOdCKzWoMvyP6KIZWNfGsWWMTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+R1dm4N3ovmrlqGW1O3F6+0osKBVz5qv57k2yjWdtSM/78xNXOmHpKpI4+zEexRMGK0yVGNt6wf+uiQHLO/gR6qW76K5d7HvUlKyby0HNIIQGC2CbyDQudOauqqZLX1TfeatLpFLzh5p5x4sKuE0gQvZSlwuG+eN/lRupMXYOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bYF2uQOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FF7C4CEE3;
	Tue, 29 Apr 2025 17:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947471;
	bh=qoNMDEqMhTDa+9tdgaOdCKzWoMvyP6KIZWNfGsWWMTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bYF2uQOX1MV4vFV67OcCFPSFgxuo9sO1IhEb+O9/HklBCIBfjgEVLDRQLug1YNLoX
	 j9uwLuqz9LzC7EHP+h89pZwOEytnF3oBSpyGDg0kZbokN2qTIIIiA6eVQ+lP3/Ho42
	 sNiWFKljIgkiK48ASn+z0o0Kx1EZ0wrP7zVV9/gQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiaogang Chen <Xiaogang.Chen@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 265/286] udmabuf: fix a buf size overflow issue during udmabuf creation
Date: Tue, 29 Apr 2025 18:42:49 +0200
Message-ID: <20250429161118.818692731@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiaogang Chen <xiaogang.chen@amd.com>

[ Upstream commit 021ba7f1babd029e714d13a6bf2571b08af96d0f ]

by casting size_limit_mb to u64  when calculate pglimit.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250321164126.329638-1-xiaogang.chen@amd.com
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma-buf/udmabuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 14b79458ac7f4..597a92438afc1 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -177,7 +177,7 @@ static long udmabuf_create(struct miscdevice *device,
 	if (!ubuf)
 		return -ENOMEM;
 
-	pglimit = (size_limit_mb * 1024 * 1024) >> PAGE_SHIFT;
+	pglimit = ((u64)size_limit_mb * 1024 * 1024) >> PAGE_SHIFT;
 	for (i = 0; i < head->count; i++) {
 		if (!IS_ALIGNED(list[i].offset, PAGE_SIZE))
 			goto err;
-- 
2.39.5




