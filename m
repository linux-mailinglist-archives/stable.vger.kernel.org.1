Return-Path: <stable+bounces-211568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHIYBPNod2nCfQEAu9opvQ
	(envelope-from <stable+bounces-211568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:15:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E73188ACC
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D4D63047E7F
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 13:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B80338594;
	Mon, 26 Jan 2026 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sAhER4of"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E66D33858E
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769433209; cv=none; b=COtHdF6/2fC7AAeGLPFON5RVQ4FHgWrRxJZABC0YUw7ofoo9dWVC1mgJKpYZdbjYUIQqcx4rpB38hnVPiDRPZe9HI60VFE3FSDeT4Ud054SW6NickuxYilf35kuEupRAQlN/muHJa71cMAWboORHFe0YsTH/IQAgbUtW3lgy5ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769433209; c=relaxed/simple;
	bh=GD8vTwM5+KAhqbe/3G8w59s3WmfOSgok03ONo56Acho=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GyiF5u+M6Crk0ko7ICFghssDrS+Pi71V/gVJJ7whH4dUDvVYcxMHAQwOiexYP6TkL6NzsOTNImReaA4mL3H5CdYuRMhqUOpJ0+8h3SvSKfLPYa4MbUcExeshofSck0onuAtcUzzX0iwZBe2lSMxqTXBCxj65KoYEWmRbdiF7BRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sAhER4of; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4EFC116C6;
	Mon, 26 Jan 2026 13:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769433209;
	bh=GD8vTwM5+KAhqbe/3G8w59s3WmfOSgok03ONo56Acho=;
	h=Subject:To:Cc:From:Date:From;
	b=sAhER4ofSE2xkmWd/eDEPiDsLloaWVTNG0KLQOWsx2O+DA0OpzeIAiSMgFPN/ZCag
	 2ZxFmbZ9nbtBZfui4MarTaCHvQyRpgRNOd0jEAXHSJEDjNoOkQQ5NttFQeus7IH3O0
	 yxT1Go/+tT/TJ/wbaS/9KX7Co675aHsCwKY1aliI=
Subject: FAILED: patch "[PATCH] scsi: xen: scsiback: Fix potential memory leak in" failed to apply to 6.1-stable tree
To: nihaal@cse.iitm.ac.in,jgross@suse.com,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Jan 2026 14:13:25 +0100
Message-ID: <2026012625-perky-unquote-b3a5@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211568-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:dkim,oracle.com:email,suse.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E73188ACC
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 901a5f309daba412e2a30364d7ec1492fa11c32c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012625-perky-unquote-b3a5@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


