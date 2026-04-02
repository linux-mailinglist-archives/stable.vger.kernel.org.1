Return-Path: <stable+bounces-233083-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCfONS2rzmkgpQYAu9opvQ
	(envelope-from <stable+bounces-233083-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 19:45:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C1B38CAEF
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 19:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFBD030F0ACE
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 17:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2F63F0AB1;
	Thu,  2 Apr 2026 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0O03JfO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC1336F40C;
	Thu,  2 Apr 2026 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151556; cv=none; b=GHysDjllcKYA/Czf4mLrK8yTp6U7Co+XURC92mqPuLR6E9dgQON1iPyRu7G2lCss+I358PqBHeZddVe0c/JukTyYMNmvbDYRdwVoPJcm3lAo4RAb6FrINqPNnU847Twf+RwOf7Arz2p+wTRQapxqlOjiTXwpVG+yGmMcfgXdst8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151556; c=relaxed/simple;
	bh=5Lo2pZBp8DRj5ymhR2VNlMfCWFu5xTE6bY8ModPE4Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UivOpUSN9EJxxPeq4sNorzLzWEBqUxohlZ4HJJ2K3KHQOlgIn7BVN3Zc0AqPvVmxbQmo9uekdApaEhnU2WbBDkNCMJbjIzr0qId9CtiE7nFVcfZ2nRb3B/S/kleLRKXd5F7bN0OGV4Fp2BVXYv68s+0nkjnUKfRoO8+xv/KaKV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0O03JfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8A0C116C6;
	Thu,  2 Apr 2026 17:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775151555;
	bh=5Lo2pZBp8DRj5ymhR2VNlMfCWFu5xTE6bY8ModPE4Gs=;
	h=From:To:Cc:Subject:Date:From;
	b=Y0O03JfOt8wipsvwN65SPYO72GmD2OuQJbCgQINRz0TaJ/EFaJ1rv3t1S1Ab3gRCO
	 AzabyziLQvABymxK0JNGQqXTN8NcLSsfozWedikTdUN9+XalWiKn+pe4nRzKpIyxZ/
	 RHb6NSrI3snHTSuPsnPWuH7eaD9FVo3ACEgrqG1p+tWqX9RXs1EVoBovPoFwFFH6kr
	 3hBlV1ZnoEQRctEgh++zBBxeH0Mq2IZ4pMU7vUL1lz3/Nt1I8tFlwkALPNZCX2V3OJ
	 DMGcbHXavnmEIpfPSoOWUN0DorlKeGFxMlA+EblnGqhSoMLoVYmPE+ghg75R8gkMBD
	 1/Cm8ENfDTBHQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Li Xiasong <lixiasong1@huawei.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] MPTCP: fix lock class name family in pm_nl_create_listen_socket
Date: Thu,  2 Apr 2026 19:39:08 +0200
Message-ID: <20260402173907.3408529-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479; i=matttbe@kernel.org; h=from:subject; bh=lgXVEg5WDiRgJUR7mWu5I3fljHJc0h+9IcxEN0jIKi8=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLPrdw9d3+sf53ivzNC0TOiO6LC3iTtM7LbvmfmhcnFE TbmiQWcHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNJUGRk6H/U9omF//67PHUf 8/rsFMYP3dpnap6ceeFcKeZ3paMqlZFhebnfds0u7r3bd3I9Xxysf7qvo2OpzpUv/u7ffFeLvt7 NAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233083-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,huawei.com:email]
X-Rspamd-Queue-Id: 52C1B38CAEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Li Xiasong <lixiasong1@huawei.com>

commit 7ab4a7c5d969642782b8a5b608da0dd02aa9f229 upstream.

In mptcp_pm_nl_create_listen_socket(), use entry->addr.family
instead of sk->sk_family for lock class setup. The 'sk' parameter
is a netlink socket, not the MPTCP subflow socket being created.

Fixes: cee4034a3db1 ("mptcp: fix lockdep false positive in mptcp_pm_nl_create_listen_socket()")
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260319112159.3118874-1-lixiasong1@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflict in pm_kernel.c, because commit 8617e85e04bd ("mptcp: pm:
  split in-kernel PM specific code") is not in this version, and moves
  code from pm_netlink.c to pm_kernel.c. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5d8dada1dbbb..92ca81a5df67 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1184,7 +1184,7 @@ static struct lock_class_key mptcp_keys[2];
 static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 					    struct mptcp_pm_addr_entry *entry)
 {
-	bool is_ipv6 = sk->sk_family == AF_INET6;
+	bool is_ipv6 = entry->addr.family == AF_INET6;
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
 	struct socket *ssock;
-- 
2.53.0


