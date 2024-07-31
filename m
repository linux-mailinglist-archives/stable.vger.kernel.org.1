Return-Path: <stable+bounces-64728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FCD9429B7
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 10:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53B828498A
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 08:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD6A1A8BF2;
	Wed, 31 Jul 2024 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="vjwe8mSv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PJAcPdRB"
X-Original-To: stable@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487431A6166;
	Wed, 31 Jul 2024 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722416122; cv=none; b=cssGWK4oJeNzCQ1Cng91OS7gVzz/Y8aBQY+RaGnmA28UOtis+MHs7OPeJmANYgtbAbkkShyxl0cQqXYD2hbJjl9pjHCDs+Ma7uewDaGtHDzDk/j0aF/i+B/MxtWTtpwThFdxpstYPzTeLQ7Gpr/H/Ptf3KtotGkKWucxyNx3pXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722416122; c=relaxed/simple;
	bh=8NDiRi+10y1SIiwdA08fsiT9dMy1pZL4V0pvzaA2upM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tExvviyNQ5JsRSRWUy8nAnuTW7NYYYZsKqP5hr2K7aA730wCGtdh0b+1xGKqEQOcMxmD54ZOjflkDb5orUFCCIsKGkv6hnTynmTeqVUDAzoWSbIcrv4NnadFHBfuoDFeBak2bLZJJQ+NZcvO7/C4P3l2vwRlN0kuIwCnHaiW2fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=vjwe8mSv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PJAcPdRB; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 413BF1146E77;
	Wed, 31 Jul 2024 04:55:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 31 Jul 2024 04:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722416118; x=
	1722502518; bh=vMA1vQSN5FVF2YHU0BsfEBv1ul6npqCvlOna7cdXU68=; b=v
	jwe8mSv0zUGv4/spZMeApZen8UkYHRlA8UBwdkjwctoKNuN/887G4GFOX/uCMfEF
	+Y+C63ZPqGql4AaNDdwaPjvJb5Arv/tzF9imYrIjfLU7bIz8dlme8AIgQYyueVHT
	69VF3K4yoWfB290FHsBqWbYD+IOzMUMUs5Jyyz6vnCHGZevNrNCbyH/ug6abD0mo
	fxb8+PmOiXtORHWoUyXSBsTWa+svEO2HrKQ84PtqE6ey8wI5Zo9wveHVp6hpNvlX
	rxLzNqKHzMKWgLLE5yAAlAx+X3n8UlBZHcFwptK19NCnKDvk2Yx62ZnL3nEYPGNo
	t1UpBC1ie5z0kixF9mfGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722416118; x=1722502518; bh=vMA1vQSN5FVF2YHU0BsfEBv1ul6n
	pqCvlOna7cdXU68=; b=PJAcPdRBhmPdTUwxnWmSXdcRfVnUHmouVeGK3Q+CD6jw
	D/INn9D67J0Vd1DPVrW4/Fqfbq9j94yI9LpND4LwF2uCwXP7txH5m0i52XXWu4GQ
	u48Cp+0yjVWjp2k6DIDOE1hZ236LhZSCB3u72rlAUtloL8E3tRHbRfjnqsk6rkSe
	B+pFyCZ9QvOkQHhUKJOddWs02+mw/TdJC3WzDc+RIl15fBRec6wVNRrFvV/odqCB
	B+moTNe4XOrfvH1DtFwDgEezj3x75bEoqWdN3IO0ZDT3CSAA6hZoyMFx7kCw7luS
	jJ3c2NZ3tqynspQqmoJy1iXzYP2a9UcP5BtJtfgTlw==
X-ME-Sender: <xms:9vupZpugOml6e-n6jUR5ZHq4_nYeaAD3gFntlVAvBPyA_Rs0NSXEaw>
    <xme:9vupZifAGzu-ToorjKNDGV8UPhd9dMSE9x4yNmfvAGSmDWE9cG5yG7WkvL3gys-kb
    9Z-6NXDI96aFNGP6wA>
X-ME-Received: <xmr:9vupZswyyAbUXCSf_qp-u_j3pWQFFtViodkXYEWyWBtpL5IhGpM6wAedqaCp-QN_BYOXrBbtdbZgR9ASwJRt8bJQDRqlb-YRsBZi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeevieelhfdukeffheekffduudevvdefudelleefgeei
    leejheejuedvgefhteevvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:9vupZgNV1MHx1mQds3-bI0YN9YmPNq4w9Rhl0gA0mv4sUP-oNI59Dw>
    <xmx:9vupZp-o0IBuwb5l-8pOYovM59Ti7W0WCoj0Ev3gzd6mOYI8RANfhA>
    <xmx:9vupZgVC0SUJCRXaMgKgz-RutyMANAiagjNIUe7SRUtLl79pGGZttA>
    <xmx:9vupZqcro8ARq1ervbWOEsrXcZ9kUQ9e_gcJac_fOhT-hrTBLtODSA>
    <xmx:9vupZskm9tid2OVvRMc9J9gpR1yCioPVACDDTwQZpaB1ZVhmtYJ8Lb-X>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 04:55:16 -0400 (EDT)
Date: Wed, 31 Jul 2024 17:55:14 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Edmund Raile <edmund.raile@protonmail.com>
Cc: tiwai@suse.com, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 0/2] ALSA: firewire-lib: restore process context
 workqueue to prevent deadlock
Message-ID: <20240731085514.GA215770@workstation.local>
Mail-Followup-To: Edmund Raile <edmund.raile@protonmail.com>,
	tiwai@suse.com, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, stable@vger.kernel.org
References: <20240730195318.869840-1-edmund.raile@protonmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730195318.869840-1-edmund.raile@protonmail.com>

Hi,

On Tue, Jul 30, 2024 at 07:53:23PM +0000, Edmund Raile wrote:
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
> 
>  sound/firewire/amdtp-stream.c | 38 ++++++++++++++++++++++-------------
>  sound/firewire/amdtp-stream.h |  1 +
>  2 files changed, 25 insertions(+), 14 deletions(-)

They look good to me.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

I appreciate your long effort to solve the issue.


Thanks

Takashi Sakamoto

