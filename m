Return-Path: <stable+bounces-38372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 828D58A0E41
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28C01C21899
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ED1145FE0;
	Thu, 11 Apr 2024 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y+REiUB5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762CD1F5FA;
	Thu, 11 Apr 2024 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830371; cv=none; b=BREpdX3fqUfGnjlyw1yQ9KWr9IkxJ2825Tun2suY2geba0u4r0YkDep6dvXWKwLjSmRoIWYaCnk519/0XkZzECEGK2xO/4H15ayN+yEbpZ5AWt7I1bTR424kxPVit8ldEV0fvwc7uGsbV6jhjNtoHmKNquQW+7TzgtGjvEqmEJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830371; c=relaxed/simple;
	bh=KUB4DUgHt8Z0ykVA4ONwdlTus7jcqQA4wvsxeS//zh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmKVTjV+lzkcmD2vd6RnYrsBlhtTllZ7xk8XsaLYjTpWzZq2iehTdGYTFPqIz6V67SorUYiJSS0AJ2GIYIOKWP00JaIQ3KYrM/h8ORoV+NkSsjFjuiClj2RyQtcPCzO797thKU4IHJ2SYbzQHlfqHAZBKkihf2PQ6saG4s8uPuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y+REiUB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE66AC433C7;
	Thu, 11 Apr 2024 10:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712830371;
	bh=KUB4DUgHt8Z0ykVA4ONwdlTus7jcqQA4wvsxeS//zh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y+REiUB5oyCty3CwlDrl7TO1LnkKeMU7XA5HOkdOpTRGgERRApNtY+6j3qOVGJUlE
	 zY6FxdLWjFdNarrufP2ExPz2anh+Us/aMGDuND9TsGIQ7xq0anfKJuBFaJL2SkRWAM
	 +udHY36rkYHNyyFnT7UEEttsiX3so7hzNaE/vWZs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Roman Smirnov <r.smirnov@omp.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 096/143] block: prevent division by zero in blk_rq_stat_sum()
Date: Thu, 11 Apr 2024 11:56:04 +0200
Message-ID: <20240411095423.798610098@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095420.903937140@linuxfoundation.org>
References: <20240411095420.903937140@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Smirnov <r.smirnov@omp.ru>

[ Upstream commit 93f52fbeaf4b676b21acfe42a5152620e6770d02 ]

The expression dst->nr_samples + src->nr_samples may
have zero value on overflow. It is necessary to add
a check to avoid division by zero.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/20240305134509.23108-1-r.smirnov@omp.ru
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-stat.c b/block/blk-stat.c
index 7ff76ae6c76a9..e42c263e53fb9 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -27,7 +27,7 @@ void blk_rq_stat_init(struct blk_rq_stat *stat)
 /* src is a per-cpu stat, mean isn't initialized */
 void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 {
-	if (!src->nr_samples)
+	if (dst->nr_samples + src->nr_samples <= dst->nr_samples)
 		return;
 
 	dst->min = min(dst->min, src->min);
-- 
2.43.0




