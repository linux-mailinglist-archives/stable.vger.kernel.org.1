Return-Path: <stable+bounces-237560-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOcmHtUl3WlcaQkAu9opvQ
	(envelope-from <stable+bounces-237560-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:20:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BA83F132F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6DEE930365BD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1BF32ABC0;
	Mon, 13 Apr 2026 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fE5XYe5a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEEC33342C;
	Mon, 13 Apr 2026 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099770; cv=none; b=U7Kwib7CElUVGuKNjFafcJjtelGXvKpnpJWHuYiJvOCmF2RD00SnHOJGaadCIEGJH9dGgQF3FTxvwcFdLIHlmJDjOEzbZ8HFPJOiXcU0CKDbXsv4JutVWoza4ZdSrM2/KsINVoCaF+LEG8pu3zV09y+ACz62nnruzNGwS7fnZGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099770; c=relaxed/simple;
	bh=WaQrnm1s6QKGwRlh56Bw2VMoTd91mqzbFJAJF/L6xlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpqQi+u80WA/q+/9LBIPGcbOu2zG9bqJBwld9PY1FZGUYqmZtr0jvXyz43cJjk71TyWTt8o41Kbmc1btaUZwLQ4lmHezaKnm8cKbRgTxO6lXTaTutc0KIFG+hyPztSpIaPjE27Aqt/VW8O/6Zzypnv+BAxU+mv/aCHwgyTLjr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fE5XYe5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990B7C2BCAF;
	Mon, 13 Apr 2026 17:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099769;
	bh=WaQrnm1s6QKGwRlh56Bw2VMoTd91mqzbFJAJF/L6xlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fE5XYe5addAKWSeKLt3/Mw/FKfPJL3Pgu+ytGnzXinMXsU2SqFiKd4SbSZaUitUKR
	 rdxAARnxDkQD6jwBxyVIeq9c9K3pRD31oEfPaHlhokfyMrRXh6EofDuUTgrAx1PFHH
	 maQu+x0N20cIFc8IxcSmhS0nz0PlFC3W1MUkULjs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+652af2b3c5569c4ab63c@syzkaller.appspotmail.com,
	Yuto Ohnuki <ytohnuki@amazon.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 468/491] xfs: stop reclaim before pushing AIL during unmount
Date: Mon, 13 Apr 2026 18:01:53 +0200
Message-ID: <20260413155836.562929550@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-237560-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,652af2b3c5569c4ab63c];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 29BA83F132F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuto Ohnuki <ytohnuki@amazon.com>

[ Upstream commit 4f24a767e3d64a5f58c595b5c29b6063a201f1e3 ]

The unmount sequence in xfs_unmount_flush_inodes() pushed the AIL while
background reclaim and inodegc are still running. This is broken
independently of any use-after-free issues - background reclaim and
inodegc should not be running while the AIL is being pushed during
unmount, as inodegc can dirty and insert inodes into the AIL during the
flush, and background reclaim can race to abort and free dirty inodes.

Reorder xfs_unmount_flush_inodes() to stop inodegc and cancel background
reclaim before pushing the AIL. Stop inodegc before cancelling
m_reclaim_work because the inodegc worker can re-queue m_reclaim_work
via xfs_inodegc_set_reclaimable.

Reported-by: syzbot+652af2b3c5569c4ab63c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=652af2b3c5569c4ab63c
Fixes: 90c60e164012 ("xfs: xfs_iflush() is no longer necessary")
Cc: stable@vger.kernel.org # v5.9
Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ dropped xfs_inodegc_stop() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_mount.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -652,8 +652,9 @@ xfs_check_summary_counts(
  * have been retrying in the background.  This will prevent never-ending
  * retries in AIL pushing from hanging the unmount.
  *
- * Finally, we can push the AIL to clean all the remaining dirty objects, then
- * reclaim the remaining inodes that are still in memory at this point in time.
+ * Stop inodegc and background reclaim before pushing the AIL so that they
+ * are not running while the AIL is being flushed. Then push the AIL to
+ * clean all the remaining dirty objects and reclaim the remaining inodes.
  */
 static void
 xfs_unmount_flush_inodes(
@@ -665,8 +666,8 @@ xfs_unmount_flush_inodes(
 
 	mp->m_flags |= XFS_MOUNT_UNMOUNTING;
 
-	xfs_ail_push_all_sync(mp->m_ail);
 	cancel_delayed_work_sync(&mp->m_reclaim_work);
+	xfs_ail_push_all_sync(mp->m_ail);
 	xfs_reclaim_inodes(mp);
 	xfs_health_unmount(mp);
 }



