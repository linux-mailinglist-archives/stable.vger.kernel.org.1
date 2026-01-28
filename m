Return-Path: <stable+bounces-212374-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AIrATcxemlT4gEAu9opvQ
	(envelope-from <stable+bounces-212374-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:54:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C37DA4B23
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FEFC305018A
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD6D30BB82;
	Wed, 28 Jan 2026 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1M6tI1lG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9C8309F1B;
	Wed, 28 Jan 2026 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615306; cv=none; b=gPt10RLFcZc18701E3H9EjZug1quoOfySKyg848FKau4KIwyK6GOVs3OcSyC8jwyUje8ueIHzdyKpYtxEAfGEKdvANat7OBY6+nnR7Grj0BtHKB549SaslD8dMZLpKtm3bc65a0SgPcumoRdzicizCTIH9+mPNLwBNbLwX1Vbr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615306; c=relaxed/simple;
	bh=xJ+XkHkMAnBR/Vu2z/043zKNJPUsSod73UmpAr213wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i24MAT7PPgdRFYo2JouVey6zQN+0GRNVKD+1w8nT4y08pP1dWYXrRaugOWzlLJFAQfeZLdHO0Vxa1/a9VlA/gnkJikd0aHk5ryJAHzlE1uICgIjJntQBNnTmg/u2psDmTvrdD2IjgZ3dA7dMwS50tUlM4bS2/G8sgHhtx5j2NNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1M6tI1lG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34C0C4CEF1;
	Wed, 28 Jan 2026 15:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615306;
	bh=xJ+XkHkMAnBR/Vu2z/043zKNJPUsSod73UmpAr213wA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1M6tI1lG/AeW9hH7qYupcBeYfInhdCl9M2GOnr2wIGVbyPiOYG/bvwi47kjvNd/5T
	 GXPzgcTZ5qruBJeDNKW62wqZVB1l6xMxzzG2vrRKa3O0cQnukRC4W2znRRaBd9+MKX
	 i/7RewMbniVY4flbS69/hsdWmdgQeRtmqdFql5lA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hamza Mahfooz <someguy@effective-light.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 139/169] net: sfp: add potron quirk to the H-COM SPP425H-GAB4 SFP+ Stick
Date: Wed, 28 Jan 2026 16:23:42 +0100
Message-ID: <20260128145339.008701342@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212374-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9C37DA4B23
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hamza Mahfooz <someguy@effective-light.com>

commit a92a6c50e35b75a8021265507f3c2a9084df0b94 upstream.

This is another one of those XGSPON ONU sticks that's using the
X-ONU-SFPP internally, thus it also requires the potron quirk to avoid tx
faults. So, add an entry for it in sfp_quirks[].

Cc: stable@vger.kernel.org
Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
Link: https://patch.msgid.link/20260113232957.609642-1-someguy@effective-light.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/sfp.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -513,6 +513,8 @@ static const struct sfp_quirk sfp_quirks
 
 	SFP_QUIRK_F("HALNy", "HL-GSFP", sfp_fixup_halny_gsfp),
 
+	SFP_QUIRK_F("H-COM", "SPP425H-GAB4", sfp_fixup_potron),
+
 	// HG MXPD-483II-F 2.5G supports 2500Base-X, but incorrectly reports
 	// 2600MBd in their EERPOM
 	SFP_QUIRK_M("HG GENUINE", "MXPD-483II", sfp_quirk_2500basex),



