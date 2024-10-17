Return-Path: <stable+bounces-86582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864E39A1D3F
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 10:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDFBEB20FBC
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 08:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473E91D3198;
	Thu, 17 Oct 2024 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o+4U0cDW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gzaTTXie";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o+4U0cDW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gzaTTXie"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE7814E2FD;
	Thu, 17 Oct 2024 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154044; cv=none; b=Mh6dLpmlxgcaLiNT/ShFu58h8ZL6ZIh6eGXn46YorW/wG9A4UhyouNLXxLMVO3rBXGoezcQEwULpMRrwaRgh8wHia4hYBeKkgbAS3nrfU24HlBv8PO/+9FVlkDo02bbZ/m/kfMyepKVgN8HusTEh8x2Q0RO/mokMyDePdcCeXh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154044; c=relaxed/simple;
	bh=9im4KKOH2I/A7fscfYrIcT0vHCvwSTgO70ai7oEomwo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkFplDJSSctGhLc2yt4VBlOlJ2nITNKKmHzoN8PveapW2cpANJirWgXNAWL256CZhDSXOw41UYteBg0KodMApqXeGe5F7qO0fPMD3DkthzhcHEaoUlzHeK7/kOFc3br6RjYA+A6UOxhabbHt5TdOokMrH2HHSHyhZL/g+s+uNL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o+4U0cDW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gzaTTXie; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o+4U0cDW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gzaTTXie; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1214E1FEF3;
	Thu, 17 Oct 2024 08:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729154033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U0LftmHZiRJcAXQvf+1qR7uws7MN71VNpVxTbpbdR48=;
	b=o+4U0cDWpLWJljWlEANwuKWGu6O8EO/Tp23kn7tly7VZIEHcGGIapsWaQwQSnDZhdcn9Xs
	fL/3zX6F3HhiF1Sh6ImJ5BY9Oy/cUMxQYAGJrs1w2ccIcgBRajNNzOK/T9CBbekLxplvEU
	JLYPE8/70d+54ljfDv/ZoRAbKnkCqy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729154033;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U0LftmHZiRJcAXQvf+1qR7uws7MN71VNpVxTbpbdR48=;
	b=gzaTTXielSf9yomSdOw7WnWYmrrIazs/7+GN4AwgZvwZhm1Nls57q/0HRN4+YWi944BuCz
	fGPvA/WWKRRN2gCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729154033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U0LftmHZiRJcAXQvf+1qR7uws7MN71VNpVxTbpbdR48=;
	b=o+4U0cDWpLWJljWlEANwuKWGu6O8EO/Tp23kn7tly7VZIEHcGGIapsWaQwQSnDZhdcn9Xs
	fL/3zX6F3HhiF1Sh6ImJ5BY9Oy/cUMxQYAGJrs1w2ccIcgBRajNNzOK/T9CBbekLxplvEU
	JLYPE8/70d+54ljfDv/ZoRAbKnkCqy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729154033;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U0LftmHZiRJcAXQvf+1qR7uws7MN71VNpVxTbpbdR48=;
	b=gzaTTXielSf9yomSdOw7WnWYmrrIazs/7+GN4AwgZvwZhm1Nls57q/0HRN4+YWi944BuCz
	fGPvA/WWKRRN2gCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCDC513A42;
	Thu, 17 Oct 2024 08:33:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YdyZMPDLEGe/OQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 17 Oct 2024 08:33:52 +0000
Date: Thu, 17 Oct 2024 10:34:51 +0200
Message-ID: <87cyjzrutw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dean Matthew Menezes <dean.menezes@utexas.edu>
Cc: Takashi Iwai <tiwai@suse.de>,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Linux Sound System <linux-sound@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: No sound on speakers X1 Carbon Gen 12
In-Reply-To: <CAEkK70TAk26HFgrz4ZS0jz4T2Eu3LWcG-JD1Ov_2ffMp66oO-g@mail.gmail.com>
References: <CAEkK70Tke7UxMEEKgRLMntSYeMqiv0PC8st72VYnBVQD-KcqVw@mail.gmail.com>
	<2024101613-giggling-ceremony-aae7@gregkh>
	<433b8579-e181-40e6-9eac-815d73993b23@leemhuis.info>
	<87bjzktncb.wl-tiwai@suse.de>
	<CAEkK70TAk26HFgrz4ZS0jz4T2Eu3LWcG-JD1Ov_2ffMp66oO-g@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Wed, 16 Oct 2024 23:18:02 +0200,
Dean Matthew Menezes wrote:
> 
> OK I have run the script and have attached the outputs.

Please avoid top-posting.

> On Wed, 16 Oct 2024 at 04:20, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Wed, 16 Oct 2024 07:56:09 +0200,
> > Linux regression tracking (Thorsten Leemhuis) wrote:
> > >
> > > On 16.10.24 07:42, Greg KH wrote:
> > > > On Tue, Oct 15, 2024 at 07:47:22PM -0500, Dean Matthew Menezes wrote:
> > > >> I am not getting sound on the speakers on my Thinkpad X1 Carbon Gen 12
> > > >> with kernel 6.11.2  The sound is working in kernel 6.8
> > > >
> > > > Can you use 'git bisect' to track down the offending change?
> > >
> > > Yeah, that would help a lot.
> > >
> > > But FWIW, I CCed the audio maintainers and the sound mailing list, with
> > > a bit of luck they might have an idea.
> > >
> > > You might also want to publish your dmesg files from the latest working
> > > and the first broken kernel, that gives people a chance to spot obvious
> > > problems. Ohh, and runing alsa-info.sh and publishing the output could
> > > help, too.
> >
> > Yes, alsa-info.sh outputs are really needed for debugging, especially
> > because Lenovo has (literally) hundreds of different models.
> >
> > Please run the script with --no-upload option and attach the outputs
> > from both working and non-working cases.

So the problem seems to be the newly added quirk for fixing S4 issue
forgot the existing quirk for the speaker.  The patch below should
address the problem.  Please give it a try.


thanks,

Takashi

-- 8< --
From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda/realtek: Fix speaker output on Thinkpad X1 Carbon Gen 12

The fix for S4 issue on some Thinkpad models in commit 1e707769df07
("ALSA: hda/realtek - Set GPIO3 to default at S4 state for Thinkpad
with ALC1318") caused a regression of the missing speaker output, as
the newly added quirk entry forgot that there was an implicitly
applied quirk matching with the pincfg, which determines the speaker
DAC connection and the I2S setup.

Correct the chained quirk entry to point to the right one,
ALC287_FIXUP_THINKPAD_I2S_SPK, to address the regression.

Fixes: 1e707769df07 ("ALSA: hda/realtek - Set GPIO3 to default at S4 state for Thinkpad with ALC1318")
Reported-by: Dean Matthew Menezes <dean.menezes@utexas.edu>
Closes: https://lore.kernel.org/all/CAEkK70Tke7UxMEEKgRLMntSYeMqiv0PC8st72VYnBVQD-KcqVw@mail.gmail.com/
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3bbf5fab2881..cc77b4967400 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10097,7 +10097,7 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc287_fixup_lenovo_thinkpad_with_alc1318,
 		.chained = true,
-		.chain_id = ALC269_FIXUP_THINKPAD_ACPI
+		.chain_id = ALC287_FIXUP_THINKPAD_I2S_SPK
 	},
 	[ALC256_FIXUP_CHROME_BOOK] = {
 		.type = HDA_FIXUP_FUNC,
-- 
2.43.0


