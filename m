Return-Path: <stable+bounces-191751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0976C211C8
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 17:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0B2426529
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 16:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0761365D25;
	Thu, 30 Oct 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=waldn.net header.i=@waldn.net header.b="bmraeFP3"
X-Original-To: stable@vger.kernel.org
Received: from mail.waldn.net (mail.waldn.net [216.66.77.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C3B3655C4
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.66.77.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840658; cv=none; b=V8DylWASJPDMm1TwECXPrKMdMvN2JYV4DzYPzb3UsBsVxAmMkbwoXZs+uX9oM5dAKzHgj100dvToe/lLRZihx02YiwsNBO7mcwqBgEMNn7ifvyzT2fAZx8zOkvb8OClrW317+FPrrX4d3RaS5+wcVy2QB3bwlszbzW7BeRyNMCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840658; c=relaxed/simple;
	bh=LC1x7SsbH5e8MksMseFoep9VPSHThJ0LIeRWVSAAtJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5mITr+7382hdzGn+3IIulU2k2d+QP2gAVN8+dI1ryp0eybNR2EKj8c6AkOxmBH3860GYJNtOk6GD5VYGATmJXnurrd/IbE5gW+n7e5qOcRqI31RM7aceJjgsyu4TPb7LVKVEiNaJPaQV0B4QPnq0gFuv6CwDWRSB9iGh0v6uzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=waldn.net; spf=pass smtp.mailfrom=waldn.net; dkim=pass (1024-bit key) header.d=waldn.net header.i=@waldn.net header.b=bmraeFP3; arc=none smtp.client-ip=216.66.77.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=waldn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldn.net
From: Amelia Crate <acrate@waldn.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waldn.net; s=mail;
	t=1761840655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hNJNidh3arRzCBUMSgRmi1UzAkzseh1xMRo57G8SDno=;
	b=bmraeFP3wyoSNDLQ6WKTQus/1N+DBSrD77QyZu5dv98pfIqVHrpByg2bChmGCfUuffQ21F
	QudX5WKiq9Cd7/SRduwXbuDh+igcwbA58AjSiOtBsstzdTJMiHI4Qqmkkt4WDbt3nf7hwO
	hAp20PPVcgJKEcnJrK6qs2KrQ/B3bYI=
To: gregkh@linuxfoundation.org
Cc: dimitri.ledkov@surgut.co.uk,
	stable@vger.kernel.org,
	Xiaogang Chen <xiaogang.chen@amd.com>,
	Amelia Crate <acrate@waldn.net>
Subject: [PATCH v2 2/4] udmabuf: fix a buf size overflow issue during udmabuf creation
Date: Thu, 30 Oct 2025 11:08:32 -0500
Message-ID: <20251030160942.19490-3-acrate@waldn.net>
In-Reply-To: <20251030160942.19490-1-acrate@waldn.net>
References: <2025103043-refinish-preformed-280e@gregkh>
 <20251030160942.19490-1-acrate@waldn.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Xiaogang Chen <xiaogang.chen@amd.com>

[ Upstream commit 021ba7f1babd029e714d13a6bf2571b08af96d0f ]

by casting size_limit_mb to u64  when calculate pglimit.

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
-	pglimit = (size_limit_mb * 1024 * 1024) >> PAGE_SHIFT;
+	pglimit = ((u64)size_limit_mb * 1024 * 1024) >> PAGE_SHIFT;
 	for (i = 0; i < head->count; i++) {
 		if (!PAGE_ALIGNED(list[i].offset))
 			goto err;
-- 
2.50.1


