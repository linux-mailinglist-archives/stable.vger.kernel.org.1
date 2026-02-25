Return-Path: <stable+bounces-218632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAnAMSNUnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:45:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3968B18FBBC
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3E95319BECA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638D61D5141;
	Wed, 25 Feb 2026 01:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lf5jUtNM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2540B26056D;
	Wed, 25 Feb 2026 01:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983481; cv=none; b=OW3pTeBwAn79Ij5oXY09aLvd6mgsFI0ho/HZbeLWoEUhvOkik8FlZVgrXC1R5OaOO+2Bepye2PJUFMH9RqMlf+fF6p5NyJaCUzJIsTuXTX2VuvW51IisFFaSBmagReKPoGci+vRSdD9zvwku5axCrA+AGvwON3gZsthz28ltQb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983481; c=relaxed/simple;
	bh=5aCXIE5ANmaBvu5Q0JtmezK7dxkrFa/uLpTmlVYphMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWlB2u+cv76o0CeXWzSOyshCx3axeWGzhEgMI16MTsRN1DgwaR1gEuYOSh5HexB6L2f91L1uZp+lEep7uN3bTwOyOoIPL4n6elf4EFhbEDzT29Dhq3AyFfHQIlBrTQJOrhXEitUezeDyO17YTtT10EUc294UCoDw8BkOP9A+XIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lf5jUtNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F297DC116D0;
	Wed, 25 Feb 2026 01:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983481;
	bh=5aCXIE5ANmaBvu5Q0JtmezK7dxkrFa/uLpTmlVYphMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lf5jUtNMaLd76lHS0JU+B6YKnFBqiSnpH9u4z1A6IEktoPN1bBTw/y/qQWQfB7oxs
	 aupXSncfSRahIrWnTHdd9OvYaZwcmMnBlPhTo38/tOMbtIEdMfR/HIsvh4nqgm+h0P
	 EoNJszD7AycqB1quU6OPWGk2wPr7jnIz3RKLwdpM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 594/781] nvmem: an8855: drop an unused Kconfig symbol
Date: Tue, 24 Feb 2026 17:21:43 -0800
Message-ID: <20260225012414.368213944@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218632-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,infradead.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3968B18FBBC
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 4796eaafd6a170db012395a40385d2baf4f4d118 ]

MFD_AIROHA_AN8855 is referenced here but never defined, so drop it
from the Kconfig file.

Fixes: e2258cfd9b98 ("nvmem: an8855: Add support for Airoha AN8855 Switch EFUSE")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260116170846.733558-4-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index bf47a982cf629..74ddbd0f79b0e 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -30,7 +30,7 @@ source "drivers/nvmem/layouts/Kconfig"
 
 config NVMEM_AN8855_EFUSE
 	tristate "Airoha AN8855 eFuse support"
-	depends on MFD_AIROHA_AN8855 || COMPILE_TEST
+	depends on COMPILE_TEST
 	help
 	  Say y here to enable support for reading eFuses on Airoha AN8855
 	  Switch. These are e.g. used to store factory programmed
-- 
2.51.0




