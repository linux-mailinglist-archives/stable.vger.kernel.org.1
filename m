Return-Path: <stable+bounces-77358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 205CC985C3E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F55285747
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1161CC884;
	Wed, 25 Sep 2024 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tf092sjc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8459A1C32E9;
	Wed, 25 Sep 2024 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265544; cv=none; b=oneAB+xvpjHkXIQk6aXTeSC++c09oZW83Ty/4tXYq4NxoYgtP5tPW2IVHtmHA2ito6luxld3/Icp3Fisc3q6LxHCNVNJyYpg/iuMU2EF/ZYln4vRYWM4l2W4lIUhXgmqqZTpyUp/YADsmcFqptdEwhLCBRABJAoq+dqXSID3MDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265544; c=relaxed/simple;
	bh=Fo5xBJHXU4CNwnOmk14HOBVh5ZuqGt3jlBtjF4mgNp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZaGNwi3VyXRhESjlJ+a7K+pueps5ifZv4XB4ybunwMIZrPXF4yypuPJJ5gZmXgC38e59KZhRj0UAgCEAmrAAOZdWFpdC6use+QlyKg/Tc7dfb5BhRTZzkvth3eOGFQAjLDFy56sC/kifagPm+YQywifsxmOx6oeMwZD8TRNs+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tf092sjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981C5C4CEC7;
	Wed, 25 Sep 2024 11:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265544;
	bh=Fo5xBJHXU4CNwnOmk14HOBVh5ZuqGt3jlBtjF4mgNp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tf092sjc7cvAkJSoR/goIE1jTdKfIdkYQQfhopRfw6ofnliLA6ZAWRXQRsua3Cl6D
	 vr0faHkFD30vtZHaQXaduv7qF6TYyDawn8MTBRjNBcaMFESe3KFrzXfMt+g1JjFD3n
	 Qp8rTI74TMUXwsyRygeKYdq+zRGjZAz2Cc6JWnNHc7uo5jBNpC0zLl260HB8Ujd0mh
	 e7YjlnNyZubrSPNGXguMYcjD2yDbBVqeD3ombzMjPlwBTREX5qu84ITjlCdc5AC00/
	 +zBIcYuEIBW/v9ga0SiF+/nNKaWACeau2h7CTaksz9BU9lEKHcigbMkuO5zVbWDE/W
	 kkdTw1EECjIOw==
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
Subject: [PATCH AUTOSEL 6.10 014/197] net: hisilicon: hns_mdio: fix OF node leak in probe()
Date: Wed, 25 Sep 2024 07:50:33 -0400
Message-ID: <20240925115823.1303019-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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


