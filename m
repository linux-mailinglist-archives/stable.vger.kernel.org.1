Return-Path: <stable+bounces-54717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6608910641
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 15:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FFB282C3E
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 13:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E771B013D;
	Thu, 20 Jun 2024 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vHUOdrLW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/4UAsKZ2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vHUOdrLW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/4UAsKZ2"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5783F1AD3F0;
	Thu, 20 Jun 2024 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890376; cv=none; b=UhOjstASLRnuR28R2WScyRj/dXlslVbgwWZiqR+Ha2eG++PlKc7Lnr7CUfmJr5caeKTrth23NI7xKzsvhoZxd9RGIcOBCzwvZ+ki9zlQAx2Jth0flhLBM2eUSRQuq2RXgoPaourJ1Hj5HSiL8P0rPflH9Va0+dc32Y3pLMOdtDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890376; c=relaxed/simple;
	bh=FWWoGsX+MpguA9PMCgz5gtyDWs0QeFmcB4IqmyZ1Fkw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nt9YNVqDSijBhSvqOMLCPWRnYSJD0582fLCs9hSGUwpAJPAzhMx9Yor8g+/HXMyde9F1J3S/D98MFDMUUeRbfdddJJrIQQGSYanGOFzCf5d4UXcbwt6SZRp88GMKT4a9IdcSvFkb6boCcnsYVxN8FYXlI4YEI6cS3O0dWX8mMhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vHUOdrLW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/4UAsKZ2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vHUOdrLW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/4UAsKZ2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3EF341F897;
	Thu, 20 Jun 2024 13:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718890373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOYuAubJ9EQWBObIRgr4MVIAypRhYs5T/TZU6iyvzVE=;
	b=vHUOdrLWV7OQbeOg8ryN9I+4hmXPPP54lsVIwMGoEiwhCJg1vsTNw7rd1kk3nQ7i6K6FMp
	jRzY9cvKPkehR2kSPwMWznL772tWrfjgBVTEgnPQLJ4IVd2IEAGU7NxrT2xZ8IUdz2P1Ae
	PrGhe+x+hnezCcNJCBtAa2PyphMdqDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718890373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOYuAubJ9EQWBObIRgr4MVIAypRhYs5T/TZU6iyvzVE=;
	b=/4UAsKZ2yuPpkX9RmDEeW/kMuFp8+lnemtV8zb1Oo+k0REK+FHllPAv/IAIBAXdUQcbIN0
	PE5dhwP72WhH0+AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vHUOdrLW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/4UAsKZ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718890373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOYuAubJ9EQWBObIRgr4MVIAypRhYs5T/TZU6iyvzVE=;
	b=vHUOdrLWV7OQbeOg8ryN9I+4hmXPPP54lsVIwMGoEiwhCJg1vsTNw7rd1kk3nQ7i6K6FMp
	jRzY9cvKPkehR2kSPwMWznL772tWrfjgBVTEgnPQLJ4IVd2IEAGU7NxrT2xZ8IUdz2P1Ae
	PrGhe+x+hnezCcNJCBtAa2PyphMdqDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718890373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOYuAubJ9EQWBObIRgr4MVIAypRhYs5T/TZU6iyvzVE=;
	b=/4UAsKZ2yuPpkX9RmDEeW/kMuFp8+lnemtV8zb1Oo+k0REK+FHllPAv/IAIBAXdUQcbIN0
	PE5dhwP72WhH0+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B3D413AC1;
	Thu, 20 Jun 2024 13:32:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AhsFBYUvdGY2TAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 20 Jun 2024 13:32:53 +0000
Date: Thu, 20 Jun 2024 15:33:18 +0200
Message-ID: <87ed8r20yp.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Pablo =?ISO-8859-1?Q?Ca=F1o?= <pablocpascual@gmail.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14AHP9
In-Reply-To: <20240619111105.34300-1-pablocpascual@gmail.com>
References: <20240619111105.34300-1-pablocpascual@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3EF341F897
X-Spam-Score: -5.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.50 / 50.00];
	BAYES_HAM(-2.99)[99.94%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed, 19 Jun 2024 13:11:05 +0200,
Pablo Caño wrote:
> 
> Lenovo Yoga Pro 7 14AHP9 (PCI SSID 17aa:3891) seems requiring a similar workaround like Yoga 9 model and Yoga 7 Pro 14APH8 for the bass speaker.
> 
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/all/20231207182035.30248-1-tiwai@suse.de/
> Signed-off-by: Pablo Caño <pablocpascual@gmail.com>
> ---
>  sound/pci/hda/patch_realtek.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index aa76d1c88589..f9223fedf8e9 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -10525,6 +10525,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x17aa, 0x387e, "Yoga S780-16 pro Quad YC", ALC287_FIXUP_TAS2781_I2C),
>  	SND_PCI_QUIRK(0x17aa, 0x3881, "YB9 dual power mode2 YC", ALC287_FIXUP_TAS2781_I2C),
>  	SND_PCI_QUIRK(0x17aa, 0x3882, "Lenovo Yoga Pro 7 14APH8", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
> +	SND_PCI_QUIRK(0x17aa, 0x3891, "Lenovo Yoga Pro 7 14AHP9", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
>  	SND_PCI_QUIRK(0x17aa, 0x3884, "Y780 YG DUAL", ALC287_FIXUP_TAS2781_I2C),
>  	SND_PCI_QUIRK(0x17aa, 0x3886, "Y780 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
>  	SND_PCI_QUIRK(0x17aa, 0x38a7, "Y780P AMD YG dual", ALC287_FIXUP_TAS2781_I2C),

The table is sorted in PCI SSID order.  Could you try to put at the
right position and resubmit?


thanks,

Takashi

