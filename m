Return-Path: <stable+bounces-126116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 289DAA6FFEF
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E52188DF57
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0A6298CCD;
	Tue, 25 Mar 2025 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XYpGvK4J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66C226657E;
	Tue, 25 Mar 2025 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905630; cv=none; b=d8MbF5ZxBeatrLCd31Z9u91sxIu6+jb6AFdwVhyxTRlIjUsFn4R120Pkp5FLuRGerjcMrP06Iviem7h9TGEv2v7E/BVtUbSZMd64P9roSPtkpDvaaGHbDFE+y33RLVo0SElCUck/uWMoedmudalZJb6AXyn88EkpM18gWuqyx6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905630; c=relaxed/simple;
	bh=D8qHWF1NEfPogxHshQTpjnt72mVWJv+FuXtOKjiI0Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ukixp4sszM1ibPPW3n9sKesNyh2pPQ4Xj/Y/YlNnMJt/vY9QYPPYsE2e5vLzdpsSseXx0GiN17E1W8eNF9qOUccPoG+XSR/id4hKxrRtxx+NMgsxLkYRlSPqj4DRilM/lINQCYZrloG58vzJNMrD64SMQMVELOH0lxLbGarbTdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XYpGvK4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655EEC4CEE9;
	Tue, 25 Mar 2025 12:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742905630;
	bh=D8qHWF1NEfPogxHshQTpjnt72mVWJv+FuXtOKjiI0Hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XYpGvK4JWmHTd4i+dKvonELdf5C6mukN+MPicIPEHQxHUwOry4SYALrZwyY43x54e
	 GRa0N1qfDmLSjZCtFrKprywk2EkErrvpLoqUoVSh5W2/9eyu9P9jYisfL+kkyAYcPT
	 p5J0/PamBavlazKIFoTE7Ep98SfWPKg4eTUQ67cc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guangwu Zhang <guazhang@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 071/198] block: fix kmem_cache of name bio-108 already exists
Date: Tue, 25 Mar 2025 08:20:33 -0400
Message-ID: <20250325122158.504477076@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122156.633329074@linuxfoundation.org>
References: <20250325122156.633329074@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit b654f7a51ffb386131de42aa98ed831f8c126546 ]

Device mapper bioset often has big bio_slab size, which can be more than
1000, then 8byte can't hold the slab name any more, cause the kmem_cache
allocation warning of 'kmem_cache of name 'bio-108' already exists'.

Fix the warning by extending bio_slab->name to 12 bytes, but fix output
of /proc/slabinfo

Reported-by: Guangwu Zhang <guazhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250228132656.2838008-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 3318e0022fdfd..a7323d567c798 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -73,7 +73,7 @@ struct bio_slab {
 	struct kmem_cache *slab;
 	unsigned int slab_ref;
 	unsigned int slab_size;
-	char name[8];
+	char name[12];
 };
 static DEFINE_MUTEX(bio_slab_lock);
 static DEFINE_XARRAY(bio_slabs);
-- 
2.39.5




