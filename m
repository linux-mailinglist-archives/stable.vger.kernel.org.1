Return-Path: <stable+bounces-233672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHBIFYsn1WnB1gcAu9opvQ
	(envelope-from <stable+bounces-233672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:49:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C353B14C5
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA9F8318206A
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045903CEB81;
	Tue,  7 Apr 2026 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mb4c6pix"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6223C1412
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775576325; cv=none; b=qGo5gYByuhjMZ8RgdtydZyWp7OmMo9a9jAOiA5gHGTTVEDnLqPEchpMXETP0mZ91Cob/W1oPfdbw9yDBGs8s00drGRGPdCOKQ2Ek+VQjFQ1GazwNIP3rim3yyCeEX+j4q8JSKWrr077ezPXZptvaHV+sD3iE+yE9D7TKQuy9Bjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775576325; c=relaxed/simple;
	bh=OcfPOr71Ph1eLmx0/jBFTnyjbrAJFKYIYy6GL7AOiQU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fAqjrzNieiBmxRrQiscvnI0OrBpAuUKARnPKKPE1JP5W95+scVc7Sfgc07eF1x25Ale8REtrA/DG/qziVqZczCmiZZmevz4E1rp7ewrB8hDN7cWwQrgjW2Q9Vas/NwvDaOwdReE6N6m4o20ur6lIYpe1ujV+caH6dafqafvyen8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mb4c6pix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262B2C19424;
	Tue,  7 Apr 2026 15:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775576325;
	bh=OcfPOr71Ph1eLmx0/jBFTnyjbrAJFKYIYy6GL7AOiQU=;
	h=Subject:To:Cc:From:Date:From;
	b=Mb4c6pixPACDJtvdUuryFHnwesevXRnFm9cnTWWBbNRxkLXN/yfhUjsrQtn7rSvQG
	 LvOHKmZJ5EsxTR861163sgvHqQ1HeMTR3rNmC7e4aiDHOFd1T7ohzTtcbSPro/DkwL
	 9kFxJQbIKXrPPhCsNyjnDGTJHdNe3ZCGcJ3BKDMk=
Subject: FAILED: patch "[PATCH] btrfs: fix incorrect return value after changing leaf in" failed to apply to 6.18-stable tree
To: robbieko@synology.com,dsterba@suse.com,fdmanana@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 07 Apr 2026 17:36:18 +0200
Message-ID: <2026040718-repeated-unsealed-bb06@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233672-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,synology.com:email]
X-Rspamd-Queue-Id: A9C353B14C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 316fb1b3169efb081d2db910cbbfef445afa03b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040718-repeated-unsealed-bb06@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 316fb1b3169efb081d2db910cbbfef445afa03b9 Mon Sep 17 00:00:00 2001
From: robbieko <robbieko@synology.com>
Date: Wed, 25 Mar 2026 18:18:15 +0800
Subject: [PATCH] btrfs: fix incorrect return value after changing leaf in
 lookup_extent_data_ref()

After commit 1618aa3c2e01 ("btrfs: simplify return variables in
lookup_extent_data_ref()"), the err and ret variables were merged into
a single ret variable. However, when btrfs_next_leaf() returns 0
(success), ret is overwritten from -ENOENT to 0. If the first key in
the next leaf does not match (different objectid or type), the function
returns 0 instead of -ENOENT, making the caller believe the lookup
succeeded when it did not. This can lead to operations on the wrong
extent tree item, potentially causing extent tree corruption.

Fix this by returning -ENOENT directly when the key does not match,
instead of relying on the ret variable.

Fixes: 1618aa3c2e01 ("btrfs: simplify return variables in lookup_extent_data_ref()")
CC: stable@vger.kernel.org # 6.12+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: robbieko <robbieko@synology.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 85ee5c79759d..098e64106d02 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -495,7 +495,7 @@ again:
 		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 		if (key.objectid != bytenr ||
 		    key.type != BTRFS_EXTENT_DATA_REF_KEY)
-			return ret;
+			return -ENOENT;
 
 		ref = btrfs_item_ptr(leaf, path->slots[0],
 				     struct btrfs_extent_data_ref);


