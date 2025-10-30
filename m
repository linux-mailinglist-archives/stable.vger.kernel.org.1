Return-Path: <stable+bounces-191694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 343C3C1EA7F
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 08:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C0F1882EE3
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 07:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E98223FC4C;
	Thu, 30 Oct 2025 07:00:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D3033290E
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 07:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807614; cv=none; b=JCRlol+QiwWKRtvuDlrHv2n8PqELUNx3bmX+PmDMYEHk7A4kVUvPBvtUvQXPBtUH+Y/OA0aTwTN3CcWkOPeRkOkFY6TffEPwM0bxJ7JiqyZRffyY87Xl3N/CXP1B+FyPy79K5f6Kl96dmfgKluRgc+rfn6VQ57eKoovNO/DjWz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807614; c=relaxed/simple;
	bh=933uhCRCJBYE+iLMFJb6hH6aljHCXDXoz5rnmNy2BBQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZAAHolpkhm2qPTq5MQv3aHq7EMJMWRK072d9QJsavP9v21vKkP0oCSHfVMmDNpTvYUaE87Eqm6LgilxZOfG6qcurw2WKXGkDCPSEkC7bou/qoYY6WjzyKALKDWfv2gXDtVVCzmdn8pkxebuD4OJOuwAivOdcBhzDqqNAFJZJL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[117.129.7.61])
	by rmsmtp-lg-appmail-01-12079 (RichMail) with SMTP id 2f2f69030cef717-4dea3;
	Thu, 30 Oct 2025 15:00:01 +0800 (CST)
X-RM-TRANSID:2f2f69030cef717-4dea3
From: Rajani Kantha <681739313@139.com>
To: razor@blackwall.org,
	toke@redhat.com,
	liuhangbin@gmail.com,
	kuba@kernel.org,
	joamaki@gmail.com,
	wangliang74@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH 6.12.y 1/2] bonding: return detailed error when loading native XDP fails
Date: Thu, 30 Oct 2025 14:59:58 +0800
Message-Id: <20251030065959.8773-2-681739313@139.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251030065959.8773-1-681739313@139.com>
References: <20251030065959.8773-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 22ccb684c1cae37411450e6e86a379cd3c29cb8f ]

Bonding only supports native XDP for specific modes, which can lead to
confusion for users regarding why XDP loads successfully at times and
fails at others. This patch enhances error handling by returning detailed
error messages, providing users with clearer insights into the specific
reasons for the failure when loading native XDP.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://patch.msgid.link/20241021031211.814-2-liuhangbin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 drivers/net/bonding/bond_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 46628a7ed497..93e6d069dfc6 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5699,8 +5699,11 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 
 	ASSERT_RTNL();
 
-	if (!bond_xdp_check(bond))
+	if (!bond_xdp_check(bond)) {
+		BOND_NL_ERR(dev, extack,
+			    "No native XDP support for the current bonding mode");
 		return -EOPNOTSUPP;
+	}
 
 	old_prog = bond->xdp_prog;
 	bond->xdp_prog = prog;
-- 
2.17.1



