Return-Path: <stable+bounces-218634-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8O4qFEVYnmkKUwQAu9opvQ
	(envelope-from <stable+bounces-218634-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:02:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C5A1906CA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DD33319D967
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE486262FC0;
	Wed, 25 Feb 2026 01:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m1cEcQGm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A3824A05D;
	Wed, 25 Feb 2026 01:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983483; cv=none; b=flteucpQbW0L4qb7jXXJGYWn4t+XH9YpwYaMicJKyK+z5vw0v9sHPBq3P4T2waox+uJOT4/ATlT8V989++aBfbR+Avg/egLUzOTXZjZda0qSkftqaB8MXi2RyTVQ+qzcrGeImtraSpOBoEx+I5AYg1VRiDj75u4lfzg28SjUeSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983483; c=relaxed/simple;
	bh=zEfBHDLdVl5CdqutueLENBMjmsg58YNRD27eJFYaZ1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKKp69YTsf8PTph3863zbYoewUb47ve8i2SVmKawO78E+uDP+fqy5+ywoxTZOITP4/GAy/h5BHikc1rBtxcrgG/8ny/xfVE1Fq6G3oHsE3t9bSC2KtNQO0Mm2ydSINjffT8T5DwHXSTo/O2aw1lTkXfR3GWVhqDjimyhhceL7Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m1cEcQGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C172C116D0;
	Wed, 25 Feb 2026 01:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983483;
	bh=zEfBHDLdVl5CdqutueLENBMjmsg58YNRD27eJFYaZ1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m1cEcQGm2oT4wgYizNI49NBZp+qrlavr2KbQT4ChBlJQ6st32TuCc3CU92n3841jz
	 QyMKkamMwjAx2qv1rVPKz8My+4kr9k0mMM9m+lK/839z+m8RLkUlfyggE/zFKWZGP6
	 2q+kDldTExd1HNv+k9kLEeYpJp9t1dPiGvtHaVws=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 596/781] pinctrl: equilibrium: Fix device node reference leak in pinbank_init()
Date: Tue, 24 Feb 2026 17:21:45 -0800
Message-ID: <20260225012414.414079444@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-218634-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.961];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8C5A1906CA
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit c0b4a4feeb43305a754893d8d9c6b2b5a52d45ac ]

When calling of_parse_phandle_with_fixed_args(), the caller is
responsible to call of_node_put() to release the reference of device
node.

In pinbank_init(), the reference of the node obtained from the
"gpio-ranges" property is never released, resulting in a reference
count leak.

Add the missing of_node_put() call to fix the leak.

Fixes: 1948d5c51dba ("pinctrl: Add pinmux & GPIO controller driver for a new SoC")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-equilibrium.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-equilibrium.c b/drivers/pinctrl/pinctrl-equilibrium.c
index 2d04829b29c99..48b55c5bf8d4f 100644
--- a/drivers/pinctrl/pinctrl-equilibrium.c
+++ b/drivers/pinctrl/pinctrl-equilibrium.c
@@ -846,6 +846,7 @@ static int pinbank_init(struct device_node *np,
 
 	bank->pin_base = spec.args[1];
 	bank->nr_pins = spec.args[2];
+	of_node_put(spec.np);
 
 	bank->aval_pinmap = readl(bank->membase + REG_AVAIL);
 	bank->id = id;
-- 
2.51.0




