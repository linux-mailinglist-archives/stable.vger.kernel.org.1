Return-Path: <stable+bounces-220745-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAgkA05Ao2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220745-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:21:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FF91C6E31
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B415302AF3C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8BD402D71;
	Sat, 28 Feb 2026 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoBw3XAL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07ED402D67;
	Sat, 28 Feb 2026 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300625; cv=none; b=IYw+wBNBoxCYZvP7Ta5li9u6P1R1qMdwb2Oc8i18Q/GYo7j7naBmWu6TMvbpstuNcDra8JRwfl8HUN1ZJIYKTBAV+4FaRPxsiM9CRkOVWI03fqpZKrYQmXOfwN3dvCUlGCs5Ji60ZgBBLleIBm+kqqnrpaHUoN9I5y96fX+3YRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300625; c=relaxed/simple;
	bh=fp1s/Q7tHaLyjsrulurs6UUQlDGA8a88fPiCQOYui7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBHi08EUN6/TPSqV2RCbX7Y3p8LfOs6sMsLjJzkA8swZym3w+t7ZKfOxCc2p2GHbM6oOBWLqxUG/azhfVOg5COIlKOWZmCgTyy75+gBDI0eYb1L99281gfAlnkSLbOhTRhvLxwikgMtIyZtAFkj5fEsQq8jos6alIfP6H0HyGig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoBw3XAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E132CC19423;
	Sat, 28 Feb 2026 17:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300625;
	bh=fp1s/Q7tHaLyjsrulurs6UUQlDGA8a88fPiCQOYui7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GoBw3XALJEm64K8dv7x3gOnonuBrfgK3GeBcuHn54CDpaLABPm6OHEvhSCEwUl6Ys
	 S6RfvUGsXBIRmPXEWHMpDPuxgtWA0yMmpOM9LRYpjNPpbM5RtuyQCPfoAQ+3wM1+p+
	 swuQ7/Fn5LHucaBScYWceos1T5godkGrjHibAASbsF5AsJX7ZvL1iQKK/ubWAjfkSJ
	 2SXAv1AmBBpxIZUqZIDUYnz5bX8njaqC1WFpV6ro6Dv85qSvlNG0ESVovuuP6z0Hzh
	 4gQ0GIN+zVfsIv/mj/Hkd/S6jmz16jyM7cRhDH2e2p3+grfMpb4mMcdzgS43nTpoSD
	 4u71CgCxUH7zw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	stable@kernel.org,
	Hongbo Li <lihongbo22@huawei.com>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 666/844] erofs: fix incorrect early exits for invalid metabox-enabled images
Date: Sat, 28 Feb 2026 12:29:39 -0500
Message-ID: <20260228173244.1509663-667-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220745-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alibaba.com:email,huawei.com:email]
X-Rspamd-Queue-Id: 97FF91C6E31
X-Rspamd-Action: no action

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 643575d5a4f24b23b0c54aa20aa74a4abed8ff5e ]

Crafted EROFS images with metadata compression enabled can trigger
incorrect early returns, leading to folio reference leaks.

However, this does not cause system crashes or other severe issues.

Fixes: 414091322c63 ("erofs: implement metadata compression")
Cc: stable@kernel.org
Reviewed-by: Hongbo Li <lihongbo22@huawei.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 5136cda5972a9..b54083128e0f4 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -330,12 +330,13 @@ static int erofs_read_superblock(struct super_block *sb)
 	}
 	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
 	if (erofs_sb_has_metabox(sbi)) {
+		ret = -EFSCORRUPTED;
 		if (sbi->sb_size <= offsetof(struct erofs_super_block,
 					     metabox_nid))
-			return -EFSCORRUPTED;
+			goto out;
 		sbi->metabox_nid = le64_to_cpu(dsb->metabox_nid);
 		if (sbi->metabox_nid & BIT_ULL(EROFS_DIRENT_NID_METABOX_BIT))
-			return -EFSCORRUPTED;	/* self-loop detection */
+			goto out;		/* self-loop detection */
 	}
 	sbi->inos = le64_to_cpu(dsb->inos);
 
-- 
2.51.0


