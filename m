Return-Path: <stable+bounces-263920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SqMyC6hrMWqUiwUAu9opvQ
	(envelope-from <stable+bounces-263920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:28:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCB66910F4
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:28:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=bvWhs7TY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263920-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263920-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B2483042F10
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A0343E9CE;
	Tue, 16 Jun 2026 15:19:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90643E4A1;
	Tue, 16 Jun 2026 15:19:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623182; cv=none; b=na11t9548bSE5W4WWVzKuJdttqSoRoBWh29WB2qyAvcvL+IPftTjmaeaFGfQILrPedJHI3H/LeYuQT01qQIm53MfXkfH2sKkG5a8mOUc6CKSfiDh8JUiRoYF7dCDjlFCQyHPi+Bv5uT+NP6t4mXV1jxo1CRoBEYxkkXM43Sjr2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623182; c=relaxed/simple;
	bh=dxmJtXS49ycfyTxB74MzuNqPghRubHxtAIp/Gwtb6Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQK+yz4piUh6yFCEX0qdZeIAWwJ2WB1YCkVhMJzJS08k6IeWBkhWFlr2GkbNkGCwjMWjgAin/WCQ0b4nxJLvOPJGlVLgXTIEqqoNWtZCGcvXKX6tMTinyPmxPER63VoJAYPkrbpLfsW9te6M5XkTeLI+BFbf5lIm7p97SSjQMfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bvWhs7TY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E211F000E9;
	Tue, 16 Jun 2026 15:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623181;
	bh=4r74YgxD7pXqm6fEfKXpbFGHROpJi74rfgEXivmzxjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bvWhs7TY8QySp+one7KkIC+6bN0ueYLGiNLDpSvJ3TCXlMncgL4b2YU3OnVojLylt
	 X9YHKsZEVUopkc6b7vXRsCR2peNgiYqjoUXtd/21gRVhTTU6Nis6Fx7qPweUeXiaUe
	 AVq2u2xkwaW49pcMvvnTyIqL6RuanqmK6YNM5ZWo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li RongQing <lirongqing@baidu.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 100/378] dma-debug: fix physical address retrieval in debug_dma_sync_sg_for_device
Date: Tue, 16 Jun 2026 20:25:31 +0530
Message-ID: <20260616145115.616981334@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263920-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:lirongqing@baidu.com,m:m.szyprowski@samsung.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,samsung.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DCB66910F4

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index 3248f8b4d096de..2c0e2cd89b5ed7 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1556,7 +1556,7 @@ void debug_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
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




