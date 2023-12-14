Return-Path: <stable+bounces-6731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8130812E06
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 12:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6081C21515
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 11:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DA23E47B;
	Thu, 14 Dec 2023 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vQkTMrY5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3bzta1/D";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vQkTMrY5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3bzta1/D"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC03E11A;
	Thu, 14 Dec 2023 03:04:14 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E1E71F7C5;
	Thu, 14 Dec 2023 11:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702551851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Skljw5BSFfgpdqQOUDwAU/GCeFOgAjR5XeHFC81qJ/A=;
	b=vQkTMrY51vyqlOg2jW5/nLQEPzZYE1f5yCnE4mFBzuluT+Njn+CXslgqe6U70uf9/1tT3P
	EzkUXzYNjB/at29bS8wHUI++bWErXHEwijxXpk/xZP6DJByPieFXU9oTkZniEuAkDx/fzA
	8nZ0f7FozdBeDA5GIhbh+nRyftoUpFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702551851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Skljw5BSFfgpdqQOUDwAU/GCeFOgAjR5XeHFC81qJ/A=;
	b=3bzta1/DtvaaOVt6hYd6neZPDuvXk7u9Vqc6CdtOsl03namm2nc4Pk9CipUVASKQOrKvGa
	TxZ2knK6DoJRBpAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702551851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Skljw5BSFfgpdqQOUDwAU/GCeFOgAjR5XeHFC81qJ/A=;
	b=vQkTMrY51vyqlOg2jW5/nLQEPzZYE1f5yCnE4mFBzuluT+Njn+CXslgqe6U70uf9/1tT3P
	EzkUXzYNjB/at29bS8wHUI++bWErXHEwijxXpk/xZP6DJByPieFXU9oTkZniEuAkDx/fzA
	8nZ0f7FozdBeDA5GIhbh+nRyftoUpFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702551851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Skljw5BSFfgpdqQOUDwAU/GCeFOgAjR5XeHFC81qJ/A=;
	b=3bzta1/DtvaaOVt6hYd6neZPDuvXk7u9Vqc6CdtOsl03namm2nc4Pk9CipUVASKQOrKvGa
	TxZ2knK6DoJRBpAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEF27137E8;
	Thu, 14 Dec 2023 11:04:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LA0HNSrhemXnZgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 14 Dec 2023 11:04:10 +0000
Date: Thu, 14 Dec 2023 12:04:10 +0100
Message-ID: <87edfpqc45.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/tas2781: call cleanup functions only once
In-Reply-To: <1a0885c424bb21172702d254655882b59ef6477a.1702510018.git.soyer@irl.hu>
References: <1a0885c424bb21172702d254655882b59ef6477a.1702510018.git.soyer@irl.hu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: 0.87
X-Spam-Level: 
X-Spam-Score: 0.84
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.84 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.06)[60.79%]
X-Spam-Flag: NO

On Thu, 14 Dec 2023 00:28:16 +0100,
Gergo Koteles wrote:
> 
> If the module can load the RCA but not the firmware binary, it will call
> the cleanup functions. Then unloading the module causes general
> protection fault due to double free.
> 
> Do not call the cleanup functions in tasdev_fw_ready.
> 
> general protection fault, probably for non-canonical address
> 0x6f2b8a2bff4c8fec: 0000 [#1] PREEMPT SMP NOPTI
> Call Trace:
>  <TASK>
>  ? die_addr+0x36/0x90
>  ? exc_general_protection+0x1c5/0x430
>  ? asm_exc_general_protection+0x26/0x30
>  ? tasdevice_config_info_remove+0x6d/0xd0 [snd_soc_tas2781_fmwlib]
>  tas2781_hda_unbind+0xaa/0x100 [snd_hda_scodec_tas2781_i2c]
>  component_unbind+0x2e/0x50
>  component_unbind_all+0x92/0xa0
>  component_del+0xa8/0x140
>  tas2781_hda_remove.isra.0+0x32/0x60 [snd_hda_scodec_tas2781_i2c]
>  i2c_device_remove+0x26/0xb0
> 
> Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
> CC: stable@vger.kernel.org
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

Thanks, applied.


Takashi

