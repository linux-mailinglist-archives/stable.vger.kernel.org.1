Return-Path: <stable+bounces-155181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C445AE2373
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 22:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60F94A82C4
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 20:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AAD28CF41;
	Fri, 20 Jun 2025 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="qrxWw9hA"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D1A233721;
	Fri, 20 Jun 2025 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750450891; cv=none; b=ZUCyTrfsQy3kJEdAGw/vvkjXe+dyoSJ2cm61Z1l9CyfB6NfPrwc3HK/T+XDPxYXgFx8xnsLQj5D+5r6+hk6tA8+9Y+g6AL5V7jqe/nSR7wZ/RDtQLYcU0CQHaDM+F6Jv4XXzWG04ZbDKrKsfGFnTnjZ6xsWp1OT2Oo8kGuJjqRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750450891; c=relaxed/simple;
	bh=U1BClflzZXmrxGcP60WeTeyTTveTS7tVrF3chwp+aHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fu1MMGnMb10erHbSc0Bbv+TwDcVWxeIRyZGWym5xHhLF3nlHzc3GtbAFOcmeq8wl8eRd4yU/cQEq+NA5VNd7QP89c7OeqbUplM9WoaB30hSODsI+qgDQgA/Y2bsrLR6emt+093Nz0CibwKaci8dvYFqThzo5ktUQbsvtl8DVJcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=qrxWw9hA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oyGZOjXj/pd2JtRblbDE5PLfyPLYet9rnW/68qUZAP8=; b=qrxWw9hAkrpPTp9X7Y+3VnGyhW
	QkKA3cLmrPJX/ZJatZNDw4pHpTLRYdaLhyNnMRzonyJJwCRLRimdTU+3IotgTbFoYFiqDTVqQufMY
	1HQQS83yFxuh1FHi7CxIlw3FaQaJCCZywXs2k0+vSbNU4fY560A4B2Bnc92geAOo9jjyZwN/mfGXt
	yiuwQlIdOd//VbPBD1AyHXO2VCIZL+dwwUCkquSdowHVDDfoLMkmwQtykDxIbycSpSwiJyXrMOZGE
	toHfqfyEXfrW8qcimRbJqvQH53Tt7lHOe3YT8N/loANuJhB6NO+64aKzoY3F2aYkbs9WtAfb6cKb4
	SY0KTMtQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1uSiEi-00GxTT-06; Fri, 20 Jun 2025 20:21:20 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 21C8DBE2DE0; Fri, 20 Jun 2025 22:21:19 +0200 (CEST)
Date: Fri, 20 Jun 2025 22:21:19 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: regressions@lists.linux.dev, Jeremy Lincicome <w0jrl1@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, 1108065@bugs.debian.org,
	stable@vger.kernel.org
Subject: Re: [regression v6.12.30..v6.12.32] mmc1: mmc_select_hs400 failed,
 error -110 / boot regression on Lenovo IdeaPad 1 15ADA7
Message-ID: <aFXCv50hth-mafOR@eldamar.lan>
References: <aFW0ia8Jj4PQtFkS@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFW0ia8Jj4PQtFkS@eldamar.lan>
X-Debian-User: carnil

On Fri, Jun 20, 2025 at 09:20:41PM +0200, Salvatore Bonaccorso wrote:
> Hi
> 
> In Debian we got a regression report booting on a Lenovo IdeaPad 1
> 15ADA7 dropping finally into the initramfs shell after updating from
> 6.12.30 to 6.12.32 with messages before dropping into the intiramfs
> shell:
> 
> mmc1: mmc_select_hs400 failed, error -110
> mmc1: error -110 whilst initialising MMC card
> 
> The original report is at https://bugs.debian.org/1107979 and the
> reporter tested as well kernel up to 6.15.3 which still fails to boot.
> 
> Another similar report landed with after the same version update as
> https://bugs.debian.org/1107979 .
> 
> I only see three commits touching drivers/mmc between
> 6.12.30..6.12.32:
> 
> 28306c58daf8 ("mmc: sdhci: Disable SD card clock before changing parameters")
> 38828e0dc771 ("mmc: dw_mmc: add exynos7870 DW MMC support")
> 67bb2175095e ("mmc: host: Wait for Vdd to settle on card power off")
> 
> I have found a potential similar issue reported in ArchLinux at
> https://bbs.archlinux.org/viewtopic.php?id=306024
> 
> I have asked if we can get more information out of the boot, but maybe
> this regression report already rings  bell for you?
> 
> #regzbot introduced v6.12.30..v6.12.32
> #regzbot link: https://bugs.debian.org/1107979
> #regzbot link: https://bbs.archlinux.org/viewtopic.php?id=306024

*sigh* apologies for the "mess", the actual right report is
https://bugs.debian.org/1108065 (where #1107979 at least has
similarities or might have the same root cause).

#regzbot link: https://bugs.debian.org/1108065

Regards,
Salvatore

