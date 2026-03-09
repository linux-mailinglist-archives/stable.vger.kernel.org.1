Return-Path: <stable+bounces-223565-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JkdHHWgrmntGwIAu9opvQ
	(envelope-from <stable+bounces-223565-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:27:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9573237059
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDFE63053DF1
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0E638F94E;
	Mon,  9 Mar 2026 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I00ip08/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6057638F93D
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773051975; cv=none; b=HM04g0Duny+RHoMRjD6Ui7E2jhw8zH0XtFOTafHGypADv9LGWUZ8h1+XFeDk71mxcOhvEz9qXDezbbpdoEZnVbqbeHQMRXboJVZxF/O/VmO1JiAQmCkCGo45jDmWTv4GWR3LQYEYyCeBN95wDKD0xSLgiT+FRdrL0OF9a1WycZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773051975; c=relaxed/simple;
	bh=PoP0o5Ik2fkZCAUG9EttzK1LOHYtE8PZtmLPPRCfMy4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LjIxt+9jkDbSF3KN+uuv2aym4VKRmVr9X/J/ZLaBBh9N7/AsFxYjTqB8bBEYNEx8FedVaECIwVrydEUr3I4kvKBmd1YMAX0IbRSFynldHLCiCHHp+Fo0mm7m91KRo2pPxgVv4ui62EFI0J6wYWb2MFs4n+93tQX5oWfMFQDd35E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I00ip08/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE86EC4CEF7;
	Mon,  9 Mar 2026 10:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773051975;
	bh=PoP0o5Ik2fkZCAUG9EttzK1LOHYtE8PZtmLPPRCfMy4=;
	h=Subject:To:Cc:From:Date:From;
	b=I00ip08/PYqKx6JRE9cIItn45fkhRvw9LLnwLoq7jj95sG/mOcp3lUcUhW/eQFZsf
	 ylTsXMzcQlz6jBH4C4xzhWrtIR8xGOOKZ9dv7HWgEBET/ngZgKPMMd0zhXS9ycDzao
	 hJgmHwGBx96RM2QollkALGDHwsTQ8bxrVUu9XH9U=
Subject: FAILED: patch "[PATCH] xfs: fix xfs_group release bug in xfs_dax_notify_dev_failure" failed to apply to 6.6-stable tree
To: djwong@kernel.org,cem@kernel.org,cmaiolino@redhat.com,hch@lst.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Mar 2026 11:26:02 +0100
Message-ID: <2026030902-saint-unearth-05fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B9573237059
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223565-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.282];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,lst.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x eb8550fb75a875657dc29e3925a40244ec6b6bd6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026030902-saint-unearth-05fe@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


