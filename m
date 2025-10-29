Return-Path: <stable+bounces-191678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9651FC1D95D
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 23:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DD4C4E1C7D
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 22:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7CE2E9EAE;
	Wed, 29 Oct 2025 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=waldn.net header.i=@waldn.net header.b="I3ILZLMW"
X-Original-To: stable@vger.kernel.org
Received: from mail.waldn.net (mail.waldn.net [216.66.77.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D3A37A3C6
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.66.77.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776798; cv=none; b=ad2wLkjnU6m7YQxIaI5Sxuxt2hDa/hphOWg+NoYLr5X+aSrp5W+WN6/GDUDNHRRiuKUQcuPOnY+8M9MfjbaWJIB9o41EonsYDN/gf6/g/5b0SJhmP0/O9Lh4Mc4K1pJ5BaZ1ihU6t2OscTuuGUDXdTv9Ii84G+SppvGriQlja7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776798; c=relaxed/simple;
	bh=CPkO3HsUaeQJnRwySAKNvGylXQrJOTw/AyCdqzXumgo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JCwo+mfXZyuRNcUfF6YOjIUMW44U1HnFJwkmlDYo1e+p7dGWhxB6oOQiTWS1DhZoo4rORDvwpL1JU9YWDub+dPqHsmYHXa2VnwUuPuMvUkFxuJL8O52+xhexBvHTFVybRCYvf9KY1bITxPRrd/RV8b9ydwaU8cQPZHBdt62sA2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=waldn.net; spf=pass smtp.mailfrom=waldn.net; dkim=pass (1024-bit key) header.d=waldn.net header.i=@waldn.net header.b=I3ILZLMW; arc=none smtp.client-ip=216.66.77.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=waldn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldn.net
Message-ID: <2fea6323-c3c9-4229-a139-39ab15e365ae@waldn.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waldn.net; s=mail;
	t=1761776796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CPkO3HsUaeQJnRwySAKNvGylXQrJOTw/AyCdqzXumgo=;
	b=I3ILZLMW1f47lPIur+tjljR0sANRdcWqOJSANOLp4fSd9uu0KlXQdc/5h+N5LNQtHJZ6II
	upbGFLGY7LkH8sl6M1sfqKk7+JIZEKn/31wCp/HaXA/DEInrpSeSS81D3Cv3qa0NgNgEej
	zVgQ2vQADm6TNypdjVmWuezbpGy2wco=
Date: Wed, 29 Oct 2025 17:26:35 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH 2/4] udmabuf: fix a buf size overflow issue during udmabuf
 creation
From: Amelia Crate <acrate@waldn.net>
To: stable@vger.kernel.org
Cc: dimitri.ledkov@surgut.co.uk
References: <79b19099-3791-4690-8729-de15128d79b7@waldn.net>
 <645ca90a-0f5d-44a0-985e-aa84a18c2fd1@waldn.net>
Content-Language: en-US
In-Reply-To: <645ca90a-0f5d-44a0-985e-aa84a18c2fd1@waldn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From 2975117abd1c11f5867b0960a8e467c8f5d394ad Mon Sep 17 00:00:00 2001
From: Xiaogang Chen <xiaogang.chen@amd.com>
Date: Fri, 21 Mar 2025 11:41:26 -0500
Subject: [PATCH 2/4] udmabuf: fix a buf size overflow issue during udmabuf
 creation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Upstream commit 021ba7f1babd029e714d13a6bf2571b08af96d0f ]

by casting size_limit_mb to u64  when calculate pglimit.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250321164126.329638-1-xiaogang.chen@amd.com
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Amelia Crate <acrate@waldn.net>
---
 drivers/dma-buf/udmabuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 0e127a9109e7..2e5c30f7ba0f 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -350,7 +350,7 @@ static long udmabuf_create(struct miscdevice *device,
         return -ENOMEM;

     INIT_LIST_HEAD(&ubuf->unpin_list);
-    pglimit = (size_limit_mb * 1024 * 1024) >> PAGE_SHIFT;
+    pglimit = ((u64)size_limit_mb * 1024 * 1024) >> PAGE_SHIFT;
     for (i = 0; i < head->count; i++) {
         if (!PAGE_ALIGNED(list[i].offset))
             goto err;
--
2.50.1

