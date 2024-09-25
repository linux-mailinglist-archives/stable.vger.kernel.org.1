Return-Path: <stable+bounces-77357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C707985C3B
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA71F1F28DAA
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08851ACDF6;
	Wed, 25 Sep 2024 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlVAsvg5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8297D1714C6;
	Wed, 25 Sep 2024 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265542; cv=none; b=hkN0TEOa4L8FUILif699CB3uQpD9d6QFdxHv+ka7saMJzdQx3wFsmiPGepqy5elqwAKtGfS9zEX0roj1R7F9pv+sBjucAjmc+wqBZtEv0wvEZcoQdaEAu0m4Pv3iOZdxGhZYdCq3En7Q5PeKol01mBnMbQdaxwWLFLDAp4y3TYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265542; c=relaxed/simple;
	bh=GBAo6MwrULjwRQNw5KThPU7V3CJYVg5MOj1bngCwdMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jo6sRkGGGlhMi+AKfceXm5GMRaCwZUQiQ6gTGx92E8BNDPHOf8YliXkXciliwaR3NmZIObjV/Kg5WB0mcDAGywF4pMRU+Y+ydJfP7ds3hxIrWPC4X+8xV+3H8PAANHmYZw62AdtUHSnPbuZcenAHFCgisshHDYOgPX1levYD72o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlVAsvg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4683FC4CEC3;
	Wed, 25 Sep 2024 11:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265542;
	bh=GBAo6MwrULjwRQNw5KThPU7V3CJYVg5MOj1bngCwdMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qlVAsvg5vNTW3vI//LKfurMRgc3yEYXDdG0BWWZXmcEBah5VikPhuWCwl+7+Jcrue
	 httWIqGnLzu25DoDtIrAWxGPZOLX0a8yjWQbQZLNysaYP9aSKxDyC7ommkPUsnShwi
	 dyk2x0SsBgtCbZuSOYUJyqc96JmjXO+u17lIFnOLtFvbFfR7x3MRRCN1gGKDCl5i64
	 yT8WNUTsZjv6QZTyUwaxyLLZpfLmiSaumIJYDkUCv6wMkA8PuA3uVJAc4pmthkCSwm
	 56kgoMvGEzC+pfB8U/dRn5XbsU4ofvddM4MMAE4ADBMzM5dSq64ST3TmmnN9Q2RZuI
	 jKo9F7+9D1ZQQ==
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
	wojciech.drewek@intel.com,
	liuyonglong@huawei.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 013/197] net: hisilicon: hns_dsaf_mac: fix OF node leak in hns_mac_get_info()
Date: Wed, 25 Sep 2024 07:50:32 -0400
Message-ID: <20240925115823.1303019-13-sashal@kernel.org>
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


