Return-Path: <stable+bounces-76650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC2397B8FD
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 10:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7651C21D0C
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 08:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A80176ACB;
	Wed, 18 Sep 2024 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hI+Jn7PP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W5XliJSq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hI+Jn7PP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W5XliJSq"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13EA176AB4;
	Wed, 18 Sep 2024 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726646994; cv=none; b=VcbHu8PKvvGwHsLR879OQHfBqDGOMngu3RfCKqRtZHLoazVYEA5Mt6422B0TlcVngp+4A3b80Ir7VlnVR+8jHEdzOoXYwyqrZDFr9TxoDsU7SSiBQAeVy3g1LPoiqDs67pIeSM+kqBgva0BpcwvgfVk2uVWW1hxkRRAmgEhNP1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726646994; c=relaxed/simple;
	bh=qz4Wjp+U8AhtB1FBlvnIV5ZTBNFIbS9umXOxm+UAKEo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n631OhM5oPlTE+/b6m9ocu322DXSdkX9wkW01wseKBRdSaXZEbFOqTSgNsVPrNogNAHJHTivL2R/hld0QK1ez0Je/ha5nrEACpfc9HyZ390MXZ/agEiOEG9S6Ad+kTKLfgrzkXL4eJmNYl7n0RBo4ztWPfibH0w9NwKp8FjO0+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hI+Jn7PP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W5XliJSq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hI+Jn7PP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W5XliJSq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C9E0203CF;
	Wed, 18 Sep 2024 08:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726646991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HM0qmaPjee+d/d/fIIAeZRg+uCEOMXGWkMIYCcEJ/a0=;
	b=hI+Jn7PPBibUy64wfAxt96wvRKmQ7rUQaxhFvzVAM8uzNSHI6pVBQ/FRDDECeousV+CY8p
	RuTTQ4mJhnmEw/hYoZ+o4bSXfKseA5xRzas1G/EWhaIdIdErVjgb0SozVlWJu0SMopDVRc
	yLtI3GdxzcQkGPwbp8n1ICen/Bbe7J4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726646991;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HM0qmaPjee+d/d/fIIAeZRg+uCEOMXGWkMIYCcEJ/a0=;
	b=W5XliJSq+VcURGbiCigjOycEYg/CCaOAV4zoZFe862HjVOvHu4qYuzyQUQdr9aRigAS5qv
	0ymyHs24xyEl0HDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hI+Jn7PP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=W5XliJSq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726646991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HM0qmaPjee+d/d/fIIAeZRg+uCEOMXGWkMIYCcEJ/a0=;
	b=hI+Jn7PPBibUy64wfAxt96wvRKmQ7rUQaxhFvzVAM8uzNSHI6pVBQ/FRDDECeousV+CY8p
	RuTTQ4mJhnmEw/hYoZ+o4bSXfKseA5xRzas1G/EWhaIdIdErVjgb0SozVlWJu0SMopDVRc
	yLtI3GdxzcQkGPwbp8n1ICen/Bbe7J4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726646991;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HM0qmaPjee+d/d/fIIAeZRg+uCEOMXGWkMIYCcEJ/a0=;
	b=W5XliJSq+VcURGbiCigjOycEYg/CCaOAV4zoZFe862HjVOvHu4qYuzyQUQdr9aRigAS5qv
	0ymyHs24xyEl0HDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D457C13A57;
	Wed, 18 Sep 2024 08:09:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KuEmMs6K6mYMVwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 18 Sep 2024 08:09:50 +0000
Date: Wed, 18 Sep 2024 10:10:41 +0200
Message-ID: <87o74le60u.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: nikolai.afanasenkov@hp.com
Cc: tiwai@suse.com,
	perex@perex.cz,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: fix mute/micmute LED for HP mt645 G8
In-Reply-To: <20240916195042.4050-1-nikolai.afanasenkov@hp.com>
References: <20240916195042.4050-1-nikolai.afanasenkov@hp.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 2C9E0203CF
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Mon, 16 Sep 2024 21:50:42 +0200,
nikolai.afanasenkov@hp.com wrote:
> 
> From: Nikolai Afanasenkov <nikolai.afanasenkov@hp.com>
> 
> The HP Elite mt645 G8 Mobile Thin Client uses an ALC236 codec
> and needs the ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk
> to enable the mute and micmute LED functionality.
> 
> This patch adds the system ID of the HP Elite mt645 G8
> to the `alc269_fixup_tbl` in `patch_realtek.c`
> to enable the required quirk.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikolai Afanasenkov <nikolai.afanasenkov@hp.com>

Thanks, applied now.


Takashi

