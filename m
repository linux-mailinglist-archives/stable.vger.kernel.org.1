Return-Path: <stable+bounces-226511-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK2nCpqPuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226511-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:30:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FFE2AFB2B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0246931F93F0
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE503F0778;
	Tue, 17 Mar 2026 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K7Iams6w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802E23E3DB1;
	Tue, 17 Mar 2026 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767028; cv=none; b=P1fzq3/n7dnM0kouygWhHp2H9a6nE6aH9zKCqYMtDtnQgHFhzQ6HE6YvrWUNYGctygP669Y9RgrLVVljk2FQH0Tzsc5T4R/dsaLI3XGbe6+H5R9qG2GTzoRXY7lMgN6Z8hp0Q+tl/hQo0q0mG2v+LG9zamVVUcy5YQK0x2+rMnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767028; c=relaxed/simple;
	bh=xszVIwFPtspbgLHCJs+G6Od3/OPL4eHLtuuklTkg4I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHlJACauwPdtDfiCm1KRKp8mq7/q0wGeIc5jOLbs+C+0NJQgq0qhYGQb4E/euKZu+eg6Yw7SUGgTExLVElCNjz7KFw6b7OTYCIxZDDRiaXj5nIbj32oJP5PRphAPxPk7HzXH7iWgV++Lbs2tdMth5gfXDkVLZUqNjPyxS6O3ATQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K7Iams6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94612C4CEF7;
	Tue, 17 Mar 2026 17:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767028;
	bh=xszVIwFPtspbgLHCJs+G6Od3/OPL4eHLtuuklTkg4I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K7Iams6w4fmiIKYZ+3QssA9K73TaM2Wp/zLNPEhwLCcSrdQ+CXtJWc6tP+QFFj4U+
	 Bu/579mKNHVROonAMggDYOoyfechxz18ztl6/AmCTFlN8S0z/mUC2kofC80MhV3Boz
	 mHgxghdm3sBAicDuqc5AMTtaHQLmNxWCjOSanPYA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.19 345/378] btrfs: abort transaction on failure to update root in the received subvol ioctl
Date: Tue, 17 Mar 2026 17:35:02 +0100
Message-ID: <20260317163019.684146420@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226511-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74FFE2AFB2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 0f475ee0ebce5c9492b260027cd95270191675fa upstream.

If we failed to update the root we don't abort the transaction, which is
wrong since we already used the transaction to remove an item from the
uuid tree.

Fixes: dd5f9615fc5c ("Btrfs: maintain subvolume items in the UUID tree")
CC: stable@vger.kernel.org # 3.12+
Reviewed-by: Anand Jain <asj@kernel.org>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ioctl.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3987,7 +3987,8 @@ static long _btrfs_ioctl_set_received_su
 
 	ret = btrfs_update_root(trans, fs_info->tree_root,
 				&root->root_key, &root->root_item);
-	if (ret < 0) {
+	if (unlikely(ret < 0)) {
+		btrfs_abort_transaction(trans, ret);
 		btrfs_end_transaction(trans);
 		goto out;
 	}



