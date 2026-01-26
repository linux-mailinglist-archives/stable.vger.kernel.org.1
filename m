Return-Path: <stable+bounces-211569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JLsN4Vod2nCfQEAu9opvQ
	(envelope-from <stable+bounces-211569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:13:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 576D888A73
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5009130160F1
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 13:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D4F338586;
	Mon, 26 Jan 2026 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bDMDuLvF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B043382FB
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769433217; cv=none; b=oHEx7gWOmuHR2ttJ9FBiL0fOqFm3Pq+G9ZnjCPLuxdq9ESTZy9sLjxfbWbVROXZOlBZOeKrVTI6FjS7co6u5G5kJ4KaNpeiwQhhfxhm5JtwW+1ryC0azHLseV+6sTOvP1YBSYMD0BbXKYJ7qdFxUJt4SLyvdcfXVhR9oGHyB/60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769433217; c=relaxed/simple;
	bh=Q9krltaDYR+YBk47zi59Jk81wEoYi5g40MwfHM0aVhA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ts7kz7IKu9oNXGk6zJm5rQ+H5LRmzJStNFGsQxqMj1zpwMyEwIz2Ws+flNIdUO6kc5t6GGNc6zEk0wbhHqKBD5mnAAQfx+/+IJJ286RoHnfo/9FuW5K8gf/AXWZs4Fb016wjsF9PyOtI5b2MAsOw0+9zkw1XhdyOzZV7htZSPNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bDMDuLvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F83C116C6;
	Mon, 26 Jan 2026 13:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769433217;
	bh=Q9krltaDYR+YBk47zi59Jk81wEoYi5g40MwfHM0aVhA=;
	h=Subject:To:Cc:From:Date:From;
	b=bDMDuLvFQ4aSrF3MJGWCyJVW+WJycDTGYeMizVcjGePP1ASVJ5W34S+THPf+5KvgU
	 RiAqbTv8hXEq2JGXtEclH5BWlYX7SqceOhBJbxEjMRcIxjdXVCVQBUQwnTbhAxb6yi
	 uD5GL1XjOu/JwleCjQ4+8lLYjGey1gh9InBOxpUY=
Subject: FAILED: patch "[PATCH] scsi: xen: scsiback: Fix potential memory leak in" failed to apply to 5.10-stable tree
To: nihaal@cse.iitm.ac.in,jgross@suse.com,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Jan 2026 14:13:26 +0100
Message-ID: <2026012626-aghast-repeated-f60b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-211569-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,msgid.link:url,gregkh:email,linuxfoundation.org:dkim,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 576D888A73
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 901a5f309daba412e2a30364d7ec1492fa11c32c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012626-aghast-repeated-f60b@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 901a5f309daba412e2a30364d7ec1492fa11c32c Mon Sep 17 00:00:00 2001
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Tue, 23 Dec 2025 12:00:11 +0530
Subject: [PATCH] scsi: xen: scsiback: Fix potential memory leak in
 scsiback_remove()

Memory allocated for struct vscsiblk_info in scsiback_probe() is not
freed in scsiback_remove() leading to potential memory leaks on remove,
as well as in the scsiback_probe() error paths. Fix that by freeing it
in scsiback_remove().

Cc: stable@vger.kernel.org
Fixes: d9d660f6e562 ("xen-scsiback: Add Xen PV SCSI backend driver")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://patch.msgid.link/20251223063012.119035-1-nihaal@cse.iitm.ac.in
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index 0c51edfd13dc..7d5117e5efe0 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -1262,6 +1262,7 @@ static void scsiback_remove(struct xenbus_device *dev)
 	gnttab_page_cache_shrink(&info->free_pages, 0);
 
 	dev_set_drvdata(&dev->dev, NULL);
+	kfree(info);
 }
 
 static int scsiback_probe(struct xenbus_device *dev,


