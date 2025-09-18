Return-Path: <stable+bounces-168959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 366E9B23778
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DBE188704B
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B6B29BDA9;
	Tue, 12 Aug 2025 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c7AITxkl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AF021C187;
	Tue, 12 Aug 2025 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025905; cv=none; b=R20/ibeY3eYorzQ0qe8b75SCymuJxfp1oWlA8reuvKJv/rgN4+uDCX7FHhjScuIyLPRv2hvloejqtfkYEyFKCeERXbVfjI455atWJ74a1zx0VuzS3XqJB0/ZKxP4iZb2OCo8XzFF9DYIDrCpGaUm91kDvqb5Z/GtQJRKrUyvvMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025905; c=relaxed/simple;
	bh=QW2g0ocC1fl7Jc6xsWffT0nopz0n8E9iQIHgM/HhGEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OH662AzCpwr5HEXinMtxRN6ke2lm9KwuUAFxbnb+/f1p7v0mjBc0J5PyURG5HGEaIhfoC473s+sT5lPxQV65Tgm/3h1QG8IBIH3ZwRpPHAe9fcK4XSTs2lIUaxhy2wtW74sSyVo5Up74xdkYACz6bmima9IxnnNs0zQ/H2EVHLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c7AITxkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F25AC4CEF0;
	Tue, 12 Aug 2025 19:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025905;
	bh=QW2g0ocC1fl7Jc6xsWffT0nopz0n8E9iQIHgM/HhGEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c7AITxklGYnDe674IbYDwknIaobNv8UbXx+krdywCj0d2Np/DwedG/epHz2j8cLAy
	 2yLzjDta16JOUH2dYCp2xibU01o4+7NfInQZGxK2ci1Mwck6+n8OCB+xSdm0TxUZEh
	 1S6EhUaoffujeolSwSEawhJXashhZakN7/eO0Cfs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Wetzel <Alexander@wetzel-home.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 178/480] wifi: mac80211: Dont call fq_flow_idx() for management frames
Date: Tue, 12 Aug 2025 19:46:26 +0200
Message-ID: <20250812174404.854916796@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Wetzel <Alexander@wetzel-home.de>

[ Upstream commit cb3bb3d88dfcd177a1050c0a009a3ee147b2e5b9 ]

skb_get_hash() can only be used when the skb is linked to a netdev
device.

Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
Fixes: 73bc9e0af594 ("mac80211: don't apply flow control on management frames")
Link: https://patch.msgid.link/20250717162547.94582-3-Alexander@wetzel-home.de
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/tx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index fd21a18a028d..10e5fb294709 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1438,7 +1438,7 @@ static void ieee80211_txq_enqueue(struct ieee80211_local *local,
 {
 	struct fq *fq = &local->fq;
 	struct fq_tin *tin = &txqi->tin;
-	u32 flow_idx = fq_flow_idx(fq, skb);
+	u32 flow_idx;
 
 	ieee80211_set_skb_enqueue_time(skb);
 
@@ -1454,6 +1454,7 @@ static void ieee80211_txq_enqueue(struct ieee80211_local *local,
 			IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
 		__skb_queue_tail(&txqi->frags, skb);
 	} else {
+		flow_idx = fq_flow_idx(fq, skb);
 		fq_tin_enqueue(fq, tin, flow_idx, skb,
 			       fq_skb_free_func);
 	}
-- 
2.39.5




