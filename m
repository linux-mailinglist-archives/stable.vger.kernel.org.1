Return-Path: <stable+bounces-93726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A18109D05DB
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11205B21715
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 20:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F651CACE0;
	Sun, 17 Nov 2024 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZlXNePLY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE3F18054
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731875511; cv=none; b=ZfB5asOwwhe07ACN994zx8gG9glbbxj6FdmhFR4WYO45BpVB5FGPF+9RlOm7EpVAeIXQ7iNijmOWN3iN4DRa4b9pWdlIAfmht9llBkmpW4saIkIsG4NhAyStQKat6+5YdsWF69bcMvenc0mzn/o/RznaihrinUOUVXyfWg+Pp84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731875511; c=relaxed/simple;
	bh=iTKwLnTdkcIF++4fLGjDzo5vEFKUHcyOCJvrXpEmnrw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EBgcqwu+ZTuyAlsPtdnb10K/AniMTcPs8w5ylilxIzKM1ye38RVnntfcFp/3KZ13+hGjSmBHQGaA1fVyCaz2lrGHy5hItQI6zAD37SEjbTPsouKfbcQBAvjeclxy8l4QHpaABiAQpJp7qi+5Rj1VcJLOQbMA6sIqBETe2X9yZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZlXNePLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F44C4CECD;
	Sun, 17 Nov 2024 20:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731875510;
	bh=iTKwLnTdkcIF++4fLGjDzo5vEFKUHcyOCJvrXpEmnrw=;
	h=Subject:To:Cc:From:Date:From;
	b=ZlXNePLYytSmVy8/uWAQ8Ifz7DPLlcleBCdiSfzT+iNvWRAtcBm6PKdLVwCwyz2mA
	 2G5ydGuog6yWYiRwKVs/ePOYBi7FKc+JzNbSZeHKCWDBCBc+Mex68s0IQe1uY0RZ9D
	 spcOj0dmIhpKIr7xagMA0OwGcEbKAzrtEJxjtNu8=
Subject: FAILED: patch "[PATCH] mptcp: pm: use _rcu variant under rcu_read_lock" failed to apply to 6.1-stable tree
To: matttbe@kernel.org,geliang@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Nov 2024 21:31:23 +0100
Message-ID: <2024111723-vacate-gaining-55ae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x db3eab8110bc0520416101b6a5b52f44a43fb4cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111723-vacate-gaining-55ae@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db3eab8110bc0520416101b6a5b52f44a43fb4cf Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 12 Nov 2024 20:18:35 +0100
Subject: [PATCH] mptcp: pm: use _rcu variant under rcu_read_lock

In mptcp_pm_create_subflow_or_signal_addr(), rcu_read_(un)lock() are
used as expected to iterate over the list of local addresses, but
list_for_each_entry() was used instead of list_for_each_entry_rcu() in
__lookup_addr(). It is important to use this variant which adds the
required READ_ONCE() (and diagnostic checks if enabled).

Because __lookup_addr() is also used in mptcp_pm_nl_set_flags() where it
is called under the pernet->lock and not rcu_read_lock(), an extra
condition is then passed to help the diagnostic checks making sure
either the associated spin lock or the RCU lock is held.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241112-net-mptcp-misc-6-12-pm-v1-3-b835580cefa8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index db586a5b3866..45a2b5f05d38 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -524,7 +524,8 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry(entry, &pernet->local_addr_list, list) {
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list,
+				lockdep_is_held(&pernet->lock)) {
 		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
 	}


