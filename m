Return-Path: <stable+bounces-247814-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JJ0Acg2B2rftQIAu9opvQ
	(envelope-from <stable+bounces-247814-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:07:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4BA551E05
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 129893023A7B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7B548B36A;
	Fri, 15 May 2026 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7obqKi6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0D7292B54
	for <stable@vger.kernel.org>; Fri, 15 May 2026 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857652; cv=none; b=soPZm4jukEEtxus/7RcMM3zQOthNjIoaUymAmfI5TJ882BFvsJfpOYPEskFpapXYMUYpB+0G2/7kO7gP6Xitlf0xzW650YiTKOWhR5ojlspkO+w5Sd6xfyS5FTAG7sQeF4qkanQneMNNnGWSKrwHmtk9PZ0TiXOFhLSqL48tpHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857652; c=relaxed/simple;
	bh=VC3VzQC92VSWac9gUcFBODYkxJh4BnXya38wrIejrJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PO1DXht9lGrGDFtZ2k10ygpbOGDrzjNfK2UgkBDiPNpjcAL9xnLLjwmBdApz+IFWONIaxVUMxwJfP+YutBS/Puh4q5iTf6MtCP1X1DChQqbMfmTIjpXrTe8tfdyJC6gqKpwhWRVVWhyfc57WcLgNALWo1w7QUyRIl3UTB3bMjBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7obqKi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F11C2BCB7;
	Fri, 15 May 2026 15:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778857652;
	bh=VC3VzQC92VSWac9gUcFBODYkxJh4BnXya38wrIejrJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W7obqKi6JTWMMKZKYWJU1uqRF3wcbsn8uLTBZeupP95vNXB7mZGeOUZdYr2+ACBrp
	 U0U6V1gj1E1Gul3HggxsbV9uMRUNkoC9trvk0xPs2eFfstxMadebfM39PzvM6025X1
	 i7IQjZQTODuzyqlfOOUiQU/OG0Czm7b95y2bTgBjnj+IMAKMb9BJygkYaAxDdL9Ph7
	 fUmKbvlULJ7N4lGjqJt6ZSstjEeXV7JKIky7M7Ub/0SA4nR4dSU97tQhuJOSiAwb0d
	 NzLP6mye+NdjBYUftr4uHWg9+f9cxCOwAPFEfWcY3V971t+CdRzin33HITGxFE/nt3
	 n5yBvY15EBNVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] btrfs: fix double free in create_space_info_sub_group() error path
Date: Fri, 15 May 2026 11:07:28 -0400
Message-ID: <20260515150728.3262445-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515150728.3262445-1-sashal@kernel.org>
References: <2026051235-backboard-scallion-e606@gregkh>
 <20260515150728.3262445-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6F4BA551E05
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247814-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit a7449edf96143f192606ec8647e3167e1ecbd728 ]

When kobject_init_and_add() fails, the call chain is:

create_space_info_sub_group()
-> btrfs_sysfs_add_space_info_type()
-> kobject_init_and_add()
-> failure
-> kobject_put(&sub_group->kobj)
-> space_info_release()
-> kfree(sub_group)

Then control returns to create_space_info_sub_group(), where:

btrfs_sysfs_add_space_info_type() returns error
-> kfree(sub_group)

Thus, sub_group is freed twice.

Keep parent->sub_group[index] = NULL for the failure path, but after
btrfs_sysfs_add_space_info_type() has called kobject_put(), let the
kobject release callback handle the cleanup.

Fixes: f92ee31e031c ("btrfs: introduce btrfs_space_info sub-group")
CC: stable@vger.kernel.org # 6.18+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/space-info.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 71d3ecd4849c4..099253002420b 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -260,10 +260,8 @@ static int create_space_info_sub_group(struct btrfs_space_info *parent, u64 flag
 	sub_group->subgroup_id = id;
 
 	ret = btrfs_sysfs_add_space_info_type(sub_group);
-	if (ret) {
-		kfree(sub_group);
+	if (ret)
 		parent->sub_group[index] = NULL;
-	}
 	return ret;
 }
 
-- 
2.53.0


