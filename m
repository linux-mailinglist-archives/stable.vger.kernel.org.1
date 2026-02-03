Return-Path: <stable+bounces-213188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFyLBFPNgWl5KAMAu9opvQ
	(envelope-from <stable+bounces-213188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 11:26:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71273D7945
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 11:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15757301D042
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530CB318136;
	Tue,  3 Feb 2026 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+xyYHsf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106833126DA;
	Tue,  3 Feb 2026 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114185; cv=none; b=DcTpshLZkR1G2v9yIbcB1G1Ku1YahLq01kSWGXx0b7VFUNIQeTpQo/Je4C8pAdReW7srKojfRlbSyqJ2Wuzzu96SZWHDhCt1E8nedeXSuCV0ZdD/ecujmiiVahgdwTgJuDs0uHxKJvl6tUTRAJp9IjCT8Atw1/ukeGczMn/Y2Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114185; c=relaxed/simple;
	bh=KJC2+BCP3Cp3Mxq0CHhO5b16UGVjEycKEKgRj63ibro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DcW1K5eb2gHIuRraoJzta+yhPVIFV7XLxk9XnGKde8adH0x+SumJV810kOOuLoL2FOtmPxGOrH6x4rlvPQyxCuTMF29KrsoL0wD++AZKgu8kFk4MfKk36JHmiGYaq+L6mzyXippMmHNUpz+OD/l20kx+HdHbryM+gU94zlRKzpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+xyYHsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0143EC116D0;
	Tue,  3 Feb 2026 10:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770114184;
	bh=KJC2+BCP3Cp3Mxq0CHhO5b16UGVjEycKEKgRj63ibro=;
	h=From:Date:Subject:To:Cc:From;
	b=r+xyYHsfFgL5s/eKBVoOwVkXsHFv89RhH/QBcQcAM76YCJTQhhaC97Vwteq39GnEq
	 kDY4mufMK30Kv53oXBqGpQtflaqz7b0HpZSsD/cU9BRBoMuslVnYht/3OANqJ/1wgk
	 RVJ4lNRdIxn+d2ksTCmq2LZNRo2Zz1SWVhj26xDhBtsR62yhUJ2WsFgdg9v+hmq+EM
	 qaTW6Xjw2M0UewBYC6runi2dLvmArN0jfCpGUEjwIrFoZN/NCe2K9o9xgQ5LbplE7E
	 xTJON5nKgSBbEQSalZojDKpBVvhlbXZszBwm1X0d2fUsorgX9Ws1nzrdJjz1ZOWR8k
	 eTJfUZc9+Gb8w==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 03 Feb 2026 11:23:01 +0100
Subject: [PATCH] ata: pata_ftide010: Fix some DMA timings
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-gemini-pata-fix-v1-1-67e1c182b45e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MywqAIBAAfyX23IIPCOtXooPoZnvIRCMC8d+Tj
 jMwU6FQZiqwDBUyPVz4ih3kOIA7bAyE7DuDEmoSSmgMdHJkTPa2uPOLRqqZjPbkpINepUxd/8d
 1a+0Dv7YEVmEAAAA=
X-Change-ID: 20260203-gemini-pata-fix-8129e83dec1c
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, 
 Tejun Heo <tj@kernel.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: linux-ide@vger.kernel.org, stable@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213188-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,googlemail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71273D7945
X-Rspamd-Action: no action

The FTIDE010 has been missing some timing settings since its
inception, since the upstream OpenWrt patch was missing these.

The community has since come up with the appropriate timings.

Fixes: be4e456ed3a5 ("ata: Add driver for Faraday Technology FTIDE010")
Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/ata/pata_ftide010.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
index c3a8384c3e04..c41da296eb38 100644
--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -122,10 +122,10 @@ static const u8 mwdma_50_active_time[3] = {6, 2, 2};
 static const u8 mwdma_50_recovery_time[3] = {6, 2, 1};
 static const u8 mwdma_66_active_time[3] = {8, 3, 3};
 static const u8 mwdma_66_recovery_time[3] = {8, 2, 1};
-static const u8 udma_50_setup_time[6] = {3, 3, 2, 2, 1, 1};
+static const u8 udma_50_setup_time[6] = {3, 3, 2, 2, 1, 9};
 static const u8 udma_50_hold_time[6] = {3, 1, 1, 1, 1, 1};
-static const u8 udma_66_setup_time[7] = {4, 4, 3, 2, };
-static const u8 udma_66_hold_time[7] = {};
+static const u8 udma_66_setup_time[7] = {4, 4, 3, 2, 1, 9, 9};
+static const u8 udma_66_hold_time[7] = {4, 2, 1, 1, 1, 1, 1};
 
 /*
  * We set 66 MHz for all MWDMA modes

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260203-gemini-pata-fix-8129e83dec1c

Best regards,
-- 
Linus Walleij <linusw@kernel.org>


