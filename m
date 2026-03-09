Return-Path: <stable+bounces-223563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KDTLT+grmm2GwIAu9opvQ
	(envelope-from <stable+bounces-223563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:26:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07417237024
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B936E30146BE
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BDC38F24E;
	Mon,  9 Mar 2026 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M5heV+dS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8655319E97B
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773051964; cv=none; b=kFf8ANbAMKs+huA0GA5kidreGdcF5DWQSHzOPh40luiMoz2/3YPyH7MdBD9R/+EuM2k8BZJYZ8n3x3POzCikuemHhgUeXmUmiXb+tBDTHWw07o60wofKM8P3Xk1HKob3FDmpCRpO/RU7JAjJ02AIeAbnmcvJT9dRLbJd7QsshWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773051964; c=relaxed/simple;
	bh=82AYcYIV15bpRHGAbFjvpPE452hG9a67ntM/n2KPyu0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a3th3R0AjnJH4KGIgLX9aaRyDn0MbmWIr3C0yLKZFJ4XB5KLJ4BQj0WsQGPoMktS2QkEXceDdLqYLyxUzalZunq3Y0QUfFs2J/ZQ9c9GTMXoH47OgF10iMBKuyp413xsrnoocxrQoqVu//INVQRuc1Gcx5VTVRR3FbDED8+MbkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M5heV+dS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF083C19423;
	Mon,  9 Mar 2026 10:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773051964;
	bh=82AYcYIV15bpRHGAbFjvpPE452hG9a67ntM/n2KPyu0=;
	h=Subject:To:Cc:From:Date:From;
	b=M5heV+dSCRJuU26ycJsegBZoW4bLjwEt/tNDo8SWf9dc32wrfS1Avr+eRBqkwzBTy
	 S58yZApGLhHi2jpYwPKuv9Xl8aNbDP0AFBxni48lKXx2XTkQtvN7YtoiSrpTcLhw0u
	 e2FybBVyCtBQPxSqOg0x/qcij23wcpRPFQ+vs8nU=
Subject: FAILED: patch "[PATCH] xfs: fix xfs_group release bug in xfs_dax_notify_dev_failure" failed to apply to 6.12-stable tree
To: djwong@kernel.org,cem@kernel.org,cmaiolino@redhat.com,hch@lst.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Mar 2026 11:26:01 +0100
Message-ID: <2026030901-flaccid-confining-ac1c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 07417237024
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223563-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.283];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,gregkh:email,lst.de:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x eb8550fb75a875657dc29e3925a40244ec6b6bd6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026030901-flaccid-confining-ac1c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eb8550fb75a875657dc29e3925a40244ec6b6bd6 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Wed, 18 Feb 2026 15:25:36 -0800
Subject: [PATCH] xfs: fix xfs_group release bug in xfs_dax_notify_dev_failure

Chris Mason reports that his AI tools noticed that we were using
xfs_perag_put and xfs_group_put to release the group reference returned
by xfs_group_next_range.  However, the iterator function returns an
object with an active refcount, which means that we must use the correct
function to release the active refcount, which is _rele.

Cc: <stable@vger.kernel.org> # v6.0
Fixes: 6f643c57d57c56 ("xfs: implement ->notify_failure() for XFS")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index 6be19fa1ebe2..64c8afb935c2 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -304,7 +304,7 @@ xfs_dax_notify_dev_failure(
 
 			error = xfs_alloc_read_agf(pag, tp, 0, &agf_bp);
 			if (error) {
-				xfs_perag_put(pag);
+				xfs_perag_rele(pag);
 				break;
 			}
 
@@ -340,7 +340,7 @@ xfs_dax_notify_dev_failure(
 		if (rtg)
 			xfs_rtgroup_unlock(rtg, XFS_RTGLOCK_RMAP);
 		if (error) {
-			xfs_group_put(xg);
+			xfs_group_rele(xg);
 			break;
 		}
 	}


