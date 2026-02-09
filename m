Return-Path: <stable+bounces-215034-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KAxIzjxiWnyEgAAu9opvQ
	(envelope-from <stable+bounces-215034-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:37:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7C411090C
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ACFA3043BE0
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F355336BCF5;
	Mon,  9 Feb 2026 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o8VaDcft"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B774A23B604;
	Mon,  9 Feb 2026 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647453; cv=none; b=duQ4m/LJPPkZS1zslsfUSkk4oaGrDcWuRZ22/lWpcbhtHTBQZUrEUKPqVhnJGowLu4PIIhTAFqRZaAR1BrpypBLwoywyTpO9XwdjoUySqjjR+OMRMhBb5t6CCAuFaNZDDRsRqMYam4U+b8Nrovn6XS5yZpQYar42iEtVaU1yd+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647453; c=relaxed/simple;
	bh=R9XJBQnDP4SAoojy/oZJSJeNzLZB8yqZRy9tluVapfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtSlqpdd0bpmT5nmI3zDWciB6QXS3zNQAof4g9bf+tJn+QytGj1iNXWw+Ii2mKTLDFBv0e1Fv3TdNrDzD5c6hWi/ZM/k1qkLxbsH80aK+vqPW7rmROLUrT6Jw8/S4/Zq7j7ZwEQgMVi3WtzkmxYP38f0ir2EwrwJBpF5vdobyWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o8VaDcft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349FEC116C6;
	Mon,  9 Feb 2026 14:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647453;
	bh=R9XJBQnDP4SAoojy/oZJSJeNzLZB8yqZRy9tluVapfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o8VaDcfteirD6Dftn7a9YhHaDck+mXsaP4t3ZbIADdhfvLism3cP7qvdqamobV5WI
	 6+sTjhln8/UrRKsW1K3bJHOa/oHCbsKLWF5jlOPfS0wFzftq34R26CKYYxrNosbsXn
	 IJG1gvcSHh37bYAZP2yuVaXKR6I8X58ea4rxSixw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qiang Ma <maqianga@uniontech.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 105/175] btrfs: fix Wmaybe-uninitialized warning in replay_one_buffer()
Date: Mon,  9 Feb 2026 15:22:58 +0100
Message-ID: <20260209142324.191895639@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215034-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniontech.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.com:email]
X-Rspamd-Queue-Id: 0C7C411090C
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qiang Ma <maqianga@uniontech.com>

[ Upstream commit 9c7e71c97c8cd086b148d0d3d1cd84a1deab023c ]

Warning was found when compiling using loongarch64-gcc 12.3.1:

  $ make CFLAGS_tree-log.o=-Wmaybe-uninitialized

  In file included from fs/btrfs/ctree.h:21,
		   from fs/btrfs/tree-log.c:12:
  fs/btrfs/accessors.h: In function 'replay_one_buffer':
  fs/btrfs/accessors.h:66:16: warning: 'inode_item' may be used uninitialized [-Wmaybe-uninitialized]
     66 |         return btrfs_get_##bits(eb, s, offsetof(type, member));         \
	|                ^~~~~~~~~~
  fs/btrfs/tree-log.c:2803:42: note: 'inode_item' declared here
   2803 |                 struct btrfs_inode_item *inode_item;
	|                                          ^~~~~~~~~~

Initialize the inode_item to NULL, the compiler does not seem to see the
relation between the first 'wc->log_key.type == BTRFS_INODE_ITEM_KEY'
check and the other one that also checks the replay phase.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 1444857de9fe8..ae2e035d013e2 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2800,7 +2800,7 @@ static int replay_one_buffer(struct extent_buffer *eb,
 
 	nritems = btrfs_header_nritems(eb);
 	for (wc->log_slot = 0; wc->log_slot < nritems; wc->log_slot++) {
-		struct btrfs_inode_item *inode_item;
+		struct btrfs_inode_item *inode_item = NULL;
 
 		btrfs_item_key_to_cpu(eb, &wc->log_key, wc->log_slot);
 
-- 
2.51.0




