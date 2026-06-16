Return-Path: <stable+bounces-264327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ODfSCW1yMWpGjgUAu9opvQ
	(envelope-from <stable+bounces-264327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:57:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A986918E7
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:57:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=RrPbGw1R;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264327-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264327-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B32BB3028B41
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B20A44D022;
	Tue, 16 Jun 2026 15:55:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CE944CAF9;
	Tue, 16 Jun 2026 15:55:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625325; cv=none; b=S9ou0O0aYdw6ralJWx0L4n9zkYVKK3z1To1Xg4/fEZ6+IMaZjt+dXNHUe4xAZxwcl4MRLGjLflvcu4ca2bz1ZLvJZ9rw48RjFvXLkXg5RjCddwbqrroyxy+OigGBeQXcs+CnGUrx23tyJ05x1pfDfXi01n91TETs7rx9L6Ar0Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625325; c=relaxed/simple;
	bh=c3+J0awFJMtMqcppxYEEFJn5L52AAGPTajyzG/wRNhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6/8YcJqhgz0cprHfXRpIVwUGouhSDFia3LKJpqDmGEo7uit/MhdYqeQUQxXjoVEWkzvO0BO5KP35fftGkHhM4TwJEfSRzwXqMbn3Ziv74jQQq4IoHz5AjXNtIGy65E0nhlHgf+f9AOyKxp4OsQrpGKl+RicEngktVOz7eMbPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RrPbGw1R; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F3E1F00A3A;
	Tue, 16 Jun 2026 15:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625323;
	bh=Unv6er02GVHPClIkwqMHwPgausnu05qqCv3qkP8OypA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RrPbGw1RZoCrn9cmlmE5NFZ795w2xxuNE93EvgpzUeZMLFVlTDlebHypOpJ5lO79k
	 Df29in7hTXPagPfTzfPmYhZfQ+wE2YquaPnA0Z0OvMPLgdTD6PzHdS9/jWCgn0rEZW
	 nfnJQH9F8k5IQiCJMTYsMdperNegymK278tS4Uxo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Logan Gunthorpe <logang@deltatee.com>,
	Li RongQing <lirongqing@baidu.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 087/325] dma-mapping: direct: fix missing mapping for THRU_HOST_BRIDGE segments
Date: Tue, 16 Jun 2026 20:28:03 +0530
Message-ID: <20260616145102.051597117@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264327-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:logang@deltatee.com,m:lirongqing@baidu.com,m:m.szyprowski@samsung.com,m:sashal@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,samsung.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88A986918E7

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index f973e7e73c90bb..fd483b558b504c 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -469,7 +469,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
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




