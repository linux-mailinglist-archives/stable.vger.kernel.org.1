Return-Path: <stable+bounces-239380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGuEJGFX5mlQvAEAu9opvQ
	(envelope-from <stable+bounces-239380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:42:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1C242FDC1
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44D5833B206A
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DA2343D91;
	Mon, 20 Apr 2026 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sm0of1/i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B01341AD6;
	Mon, 20 Apr 2026 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700098; cv=none; b=FGLRarhWm0kkYD/0J7wgknC3QY0crPVbHUDpsYsW1L7iKDWS8QeFPwPnJrFsTMrn8kfII51uhVm8Dj+JmmlrWJVisSk9z5NayAY8DCLPVZqSuijhLQEQhp9pUvd3/KO0vfs+K9Qz/2I2PSKnrLv/Ne5+LSa4NGr1hcIk9r4gM8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700098; c=relaxed/simple;
	bh=ePjjkC861CG8LrSVln48WRq7MSGcBjHwi8VBo4C5j5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAND2xvsWFvmwoHBDHjzczXRMK47dPCxaYZrOKoUBBU7am+ee25Aq6XmH+EwW6s3DvfgtixkcDAvBf8D+7KPM93jtBAN6kgSIfio3uibkFUnHGHDtOrbj8lBMQd/owShER+hJDz9PLNkb48QwVhMLlnFEA5/FYjhm7Gxv82sXkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sm0of1/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEAFC19425;
	Mon, 20 Apr 2026 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700098;
	bh=ePjjkC861CG8LrSVln48WRq7MSGcBjHwi8VBo4C5j5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sm0of1/iHSYWudIfHz7UEO4p6ozGgunj6PmLv5Dwgv6Y1vWC44Js2yAth/Q1e+k7M
	 58MDaQLl4cQcv/StrE6nqGKa6VSRYXlchubMvwhva4N0Exc1UMO9w1P0pM9kv4VTLr
	 HWmJ+BrgvIQAKuGVrPwfyNMuXe30V0TL1D+g1lac=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Gilson=20Marquato=20J=C3=BAnior?= <gilsonmandalogo@hotmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 034/220] ASoC: amd: yc: Add DMI entry for HP Laptop 15-fc0xxx
Date: Mon, 20 Apr 2026 17:39:35 +0200
Message-ID: <20260420153935.264096321@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-239380-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,hotmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 4A1C242FDC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gilson Marquato Júnior <gilsonmandalogo@hotmail.com>

[ Upstream commit 8ec017cf31299c4b6287ebe27afe81c986aeef88 ]

The HP Laptop 15-fc0xxx (subsystem ID 0x103c8dc9) has an internal
DMIC connected to the AMD ACP6x audio coprocessor. Add a DMI quirk
entry so the internal microphone is properly detected on this model.

Tested on HP Laptop 15-fc0237ns with Fedora 43 (kernel 6.19.9).

Signed-off-by: Gilson Marquato Júnior <gilsonmandalogo@hotmail.com>
Link: https://patch.msgid.link/20260330-hp-15-fc0xxx-dmic-v2-v1-1-6dd6f53a1917@hotmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 6f1c105ca77e3..4c0acdad13ea1 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -45,6 +45,13 @@ static struct snd_soc_card acp6x_card = {
 };
 
 static const struct dmi_system_id yc_acp_quirk_table[] = {
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Laptop 15-fc0xxx"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.53.0




