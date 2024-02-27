Return-Path: <stable+bounces-24485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AF48694B9
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316471F22B8F
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8734013DB9B;
	Tue, 27 Feb 2024 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0k3+l718"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4738813B2BA;
	Tue, 27 Feb 2024 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042135; cv=none; b=u2k3QPA4VUGUwyJIevj1lOxV8qecEkeReQt3oxFd8ePxfbo/b29TQVVBL86b9W1zFZdV9/Hd0JxVPtUoACH+CFf6h0P9UdEF4LpsOyLxojrUf0P4PqrVIsEUnPJbBcZkgIEkGU5gpfwoqpgO/O+60OUmXHjmDv+3KXPbFH+Vvgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042135; c=relaxed/simple;
	bh=5yvlYTvtS9d/sS/15KeSGPQQ2SXCGSlP1efKwCXYSsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0SaFNizDtRvBJ0IM4U+N4eIMMKHP4i5CSVx5vmJfDcBOxtJH8tkJJ8kKcufPSpiYhEVbpAG2HvV6e+HFG4nzDaIqRiPRJXck2RNlzCtI7V9QsZgOjj/mwR+d64DvB4oKFGtJ8j4H866U1mwD7YiRxa8dyVuHtQtU8ZNxBC4nbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0k3+l718; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC20C43399;
	Tue, 27 Feb 2024 13:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042135;
	bh=5yvlYTvtS9d/sS/15KeSGPQQ2SXCGSlP1efKwCXYSsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0k3+l718/BO0AEHgHh9W+mLYZcmPdt6NZovEdCD7IXHz80mAtVVK04kjwBRJr1CGb
	 ccoPLRukROiwWicPTocPg1ByM6Q6W/8hUpYfd0+7BfRuZ7NfjH1z8uYg84L6edJKmz
	 NTZceT0sbKY1XPzcxq6VtKGDLv2CJvmETwd2AGOA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.6 192/299] mptcp: add needs_id for userspace appending addr
Date: Tue, 27 Feb 2024 14:25:03 +0100
Message-ID: <20240227131632.001562012@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geliang Tang <tanggeliang@kylinos.cn>

commit 6c347be62ae963b301ead8e7fa7b9973e6e0d6e1 upstream.

When userspace PM requires to create an ID 0 subflow in "userspace pm
create id 0 subflow" test like this:

        userspace_pm_add_sf $ns2 10.0.3.2 0

An ID 1 subflow, in fact, is created.

Since in mptcp_pm_nl_append_new_local_addr(), 'id 0' will be treated as
no ID is set by userspace, and will allocate a new ID immediately:

     if (!e->addr.id)
             e->addr.id = find_next_zero_bit(pernet->id_bitmap,
                                             MPTCP_PM_MAX_ADDR_ID + 1,
                                             1);

To solve this issue, a new parameter needs_id is added for
mptcp_userspace_pm_append_new_local_addr() to distinguish between
whether userspace PM has set an ID 0 or whether userspace PM has
not set any address.

needs_id is true in mptcp_userspace_pm_get_local_id(), but false in
mptcp_pm_nl_announce_doit() and mptcp_pm_nl_subflow_create_doit().

Fixes: e5ed101a6028 ("mptcp: userspace pm allow creating id 0 subflow")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_userspace.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -26,7 +26,8 @@ void mptcp_free_local_addr_list(struct m
 }
 
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
-						    struct mptcp_pm_addr_entry *entry)
+						    struct mptcp_pm_addr_entry *entry,
+						    bool needs_id)
 {
 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct mptcp_pm_addr_entry *match = NULL;
@@ -41,7 +42,7 @@ static int mptcp_userspace_pm_append_new
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
-		if (addr_match && entry->addr.id == 0)
+		if (addr_match && entry->addr.id == 0 && needs_id)
 			entry->addr.id = e->addr.id;
 		id_match = (e->addr.id == entry->addr.id);
 		if (addr_match && id_match) {
@@ -64,7 +65,7 @@ static int mptcp_userspace_pm_append_new
 		}
 
 		*e = *entry;
-		if (!e->addr.id)
+		if (!e->addr.id && needs_id)
 			e->addr.id = find_next_zero_bit(id_bitmap,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
@@ -153,7 +154,7 @@ int mptcp_userspace_pm_get_local_id(stru
 	if (new_entry.addr.port == msk_sport)
 		new_entry.addr.port = 0;
 
-	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry);
+	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry, true);
 }
 
 int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
@@ -195,7 +196,7 @@ int mptcp_nl_cmd_announce(struct sk_buff
 		goto announce_err;
 	}
 
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val);
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val, false);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
 		goto announce_err;
@@ -333,7 +334,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buf
 	}
 
 	local.addr = addr_l;
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &local, false);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
 		goto create_err;



