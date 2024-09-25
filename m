Return-Path: <stable+bounces-77559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA11E985E80
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56BEE1F21C72
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3786211CF5;
	Wed, 25 Sep 2024 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkP/vXT6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5F8211CDE;
	Wed, 25 Sep 2024 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266331; cv=none; b=Xxhg1J11acEaJz0HiBEGwmi8PFZv7hX+JMK0y13XGhiBHO6I3/F1P7Lw3Nz1pp0H6rR9Ap3oV7Hzl11mtLTTXmq+PB1bYNhsbBfudF+v/hiDim9VrTnZCEp2jRPgBRJvIkUiqJEl5gBFMGaTlTqiIxSX1XWe5IQkeAwNi+FaWAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266331; c=relaxed/simple;
	bh=GBAo6MwrULjwRQNw5KThPU7V3CJYVg5MOj1bngCwdMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTPo8xOKDnLnyw1yJDgy74n1dv7tldBystz0O+qvv9gVCBoM1o03vg6rylL8kiMsTYvXmnTfN+kWqRHAxDOoiYBB+1mUO7nxw20yCF+P9YgYSo0/kgguK45ruir8H3kJpffF5gdUJnwzgvimfJZ9DTXN8AHbb2Wv+yRhx8njDSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkP/vXT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56C8C4CEC7;
	Wed, 25 Sep 2024 12:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266331;
	bh=GBAo6MwrULjwRQNw5KThPU7V3CJYVg5MOj1bngCwdMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gkP/vXT6dwOiDYN/Jz4xKa/tGfUZ/ceATJ7ntkL3qKXU3uqUkKH0GAFz3QYB7Rm6t
	 GD/zYqKaOhcpnEYk7cC9fki36cvLiiBrSUkx+OM3MmE830TCwQ4V2sHUn8oqQoZI67
	 mv6pK4pQHO7Hw+tplRKC9ei3jrh0yD0wOpau1oeFSBd6Q6ZnIM4bdukQXKNbsfZ11q
	 xjT0sVZOVe6i7qhwpt/Fo/lwM4L47+G/RTnKe/XCQANtyDUa8SwVDBGFVNZxBvc5vx
	 ieRSKuxgDcxT47lj2CFEXQxp0Gt8ZkwXuNS5nGAOyseUqAvFjXP1l9UpPnitxXQv0N
	 +zqSahQoH6p4w==
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
	shaojijie@huawei.com,
	liuyonglong@huawei.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 013/139] net: hisilicon: hns_dsaf_mac: fix OF node leak in hns_mac_get_info()
Date: Wed, 25 Sep 2024 08:07:13 -0400
Message-ID: <20240925121137.1307574-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 5680cf8d34e1552df987e2f4bb1bff0b2a8c8b11 ]

Driver is leaking OF node reference from
of_parse_phandle_with_fixed_args() in hns_mac_get_info().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20240827144421.52852-3-krzysztof.kozlowski@linaro.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index f75668c479351..616a2768e5048 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -933,6 +933,7 @@ static int hns_mac_get_info(struct hns_mac_cb *mac_cb)
 			mac_cb->cpld_ctrl = NULL;
 		} else {
 			syscon = syscon_node_to_regmap(cpld_args.np);
+			of_node_put(cpld_args.np);
 			if (IS_ERR_OR_NULL(syscon)) {
 				dev_dbg(mac_cb->dev, "no cpld-syscon found!\n");
 				mac_cb->cpld_ctrl = NULL;
-- 
2.43.0


