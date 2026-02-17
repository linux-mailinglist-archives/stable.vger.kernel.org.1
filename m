Return-Path: <stable+bounces-216987-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FobDxLTlGmfIAIAu9opvQ
	(envelope-from <stable+bounces-216987-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:44:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E10931502A7
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 507BA3005591
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583E7378830;
	Tue, 17 Feb 2026 20:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u1tmR58s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0E43783CF;
	Tue, 17 Feb 2026 20:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361038; cv=none; b=U3KMypXUyhazws6wxl/PFmXvhJFB3NuN+yRsB4328TUCZmawXjViyAJWYsITH7a0IOZ2XFzYAoxRK01SgzwtyeBnw4g2GYFZ1ix/Ng9ilV0lDzuV30IjHgowFO7uhcg/Svv64dLjsSKp2nm8WT+qja1ORekTxsyncdldPhbzsRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361038; c=relaxed/simple;
	bh=2SQMWTfzJck1d9ZeXXc6I//KDaqGCU5XFhEe5drB+eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwmfg3auLhuOPI1CmP49gCMbENcMV0wFhCAdVA4Jforu7OyVxGsOxWYCGANyB4C3SqWZB3OOZRFR3BqcBc8S3v9Mv4uHLdqI7Ce7ykc62azviCtFyJhBkaR7wBQH2uLEiGrJxx7EoVo3uh+tD+GHaB8aQ3ox8dNUvVkinscHAgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u1tmR58s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81ED2C4CEF7;
	Tue, 17 Feb 2026 20:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361038;
	bh=2SQMWTfzJck1d9ZeXXc6I//KDaqGCU5XFhEe5drB+eU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u1tmR58sKhYCt0gpadfB2dqTpPp5+/vmif5ArhXjUzTrSEgJC0xyEA8sbOjiuFEno
	 G3ZaGdoshH3zF6PX2b+3JstF5Z5RZ4ZLWQB92ftU/k06mtXeX6STnjLVqwoz+8vWOH
	 /KpIVZzyazSsQqBReRXeEmbO/il0HDZhu3bHo1Rc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com,
	Eulgyu Kim <eulgyukim@snu.ac.kr>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 22/39] mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()
Date: Tue, 17 Feb 2026 21:31:31 +0100
Message-ID: <20260217200003.785026394@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200002.929083107@linuxfoundation.org>
References: <20260217200002.929083107@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216987-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,5498a510ff9de39d37da];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,appspotmail.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,free_list.next:url]
X-Rspamd-Queue-Id: E10931502A7
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1656,16 +1656,26 @@ static void __reset_counters(struct pm_n
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



