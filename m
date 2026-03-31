Return-Path: <stable+bounces-232306-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHsRMIP/y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-232306-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:08:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B7A36DF0B
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E772E30DC758
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166F32D877B;
	Tue, 31 Mar 2026 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xS+CfiaE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4892D77F5;
	Tue, 31 Mar 2026 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976409; cv=none; b=ba7BzRoTXKPGygssEJk0O+40+B5F+QRclOmyi2ohy4ffVKeYlLra/y8JIJyLb1k6t9Sx9bwO8RcfdBFtD2FBbeFknEc+7Waoli9a5tKPOLrVnw2sC1IfbVvtWa2LZrkRNRgdFWo3j6ONkaJwNAbdbY31T4oJ66B44DQIOjR59FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976409; c=relaxed/simple;
	bh=dlZbDEcZLWw80HPcGbEUA0vNRBlAqq+wcQb3SnsVfAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvsLHaMwFiSHKYZmAjg2oalOyZlLpz3l9X8vIUy/ctHnPlo30ygzbqsceabwAiV8aVqSkyzhKiLNE0/idaoDPv5l5nCt90w+tW/HBlgDuVymulog0vNNeOnSDu3eg7aSv73k8n+YzZ2njbOmOzEk+EpLm7lVgxvFn5sg+yPOrFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xS+CfiaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61829C2BCB3;
	Tue, 31 Mar 2026 17:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976409;
	bh=dlZbDEcZLWw80HPcGbEUA0vNRBlAqq+wcQb3SnsVfAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xS+CfiaEWp4gzbMfFXev5EDmJWyxBGGvXexWxjWsVqiCKMn1cUFqfiJbaOe2PYcr/
	 6FU6O9hu9RFSlbziFP9vsKgj1Pkg+uElanpfb1+4RTW8m1xxbgFEC6CCMOifZbNOhZ
	 bM2FUWWh9j6SNFta26G7oLKjzs9qrk7T2/4tu75k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amelie Delaunay <amelie.delaunay@foss.st.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 081/309] pinctrl: stm32: fix HDP driver dependency on GPIO_GENERIC
Date: Tue, 31 Mar 2026 18:19:44 +0200
Message-ID: <20260331161756.468469977@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232306-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,st.com:email]
X-Rspamd-Queue-Id: 43B7A36DF0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

[ Upstream commit c8cfeb4b9dda2cdfce79519aee4aaff16310a7b6 ]

The HDP driver uses the generic GPIO chip API, but this configuration
may not be enabled.
Ensure it is enabled by selecting the appropriate option.

Fixes: 4bcff9c05b9d ("pinctrl: stm32: use new generic GPIO chip API")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/stm32/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/stm32/Kconfig b/drivers/pinctrl/stm32/Kconfig
index 5f67e1ee66dd9..d6a1715230121 100644
--- a/drivers/pinctrl/stm32/Kconfig
+++ b/drivers/pinctrl/stm32/Kconfig
@@ -65,6 +65,7 @@ config PINCTRL_STM32_HDP
 	select PINMUX
 	select GENERIC_PINCONF
 	select GPIOLIB
+	select GPIO_GENERIC
 	help
 	  The Hardware Debug Port allows the observation of internal signals.
 	  It uses configurable multiplexer to route signals in a dedicated observation register.
-- 
2.51.0




