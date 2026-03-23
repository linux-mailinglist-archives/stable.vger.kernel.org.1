Return-Path: <stable+bounces-229558-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAaHIChswWkVTAQAu9opvQ
	(envelope-from <stable+bounces-229558-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:36:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E24012F8707
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 463433068ADD
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181B53A960E;
	Mon, 23 Mar 2026 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GKjKRstf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C5E3AC0D3;
	Mon, 23 Mar 2026 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282245; cv=none; b=m2GpmluKY1A7IuF+MszGADbQJpSRxYpO2m2kvVLNPZtyHc6nE6gfH5+OZx8pJMpVHZln0S71eeoZlFqCl9v9nNbhHWxjcxcp5d/TydEw1pp0w5lsIsJVp+csXU2etXHfz7Hqw8xGtE0iVMuV30sIsV3DP3H2noxePKJdl4/1vPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282245; c=relaxed/simple;
	bh=zdManzZpe2MUMLbbh7v5Gethcb/9etrvOKevD3uaBkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ml+lWktLnuIVo801cEO4pgMngMw/k5NuvDRq1gf0cwYs6Aw6a/cg1jbNjHPErV6HXSG/HGFvtFInguFSI7dFKEUFBsmmhJpohFwAtBW/aZnOY6cceLFecj9xnhO6V6+sIxwd0N46K/D8h7XcJ2w5mAGivQAXfvj25biTICCH+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GKjKRstf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E0FC4CEF7;
	Mon, 23 Mar 2026 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282245;
	bh=zdManzZpe2MUMLbbh7v5Gethcb/9etrvOKevD3uaBkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GKjKRstf7e14pZSW2UTq9XyM6PpNkf0VtMg+SsCLHTjX674GVYXsfJ+83sEJ7FNOp
	 cT3Oh0P6X77PhV4YbkNRcRTcn4RtSSTIXjVgE76qZIc6XhLCSvVVsez911yXWQb0k5
	 NBXR2Bsh3pxtoNvBkfHl5buaVa+R/SqqUfO5uWis=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 048/481] ext4: remove unnecessary e4b->bd_buddy_page check in ext4_mb_load_buddy_gfp
Date: Mon, 23 Mar 2026 14:40:30 +0100
Message-ID: <20260323134526.402114313@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229558-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E24012F8707
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kemeng Shi <shikemeng@huaweicloud.com>

[ Upstream commit 285164b80175157c18a06425cf25591c9f942b1a ]

e4b->bd_buddy_page is only set if we initialize ext4_buddy successfully. So
e4b->bd_buddy_page is always NULL in error handle branch. Just remove the
dead check.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://lore.kernel.org/r/20230303172120.3800725-11-shikemeng@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: bdc56a9c46b2 ("ext4: fix e4b bitmap inconsistency reports")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 71e15007ffdf4..7431ff97a68c8 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1599,8 +1599,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 		put_page(page);
 	if (e4b->bd_bitmap_page)
 		put_page(e4b->bd_bitmap_page);
-	if (e4b->bd_buddy_page)
-		put_page(e4b->bd_buddy_page);
+
 	e4b->bd_buddy = NULL;
 	e4b->bd_bitmap = NULL;
 	return ret;
-- 
2.51.0




