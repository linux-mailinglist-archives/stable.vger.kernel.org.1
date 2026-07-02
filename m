Return-Path: <stable+bounces-270730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JgOxHAmfRmpmaQsAu9opvQ
	(envelope-from <stable+bounces-270730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:25:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8847D6FB4FB
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:25:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=vV0JT4rT;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270730-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270730-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE18D32736A6
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FF5339844;
	Thu,  2 Jul 2026 16:28:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4870C341077;
	Thu,  2 Jul 2026 16:28:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009701; cv=none; b=e76wtVtzXYzIpP5MZ3jZb2R/VDWygwO94qsXdJw30B6rF9zf/GQcKPCve4ZlnYFVt0skg/mUjR0jbXGaaH60NNl1ilk0D2Pr0peg5+mHK8OhymnOAGxFOuCzN1yCPDBdTLWVTTXZ9NQghbE3rfr+u7jKLkZd1hncN0MGoGut56Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009701; c=relaxed/simple;
	bh=nZZJlTNU6Js+AA+dDJT7GPmsRaGXyJC6YYh+SqayZHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrlhzfA4nkYyORSHd08n+/zZPFc8OgIXtAKKpVm7fxjcL4q9ZxArYE0BrVJ/1ZVCPzVO2mOt8McP0HVpEjtY5hL3ZXBUSikMPUUrFEJ18uE29dMWV7Wb+wpIoN/TslgY6IOGym9FQSn7p7v9E/NJrEtw80iK7WmNtCrg6HF8DkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vV0JT4rT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7CD1F000E9;
	Thu,  2 Jul 2026 16:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009699;
	bh=wLe+JtGZjnmRR0XMwUwUcWlISBdXm6dMUiTaNTkcfjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vV0JT4rTlyy5elPYRzStMAUmBczT7lImt9ItL4weuBAMg03xA7rgxXd6mDQ4UtIK9
	 3ocjcBm7bpA1+AkZ9J+tYnFUYMmfFqCPkfDff+m6XRNaSOnlqpjVdjj62l1gG4PhrE
	 XWh7a1V6uH8fV9uXe1mMywedpZcKgVo39PkoUkL4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuto Ohnuki <ytohnuki@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 55/95] ext4: add bounds check for inline data length in ext4_read_inline_page
Date: Thu,  2 Jul 2026 18:19:58 +0200
Message-ID: <20260702155110.365025501@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155109.196223802@linuxfoundation.org>
References: <20260702155109.196223802@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270730-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:ytohnuki@amazon.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,iloc.bh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8847D6FB4FB

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuto Ohnuki <ytohnuki@amazon.com>

[ Upstream commit 356227096eb66e41b23caf7045e6304877322edf ]

ext4_read_inline_page() does not validate that the inline data length
fits within a page before copying data. If the inline size exceeds
PAGE_SIZE due to filesystem corruption, this could lead to a kernel
memory write beyond the page boundary.

Add a bounds check after computing len, returning -EFSCORRUPTED if the
value exceeds PAGE_SIZE.

The upstream commit replaced a BUG_ON(len > PAGE_SIZE) in
ext4_read_inline_folio(). In 6.1 and earlier, the function is still named
ext4_read_inline_page() and the BUG_ON was never present, so this patch
adds the bounds check directly.

Fixes: 46c7f254543d ("ext4: add read support for inline data")
Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/inline.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index c5b1f9af230952..5d5f99ed974687 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -517,6 +517,14 @@ static int ext4_read_inline_page(struct inode *inode, struct page *page)
 		goto out;
 
 	len = min_t(size_t, ext4_get_inline_size(inode), i_size_read(inode));
+	if (len > PAGE_SIZE) {
+		ext4_error_inode(inode, __func__, __LINE__, 0,
+				 "inline size %zu exceeds PAGE_SIZE", len);
+		ret = -EFSCORRUPTED;
+		brelse(iloc.bh);
+		goto out;
+	}
+
 	kaddr = kmap_atomic(page);
 	ret = ext4_read_inline_data(inode, kaddr, len, &iloc);
 	flush_dcache_page(page);
-- 
2.53.0




