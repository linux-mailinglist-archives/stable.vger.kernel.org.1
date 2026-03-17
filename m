Return-Path: <stable+bounces-226779-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFewHciTuWnKKgIAu9opvQ
	(envelope-from <stable+bounces-226779-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:47:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E292B0235
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC0C630FDC4D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633302459DC;
	Tue, 17 Mar 2026 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0yPRK5kQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AD42DF132;
	Tue, 17 Mar 2026 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768166; cv=none; b=OdTND94B/8zpibV/UHZe4wrAT/JwPZigzzDwuZ/AGbKlPqfaj32b11W0xMiwa4M0O/18zxT4GyIpUYbhVppAbjx2sBcpLeGN3seHz+zUOE8oGZPBYJnfEDfp6vhdXwmlXm2dIKXRFiGZ2vmHA4o7eeM4nJ04UP1oCwn0SpCvaGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768166; c=relaxed/simple;
	bh=4n6zSZTbYlDIu/pfiEUBfV3WsWF/XE4t+P2rwtUwOVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gv+PVSdFn+p9ySy4HMsOey9mxEKq4yXUT6z7oWqN2HrT7cStvMRcxzw86eIwAu4jFJB8XJGz2SThpDnkvxX3quM6Ere1F3hynVPlzRFTU8hwBZ+z3qy3gSVP2TLvol9ysdOEfl5Ur5BoOy0CROxf6BZlw0Nnv9ILojkJjxZhlb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0yPRK5kQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B05C2BC86;
	Tue, 17 Mar 2026 17:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768165;
	bh=4n6zSZTbYlDIu/pfiEUBfV3WsWF/XE4t+P2rwtUwOVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0yPRK5kQY66BU46SpMK6CVDJZ+QJx0iML2yoVtT02682XrYx7Ev27cgpqf7IOXIa7
	 UUYc30Z9+S58KukqqyJxQ6uKoBvoYplnc5bf3UL77aAFeX/MeM21q2nPruri4fq7Tg
	 rY1Aholt8Df1qPNCMq9cH1ASG7cRudMfBEyNj6Gc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>
Subject: [PATCH 6.18 213/333] pinctrl: cy8c95x0: Dont miss reading the last bank registers
Date: Tue, 17 Mar 2026 17:34:02 +0100
Message-ID: <20260317163007.262995266@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226779-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 70E292B0235
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit b6c3af46c26f2d07c10a1452adc34b821719327e upstream.

When code had been changed to use for_each_set_clump8(), it mistakenly
switched from chip->nport to chip->tpin since the cy8c9540 and cy8c9560
have a 4-pin gap. This, in particular, led to the missed read of
the last bank interrupt status register and hence missing interrupts
on those pins. Restore the upper limit in for_each_set_clump8() to take
into consideration that gap.

Fixes: 83e29a7a1fdf ("pinctrl: cy8c95x0; Switch to use for_each_set_clump8()")
Cc: stable@vger.kernel.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -627,7 +627,7 @@ static int cy8c95x0_write_regs_mask(stru
 	bitmap_scatter(tmask, mask, chip->map, MAX_LINE);
 	bitmap_scatter(tval, val, chip->map, MAX_LINE);
 
-	for_each_set_clump8(offset, bits, tmask, chip->tpin) {
+	for_each_set_clump8(offset, bits, tmask, chip->nport * BANK_SZ) {
 		unsigned int i = offset / 8;
 
 		write_val = bitmap_get_value8(tval, offset);
@@ -655,7 +655,7 @@ static int cy8c95x0_read_regs_mask(struc
 	bitmap_scatter(tmask, mask, chip->map, MAX_LINE);
 	bitmap_scatter(tval, val, chip->map, MAX_LINE);
 
-	for_each_set_clump8(offset, bits, tmask, chip->tpin) {
+	for_each_set_clump8(offset, bits, tmask, chip->nport * BANK_SZ) {
 		unsigned int i = offset / 8;
 
 		ret = cy8c95x0_regmap_read_bits(chip, reg, i, bits, &read_val);



