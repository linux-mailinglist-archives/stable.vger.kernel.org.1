Return-Path: <stable+bounces-228911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M7vCZpqwWnVSwQAu9opvQ
	(envelope-from <stable+bounces-228911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:30:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EAC2F8312
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C7A132A9FC9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBE926A08F;
	Mon, 23 Mar 2026 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fGL05jE7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834A826ED46;
	Mon, 23 Mar 2026 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277466; cv=none; b=NaeXQk+yZit3tMZh3vQPGj/ltxXkNaRBhVtdNOf1VWedaCnl1THRbTXUfk1qKZtu2QEI6kh7KwBLHCPwywQMWlf+ggTjTnhrpqKS1nUK8rTBNjGdgPFIPkXj0goPhAFFf3QxkU53epWHpEPMD4Lyk2/3gsmspW/SbtTDVzd8Iyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277466; c=relaxed/simple;
	bh=0sEVdAI1vu7okh33FF4Fe5Lxm1/XQh5oYa6ku3eGESE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKrE51kR16YZNAuW6biJEn5uqeU49Pn7fEAHSXCNiYcrxNy21UWz2emtztDmE5bTWbiIs2RotNdytlrqRuE4AnouoSOTG6V7Z2HfgtbjQisTQk+ZYcVZj10krlVLpn2uI/H8DwRMPS0qI/ywfYZrFx+/K7hmREdbKblj22bvgMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fGL05jE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16519C4CEF7;
	Mon, 23 Mar 2026 14:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277466;
	bh=0sEVdAI1vu7okh33FF4Fe5Lxm1/XQh5oYa6ku3eGESE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fGL05jE7kcLRfqMZN/8NEQDjLHtqvV+56F1BSO22hZVYeUSXNcku6R1wV48xafmDq
	 sr4L7oQ3HbsTfYfsavVL34+k6ndRoFwTZ9+jqHlrUlz//Sa0HUi2q8hXSLhmUYK6M1
	 YVHGIHKN/3E5HQtyuSizMoqT81/VMmjwOS+gPrdc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	William Zhang <william.zhang@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 450/460] mtd: rawnand: brcmnand: skip DMA during panic write
Date: Mon, 23 Mar 2026 14:47:26 +0100
Message-ID: <20260323134537.642077777@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228911-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: B5EAC2F8312
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamal Dasu <kamal.dasu@broadcom.com>

[ Upstream commit da9ba4dcc01e7cf52b7676f0ee9607b8358c2171 ]

When oops_panic_write is set, the driver disables interrupts and
switches to PIO polling mode but still falls through into the DMA
path. DMA cannot be used reliably in panic context, so make the
DMA path an else branch to ensure only PIO is used during panic
writes.

Fixes: c1ac2dc34b51 ("mtd: rawnand: brcmnand: When oops in progress use pio and interrupt polling")
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
Reviewed-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 2eb44c1428fbc..bbba3cf477e98 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2303,14 +2303,12 @@ static int brcmnand_write(struct mtd_info *mtd, struct nand_chip *chip,
 	for (i = 0; i < ctrl->max_oob; i += 4)
 		oob_reg_write(ctrl, i, 0xffffffff);
 
-	if (mtd->oops_panic_write)
+	if (mtd->oops_panic_write) {
 		/* switch to interrupt polling and PIO mode */
 		disable_ctrl_irqs(ctrl);
-
-	if (use_dma(ctrl) && (has_edu(ctrl) || !oob) && flash_dma_buf_ok(buf)) {
+	} else if (use_dma(ctrl) && (has_edu(ctrl) || !oob) && flash_dma_buf_ok(buf)) {
 		if (ctrl->dma_trans(host, addr, (u32 *)buf, oob, mtd->writesize,
 				    CMD_PROGRAM_PAGE))
-
 			ret = -EIO;
 
 		goto out;
-- 
2.51.0




