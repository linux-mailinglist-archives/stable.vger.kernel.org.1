Return-Path: <stable+bounces-219321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGBsFbCdnmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:58:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7134192A81
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8F6F30387DD
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2775330C606;
	Wed, 25 Feb 2026 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LUnrO4hs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44F42F290B;
	Wed, 25 Feb 2026 06:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002638; cv=none; b=f405XX2vmWjM1XcDdp3NqmKNvrp7KXUH8D5w8IUaRVsFdurPLPhjuDL5B6JdJCyL1Su5waJ+z9m1AwJGBfAcNqOj3Ub8w9R0e62j0DbkmjbIYUasT/EpGD0CLXHM2A57rRRPTJ/zFQKYqGhLjIzJmYN1J4fmjU8lSfeATwrRHUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002638; c=relaxed/simple;
	bh=ap9KLUYjn2BuZ5RPclKXfx/W2e5YFqhzPUqvZk2mHd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vs+efQXBcLo3oNtBtUjOF4Wt+E2DGUULJymIcnN2fDh3Ij6zw+qJ9Xf3kvS8pIQOqtMgYoydkqYaps0GrkxNBRFNLoKrygEOSApY9x7QdjS6MkGbcwkt19kr8gtq1dJaOtMODD6fmug+KgIsj5JdNsvGBuxHTJFX/nethOC96Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LUnrO4hs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEA9C116D0;
	Wed, 25 Feb 2026 06:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002638;
	bh=ap9KLUYjn2BuZ5RPclKXfx/W2e5YFqhzPUqvZk2mHd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LUnrO4hsv6zw5PxU8i7WGPigM87Q8qxvOiZ2oiiyMdYIeXDtgcOkhi8peml8KcOcg
	 xxqvbLYzv1xXdAjVvX23MRtEhPVKpdyfvy9OZECX0WyQvTK3hXsHYQDhapcd7BD2mL
	 UttVGOEvlx7Oa22yMkMLvxta22WXumsqxbai30SY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 404/641] clk: qcom: gcc-sm8550: Use floor ops for SDCC RCGs
Date: Tue, 24 Feb 2026 17:22:10 -0800
Message-ID: <20260225012358.356908570@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219321-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email,linaro.org:email]
X-Rspamd-Queue-Id: C7134192A81
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

[ Upstream commit 1c06e3956054fb5a0930f07b02726b1774b6c700 ]

In line with commit a27ac3806b0a ("clk: qcom: gcc-sm8450: Use floor ops
for SDCC RCGs") done to fix issues with overclocked SD cards on SM8450
powered boards set floor clock operations for SDCC RCGs on SM8550.

This change fixes initialization of some SD cards, where the problem
is manifested by the SDHC driver:

    mmc0: Card appears overclocked; req 50000000 Hz, actual 100000000 Hz
    mmc0: error -110 whilst initialising SD card

Fixes: 955f2ea3b9e9 ("clk: qcom: Add GCC driver for SM8550")
Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20251124212012.3660189-2-vladimir.zapolskiy@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-sm8550.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8550.c b/drivers/clk/qcom/gcc-sm8550.c
index 862a9bf73bcb5..36a5b7de5b55d 100644
--- a/drivers/clk/qcom/gcc-sm8550.c
+++ b/drivers/clk/qcom/gcc-sm8550.c
@@ -1025,7 +1025,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.parent_data = gcc_parent_data_9,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_9),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_shared_ops,
+		.ops = &clk_rcg2_shared_floor_ops,
 	},
 };
 
@@ -1048,7 +1048,7 @@ static struct clk_rcg2 gcc_sdcc4_apps_clk_src = {
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_shared_ops,
+		.ops = &clk_rcg2_shared_floor_ops,
 	},
 };
 
-- 
2.51.0




