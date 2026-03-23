Return-Path: <stable+bounces-229172-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNMYF35bwWlKSgQAu9opvQ
	(envelope-from <stable+bounces-229172-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:25:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C63B32F644B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE7C3303A857
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4073B3B0AD8;
	Mon, 23 Mar 2026 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oYBfkKUm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037853B0ACA;
	Mon, 23 Mar 2026 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278288; cv=none; b=Zc49Jc2melJSPlmR6NGYmdRQ+z++zUDphze2Upkhc/ZlCkHiyC1aLCgNYyb9dERGYSBkeW2fYPSb+jcF4lnSSCPFRHhClcsuGV0KXA13f0jg2HXKxrCsVGu0J/9V7oVRS59Dk+lLozES25/jXP0fCKZYHcfzCRNONMzu2vjkT30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278288; c=relaxed/simple;
	bh=yjvhDHIcsKK4QW/n4MuY40WBUBCAz7xIHU2CpzNCeQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OfH1/CTQ9eySm1NJtkk74MnKgGdqWOy+L1apjnvksqVUkrg7/3py0dBKCY6GqtWkfZHWSkY+oCA8UOyHPc7Br11jZPRWb3Nbqv/iFqT1cE2G6enQofauhNqt2S9d2HErgsG6MGvaATty/ggoJ/pCcvN7qXY9ucQo9Cii8ylWII4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oYBfkKUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFB9C4CEF7;
	Mon, 23 Mar 2026 15:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278287;
	bh=yjvhDHIcsKK4QW/n4MuY40WBUBCAz7xIHU2CpzNCeQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYBfkKUm5zo3Bsx5sFbAqPRdyiHq9xD9xwqzLekzf4Ia/f0O2fliV8gRpLDENhVqR
	 dnYle/2yH56AHb7WYiSJizsNcjFqgQyN9dhH/HhhpxMIkT1AsH3LOXzQAtPSiy6Xfo
	 5jZQqCqETmIiMdn9gs57lOFVvuE7O4YMd7qUTJ58=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 233/567] net: sfp: improve Huawei MA5671a fixup
Date: Mon, 23 Mar 2026 14:42:33 +0100
Message-ID: <20260323134539.601409606@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lunn.ch,kernel.org];
	TAGGED_FROM(0.00)[bounces-229172-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C63B32F644B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Álvaro Fernández Rojas <noltari@gmail.com>

[ Upstream commit 87d126852158467ab87d5cbc36ccfd3f15464a6c ]

With the current sfp_fixup_ignore_tx_fault() fixup we ignore the TX_FAULT
signal, but we also need to apply sfp_fixup_ignore_los() in order to be
able to communicate with the module even if the fiber isn't connected for
configuration purposes.
This is needed for all the MA5671a firmwares, excluding the FS modded
firmware.

Fixes: 2069624dac19 ("net: sfp: Add tx-fault workaround for Huawei MA5671A SFP ONT")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20260306125139.213637-1-noltari@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 6ef50d1ce2eda..00bbe20b0b43e 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -359,6 +359,12 @@ static void sfp_fixup_ignore_tx_fault(struct sfp *sfp)
 	sfp->state_ignore_mask |= SFP_F_TX_FAULT;
 }
 
+static void sfp_fixup_ignore_tx_fault_and_los(struct sfp *sfp)
+{
+	sfp_fixup_ignore_tx_fault(sfp);
+	sfp_fixup_ignore_los(sfp);
+}
+
 static void sfp_fixup_ignore_hw(struct sfp *sfp, unsigned int mask)
 {
 	sfp->state_hw_mask &= ~mask;
@@ -501,7 +507,7 @@ static const struct sfp_quirk sfp_quirks[] = {
 	// Huawei MA5671A can operate at 2500base-X, but report 1.2GBd NRZ in
 	// their EEPROM
 	SFP_QUIRK("HUAWEI", "MA5671A", sfp_quirk_2500basex,
-		  sfp_fixup_ignore_tx_fault),
+		  sfp_fixup_ignore_tx_fault_and_los),
 
 	// FS 2.5G Base-T
 	SFP_QUIRK_M("FS", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
-- 
2.51.0




