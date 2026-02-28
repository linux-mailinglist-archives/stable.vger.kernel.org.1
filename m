Return-Path: <stable+bounces-220080-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAWmI80mo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220080-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:33:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0721C4E7C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF40030387CA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2825332EA7;
	Sat, 28 Feb 2026 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WR76vOUc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B96328B78;
	Sat, 28 Feb 2026 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299969; cv=none; b=HyAJ6v8sgaBn5bR8gtECuVZUKiTRWh8AeXn/ju/fynrWD4EDdvv/J43spVZYUNjSAv4CJ5mV3f8N3cI8qSNG/IHWv0w5+FzWtn/fNmKvc3LudydIGZrDOxApmMUofIrftObu0xWQX23ubb8sZrM5VVzUs8KRECBv4vL/fXGvVBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299969; c=relaxed/simple;
	bh=9taDygXBPHFAL+8NwE6jVOboCmH2pLTlGH9WJiMeZew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/sUl/lah0nGj3i+i8qjocCUm4yUo0FBcliSo1fAxx59fi2R/7PV4PJ8XmWFmxvQJiDH1CCh1uuNawlQEKDSR6lNdH3D8LsHijv8gYAO70DGT0paE9+3RTM2Y1f/DFsEWlGjH8+sBFIVj5n7/oyqICKfL3arZGmI4QG/TbrisNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WR76vOUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E038BC19423;
	Sat, 28 Feb 2026 17:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772299969;
	bh=9taDygXBPHFAL+8NwE6jVOboCmH2pLTlGH9WJiMeZew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WR76vOUcrDpt2e0jkV7hy8NeVketJjy4cZlb8ad/xpjyz/HXya5Eik5mDZ7Bx3kE1
	 61gIbfnhHX28P3xBIfUuxAnyGYUOvbdahLphC9HjbZdzcpy6/EmsKtXCb/E5qk33+b
	 eDrDiuFRXuVgnLIHOt4uVchsHXjjhqdwtkcjGU1QcpMehAehHZGxZmdnP6N4EXS7wj
	 LXMPENMhlYiaa5YU39F3L9kBYFQFyTJsb3tdCGyb5SzDB7+oWBQg5bbiLo5mDuvemh
	 N38lek+OKH9rK19+EYv8DgTwELNn5PwnPg+lpAgrzEBCaPycXrJo/WFFezTDzBvmSG
	 MDG1AmgvkSQVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 002/844] mmc: rtsx_pci_sdmmc: increase power-on settling delay to 5ms
Date: Sat, 28 Feb 2026 12:18:35 -0500
Message-ID: <20260228173244.1509663-3-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220080-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 2E0721C4E7C
X-Rspamd-Action: no action

From: Matthew Schwartz <matthew.schwartz@linux.dev>

[ Upstream commit aced969e9bf3701dc75cfca57c78c031b7875b9d ]

The existing 1ms delay in sd_power_on is insufficient and causes resume
errors around 4% of the time.

Increasing the delay to 5ms resolves this issue after testing 300
s2idle cycles.

Fixes: 1f311c94aabd ("mmc: rtsx: add 74 Clocks in power on flow")
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Link: https://patch.msgid.link/20260105060236.400366-3-matthew.schwartz@linux.dev
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 4db3328f46dfb..b6cf1803c7d27 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -937,7 +937,7 @@ static int sd_power_on(struct realtek_pci_sdmmc *host, unsigned char power_mode)
 	if (err < 0)
 		return err;
 
-	mdelay(1);
+	mdelay(5);
 
 	err = rtsx_pci_write_register(pcr, CARD_OE, SD_OUTPUT_EN, SD_OUTPUT_EN);
 	if (err < 0)
-- 
2.51.0


