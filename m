Return-Path: <stable+bounces-228883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDtHFvVXwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-228883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:10:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF842F5EA0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30BC1301FB41
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EC43B0AE2;
	Mon, 23 Mar 2026 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O6dHGeDH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCEA3AF668;
	Mon, 23 Mar 2026 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277392; cv=none; b=HllQL2T/raNCq8NiFzIsTh1lHxVxjwntjrFs37nqoF60vDGw/r0vk0Zvny/oXTCjTbiqqIEYP3ZMFTqAdS9YwpKJKFQG4rZCcZiJY1L3r5ASloiKuaCXlm+0Z0lpQRe/GNIzPW7L518kxNZgE6g81zgpLhPg6bDTX7KFcKLBEHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277392; c=relaxed/simple;
	bh=/512DfVerBwJ6Pj/ggBVG330dR45Dff50IojU+EazWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzFMXb1Dtr29BJCmvjKUslNl+f+0HdtD88rKYVcaCDT0D2gHeWvYpLVgn85BpdOS9/WisptzoIx0+c2VOxbQwBNH3TIPTiqwD9WOELGLHywxZMGtdF4En6Gd8Uih09OTSam3m4YxDUXTINrqh8AzYJ372bGtajZR+37UN7PyZOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O6dHGeDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D547C4CEF7;
	Mon, 23 Mar 2026 14:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277391;
	bh=/512DfVerBwJ6Pj/ggBVG330dR45Dff50IojU+EazWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O6dHGeDHlvOwfnBnuymVwYt+b5XVaTEiqxLIfoso7tZdE6B1McnB/qwQLpEpx89p5
	 cmzmK8DBbQchfDecS3VkN5ja1DwCH82Mk/nQZuCUtbiNIskyT9BJUu5CYQDqYeNpGF
	 b0m6eubyPU0gek0m4B4FreUwNyFRn4Xi0q0Vgepk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Astrand <astrand@lysator.liu.se>,
	Guenter Roeck <linux@roeck-us.net>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 420/460] wifi: wlcore: Return -ENOMEM instead of -EAGAIN if there is not enough headroom
Date: Mon, 23 Mar 2026 14:46:56 +0100
Message-ID: <20260323134536.869397164@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228883-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3FF842F5EA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit deb353d9bb009638b7762cae2d0b6e8fdbb41a69 ]

Since upstream commit e75665dd0968 ("wifi: wlcore: ensure skb headroom
before skb_push"), wl1271_tx_allocate() and with it
wl1271_prepare_tx_frame() returns -EAGAIN if pskb_expand_head() fails.
However, in wlcore_tx_work_locked(), a return value of -EAGAIN from
wl1271_prepare_tx_frame() is interpreted as the aggregation buffer being
full. This causes the code to flush the buffer, put the skb back at the
head of the queue, and immediately retry the same skb in a tight while
loop.

Because wlcore_tx_work_locked() holds wl->mutex, and the retry happens
immediately with GFP_ATOMIC, this will result in an infinite loop and a
CPU soft lockup. Return -ENOMEM instead so the packet is dropped and
the loop terminates.

The problem was found by an experimental code review agent based on
gemini-3.1-pro while reviewing backports into v6.18.y.

Assisted-by: Gemini:gemini-3.1-pro
Fixes: e75665dd0968 ("wifi: wlcore: ensure skb headroom before skb_push")
Cc: Peter Astrand <astrand@lysator.liu.se>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Link: https://patch.msgid.link/20260318064636.3065925-1-linux@roeck-us.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ti/wlcore/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wlcore/tx.c b/drivers/net/wireless/ti/wlcore/tx.c
index f251627c24c6e..3c0f8f3ba2668 100644
--- a/drivers/net/wireless/ti/wlcore/tx.c
+++ b/drivers/net/wireless/ti/wlcore/tx.c
@@ -210,7 +210,7 @@ static int wl1271_tx_allocate(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 		if (skb_headroom(skb) < (total_len - skb->len) &&
 		    pskb_expand_head(skb, (total_len - skb->len), 0, GFP_ATOMIC)) {
 			wl1271_free_tx_id(wl, id);
-			return -EAGAIN;
+			return -ENOMEM;
 		}
 		desc = skb_push(skb, total_len - skb->len);
 
-- 
2.51.0




