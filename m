Return-Path: <stable+bounces-255872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJJnOTqmGGpplwgAu9opvQ
	(envelope-from <stable+bounces-255872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:31:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3FA5F8E3E
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B073306A767
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD422F8E88;
	Thu, 28 May 2026 20:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qReXWDV3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0203E1C3318;
	Thu, 28 May 2026 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000113; cv=none; b=LPA2ScS9r+BHs+ggw5Ae8P/crGcJ8LBx/ZXiJrOrP3LdbP/P0Ui1tE7C/N43DaRhuq4GO2plySmBkSjL8M8yS0/ZFC9eZiwWVqLH6nxNMhsz5E0qOdmKlx4tn7atRDFrKTPLOBZH3Usw2etTqQasZAJKynaUEgR1ElfBT5fC+Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000113; c=relaxed/simple;
	bh=uwAyvRNs97aNQU9s4rEf6iexqRKrzqYsuy/2lk/H5z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiiaOsRfcRbXUS8dAwv8O5s3xS67iM80xFOGF6+a1gMc2C5bgi/bUq+M/EdWlwTwZbpknXkWchVQ3yxNuUVQyCSK+/A6KW1YERddapDYXrgrxcEv081+CmN6q/mPFc5/OYTClekl9FfVRAAzTPGyP2vTQWOimYLuxJEt14p7LEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qReXWDV3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D5B1F000E9;
	Thu, 28 May 2026 20:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000112;
	bh=q4kDVw7zwk1/l5ZvxszR3x3pARjRkBkzZEactHDhZU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qReXWDV3pAoyFwjKz0JxD+L87jAXw4/P4OLbfr8McUlLUCk/vf7zszhHbmksZbZti
	 vFjqvSpDGgKyV2+LQckkzwtcMWY20iMrosr+PfNUvOiA5WP1FXlYZn9vo7eXr9S7D9
	 sEOoDuPvNSLZdGc7/HcRy9Ui9CWQZafLe3o0aanY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 306/377] spi: mtk-snfi: Fix resource leak in mtk_snand_read_page_cache()
Date: Thu, 28 May 2026 21:49:04 +0200
Message-ID: <20260528194647.226023777@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-255872-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1E3FA5F8E3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit 496ba79b9496b8b3747cbc764ebd33ee7325e806 ]

When DMA read times out in mtk_snand_read_page_cache(), the original code
erroneously jumped to cleanup label which skips DMA unmapping and ECC
disable, causing a resource leak.

Fixes: 764f1b748164 ("spi: add driver for MTK SPI NAND Flash Interface")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Link: https://patch.msgid.link/20260510-snfi-v1-1-bc375cf1af8e@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-mtk-snfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
index a026b0e61994b..9e6038a5a2ad0 100644
--- a/drivers/spi/spi-mtk-snfi.c
+++ b/drivers/spi/spi-mtk-snfi.c
@@ -961,7 +961,7 @@ static int mtk_snand_read_page_cache(struct mtk_snand *snf,
 		    &snf->op_done, usecs_to_jiffies(SNFI_POLL_INTERVAL))) {
 		dev_err(snf->dev, "DMA timed out for reading from cache.\n");
 		ret = -ETIMEDOUT;
-		goto cleanup;
+		goto cleanup2;
 	}
 
 	// Wait for BUS_SEC_CNTR returning expected value
-- 
2.53.0




