Return-Path: <stable+bounces-220402-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBPgN/o2o2lh+gQAu9opvQ
	(envelope-from <stable+bounces-220402-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:42:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 703831C6246
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AA1B33DEAD5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABFB3AC63C;
	Sat, 28 Feb 2026 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQbmkhjO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CBF3AC633;
	Sat, 28 Feb 2026 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300294; cv=none; b=JSYTKwcB7F0F4jDKnx4IGwzQijmTjcxU0sKfrv4wtvFlDqGeTv0BtWSZ782x5l+llVtti9j17NPCieAasQQnhIZuidJZaScKyOtHtlDRy24FVsiSpNppuIWDMnxs2SG0wkJ67m+FzWb74XqSRkCKkViGbP5mpH/q6/QbOgQWkXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300294; c=relaxed/simple;
	bh=r2xgP5PyfmenROj68v9m+9bJzfof5h81AA6cs0O7Ns4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CEeVq5BJYqFQcOXkE8/mfE0pvH/mJwrm0MuUlRarWt+nspSiW1yUNQh39KoYE1W4VCLH9bwS4RyO1Wt40lYF9jcLVORS0Ax4eqc5Ia7V1Dx+actfXiMfeMC02XRZHTPNTK3LPwMQV3+UVr2hSUQt+y9ms9p2iDPA4OrFngVMvBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQbmkhjO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589D4C19423;
	Sat, 28 Feb 2026 17:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300293;
	bh=r2xgP5PyfmenROj68v9m+9bJzfof5h81AA6cs0O7Ns4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bQbmkhjOhnf4ariIISrIgX+KwBAPaKRsG040Lymq5ykRx7BKFhz0fNozVPav+4fhF
	 5qoeUMWxq+Y/DvcucyG/QWtLOMFwZUTOiPgPARkG5g4zIYwwNJI8gsWAyuPbnWxM8V
	 TjYpUlahHqs8Rjjjv9TZ6dizHwKKMNKFUcZQ5m+eRrhLYI7+wN69HTVCbQFHwXYSlO
	 zg55zFGDK+0Y1qdjcAU9kERYjeiPt2SgkX8qzk3a7RGyWQApcz9XwfsL47DIko+oI1
	 IuwJMwobhjOAtSDRH6Dwv5E0ZhJuW0TG9wQZuRgSQoyUjj32xJQk1P319oLl4/SLqH
	 ICx3CqJEKfbkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 323/844] net: sfp: add quirk for Lantech 8330-265D
Date: Sat, 28 Feb 2026 12:23:56 -0500
Message-ID: <20260228173244.1509663-324-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220402-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 703831C6246
X-Rspamd-Action: no action

From: Marek Behún <kabel@kernel.org>

[ Upstream commit 86a8e8e0ddbc3d14c799536eb888180b84d002f3 ]

Similar to Lantech 8330-262D-E, the Lantech 8330-265D also reports
2500MBd instead of 3125MBd.

Also, all 8330-265D report normal RX_LOS in EEPROM, but some signal
inverted RX_LOS. We therefore need to ignore RX_LOS on these modules.

Signed-off-by: Marek Behún <kabel@kernel.org>
Link: https://patch.msgid.link/20260128170044.15576-1-kabel@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 3e023723887c4..43aefdd8b70f7 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -532,9 +532,13 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK("HUAWEI", "MA5671A", sfp_quirk_2500basex,
 		  sfp_fixup_ignore_tx_fault),
 
-	// Lantech 8330-262D-E can operate at 2500base-X, but incorrectly report
-	// 2500MBd NRZ in their EEPROM
+	// Lantech 8330-262D-E and 8330-265D can operate at 2500base-X, but
+	// incorrectly report 2500MBd NRZ in their EEPROM.
+	// Some 8330-265D modules have inverted LOS, while all of them report
+	// normal LOS in EEPROM. Therefore we need to ignore LOS entirely.
 	SFP_QUIRK_S("Lantech", "8330-262D-E", sfp_quirk_2500basex),
+	SFP_QUIRK("Lantech", "8330-265D", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_los),
 
 	SFP_QUIRK_S("UBNT", "UF-INSTANT", sfp_quirk_ubnt_uf_instant),
 
-- 
2.51.0


