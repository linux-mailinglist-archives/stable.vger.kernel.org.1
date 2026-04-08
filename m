Return-Path: <stable+bounces-235059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJv6FHCl1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-235059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:58:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF743C21B4
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4AAD300CC80
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750993D9042;
	Wed,  8 Apr 2026 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FoS2e9SL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CBB3D8918;
	Wed,  8 Apr 2026 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674464; cv=none; b=EaKNAox8LeNHe9C9a+hvJnyA5f7pAk6WeJHE4ZwDfxMC4//jtkfNNcJX7PLrUj2/1rXY37yP2QVFmVuPbfmVFHDvD76iHQyMWHZ76/C0lzjsI25Z5WGFYeciipwJc0UuetOAtR9txvgoAWoeUL/h7BRa8puJhbT1hC2ERYde5is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674464; c=relaxed/simple;
	bh=bhc3jnLvxp7UJA/p6OTGx3dI3VW3ZS8MMEjipwUgRvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pl50X6bgAbHfCs+7iZKaJIO3np5kv5x+k6/H0tDL21dC4atyawkOd+WUNYtckUF2FHIJyZjc6qBK/bpJY7dNT4DyPenmJJBElcQeJ7V7wralkR0I4U0O5q1/Ph/3W9qEZ51ZFibjMA+4KVSyi5JXalnIhIeWIKeLAvW0eNNoiIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FoS2e9SL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C3EC19421;
	Wed,  8 Apr 2026 18:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674464;
	bh=bhc3jnLvxp7UJA/p6OTGx3dI3VW3ZS8MMEjipwUgRvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FoS2e9SLoWL1+pnIXVbYstHOe1gpWVSLG3cX2V7aSUgRpnfjWewHJAPAmW16VLr96
	 im0uQfcaYrN6F1dMoHYYoLKbGRtNgtOcKkxWEDbBPsJxHqIPBV3OQE6nfeKf15JwIU
	 KWqHJP1nEYIREJjnwA1iDVPugbpZnYWq0UBB9JdM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Julian Braha <julianbraha@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 075/311] ASoC: Intel: boards: fix unmet dependency on PINCTRL
Date: Wed,  8 Apr 2026 20:01:15 +0200
Message-ID: <20260408175942.215837903@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,arndb.de,kernel.org];
	TAGGED_FROM(0.00)[bounces-235059-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,arndb.de:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: EBF743C21B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Braha <julianbraha@gmail.com>

[ Upstream commit e920c36f2073d533bdf19ba6ab690432c8173b63 ]

This reverts commit c073f0757663 ("ASoC: Intel: sof_sdw: select PINCTRL_CS42L43 and SPI_CS42L43")

Currently, SND_SOC_INTEL_SOUNDWIRE_SOF_MACH selects PINCTRL_CS42L43
without also selecting or depending on PINCTRL, despite PINCTRL_CS42L43
depending on PINCTRL.

See the following Kbuild warning:

WARNING: unmet direct dependencies detected for PINCTRL_CS42L43
  Depends on [n]: PINCTRL [=n] && MFD_CS42L43 [=m]
  Selected by [m]:
  - SND_SOC_INTEL_SOUNDWIRE_SOF_MACH [=m] && SOUND [=y] && SND [=m] && SND_SOC [=m] && SND_SOC_INTEL_MACH [=y] && (SND_SOC_SOF_INTEL_COMMON [=m] || !SND_SOC_SOF_INTEL_COMMON [=m]) && SND_SOC_SOF_INTEL_SOUNDWIRE [=m] && I2C [=y] && SPI_MASTER [=y] && ACPI [=y] && (MFD_INTEL_LPSS [=n] || COMPILE_TEST [=y]) && (SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES [=n] || COMPILE_TEST [=y]) && SOUNDWIRE [=m]

In response to v1 of this patch [1], Arnd pointed out that there is
no compile-time dependency sof_sdw and the PINCTRL_CS42L43 driver.
After testing, I can confirm that the kernel compiled with
SND_SOC_INTEL_SOUNDWIRE_SOF_MACH enabled and PINCTRL_CS42L43 disabled.

This unmet dependency was detected by kconfirm, a static analysis
tool for Kconfig.

Link: https://lore.kernel.org/all/b8aecc71-1fed-4f52-9f6c-263fbe56d493@app.fastmail.com/ [1]
Fixes: c073f0757663 ("ASoC: Intel: sof_sdw: select PINCTRL_CS42L43 and SPI_CS42L43")
Signed-off-by: Julian Braha <julianbraha@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Link: https://patch.msgid.link/20260325001522.1727678-1-julianbraha@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index c23fdb6aad4ca..1031d6497f55e 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -525,8 +525,6 @@ config SND_SOC_INTEL_SOUNDWIRE_SOF_MACH
 	select SND_SOC_CS42L43_SDW
 	select MFD_CS42L43
 	select MFD_CS42L43_SDW
-	select PINCTRL_CS42L43
-	select SPI_CS42L43
 	select SND_SOC_CS35L56_SPI
 	select SND_SOC_CS35L56_SDW
 	select SND_SOC_DMIC
-- 
2.53.0




