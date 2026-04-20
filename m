Return-Path: <stable+bounces-239448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO+jGSde5mm3vQEAu9opvQ
	(envelope-from <stable+bounces-239448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:11:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD84A430A9F
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F2C4359A70D
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B944F33858B;
	Mon, 20 Apr 2026 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ngCe/RW5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF9233262B;
	Mon, 20 Apr 2026 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700279; cv=none; b=OQOt2/9DFLeNGqEB9N7IyjfqKQAqIBveWnokXCjfJPsCzzG8HAoA3ODbaORP02X49vPOuYHjl/MEfmQVt+7ee98Gi4ElCo0YbSGA9h/QLV/TBqn0uEQ1CQv+Q44zn/woW739dZhttfOypo1YqKo8kejTEdAILONPPviXJGJIBUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700279; c=relaxed/simple;
	bh=ZLLlf0G1U2ecoupr72LsFUPZwqLqsn5pOdgjRWDrfdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvQ4fjc/5Zr5YtHmyuH3iBRrU5U/jubw4N5p3jx/7xD77TQZBB3cELjOEcqTonTWMzt1A5pNhz+4xymlhnhkN+y67g4uLGW6rWBSYCOUZRvJ2h48RCY3iWJOyPfL/YMKnn7W8fE70NvzCL0xa3nVxuHJNhtxLZPS6WR7MhhyHDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ngCe/RW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F013FC19425;
	Mon, 20 Apr 2026 15:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700279;
	bh=ZLLlf0G1U2ecoupr72LsFUPZwqLqsn5pOdgjRWDrfdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ngCe/RW5DD7QHRQezzjjE5dCeCNeLkjFA6BIgRzw/mg7nrZUfGWoy9F8ueT0VH6HG
	 PtFqknAPduMe9FmgUA4Yews35aRvDPBYpBIiHRXOQqelH3ypbAFhPjIIQF/qOoJmY5
	 1MBCzMSyBf/KWn4UVByB3RokKglEdsNoOh1ntwmI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 078/220] net: fec: make FIXED_PHY dependency unconditional
Date: Mon, 20 Apr 2026 17:40:19 +0200
Message-ID: <20260420153936.846966172@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239448-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arndb.de:email,msgid.link:url]
X-Rspamd-Queue-Id: DD84A430A9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit e16a0d36777b572196de4944aaa196adf828eb8e ]

When CONFIG_FIXED_PHY is in a loadable module, the fec driver cannot be
built-in any more:

x86_64-linux-ld: vmlinux.o: in function `fec_enet_mii_probe':
fec_main.c:(.text+0xc4f367): undefined reference to `fixed_phy_unregister'
x86_64-linux-ld: vmlinux.o: in function `fec_enet_close':
fec_main.c:(.text+0xc59591): undefined reference to `fixed_phy_unregister'
x86_64-linux-ld: vmlinux.o: in function `fec_enet_mii_probe.cold':

Select the fixed phy support on all targets to make this build
correctly, not just on coldfire.

Notat that Essentially the stub helpers in include/linux/phy_fixed.h
cannot be used correctly because of this build time dependency,
and we could just remove them to hit the build failure more often
when a driver uses them without the 'select FIXED_PHY'.

Fixes: dc86b621e1b4 ("net: fec: register a fixed phy using fixed_phy_register_100fd if needed")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260402141048.2713445-1-arnd@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
index e2a591cf9601f..11edbb46a1180 100644
--- a/drivers/net/ethernet/freescale/Kconfig
+++ b/drivers/net/ethernet/freescale/Kconfig
@@ -28,7 +28,7 @@ config FEC
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select CRC32
 	select PHYLIB
-	select FIXED_PHY if M5272
+	select FIXED_PHY
 	select PAGE_POOL
 	imply PAGE_POOL_STATS
 	imply NET_SELFTESTS
-- 
2.53.0




