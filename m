Return-Path: <stable+bounces-272604-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XwhbJ28dTmoHDgIAu9opvQ
	(envelope-from <stable+bounces-272604-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 11:50:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA41723E4C
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 11:50:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b="Vqr/0Gbe";
	dmarc=pass (policy=none) header.from=uniontech.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272604-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272604-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94C0430264FA
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 09:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEA931D757;
	Wed,  8 Jul 2026 09:49:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA321F130B
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 09:49:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504171; cv=none; b=i/3Y5tCaD5d5ZYmU2/yq+jZCm7Gq/Zd75i5oaOlPm7E9vxTqIg8fEgNMcXD7oKl9LJrN7z3H4HPD3gzF2bYrkeipjEur3HnzeA5vrsp7Q4Kokc3W0vrqQ4kw0PDxKFWP7aNy7NHOOZc+vDyulET7yoELsgJV/qZY5sVqzbpLYx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504171; c=relaxed/simple;
	bh=FF44kqTDfVUFxHg9EYFd2Pz2EhO3TCToB9VJbVEuTQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mOX8GMhvc4D6DdBUBsOPx3Wc2D+aKQZYX/q31J115UGwaQZVCOEcvBa5aP2AMT+8ABwnxy0+svQq1GwKFcYvNDdlSQxnaFYQ8vTl2wbe03HNgw0U/2HECA8FUs6q3wenMtswR9zYN1N2NinS6XvCKYboQFCNuL6YdrZ8rdpszQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Vqr/0Gbe; arc=none smtp.client-ip=52.59.177.22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783504086;
	bh=2a3ZLqPBvZDVtawq0cVQbtmHfF2UJfaGQSoSNsHEYk4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Vqr/0Gbew/VqW7e49JIX2RgfBmUctf2of19EwNJLuRfDFAy6BbuYPU72UkoNJsAiZ
	 nXOTyG233sDR8NUOW9nuX6Iv+uOipdWk2hDXBzp4YHtv/7crGSPGOFacY3ex4rcdSn
	 shVhPnVsBhUfjqEyOIPCKug1C6EGhsPpDLgFgMzM=
X-QQ-mid: zesmtpgz3t1783504080ta3c8fd61
X-QQ-Originating-IP: yuh2E71A8T01Lx1Ov40dE06pghTaDM2LIlF36J2bePU=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Jul 2026 17:47:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9541104624205774073
EX-QQ-RecipientCnt: 10
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@idosch.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6.y 02/11] net, team, bonding: Add netdev_base_features helper
Date: Wed,  8 Jul 2026 17:47:04 +0800
Message-Id: <20260708094710.27047-3-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260708094710.27047-1-guanwentao@uniontech.com>
References: <20260708094710.27047-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: ORKp4oz66c+QYO4cgFvVhGymJA2GL8UqQa9IwTzNs3wjR+uLxrMhVd59
	vh4Ctew7gVQl+VurlAAuNLGiafqYzWke+RaTJhQJB5pETzZw82DPawh5YfpW0El3XJm84GZ
	ahLtvcj2K0bfkrZkxq7V6w97Oe9DuFhbmKWhqrZ4A+96e0Ud6COWi6PU0hL1Vn0821uim3O
	rysXrGrlCCG3yHH0KmdeJ+8ux8WwmKpl7j5DirUhHzX4A91JI49jjLZTL0bZSr5+EvpsTnm
	zqTv6UPulQzXZRB4OlNehK4AD/D5OAWtlvrePeULPiBmtFEjsy0mYsgnOXfmsPmbhMYOTQm
	gQXrlJIeDuOYPioU1pE8Z7Y1EZoAm343tWSkbfx5uEz9MaMzyQ2nfwKcH1e/Q66p+Fvr8QW
	qu8MOsgDChoE1d7oB8wPoN692SOhrF4z/bgI6ZTvu7jOKipPKHdZAXHODJPskMpojuwEQ5a
	5x5dkxw4lIxmcrNAkTDIvpqYH1usKYTxmeIjJ5/49dpEwA2+Qlam+i7pXaGnUpbGj5gIxzr
	U57+nHGigp53RZj6EQ8eVmBedgTJMrgrvC58YuuOGrMGVNW+TNAvxPfoRXFnEceGFi62kFo
	mgsF9/+rUEdK50Tg2OjWIsPe6Cd89ivh9Aty1gFckeb0nUXYPw0MQGKNblhlKg3Xw99jJMz
	zYGhxE88HaePXUxRNYwFEjPV2ex5GMzgJoDT0wMOYOWVFBWQvldKTP9gZOdu0Iy/Oq0+30o
	wmyUR1QX+xNAr0oKoaS1WHcF6NgCDNBBgeEBTp2gPpvA19nh9s22eDqJCieLQIPq12sEewM
	EeUBDH19sIQPs0IIodlFXpJ3rndgBAV4XmwFk+DFCmT0I/uCEMgXPs78/93lSpvCHEm2b3/
	A57TYo4LZ+kACMyVrAdrER3+8MKs0rFV76aQUiwGXoi4oRxPxkvD+Ow+nMiYew/XsYhD9Bp
	te8fKv5AJYyvN1RW3Q3D44Hu4ToDaMqlONo8327Ja+73tkNtMUS74DYSIQIlIfgwwI4xTRA
	58G4K+sutofaW8FbIIpmd0w4j2VL0XAQW9rhjCUCD7DKA1XgzbGGBNGTLqCttKhaSK3MPB4
	DxylOnlnrjy5x1HLbUxCbtT5aSgy+lFw0cllFbIvy7JfrMMVZWIYuuoX2ccB0sqlw==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,iogearbox.net,blackwall.org,idosch.org,nvidia.com,gmail.com,redhat.com,uniontech.com];
	TAGGED_FROM(0.00)[bounces-272604-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:daniel@iogearbox.net,m:razor@blackwall.org,m:idosch@idosch.org,m:jiri@nvidia.com,m:liuhangbin@gmail.com,m:pabeni@redhat.com,m:guanwentao@uniontech.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,uniontech.com:from_mime,uniontech.com:email,uniontech.com:mid,uniontech.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3EA41723E4C

From: Daniel Borkmann <daniel@iogearbox.net>

Both bonding and team driver have logic to derive the base feature
flags before iterating over their slave devices to refine the set
via netdev_increment_features().

Add a small helper netdev_base_features() so this can be reused
instead of having it open-coded multiple times.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@idosch.org>
Cc: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/20241210141245.327886-1-daniel@iogearbox.net
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
(cherry picked from commit d2516c3a53705f783bb6868df0f4a2b977898a71)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/net/bonding/bond_main.c | 4 +---
 drivers/net/team/team_core.c    | 3 +--
 include/linux/netdev_features.h | 7 +++++++
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e57e1296da374..36277bcefe290 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1456,9 +1456,7 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 	struct slave *slave;
 
 	mask = features;
-
-	features &= ~NETIF_F_ONE_FOR_ALL;
-	features |= NETIF_F_ALL_FOR_ALL;
+	features = netdev_base_features(features);
 
 	bond_for_each_slave(bond, slave, iter) {
 		features = netdev_increment_features(features,
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index deb6eb3a240a0..5cd1807e11f79 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2026,8 +2026,7 @@ static netdev_features_t team_fix_features(struct net_device *dev,
 	netdev_features_t mask;
 
 	mask = features;
-	features &= ~NETIF_F_ONE_FOR_ALL;
-	features |= NETIF_F_ALL_FOR_ALL;
+	features = netdev_base_features(features);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(port, &team->port_list, list) {
diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 7c2d77d75a888..1b5ad57e7cbf5 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -261,4 +261,11 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 				 NETIF_F_GSO_UDP_TUNNEL |		\
 				 NETIF_F_GSO_UDP_TUNNEL_CSUM)
 
+static inline netdev_features_t netdev_base_features(netdev_features_t features)
+{
+	features &= ~NETIF_F_ONE_FOR_ALL;
+	features |= NETIF_F_ALL_FOR_ALL;
+	return features;
+}
+
 #endif	/* _LINUX_NETDEV_FEATURES_H */
-- 
2.30.2


