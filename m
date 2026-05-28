Return-Path: <stable+bounces-255760-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBiQA/GkGGoQlwgAu9opvQ
	(envelope-from <stable+bounces-255760-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:26:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 737235F8AD5
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 001A0302DF91
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE803329C48;
	Thu, 28 May 2026 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kqKVW/3w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC4433987F;
	Thu, 28 May 2026 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999807; cv=none; b=qOxozEf0M4BDSx4T+ND1T7+2sXl52zlsk1Q5FPWPzQlDVDHi4nbIXIZRIzYTpig2Yy4oLZBo+ibc7uFdQo+xcB/IqcSAjs20pqP5vxqu3njQ78JjEeoINGWpwFKoQLBFaqgpxXQQXVq42yy+bhoZjOGlEW/S72/6XLkrUN9qhEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999807; c=relaxed/simple;
	bh=bo7g2l2j66GcxUEZ8zzwLcKUXeBQpofsmScK5VWbBjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYIl8J5p7Hz5VNXPYpS5NJVuI9ZVrTN3Ao/dJ9TWKAY0RKMSETmjjMaLtlYk2Loel9+ByH+9t4qqasbWPM1K08itSyfwjBc3kDydghNvI3g27sgNb8RqxspqUJE7kwQBg30aHRBWF1W9Cu/e39dSCaZ5WFw9sifEb2JSnTbJWPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kqKVW/3w; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9511F000E9;
	Thu, 28 May 2026 20:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999806;
	bh=/AnZoweMKaY55Fi+OO7Gwq10I3Pi8f/xE4DELw4UUso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kqKVW/3wo0jML5iJ8mGJhe+ec97YprJTwUuQr8GQo1iACGxN8PQRJze8us20LY7fS
	 Jk3WT951kcxffTXjI+5v6H2+pv4fCneJqkPJBsy+W3K5TANuC6Aw3ovpr5j0Cbib5L
	 I2JM/C34Dn4yao0eD27qO/xGL0O4eHqkhCBTrVyU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Ene <sebastianene@google.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 191/377] firmware: arm_ffa: Align RxTx buffer size before mapping
Date: Thu, 28 May 2026 21:47:09 +0200
Message-ID: <20260528194643.941974149@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255760-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 737235F8AD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudeep Holla <sudeep.holla@kernel.org>

[ Upstream commit 0399e3f872ca3d78044bb715a73ea645806d2c7b ]

Commit 83210251fd70 ("firmware: arm_ffa: Use the correct buffer size during
RXTX_MAP") advertises PAGE_ALIGN(rxtx_bufsz) to firmware when mapping the
buffers but the driver continues to stores the minimum FF-A buffer size
in drv_info->rxtx_bufsz which is used elsewhere in the driver.

Align the size before storing it so that the allocation, validation and
FFA_RXTX_MAP all use the same buffer size.

Fixes: 83210251fd70 ("firmware: arm_ffa: Use the correct buffer size during RXTX_MAP")
Cc: Sebastian Ene <sebastianene@google.com>
Link: https://sashiko.dev/#/patchset/20260402113939.930221-1-sebastianene@google.com
Reviewed-by: Sebastian Ene <sebastianene@google.com>
Link: https://patch.msgid.link/20260428-ffa_fixes-v2-9-8595ae450034@kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index f96bb84af55e3..70f34f58f3832 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -2102,6 +2102,7 @@ static int __init ffa_init(void)
 			rxtx_bufsz = SZ_4K;
 	}
 
+	rxtx_bufsz = PAGE_ALIGN(rxtx_bufsz);
 	drv_info->rxtx_bufsz = rxtx_bufsz;
 	drv_info->rx_buffer = alloc_pages_exact(rxtx_bufsz, GFP_KERNEL);
 	if (!drv_info->rx_buffer) {
@@ -2117,7 +2118,7 @@ static int __init ffa_init(void)
 
 	ret = ffa_rxtx_map(virt_to_phys(drv_info->tx_buffer),
 			   virt_to_phys(drv_info->rx_buffer),
-			   PAGE_ALIGN(rxtx_bufsz) / FFA_PAGE_SIZE);
+			   rxtx_bufsz / FFA_PAGE_SIZE);
 	if (ret) {
 		pr_err("failed to register FFA RxTx buffers\n");
 		goto free_pages;
-- 
2.53.0




