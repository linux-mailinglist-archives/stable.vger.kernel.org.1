Return-Path: <stable+bounces-264478-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4S7ANCF4MWqCkAUAu9opvQ
	(envelope-from <stable+bounces-264478-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:21:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 236A8691FAA
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:21:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=uU5yi4Tt;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264478-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-264478-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 616893086614
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF95F4611C4;
	Tue, 16 Jun 2026 16:08:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A984534B3;
	Tue, 16 Jun 2026 16:08:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626108; cv=none; b=Ww/uDGV8dOpBUkwLeC93X3TgYjGprHdUaG1Uz+W00MwsaQQbUAPmMCkfMf5CyDlXdvDYIwq+K6yth0GqV22NsYPnqWH+IzUE35bkgg6SUqPSpsGosgVA3UMVftAu6pbd0p3MIys2683jHaFlD8mwF/axs4aAakD2Q7vBJ8gWnh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626108; c=relaxed/simple;
	bh=TdXKi0KuCHJZ7m5QsF6oMVWN6Yfb4waR9Dgq+WrzILM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6UY1GVnpDSc9OCiHqqh0FpNiE67ihf15XPx8ZVvHDzDsKUkkJRyHbTF6/gmJQI+6s3taEINVTtru5ivzCzh2M79HipDd2vUbxw4PeEY5HkWnv61oPL4QGRX3cAnRkKHTzoBKrBO373sthPyT46td9OAL/c+u67RwMk8MjJ1R4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uU5yi4Tt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C7E1F000E9;
	Tue, 16 Jun 2026 16:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781626107;
	bh=OyE/tWgnSG/pPp4Qw6h20LBFZvZr8rmLQuUecmECCU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uU5yi4TtGdmPQFUZ8Sbwh2dJTHUlxOpZIB5lIw+xBp0ocCHCHXCcI5Y88SKbTTN1m
	 b8vZQY50cNMy+mSXj3zf0VPjf3o/pIWm2LrTubgVdjoaKezlWmDtfyeWeDKdQ5rf5P
	 5EuxWoIrZ0INM9U56PpPUvXnOlVBACu4i09waw8A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Lai <justinlai0215@realtek.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 265/325] rtase: Reset TX subqueue when clearing TX ring
Date: Tue, 16 Jun 2026 20:31:01 +0530
Message-ID: <20260616145111.834049216@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264478-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:justinlai0215@realtek.com,m:aleksander.lobakin@intel.com,m:kuba@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 236A8691FAA

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Lai <justinlai0215@realtek.com>

commit ab1ecaabe74b7d86c38ab2ab44bd56cdcc33645a upstream.

rtase_tx_clear() clears the TX ring and resets the ring indexes.
However, the TX queue state and BQL accounting are not reset at
the same time.

This may leave __QUEUE_STATE_STACK_XOFF asserted after
rtase_sw_reset(), preventing new TX packets from being scheduled.

Reset the TX subqueue when clearing the TX ring so the TX queue
state and BQL accounting are restored together.

Fixes: 5a2a2f15244c ("rtase: Implement the rtase_down function")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Link: https://patch.msgid.link/20260602114659.12335-1-justinlai0215@realtek.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -239,6 +239,8 @@ static void rtase_tx_clear(struct rtase_
 		rtase_tx_clear_range(ring, ring->dirty_idx, RTASE_NUM_DESC);
 		ring->cur_idx = 0;
 		ring->dirty_idx = 0;
+
+		netdev_tx_reset_subqueue(tp->dev, i);
 	}
 }
 



