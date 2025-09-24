Return-Path: <stable+bounces-181583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5003AB98BF3
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 10:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92795164AE0
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 08:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBE2283FEA;
	Wed, 24 Sep 2025 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0kIf5+V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8A526F2AA;
	Wed, 24 Sep 2025 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701109; cv=none; b=Y5Yxy/Y9sZhD7mYmPiY9Yx6/rE/H7OtubsSH3gEGmuwvU05cD3yUyH20BqytTq4NhvBUc2XSSlBH/r5+LE1Lh7UfHruPFilnfXhEZTAHWNgq4eycj7EyLi7S3s7E8PyPzU7EltM6podrsxkV5Y8hKO4zuwMsKTS++yryHzhpE6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701109; c=relaxed/simple;
	bh=PFhuBd8iA3HncUHJ74iHuikqIFgZeBkd3xl2TImLdII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ArjgMwGlA98IOOJ4A2NGtYEXlEJIr5AghPZKPxeMikQSgs1yIgFaRGq+PAVwO//OBhZQc6/Wf7XimExYwCJDfCqXOLLPwzaazkE2LAXSgYXkUfs/nq7v5pDcOBEv2+s7JTfn8jQnZ++cWTqPPDadLVRThHDqqU0PBCA1O+89Mkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0kIf5+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72F1C4CEE7;
	Wed, 24 Sep 2025 08:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758701108;
	bh=PFhuBd8iA3HncUHJ74iHuikqIFgZeBkd3xl2TImLdII=;
	h=From:To:Cc:Subject:Date:From;
	b=f0kIf5+VtNsPoTXl15wn8jrm+J43Ko6u7hXA99Q61w+8oQSF8aJIp4ZW5J0cUMGbc
	 bJZDtLKHkDWfSRNU0NArI8CPQmlPuZ7VScnq1FMLIgVzrYmgQbawCcmN6ElwsbZjfH
	 alzazFa1COb7UcqWiKM8ilRpk6e2ZSJV0mZWwg7jCvl5DcpialTtYusv0UEAb1zsrI
	 zV+13rEU8yeMPuDcf6ITnQyQatjNKrfwpl/3EUeuuitovWfamgrxpAbCfaVVsr+hGm
	 OgzV/6mb00XnXFKOufQpQ2QML+SodNPmqn+J5wTdr0HI9/hn32v0w/3cqSee4YtWTH
	 /25hFlxe5Ykqg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1KUo-000000004jN-0aRM;
	Wed, 24 Sep 2025 10:05:02 +0200
From: Johan Hovold <johan@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] lib/genalloc: fix device leak in of_gen_pool_get()
Date: Wed, 24 Sep 2025 10:02:07 +0200
Message-ID: <20250924080207.18006-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken when looking up the genpool
platform device in of_gen_pool_get() before returning the pool.

Note that holding a reference to a device does typically not prevent its
devres managed resources from being released so there is no point in
keeping the reference.

Fixes: 9375db07adea ("genalloc: add devres support, allow to find a managed pool by device")
Cc: stable@vger.kernel.org	# 3.10
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 lib/genalloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/genalloc.c b/lib/genalloc.c
index 4fa5635bf81b..841f29783833 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -899,8 +899,11 @@ struct gen_pool *of_gen_pool_get(struct device_node *np,
 		if (!name)
 			name = of_node_full_name(np_pool);
 	}
-	if (pdev)
+	if (pdev) {
 		pool = gen_pool_get(&pdev->dev, name);
+		put_device(&pdev->dev);
+	}
+
 	of_node_put(np_pool);
 
 	return pool;
-- 
2.49.1


