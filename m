Return-Path: <stable+bounces-225947-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAGmCH9PuWnj/wEAu9opvQ
	(envelope-from <stable+bounces-225947-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:56:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE36C2AA3E3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 041233025E27
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4636A3C6619;
	Tue, 17 Mar 2026 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oeRQDiDW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF233A3E75
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752189; cv=none; b=ozvxjjY2UYu4zMsCxQsVWtQyMWNFTrts814H929K/r4c+vZMpMIcS9hb6WIxjpYjFaOVr47lHT+r6fNB/KzsumyOMvXPJQIXDsVshsAr6Y30WpPm/Y1jAZW9h57PH6YaD/cyZEUWGHb4lwSSh+yIxm18oaXFvTMaZmIwy3QSCPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752189; c=relaxed/simple;
	bh=u8oZCm1fBGjmze7bCsXj+H7Rgtol9IWF+gYOrd6gi/o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VMZEr7JDkDGbDjdMmj1RegYnzW2/5o26SqE8YexobJ8brDWAI9ZofrYH/CKCm3xGfvbtRzA8lFPnc/B5aGZc7YHTWxmmMp1BKKa8NFtZnXXzY2aN5Yg8015LnjAELu2sB73mK9CEQ5/8B083cy/1nm7kZ8hBqsngvGEgo/1VrjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oeRQDiDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40162C4CEF7;
	Tue, 17 Mar 2026 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773752188;
	bh=u8oZCm1fBGjmze7bCsXj+H7Rgtol9IWF+gYOrd6gi/o=;
	h=Subject:To:Cc:From:Date:From;
	b=oeRQDiDWvfxAEeGbdVP268Q3g998ZyNTxybtDeSdOE58zti0Lnmr3/CqPMxYyNqGk
	 IBXneBQ+DQVNLkO/vuOrov5/WaG11X2C3exC/sMfafqZh0auY4FCFsezrMs6D//mff
	 FlpUhMEfv4BOpng1O0Csutn6X5e0OBsXbVUbZjRM=
Subject: FAILED: patch "[PATCH] xfs: fix integer overflow in bmap intent sort comparator" failed to apply to 5.10-stable tree
To: leo.lilong@huawei.com,cem@kernel.org,djwong@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:56:15 +0100
Message-ID: <2026031715-deepen-kabob-15c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225947-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:dkim,huawei.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE36C2AA3E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 362c490980867930a098b99f421268fbd7ca05fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031715-deepen-kabob-15c4@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 362c490980867930a098b99f421268fbd7ca05fd Mon Sep 17 00:00:00 2001
From: Long Li <leo.lilong@huawei.com>
Date: Tue, 10 Mar 2026 20:32:33 +0800
Subject: [PATCH] xfs: fix integer overflow in bmap intent sort comparator

xfs_bmap_update_diff_items() sorts bmap intents by inode number using
a subtraction of two xfs_ino_t (uint64_t) values, with the result
truncated to int. This is incorrect when two inode numbers differ by
more than INT_MAX (2^31 - 1), which is entirely possible on large XFS
filesystems.

Fix this by replacing the subtraction with cmp_int().

Cc: <stable@vger.kernel.org> # v4.9
Fixes: 9f3afb57d5f1 ("xfs: implement deferred bmbt map/unmap operations")
Signed-off-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index e8775f254c89..b237a25d6045 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -245,7 +245,7 @@ xfs_bmap_update_diff_items(
 	struct xfs_bmap_intent		*ba = bi_entry(a);
 	struct xfs_bmap_intent		*bb = bi_entry(b);
 
-	return ba->bi_owner->i_ino - bb->bi_owner->i_ino;
+	return cmp_int(ba->bi_owner->i_ino, bb->bi_owner->i_ino);
 }
 
 /* Log bmap updates in the intent item. */


