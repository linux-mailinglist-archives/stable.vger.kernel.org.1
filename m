Return-Path: <stable+bounces-251724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NVJIaXzDWry4wUAu9opvQ
	(envelope-from <stable+bounces-251724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:47:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B993594904
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06437304BF05
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398ED3F44CB;
	Wed, 20 May 2026 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lrx6j3mC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E833F23A4;
	Wed, 20 May 2026 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298726; cv=none; b=dH0iKABs+VS5tbnIffZbqPr1vG1L3R1S1yfMiL3RCgeIMPs7UJqyoMT6yLcO44TcbM9TyZOxUMc8mwvJDJs4m7+8MNLtYG1c3ec/OlUF5TkHc1tsHSfdSOaPWjWEIREaRfkPXyA2ukNBEnvUMS/zGubY4wSKCKZ9Rb3Tphr9rwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298726; c=relaxed/simple;
	bh=jXj4+LNYzmWxW5VWkn2ixtQts3sKcAznAtH3xUkyUqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5zJJeQmShIWNdnFhn8RYgTmpz1MRBSUy5nzD4vi4zEW0ykk7uy7tEMIvQVWbkK4Y0hOHYPVtwjxiqRRqqxO4ODQxK1o6mwxD/o9vPnW+vpBA4qon2YEJaTRKL+qcuP3b4RauD69LkQeIXJ9wGFQJBGhK5EbZ2F9FtDWHecHQOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lrx6j3mC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D321F000E9;
	Wed, 20 May 2026 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298724;
	bh=5KrjDvVcGnjSMd0El2h0bNmUJeuLPVXuVe1qbMKf2Z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lrx6j3mCXbY4a+Vks9p2Pi05KHY632yKdi2gcacfhdSHDwWQ1axUNVQakMszZN80k
	 8BEk2ONqylLspsZfRh2WqlXWiiMnNyHI67TjHW6xVta0ZQUZ4MvRYn670D+dWxIeMz
	 n2LAQT2yjq+XyjPGhPz3yxHLn+HrqKkP6YJ+A5tM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Inochi Amaoto <inochiama@gmail.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 519/957] pinctrl: sophgo: pinctrl-sg2044: Fix wrong module description
Date: Wed, 20 May 2026 18:16:42 +0200
Message-ID: <20260520162145.788731066@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,outlook.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-251724-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,outlook.com:email]
X-Rspamd-Queue-Id: 1B993594904
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Inochi Amaoto <inochiama@gmail.com>

[ Upstream commit 7648112358a4207916d3e38bfee49f85552fe95f ]

Fix the SoC model in module description string, it should be
sg2044 instead of sg2002.

Fixes: 614a54cb5ac3 ("pinctrl: sophgo: add support for SG2044 SoC")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sophgo/pinctrl-sg2044.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sophgo/pinctrl-sg2044.c b/drivers/pinctrl/sophgo/pinctrl-sg2044.c
index b0c46d8954ca1..cf0b674c038f0 100644
--- a/drivers/pinctrl/sophgo/pinctrl-sg2044.c
+++ b/drivers/pinctrl/sophgo/pinctrl-sg2044.c
@@ -714,5 +714,5 @@ static struct platform_driver sg2044_pinctrl_driver = {
 };
 module_platform_driver(sg2044_pinctrl_driver);
 
-MODULE_DESCRIPTION("Pinctrl driver for the SG2002 series SoC");
+MODULE_DESCRIPTION("Pinctrl driver for the SG2044 series SoC");
 MODULE_LICENSE("GPL");
-- 
2.53.0




