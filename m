Return-Path: <stable+bounces-263919-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L1L3EhRrMWpniwUAu9opvQ
	(envelope-from <stable+bounces-263919-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:26:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F3269105A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:26:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Vp28C5hl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263919-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263919-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54618320A192
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0EF44BCB5;
	Tue, 16 Jun 2026 15:19:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D44744102A;
	Tue, 16 Jun 2026 15:19:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623176; cv=none; b=V13Meht0cOQp1VoXm/8cqR6BGvOblMqWkRE6aBECqV3UKWpXee5zt2q54UF5uuQwOIhpt1PMBnaY6NgIpTXib1ybwiIyi5a8mXK9ymcwNrOohLLUnj0JnxrHgZ26jKohfJiL185yap/fpIKokms92OMr3KnRT+5vKbRedkOToLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623176; c=relaxed/simple;
	bh=5PKjrfsKkHUKBS6S7zDQNQrVZ86eVdWp+lklTVDd0k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcJWEbd+WHwHBA/CQzMBRjoMrWcbswgC9NcgVamHiEgVlBIzrl/QEMGw3hcEiYn5/BQdAne5Ppygz7TLmVPZn/5u5E0hh/NbOK0pqmC6SlKw6VWxnsJUw3z2cnLUCkFfsnBIyqXPhK1WecmtFjFGdDrpFOd5mHRjuOClvDVCuoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vp28C5hl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070E41F00A3D;
	Tue, 16 Jun 2026 15:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623175;
	bh=nd2oQN8UghwGloAImDZ1RvC1wNfJEzQutAQUqc6xgA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vp28C5hl4Jfya1FAW0RI3PTfCCdMHYo85QBmDHwYhYxOvz35GJFS0wNgd0lYxtLX3
	 kTmBiLHZl/n+7S8j1UrrlKBkDCr2I9dAyy7xpkAHXD9FruU0eJTIFDCVyECYvFPQj6
	 SUwGKKzASI/cFKRpzCi+iQZfztQPdbZYZSx9kvGY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Logan Gunthorpe <logang@deltatee.com>,
	Li RongQing <lirongqing@baidu.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 099/378] dma-mapping: direct: fix missing mapping for THRU_HOST_BRIDGE segments
Date: Tue, 16 Jun 2026 20:25:30 +0530
Message-ID: <20260616145115.543439864@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263919-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:logang@deltatee.com,m:lirongqing@baidu.com,m:m.szyprowski@samsung.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,samsung.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39F3269105A

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit 560000d619ef162568746ce287f0c725e24ea967 ]

In dma_direct_map_sg(), the case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE
incorrectly used 'break' instead of falling through to MAP_NONE.
As a result, segments traversing the host bridge skipped the required
dma_direct_map_phys() call entirely, leaving sg->dma_address
uninitialized and leading to DMA failures. Fix this by using
'fallthrough;'.

Fixes: a25e7962db0d79 ("PCI/P2PDMA: Refactor the p2pdma mapping helpers")
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20260603013723.2439-1-lirongqing@baidu.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8f43a930716d46..306afebf54ef06 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -466,7 +466,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 			 * must be mapped with CPU physical address and not PCI
 			 * bus addresses.
 			 */
-			break;
+			fallthrough;
 		case PCI_P2PDMA_MAP_NONE:
 			sg->dma_address = dma_direct_map_phys(dev, sg_phys(sg),
 					sg->length, dir, attrs);
-- 
2.53.0




