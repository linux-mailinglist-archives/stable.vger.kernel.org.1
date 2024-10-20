Return-Path: <stable+bounces-86945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D00939A52FE
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 09:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A6C9B2138C
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 07:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9736525771;
	Sun, 20 Oct 2024 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c8GP7jYy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W2dPVKAD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c8GP7jYy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W2dPVKAD"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E6CBA2D;
	Sun, 20 Oct 2024 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729408729; cv=none; b=Y+aKpyM9a5Q3dvnJ1T/cOW+zdK9LUF5oWRKcY1ifKy3cOd1EhRn96KgAJQ7rfTZmtdW+9KLhZdKcW5cyP3p0YaaoWEf55TfxBPENrftdlqs9RtJATaC9opPFdYn7xHdy9lfFhatosoGA8YdVsD/5JmSmEv8t9QVZFNRnLfQdRUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729408729; c=relaxed/simple;
	bh=7T8jIq9N8C0DJGZ91eyFAZd2P2AtqTLtY7CHEzjm+dM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y90VNswwadSLD7Q8//R87TUs/mzeooEi1gQd2F6j6YESWmXhIEP83s+dQqFChDTaDAM0oQomHQyTwRyF34X/lFYRcuc/CnOFFcp531QuYNGoxmTnkwOsM88LjI+u4GSZYLTubNsW/rtp5/Gaos1YXbLo4ELMaCByMxIb1awv+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c8GP7jYy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W2dPVKAD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c8GP7jYy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W2dPVKAD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3D6471FDA7;
	Sun, 20 Oct 2024 07:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729408720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nFtbtmULMnSG3ZeJX/CQ1Cnqql0kK3sTI0bMhJ/FxrY=;
	b=c8GP7jYykFI93i08I6K6+dvUhyIpVMe0Xzb8O2w7q69km+gk08hvybznHE828WA8INg3JY
	+N4VY5IklA7jgyEtaX9nwVE8axTzxiqomcF6EpebrlNrPcGqVzvj3EWnqaRhqRwevywkxo
	uJOmXQT0qGeuXs2t6am1m5K3060XSmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729408720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nFtbtmULMnSG3ZeJX/CQ1Cnqql0kK3sTI0bMhJ/FxrY=;
	b=W2dPVKAD29f+HGL46xp9OYI9TbfcuJENxAMas+OhxR9gipDyK79eVmty0D4qZhZGiRJijY
	tYMqoTWTQ1JMizDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729408720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nFtbtmULMnSG3ZeJX/CQ1Cnqql0kK3sTI0bMhJ/FxrY=;
	b=c8GP7jYykFI93i08I6K6+dvUhyIpVMe0Xzb8O2w7q69km+gk08hvybznHE828WA8INg3JY
	+N4VY5IklA7jgyEtaX9nwVE8axTzxiqomcF6EpebrlNrPcGqVzvj3EWnqaRhqRwevywkxo
	uJOmXQT0qGeuXs2t6am1m5K3060XSmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729408720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nFtbtmULMnSG3ZeJX/CQ1Cnqql0kK3sTI0bMhJ/FxrY=;
	b=W2dPVKAD29f+HGL46xp9OYI9TbfcuJENxAMas+OhxR9gipDyK79eVmty0D4qZhZGiRJijY
	tYMqoTWTQ1JMizDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 051DC13894;
	Sun, 20 Oct 2024 07:18:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GcUQANCuFGf/egAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 20 Oct 2024 07:18:40 +0000
Date: Sun, 20 Oct 2024 09:19:39 +0200
Message-ID: <87h697jl6c.wl-tiwai@suse.de>
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
In-Reply-To: <CAEkK70RAWRjRp6_=bSrecSXXMfnepC2P2YriaHUqicv5x5wJWw@mail.gmail.com>
References: <CAEkK70Tke7UxMEEKgRLMntSYeMqiv0PC8st72VYnBVQD-KcqVw@mail.gmail.com>
	<2024101613-giggling-ceremony-aae7@gregkh>
	<433b8579-e181-40e6-9eac-815d73993b23@leemhuis.info>
	<87bjzktncb.wl-tiwai@suse.de>
	<CAEkK70TAk26HFgrz4ZS0jz4T2Eu3LWcG-JD1Ov_2ffMp66oO-g@mail.gmail.com>
	<87cyjzrutw.wl-tiwai@suse.de>
	<CAEkK70T7NBRA1dZHBwAC7mNeXPo-dby4c7Nn=SYg0vzeHHt-1A@mail.gmail.com>
	<87ttd8jyu3.wl-tiwai@suse.de>
	<CAEkK70RAWRjRp6_=bSrecSXXMfnepC2P2YriaHUqicv5x5wJWw@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.986];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 20 Oct 2024 01:11:39 +0200,
Dean Matthew Menezes wrote:
> 
> With the patch I get this alsa-info.sh

The status looks OK; at least the DAC assignment is identical with the
working case with 6.8 kernel.  But I noticed that your device doesn't
seem needing the I2S amp, judging from the module list.  Please give 
the dmesg outputs from both working and non-working cases, as
requested earlier, for further analysis, too.

Then check the following change instead of the previous one:

-- 8< --
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10754,8 +10754,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x2318, "Thinkpad Z13 Gen2", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x2319, "Thinkpad Z16 Gen2", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x231a, "Thinkpad Z16 Gen2", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
-	SND_PCI_QUIRK(0x17aa, 0x231e, "Thinkpad", ALC287_FIXUP_LENOVO_THKPAD_WH_ALC1318),
-	SND_PCI_QUIRK(0x17aa, 0x231f, "Thinkpad", ALC287_FIXUP_LENOVO_THKPAD_WH_ALC1318),
+	SND_PCI_QUIRK(0x17aa, 0x231e, "Thinkpad", ALC287_FIXUP_THINKPAD_I2S_SPK),
+	SND_PCI_QUIRK(0x17aa, 0x231f, "Thinkpad", ALC287_FIXUP_THINKPAD_I2S_SPK),
 	SND_PCI_QUIRK(0x17aa, 0x2326, "Hera2", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
-- 8< --

If this doesn't work, let's try to get rid of those entries, instead:

-- 8< --
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10754,8 +10754,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x2318, "Thinkpad Z13 Gen2", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x2319, "Thinkpad Z16 Gen2", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x231a, "Thinkpad Z16 Gen2", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
-	SND_PCI_QUIRK(0x17aa, 0x231e, "Thinkpad", ALC287_FIXUP_LENOVO_THKPAD_WH_ALC1318),
-	SND_PCI_QUIRK(0x17aa, 0x231f, "Thinkpad", ALC287_FIXUP_LENOVO_THKPAD_WH_ALC1318),
+//	SND_PCI_QUIRK(0x17aa, 0x231e, "Thinkpad", ALC287_FIXUP_LENOVO_THKPAD_WH_ALC1318),
+//	SND_PCI_QUIRK(0x17aa, 0x231f, "Thinkpad", ALC287_FIXUP_LENOVO_THKPAD_WH_ALC1318),
 	SND_PCI_QUIRK(0x17aa, 0x2326, "Hera2", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
-- 8< --

If neither of the above brings back the sound, I must have looked at a
wrong place.


thanks,

Takashi

