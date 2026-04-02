Return-Path: <stable+bounces-233082-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO8AMu6pzmkgpQYAu9opvQ
	(envelope-from <stable+bounces-233082-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 19:39:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2565738CA16
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 19:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D66B304AD96
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 17:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D34E30C601;
	Thu,  2 Apr 2026 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkahzDFt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44071F0E25;
	Thu,  2 Apr 2026 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151387; cv=none; b=iC4BMN+KeuKx863tLG8YNyaAIboyxpzbT2DPM4Y99lq+VhR7Oh9MOa5/whDbtIndoOhozjM2bztqqN2wqXb0Vk3ptkx74RB4TnUs7vSTslBfUuLI48+4dv6Bn7GNE9dUpqCsK3FQ4D/Q4Ak5yFcgRyKbGg6iFWbLy/ZG9UUupYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151387; c=relaxed/simple;
	bh=PSgkDJkeZhMmhWglvorZxNY2NC5HOwwTuIkE2PddNnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQ2KVfoXzWxtzSUaWU51B1jEfqCvCmWYdQglSN9jeIHhMqCMRs+X6V+ydFrA10HOToCJx6BpKhNhZV+lTGU+5E6OzGikLY10XydUfkqReNTfRnFkdrHxIKwrZW8q1e0+0RSFHwQME7IbAKEVlfdcTyOZPbNJgR8w42yEDjEYxgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkahzDFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B096C116C6;
	Thu,  2 Apr 2026 17:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775151387;
	bh=PSgkDJkeZhMmhWglvorZxNY2NC5HOwwTuIkE2PddNnA=;
	h=From:To:Cc:Subject:Date:From;
	b=PkahzDFtaB4ZMQB7jrmPtShDMHc5pkMpVDeUgVik+rKJS3acABzOcP/0uBA/kpKzX
	 +0qRtrlZmNElAuxdX6WVKmy64T0n7Ba8Jzag573Zfy/kahAFhfchwWxmGLmqDBdcWz
	 Ojr9W3m7WHcmQDf8QDwCVfv21HKj0gF3tI2E7Y0rns2A+4DThdDN4L9jzFWgr1mETB
	 q4S/cfCwcqq7Lvlyhbg55hyyxVhoPLttdSGnkg9LRqgmJB9tYRvAIGpPzDHkl800hz
	 e2NP5J9179T50oY4LG8gtcWEomjsuexVqPDRja8XXMSNEaYB1oFWEbE3Ww0XbtrVRk
	 gGS/eFaC8G1+Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Li Xiasong <lixiasong1@huawei.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] MPTCP: fix lock class name family in pm_nl_create_listen_socket
Date: Thu,  2 Apr 2026 19:36:17 +0200
Message-ID: <20260402173616.3331064-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1483; i=matttbe@kernel.org; h=from:subject; bh=vS9H9xHqIUOIXyXZKbTchtWE7NAzMuAod/TwFoJBI5E=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLPrRQ8brEmz/rFBM9Vi3n//dhhHLhZQTtsc+Osbvsug zNzeI6zdJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEykWJCR4duu+qNcsddeT6/2 Uwlbcsrqzx2PnCRjxoQes9z3bifbtzH89428sO6l0b0risqVfwMv33TriPgQZLjQanmSV5CvXsw 8dgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233082-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,huawei.com:email]
X-Rspamd-Queue-Id: 2565738CA16
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
index 91aaf4bd43ea..269e95c8415f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1189,7 +1189,7 @@ static struct lock_class_key mptcp_keys[2];
 static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 					    struct mptcp_pm_addr_entry *entry)
 {
-	bool is_ipv6 = sk->sk_family == AF_INET6;
+	bool is_ipv6 = entry->addr.family == AF_INET6;
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
 	struct sock *newsk, *ssk;
-- 
2.53.0


