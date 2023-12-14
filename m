Return-Path: <stable+bounces-6732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBB9812E13
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 12:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75CFDB20EC5
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 11:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A243E47D;
	Thu, 14 Dec 2023 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QhD1r8Ka";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1BL54thY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Juks4PQG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="meOGCL4w"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790C819E;
	Thu, 14 Dec 2023 03:05:25 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8C701F7C5;
	Thu, 14 Dec 2023 11:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702551923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jh37XTpPgpC2e/hQvtSi2xLMjUa4CLQ/Qc/4iU+ctz8=;
	b=QhD1r8KaNEnVlUiKbnubxJCrqYOdYnKAv8yx6nfxbPiYeVXYYlr80UGEDucDxWeJFXzkv8
	Pkxjkh1GdLDme0PojFw+wITS4K1WchK83pPixo8QMJ9o4GA9Qmo1PRCCupLEVDFqbmJnGg
	jG06Cfp3tYENU3AbZlyImW6wga2oD5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702551923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jh37XTpPgpC2e/hQvtSi2xLMjUa4CLQ/Qc/4iU+ctz8=;
	b=1BL54thYGVy/fgg4y0NQVekCcFPlpbPdyE9DB7zb3UCRlfSxSPruU2LNHqSz0SH2jZtRVH
	/wJ0XhtpEJ6peXAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702551922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jh37XTpPgpC2e/hQvtSi2xLMjUa4CLQ/Qc/4iU+ctz8=;
	b=Juks4PQGiBnzKLV4rBuaIEt83E+4s01zPghD6/57nHXY7Oua5zbFkmd/9sAn9M/MxC4I49
	QoZdlm1TDbX5Z1Hh7j1jXAq6xdqxTSoMR5kSlklVXygG1TZ+Uf0TmJE3Qd/JdzRzbTGlvo
	UlflqhTW0enE4d7+iQ0zm0vs1Q+mmSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702551922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jh37XTpPgpC2e/hQvtSi2xLMjUa4CLQ/Qc/4iU+ctz8=;
	b=meOGCL4wEyUo5NiQk+oYjFsoFTlUC4kJOvFwXFflJLRe6nllAqXyaDBaMc2wfzutE9nikp
	zT9OWayuyFk2ODDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F8D1137E8;
	Thu, 14 Dec 2023 11:05:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f8eRIXLhemUwZwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 14 Dec 2023 11:05:22 +0000
Date: Thu, 14 Dec 2023 12:05:22 +0100
Message-ID: <87cyv9qc25.wl-tiwai@suse.de>
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
Subject: Re: [PATCH] ALSA: hda/tas2781: reset the amp before component_add
In-Reply-To: <4d23bf58558e23ee8097de01f70f1eb8d9de2d15.1702511246.git.soyer@irl.hu>
References: <4d23bf58558e23ee8097de01f70f1eb8d9de2d15.1702511246.git.soyer@irl.hu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -1.76
X-Spam-Level: 
X-Spam-Score: -1.87
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.87 / 50.00];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[irl.hu:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.77)[98.99%]
X-Spam-Flag: NO

On Thu, 14 Dec 2023 00:49:20 +0100,
Gergo Koteles wrote:
> 
> Calling component_add starts loading the firmware, the callback function
> writes the program to the amplifiers. If the module resets the
> amplifiers after component_add, it happens that one of the amplifiers
> does not work because the reset and program writing are interleaving.
> 
> Call tas2781_reset before component_add to ensure reliable
> initialization.
> 
> Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
> CC: stable@vger.kernel.org
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

Thanks, applied now.


Takashi

