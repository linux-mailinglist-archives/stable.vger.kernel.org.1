Return-Path: <stable+bounces-264608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8nE2M6Z6MWqYkQUAu9opvQ
	(envelope-from <stable+bounces-264608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:32:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C666922EB
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:32:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ghlPnq39;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264608-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264608-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC8DF31E4C22
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE5337DEBF;
	Tue, 16 Jun 2026 16:20:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8F035AC1E;
	Tue, 16 Jun 2026 16:19:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626800; cv=none; b=JmfOnF/dSnLgM0ZWkz5hPHlBtiyQx6gTHvt9bMbFpAVyw8+sS84XCKhpG6tg6Zc0gIgPKfnJWXn6PhNqYXlW/IFVofarmNV9Tz73oWNRS+PoMnUUutDP+s1c+xEJPZKYtRP0ssGB98tCAqn9rh2MoSnljAqBAP0Qg4Il6HYm6hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626800; c=relaxed/simple;
	bh=ouj4tCVAgGurB52+rPJg7NQvfDDExNYbEtTuVoTWEzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4RvMLRGKBeDjG+GmJMcvaFHsOsz3Kz//hyt3uOJck5wenfYjLcOpQdPQnaCT796DfQfuos5L8GDqV/ssPShYRoishHqh5kJV47Bam3EPihhocu1klZYPQejLkoLIVk9n0h+rdMQvO26Uy0GLaauu0Gt4TjvuKX9A6bhRquVho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ghlPnq39; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D8C1F000E9;
	Tue, 16 Jun 2026 16:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781626798;
	bh=qmHjyq7LORLwUG/bUJdxssYolVOJESXRDUpZFnD0uyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ghlPnq39JTHGmw4YGNIknbQ55mtLR3bkIM27/qMfUqw+BVoOpG3iXmtlg56TitmAJ
	 Fm0Xc/lkyMj0uDyxOEXtf8n0hWXodhDO5GtwTbo9rU30Cs8DtJyyppEBeiycCOiCbC
	 pZwD7hUkYTxOJU94L9Wv6lCFT8eJOgxVHwINA7OQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li RongQing <lirongqing@baidu.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 073/261] dma-debug: fix physical address retrieval in debug_dma_sync_sg_for_device
Date: Tue, 16 Jun 2026 20:28:31 +0530
Message-ID: <20260616145048.494689048@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-264608-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:lirongqing@baidu.com,m:m.szyprowski@samsung.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,samsung.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40C666922EB

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit 9bfaa86b405381326c971984fd6da184c289713f ]

In debug_dma_sync_sg_for_device(), when iterating over a scatterlist,
the debug entry population mistakenly uses the head of the scatterlist
'sg' to fetch the physical address via sg_phys(), instead of using the
current iterator variable 's'.

This causes dma-debug to track the physical address of the very first
scatterlist entry for all subsequent entries in the list.

Fix this by passing the correct loop iterator 's' to sg_phys()

Fixes: 9d4f645a1fd49ee ("dma-debug: store a phys_addr_t in struct dma_debug_entry")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20260603123708.1665-1-lirongqing@baidu.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 035dda07ab0d08..b1192cff035924 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1573,7 +1573,7 @@ void debug_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 		struct dma_debug_entry ref = {
 			.type           = dma_debug_sg,
 			.dev            = dev,
-			.paddr		= sg_phys(sg),
+			.paddr		= sg_phys(s),
 			.dev_addr       = sg_dma_address(s),
 			.size           = sg_dma_len(s),
 			.direction      = direction,
-- 
2.53.0




