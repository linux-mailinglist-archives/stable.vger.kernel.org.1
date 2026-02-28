Return-Path: <stable+bounces-220731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qObyD0dVo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:51:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F7F1C8929
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14B0E3276C92
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C57448C8DA;
	Sat, 28 Feb 2026 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIy/ztAc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1AB3FFADA;
	Sat, 28 Feb 2026 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300612; cv=none; b=G/zdTh/Lw+ZS7P0Ak2jUz/uxo6OLY6Z6cqhphtzENLFHCO+k2V5yz/aSzGzdor/LBtCFPAhBu0DlGxrzTa33MAxfkV2jzzurExIS86t6zBARBvolSmi7XiiPj6ddR0XFr9la5TfiJbfjOAW4UEumYopncLoel9FzV3XDvmSOXIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300612; c=relaxed/simple;
	bh=hbXZtEnI7h+qFxH3cDPv4Wg6WkTxhKe9oHLMa70Ar48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYRCoELrkJ2r0n3HXjJ/G+lfPUcqd6MtoeT8N6hjVfgtObG7LqQQd2qYNErcGcvZMbvoVwUr02Ylx2+pGcVK7xTx0VR7TnNQSuxqPrI9YDIykCunIeWzOSA/nRevYoabE2AdjCNDyPPA5ilqdVImQCmksQG1h2dhW4mcinOU0mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIy/ztAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB43C116D0;
	Sat, 28 Feb 2026 17:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300612;
	bh=hbXZtEnI7h+qFxH3cDPv4Wg6WkTxhKe9oHLMa70Ar48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MIy/ztAcxi/ZsxxADr1Nh9dNseXP/7rfqjQHoqm8pdJFaKiWhiJ9H0TP2O8u9GPwL
	 NjhRj9bd44at4G8cKIuER0ntLF0/S8wfVlQv0Ga/JfU/J8KLPuQj5eqADU14bgVnir
	 C8fgTjYpGepyMEflYs0mxPnza6mDcDqreU+VZ+M0k2foIbh2HqvFjLEQoWnJQhGqhc
	 x4gdXGB8uUHMDSXHNdzJrPJflLzl7okcklJOSvB8W6LfVJ2lA5puuPI1kF+FdnqtHJ
	 MGw25YIvdIeUSAykTAlx+E3cmPlsXvzMnFyh5wHbYEAdplN9aajrsxJ/rT1cRMAN/O
	 Ar3d49oUqIxzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 652/844] xfs: mark data structures corrupt on EIO and ENODATA
Date: Sat, 28 Feb 2026 12:29:25 -0500
Message-ID: <20260228173244.1509663-653-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220731-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98F7F1C8929
X-Rspamd-Action: no action

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit f39854a3fb2f06dc69b81ada002b641ba5b4696b ]

I learned a few things this year: first, blk_status_to_errno can return
ENODATA for critical media errors; and second, the scrub code doesn't
mark data structures as corrupt on ENODATA or EIO.

Currently, scrub failing to capture these errors isn't all that
impactful -- the checking code will exit to userspace with EIO/ENODATA,
and xfs_scrub will log a complaint and exit with nonzero status.  Most
people treat fsck tools failing as a sign that the fs is corrupt, but
online fsck should mark the metadata bad and keep moving.

Cc: stable@vger.kernel.org # v4.15
Fixes: 4700d22980d459 ("xfs: create helpers to record and deal with scrub problems")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/btree.c   | 2 ++
 fs/xfs/scrub/common.c  | 4 ++++
 fs/xfs/scrub/dabtree.c | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/fs/xfs/scrub/btree.c b/fs/xfs/scrub/btree.c
index acade92c5fce1..b497f6a474c77 100644
--- a/fs/xfs/scrub/btree.c
+++ b/fs/xfs/scrub/btree.c
@@ -42,6 +42,8 @@ __xchk_btree_process_error(
 		break;
 	case -EFSBADCRC:
 	case -EFSCORRUPTED:
+	case -EIO:
+	case -ENODATA:
 		/* Note the badness but don't abort. */
 		sc->sm->sm_flags |= errflag;
 		*error = 0;
diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index 7bfa37c99480f..5f9be4151d722 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -103,6 +103,8 @@ __xchk_process_error(
 		break;
 	case -EFSBADCRC:
 	case -EFSCORRUPTED:
+	case -EIO:
+	case -ENODATA:
 		/* Note the badness but don't abort. */
 		sc->sm->sm_flags |= errflag;
 		*error = 0;
@@ -177,6 +179,8 @@ __xchk_fblock_process_error(
 		break;
 	case -EFSBADCRC:
 	case -EFSCORRUPTED:
+	case -EIO:
+	case -ENODATA:
 		/* Note the badness but don't abort. */
 		sc->sm->sm_flags |= errflag;
 		*error = 0;
diff --git a/fs/xfs/scrub/dabtree.c b/fs/xfs/scrub/dabtree.c
index 056de4819f866..a6a5d3a75d994 100644
--- a/fs/xfs/scrub/dabtree.c
+++ b/fs/xfs/scrub/dabtree.c
@@ -45,6 +45,8 @@ xchk_da_process_error(
 		break;
 	case -EFSBADCRC:
 	case -EFSCORRUPTED:
+	case -EIO:
+	case -ENODATA:
 		/* Note the badness but don't abort. */
 		sc->sm->sm_flags |= XFS_SCRUB_OFLAG_CORRUPT;
 		*error = 0;
-- 
2.51.0


