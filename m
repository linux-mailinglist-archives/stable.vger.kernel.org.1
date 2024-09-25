Return-Path: <stable+bounces-77114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F2F98584A
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779F8286360
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FD418BC0D;
	Wed, 25 Sep 2024 11:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CamjTNh2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8338C18BBBA;
	Wed, 25 Sep 2024 11:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264242; cv=none; b=GHKa1u5kz3oxl0UuAnFiFTYEOrW8YsQ0OXRygPWZdxGPhGsRQBoaVFyn2+PHi7LhPMGjjdP0VYctbRC26zofWSDjxtymvIaPdy3xSPjnETYOCXJycLITuJUDDQWBiy34PSCxG9Rzy72gd/Oi7xlW4aYREXvET/fQWdvaaJ/Hlu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264242; c=relaxed/simple;
	bh=Fo5xBJHXU4CNwnOmk14HOBVh5ZuqGt3jlBtjF4mgNp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1ZziZ4H/tlngBfSn82ef8LtfD/hHChdepdWCb0K7lfz/bj93OdnCShLa2Tbp5vK5v8mHnBdC7nPyfQFaY9ObMgMc9NT3oA7h7kmBPucCkG9Thyu2GahW/4o5+NI4bYnN3EGub7b6MsPW3VjKhl3P4qJQZbODFN9j3xwE9WD134=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CamjTNh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7FEC4CEC3;
	Wed, 25 Sep 2024 11:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264242;
	bh=Fo5xBJHXU4CNwnOmk14HOBVh5ZuqGt3jlBtjF4mgNp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CamjTNh2gqUAvp93S32ZkEL+4vHTStE/85UrdYvLNyfvEKB1966kCuupBu19emvfA
	 /QNtjsyiNDjrXspj7WlfKYilVfNrlZV+tPeY0YOlUtypqDYcNmFIeiOxtaZVt/+AQJ
	 XVO/6TtQtnJfqw+5tU9gi4NKtf+wA73iJyBScy4Gi/SXB6uNNttZqAjX2hu6EWSnbi
	 ri5g6Sh2mxDNFzjYFISkD7EOCgJhbIQGaAO4dEN1b11rDrx/a/8Sog1UPVyrAsJYoS
	 T9r5lIWMhAGRbS4S7GKQ4SR7q/v8RfD0Pi4lKGqCMHRFD6RZq3Pq+IAiIkGT/ZN8gD
	 UpJQCfcTB5nGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	yisen.zhuang@huawei.com,
	salil.mehta@huawei.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 016/244] net: hisilicon: hns_mdio: fix OF node leak in probe()
Date: Wed, 25 Sep 2024 07:23:57 -0400
Message-ID: <20240925113641.1297102-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit e62beddc45f487b9969821fad3a0913d9bc18a2f ]

Driver is leaking OF node reference from
of_parse_phandle_with_fixed_args() in probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20240827144421.52852-4-krzysztof.kozlowski@linaro.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns_mdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
index ed73707176c1a..8a047145f0c50 100644
--- a/drivers/net/ethernet/hisilicon/hns_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
@@ -575,6 +575,7 @@ static int hns_mdio_probe(struct platform_device *pdev)
 						MDIO_SC_RESET_ST;
 				}
 			}
+			of_node_put(reg_args.np);
 		} else {
 			dev_warn(&pdev->dev, "find syscon ret = %#x\n", ret);
 			mdio_dev->subctrl_vbase = NULL;
-- 
2.43.0


