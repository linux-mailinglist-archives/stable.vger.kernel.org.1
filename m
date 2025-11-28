Return-Path: <stable+bounces-197572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E6642C9171F
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 10:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93C63347371
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 09:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3586330217D;
	Fri, 28 Nov 2025 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="LUF4xbT3"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA8C30275E
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764322194; cv=none; b=WhbiXkNeYYfewxW4i+OCAqN6VcI094X3LjjlJJ4G6gLqKbiXEnl4bOyKSNRlX2xXTpqUc/kSiD0k+90QLjV4xl5yTGFhx4e44msKfEEfqzjkJ44KH7krJq0BuThl68Tegkzz73Gbh1Uwz7VoO8OiJbv6O2SO4dqqr/sPJWNcAnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764322194; c=relaxed/simple;
	bh=CqWmurYDeNCIkyRHWWKN/bWWs7oXe/P58ZcgDCe5U7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1QERGx12ybp93qcMJ1+iMouqo150DDHpoxrWMVnkeYRzXmjYUy7b1MGSGuGbwG3eaEGcPViNJ1kdQ10RKAY160Toh7VTYUHAnPH1mS27+xWbdRioRrkKzYrlNUiOM/6fQvCOLmo5U9WFca2ubTJ2UO1f4Qj6GkyH2ehc/Kh530=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=LUF4xbT3; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=LUF4xbT3K+vALy5GwFu14g2iRJqvAUm7sY+fKxNqCa81xe7hNSJgFjqyBa7dYbNdXJAO2AlwSgrn9
	 IyxDOTFolQUGrCCP5za/Vc8PEIxDDlJd0Nhr995vFoFLxjDVttjJJ02M2aWjXxv/X2oo4vFCTQTFG6
	 iUYZgUE+M8d/wgYk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[183.241.245.185])
	by rmsmtp-lg-appmail-08-12086 (RichMail) with SMTP id 2f3669296ac0696-12781;
	Fri, 28 Nov 2025 17:26:27 +0800 (CST)
X-RM-TRANSID:2f3669296ac0696-12781
From: Rajani Kantha <681739313@139.com>
To: razor@blackwall.org,
	toke@redhat.com,
	liuhangbin@gmail.com,
	kuba@kernel.org,
	wangliang74@huawei.com,
	joamaki@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6 1/2] bonding: return detailed error when loading native XDP fails
Date: Fri, 28 Nov 2025 17:26:17 +0800
Message-Id: <20251128092618.1861-2-681739313@139.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251128092618.1861-1-681739313@139.com>
References: <20251128092618.1861-1-681739313@139.com>
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
index 9aa328b958be..5c314d1d934f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5622,8 +5622,11 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 
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



