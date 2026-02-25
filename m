Return-Path: <stable+bounces-219371-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEzZE3yinmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219371-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:19:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E8819334A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EC1E31AEDB2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78932DC767;
	Wed, 25 Feb 2026 06:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yaNTfJ/j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFF72D6E58;
	Wed, 25 Feb 2026 06:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002671; cv=none; b=lK4vpU67oHMd7Rig8L9v6Ocfvu2KbCcDdHiumdE/lmlD6KC3ZFDJKNBQk9oy0f8KKssIWrCJ4FzQVdOsnnzrbuCbf6UY0C5eaTYNzAb1eGNohNEmo/Di057qfHtLYC9sjg7CsbMEkULaDxFf1IBF0C2wDj6+POr/AgoiZpXTlWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002671; c=relaxed/simple;
	bh=ucPkeDmQ4D2amBpuWrmTlJgRLOCMS5LtcM4BcIKXOB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8jmzOg5N79s5d19/H1OfLuURznlm9tH649SNpAYCW73fq3ltHoL1SPZGl4P48uWGH02AgJatFf5wol+ygDQQW+fRhy9icGfAekQ0TgaIwixtJNHTjecNi/6Z3m6XKuFk2w9iz7yCgRdVNA0Dxo/pEw7xDV6CpqMzIMdL0fdc2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yaNTfJ/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66453C116D0;
	Wed, 25 Feb 2026 06:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002671;
	bh=ucPkeDmQ4D2amBpuWrmTlJgRLOCMS5LtcM4BcIKXOB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yaNTfJ/j+l3g3F659o75XU6GswAT6HMcJH00Ftbb3uOjwcyq40oPRnIcWE5X2CMJb
	 dAfGAyrrXwN6QcKGweVLhLPZMrkiN56deLsFgtmQsOzuKWowBeBJ0EiRYUbLjclxMO
	 NiNb5Wk79Mm8/CrNvfnqyTyvq05848VwZbuexm3Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 454/641] dma: dma-axi-dmac: fix HW scatter-gather not looking at the queue
Date: Tue, 24 Feb 2026 17:23:00 -0800
Message-ID: <20260225012359.515878588@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219371-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,analog.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8E8819334A
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nuno Sá <nuno.sa@analog.com>

[ Upstream commit bbcbafb99df41a1d81403eb4f5bb443b38228b57 ]

For HW scatter gather transfers we still need to look for the queue. The
HW is capable of queueing 3 concurrent transfers and if we try more than
that we'll get the submit queue full and should return. Otherwise, if we
go ahead and program the new transfer, we end up discarding it.

Fixes: e97dc7435972 ("dmaengine: axi-dmac: Add support for scatter-gather transfers")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
base-commit: 398035178503bf662281bbffb4bebce1460a4bc5
change-id: 20251104-axi-dmac-fixes-and-improvs-e3ad512a329c
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
Link: https://patch.msgid.link/20251104-axi-dmac-fixes-and-improvs-v1-2-3e6fd9328f72@analog.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/dma-axi-dmac.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index e22639822045f..0f25f6d8ae71f 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -233,11 +233,9 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 	unsigned int flags = 0;
 	unsigned int val;
 
-	if (!chan->hw_sg) {
-		val = axi_dmac_read(dmac, AXI_DMAC_REG_START_TRANSFER);
-		if (val) /* Queue is full, wait for the next SOT IRQ */
-			return;
-	}
+	val = axi_dmac_read(dmac, AXI_DMAC_REG_START_TRANSFER);
+	if (val) /* Queue is full, wait for the next SOT IRQ */
+		return;
 
 	desc = chan->next_desc;
 
-- 
2.51.0




