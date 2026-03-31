Return-Path: <stable+bounces-232259-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFbPLpv+y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-232259-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:04:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 760DB36DCB4
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3023E3091834
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2835413258;
	Tue, 31 Mar 2026 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="otW8v2vF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9559C29DB8F;
	Tue, 31 Mar 2026 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976287; cv=none; b=hdpDdYJZy4ND2snlH/dFNCeKcZOZLV4ddkdoAqs7/dWfMIOn3zdzWN//k+YjDiV+VfpO1ESgEwOIDuQbRQTbu3mkaE5pnPBydMTzNPVoTAYiaolYiYIB0AzkOQSe31wy1tHHb76I1vb94x1ztfT/DRi2UumOTYrvd8Qi3yVdSMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976287; c=relaxed/simple;
	bh=zhFjlOsEfYtSFsa4t1X7C889HTxdVQvXfEP1u8S6NaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mD5RqfciRFHvFf6pz6hNb1uoUCKlOpKFiT/vbGr4UG7xxvhScptl4LNEqyBPfUdDap/sPNIF3ivPIPB18OW9P91Hh4bt74j0OM5QCz7IEGJh4hmLnAXiLGx2HYpU0XErXLkqNew42XUC1RImKLmjVza+/9Tvw64n4MURPdbtKqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=otW8v2vF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C87AC19423;
	Tue, 31 Mar 2026 16:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976287;
	bh=zhFjlOsEfYtSFsa4t1X7C889HTxdVQvXfEP1u8S6NaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=otW8v2vFEf6BdFyJYzp74gzaTvnK/jeRw8/NIzfllwHbP9Tgi1Cmj2PdoQgBnYglW
	 TaVqDY9kzkT1pf7ISpo0POKybMUQXikRkNfr7r+OFTdOlsP9zrvnl8BtlIUE8929XK
	 orwYFWtjqpIlLoW9pDwxgMXLQWEwuXCOadWptAmY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antheas Kapenekakis <lkml@antheas.dev>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 035/309] platform/x86: oxpec: Add support for Aokzoe A2 Pro
Date: Tue, 31 Mar 2026 18:18:58 +0200
Message-ID: <20260331161754.774469980@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232259-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,antheas.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 760DB36DCB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antheas Kapenekakis <lkml@antheas.dev>

[ Upstream commit cd0883055b04586770dab43c64159348bf480a3e ]

Aokzoe A2 Pro is an older device that the oxpec driver is missing the
quirk for. It has the same behavior as the AOKZOE A1 devices. Add a
quirk for it to the oxpec driver.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
Link: https://patch.msgid.link/20260223183004.2696892-5-lkml@antheas.dev
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/oxpec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index bf07732776ca9..d66c9c0003585 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -124,6 +124,13 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)aok_zoe_a1,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AOKZOE"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AOKZOE A2 Pro"),
+		},
+		.driver_data = (void *)aok_zoe_a1,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AOKZOE"),
-- 
2.51.0




