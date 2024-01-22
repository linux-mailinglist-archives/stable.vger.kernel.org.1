Return-Path: <stable+bounces-13890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A1A837E98
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC94C28B485
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DFE6ABB;
	Tue, 23 Jan 2024 00:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pnnp7jmS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC9763C3;
	Tue, 23 Jan 2024 00:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970683; cv=none; b=nO4N4MjGOykjp84DSZYD+DJz0f8SpJ0XYk9f3tQ09NbgjkO136xE5WkNfpuftJTEYZ+7iDLMWgRnd4t4nT5o3BN0BaVNiSgJIHGDpwoHb1O9uBusVp7KHkVrI2mys3t++9i+RMWSN8FFbIHS6iV2QyId09D2AJJr/qTcIUNAhVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970683; c=relaxed/simple;
	bh=mtoTqddyqKcc+54UlHUYU/mxFoctsYjJahMeaHvkn20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpiRtPa7sMCFwxpIcSDowpFmtiSKfjiIMc4I8HVYIX8CAyNdtffWOTP7uIoL0+TgpGMLtDi56ZsWMbTxwgdMEr/mL5Nn9M/KSDRPItbeDhWoi0Ri3JowwY1tpRuNv47nk4qEShcRLMprnJKvebDCDMX0M27gTCqJ9ReF6rhZgGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pnnp7jmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C14AC433C7;
	Tue, 23 Jan 2024 00:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705970683;
	bh=mtoTqddyqKcc+54UlHUYU/mxFoctsYjJahMeaHvkn20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pnnp7jmSZwqbAXB8ySjOSaysEcxmW7U8W1XKIfhtJOvttr19CKXUimUu/2AcFYKod
	 N9lUG5IHrXVisK/tfMaTsYMusD4GDNbMxy/8WrvHNXf4Kdvkp6INpJNK0KA9aS/OFj
	 Vrr8NrBWKGZe2xf7svwxdWS8IpWPShENyekZ6lRE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Barry Song <v-songbaohua@oppo.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 062/417] crypto: scomp - fix req->dst buffer overflow
Date: Mon, 22 Jan 2024 15:53:50 -0800
Message-ID: <20240122235753.863400948@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 738f4f8f0f41..4d6366a44400 100644
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




