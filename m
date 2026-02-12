Return-Path: <stable+bounces-215984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHp1KfYQjmkM/AAAu9opvQ
	(envelope-from <stable+bounces-215984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 18:42:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E75130061
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 18:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E9E4304E70D
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 17:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F023BB40;
	Thu, 12 Feb 2026 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNnjDk/j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ED41E9B3F;
	Thu, 12 Feb 2026 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770918120; cv=none; b=rs6AAy/1L7zP/lj0YkqvJZegZRwNhWamk99N/BOkBbjqtKi0ODjnrYr/Q7MqeHZGic41p8jb9yL5NG9zd7wio7LNDjrIpbKG0Sb/5N+QaL6dVielKYQ+7HJPXnkK2LMZb+EgbUW9iFFye0M8VAJNLEr9qn2+tYL25QICsEZ1wEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770918120; c=relaxed/simple;
	bh=ZkFiNws2RQdpDs8XLBZhVq8Fo3BvVximS2v1wPpiquU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qKmR2SV7RRNQ3Psbe5/9Jh+5FqLmBXJzRGjC0Q9nGejaZgribTkOmPgBy8rP/CHE88xETg1XhFPYRNSkJXZQMipThCZw/BQwADDu0a9Hwq/2DPt4h6hejYJmlRk+8os9XYLdf3QZA2lP6JFoe/eGo1BJlXO3+rQa5gwx+Qm4XiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNnjDk/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC40C16AAE;
	Thu, 12 Feb 2026 17:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770918120;
	bh=ZkFiNws2RQdpDs8XLBZhVq8Fo3BvVximS2v1wPpiquU=;
	h=From:To:Cc:Subject:Date:From;
	b=rNnjDk/jujuJcfxoLXVxMvdhV6l5i3yDIn2JNRHwTeZch4JT8TiNxe9RfO0H/2dPp
	 Na49stBTtXmuVOF98l3LtqopsWLwuUgawshUOFsOjRbOx+tUu1/NNQ/mqq0DejBuA5
	 0r9BtA9sNhtIO8rnJ01qeumqm/dqBMJmfo8CaaR9lbFCEvJkeBtTsSAsQGJls50Fau
	 VhO9pIYcb5MRIn+CoAe1x1l9UNWoJ5zCV+9iNsGBvLPCYS67eCkqlICHu15l051/0p
	 dK+lUomCc+za6n2E4+gyv6OvPJ2qJ0PiesAPrlFsfTtkCDhCoxHfFJd7eAWF0+/TyA
	 lZ0O0UH9ObT5Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com,
	Eulgyu Kim <eulgyukim@snu.ac.kr>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()
Date: Thu, 12 Feb 2026 18:41:47 +0100
Message-ID: <20260212174146.1841030-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3183; i=matttbe@kernel.org; h=from:subject; bh=On2kSmDCbLIbTazrBwMQSs2xFdKmS1BqxP5FB85aHsk=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL7BG4lf36ay5C0knnNulXlZ768PaMnNnH2HR3bhNd7P Q54Bxbd6ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhIVAojw0S3HJtlLVPXb72s deb/wh5zA2mZr/Lz8g1PSZXde8GSs4Lhv5/dyoUdCi7SUglWTS4cbw5cWrqndf8TvhknPz+1/st tww8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215984-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,5498a510ff9de39d37da];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,snu.ac.kr:email,msgid.link:url,free_list.next:url]
X-Rspamd-Queue-Id: 08E75130061
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

commit e2a9eeb69f7d4ca4cf4c70463af77664fdb6ab1d upstream.

syzbot and Eulgyu Kim reported crashes in mptcp_pm_nl_get_local_id()
and/or mptcp_pm_nl_is_backup()

Root cause is list_splice_init() in mptcp_pm_nl_flush_addrs_doit()
which is not RCU ready.

list_splice_init_rcu() can not be called here while holding pernet->lock
spinlock.

Many thanks to Eulgyu Kim for providing a repro and testing our patches.

Fixes: 141694df6573 ("mptcp: remove address when netlink flushes addrs")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6970a46d.a00a0220.3ad28e.5cf0.GAE@google.com/T/
Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/611
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260124-net-mptcp-race_nl_flush_addrs-v3-1-b2dc1b613e9d@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts because the code has been moved from pm_netlink.c to
  pm_kernel.c later on in commit 8617e85e04bd ("mptcp: pm: split
  in-kernel PM specific code"). The same modifications can be applied
  in pm_netlink.c with one exception, because 'pernet->local_addr_list'
  has been renamed to 'pernet->endp_list' in commit 35e71e43a56d
  ("mptcp: pm: in-kernel: rename 'local_addr_list' to 'endp_list'"). The
  previous name is then still being used in this version.
  Also, another conflict is caused by commit 7bcf4d8022f9 ("mptcp: pm:
  rename helpers linked to 'flush'") which is not in this version:
  mptcp_nl_remove_addrs_list() has been renamed to
  mptcp_nl_flush_addrs_list(). The previous name has then been kept. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e396adefea02..1c8aabce33a6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1656,16 +1656,26 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
 static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	LIST_HEAD(free_list);
+	struct list_head free_list;
 
 	spin_lock_bh(&pernet->lock);
-	list_splice_init(&pernet->local_addr_list, &free_list);
+	free_list = pernet->local_addr_list;
+	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
 	__reset_counters(pernet);
 	pernet->next_id = 1;
 	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
 	spin_unlock_bh(&pernet->lock);
-	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
+
+	if (free_list.next == &pernet->local_addr_list)
+		return 0;
+
 	synchronize_rcu();
+
+	/* Adjust the pointers to free_list instead of pernet->local_addr_list */
+	free_list.prev->next = &free_list;
+	free_list.next->prev = &free_list;
+
+	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
 	__flush_addrs(&free_list);
 	return 0;
 }
-- 
2.51.0


