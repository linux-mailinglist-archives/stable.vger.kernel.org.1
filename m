Return-Path: <stable+bounces-220476-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI8iBQk8o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220476-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:03:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DBE1C68C0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA9993225343
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6193A3C1555;
	Sat, 28 Feb 2026 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/qomozQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2349D3C1525;
	Sat, 28 Feb 2026 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300363; cv=none; b=ky+3v4CEBH285zbnwE83I/586LGvKlw77WRrMCqV8aiKgPa8mftBbzroFNRAnKKYjSAZRV+XkGxU8uhWESowamYL5DQr/GmTy4lrh+zLl3W2hgk8Z/fuif+LKKWydjyws3qQPs0+ImHb9FQNKPVIjU335pj/qTJSYgJMv51hoaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300363; c=relaxed/simple;
	bh=Z/bdLUj1wqj9sxsuaIVpV0P7vtGpNZAyjM/rPm9AFew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVXrnGJ9hk6W0/oR+GTos28LR6IDXWZh20I07KTo9kwkPw1ugvkqfDnfutkwBxGkiCgtP4lNJEAGQaPDWDeucQjqJ17AtaUC9QDzPHdxpqlm4A8VTq8FZZBd5iMigVYYkhvM7VyexusMNwAMH47CWObEqSH54O6zhnC8BQgIiek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/qomozQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C32AC19423;
	Sat, 28 Feb 2026 17:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300362;
	bh=Z/bdLUj1wqj9sxsuaIVpV0P7vtGpNZAyjM/rPm9AFew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S/qomozQxob5xbkQeTDbpko8npmVMNrh6g3MXPS7EhbeJvDzZa+6CWCiYKD1JhPFS
	 snu7jtpJcyvUhlSEUepl5aDnBX0aDH2wKlUaCUW1odIxH38nnUM3iPI8ab/2CnjXzT
	 BHDtKyibIsoPaKK/WDZdT1dNGXwI8JD4Ltdapf1yxZXG/KtSOAOzgU2zBWTxXlEXu7
	 3t+wO2ltLdN2QOZc+ngi1DzWe+2BEdLp095yLRONUPFXDAACL/F3WNS4X/ZX50FSDl
	 I+POmL3hngrVh1x6f79qS8f0oFPR8N8W50w1dPsgMrxGtIJ1huB4hxbZADI67cp3S2
	 BDKecY4E6U/mQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 397/844] Revert "mfd: da9052-spi: Change read-mask to write-mask"
Date: Sat, 28 Feb 2026 12:25:10 -0500
Message-ID: <20260228173244.1509663-398-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220476-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30DBE1C68C0
X-Rspamd-Action: no action

From: Marcus Folkesson <marcus.folkesson@gmail.com>

[ Upstream commit 12daa9c1954542bf98bb942fb2dadf19de79a44b ]

This reverts commit 2e3378f6c79a1b3f7855ded1ef306ea4406352ed.

Almost every register in this chip can be customized via OTP
memory. Somehow the value for R19, which decide if the flag is set
on read or write operation, seems to have been overwritten for the chip
the original patch were written for.

Revert the change to follow the default behavior.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Link: https://patch.msgid.link/20251124-da9052-revert-v1-1-fbeb2c894002@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/da9052-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/da9052-spi.c b/drivers/mfd/da9052-spi.c
index 80fc5c0cac2fb..be5f2b34e18ae 100644
--- a/drivers/mfd/da9052-spi.c
+++ b/drivers/mfd/da9052-spi.c
@@ -37,7 +37,7 @@ static int da9052_spi_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, da9052);
 
 	config = da9052_regmap_config;
-	config.write_flag_mask = 1;
+	config.read_flag_mask = 1;
 	config.reg_bits = 7;
 	config.pad_bits = 1;
 	config.val_bits = 8;
-- 
2.51.0


