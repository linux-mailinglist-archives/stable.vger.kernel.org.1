Return-Path: <stable+bounces-250628-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOM6LXLoDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-250628-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:59:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A09592C5E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2762330CB220
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161F335201E;
	Wed, 20 May 2026 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UJ7WSeGe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E4351C2F;
	Wed, 20 May 2026 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295908; cv=none; b=osoco2EBmlyM/Xbip4ssxnq0pCMuskQgEp3vkym/OAq71aSnkvfKDJARcV7okuqNeB/1belc0fYdRXD48LtokhbKRehYCA9qPMqKcXSbNspcztJOPWeYCBivxKnHGCM0a4WXO5SphDmawzcmQT7lWyVl+DrkWYBiFz6+j/f8r6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295908; c=relaxed/simple;
	bh=LtQiVsdjqpoSxOts/QWSR0j8lS+ZXxw9zrGQmXvPw2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8QtPbsB2q/jVGPOkCrflYIIJBC2EnVVLQMMNGnnLMQhdZN6u1MjQfF8GZe45a6L6GQeQUO0o6FRRZtw2hCkjkjMFpYgKW1Qcv7iBIy+s3QjqJ92BDE9c7+eu09adwxPV/DPVZ/eLZrTJ3JHdXDxvq1Rl7jmEirXo2XjiE5Lf6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UJ7WSeGe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA491F000E9;
	Wed, 20 May 2026 16:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295907;
	bh=vsEzOc2vyGXG8M8quEH7GJ54PTzJ/GgSUIjNKLh4V6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UJ7WSeGez5KogibqyLeVgSkMvBWaM9p0KJN3ONtNuSuM+gvQ1s1aB68tsDkRT9Bv7
	 FGJgWeBJl90zew/6CXUHfYWb1++XY8DPJ9vvyV6oYPdXOkaSdPwKZlLAGIXrc3eNCZ
	 glDbcLPuQSBfh8MRGih7rN85c+9a+NWR2t6lXjK4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shiji Yang <yangshiji66@outlook.com>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"Pratyush Yadav (Google)" <pratyush@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0597/1146] mtd: spi-nor: swp: check SR_TB flag when getting tb_mask
Date: Wed, 20 May 2026 18:14:07 +0200
Message-ID: <20260520162201.688299275@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,outlook.com,kernel.org,bootlin.com];
	TAGGED_FROM(0.00)[bounces-250628-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,outlook.com:email]
X-Rspamd-Queue-Id: 54A09592C5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shiji Yang <yangshiji66@outlook.com>

[ Upstream commit 94645aa41bf9ecb87c2ce78b1c3405bfb6074a37 ]

When the chip does not support top/bottom block protect, the tb_mask
must be set to 0, otherwise SR1 bit5 will be unexpectedly modified.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Fixes: 3dd8012a8eeb ("mtd: spi-nor: add TB (Top/Bottom) protect support")
Reviewed-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/swp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
index 9b07f83aeac76..e67a81dbb6bf6 100644
--- a/drivers/mtd/spi-nor/swp.c
+++ b/drivers/mtd/spi-nor/swp.c
@@ -28,8 +28,10 @@ static u8 spi_nor_get_sr_tb_mask(struct spi_nor *nor)
 {
 	if (nor->flags & SNOR_F_HAS_SR_TB_BIT6)
 		return SR_TB_BIT6;
-	else
+	else if (nor->flags & SNOR_F_HAS_SR_TB)
 		return SR_TB_BIT5;
+	else
+		return 0;
 }
 
 static u64 spi_nor_get_min_prot_length_sr(struct spi_nor *nor)
-- 
2.53.0




