Return-Path: <stable+bounces-19735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F52C853381
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 15:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D582D1F2944A
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A49757898;
	Tue, 13 Feb 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xolAhlOy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAC95EE65;
	Tue, 13 Feb 2024 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835623; cv=none; b=A62ur7tlANma/n2g9lIxL0Ksr/CDVpqqTQEqOmvJmASloV6YqdvFx00ZowOSsJZwgL72iTTPD0xpOeAARfCy9snS4A3xG+REyijvvYPP3l4nLvNXw07rmvZUMllYl2M0BgE7Cy1WbgPFk8SENyTk/haGzNM6ngR2kzMVrHpjz9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835623; c=relaxed/simple;
	bh=y41JaSKfeWVzFEq+5e6C1oXttwhw87cx5j4UR/t5CEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZcBH/OUlM7A4HK1bo+ategRkp3EoupNhSeN6j+wbIbuXWdWZ0AFOG2rMCkci2h3lOQtBaX2oSRg1nBip1GM/BslUwtQ4QWsJ5fK65Hh+NuoIkeL5C/Hptv22zJBrEcwk2KOO3xdeqB0bEWmTFOMl8nG1d1Ighzu69yMO6hwOLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xolAhlOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17313C433C7;
	Tue, 13 Feb 2024 14:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707835622;
	bh=y41JaSKfeWVzFEq+5e6C1oXttwhw87cx5j4UR/t5CEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xolAhlOyVyuVZiyTDvGcKEtXr91VbRn3NP78HOEfVuOkMh+wvKqU4weNl61OENra5
	 IxxbbSXJx9PMEBajc4PuoKVJVt1atEh3kJBNEfy9J/TeOa30svjeMS1kzQIXlXn1d9
	 WLiZIyv76SL0gDQgCB4g09P7JnF2bsKhydBDnXvU=
Date: Tue, 13 Feb 2024 15:46:59 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Ted Chang <tedchang2010@gmail.com>, stable@vger.kernel.org,
	regressions@lists.linux.dev, venkataprasad.potturu@amd.com,
	"perex@perex.cz" <perex@perex.cz>, alsa-devel@alsa-project.org,
	broonie@kernel.org, linux@leemhuis.info,
	linux-sound@vger.kernel.org
Subject: Re: [REGRESSION] Acp5x probing regression introduced between kernel
 6.7.2 -> 6.7.4
Message-ID: <2024021342-overshoot-percent-a329@gregkh>
References: <CAD_nV8BG0t7US=+C28kQOR==712MPfZ9m-fuKksgoZCgrEByCw@mail.gmail.com>
 <CAD_nV8B=KSyOrASsbth=RmDV9ZUCipxhdJY3jY02C2jQ6Y34iA@mail.gmail.com>
 <87bk8kkcbg.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk8kkcbg.wl-tiwai@suse.de>

On Tue, Feb 13, 2024 at 09:17:39AM +0100, Takashi Iwai wrote:
> On Mon, 12 Feb 2024 15:32:45 +0100,
> Ted Chang wrote:
> > 
> > 
> > Hi everyone,
> > Takashi Iwai suggested that I test OBS home:tiwai:bsc1219789 repo. His comment
> > suggest he reverted commit
> > c3ab23a10771bbe06300e5374efa809789c65455 ASoC: amd: Add new dmi entries for
> > acp5x platform. My audio seems to work again
> > 
> > [    7.420289] acpi_cpufreq: overriding BIOS provided _PSD data
> > [    7.439331] snd_pci_acp5x 0000:04:00.5: enabling device (0000 -> 0002)
> > [    7.574796] snd_hda_intel 0000:04:00.1: enabling device (0000 -> 0002)
> > [    7.574980] snd_hda_intel 0000:04:00.1: Handle vga_switcheroo audio client
> > [    7.577788] kvm_amd: TSC scaling supported
> > [    7.577794] kvm_amd: Nested Virtualization enabled
> > [    7.577796] kvm_amd: Nested Paging enabled
> > [    7.577799] kvm_amd: SEV enabled (ASIDs 1 - 14)
> > [    7.577802] kvm_amd: SEV-ES disabled (ASIDs 0 - 0)
> > [    7.577824] kvm_amd: Virtual VMLOAD VMSAVE supported
> > [    7.577825] kvm_amd: Virtual GIF supported
> > [    7.577827] kvm_amd: LBR virtualization supported
> > [    7.589223] MCE: In-kernel MCE decoding enabled.
> > [    7.590386] snd_hda_intel 0000:04:00.1: bound 0000:04:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
> > [    7.591577] cs35l41 spi-VLV1776:00: supply VA not found, using dummy regulator
> > [    7.591644] cs35l41 spi-VLV1776:00: supply VP not found, using dummy regulator
> > [    7.595880] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input17
> > [    7.596790] input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input18
> > 
> > https://build.opensuse.org/project/show/home:tiwai:bsc1219789
> > 
> > Now I'm building a test kernel with the revert of the suspected backport patch.
> > It's being built in OBS home:tiwai:bsc1219789 repo.  Please give it a try later once after the build finishes (takes an hour or so).
> > 
> > So the culprit was the stable commit 4b6986b170f2f23e390bbd2d50784caa9cb67093, which is the upstream commit c3ab23a10771bbe06300e5374efa809789c65455
> >     ASoC: amd: Add new dmi entries for acp5x platform
> 
> Greg, could you revert the commit
> 4b6986b170f2f23e390bbd2d50784caa9cb67093 on 6.7.y?
> 
> Apparently it caused the regression on Steam Deck, the driver probe
> failed with that backport alone.

Now reverted, as well as on 6.6.y and 6.1.y.

thanks,

greg k-h

