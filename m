Return-Path: <stable+bounces-256147-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK7WKFSqGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256147-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:49:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F0E5F99C7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF8F03232614
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F7B33F5BE;
	Thu, 28 May 2026 20:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G9HLqvEa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0393016E1;
	Thu, 28 May 2026 20:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000887; cv=none; b=AEZqi6HpJUUg6kKeaBo8tGWdfnryvhE/qNVD0kR7yIkCGAkW65iMMHRU7A7fLE/ht2WjRCvOw98JSEyM6F3TjlDN2cwgy3W1HQRRML9JNoOihdaSJZy8eNUOeOGPFInQByYKgzjgGqHu8+81PCXtXg4pePDh82ZTnYr1UVE4UhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000887; c=relaxed/simple;
	bh=j8ENg+WqXxSKMyshAukrxMspNbhOxqhMd5KtBMbayLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CkM722nF4BnYI2kBZ1dT7YzAajj1B7944mchsOvUgCkEEkMs7bF+SPZY5NEeJXZE30iaZ/D2QjYQS2AWfXfEWZjB/X8yLp/diZv0uVKanTE/3mYxwPQMn8EXnkJfl64kSYulw1LqeyYOwFXKZ7G7Z81tjD7Pji0RumkzyE6xS/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G9HLqvEa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AAA1F000E9;
	Thu, 28 May 2026 20:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000886;
	bh=C43gVVROdOeQFrI/TNxu8ma4QqmiZmp32SHArXEzUfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G9HLqvEaYKnh9KKNjw2bp5nnRMi88d389XrTrd5WRngTRHWioSRaoXCAQ/mS/V5Dt
	 BxwpgNSa19PuL/nXpOSjgxsEVvIX+jvQk94aIZb5uT67K6k/SJEhDt43ItyIUzVphM
	 wAvpy/WstsGiqfAjUiX/o6B/GaxklahHTIVsVxAA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Haarmann-Thiemann <eitschman@nebelreich.de>,
	Linus Walleij <linusw@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 203/272] net: ethernet: cortina: Drop half-assembled SKB
Date: Thu, 28 May 2026 21:49:37 +0200
Message-ID: <20260528194634.929063647@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256147-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,nebelreich.de:email]
X-Rspamd-Queue-Id: F1F0E5F99C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 47072fbabcaee..8fee13bd056ad 100644
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




