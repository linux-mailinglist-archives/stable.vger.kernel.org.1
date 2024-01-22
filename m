Return-Path: <stable+bounces-13041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFE7837A4A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D6C1C242B8
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E2612BEBF;
	Tue, 23 Jan 2024 00:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D0xoAxfM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1379012A17F;
	Tue, 23 Jan 2024 00:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968874; cv=none; b=jQmIspqTbSqC6P9cuq4Q4fiN8ouA13BIJWBKTlaQwk5HXLgAW5Iaqf8y8paQifr0N8nlO3BuKr2nJCGUpuCB1VUkwX7ITkDL2A00dAHw54fSUvcJpYKQECzkSe8LPLFQuDvmg3oau8DSsXj/1LhYGXswpQtOqlhOxBYsBqSFhWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968874; c=relaxed/simple;
	bh=kfN7LWDKMOd2Vpcb8xoCRBwSrib7uiVQweklGawwzg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGXWtlFQb2O3PlnHBpP9K7o7gVsQdek7ybi+cVpshISiNhj28zi4olsdGPbwZ1pgqoTpJETMy/hp9UxFMXXGpI1kzm6Zii37bFDQswfTT2ioDHmBSDPW9+ntdND+SYSPNC8hfGPZpGNa1guYEbSWCpkpRLB7xYv9AF36l3O3JXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D0xoAxfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B949DC433C7;
	Tue, 23 Jan 2024 00:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968873;
	bh=kfN7LWDKMOd2Vpcb8xoCRBwSrib7uiVQweklGawwzg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D0xoAxfM+zDIHKds09729UNbhmI4MjQdkv64e8Y65/w+pnVsi8VeSx/V7pHqH3r1+
	 ifOsLgllpPG+N5j47f37xRWiIh4iZoSC18b8GW+cRs0rjiAlwI/0ru8s9xySzxfsmc
	 4hUf6VkecI217TEuCKx2I4p3dLhdwhJvAX5m5Npg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Barry Song <v-songbaohua@oppo.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 077/194] crypto: scomp - fix req->dst buffer overflow
Date: Mon, 22 Jan 2024 15:56:47 -0800
Message-ID: <20240122235722.531360549@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235719.206965081@linuxfoundation.org>
References: <20240122235719.206965081@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengming Zhou <zhouchengming@bytedance.com>

[ Upstream commit 744e1885922a9943458954cfea917b31064b4131 ]

The req->dst buffer size should be checked before copying from the
scomp_scratch->dst to avoid req->dst buffer overflow problem.

Fixes: 1ab53a77b772 ("crypto: acomp - add driver-side scomp interface")
Reported-by: syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/0000000000000b05cd060d6b5511@google.com/
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/scompress.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/crypto/scompress.c b/crypto/scompress.c
index 4d50750d01c6..ec849790f728 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -124,6 +124,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	struct crypto_scomp *scomp = *tfm_ctx;
 	void **ctx = acomp_request_ctx(req);
 	struct scomp_scratch *scratch;
+	unsigned int dlen;
 	int ret;
 
 	if (!req->src || !req->slen || req->slen > SCOMP_SCRATCH_SIZE)
@@ -135,6 +136,8 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	if (!req->dlen || req->dlen > SCOMP_SCRATCH_SIZE)
 		req->dlen = SCOMP_SCRATCH_SIZE;
 
+	dlen = req->dlen;
+
 	scratch = raw_cpu_ptr(&scomp_scratch);
 	spin_lock(&scratch->lock);
 
@@ -152,6 +155,9 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 				ret = -ENOMEM;
 				goto out;
 			}
+		} else if (req->dlen > dlen) {
+			ret = -ENOSPC;
+			goto out;
 		}
 		scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->dlen,
 					 1);
-- 
2.43.0




