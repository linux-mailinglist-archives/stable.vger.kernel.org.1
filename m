Return-Path: <stable+bounces-254131-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHDyJ8gxFGqUKgcAu9opvQ
	(envelope-from <stable+bounces-254131-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 13:26:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8FA5C9EBD
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 13:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22879302BEB5
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 11:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A468935E1BF;
	Mon, 25 May 2026 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="GC5+QXQy"
X-Original-To: stable@vger.kernel.org
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DCF2B9A4;
	Mon, 25 May 2026 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779708290; cv=none; b=PNRHNndWxU6zMYJicObCWui/zLhJJ1Vd9xiGHB27QDP0fS1YF4WxX1hqhLWFb//F6ZzDxzA3tndnGoUXQ8FAcj2VWdRKifDDv/qGzdTUfShLGtHeykJiWPujJGSRKheuoTipDiVJgFbknpbHoNHIninY918lPRDsTtObaR36tTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779708290; c=relaxed/simple;
	bh=47xlOO5JbId46R5ZNpfziDDo8V+XnFuCW1yJNrzdW3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TI6TMxxkD9Yu8pTD9hDVPn47Y18EYYm7kGXfLdW4HDk6I09dTeN85OQmUFEiwxaSWDTnIbIEAe7+L6AsDhFWK+DEgDvJoDo/ZzetAeZLnZNVH6jQ8c4ateRWH1xyiP8UTVBFexq7DLo2qIK0/EabPFUQ5Zb8zmCdhAMW0vnC9I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=GC5+QXQy; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from [127.0.1.1] (unknown [91.160.0.144])
	(Authenticated sender: vjardin@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 49895B0059C;
	Mon, 25 May 2026 13:24:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1779708287;
	bh=47xlOO5JbId46R5ZNpfziDDo8V+XnFuCW1yJNrzdW3U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GC5+QXQyrM/L8pDABN5U+N6oqFJw1qGBvBh+sJt0SXW5J5YrETyGLTwx85gQMFt6T
	 iy1OB9KAi2KRROBi+oK/e/B3BvgLkZtW/hFfu2C5tgmuTAgYPdnrXCnD9Fe8iXl1v9
	 ANTofiUA/NPvDoCIqm2pkmF/HiCgDKwNkjqsJWzVr4aWWqACdPmX2BmhS9nhTpkqBt
	 LCLz60n/v1SBqL0RHAqu3SCaPZ4cHKcL330woF7cM/vPj/AUIUSg64q8+0RpIK9rKf
	 kgV1lf113lcdHlHG32ylLkr4h+CznbAh5LOBWzxMusVghpAOoxJ+nuPefdNIDBxLig
	 qlS+9dk9gYQJQ==
From: Vincent Jardin <vjardin@free.fr>
Date: Mon, 25 May 2026 13:24:02 +0200
Subject: [PATCH 1/2] i2c: imx: fix locked bus on SMBus block-read of 0
 (atomic)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-for-upstream-i2c-lx2160-fix-v1-v1-1-f30ab53dd97c@free.fr>
References: <20260525-for-upstream-i2c-lx2160-fix-v1-v1-0-f30ab53dd97c@free.fr>
In-Reply-To: <20260525-for-upstream-i2c-lx2160-fix-v1-v1-0-f30ab53dd97c@free.fr>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Wolfram Sang <wsa@kernel.org>, 
 Kaushal Butala <kaushalkernelmailinglist@gmail.com>, 
 Shawn Guo <shawn.guo@freescale.com>, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc: linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vincent Jardin <vjardin@free.fr>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779708249; l=1759;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=47xlOO5JbId46R5ZNpfziDDo8V+XnFuCW1yJNrzdW3U=;
 b=2eo7uMa1GLjy9XOUrlVsSrBMoV+sMK2Dc9T5c68PVvADPOD6V2VISAuCyCV/8lho3kg5+hk1L
 Iaf5oB8SqXjAK8k9smeYquWY1LfjradUGe0gBniikkvzvBBskr96KOu
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[free.fr,quarantine];
	R_DKIM_ALLOW(-0.20)[free.fr:s=smtp-20201208];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254131-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com,freescale.com,toradex.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[free.fr];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.infradead.org,free.fr];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vjardin@free.fr,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[free.fr:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1A8FA5C9EBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SMBus 3.1 6.5.7 allows a Block Read byte count of 0, but the atomic
(polling) path rejects it as -EPROTO. Worse, it returns without a
NACK+STOP: the next receive cycle has already started, so the target
keeps holding SDA and the bus stays stuck until a power cycle for
this i2c controller.

Accept count=0: NACK the in-flight dummy byte (TXAK) and extend msgs->len
so the existing last-byte handling emits STOP. The dummy byte is
discarded; block-read callers only consume buf[0..count-1].

The interrupt-driven path has the same flaw from a later commit and is
fixed separately, as it carries a different Fixes:

Fixes: 8e8782c71595 ("i2c: imx: add SMBus block read support")
Cc: <stable@vger.kernel.org> # v3.16+
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 drivers/i2c/busses/i2c-imx.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index a208fefd3c3b..0cd4f5892591 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1436,8 +1436,19 @@ static int i2c_imx_atomic_read(struct imx_i2c_struct *i2c_imx,
 		 */
 		if ((!i) && block_data) {
 			len = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
-			if ((len == 0) || (len > I2C_SMBUS_BLOCK_MAX))
+			if (len > I2C_SMBUS_BLOCK_MAX)
 				return -EPROTO;
+			if (len == 0) {
+				/*
+				 * SMBus 3.1 6.5.7: support count byte of 0.
+				 */
+				temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+				temp |= I2CR_TXAK;
+				imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+				msgs->buf[0] = 0;
+				msgs->len = 2;
+				continue;
+			}
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> read length: 0x%X\n",
 				__func__, len);

-- 
2.43.0


