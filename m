Return-Path: <stable+bounces-77382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC8F985C8D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789B2288036
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAE01D0DC7;
	Wed, 25 Sep 2024 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRIfpA6m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3EC1D097C;
	Wed, 25 Sep 2024 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265586; cv=none; b=jmae5aIm5q5XtARhDzMH4c9jYUlaJVASTDlgOGPPalKh1DAbr5yWx4HuHVpul0TxDyZCOxEcT8jDEl61vHBddUQcQ4MWGZSfXfwAlvK9lDjEblfY8i0pbHmlA4B6PNfPcIb5OncUoJPRb6/dWh0UZ8wyDXAyShSGRpy0BykcloI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265586; c=relaxed/simple;
	bh=i8Ddac0wgO2fY7sABcvAsuECZ7AXGgf8fgPecamxW/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGzBH1hgj2b8Te1bQyrggs/WBxQEdJ+pbFaNFh05l3xltahrj4zXaUhXD16F2StwHzgQs5Z575hA+UZPFyXkbqJw268dUaJ1+AQN4hFyet8CPf3CPnYn+udzH/e2Y/xf8ZfTgZ7DVNpbo+ZAWE8o04+/rCfMyjoXkpoQlnSnU0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRIfpA6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE5AC4CEC3;
	Wed, 25 Sep 2024 11:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265586;
	bh=i8Ddac0wgO2fY7sABcvAsuECZ7AXGgf8fgPecamxW/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRIfpA6mL2X+jvU0ieGqPkS/PC8bkWyCNY5/e/n568zns3wF2Y0l+rySMGKhJrHKE
	 4JG7RwUJQ8y0pMhotF2WJgYBPYvWi84i3/YRtqEp61zXfzeLsUh7Wu0mSoanFesrJb
	 iPF4o5NXSoggXeS+H1U2JeLFsg431NRzgL/llsE/oJwq1jGyan4Mwm8+H4SwDxZ1vn
	 yjhNVR2+Smi5ez/YdeCZoW72gQ/kwOyEI1NijOPkazwSyCM6LWRrvTI4pllndH4RUu
	 oiS5AAUjVHITCVTO01vy98GxKa70Ps1q2NjG9wn2hUHqTm1MHNZWTdHiLM25+hXHwu
	 JL1zuMMJvwLyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 037/197] bnxt_en: Extend maximum length of version string by 1 byte
Date: Wed, 25 Sep 2024 07:50:56 -0400
Message-ID: <20240925115823.1303019-37-sashal@kernel.org>
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

From: Simon Horman <horms@kernel.org>

[ Upstream commit ffff7ee843c351ce71d6e0d52f0f20bea35e18c9 ]

This corrects an out-by-one error in the maximum length of the package
version string. The size argument of snprintf includes space for the
trailing '\0' byte, so there is no need to allow extra space for it by
reducing the value of the size argument by 1.

Found by inspection.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Link: https://patch.msgid.link/20240813-bnxt-str-v2-1-872050a157e7@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 79c09c1cdf936..0032c4ebd7e12 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4146,7 +4146,7 @@ static void bnxt_get_pkgver(struct net_device *dev)
 
 	if (!bnxt_get_pkginfo(dev, buf, sizeof(buf))) {
 		len = strlen(bp->fw_ver_str);
-		snprintf(bp->fw_ver_str + len, FW_VER_STR_LEN - len - 1,
+		snprintf(bp->fw_ver_str + len, FW_VER_STR_LEN - len,
 			 "/pkg %s", buf);
 	}
 }
-- 
2.43.0


