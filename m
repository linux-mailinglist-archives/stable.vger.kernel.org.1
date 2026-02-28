Return-Path: <stable+bounces-220763-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOhUGSZWo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220763-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:55:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEB51C89CF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB66D3372F3B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E343040625C;
	Sat, 28 Feb 2026 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="es8l/TAz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D2C406255;
	Sat, 28 Feb 2026 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300643; cv=none; b=PLL+SLgCJwGA9duFb7QyfFGdNeHUlbc2c5IpeKGtpwapPTFV6IaHp+hxqE0aEd5VxdCBEDQGWBhb2exxg49/SUy7Rxm8fuf2gzI09QMkpPfQ0UDJXQ2m9tfp5RNsePSOYh/TBXutCowjHd3JdtCSMoOFtKDCq8zVAV8jatc7CNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300643; c=relaxed/simple;
	bh=CVsQXwErh+3UDMxzd+f1OyBwyYab9vaX/eDRrIKzo50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnYxKETcxYKRgl1PsBjmVrFn65MIBLug0X97jy1lDejnfNjiH4aVkHp2gisk/kmvc7jGkV7EJaCZ1tpVzCxHxrJUTlcvjABClxov2Q4BDFwabGp8DGtpXZrxtYxI6xFvm1ie1JopZZAe6kYJ9ocm3ungr5iUC7FQ1/CnpoMfgUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=es8l/TAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854F6C19423;
	Sat, 28 Feb 2026 17:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300643;
	bh=CVsQXwErh+3UDMxzd+f1OyBwyYab9vaX/eDRrIKzo50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=es8l/TAzStZ1vYjObZUfbydS9B8ObfxPPhnD3N0fYTxMUVBSw3hYfSnQF4i46koTW
	 COVYxp9QiLDwQgv4c3cuW6Tbt7Rvbz+cUI2x4MqB4/WlpKFi/3WJ4rRAtNy55ww52V
	 nZ6t2gklbNQfOAcWYJeh2Bgv963sxe/7ZXYdA5wg2IuZ5Y/IvdNFAczzGREOS5aIkw
	 JJggywGgDmo+Q5ZfBPL30qDUXSF32RhRfAQxH5zseBZgCp41JmknT72M6hY5/Uwm5V
	 RnPL9qi3avqQs8j9f4Q64qT41qf79gjal4WNB+I/DqgIGE1OHD7ApKBU8PLOq4cTuB
	 GKD9ZuyRjaa4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Stephen Boyd <sboyd@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 684/844] spmi: apple: Add "apple,t8103-spmi" compatible
Date: Sat, 28 Feb 2026 12:29:57 -0500
Message-ID: <20260228173244.1509663-685-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220763-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,gompa.dev:email,linuxfoundation.org:email,jannau.net:email]
X-Rspamd-Queue-Id: 6CEB51C89CF
X-Rspamd-Action: no action

From: Janne Grunau <j@jannau.net>

[ Upstream commit 6c54b0a801dd8227237ba0bf0728bb42681cf027 ]

After discussion with the devicetree maintainers we agreed to not extend
lists with the generic compatible "apple,spmi" anymore [1]. Use
"apple,t8103-spmi" as base compatible as it is the SoC the driver and
bindings were written for.

[1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/

Fixes: 77ca75e80c71 ("spmi: add a spmi driver for Apple SoC")
Cc: stable@vger.kernel.org
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Link: https://patch.msgid.link/20260123182039.224314-7-sboyd@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spmi/spmi-apple-controller.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spmi/spmi-apple-controller.c b/drivers/spmi/spmi-apple-controller.c
index 697b3e8bb0235..87e3ee9d4f2aa 100644
--- a/drivers/spmi/spmi-apple-controller.c
+++ b/drivers/spmi/spmi-apple-controller.c
@@ -149,6 +149,7 @@ static int apple_spmi_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id apple_spmi_match_table[] = {
+	{ .compatible = "apple,t8103-spmi", },
 	{ .compatible = "apple,spmi", },
 	{}
 };
-- 
2.51.0


