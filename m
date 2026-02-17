Return-Path: <stable+bounces-216788-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCZ/IZdSlGl3CgIAu9opvQ
	(envelope-from <stable+bounces-216788-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:35:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F04314B72E
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 319FF3004D17
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 11:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56AB333733;
	Tue, 17 Feb 2026 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9Kw5/XZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8703B332EB4;
	Tue, 17 Feb 2026 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771328146; cv=none; b=jUwR/vPrUbTpJPLnOLjWadDIApcr3uxCu0BWqgX0lP6bg/qvJOI6jGGEjS7bdyapC/CA2VEedzcC/xGjJDz+FhP8bZOEkynQln0ylDTzwXy7XP/2HYsbayLDKjsDpT/a4CgeO635rQsrI6HNu2lp1h2cYvVAVJfXHC8HxoxXk40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771328146; c=relaxed/simple;
	bh=XZ1cEoh7ErNrbtOPqCCaVg9prMl/jUVXBKDSLHi3voc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KvCsJPa9OjP6GMwOmezI5s+kuU89quZlpNuh0tPCDdE8do0Xw5WOcMTD4PSZgvo3W99u8CM7hDUxzRvAAcq1Z9C5gGVTuPu4Pj/yD2B1mtzlcC5473BH5tKsGsyQvCrrfFOGgzlu7NEb74nS/HS2GiXkI9ovbEL0ZULgiRVw23o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9Kw5/XZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC353C4CEF7;
	Tue, 17 Feb 2026 11:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771328146;
	bh=XZ1cEoh7ErNrbtOPqCCaVg9prMl/jUVXBKDSLHi3voc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W9Kw5/XZgeG7ZtHy2GAmxF4VUxw6f3aObmKBFc+TCn8f6qdUpOq4662fvASycSjWB
	 M5f4IBhhXuE2NmirgkmY6KVKUXP4Nux0bV4wVCdUADmq1JG04sLSDH0MqZuM6x9/KQ
	 wh/HVFE33n7nMWe40IHiGjAU1kni2TGCQ3BVjEMII6inusQdc+v3ZHAM+BJAXuksJL
	 QwVP1iglszGKI+0//6CbK7t3kXUIEwVV65/NKC+K8pX7vdmRpYEkJB/bv8bQfIrroV
	 v3yQ19E/LJXiGK57AktQ2AmEo8xA3yyI3Gb0MK/3nmyJ5nQz2FqONge0cDVVyCyerQ
	 InT6aw+sedeBA==
From: Mark Brown <broonie@kernel.org>
To: Gustavo Salvini <guspatagonico@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 mario.limonciello@amd.com, Vijendar.Mukunda@amd.com, tiwai@suse.com, 
 stable@vger.kernel.org
In-Reply-To: <20260210155156.29079-1-guspatagonico@gmail.com>
References: <20260210155156.29079-1-guspatagonico@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Add DMI quirk for ASUS Vivobook Pro 15X
 M6501RR
Message-Id: <177132814457.11429.8947566827430514927.b4-ty@kernel.org>
Date: Tue, 17 Feb 2026 11:35:44 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216788-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9F04314B72E
X-Rspamd-Action: no action

On Tue, 10 Feb 2026 12:51:56 -0300, Gustavo Salvini wrote:
> The ASUS Vivobook Pro 15X (M6501RR) with AMD Ryzen 9 6900HX has an
> internal DMIC that is not detected without a DMI quirk entry, as the
> BIOS does not set the AcpDmicConnected ACPI _DSD property.
> 
> Adding the DMI entry enables the ACP6x DMIC machine driver to probe
> successfully.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add DMI quirk for ASUS Vivobook Pro 15X M6501RR
      commit: ff9cadd1a2c0b2665b7377ac79540d66f212e7e3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


