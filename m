Return-Path: <stable+bounces-217051-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOPINu3TlGmfIAIAu9opvQ
	(envelope-from <stable+bounces-217051-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:47:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 181231504A2
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A2B2300845C
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0640B284B3B;
	Tue, 17 Feb 2026 20:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NBXvWSJI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC747A13A;
	Tue, 17 Feb 2026 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361253; cv=none; b=NZXnAj2xn060zF6yVi1aAanvYTmtNmeH+nkIwkifmHMzhQpmZlzKyp08dFOlXFdZ+moFlS2oXg1xJVv2oFGP0rxsCaI6mt6MlqKlT5iIABhvY3mw6isqWKRIX9i+VBLhhzYQVp5rUduf/kR65wVHvBZoLxgMZVo/V6FRRsiZmLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361253; c=relaxed/simple;
	bh=X58tokUHQiamljwo5OfrGKfsZkHLLd3aAaxIJ3pgi+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYD0khQWNqTUQA/0Yi4Wrgt3xqL1ppj//zVHHvKnz6hpIJyDOg3Ppi3LgLDlLgVNc8TNlcXDJRO/1+tYtt3JGa4iDOPKClzcYAUxyTUpwpMd7AUhoiM7WBcaT3KSh0VfTBwZKCXti5WzgK+vPX1a+r63uzQEcw//dHiKOoQV5ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NBXvWSJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D66C4CEF7;
	Tue, 17 Feb 2026 20:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361253;
	bh=X58tokUHQiamljwo5OfrGKfsZkHLLd3aAaxIJ3pgi+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NBXvWSJIApC1lQ50ZYE8UtcKKOklJo+FLYkSXvzftSOf1QJPRIc6pY8XsPBZD3Msc
	 XpMkEjLIBRk+vJlNEkG5dtJHgC9UK2r8csvshWhl08Rb5A5FvFZaDJK8i+9ndXNM6n
	 SgSEBTVyQun0YlozjTUS6OPQiv9i46s4rD8Coi9w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anatolii Shirykalov <pipocavsobake@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 29/64] ASoC: amd: yc: Add ASUS ExpertBook PM1503CDA to quirks list
Date: Tue, 17 Feb 2026 21:31:25 +0100
Message-ID: <20260217200008.611813650@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200007.505931165@linuxfoundation.org>
References: <20260217200007.505931165@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-217051-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 181231504A2
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anatolii Shirykalov <pipocavsobake@gmail.com>

[ Upstream commit 018b211b1d321a52ed8d8de74ce83ce52a2e1224 ]

Add ASUS ExpertBook PM1503CDA to the DMI quirks table to enable
internal DMIC support via the ACP6x machine driver.

Signed-off-by: Anatolii Shirykalov <pipocavsobake@gmail.com>
Link: https://patch.msgid.link/20260119145618.3171435-1-pipocavsobake@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 6bbbcf77fc525..43f7f64015b25 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -451,6 +451,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "15NBC1011"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ASUS EXPERTBOOK PM1503CDA"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.51.0




