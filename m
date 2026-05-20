Return-Path: <stable+bounces-252540-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJG0Bq37DWru5AUAu9opvQ
	(envelope-from <stable+bounces-252540-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:21:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0BE595E39
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDB343120F18
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668DE347515;
	Wed, 20 May 2026 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cr2a3nnZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FA981AA8;
	Wed, 20 May 2026 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300942; cv=none; b=WGWcvjX69zCW8UYOzu9Xj80DAzUduBIMxlkjTRmYbtszVUI3m9BuTt5DIxUBk2/WVEL4ighKds2k/tlM0jV/VeTOvOEG8Pp/R4Y7O6zkUT0kCzSY0BOrpUqx+jx97X81htS2kxUHn6udH5rnl7hay04peZcjm7fBBHbrZTqmeJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300942; c=relaxed/simple;
	bh=ZP+qidQzg8iHAjF7NeUresYK7DKlg/nqJy24RHKVPkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pajSfTwUVHjYBSVRXcS94OjmU2OunhEKdGuPxTC1nep3BtYvMchik576FWYzLSoFHxzCD60QZ4S+MpbWvxN+IkQC+FmmFZbTkLlQR1Xhbd5NgMcCe3roKR8q6WlFS3dLqZenFBd9NX/4C2Bq7//3Ynx3dVKLggh3EeiFLpAMiKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cr2a3nnZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAE71F000E9;
	Wed, 20 May 2026 18:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300940;
	bh=FSK9EJFNQv7nzf+F2aNoKHELqdkpqasaEIlSvrQsH/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cr2a3nnZDR3gmKRyOgIgmQ6TYzp8FQMZyUywR4F2ohx2cpgssLm5UWpNcwK52aKYs
	 CzU7trvtWpNrxCcQALKwJOpILbrD2xUCQXgH3IyGURfQwCaSZCUC9vQCpwqWDxciwI
	 GAFfPIt/xipw+bEl4pFktCcwXl6v9OGTDevtGd30=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 366/666] pinctrl: renesas: rzg2l: Fix save/restore of {IOLH,IEN,PUPD,SMT} registers
Date: Wed, 20 May 2026 18:19:37 +0200
Message-ID: <20260520162119.174526084@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252540-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,renesas.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8A0BE595E39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit d9a60e367919752a1d398ebeba667f1e200fae1e ]

The rzg2l_pinctrl_pm_setup_regs() handles save/restore of
{IOLH,IEN,PUPD,SMT} registers during s2ram, but only for ports where all
pins share the same pincfg. Extend the code to also support ports with
variable pincfg per pin, so that {IOLH,IEN,PUPD,SMT} registers are
correctly saved and restored for all pins.

Fixes: 254203f9a94c ("pinctrl: renesas: rzg2l: Add suspend/resume support")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260326162459.101414-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 8a7eb11df9029..bcb0c39369e05 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2812,6 +2812,13 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
 		off = RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
 		pincnt = hweight8(FIELD_GET(PIN_CFG_PIN_MAP_MASK, cfg));
 
+		if (cfg & RZG2L_VARIABLE_CFG) {
+			unsigned int pin = port * RZG2L_PINS_PER_PORT;
+
+			for (unsigned int i = 0; i < RZG2L_PINS_PER_PORT; i++)
+				cfg |= *(u64 *)pctrl->desc.pins[pin + i].drv_data;
+		}
+
 		caps = FIELD_GET(PIN_CFG_MASK, cfg);
 		has_iolh = !!(caps & (PIN_CFG_IOLH_A | PIN_CFG_IOLH_B | PIN_CFG_IOLH_C));
 		has_ien = !!(caps & PIN_CFG_IEN);
-- 
2.53.0




