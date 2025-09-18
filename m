Return-Path: <stable+bounces-170120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12278B2A2F9
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD8C174F90
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490D631CA57;
	Mon, 18 Aug 2025 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vJusCMCY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00198320CC1;
	Mon, 18 Aug 2025 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521581; cv=none; b=e1jVhtv/imq4a+ZVgszkH8H1WV057YG/nZqBnjG+o4dnklTnooCxNr4I41+HI4cRSQfL4shrgKEcO/JF8sJUhfjPs/xU4o7WlPQQBY3EkE86uRc2OhSzwcvZ6DCcm6ZzrpKqSPHaDtrm3WcUKFcD7rtmxpnAnyQ9GdccqSXS4vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521581; c=relaxed/simple;
	bh=4+07oK+ByDtC4M1uEoKJaZIIrvRrld3Mk1l/fEdYlQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfQn7IEo1VjIKF3kkA24w7DlvbIKRfy3Ox80YfNhNBxtaHPznZ2I57e4PsS+7Lc2ERYMSlGf+ISIG4IQlJC7kWBOnh06wctjLYfbJZoj+utvBavjkvQpNmAoHCip+Yr5WHm9O7qxTEMgrgL17FGduoHu1zEHBdLj1rssMiL6H9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vJusCMCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6394FC4CEEB;
	Mon, 18 Aug 2025 12:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755521580;
	bh=4+07oK+ByDtC4M1uEoKJaZIIrvRrld3Mk1l/fEdYlQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vJusCMCYqAvbdwJj9DdwGGMogVWphCAjhLdUraTkRxMP7fgBhoW9XXvEcjzokUzeh
	 pKKzA4mig6y/JWo7lyXovRkQhJr/MY2c2oGo+5Vz8pCuVVpVTHR3rGHj6xcUifiPJd
	 kNjOekeO2XSx6dVfABXWz80nPI1Xtlh6vUZIhZWk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+e62c9db591c30e174662@syzkaller.appspotmail.com,
	syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com,
	syzbot+be6b1fdfeae512726b4e@syzkaller.appspotmail.com,
	Sven Stegemann <sven@stegemann.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 063/444] net: kcm: Fix race condition in kcm_unattach()
Date: Mon, 18 Aug 2025 14:41:29 +0200
Message-ID: <20250818124451.309676406@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Stegemann <sven@stegemann.de>

[ Upstream commit 52565a935213cd6a8662ddb8efe5b4219343a25d ]

syzbot found a race condition when kcm_unattach(psock)
and kcm_release(kcm) are executed at the same time.

kcm_unattach() is missing a check of the flag
kcm->tx_stopped before calling queue_work().

If the kcm has a reserved psock, kcm_unattach() might get executed
between cancel_work_sync() and unreserve_psock() in kcm_release(),
requeuing kcm->tx_work right before kcm gets freed in kcm_done().

Remove kcm->tx_stopped and replace it by the less
error-prone disable_work_sync().

Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Reported-by: syzbot+e62c9db591c30e174662@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e62c9db591c30e174662
Reported-by: syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d199b52665b6c3069b94
Reported-by: syzbot+be6b1fdfeae512726b4e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=be6b1fdfeae512726b4e
Signed-off-by: Sven Stegemann <sven@stegemann.de>
Link: https://patch.msgid.link/20250812191810.27777-1-sven@stegemann.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/kcm.h |  1 -
 net/kcm/kcmsock.c | 10 ++--------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/include/net/kcm.h b/include/net/kcm.h
index 441e993be634..d9c35e71ecea 100644
--- a/include/net/kcm.h
+++ b/include/net/kcm.h
@@ -71,7 +71,6 @@ struct kcm_sock {
 	struct list_head wait_psock_list;
 	struct sk_buff *seq_skb;
 	struct mutex tx_mutex;
-	u32 tx_stopped : 1;
 
 	/* Don't use bit fields here, these are set under different locks */
 	bool tx_wait;
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index d4118c796290..1d37b26ea2ef 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -429,7 +429,7 @@ static void psock_write_space(struct sock *sk)
 
 	/* Check if the socket is reserved so someone is waiting for sending. */
 	kcm = psock->tx_kcm;
-	if (kcm && !unlikely(kcm->tx_stopped))
+	if (kcm)
 		queue_work(kcm_wq, &kcm->tx_work);
 
 	spin_unlock_bh(&mux->lock);
@@ -1696,12 +1696,6 @@ static int kcm_release(struct socket *sock)
 	 */
 	__skb_queue_purge(&sk->sk_write_queue);
 
-	/* Set tx_stopped. This is checked when psock is bound to a kcm and we
-	 * get a writespace callback. This prevents further work being queued
-	 * from the callback (unbinding the psock occurs after canceling work.
-	 */
-	kcm->tx_stopped = 1;
-
 	release_sock(sk);
 
 	spin_lock_bh(&mux->lock);
@@ -1717,7 +1711,7 @@ static int kcm_release(struct socket *sock)
 	/* Cancel work. After this point there should be no outside references
 	 * to the kcm socket.
 	 */
-	cancel_work_sync(&kcm->tx_work);
+	disable_work_sync(&kcm->tx_work);
 
 	lock_sock(sk);
 	psock = kcm->tx_psock;
-- 
2.50.1




