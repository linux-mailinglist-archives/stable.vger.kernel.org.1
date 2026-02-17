Return-Path: <stable+bounces-216938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKoFEXrSlGmfIAIAu9opvQ
	(envelope-from <stable+bounces-216938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:41:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2276150128
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81DB43042FE2
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2890D3783AB;
	Tue, 17 Feb 2026 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lupe1eZk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF19F37755D;
	Tue, 17 Feb 2026 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771360867; cv=none; b=vGmgpohFDy3i7KLJKVjMkzUMkiKFrxYNL1q7FbCpb/25zrHevkocKBTMKPkW2nzzaAgGTFyRKG3YNNJJ50P+LeiQzoKiTV0zSfdWgrLvPSCv1nyR6yMyGgVyoMJWBBoUnDKwQVCmIyXG1b4/6l2X49iwynJDk0Yx8RKlWomz0CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771360867; c=relaxed/simple;
	bh=5fjSF+GE+FGLabiQf3DofV0L0xVEKb9aM5b9WzceauU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egusg4rt5Xbh11OjXK/xeeWKtP2WU0MoziiQkVqLq/qIjxz6vKx9LfruKZZq5V8gnjAaFgB1RNkrhyseEgXVBXWBCjohhb4eu6wyQ4AKtYeRbXaXi035eo3szZkZhJ4tJGxph79Okay4bnPOdjqhMLSLGUvyKaHgxCXC13G+Nio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lupe1eZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ACEC4CEF7;
	Tue, 17 Feb 2026 20:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771360867;
	bh=5fjSF+GE+FGLabiQf3DofV0L0xVEKb9aM5b9WzceauU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lupe1eZkcj01VlxQbHPS9yxmhSsIyigG+xD75PVVbU2eqp84UkRRfM3y0HFcPe5P5
	 rRd8CedR/JdIoxYJSeS3dgtVO3W8pEyKJrihvb3sEiT/aJI5cNYIOmNn0sYi7LG0Ue
	 i9Y5QU9PlE9iooi5O2oQDcM3qouD/LV8yoyNsl9A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anatolii Shirykalov <pipocavsobake@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 07/39] ASoC: amd: yc: Add ASUS ExpertBook PM1503CDA to quirks list
Date: Tue, 17 Feb 2026 21:30:29 +0100
Message-ID: <20260217200004.511178555@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200004.221651386@linuxfoundation.org>
References: <20260217200004.221651386@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-216938-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: E2276150128
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index b0456be5d921a..92d0d39d39d9a 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -535,6 +535,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
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




