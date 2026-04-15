Return-Path: <stable+bounces-238069-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOT0CPJW32n1RwAAu9opvQ
	(envelope-from <stable+bounces-238069-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:14:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C9C4026E4
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B57693041D63
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 09:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01DB2BEC34;
	Wed, 15 Apr 2026 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="Mo7/eRCe"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C786B313537
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244367; cv=none; b=dupDD+nm6zKQJwShF6D3VhbPb3d51FTqDSFRLux3ErRB8/+25tNVCkZq6P0quWpJKI4cvb7JUy4WhXKtrCreSLLGActrujO4m6pFlFm+pgMmUXSd3Ofc2bZmNE2jB9mUwR/lp8hyUgqimX+pZ7R93048a5GX4x+3AUv+T3ZestM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244367; c=relaxed/simple;
	bh=34Lm3dgriUNV10LwFqZUJ9vo+UkjLbrwLyB0levZg4M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAqyz6Iqg70QkWOB+KnPMdba0vRAXkJOhwtw9NruWX952I7/kap0MtOqA/ZYL8XgIDZpcbbhSkqc9bEL0OeYamMfDEteRcACj/WYKOYWnpAMvLgRwsXXwEFndrUP/Zv0ih4O3Ie8zgTCLlv25Yt5tWAK9VTmaJSu8d1qDvIdHyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=Mo7/eRCe; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Mo7/eRCeghUDs2MBNoc/5hFQPUvjIoku/5D5J0CeOTXkx+tlgBBpZitmjPy+JBxlSkq50ApVxdK6a
	 D0QhryzwDj/Ahfq1+DXTKd6+sgP5VDgO49HsQa7BQmGZ3zI9HSPGW/P7jl2gzq5BjzeEEjjOqafeha
	 aGVeGRy030esIsuk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[223.104.41.126])
	by rmsmtp-lg-appmail-09-12087 (RichMail) with SMTP id 2f3769df5680d70-028ad;
	Wed, 15 Apr 2026 17:12:37 +0800 (CST)
X-RM-TRANSID:2f3769df5680d70-028ad
From: Rajani Kantha <681739313@139.com>
To: liuhangbin@gmail.com,
	razor@blackwall.org,
	toke@redhat.com,
	kuba@kernel.org,
	wangliang74@huawei.com,
	joamaki@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 6.1.y 1/2] bonding: return detailed error when loading native XDP fails
Date: Wed, 15 Apr 2026 17:12:31 +0800
Message-Id: <20260415091232.3244-2-681739313@139.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20260415091232.3244-1-681739313@139.com>
References: <20260415091232.3244-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238069-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,blackwall.org,redhat.com,kernel.org,huawei.com,vger.kernel.org];
	DMARC_NA(0.00)[139.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[681739313@139.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	NEURAL_HAM(-0.00)[-0.934];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[139.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,139.com:mid,139.com:email,blackwall.org:email]
X-Rspamd-Queue-Id: 02C9C4026E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 7fe7485fbb16..c6b4f681c70d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5636,8 +5636,11 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 
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
2.35.3



