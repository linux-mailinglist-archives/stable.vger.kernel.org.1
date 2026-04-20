Return-Path: <stable+bounces-239592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iELDNQxm5mlmvwEAu9opvQ
	(envelope-from <stable+bounces-239592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:44:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26124431F91
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C27CF31544CE
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8168A331A78;
	Mon, 20 Apr 2026 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gcHqoyVm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B401EB5CE;
	Mon, 20 Apr 2026 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700652; cv=none; b=Xu+xxWFzAk2yFarbGP2uRwl6xN0RQm/FcEhJm+l0dce1zBRM+nzIuuhNDqJaDWi6CE98j365v295zmwGGp2e4lLIzBFSGjndE3Iskh+GqsqQhPyQxdCUS70O3wbA+Y7kfn5h2bvVxmQGLyVo4ul7cDFnZgPi/Uvt5YR/fOrcsuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700652; c=relaxed/simple;
	bh=dzvMO5IZG8z9djbgwdKWzJ8ut9+WUuHf0Z13kOWr6rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CuBJQ/HBDdVjUarMZrnqorRPqaK59CGD79KOe+S9TlUZd0KuQR487rtpaIB+ndDHHzI73ElPyyUXN6jAkuwe1tYGEVGx5R3mwFt53qPKn8tl3XzeAlQoBto28Cge14FVc8YgV016XeCJYcPiS3pmp/G71aKIx96IhHa8L8ILZSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gcHqoyVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9507FC19425;
	Mon, 20 Apr 2026 15:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700651;
	bh=dzvMO5IZG8z9djbgwdKWzJ8ut9+WUuHf0Z13kOWr6rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gcHqoyVm6YEpKbRGo1mrdweXMC9fJieSB9bx8K0j8VG+sAqEdiqYfCQXYF2Agn0FE
	 IJBWoxrezSC2PYe/NzAHE3lu0H0YdGsA+aWH+JXK8b5bfOtOASbXZNnzA3GWVyV/YH
	 XDziKQcTEIaLkJf9/naV0lV8PkhzSH80iezf4Hvw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Gilson=20Marquato=20J=C3=BAnior?= <gilsonmandalogo@hotmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 033/198] ASoC: amd: yc: Add DMI entry for HP Laptop 15-fc0xxx
Date: Mon, 20 Apr 2026 17:40:12 +0200
Message-ID: <20260420153936.811251904@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239592-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,hotmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 26124431F91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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




