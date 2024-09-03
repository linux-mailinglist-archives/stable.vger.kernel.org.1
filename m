Return-Path: <stable+bounces-72799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4D89699E4
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D004528372F
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0C21AD249;
	Tue,  3 Sep 2024 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spedT5mw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E9645003;
	Tue,  3 Sep 2024 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358622; cv=none; b=FXFZhejOOuOsSlHc8K6KzazmIReXCk9hi7oBQADHMvTb1TchSnu2NRqQryGGYgM/SoRNb6Z67de9RMcdKIXDJtnkUddojwPN4w5e/AZpbpOQBuAzmGfD1T7IT3BrhmG3BiJ1YEZcWupcGRvode/UUplS79arQNyl6lF4NCqR0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358622; c=relaxed/simple;
	bh=uYK0205hKRLrPQ+eEBOmJLuw3pivN/IYQljGnJA4NVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLEYEhNhC4QxiFtuPbQ9lI2g8bKA93q1WnwKlTCGga14a1m0ZTl0vkmaZrEnogeDNx87v6qaXY7L5edwtgiFNrvFF9PhMZ68RwsryPD84FP8m591jOtWFN7LspfYO3rA0Nkn7XENI1lUZiKDQv/Eh/tBWrRFDzY+4mcfBk5D92s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spedT5mw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE7CC4CEC4;
	Tue,  3 Sep 2024 10:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725358621;
	bh=uYK0205hKRLrPQ+eEBOmJLuw3pivN/IYQljGnJA4NVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=spedT5mwXG+Ftq5wFjuz8bUbIHNrzc5pU2el8oEegHPOQ7lde32cNFxhAfCq6ELqM
	 fV6s2upepzh9uttSALjVOnN9s1bKkDa2IsWSWyWLpmu8XSCvYoIxskOjClithwxDtE
	 LkHulEJdMdQbGCCu2fauAKOHY6JTWu2feoT5AE2axhsamfXa2uRvzvR4UCZ0ymcxGy
	 FFAdn4wKe1TxSzg4XwDpnImmx3iN2hhRL7Vn/em44r0qvv2w9pnXldFHwGxF/oSMjU
	 7UIpEb+22wGll4wM2iW82BZJj/BbOrKk8rJkeYW4oyaK9/WghqdG3KT1Cy+Fn0EWJJ
	 piJfAkTkevvKQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.6.y 1/2] mptcp: make pm_remove_addrs_and_subflows static
Date: Tue,  3 Sep 2024 12:16:56 +0200
Message-ID: <20240903101654.3376356-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083044-banked-tapered-91df@gregkh>
References: <2024083044-banked-tapered-91df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063; i=matttbe@kernel.org; h=from:subject; bh=PUHHivcwFVptFcvNWpuHApfb3OeOiYvxwfM9LG/7xL0=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1uIWsDZObPTsdiTMDTRB08f5oAhIRGPXHK1z5 WVAW0LH/RCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtbiFgAKCRD2t4JPQmmg cw6FD/9swIC+SbgigHTuUI88RGEbOphUUBu1UjDdzv3RhNLO5Ga6A1fKUUZ7IHBB4A5oNWmEXfH 1dl2KJ/ki5hjuH2lC9d+Q1t26DOQVUYEYlwocAFO2yv+UDdhxm8WYfcyjV5+UEK+m2MCo2fLNfZ qlM/ZtmQ18bx1LIeEvlUmah9u9HqxGZCUCDuLCqwB/N/YQgtrLtYs12bbGRvM4VANzP+X09P8tR imEWhUEtiOPuNFL0Y+qDLULntSoyDarfq66+p2po3fXEyi8ALTS+aXW5uupIp5C05yCrcQLhl+v aG0hXNJr0ewpuMg8iUt1lB1ykL68odaJ4IyCmveRaBfEHdUbS2Ga41XZiqnZGGdeCy92px9d18a jCb+AwbRJGnp1qbet8s/tHSND+U69EW7edGe0nV5SHidt1w52jwYk9ipo4v0rqKr0q2v0PQ1QdM G9vpuyl3s5JUxn7alS182I9p0wDnpnZco8lSqs0Q4KRLxXKuoWLrsM1daHZv3Fw2ZJw4hlH28CQ uRB5Gn6691zNnwBvtcatdgZUCBYmeNFOaNOgxfzoZnQqTASOA1d1Z0pS17ibHd3mAmUfCJdo8VE tiB/8wsAGHr/eZfalEtLJir3uusoCIu0cCDIH7gftu+P9gSqA5Z0o1wF3/FR7d7Kd/yzUaHOLt3 Xbn04UFF+oKLy3w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

commit e38b117d7f3b4a5d810f6d0069ad0f643e503796 upstream.

mptcp_pm_remove_addrs_and_subflows() is only used in pm_netlink.c, it's
no longer used in pm_userspace.c any more since the commit 8b1c94da1e48
("mptcp: only send RM_ADDR in nl_cmd_remove"). So this patch changes it
to a static function.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 87b5896f3f78 ("mptcp: pm: fix RM_ADDR ID for the initial subflow")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 4 ++--
 net/mptcp/protocol.h   | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index aff41beb4dab..fa4668c2d6b3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1701,8 +1701,8 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	}
 }
 
-void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
-					struct list_head *rm_list)
+static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
+					       struct list_head *rm_list)
 {
 	struct mptcp_rm_list alist = { .nr = 0 }, slist = { .nr = 0 };
 	struct mptcp_pm_addr_entry *entry;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8996cd6b6820..ecbea95970f6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -948,8 +948,6 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
-void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
-					struct list_head *rm_list);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info);
-- 
2.45.2


