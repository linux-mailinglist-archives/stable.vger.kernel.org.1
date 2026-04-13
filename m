Return-Path: <stable+bounces-236659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD7rITEZ3WnoZwkAu9opvQ
	(envelope-from <stable+bounces-236659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:26:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DBF3EEED1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C4B3302454F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B8530ACE6;
	Mon, 13 Apr 2026 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ARWKyaoc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B792309DB5;
	Mon, 13 Apr 2026 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097474; cv=none; b=l8qkRZqE/TqeSujv77zgBzVHpfWDoxhlxbCQelKySXOW6jpGqU5XQ5EFeCwiCC+cGWmYtjL6Ih9Enqz+1vaRQEBWULNKoARuZULHQsX3MqR+GAv9FRmeqsFH1E/+b7OVeXTWrC8KXO1fkG4YG/rJJwPAI8Zt45nT7DkcIpLPiP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097474; c=relaxed/simple;
	bh=mpscWdPHfzhzI1M/mQhbejocfgQq9dxG05v+LWs/Ll8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDh6XCyKq+yAWrLnpQ7AaXMxIpXF/aoy8p5Iwp74LSxFMuSxUe2wnlspy/7/ZL/SGGQOS97Zd0gtMl6xNmtXF7kLK9PVzTCUmxF8Byy8puM+IlPcdGsfhvbjGGL99ukwKpqzX7Ni4HQpodF8W4lqFWbdBWdnmP3oUibF9NKdL84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ARWKyaoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962F6C2BCAF;
	Mon, 13 Apr 2026 16:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097473;
	bh=mpscWdPHfzhzI1M/mQhbejocfgQq9dxG05v+LWs/Ll8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ARWKyaocdEcjgjvDFvwqzzOhO7ICYEXIoiPxKP1v4WXA53OP3P7lX/U0F5WfT0xL7
	 3+XxqjKC7dihC6LHfGtjcihQc+MfjznLJZu3tUddmzZQTeX/cvo1JZYeVXFK6VdVgA
	 1G3YGbCaNZiTHmFYquNz2JLUks7WuCIa3+FToxIU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matt Vollrath <tactii@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 123/570] e1000/e1000e: Fix leak in DMA error cleanup
Date: Mon, 13 Apr 2026 17:54:14 +0200
Message-ID: <20260413155835.050791043@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236659-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email]
X-Rspamd-Queue-Id: 57DBF3EEED1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Vollrath <tactii@gmail.com>

[ Upstream commit e94eaef11142b01f77bf8ba4d0b59720b7858109 ]

If an error is encountered while mapping TX buffers, the driver should
unmap any buffers already mapped for that skb.

Because count is incremented after a successful mapping, it will always
match the correct number of unmappings needed when dma_error is reached.
Decrementing count before the while loop in dma_error causes an
off-by-one error. If any mapping was successful before an unsuccessful
mapping, exactly one DMA mapping would leak.

In these commits, a faulty while condition caused an infinite loop in
dma_error:
Commit 03b1320dfcee ("e1000e: remove use of skb_dma_map from e1000e
driver")
Commit 602c0554d7b0 ("e1000: remove use of skb_dma_map from e1000 driver")

Commit c1fa347f20f1 ("e1000/e1000e/igb/igbvf/ixgb/ixgbe: Fix tests of
unsigned in *_tx_map()") fixed the infinite loop, but introduced the
off-by-one error.

This issue may still exist in the igbvf driver, but I did not address it
in this patch.

Fixes: c1fa347f20f1 ("e1000/e1000e/igb/igbvf/ixgb/ixgbe: Fix tests of unsigned in *_tx_map()")
Assisted-by: Claude:claude-4.6-opus
Signed-off-by: Matt Vollrath <tactii@gmail.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 2 --
 drivers/net/ethernet/intel/e1000e/netdev.c    | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index b252373ec9fa6..e7e7b6255ddfe 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -2950,8 +2950,6 @@ static int e1000_tx_map(struct e1000_adapter *adapter,
 dma_error:
 	dev_err(&pdev->dev, "TX DMA map failed\n");
 	buffer_info->dma = 0;
-	if (count)
-		count--;
 
 	while (count--) {
 		if (i == 0)
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index c153f44a6ab85..3216089642648 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5637,8 +5637,6 @@ static int e1000_tx_map(struct e1000_ring *tx_ring, struct sk_buff *skb,
 dma_error:
 	dev_err(&pdev->dev, "Tx DMA map failed\n");
 	buffer_info->dma = 0;
-	if (count)
-		count--;
 
 	while (count--) {
 		if (i == 0)
-- 
2.51.0




