Return-Path: <stable+bounces-254375-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLVoCC2xFWpxYAcAu9opvQ
	(envelope-from <stable+bounces-254375-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:41:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6555D7CC9
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DE8830363B9
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 14:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE223C76B9;
	Tue, 26 May 2026 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JJeQiacv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7DnUkntZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JJeQiacv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7DnUkntZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F833D9684
	for <stable@vger.kernel.org>; Tue, 26 May 2026 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805872; cv=none; b=UhydIBcrltuLQoC1IvGFmbBDgcT+C38UXxYeh8g85Jtfg3/GWCTmRMEH02LCkgIS4GEYrKUkyVgQy6Wzc4nFXVxqafXHRvIhCUUcaayPdQUC2bYTwgpYTmc41X17ZaKXUUMzUXJKDrtU8gKUcF13PpCnP88rI1w3m0MdSiAeosM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805872; c=relaxed/simple;
	bh=KlPYfxwsjj54wwQ5mV6H4DWsBW/c3UghHw0/YI8nvZw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyvniPDJdyJsPwldGQnCWWN0HST96paMvH+1y/3/3o+jueySBruPAOt/KToq3aPSRn5C7MRKPSXzBaEnK+OZFhqPmtyq2aHdDw7w8E5ZXlIVU9h8s7V/8ivOTFo2bSorkQujs8vvs8kqO5t20Fi3mzrsmThc3WKzCdUiVxRYglM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JJeQiacv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7DnUkntZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JJeQiacv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7DnUkntZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5890D672E8;
	Tue, 26 May 2026 14:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779805869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cioNoi1N5dwczYTfhhwBNu7Jso7fTwNN/IdYdMQdKPA=;
	b=JJeQiacvibuR7erImcz0PNbeefcy17h38rnJPfGM1x7GFnF5evES0Dcfv4s8qp4dUU4daU
	E0qkLMG95qjQBllkipwdLSHXNFDzFXJbAcBmgBEFnk1GeVcjWIaGSdCFb/VhTBU54/5C1A
	k1D1Nl2CX48X1uUhP+sh29DOgfi2eWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779805869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cioNoi1N5dwczYTfhhwBNu7Jso7fTwNN/IdYdMQdKPA=;
	b=7DnUkntZYG3+qrLuFu+e5CuID2SKvUhyISmob7vyzqp9YZ3MpSVhYbnxayx7avEFu5mtjb
	bIeNOxISiwBeR8Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779805869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cioNoi1N5dwczYTfhhwBNu7Jso7fTwNN/IdYdMQdKPA=;
	b=JJeQiacvibuR7erImcz0PNbeefcy17h38rnJPfGM1x7GFnF5evES0Dcfv4s8qp4dUU4daU
	E0qkLMG95qjQBllkipwdLSHXNFDzFXJbAcBmgBEFnk1GeVcjWIaGSdCFb/VhTBU54/5C1A
	k1D1Nl2CX48X1uUhP+sh29DOgfi2eWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779805869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cioNoi1N5dwczYTfhhwBNu7Jso7fTwNN/IdYdMQdKPA=;
	b=7DnUkntZYG3+qrLuFu+e5CuID2SKvUhyISmob7vyzqp9YZ3MpSVhYbnxayx7avEFu5mtjb
	bIeNOxISiwBeR8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DB4F5A25A;
	Tue, 26 May 2026 14:31:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jk6ICq2uFWqdMQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 26 May 2026 14:31:09 +0000
Date: Tue, 26 May 2026 16:31:04 +0200
Message-ID: <87pl2ixmxj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Huacai Chen <chenhuacai@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	stable@vger.kernel.org,
	Baoqi Zhang <zhangbaoqi@loongson.cn>,
	Haowei Zheng <zhenghaowei@loongson.cn>
Subject: Re: [PATCH] ALSA: hda/hdmi: Use 'AC_PINSENSE_ELDV' to detect pinsense for Loongson
In-Reply-To: <20260526111940.2347847-1-chenhuacai@loongson.cn>
References: <20260526111940.2347847-1-chenhuacai@loongson.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254375-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AA6555D7CC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 13:19:40 +0200,
Huacai Chen wrote:
> 
> Due to a hardware defect, for Loongson PCI HDMI devices with a reversion
> ID of 2, the pin sense status must be determined via the ELD.
> 
> Add a codec flag, eld_jack_detect, to indicate this case, and do special
> handlings in read_pin_sense().
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
> Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  include/sound/hda_codec.h    | 1 +
>  sound/hda/codecs/hdmi/hdmi.c | 8 +++++++-
>  sound/hda/common/jack.c      | 4 ++++
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
> index 24581080e26a..1a1fe7a904c3 100644
> --- a/include/sound/hda_codec.h
> +++ b/include/sound/hda_codec.h
> @@ -259,6 +259,7 @@ struct hda_codec {
>  	unsigned int forced_resume:1; /* forced resume for jack */
>  	unsigned int no_stream_clean_at_suspend:1; /* do not clean streams at suspend */
>  	unsigned int ctl_dev_id:1; /* old control element id build behaviour */
> +	unsigned int eld_jack_detect:1;	/* Machine jack-detection by ELD */
>  
>  	unsigned long power_on_acct;
>  	unsigned long power_off_acct;
> diff --git a/sound/hda/codecs/hdmi/hdmi.c b/sound/hda/codecs/hdmi/hdmi.c
> index f20d1715da62..423cd9f683c6 100644
> --- a/sound/hda/codecs/hdmi/hdmi.c
> +++ b/sound/hda/codecs/hdmi/hdmi.c
> @@ -2285,6 +2285,7 @@ EXPORT_SYMBOL_NS_GPL(snd_hda_hdmi_acomp_init, "SND_HDA_CODEC_HDMI");
>  enum {
>  	MODEL_GENERIC,
>  	MODEL_GF,
> +	MODEL_LOONGSON,
>  };
>  
>  static int generichdmi_probe(struct hda_codec *codec,
> @@ -2302,6 +2303,11 @@ static int generichdmi_probe(struct hda_codec *codec,
>  	if (id->driver_data == MODEL_GF)
>  		codec->no_sticky_stream = 1;
>  
> +	if (id->driver_data == MODEL_LOONGSON) {
> +		if (codec->bus && codec->bus->pci->revision == 0x2)
> +			codec->eld_jack_detect = 1; /* Jack-detection by ELD */
> +	}
> +
>  	return 0;
>  }
>  
> @@ -2319,7 +2325,7 @@ static const struct hda_codec_ops generichdmi_codec_ops = {
>  /*
>   */
>  static const struct hda_device_id snd_hda_id_generichdmi[] = {
> -	HDA_CODEC_ID_MODEL(0x00147a47, "Loongson HDMI",		MODEL_GENERIC),
> +	HDA_CODEC_ID_MODEL(0x00147a47, "Loongson HDMI",		MODEL_LOONGSON),
>  	HDA_CODEC_ID_MODEL(0x10951390, "SiI1390 HDMI",		MODEL_GENERIC),
>  	HDA_CODEC_ID_MODEL(0x10951392, "SiI1392 HDMI",		MODEL_GENERIC),
>  	HDA_CODEC_ID_MODEL(0x11069f84, "VX11 HDMI/DP",		MODEL_GENERIC),
> diff --git a/sound/hda/common/jack.c b/sound/hda/common/jack.c
> index 98ba1c4d5ba4..1f0ebf9cd151 100644
> --- a/sound/hda/common/jack.c
> +++ b/sound/hda/common/jack.c
> @@ -58,6 +58,10 @@ static u32 read_pin_sense(struct hda_codec *codec, hda_nid_t nid, int dev_id)
>  				  AC_VERB_GET_PIN_SENSE, dev_id);
>  	if (codec->inv_jack_detect)
>  		val ^= AC_PINSENSE_PRESENCE;
> +	if (codec->eld_jack_detect) {
> +		val &= ~AC_PINSENSE_PRESENCE;
> +		val |= !!(val & AC_PINSENSE_ELDV) << 31;
> +	}

IMO it's worth for a comment in the above; basically it's faking the
AC_PINSENSE_PRESENCE from AC_PINSENSE_ELDV bit, which explains the
magic shift number.


thanks,

Takashi

