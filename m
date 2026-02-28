Return-Path: <stable+bounces-220898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEQNHk1Go2li+wQAu9opvQ
	(envelope-from <stable+bounces-220898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:47:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F389D1C75CA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A95B5363D53B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F234262BA;
	Sat, 28 Feb 2026 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjuIlDpq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651DE4262B0;
	Sat, 28 Feb 2026 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300787; cv=none; b=cvzBsvy+ffdXkhvbjDmx55QaX7lnNnEelu7LJlRsfOYUDhKVCbSzWdfDaQQF3fjAYe561agQeqKW4zEK3iXiho584GmvHLGe8SWxeQfVh4bEOge8+L/pBPg7AIYPghIBGd4wqTB7zNTe9Qv2eebJVbTuxd16CBQdd+wfPTr726Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300787; c=relaxed/simple;
	bh=/PlTOHnxU+YtZ/oVw0B8iKFTALZYB8xaIPwatim10WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oj5yUEabrLSQTm3WzB4ZirSZaBGffGHtlOFiHyxVd83Oaj0ffFhIkbS55hs83FpLUkY+3tYZhs+LlSXZJsAvtOyTfF9AB+WJJBjMAtMwpGOW67ZASzwu8Dwxo3ZJhEFkFCGh0Nyv5kXqbFUHC0lFQprsnvecn/BGyZoRCVDw8+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjuIlDpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B223BC19424;
	Sat, 28 Feb 2026 17:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300787;
	bh=/PlTOHnxU+YtZ/oVw0B8iKFTALZYB8xaIPwatim10WM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AjuIlDpqx3irCfd35TG9hgykb3cPSRIQLt2f+i81TfxcNjrSquChYua6f8vlWK5Kt
	 7ISdP+hEaDMQvnMVf38VcGP71qPLpstf5fK3gZfiV3Af+XdTlmYBSayJIhSP/8cVo4
	 sYu5Uf3kX6e59hatmw5UtsvUrIbnoIOlCEwMzYtslGaBSI41kgL+qmsQwJ79V23gFt
	 aDciUazCwr6OKM5+59a0nVpF2hCSiyIDiBqdHK+XyyT0Wz9kvEDANzKk7YOSxb+9qv
	 RjWDRzdZA0vIWLwTLcxJkQmEhtLT8W++sQxFpTWdME3gerWu9rwD0dDezNBdsHcIQz
	 IGD/PpV/UsOvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gustavo Salvini <guspatagonico@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 819/844] ASoC: amd: yc: Add DMI quirk for ASUS Vivobook Pro 15X M6501RR
Date: Sat, 28 Feb 2026 12:32:12 -0500
Message-ID: <20260228173244.1509663-820-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220898-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: F389D1C75CA
X-Rspamd-Action: no action

From: Gustavo Salvini <guspatagonico@gmail.com>

[ Upstream commit ff9cadd1a2c0b2665b7377ac79540d66f212e7e3 ]

The ASUS Vivobook Pro 15X (M6501RR) with AMD Ryzen 9 6900HX has an
internal DMIC that is not detected without a DMI quirk entry, as the
BIOS does not set the AcpDmicConnected ACPI _DSD property.

Adding the DMI entry enables the ACP6x DMIC machine driver to probe
successfully.

Cc: stable@vger.kernel.org

Signed-off-by: Gustavo Salvini <guspatagonico@gmail.com>
Link: https://patch.msgid.link/20260210155156.29079-1-guspatagonico@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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


