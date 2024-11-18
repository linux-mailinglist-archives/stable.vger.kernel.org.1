Return-Path: <stable+bounces-93827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504E89D1810
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 19:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCD6CB23B9C
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 18:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4141E0DE5;
	Mon, 18 Nov 2024 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nq8WJjFm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073D42E3EB;
	Mon, 18 Nov 2024 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731954476; cv=none; b=cs4Vw+4tMuMOgG7NMeZt21AJ1LePVjP1V5uTLwJ0G/s7aytZtfSLUhV3nPja8WsaIIshkohdUSX0YkYmjyYqvnzolNxq8R0a4YUs9sGckD5/NwuUx8pe7sNAefvWyn1TDuUvL6fIdnp6/8n/8719675/k+YH7NIUwQwGB2z2+VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731954476; c=relaxed/simple;
	bh=oUHl9syWz+l50YB6iHaH/W3xamw75kFCBtFIDuz+ldw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDWE1Hj6RrNRsgK43ZXvLEMXnqCJSNMXUULkppETSHU2wiUfs3jpSE7rjsylrluzW5+vvXe9QtGySENsz2U5F/RC+ycyJk1WrRInCbjjPaAb3mOg9uh9QF7wNcqyQi90rWU//9yMIubS4I2yio6BpFAGaAdbIQU+9KnXdz0x9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nq8WJjFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCFFC4CECC;
	Mon, 18 Nov 2024 18:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731954475;
	bh=oUHl9syWz+l50YB6iHaH/W3xamw75kFCBtFIDuz+ldw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nq8WJjFm/VL11yuPxAiW7/4d/0xhF3JdiM7sAHIuRLG5f+qDH4v59y3zQxUvIr40P
	 /ByJPreyn/XIuPW47+xJPBz0jwO7gUU3fO9f3R/n7day8pezFq2vNq9ddGvJUQmX7f
	 bNQtKLP+9TZCvMnWdRQ6ptg53rOqCz3nOzwXigFh2fv3Y6kNN8sQQQ6ikicdpogP3y
	 VC3YuXtJ5Hp88bJdN7DZe4i/6Hniql6Rp8RssEEmREQ68/0Lwe/4DJsIffFX3u9skR
	 LLWHcvbbKNADS5/7HdilWIxb88LLwpy0jH3XEwTgqnZ8eOJjGTqFbMm3QWpJoP15+F
	 VwvgQ5tJofj0w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 6/6] mptcp: pm: use _rcu variant under rcu_read_lock
Date: Mon, 18 Nov 2024 19:27:24 +0100
Message-ID: <20241118182718.3011097-14-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118182718.3011097-8-matttbe@kernel.org>
References: <20241118182718.3011097-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=matttbe@kernel.org; h=from:subject; bh=oUHl9syWz+l50YB6iHaH/W3xamw75kFCBtFIDuz+ldw=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnO4cG8kNSj4r+UMJypWr51PC0SKuCn7EsWI6FZ bjEY7CrvrCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzuHBgAKCRD2t4JPQmmg cwKFD/0U/S4zOye0ab02Ca9LVqhM2yC/rQEfO3O4WL8s6ekxFQAxyrkt/KUxrM+ntFjLZ0q2ENg 9wazA2pSAMwwwtC7RJ4vuGJ1KWgVHDwuSaCNaffqvWtsq+qbewxTDTUMUsn7zW/d89wLc2bCmqi bQCSemaB5wDuH+BvgfGPAcvjSyfb/va3WiqhhxJT2LNvgbwB9h1UgI0fFv1sgeDwyFRJCzwNRGs X/aTrMJZh+oKvA2DMDV5NirBEM35DQUCPP49YmOBu2RaOxx16YU3dgeej4pyuY5u7V4MHkKNRDk 05TAvnDr4UXFyj/qYL5qq4iZRv8Zh6HyoANA5zn1oKXcCaojdExUyHm7xSlokBlJNrGRkVIEcPP xSP+qwaR27BsKLFAD7xEo5yTG8X7+4f3knB9u21rXq9Mcqz8vJcNcDix9nEXQlS27HqQzjnehP4 owj+HxF/RSi9jRYlW2fCqiIgvdALsLKsKyLf6GQ7kyYwkyBxDGv1/v8nV2e4eogSEenWRps/hVQ y+/aA22kNon3okLHVk7ZCanYtUabtCa2yWwG5YeEMlQwOySCDk/KlNvXXxIGRE1EYgnknuyw5+H 2a5ReYWOcOWC6hzLfr8DEZTK3Qut3xn/CIJRln/jvLWth6INRl0Jym2D+ROTiY84RzvrILDlTu7 kDg+h9yXHQQSedA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit db3eab8110bc0520416101b6a5b52f44a43fb4cf upstream.

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
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 76be4f4412df..2cf4393e48dc 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -525,7 +525,8 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry(entry, &pernet->local_addr_list, list) {
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list,
+				lockdep_is_held(&pernet->lock)) {
 		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
 	}
-- 
2.45.2


