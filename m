Return-Path: <stable+bounces-64735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3233B942A7A
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 11:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE321F21068
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 09:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533911AB51B;
	Wed, 31 Jul 2024 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uHXUG/ud";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BmMoWYvo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uHXUG/ud";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BmMoWYvo"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F30817C8D;
	Wed, 31 Jul 2024 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418137; cv=none; b=iUfv/SilyHI7nLs2e+jq4PxDFc+201bZSTmzXoYJVu4XwwnTb2p6ynAEPL7WVQKtHgIXhNdoF+pNEN0T+CMW88TNNw++3OY38ZpFXWAjUKMuhEqMKfPB+nbxnMVE9GeYQFADzXODioG7VNtbOOrzq2Crp0KF9uZ+vEVqLnxdx/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418137; c=relaxed/simple;
	bh=dW8Zk6W9eMjp2YUthgUJ/GZykyYD06tqeF8b7dB27wg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9q4iMQzawZ/NPH73gpxLab7Of6oEPT+BeXv8P5zzRoXsrz6YxB6ZGEFM8PJkiDXTYs6IrePpWMjA3X2RF1XzDCt3HSjtksgSNWLHsSvoJihyU3uREUjFWmkom/lvLr6DoehDyqgNx3TfHRKcfCcux8s28gj6F3dQhkqN7fKIn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uHXUG/ud; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BmMoWYvo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uHXUG/ud; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BmMoWYvo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6306C1F833;
	Wed, 31 Jul 2024 09:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722418133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xww2KrgmTygSkhqjYmOgbKvDtHvBLkrRjLM8Ffaw1vI=;
	b=uHXUG/ud+yLP3GulJDgZyjAFtOZL37GyTo9PzP0odYPyMQ6xaLycNVEru365CcWF2szoaR
	aeHH7CKQ0hdUKzMbO3/oUjxW/DroUvOUKsFW3Bw8bhcGgO825l4xNpYkxdMz+IvUAg622d
	KPVrZkq8hAk97TbWm/jvcKEu9tJI7AM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722418133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xww2KrgmTygSkhqjYmOgbKvDtHvBLkrRjLM8Ffaw1vI=;
	b=BmMoWYvoM9LUzNqtUInq+2feL5ZbQ7D4Cm3a3iJE/PIm+D9TaCRJtsAk4we1ZrGYBlaDoD
	XC88qYTTAoT49iAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722418133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xww2KrgmTygSkhqjYmOgbKvDtHvBLkrRjLM8Ffaw1vI=;
	b=uHXUG/ud+yLP3GulJDgZyjAFtOZL37GyTo9PzP0odYPyMQ6xaLycNVEru365CcWF2szoaR
	aeHH7CKQ0hdUKzMbO3/oUjxW/DroUvOUKsFW3Bw8bhcGgO825l4xNpYkxdMz+IvUAg622d
	KPVrZkq8hAk97TbWm/jvcKEu9tJI7AM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722418133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xww2KrgmTygSkhqjYmOgbKvDtHvBLkrRjLM8Ffaw1vI=;
	b=BmMoWYvoM9LUzNqtUInq+2feL5ZbQ7D4Cm3a3iJE/PIm+D9TaCRJtsAk4we1ZrGYBlaDoD
	XC88qYTTAoT49iAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AC311368F;
	Wed, 31 Jul 2024 09:28:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zhM2CNUDqmamGwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 31 Jul 2024 09:28:53 +0000
Date: Wed, 31 Jul 2024 11:29:30 +0200
Message-ID: <87ed79zz7p.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Edmund Raile <edmund.raile@protonmail.com>
Cc: o-takashi@sakamocchi.jp,
	clemens@ladisch.de,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 0/2] ALSA: firewire-lib: restore process context workqueue to prevent deadlock
In-Reply-To: <20240730195318.869840-1-edmund.raile@protonmail.com>
References: <20240730195318.869840-1-edmund.raile@protonmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-0.10 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[protonmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -0.10

On Tue, 30 Jul 2024 21:53:23 +0200,
Edmund Raile wrote:
> 
> This patchset serves to prevent an AB/BA deadlock:
> 
> thread 0:
>     * (lock A) acquire substream lock by
> 	snd_pcm_stream_lock_irq() in
> 	snd_pcm_status64()
>     * (lock B) wait for tasklet to finish by calling
>     	tasklet_unlock_spin_wait() in
> 	tasklet_disable_in_atomic() in
> 	ohci_flush_iso_completions() of ohci.c
> 
> thread 1:
>     * (lock B) enter tasklet
>     * (lock A) attempt to acquire substream lock,
>     	waiting for it to be released:
> 	snd_pcm_stream_lock_irqsave() in
>     	snd_pcm_period_elapsed() in
> 	update_pcm_pointers() in
> 	process_ctx_payloads() in
> 	process_rx_packets() of amdtp-stream.c
> 
> ? tasklet_unlock_spin_wait
>  </NMI>
>  <TASK>
> ohci_flush_iso_completions firewire_ohci
> amdtp_domain_stream_pcm_pointer snd_firewire_lib
> snd_pcm_update_hw_ptr0 snd_pcm
> snd_pcm_status64 snd_pcm
> 
> ? native_queued_spin_lock_slowpath
>  </NMI>
>  <IRQ>
> _raw_spin_lock_irqsave
> snd_pcm_period_elapsed snd_pcm
> process_rx_packets snd_firewire_lib
> irq_target_callback snd_firewire_lib
> handle_it_packet firewire_ohci
> context_tasklet firewire_ohci
> 
> The issue has been reported as a regression of kernel 5.14:
> Link: https://lore.kernel.org/regressions/kwryofzdmjvzkuw6j3clftsxmoolynljztxqwg76hzeo4simnl@jn3eo7pe642q/T/#u
> ("[REGRESSION] ALSA: firewire-lib: snd_pcm_period_elapsed deadlock
> with Fireface 800")
> 
> Commit 7ba5ca32fe6e ("ALSA: firewire-lib: operate for period elapse event
> in process context") removed the process context workqueue from
> amdtp_domain_stream_pcm_pointer() and update_pcm_pointers() to remove
> its overhead.
> Commit b5b519965c4c ("ALSA: firewire-lib: obsolete workqueue for period
> update") belongs to the same patch series and removed
> the now-unused workqueue entirely.
> 
> Though being observed on RME Fireface 800, this issue would affect all
> Firewire audio interfaces using ohci amdtp + pcm streaming.
> 
> ALSA streaming, especially under intensive CPU load will reveal this issue
> the soonest due to issuing more hardIRQs, with time to occurrence ranging
> from 2 secons to 30 minutes after starting playback.
> 
> to reproduce the issue:
> direct ALSA playback to the device:
>   mpv --audio-device=alsa/sysdefault:CARD=Fireface800 Spor-Ignition.flac
> Time to occurrence: 2s to 30m
> Likelihood increased by:
>   - high CPU load
>     stress --cpu $(nproc)
>   - switching between applications via workspaces
>     tested with i915 in Xfce
> PulsaAudio / PipeWire conceal the issue as they run PCM substream
> without period wakeup mode, issuing less hardIRQs.
> 
> Cc: stable@vger.kernel.org
> Backport note:
> Also applies to and fixes on (tested):
> 6.10.2, 6.9.12, 6.6.43, 6.1.102, 5.15.164
> 
> Edmund Raile (2):
>   Revert "ALSA: firewire-lib: obsolete workqueue for period update"
>   Revert "ALSA: firewire-lib: operate for period elapse event in process
>     context"

Applied both patches now.  Thanks.


Takashi

