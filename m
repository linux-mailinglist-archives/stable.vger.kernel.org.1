Return-Path: <stable+bounces-247625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GQLK1fnBmoHowIAu9opvQ
	(envelope-from <stable+bounces-247625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:28:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D65B54C6AD
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9B31320DA77
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBE342B721;
	Fri, 15 May 2026 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rhC/CPXb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UmaRIA08";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nk2pKARl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qF3q43IE"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C5042883C
	for <stable@vger.kernel.org>; Fri, 15 May 2026 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836038; cv=none; b=TmJOJT2kVeyt7LSXDz+j4G6uTe9TqM7rNhkMln3oH+XJA8PcGdwO905H4FuhhT0i6xdVYq2A3eEme9rlhSXMOuj+ltvjuNPEQ71GLDMofzhI+V4e3bJafJw0ovY74ruU8LhSmkRqQK9ztLDCT3+fIrhp0Ut3TNUCPBVYFQvh5Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836038; c=relaxed/simple;
	bh=DrqXsdqp2Vd8spFl6O+WtPgMPTIpADhVfhi31z/1iS4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhxlpkfFlgd+Z437EV147KPQsTOjkPLxm2Tcn/t4vgmkRoR3b0n0b5wnzKpcdQLESkx60WREUxBvQGl99b5WYLZ3L+3NTEmSurTsdqUwYMTP1o0M+lie0BFj7+W+EUc6/5xL35bCJz6ZvKQN7FoGS97KIkqaASS+PWj2S/CdT2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rhC/CPXb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UmaRIA08; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nk2pKARl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qF3q43IE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E724261F54;
	Fri, 15 May 2026 09:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778836035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IQAcAzoKTIOjOz2aGlg5r/suVgpvoeOQg+9QcsRjnQ=;
	b=rhC/CPXbzjd4nzG4bpOUlVSraSgtHUBI18MplhV7XzoM+/n2wvLABFNOVMiaSD4oc2O4E/
	dvlfCPVc9XY6Pc9MIXGRLQqy9QrvU2TNUNe5cvpYbThVgQ4b5Mxo8r9lbIcbVIz5PctoOp
	zx4bdDhxNmlO+wvnhVOeBh70k1jQ1KE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778836035;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IQAcAzoKTIOjOz2aGlg5r/suVgpvoeOQg+9QcsRjnQ=;
	b=UmaRIA08H+z03HzdttiOZe56vhhh4nR19eFGwElCNJvTevRh90wc2TWOeEkxwRb5lqxqVF
	yeRi4eM5mHXxYUBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nk2pKARl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qF3q43IE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778836034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IQAcAzoKTIOjOz2aGlg5r/suVgpvoeOQg+9QcsRjnQ=;
	b=nk2pKARl8R+sG5TTim0jseDA2cO1JD/NyUG/Ie3CJuiRfhon6jeE1jvaxnmWUkdqPxjeGA
	9cmWeaCUYDPRpChj0+sxWh71rgaBcBp6DZYyqM0JEuWaW1B/Q48eYHOj/dknq86NPuSXPD
	c7Rk79LllomnlS8jgHioSgLPOOGDoS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778836034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IQAcAzoKTIOjOz2aGlg5r/suVgpvoeOQg+9QcsRjnQ=;
	b=qF3q43IEfl6tVA/L/JIaTvjJtrN7h015jgjUKtueuUPKLKWHsJkd3fsbcsVgr4dDspRVKh
	xCqVHxIZ/WfTdNAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96A38593A9;
	Fri, 15 May 2026 09:07:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d3E/I0LiBmpfWQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 15 May 2026 09:07:14 +0000
Date: Fri, 15 May 2026 11:07:14 +0200
Message-ID: <87mry1t519.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: David Rhodes <david.rhodes@cirrus.com>,
    Richard Fitzgerald <rf@opensource.cirrus.com>,
    Stefan Binding <sbinding@opensource.cirrus.com>,
    Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] ALSA: hda/cs35l41: Fix firmware load work teardown
In-Reply-To: <20260511-alsa-hda-cs35l41-fw-work-teardown-v1-1-1184e9bc4f25@gmail.com>
References: <20260511-alsa-hda-cs35l41-fw-work-teardown-v1-1-1184e9bc4f25@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: 0D65B54C6AD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-247625-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,perex.cz,vger.kernel.org,opensource.cirrus.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, 11 May 2026 06:29:34 +0200,
Cássio Gabriel wrote:
> 
> cs35l41_hda creates ALSA controls whose private data points at the
> cs35l41_hda object. The firmware load control can also queue
> fw_load_work.
> 
> Those controls are not removed on component unbind, and device remove
> only cancels fw_load_work through cs35l41_remove_dsp(). That helper is
> skipped when halo_initialized is false. With firmware_autostart
> disabled, a firmware load can be requested before the DSP has been
> initialized. If the component or device is removed before the queued
> work runs, the worker can run after teardown and dereference driver
> state that is no longer valid.
> 
> Track the created controls and remove them on unbind so no new control
> callback can reach the driver data or queue more work. Then cancel
> fw_load_work to drain any request that was already queued. Also cancel
> the work unconditionally during device remove before runtime PM teardown.
> 
> Fixes: 47ceabd99a28 ("ALSA: hda: cs35l41: Support Firmware switching and reloading")
> Fixes: 4c870513fbb0 ("ALSA: hda: cs35l41: Add read-only ALSA control for forced mute")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>

Cirrus people, could you take a look?  I'd like to let this better
reviewed since it's non-trivial changes.


thanks,

Takashi

> ---
>  sound/hda/codecs/side-codecs/cs35l41_hda.c | 77 +++++++++++++++++++++---------
>  sound/hda/codecs/side-codecs/cs35l41_hda.h |  5 ++
>  2 files changed, 60 insertions(+), 22 deletions(-)
> 
> diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
> index b64890006bb7..7f18be0ccf5a 100644
> --- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
> +++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
> @@ -1325,6 +1325,43 @@ static int cs35l41_fw_type_ctl_info(struct snd_kcontrol *kcontrol, struct snd_ct
>  	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(cs35l41_hda_fw_ids), cs35l41_hda_fw_ids);
>  }
>  
> +static void cs35l41_remove_controls(struct cs35l41_hda *cs35l41)
> +{
> +	if (!cs35l41->codec)
> +		return;
> +
> +	snd_ctl_remove(cs35l41->codec->card, cs35l41->mute_override_ctl);
> +	cs35l41->mute_override_ctl = NULL;
> +
> +	snd_ctl_remove(cs35l41->codec->card, cs35l41->fw_load_ctl);
> +	cs35l41->fw_load_ctl = NULL;
> +
> +	snd_ctl_remove(cs35l41->codec->card, cs35l41->fw_type_ctl);
> +	cs35l41->fw_type_ctl = NULL;
> +}
> +
> +static int cs35l41_add_control(struct cs35l41_hda *cs35l41,
> +			       struct snd_kcontrol_new *ctl,
> +			       struct snd_kcontrol **kctl)
> +{
> +	int ret;
> +
> +	*kctl = snd_ctl_new1(ctl, cs35l41);
> +	if (!*kctl)
> +		return -ENOMEM;
> +
> +	ret = snd_ctl_add(cs35l41->codec->card, *kctl);
> +	if (ret) {
> +		dev_err(cs35l41->dev, "Failed to add KControl %s = %d\n", ctl->name, ret);
> +		*kctl = NULL;
> +		return ret;
> +	}
> +
> +	dev_dbg(cs35l41->dev, "Added Control %s\n", ctl->name);
> +
> +	return 0;
> +}
> +
>  static int cs35l41_create_controls(struct cs35l41_hda *cs35l41)
>  {
>  	char fw_type_ctl_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
> @@ -1360,32 +1397,23 @@ static int cs35l41_create_controls(struct cs35l41_hda *cs35l41)
>  	scnprintf(mute_override_ctl_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "%s Forced Mute Status",
>  		  cs35l41->amp_name);
>  
> -	ret = snd_ctl_add(cs35l41->codec->card, snd_ctl_new1(&fw_type_ctl, cs35l41));
> -	if (ret) {
> -		dev_err(cs35l41->dev, "Failed to add KControl %s = %d\n", fw_type_ctl.name, ret);
> -		return ret;
> -	}
> -
> -	dev_dbg(cs35l41->dev, "Added Control %s\n", fw_type_ctl.name);
> -
> -	ret = snd_ctl_add(cs35l41->codec->card, snd_ctl_new1(&fw_load_ctl, cs35l41));
> -	if (ret) {
> -		dev_err(cs35l41->dev, "Failed to add KControl %s = %d\n", fw_load_ctl.name, ret);
> -		return ret;
> -	}
> -
> -	dev_dbg(cs35l41->dev, "Added Control %s\n", fw_load_ctl.name);
> +	ret = cs35l41_add_control(cs35l41, &fw_type_ctl, &cs35l41->fw_type_ctl);
> +	if (ret)
> +		goto err;
>  
> -	ret = snd_ctl_add(cs35l41->codec->card, snd_ctl_new1(&mute_override_ctl, cs35l41));
> -	if (ret) {
> -		dev_err(cs35l41->dev, "Failed to add KControl %s = %d\n", mute_override_ctl.name,
> -			ret);
> -		return ret;
> -	}
> +	ret = cs35l41_add_control(cs35l41, &fw_load_ctl, &cs35l41->fw_load_ctl);
> +	if (ret)
> +		goto err;
>  
> -	dev_dbg(cs35l41->dev, "Added Control %s\n", mute_override_ctl.name);
> +	ret = cs35l41_add_control(cs35l41, &mute_override_ctl, &cs35l41->mute_override_ctl);
> +	if (ret)
> +		goto err;
>  
>  	return 0;
> +
> +err:
> +	cs35l41_remove_controls(cs35l41);
> +	return ret;
>  }
>  
>  static bool cs35l41_dsm_supported(acpi_handle handle, unsigned int commands)
> @@ -1522,6 +1550,10 @@ static void cs35l41_hda_unbind(struct device *dev, struct device *master, void *
>  		device_link_remove(&cs35l41->codec->core.dev, cs35l41->dev);
>  		unlock_system_sleep(sleep_flags);
>  		memset(comp, 0, sizeof(*comp));
> +
> +		cs35l41_remove_controls(cs35l41);
> +		cancel_work_sync(&cs35l41->fw_load_work);
> +		cs35l41->codec = NULL;
>  	}
>  }
>  
> @@ -2058,6 +2090,7 @@ void cs35l41_hda_remove(struct device *dev)
>  	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
>  
>  	component_del(cs35l41->dev, &cs35l41_hda_comp_ops);
> +	cancel_work_sync(&cs35l41->fw_load_work);
>  
>  	pm_runtime_get_sync(cs35l41->dev);
>  	pm_runtime_dont_use_autosuspend(cs35l41->dev);
> diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.h b/sound/hda/codecs/side-codecs/cs35l41_hda.h
> index 7d003c598e93..56ec07c0bb74 100644
> --- a/sound/hda/codecs/side-codecs/cs35l41_hda.h
> +++ b/sound/hda/codecs/side-codecs/cs35l41_hda.h
> @@ -57,6 +57,8 @@ enum control_bus {
>  	SPI
>  };
>  
> +struct snd_kcontrol;
> +
>  struct cs35l41_hda {
>  	struct device *dev;
>  	struct regmap *regmap;
> @@ -75,6 +77,9 @@ struct cs35l41_hda {
>  	int speaker_id;
>  	struct mutex fw_mutex;
>  	struct work_struct fw_load_work;
> +	struct snd_kcontrol *fw_type_ctl;
> +	struct snd_kcontrol *fw_load_ctl;
> +	struct snd_kcontrol *mute_override_ctl;
>  
>  	struct regmap_irq_chip_data *irq_data;
>  	bool firmware_running;
> 
> ---
> base-commit: 1bc46462f4c09f8d429ae8ec17f92886d604659f
> change-id: 20260421-alsa-hda-cs35l41-fw-work-teardown-48cdba14a9cd
> 
> Best regards,
> --
> Cássio Gabriel <cassiogabrielcontato@gmail.com>
> -- 
> Cássio Gabriel <cassiogabrielcontato@gmail.com>
> 

