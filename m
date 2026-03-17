Return-Path: <stable+bounces-225948-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC1tLpJPuWnj/wEAu9opvQ
	(envelope-from <stable+bounces-225948-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:56:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F9C2AA400
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF5B1305B58B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C044F3C660D;
	Tue, 17 Mar 2026 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K9U8vCBl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848A13C3C02
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752192; cv=none; b=sCprsohglJvR8tzZoqwpS+97bFj4Qeo3Em0BEGvI9XYeuRMCDSHQlguidNO7AFS/bGsW2edwy4UQ4U0Z659NloK2dM6RA4XL1nher/TsJnqno9vaO+KB+yCfuwSlwDVXceaf/QrNWLx/gvnJe6COcr+1tKE11I7tcHSMSofRDQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752192; c=relaxed/simple;
	bh=ygeGoq4PbgwilBiQlHmydji/CFP6SNSn3uTQy10y0cs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IC9K0iaHoqri7MYBxeSifyiFoogt2hlAj1qe/6pMshDpcXIqAuFGYsJd0APqdn+nsbipR7hngxeVR+M1lYnsnGV7Rs+0YCLydzpD8G/YpbxwrkNcqXDmmMoCBX8/TSKeCEC4eaV+p3h4M/gAhB78QdFMBUkSG8oLI/BmYrFwkGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K9U8vCBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9DCC4CEF7;
	Tue, 17 Mar 2026 12:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773752192;
	bh=ygeGoq4PbgwilBiQlHmydji/CFP6SNSn3uTQy10y0cs=;
	h=Subject:To:Cc:From:Date:From;
	b=K9U8vCBlfAF4dkUyChfovnd9VyJg4c50qYZZu7v0p6+hFL6QGNcJh0Tl9CltnSDbU
	 hYkpMDedLeKoYhE1c6Vqlt15SHpcg/tKNJRkrbKaa7B5p8ioj7b7IX/UB9sjmj0X3g
	 to/bUcxbeCTA5fU88Ak0DflOlgXkrdCaRaJ4y7cU=
Subject: FAILED: patch "[PATCH] xfs: fix integer overflow in bmap intent sort comparator" failed to apply to 5.15-stable tree
To: leo.lilong@huawei.com,cem@kernel.org,djwong@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:56:15 +0100
Message-ID: <2026031715-attitude-wildfowl-8193@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225948-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Queue-Id: 49F9C2AA400
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 362c490980867930a098b99f421268fbd7ca05fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031715-attitude-wildfowl-8193@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


