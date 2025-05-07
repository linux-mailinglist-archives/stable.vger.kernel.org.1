Return-Path: <stable+bounces-142392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0852AAEA6B
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13DF9C7BA4
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D6C289348;
	Wed,  7 May 2025 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nMumWAep"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B512116E9;
	Wed,  7 May 2025 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644107; cv=none; b=DwdB9hDQw5YwBeG8V12qvfuExBnC8QR5u2lYglMqfCEea+Lpwfdh4W8r4bBNdn73yZP42SzRWeT082Sx94670esKJCSvp6vqcEa0GeRFCc3qnLG6EDFOTGsluUmRf9ZcBsG9rPBvzZCJuAUJwAtutgrBl2jsh0b3HZEdPlKM4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644107; c=relaxed/simple;
	bh=VgSz9jI5qJoCBaCJqhFhrWcCv44VyY27ySkS+ULrdK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g31xo1gGZXb1yCfuBjsU9+5DHUEj9LHt1Afb3b1KBDT7AaNWCSxr0dWrceEkY49ip/rQy/1ZFa7QBpr1o3QNuJlVdx8k+NZn/f+7Jxw7UhWyXz/Wy2+4+tk0KB5yYS7UpLntVUzfisRXquhgdgpX6CY5YD1BZXXITUlbwsSzioE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nMumWAep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68338C4CEE2;
	Wed,  7 May 2025 18:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746644107;
	bh=VgSz9jI5qJoCBaCJqhFhrWcCv44VyY27ySkS+ULrdK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nMumWAepqh48nDJTjaixxZpYcbdA/iYZmY9XHEne7KXxbMsu7K7F+AIApzHOVdvtD
	 0f3JWxrm3SfXnzXBBFq/usATaIfdFMmHJirMy8rVtdKoAFkgZK1ixQAKxf6wtY40z4
	 S1RisGkUH3PTlShMJc16+1Yp1VdNUsHx939gerrI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 122/183] bnxt_en: Fix ethtool selftest output in one of the failure cases
Date: Wed,  7 May 2025 20:39:27 +0200
Message-ID: <20250507183829.766260877@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183824.682671926@linuxfoundation.org>
References: <20250507183824.682671926@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

[ Upstream commit 8e6cc9045380f3f0c48ebda2bda5e1abe263388d ]

When RDMA driver is loaded, running offline self test is not
supported and driver returns failure early. But it is not clearing
the input buffer and hence the application prints some junk
characters for individual test results.

Fix it by clearing the buffer before returning.

Fixes: 895621f1c816 ("bnxt_en: Don't support offline self test when RoCE driver is loaded")
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 9c58208395144..d974f71074a76 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4922,6 +4922,7 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
 	if (!bp->num_tests || !BNXT_PF(bp))
 		return;
 
+	memset(buf, 0, sizeof(u64) * bp->num_tests);
 	if (etest->flags & ETH_TEST_FL_OFFLINE &&
 	    bnxt_ulp_registered(bp->edev)) {
 		etest->flags |= ETH_TEST_FL_FAILED;
@@ -4929,7 +4930,6 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
 		return;
 	}
 
-	memset(buf, 0, sizeof(u64) * bp->num_tests);
 	if (!netif_running(dev)) {
 		etest->flags |= ETH_TEST_FL_FAILED;
 		return;
-- 
2.39.5




