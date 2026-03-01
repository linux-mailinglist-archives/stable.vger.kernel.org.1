Return-Path: <stable+bounces-222008-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGBwNCuco2l2IQUAu9opvQ
	(envelope-from <stable+bounces-222008-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:53:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8FE1CC28C
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51391307F00C
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E64D309EE6;
	Sun,  1 Mar 2026 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvqSfWOi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420DB2F49FD;
	Sun,  1 Mar 2026 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329680; cv=none; b=q3WEJP6G5KCURe1GkAKw6PcDsfK39uVHy/hf6m0PlaCJ6SuhyY3UyaDf9f7hviP7tExByX56hT/b7Sr1A+5wm3cADVaKUr51AuR6vtuxS1yuN1aGepBtbuSgwo9BR/JMK4IUpvtNv9xmhbRvGTvy+/sfun0eT0eA2vgvc0vsQMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329680; c=relaxed/simple;
	bh=aLgXm2MDOFieEr5niTOWxwLuliiD1luGdcd8iC1r7VI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hrU2Gi/f6GlvV2btJz62A2tn65gxHTjK3QHnoxYvUqR6CDV8+m6WQF1b+6usaw2XUbxEntemjPu0jPsCjTb3BH8OdEYTHJWFbfE2ZGEyxBjnOb4KbWym6wPO/M1/8/J5ONfzhqL3UgdRRsNU7F0YnnKLt4ANtZfB+fG682aCMBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvqSfWOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC48C19424;
	Sun,  1 Mar 2026 01:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329680;
	bh=aLgXm2MDOFieEr5niTOWxwLuliiD1luGdcd8iC1r7VI=;
	h=From:To:Cc:Subject:Date:From;
	b=KvqSfWOiSVlQMTEwSLWKOHxvwMzqhqwgAH+IUBwRp/aRM2NWcV0qNC3Ng7yOHXCsQ
	 4a96NnDykvSxGxp5JgsODoLWU8kfJv2arJ9NJuJdach1mfQNA+QMe3z0GZHT57ebsA
	 HX6uSuZ0tNLKLBplIJkBrQTAoHgDhnG1BMvlhTgK5mFTLY9AyCrNfYcy/neeYSoNj3
	 CrEpE5yfhnzklb1aCxwOsr9GtCrIYB1NAF6PTsJr8vv+rLOMBBarWfeBFqjg1KOoa1
	 Bh3PkUs0jQOTLHx/CIHaeh1QG9u6mse0zevpEprEdnFUPWNAi9IxtVFSS9P0DZsKmN
	 Zb4movDA+KJZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	guspatagonico@gmail.com
Cc: Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org
Subject: FAILED: Patch "ASoC: amd: yc: Add DMI quirk for ASUS Vivobook Pro 15X M6501RR" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:47:58 -0500
Message-ID: <20260301014758.1711998-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222008-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 8C8FE1CC28C
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ff9cadd1a2c0b2665b7377ac79540d66f212e7e3 Mon Sep 17 00:00:00 2001
From: Gustavo Salvini <guspatagonico@gmail.com>
Date: Tue, 10 Feb 2026 12:51:56 -0300
Subject: [PATCH] ASoC: amd: yc: Add DMI quirk for ASUS Vivobook Pro 15X
 M6501RR

The ASUS Vivobook Pro 15X (M6501RR) with AMD Ryzen 9 6900HX has an
internal DMIC that is not detected without a DMI quirk entry, as the
BIOS does not set the AcpDmicConnected ACPI _DSD property.

Adding the DMI entry enables the ACP6x DMIC machine driver to probe
successfully.

Cc: stable@vger.kernel.org

Signed-off-by: Gustavo Salvini <guspatagonico@gmail.com>
Link: https://patch.msgid.link/20260210155156.29079-1-guspatagonico@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 67f2fee193980..f1a63475100d1 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -696,7 +696,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "XyloD5_RBU"),
 		}
 	},
-
+	{
+			.driver_data = &acp6x_card,
+			.matches = {
+				DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+				DMI_MATCH(DMI_PRODUCT_NAME, "Vivobook_ASUSLaptop M6501RR_M6501RR"),
+			}
+		},
 	{}
 };
 
-- 
2.51.0





