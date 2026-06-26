Return-Path: <stable+bounces-268701-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jaSTFVfVPWrC6wgAu9opvQ
	(envelope-from <stable+bounces-268701-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 03:26:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D7D6C96E6
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 03:26:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=kptfRmdQ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268701-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268701-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01091304480F
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 01:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA7A2D8385;
	Fri, 26 Jun 2026 01:26:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94CE2C0298;
	Fri, 26 Jun 2026 01:26:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782437199; cv=none; b=H0NHaHTlzgSo4VnWyIBJ/pcSK9nosGCNTwbVu5FfLMHxmhJ+X/25JRcUKSrD9+avSHYxUK3ch97IU0hId691yCH+x/XuIp2EgP7R0U3MNJDYwuai89lBeL2Ba5ic3mVM6fud4KriK/tygHxW++YGy/6ptJY+zyRo3znC4D1sF94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782437199; c=relaxed/simple;
	bh=EbanJLEkyKpqzNMcQRNX2b8jby7wLfju2brKwC8PAec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=elYn4bOb0p9lpETPSpqOB9t1qflKhqq+F0ABockfXHf3vAo4kDkUwjiPd6AhvE9wmrNvNjiGbiZqAJDyJocMtzw5In8+uJSXLRa4j9DlEmFZx7DzbtRVvQyPKuqjNQG+s1IIVFFMvkbk8ayNkmfoWpL/QUz2XglgJAJ4oZpTcz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=kptfRmdQ; arc=none smtp.client-ip=43.155.80.173
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782437131;
	bh=3fXfBwENMmiz90XicVnuAoBPRhmDgrRJrDZrB+n21oU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=kptfRmdQQNMnuMYVsUrNCkVP4jkE2cAq6d4r7SPXrflg1rtQgbfNQmfIYU/H8TU2x
	 lxhx9f9nFdWPEcPtG3q5bdNSIQGHdb7nCVmfTxivFmE+4/MleBhXYvnOVVA3/zgWFz
	 a5x9Wq9dkDdFG9Z4QuLqPCxXLcvtVd846xAr24IA=
X-QQ-mid: esmtpgz10t1782437126t9549af7a
X-QQ-Originating-IP: /zeSQLUbbqHxJ4yuDgl62zoM2AdNb6AjNn+62Ll7Avg=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jun 2026 09:25:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12274750682708982893
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: miquel.raynal@bootlin.com
Cc: richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mtd: virt-concat: free duplicate generated name
Date: Fri, 26 Jun 2026 09:25:22 +0800
Message-ID: <363FB8CFA79EDF5F+20260626012522.3683748-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MBN1Gf7pvZQZVd/KoRNNiG4aCzL/sp7zK9B9eClFIZR0gz3VD13HSySo
	UT92DnRc78Q/q0D7IPly4nyimAUW7dg5ZM/jQyDcxZieaTzd5Qq4czynEeqhC+rMK+44d2G
	DhqO8w00s3IdVeHEYKrjtYGGue3HzR+vJKwxEPauOdq6EkDKSce9JhXMjtqIw6aNuM18WFj
	z6JwsyQGruoWspyjwarQR1bbkti2wKjYyIwHK2D6kFA7Xx/bmcl7UF09PJUIgtKUmk0ZIFQ
	WcQMS282pQCU3/Ad1Jvr6K2jrKkFaJ7nyHgJo+HXz2qa3iyR1GCRPKfkTvuFAghmYg4zgmx
	D0pn0qAEIDYf+Pl079s5CrJYiZPdVK5I5TSuu0d15Lyf+pXHZ8xL94diRn6NutCyisSxiTu
	vyWbWuSlMsMNlM22kFmd2/Lhq6IWrlBz3ecK/FPHKds+FCiKDGQOBJbl0Ew0kahVKzvEwPP
	qaGH5xefM2K66pLK3dxffx7XAgnAAF5eJb9poqkIKIhqkr2bZScE7ovxL2lM69qOETHJPKw
	mmdVXXnSaGiPrvhoDpP36CCEW0exFaAxUaQ5C5n4HkSXEn2B2ThPKoRPccXEsNjJDxsAuVQ
	UjE+4E664AOacEalMJQ7QYs1QMtkxe73fBkpHbM6/Ibp8O6MstR317n4ZmjQNti4C3+3egf
	YXnDHDvtyLiSpgcNhSKcSBVUw14i4O7a5g446LzNzps2qmOjnFE+TKxwbpfgwtXIWai4bdl
	B0rTeFtml2tjQWAOGEwDJZaFQFzr0CQFdvvG/NcahJQca/F+LhoKbZjiw64ekFq2Lv8IvRI
	xo9RAI3t1ZwnF1lzLnsLDA5VDC/EM2A+bEcYaAOY/OUP9I23DbnucqvviR4spX2YMDAVFSu
	r4KvLDxaZa5yztSSFsb55vjKZDPpaSZPCYK+ei+mMv6VZaq/49WiUgdibn/xchA6Bhgz/5X
	kQT5XPfEVhmwO2emX9j5XHyzmP+9SebR+Di3tt7EHrZ5V4YlYBwhnWKPq5v7NdGErO9yIKz
	k/6KsexE7sLjNboipHQv46D0kW5qTdEt55vkz9lrdEZsNeBwKk
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268701-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:linux-mtd@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:raoxu@uniontech.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[raoxu@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raoxu@uniontech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5D7D6C96E6

From: Xu Rao <raoxu@uniontech.com>

Every MTD registration runs mtd_virt_concat_create_join().  Once a
virtual concat has already been registered, the function builds the same
name again and takes the equal-name branch.  That branch skips to the
next item without freeing the newly allocated string.

Free the temporary name before continuing.

Fixes: 43db6366fc2d ("mtd: Add driver for concatenating devices")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/mtd/mtd_virt_concat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtd_virt_concat.c b/drivers/mtd/mtd_virt_concat.c
index 37075ea..5db6e64 100644
--- a/drivers/mtd/mtd_virt_concat.c
+++ b/drivers/mtd/mtd_virt_concat.c
@@ -321,8 +321,10 @@ int mtd_virt_concat_create_join(void)
 
 			if (concat->mtd.name) {
 				ret = memcmp(concat->mtd.name, name, name_sz);
-				if (ret == 0)
+				if (ret == 0) {
+					kfree(name);
 					continue;
+				}
 			}
 			mtd = mtd_concat_create(concat->subdev, concat->num_subdev, name);
 			if (!mtd) {

