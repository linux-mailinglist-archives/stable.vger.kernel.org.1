Return-Path: <stable+bounces-242667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDy9ClE192nQdQIAu9opvQ
	(envelope-from <stable+bounces-242667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:45:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DCE4B5560
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D63C30073F6
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 11:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58F838DD3;
	Sun,  3 May 2026 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ewfWXYTq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D6440DFA3
	for <stable@vger.kernel.org>; Sun,  3 May 2026 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777808716; cv=none; b=afcfcF/wz/zBZCOxVSwirrenzuia+mQ7CpuOeP8pa+XRnsQCtO9AEEHYCWXOWgtPHt7Z+7bU7Xc3jvXl+ZTpmFKqzm7yXPyW4YIaUx3xqzSajr0NTi4z9vFRtn/5FhwVh3MmZWG+3nR6mP1wYo0UEiujH2BOnN0U8RuSgs2Odtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777808716; c=relaxed/simple;
	bh=WrIjYAS6NT3wcQnlFibwFgKkgIKzvmiw/xDNDSR0pAw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aRDEvrx88njSSGFAG76Q30Suv8a4cAaOCQtg9JjmoVA2Vr8RKboEoD2nMX8iq8a6NrtaKpzqwDfbxcRbEQfa/q0GYIfB/B8cZ5ayfC/g8xiwi6hisGrbToh4Th1BjEq7sruGJ4+5iTEXvOTWAygeWzGxIQ8a93J9qMYj2nPxvg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ewfWXYTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C00C2BCB4;
	Sun,  3 May 2026 11:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777808716;
	bh=WrIjYAS6NT3wcQnlFibwFgKkgIKzvmiw/xDNDSR0pAw=;
	h=Subject:To:Cc:From:Date:From;
	b=ewfWXYTqJTTPs0wnqppoPGS59ZbVBC9G0nLrv3dpIBdovAu4fTZg7hNIZDQ2Wt4A8
	 SrNcOsDS8/kEMC2vXQf3dDfHOhhzVnzPpnl83rrJ/egLWrIBbDzV62tYp9fgUAhvsU
	 oOEIoks4AywNlFNf3LNwjSnG3S6bAae5hsaiKzzQ=
Subject: FAILED: patch "[PATCH] xfs: fix a resource leak in xfs_alloc_buftarg()" failed to apply to 6.6-stable tree
To: lihaoxiang@isrc.iscas.ac.cn,cem@kernel.org,djwong@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 13:45:13 +0200
Message-ID: <2026050313-manmade-batting-5838@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 93DCE4B5560
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-242667-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim]


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 29a7b2614357393b176ef06ba5bc3ff5afc8df69
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050313-manmade-batting-5838@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 29a7b2614357393b176ef06ba5bc3ff5afc8df69 Mon Sep 17 00:00:00 2001
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Date: Wed, 1 Apr 2026 12:02:41 +0800
Subject: [PATCH] xfs: fix a resource leak in xfs_alloc_buftarg()

In the error path, call fs_put_dax() to drop the DAX
device reference.

Fixes: 6f643c57d57c ("xfs: implement ->notify_failure() for XFS")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index ee8c3944015a..580d40a5ee57 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1756,6 +1756,7 @@ xfs_alloc_buftarg(
 	return btp;
 
 error_free:
+	fs_put_dax(btp->bt_daxdev, mp);
 	kfree(btp);
 	return ERR_PTR(error);
 }


