Return-Path: <stable+bounces-13200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E071E837AEA
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A711F2541D
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FC413343E;
	Tue, 23 Jan 2024 00:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FDz/qz4l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088AE13343A;
	Tue, 23 Jan 2024 00:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969133; cv=none; b=YqEcA05zMYYTCxZcyAoCw4l3M9d5TpXT8xKXyS10++QLbKlXSTXkF6yCXodzkWLeCNPe10/XIpztA/NvtW4NRFSUKXcb3toJiSDz7EK/yw0wYaxlteU7TmUkt/v3xoHT0dKGw1IMM1fyOYope1H6oNFiwN2rB5QX7stkTU6m6Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969133; c=relaxed/simple;
	bh=3DocdzHES5lqoZgzI8CnCKRXJcV9ce+FbLRh65ccw4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6hbBHijx1CVU0a4GxMK9MgNpT5X+hH+Zx5dNQ2Tn0FLtiJ5awoeEq8Ah2lafCL658MPFYfxE3hWzviDKFZc3umbZNsc46NZvDdTRPqO90yyLqJtaYY5zC1aCK/W0iF5TFOKMjmWjEIgjvfpe1NX4Hpqe52IMdkY3RIRVbbaWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FDz/qz4l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B776EC433C7;
	Tue, 23 Jan 2024 00:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969132;
	bh=3DocdzHES5lqoZgzI8CnCKRXJcV9ce+FbLRh65ccw4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FDz/qz4lhjJ7KtDSjCBUqBCqKUNRaVEmFzSb9cQr9n7tzR0QJ1ZHDaRHSnJSxOe4O
	 yF0SJIz+k+MaUhSHXDP8JQMMT276Or/txQ4Gyl7jh98IMS9EN/Ehjz05YhvB/GD2e7
	 uiGb9BAWEe0awssJY+ap/COKKOLIImllW3goDp/A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 043/641] crypto: rsa - add a check for allocation failure
Date: Mon, 22 Jan 2024 15:49:07 -0800
Message-ID: <20240122235819.429768031@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit d872ca165cb67112f2841ef9c37d51ef7e63d1e4 ]

Static checkers insist that the mpi_alloc() allocation can fail so add
a check to prevent a NULL dereference.  Small allocations like this
can't actually fail in current kernels, but adding a check is very
simple and makes the static checkers happy.

Fixes: 6637e11e4ad2 ("crypto: rsa - allow only odd e and restrict value in FIPS mode")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/rsa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/rsa.c b/crypto/rsa.c
index c79613cdce6e..b9cd11fb7d36 100644
--- a/crypto/rsa.c
+++ b/crypto/rsa.c
@@ -220,6 +220,8 @@ static int rsa_check_exponent_fips(MPI e)
 	}
 
 	e_max = mpi_alloc(0);
+	if (!e_max)
+		return -ENOMEM;
 	mpi_set_bit(e_max, 256);
 
 	if (mpi_cmp(e, e_max) >= 0) {
-- 
2.43.0




