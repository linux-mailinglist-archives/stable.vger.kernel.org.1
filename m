Return-Path: <stable+bounces-213802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENX4OnFlg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:27:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76357E89E8
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D30E319231A
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0151B423A7A;
	Wed,  4 Feb 2026 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gbd6g9RN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0C8423A71;
	Wed,  4 Feb 2026 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217559; cv=none; b=pMTm+NyjG6wD0OolWrClGxf2FjTvyxV1dvYNrloSiBvjyklLKqQvLR93n0M0z1xuKHRn4ILxmic5u31NMUoEfIn/ryXNHs/Fz3V9A1+etJreXK2Mzilbw5qqidl062frLVxa8lnSbzdMKXVGS2e0+gn1GwsJPKo1PSjPXv2gc6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217559; c=relaxed/simple;
	bh=p9TWvBUtE1JjcQA8+MWrotYSz6i7RBqD/J0Oj0Pp4Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncoh8fYGm3RgMmbYpcO2eutLEkxFhhFFxO3ezQRaiXNFQGwWcCZfNYWp+e4N4Ip+ZkvtmNfDoiUIIesc304SReVq68Tu3epsC7DPDXBPM6fGQt/uPLZujAdmAdlJalrsQBcdkcPoGO36crwKmkKOu/k/9ciiAmKFWl7cgoBpyLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gbd6g9RN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC77C4CEF7;
	Wed,  4 Feb 2026 15:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217559;
	bh=p9TWvBUtE1JjcQA8+MWrotYSz6i7RBqD/J0Oj0Pp4Q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gbd6g9RNchD38KqmgzOssasRUaUKpbwEtTuSjC2hV82k8eSbTX6DPDPQ8IfjlVULA
	 hyIf6+3nvPA1DzV71f/OT5q0XPxPEO0rI7hX/goKA/pam2QOUwTjpixILZ/XbGPyod
	 vve7DNCO8iE9lTTUIJSzT9PsI4iGqjvjQvyq9KNI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 017/280] btrfs: store fs_info in space_info
Date: Wed,  4 Feb 2026 15:36:31 +0100
Message-ID: <20260204143910.251856299@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213802-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.com:email,bur.io:email,wdc.com:email]
X-Rspamd-Queue-Id: 76357E89E8
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index bede72f3dffc3..069df2ebd1ca5 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -230,6 +230,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 	if (!space_info)
 		return -ENOMEM;
 
+	space_info->fs_info = info;
 	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++)
 		INIT_LIST_HEAD(&space_info->block_groups[i]);
 	init_rwsem(&space_info->groups_sem);
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index fea2f93674e7c..d6b34f2738b53 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -65,6 +65,7 @@ enum btrfs_flush_state {
 };
 
 struct btrfs_space_info {
+	struct btrfs_fs_info *fs_info;
 	spinlock_t lock;
 
 	u64 total_bytes;	/* total bytes in the space,
-- 
2.51.0




