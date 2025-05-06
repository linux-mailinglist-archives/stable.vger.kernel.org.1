Return-Path: <stable+bounces-141857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933CEAACDC9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 21:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D28C521108
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 19:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1C01F55FA;
	Tue,  6 May 2025 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="00YUfhbk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FgsnKxMK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="00YUfhbk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FgsnKxMK"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADEA1BE238
	for <stable@vger.kernel.org>; Tue,  6 May 2025 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746558647; cv=none; b=aXibS4C/W6/eGBKDgA0SKcRA/C7YloVOIvk2BPSDh3YDg9V+mp/r716WOaRY4TUlo9uH9eOxads0ZQPQIuO0O/J1ecJpnYL67l1ABKJDI00ZV1ESRTT20YwlWQNdXCpNgfrkJHlnVfhCswO7BcSPkUsmEs5u9pD8XG7mj7MZVTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746558647; c=relaxed/simple;
	bh=inUFxvNR6eEm0KTB8hsK4GiFsStwDXopUw8a0m+SPJg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3mErc0cdZaARxAK5/wjQKthTkhkL0sIJi25MBwKqgh/hFw3jmDdKdLO2lgUvMXDUWvGboqhxhOnJJ1DGVPqxa+3mHvPOw4qA8aiUriHN65nmIjMwOp1cKoys4358H6ML+3pDLMjHLXlY6cZKoiY1TsBFtHqphSa4KsyZnVG/XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=00YUfhbk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FgsnKxMK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=00YUfhbk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FgsnKxMK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7216A211C9;
	Tue,  6 May 2025 19:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746558642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2yoe17/X8WdBHAxqQVl2NYwIsvDdu0JonWJHAFvSHc=;
	b=00YUfhbkHc2Vu8Tk2eev+RM11MzTlYzkyrmZd8pCd2Ascz7fyDyeOQ3cA69OxUkejrJ05p
	dLulYU7YFnze/mn9JpHUAdFBZg6zbbLkGKlIBBUqHcFHxeeJD/7KG8bO+pQqAXH5ToKCwl
	5TbYqwQSi4+3FLLmz6QDYnixhd/seVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746558642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2yoe17/X8WdBHAxqQVl2NYwIsvDdu0JonWJHAFvSHc=;
	b=FgsnKxMK4gs9nN+PErk02S/fBe4KrtLLsPs7CWIz4LX8XpqbT7sFJSNsUskXfdy2saxS/o
	QwjoPgvPWnfTz/Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=00YUfhbk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FgsnKxMK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746558642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2yoe17/X8WdBHAxqQVl2NYwIsvDdu0JonWJHAFvSHc=;
	b=00YUfhbkHc2Vu8Tk2eev+RM11MzTlYzkyrmZd8pCd2Ascz7fyDyeOQ3cA69OxUkejrJ05p
	dLulYU7YFnze/mn9JpHUAdFBZg6zbbLkGKlIBBUqHcFHxeeJD/7KG8bO+pQqAXH5ToKCwl
	5TbYqwQSi4+3FLLmz6QDYnixhd/seVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746558642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2yoe17/X8WdBHAxqQVl2NYwIsvDdu0JonWJHAFvSHc=;
	b=FgsnKxMK4gs9nN+PErk02S/fBe4KrtLLsPs7CWIz4LX8XpqbT7sFJSNsUskXfdy2saxS/o
	QwjoPgvPWnfTz/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F48313687;
	Tue,  6 May 2025 19:10:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X7saCrJeGmgbHQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 06 May 2025 19:10:42 +0000
Date: Tue, 06 May 2025 21:10:41 +0200
Message-ID: <87y0v9v9la.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ezra Khuzadi <ekhuzadi@uci.edu>
Cc: kernel test robot <lkp@intel.com>,
	sound-dev@vger.kernel.org,
	stable@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	alsa-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	"perex@perex.cz" <perex@perex.cz>
Subject: Re: sound/pci/hda: add quirk for HP Spectre x360 15-eb0xxx
In-Reply-To: <CAPXr0uw7Dj9ckM_pLDkUaAH3vid9BmePrACOYZv-N549AUEHfw@mail.gmail.com>
References: <CAPXr0uxh0c_2b2-zJF=N8T6DfccfyvOQRX0X0VO24dS7YsxzzQ@mail.gmail.com>
	<aBHgOsqA4qfe7LbN@c757f733ca9e>
	<CAPXr0uxJg0kMu_N7Gxb14kVdhkFGXO_KbK5RxfAcY9dEA8vrEA@mail.gmail.com>
	<CAPXr0uw7Dj9ckM_pLDkUaAH3vid9BmePrACOYZv-N549AUEHfw@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7216A211C9
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Tue, 06 May 2025 12:11:26 +0200,
Ezra Khuzadi wrote:
> 
> 
> Hi Takashi, Jaroslav, all maintainers,
> 
> Could you please review it or let me know if any changes are needed? This is
> my first kernel patch as a student, and I’d appreciate any feedback.

I guess you submitted to a wrong address.  The proper mailing list is
linux-sound@vger.kernel.org.  Please try to resubmit.
And, make sure that your mailer doesn't break tabs and whitespaces.
You can test sending to yourself and verify that the submitted patch
is properly applicable beforehand.


thanks,

Takashi

> 
> Thanks,
> Ezra Khuzadi
> 
> On Wed, Apr 30, 2025 at 1:43 AM Ezra Khuzadi <ekhuzadi@uci.edu> wrote:
> 
>     sound/pci/hda/patch_realtek.c: add quirk for HP Spectre x360 15-eb0xxx
>    
>     Add subsystem ID 0x86e5 for HP Spectre x360 15-eb0xxx so that
>     ALC285_FIXUP_HP_SPECTRE_X360_EB1 (GPIO amp-enable, mic-mute LED and
>     pinconfigs) is applied.
>    
>     Tested on HP Spectre x360 15-eb0043dx (Vendor 0x10ec0285, Subsys
>     0x103c86e5)
>     with legacy HDA driver and hda-verb toggles:
>    
>       $ cat /proc/asound/card0/codec#0 \
>           | sed -n -e '1,5p;/Vendor Id:/p;/Subsystem Id:/p'
>       Codec: Realtek ALC285
>       Vendor Id: 0x10ec0285
>       Subsystem Id: 0x103c86e5
>    
>       $ dmesg | grep -i realtek
>       [    5.828728] snd_hda_codec_realtek ehdaudio0D0: ALC285: picked fixup
>             for PCI SSID 103c:86e5
>    
>     Signed-off-by: Ezra Khuzadi <ekhuzadi@uci.edu>
>     Cc: stable@vger.kernel.org
>    
>     ---
>      sound/pci/hda/patch_realtek.c | 1 +
>      1 file changed, 1 insertion(+)
>    
>     diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>     index 877137cb09ac..82ad105e7fa9 100644
>     --- a/sound/pci/hda/patch_realtek.c
>     +++ b/sound/pci/hda/patch_realtek.c
>     @@ -10563,6 +10563,7 @@ static const struct hda_quirk alc269_fixup_tbl[] =
>     {
>        SND_PCI_QUIRK(0x103c, 0x86c7, "HP Envy AiO 32",
>     ALC274_FIXUP_HP_ENVY_GPIO),
>     +  SND_PCI_QUIRK(0x103c, 0x86e5, "HP Spectre x360 15-eb0xxx",
>     ALC285_FIXUP_HP_SPECTRE_X360_EB1),
>        SND_PCI_QUIRK(0x103c, 0x86e7, "HP Spectre x360 15-eb0xxx",
>     ALC285_FIXUP_HP_SPECTRE_X360_EB1),
>        SND_PCI_QUIRK(0x103c, 0x86e8, "HP Spectre x360 15-eb0xxx",
>     ALC285_FIXUP_HP_SPECTRE_X360_EB1),
>        SND_PCI_QUIRK(0x103c, 0x86f9, "HP Spectre x360 13-aw0xxx",
>     ALC285_FIXUP_HP_SPECTRE_X360_MUTE_LED),
>    
>     On Wed, Apr 30, 2025 at 1:33 AM kernel test robot <lkp@intel.com> wrote:
>     >
>     > Hi,
>     >
>     > Thanks for your patch.
>     >
>     > FYI: kernel test robot notices the stable kernel rule is not satisfied.
>     >
>     > The check is based on 
>     https://urldefense.com/v3/__https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html*option-1__;Iw!!CzAuKJ42GuquVTTmVmPViYEvSg!PiCmDJsbkP48HY6ady0rbC21rGusuY-IjJ61JqQnp99GdHsbc5uEQDwV-Q9TeKK7R4THFV7fXQ$
>     >
>     > Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to
>     have the patch automatically included in the stable tree.
>     > Subject: sound/pci/hda: add quirk for HP Spectre x360 15-eb0xxx
>     > Link: 
>     https://urldefense.com/v3/__https://lore.kernel.org/stable/CAPXr0uxh0c_2b2-zJF*3DN8T6DfccfyvOQRX0X0VO24dS7YsxzzQ*40mail.gmail.com__;JSU!!CzAuKJ42GuquVTTmVmPViYEvSg!PiCmDJsbkP48HY6ady0rbC21rGusuY-IjJ61JqQnp99GdHsbc5uEQDwV-Q9TeKK7R4SyRLIbeQ$
>     >
>     > --
>     > 0-DAY CI Kernel Test Service
>     > 
>     https://urldefense.com/v3/__https://github.com/intel/lkp-tests/wiki__;!!CzAuKJ42GuquVTTmVmPViYEvSg!PiCmDJsbkP48HY6ady0rbC21rGusuY-IjJ61JqQnp99GdHsbc5uEQDwV-Q9TeKK7R4QdTQyPmg$
>     >
>     >
>     >
> 

