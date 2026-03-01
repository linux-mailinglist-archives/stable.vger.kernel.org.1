Return-Path: <stable+bounces-222207-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC2bIk+fo2lzIgUAu9opvQ
	(envelope-from <stable+bounces-222207-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:07:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A971CD012
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76CE83055DB5
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E752EE5FD;
	Sun,  1 Mar 2026 01:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLU83/7b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432F42E7648;
	Sun,  1 Mar 2026 01:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330307; cv=none; b=e52gfeSPN9H4GpuBHnTDkITeqDMQOEkPtNP3QYJXe+hGt5XsnL6pi3hFQyT0qNV3/PIbKJtoeWykdL+MhoHZKO6+dnsR9pBA3JEFgSKdqTeNVT9NnJeIuK05jcmKaZrosD6chCYAZtNGimNuv6Wv0z8KdLldKU3AeCkcg8+7zmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330307; c=relaxed/simple;
	bh=uZEcPk7V8q+Q5V1pOHmLcUCdAtJv9/Gv3wyNTDRBj0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NoP1KvC9AgoRaC0AcFPBU2nFm09/ogfohbseMdGHhduQHcoEh8X02HkL0IXSjHToaRGJJkW495ouoCp9eaz7D/g9qJ2pC3RIjbDAG77RAzgCA1tXmsCQ8caaFiBpTOnm7x3LtYMUuH6YDj7Q1riFQsaBnzG69LliXCd49AcKUFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLU83/7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541D5C2BCB3;
	Sun,  1 Mar 2026 01:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330306;
	bh=uZEcPk7V8q+Q5V1pOHmLcUCdAtJv9/Gv3wyNTDRBj0M=;
	h=From:To:Cc:Subject:Date:From;
	b=jLU83/7bPgV1Lxy006x3mFAmwCZX4TwuCjimTDPlkihSXxnQW//F75wqcBeAtcxfY
	 ptFE8vMrlurn6t4JZJK3DrdseYqS6uKRc/+ZxVZKoJvUfzojafNILpwtcvf3KCpyMV
	 xCgEjHrU8mrLKoIoVzNTi89FvfUyiw9eAH0vI+upn95gZ3stnHipow4/nvL56kvW9d
	 r9BxWPE0jiqd6l9jom5Nz63IZjnWq9sypEqtWzZ8rCQoDL4NnC7rk+dVGdNBJ5zItL
	 FltT3i0TnFfgFq7ERI6qwTCYGUqMrIhFbiH6Mld/rvPlpx9XTMdCowYfkJ06gsNw/k
	 3KvRdXMez+JBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	guspatagonico@gmail.com
Cc: Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org
Subject: FAILED: Patch "ASoC: amd: yc: Add DMI quirk for ASUS Vivobook Pro 15X M6501RR" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:58:24 -0500
Message-ID: <20260301015825.1723867-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222207-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 99A971CD012
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
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





