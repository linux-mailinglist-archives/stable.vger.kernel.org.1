Return-Path: <stable+bounces-24969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF09C86971A
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF5A1C223E7
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB5413B797;
	Tue, 27 Feb 2024 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B2v+bHW7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9C013B78F;
	Tue, 27 Feb 2024 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043492; cv=none; b=UnNZBev1KTa6a5G+YiFOi3QkTfgzprG+PYd5IbzoHYIFFtWSM/igXkfeDXudhQoaTUZL5deR2DQfp2qBXNjHy03SPYT5r01PeGT2j7kTu0Klg6/cy60B5To/myzJLwjzFmSWLiLxzMRincx8JJn+uzDXLeV//ZITnmngRsNdv5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043492; c=relaxed/simple;
	bh=CI6Shwh/HQCcthnN3PB++AQTgLi/brfB0nDAUWASVWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQZXmMGqjnTZpOF1NIyZ0J73PC+Db8NXPJEI487+LCb0DEwXFrOMtvTUkZzPrIT3UOI9/EKPhFbdRiS4iyMlwk3BARiO1xyVY0QP/6tuShB1zKAQh9brnRBx3GRpTiJRhz/9yaLPpzVYKG3MNkpAn19PZoJdBv9Y3GsjVTHsOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B2v+bHW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09BDC433F1;
	Tue, 27 Feb 2024 14:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043492;
	bh=CI6Shwh/HQCcthnN3PB++AQTgLi/brfB0nDAUWASVWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B2v+bHW7/o2u2h1fpq15tzz+/5QZPyIqxtpEKgp2WS7pE6E8WGF+rPTOcfoUVyzD6
	 7W/sO8MINHXlLCcNZBryqDq7Cm58+i1LLpvBtGRIvK+bdSCqTQ6i1mKmRELJj5SOQe
	 lq7rNDQGgwkKjPG2Qk19g35RPWQJcWA0ZDZyzrcU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 127/195] mptcp: add needs_id for userspace appending addr
Date: Tue, 27 Feb 2024 14:26:28 +0100
Message-ID: <20240227131614.637824589@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
References: <20240227131610.391465389@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -155,7 +156,7 @@ int mptcp_userspace_pm_get_local_id(stru
 	if (new_entry.addr.port == msk_sport)
 		new_entry.addr.port = 0;
 
-	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry);
+	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry, true);
 }
 
 int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
@@ -197,7 +198,7 @@ int mptcp_nl_cmd_announce(struct sk_buff
 		goto announce_err;
 	}
 
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val);
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val, false);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
 		goto announce_err;
@@ -335,7 +336,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buf
 	}
 
 	local.addr = addr_l;
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &local, false);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
 		goto create_err;



