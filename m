Return-Path: <stable+bounces-218990-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GaNEwlanmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218990-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:10:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6D0190A15
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 075EE31BF367
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372802BE035;
	Wed, 25 Feb 2026 01:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gom7BOeC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA9C1FC7;
	Wed, 25 Feb 2026 01:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983896; cv=none; b=PJru5B7vX8xLgci3lR67vACR/WyAe1awej6CPsLk2GfgOEijGQp0xiqiHnyhY3tWC+CKkGW3MDIaEh4b/PqYtx+y+Jxh2Ll1HuuIsD1sC4Kf7p9QzjLrUKrJGvbGJ0iRr3piVxbNQi125G50kffp6wpRM2dw6DZTfQiSKmkcTqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983896; c=relaxed/simple;
	bh=TDhr7KS871rrqEjgnXz2/gRZjR9VQzqcke5nLohzajI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0Qshe68+d4ei/NqxEPQBdUAfII0xfOQC+jybJrDecIlMdE0XWQCVSXplOH69oNPycYB0q/+J43t8UxCswjKfNzIuICPqmZFPMJz78QzGN6/sEMfcMBEcg4BaPeLS7yLrwWICJTzz75hzMBq8FEdkWGg/B9ypo23narw39o54Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gom7BOeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7BCC116D0;
	Wed, 25 Feb 2026 01:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983895;
	bh=TDhr7KS871rrqEjgnXz2/gRZjR9VQzqcke5nLohzajI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gom7BOeCN4RNu3Oq6y5MqktYHwPcLzOgdsS/bUsoQJLoOO15INdr/F2H1o2hM3P5x
	 5jSjNSrxVJHkRuGZgWtQtP3X3UoUQjoY81jMN8hotZ5Zk2l1D+8LkADohWRwBLdALV
	 uvWtwnt30jP5mGsmfER30QRkQMwFsXNmM24BvQhs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Junhui Liu <junhui.liu@pigmoral.tech>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 167/641] reset: canaan: k230: drop OF dependency and enable by default
Date: Tue, 24 Feb 2026 17:18:13 -0800
Message-ID: <20260225012353.103254761@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218990-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 9B6D0190A15
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junhui Liu <junhui.liu@pigmoral.tech>

[ Upstream commit c7a5e01e229d21e0560d78bd645b4f7398667ce4 ]

The driver doesn't use any symbols depending on CONFIG_OF, so drop the
dependency. Also, enable it by default when ARCH_CANAAN is selected.

Fixes: 360a7a647759 ("reset: canaan: add reset driver for Kendryte K230")
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 78b7078478d46..b3b9e0f9d8c48 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -150,7 +150,7 @@ config RESET_K210
 config RESET_K230
 	tristate "Reset controller driver for Canaan Kendryte K230 SoC"
 	depends on ARCH_CANAAN || COMPILE_TEST
-	depends on OF
+	default ARCH_CANAAN
 	help
 	  Support for the Canaan Kendryte K230 RISC-V SoC reset controller.
 	  Say Y if you want to control reset signals provided by this
-- 
2.51.0




