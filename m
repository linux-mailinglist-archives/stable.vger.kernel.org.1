Return-Path: <stable+bounces-85867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E95A99EA94
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503C21C22355
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E481AF0B3;
	Tue, 15 Oct 2024 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W+/9flr+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739C91C07DD;
	Tue, 15 Oct 2024 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996957; cv=none; b=tN9WECyFElv7opNpjjtDrzcO5h79YALcmVkhLA5XSiBIe7fF7/foa+GdnH6r9MlRXUvcwVOMILcE5f4489t5DIiFmgv9gt62/ICGLD/x3O9y/qoInB+lXKBX3xHyzUKgQQRT+gmtRstROtEbk9/D0WUalEG359Wu05SBmePOL1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996957; c=relaxed/simple;
	bh=PJf60X3lt9OSn58JbBYO2Ap5b/HXvqmpMfMecTEfKYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aw9fnUkWe5MMMy15uR7Bw4R3XyAcsmwZLNpqSzw/itbje154Lv/UVxo8H0x7y10edNywk9dBQhFmc94R8uoJkO4/D3eOFVIQR2d6wcsNX2L8oVd3wnqMwBdG4mYj85UqLOOKf4XExzodINaGi0vbcG11YlWir9sG4XV6WPrYnkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W+/9flr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9150C4CEC6;
	Tue, 15 Oct 2024 12:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728996957;
	bh=PJf60X3lt9OSn58JbBYO2Ap5b/HXvqmpMfMecTEfKYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+/9flr+YyxrZURTUH2qWqvJRc0K8mqePowf8Ut6JHYDYC9mNYHcANsJzIBdLBrAc
	 IK33eFuCQyM6MwbmFF5/25tQ5khFcoQuAyd7etGYOVPaJJR2VbnAK1rmLTSPWFfJY2
	 5pvlvDJX4jxhgJmnYTppv0bPr+Y7ElCaAlYBWZiQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geliang Tang <geliangtang@gmail.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 5.10 048/518] mptcp: export lookup_anno_list_by_saddr
Date: Tue, 15 Oct 2024 14:39:12 +0200
Message-ID: <20241015123918.864322911@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geliang Tang <geliangtang@gmail.com>

commit d88c476f4a7dd69a2588470f6c4f8b663efa16c6 upstream.

This patch exported the static function lookup_anno_list_by_saddr, and
renamed it to mptcp_lookup_anno_list_by_saddr.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: b4cd80b03389 ("mptcp: pm: Fix uaf in __timer_delete_sync")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |   10 +++++-----
 net/mptcp/protocol.h   |    3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -194,9 +194,9 @@ static void check_work_pending(struct mp
 		WRITE_ONCE(msk->pm.work_pending, false);
 }
 
-static struct mptcp_pm_add_entry *
-lookup_anno_list_by_saddr(struct mptcp_sock *msk,
-			  struct mptcp_addr_info *addr)
+struct mptcp_pm_add_entry *
+mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
+				struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 
@@ -255,7 +255,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock
 	struct sock *sk = (struct sock *)msk;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = lookup_anno_list_by_saddr(msk, addr);
+	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 	if (entry)
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 	spin_unlock_bh(&msk->pm.lock);
@@ -272,7 +272,7 @@ static bool mptcp_pm_alloc_anno_list(str
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 
-	if (lookup_anno_list_by_saddr(msk, &entry->addr))
+	if (mptcp_lookup_anno_list_by_saddr(msk, &entry->addr))
 		return false;
 
 	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -451,6 +451,9 @@ void mptcp_pm_free_anno_list(struct mptc
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       struct mptcp_addr_info *addr);
+struct mptcp_pm_add_entry *
+mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
+				struct mptcp_addr_info *addr);
 
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,



