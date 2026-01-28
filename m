Return-Path: <stable+bounces-211994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNO5LQ0remnK3gEAu9opvQ
	(envelope-from <stable+bounces-211994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:28:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 125DFA3CE7
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C0C1300C7EC
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8728C36C0CF;
	Wed, 28 Jan 2026 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Viv3AG2L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1699236C0C7;
	Wed, 28 Jan 2026 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614042; cv=none; b=m6kb3vAi2Lh1o/lk5V1e9GibqKzuln6DcYW8ZBla0zgYPU334ozPAo6J4nWJXDlLFCEYMNmbgFN1+gNmF3R/6IZbnPWwgQxbqmyDfVn8Pm8ieK/2a0xEuezhNl/wa0ATBmF8aNhNp3pztzajpGTgbUk18I8R/xe+clFVwklrioI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614042; c=relaxed/simple;
	bh=D2oZRhmTJAiRSuiccxUCtQ4Gcmhj1FYFDviPe2B/TkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPvogvbGNH+Rg5DQVtBHZAN3nKd/hbvasv/SXxx/ABgkZbL4i8ZbNYtSbsCTOFK0i0am5DDXoeehQXK133Fo/giSaPQgx2wE7DGYxc3/hxTPUb66FkpjQZcFcqNJSc89oEp7JL92W0ynxQeAvShhzA4apj6V5V3twattGAmwVo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Viv3AG2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAF7C4CEF1;
	Wed, 28 Jan 2026 15:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614041;
	bh=D2oZRhmTJAiRSuiccxUCtQ4Gcmhj1FYFDviPe2B/TkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Viv3AG2LIeQUPtchreLJ7o2rQOmVGsKt2P7Psg047yteqbcgVZL3gO07aC0DmULuN
	 bgPqbM4f7U+LZ0tI6peFGZmYNUAUzZ7LS1S8KLmjc9ymAhEmG7plYcWbXjHV1y8ZSq
	 KLwVbjk2Wd9+IGys2z9DV5Gvr6QxpetThDNVc+3o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 019/254] btrfs: store fs_info in space_info
Date: Wed, 28 Jan 2026 16:19:55 +0100
Message-ID: <20260128145345.397708537@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211994-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[bur.io:server fail];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,toxicpanda.com:email,wdc.com:email]
X-Rspamd-Queue-Id: 125DFA3CE7
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Burkov <boris@bur.io>

[ Upstream commit 42f620aec182f62ee72e3fce41cb3353951b3508 ]

This is handy when computing space_info dynamic reclaim thresholds where
we do not have access to a block group. We could add it to the various
functions as a parameter, but it seems reasonable for space_info to have
an fs_info pointer.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: a11224a016d6 ("btrfs: fix memory leaks in create_space_info() error paths")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/space-info.c | 1 +
 fs/btrfs/space-info.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 27690c518f6d7..bf5e509eb9fa8 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -233,6 +233,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 	if (!space_info)
 		return -ENOMEM;
 
+	space_info->fs_info = info;
 	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++)
 		INIT_LIST_HEAD(&space_info->block_groups[i]);
 	init_rwsem(&space_info->groups_sem);
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index b0187f25dbb5e..39452e36625ae 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -84,6 +84,7 @@ enum btrfs_flush_state {
 };
 
 struct btrfs_space_info {
+	struct btrfs_fs_info *fs_info;
 	spinlock_t lock;
 
 	u64 total_bytes;	/* total bytes in the space,
-- 
2.51.0




