Return-Path: <stable+bounces-220569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCadCeg+o2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:15:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A571C6C16
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 631B33416257
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15533DBD37;
	Sat, 28 Feb 2026 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1yBVa/I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D003DBD31;
	Sat, 28 Feb 2026 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300450; cv=none; b=gfYNaGGVewQUPbNhblH4IYk2Sl2C65ylhovfcNTHvddyJvXVyjKp9mJ0LcxsfH4K2KDlo3nJ8zReAxav1aoZLr6qx74+sDsk34k6vsMb7uzvaznKSMrvHtIAqC7NPWqC+7xLsoMNCaoXvj2SXvSrLxaqdseOspeAxiC23bXNRSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300450; c=relaxed/simple;
	bh=H4+M4frMpuu9VZziEWFTpF/5sUXIheXRCgWyulN+qZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHOyFzbdgd1/Bj+6jLpdKNe/AIXW5rAv949Ok5DqrnZusvHNqXBW6f7SDcVOxkUa9qtC7eACN+kbtalUFlNwMtSV7ll8Zegk7FPKmfQl7qJCnyDPyJUGjNoSScwGJei6+16m5tsthdW1Op6BWaFWeokmY2mkmEFzftGbtKPZ0g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1yBVa/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B68C19423;
	Sat, 28 Feb 2026 17:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300450;
	bh=H4+M4frMpuu9VZziEWFTpF/5sUXIheXRCgWyulN+qZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F1yBVa/IiPlA1IMMXVSlB+LzF83M1ni8ip8r4O0iSr3EjUrIfKeKGyCe09hjhFGHS
	 l3TqRqlrT2OvljuV5WDQoCy3Bf9sI6gWY4wcmzghAnZveERpH77Azhg2L1LJTu1AAy
	 PblIkjChcg9Y89hV9kXnVrAYtvIXleMOSVfE+szU7WkwtDsRa97NdXq51ftwPMQQqO
	 Gn/utEaSRIHHKGkJhhxUu43wTjwxoixvMGbRY6wZ34mGN5OF35a7/lqs/YdHqrv+OG
	 SstkWjsT+1AWCLS2bMQJN+ByYiExucirvaQaFFqpAXHrLpsXEntj4Xv3lYvurHx0VC
	 n6Zm8QzRIvL7w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+d988dc155e740d76a331@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 490/844] erofs: fix interlaced plain identification for encoded extents
Date: Sat, 28 Feb 2026 12:26:43 -0500
Message-ID: <20260228173244.1509663-491-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220569-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.976];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,d988dc155e740d76a331];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,alibaba.com:email]
X-Rspamd-Queue-Id: 47A571C6C16
X-Rspamd-Action: no action

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 4a2d046e4b13202a6301a993961f5b30ae4d7119 ]

Only plain data whose start position and on-disk physical length are
both aligned to the block size should be classified as interlaced
plain extents. Otherwise, it must be treated as shifted plain extents.

This issue was found by syzbot using a crafted compressed image
containing plain extents with unaligned physical lengths, which can
cause OOB read in z_erofs_transform_plain().

Reported-and-tested-by: syzbot+d988dc155e740d76a331@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/699d5714.050a0220.cdd3c.03e7.GAE@google.com
Fixes: 1d191b4ca51d ("erofs: implement encoded extent metadata")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zmap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index c8d8e129eb4ba..30775502b56da 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -513,6 +513,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 	unsigned int recsz = z_erofs_extent_recsize(vi->z_advise);
 	erofs_off_t pos = round_up(Z_EROFS_MAP_HEADER_END(erofs_iloc(inode) +
 				   vi->inode_isize + vi->xattr_isize), recsz);
+	unsigned int bmask = sb->s_blocksize - 1;
 	bool in_mbox = erofs_inode_in_metabox(inode);
 	erofs_off_t lend = inode->i_size;
 	erofs_off_t l, r, mid, pa, la, lstart;
@@ -596,17 +597,17 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 			map->m_flags |= EROFS_MAP_MAPPED |
 				EROFS_MAP_FULL_MAPPED | EROFS_MAP_ENCODED;
 			fmt = map->m_plen >> Z_EROFS_EXTENT_PLEN_FMT_BIT;
+			if (map->m_plen & Z_EROFS_EXTENT_PLEN_PARTIAL)
+				map->m_flags |= EROFS_MAP_PARTIAL_REF;
+			map->m_plen &= Z_EROFS_EXTENT_PLEN_MASK;
 			if (fmt)
 				map->m_algorithmformat = fmt - 1;
-			else if (interlaced && !erofs_blkoff(sb, map->m_pa))
+			else if (interlaced && !((map->m_pa | map->m_plen) & bmask))
 				map->m_algorithmformat =
 					Z_EROFS_COMPRESSION_INTERLACED;
 			else
 				map->m_algorithmformat =
 					Z_EROFS_COMPRESSION_SHIFTED;
-			if (map->m_plen & Z_EROFS_EXTENT_PLEN_PARTIAL)
-				map->m_flags |= EROFS_MAP_PARTIAL_REF;
-			map->m_plen &= Z_EROFS_EXTENT_PLEN_MASK;
 		}
 	}
 	map->m_llen = lend - map->m_la;
-- 
2.51.0


