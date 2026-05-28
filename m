Return-Path: <stable+bounces-255377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IM6DM7ihGGqvlggAu9opvQ
	(envelope-from <stable+bounces-255377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:12:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2745F8111
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00A3E32383D2
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C01339866;
	Thu, 28 May 2026 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BC75XX/a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179952FD7C3;
	Thu, 28 May 2026 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998739; cv=none; b=j9wLk55U5c6li3+UQmhGgAgLgAKEVKwIHd4p6b0Qfm3kMtNoaXtkJ51O2u6DXzM9Tb5qmz8BGS616a5AcO9b8khSrSAzoMi6rPVWJ62FbANusk+5FsOSE6RhS5CHyhM0M5BeRm6lEDSNi7k+QnBjfcA642ZYRsXOc+FST2KrsXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998739; c=relaxed/simple;
	bh=QOQJ8MyFZtkEN87yTH3Rkn9fJS9bWytk7HMTrKdq6pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJxa0FR2bmjTkrVEqREeMNUs+jKcHsGJycU6015NRTfxZoHQuES/eBfjae0YmIr8qzjjpEKL187LhAOs5yC48ArFy6QAiHgnYqja7AyI+8Hd1to4lo7XqPZk/P1TxtGvZyWoBb/A2IeO4lt0QRM9O2tdr2YqysCNZ9tMiexh7Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BC75XX/a; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B5B1F000E9;
	Thu, 28 May 2026 20:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998738;
	bh=Wb0PR+dbX0ONu+FuOt0tlFwX9Aqh6JxnMaeeoFzDCFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BC75XX/aMmF/6g2JjAGyXX56u3OZUi1OkDYb1Dlx/w/SAq0qUer/Z53pvAke8mCdv
	 M2gOxxg2hEivO5+3UJge4F2vDGrlSYxgwGlUd1G+/6VTEd7Zo5urHR7Qreb3kiAoYx
	 qJJLs4VJoTshsUI+Xqnzr4W9ZUaeDBh3WgpAvqL4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Haarmann-Thiemann <eitschman@nebelreich.de>,
	Linus Walleij <linusw@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 273/461] net: ethernet: cortina: Drop half-assembled SKB
Date: Thu, 28 May 2026 21:46:42 +0200
Message-ID: <20260528194655.073602255@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255377-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 5B2745F8111
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>

[ Upstream commit b266bacba796ff5c4dcd2ae2fc08aacf7ab39153 ]

In gmac_rx() (drivers/net/ethernet/cortina/gemini.c), when
gmac_get_queue_page() returns NULL for the second page of a multi-page
fragment, the driver logs an error and continues — but does not free the
partially assembled skb that was being assembled via napi_build_skb() /
napi_get_frags().

Free the in-progress partially assembled skb via napi_free_frags()
and increase the number of dropped frames appropriately
and assign the skb pointer NULL to make sure it is not lingering
around, matching the pattern already used elsewhere in the driver.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Link: https://patch.msgid.link/20260505-gemini-ethernet-fix-v2-1-997c31d06079@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: ebd8ec2b309e ("net: ethernet: cortina: Carry over frag counter")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 57a25030f883c..e8d973b8fb0c3 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1493,6 +1493,11 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 		gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
 		if (!gpage) {
 			dev_err(geth->dev, "could not find mapping\n");
+			if (skb) {
+				napi_free_frags(&port->napi);
+				port->stats.rx_dropped++;
+				skb = NULL;
+			}
 			continue;
 		}
 		page = gpage->page;
-- 
2.53.0




