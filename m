Return-Path: <stable+bounces-2959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9787FC6D5
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19753286437
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1F342A8F;
	Tue, 28 Nov 2023 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSKflLYx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BB64437B;
	Tue, 28 Nov 2023 21:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE937C433CA;
	Tue, 28 Nov 2023 21:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205600;
	bh=+NrWQrBv8ISFQLjQerhL7DQug0d51ngGgWX5u9WiijA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WSKflLYxHlRUNA2MsgA+j90bkaSaa32qeKna4lC1tJS/NfYEudEewS7tbGzxcCrQg
	 o1YvnvfuV9+0J36Cpx1UyJPwkFNmROR34Jx1IpvX2IIzorP/0vVxE84gKhntlbQyCo
	 MMSM3ghFGRbF+bUmyOwAsJEQTWUaitENSpNSprZRa3muuEcYM0OLeOq+nm5qJBj3Mr
	 vJMazJPvuq72SKirnWMuxmfOFZAXSHmNY5fad1k+tqyO4VkHoDNboHkhb6dYda/6D4
	 dM+AprJhFF8iidfWEGlX5u0p1qHofugu3R9OeJU8/esbdNmKB3n2W/+fn2CPlmIWTY
	 fR/unBANiE5gw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Nan <linan122@huawei.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH AUTOSEL 6.6 13/40] nbd: fix null-ptr-dereference while accessing 'nbd->config'
Date: Tue, 28 Nov 2023 16:05:19 -0500
Message-ID: <20231128210615.875085-13-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit

From: Li Nan <linan122@huawei.com>

[ Upstream commit c2da049f419417808466c529999170f5c3ef7d3d ]

Memory reordering may occur in nbd_genl_connect(), causing config_refs
to be set to 1 while nbd->config is still empty. Opening nbd at this
time will cause null-ptr-dereference.

   T1                      T2
   nbd_open
    nbd_get_config_unlocked
                 	   nbd_genl_connect
                 	    nbd_alloc_and_init_config
                 	     //memory reordered
                  	     refcount_set(&nbd->config_refs, 1)  // 2
     nbd->config
      ->null point
			     nbd->config = config  // 1

Fix it by adding smp barrier to guarantee the execution sequence.

Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Link: https://lore.kernel.org/r/20231116162316.1740402-4-linan666@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index daaf8805e876c..3f03cb3dc33cc 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -397,8 +397,16 @@ static u32 req_to_nbd_cmd_type(struct request *req)
 
 static struct nbd_config *nbd_get_config_unlocked(struct nbd_device *nbd)
 {
-	if (refcount_inc_not_zero(&nbd->config_refs))
+	if (refcount_inc_not_zero(&nbd->config_refs)) {
+		/*
+		 * Add smp_mb__after_atomic to ensure that reading nbd->config_refs
+		 * and reading nbd->config is ordered. The pair is the barrier in
+		 * nbd_alloc_and_init_config(), avoid nbd->config_refs is set
+		 * before nbd->config.
+		 */
+		smp_mb__after_atomic();
 		return nbd->config;
+	}
 
 	return NULL;
 }
@@ -1559,7 +1567,15 @@ static int nbd_alloc_and_init_config(struct nbd_device *nbd)
 	init_waitqueue_head(&config->conn_wait);
 	config->blksize_bits = NBD_DEF_BLKSIZE_BITS;
 	atomic_set(&config->live_connections, 0);
+
 	nbd->config = config;
+	/*
+	 * Order refcount_set(&nbd->config_refs, 1) and nbd->config assignment,
+	 * its pair is the barrier in nbd_get_config_unlocked().
+	 * So nbd_get_config_unlocked() won't see nbd->config as null after
+	 * refcount_inc_not_zero() succeed.
+	 */
+	smp_mb__before_atomic();
 	refcount_set(&nbd->config_refs, 1);
 
 	return 0;
-- 
2.42.0


