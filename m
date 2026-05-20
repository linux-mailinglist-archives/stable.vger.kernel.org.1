Return-Path: <stable+bounces-250938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALneAxX1DWry4wUAu9opvQ
	(envelope-from <stable+bounces-250938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:53:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABEE594D48
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C45413131E4E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949203D7D67;
	Wed, 20 May 2026 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FBlzR0N2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FEA37D101;
	Wed, 20 May 2026 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296681; cv=none; b=G5WoewcfQlKjq06HpoPn4g8smNxtheCJr7eaIkwcgjwCoK4ZKeoTindMewtSr2CzqxqXWNjc87aIkDcG3eduWI8jA2zVcC4rXYqvLUxBJSVIT7M2BNO2Xae98rTRzZ93dK7RKQf3jYhBRc/IAbt10QW6IKlFmc7dYdX/meRXT6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296681; c=relaxed/simple;
	bh=Pa4Vo5omwQw93kEAXBrKnpQkBYU7XbsNY9r40ZSdwBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stvQTVILv0eN9E0BmUygoUgtfwOW1EVceZ/+7Sx/mMoOOeSa6XKoi4NJJJOU/5Qs/SjFLEKWxI81TU0V3pSsmJKFuVzF9wnKBje5S9vb9ugFr/QkMb4MTKmclS1EffZl23ESw7MvPMU6vNRQBSXTgPUx2/WWYBepGk5P0ZORw0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FBlzR0N2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF9F1F000E9;
	Wed, 20 May 2026 17:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296680;
	bh=ZKZwMcIB2K3fbLhY5vmYsuXxGMtqBHjhzoyPsFgUL+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FBlzR0N2mk/xdqGLWaCgI2/JHf46nQkfqOdSmPrn3eBvMqlEesVrINiksBFUME9Aq
	 UXthrfyDNKvv7VluSbd6530lkPBhvrKVWR+339MltR6sF3WlRwmhIbcavGhXT/1zJ+
	 2hhfRJcvxtPotcEPAESsnWI2lDPom5gvglJinePk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Harmstone <mark@harmstone.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0891/1146] btrfs: dont clobber errors in add_remap_tree_entries()
Date: Wed, 20 May 2026 18:19:01 +0200
Message-ID: <20260520162208.400896996@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250938-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.com:email,harmstone.com:email]
X-Rspamd-Queue-Id: 0ABEE594D48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Harmstone <maharmstone@fb.com>

[ Upstream commit 44366af74061793ee5ceef455a4f0e465892d0de ]

In add_remap_tree_entries(), we only process a certain number of entries
at a time, meaning we may need to loop.

But because we weren't checking the return value of btrfs_insert_empty_items()
within the loop, this meant that if the last iteration of the loop
succeeded but a previous iteration failed, we were erroneously returning
0.

Fix this by breaking the loop early if btrfs_insert_empty_items() fails.

Fixes: b56f35560b82 ("btrfs: handle setting up relocation of block group with remap-tree")
Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/relocation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index a6965abbab719..d8cd04fe9a4cd 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3884,7 +3884,7 @@ static int add_remap_tree_entries(struct btrfs_trans_handle *trans, struct btrfs
 		ret = btrfs_insert_empty_items(trans, fs_info->remap_root, path, &batch);
 		btrfs_release_path(path);
 
-		if (num_entries <= max_items)
+		if (ret || num_entries <= max_items)
 			break;
 
 		num_entries -= max_items;
-- 
2.53.0




