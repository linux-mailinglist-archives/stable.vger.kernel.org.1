Return-Path: <stable+bounces-256581-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMgrA/VhGWrDvwgAu9opvQ
	(envelope-from <stable+bounces-256581-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:52:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 781266003C0
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D4233015473
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 09:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DCB3BD62E;
	Fri, 29 May 2026 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="D5cQBJ29"
X-Original-To: stable@vger.kernel.org
Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E89385D60;
	Fri, 29 May 2026 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048224; cv=none; b=s5C0Ios+Q+AVvCz/EdwvjeGXgcHyDxtJbGYVazuQOUvSsCFtYDMoMtVNoOZcc5g0aH1Cqd1X2Uc9JZgw3eKRiqF6oJ2zo7VLppfiCIfKhknXh8+eCRRKAW7L25zxmjLBKbJXN4mV2b3WF836RXmIe+S0eegm20REa+oOUIyd+Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048224; c=relaxed/simple;
	bh=nQhEEJC7UiBSk+EjxGg14ByJ7Sa+/PNen/fIZQlXYJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4hNwlQNLQcncC3/y4KLTu8hrygcmg9jjPaYCnYdnsZnoI8WiNoEBnv7yIGikISBwhWHk7KgTYYK9rvJNWpqQaeOpMRqn3aiK4Lqs4Eeqp//DAqgrxjXx+vyeGiNx0e380jxkkdNygfCFUFCKe86MG3buOR3/CYWTn1/B97gzUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=D5cQBJ29; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1780048220;
	bh=nQhEEJC7UiBSk+EjxGg14ByJ7Sa+/PNen/fIZQlXYJ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D5cQBJ295FX/kz8ZSMxTRJ6szEjP1/q59dWdJTQatz4CKMniWu6veA2lHdMJ62wn/
	 P2mICAsVqXkLrLL1FZn/XAbvFKLhqdicaxPJAYFD81gRg0/IG+ME1PR7YWXf1gAYSi
	 +8XsyKSrsZbZjsMBSMIJT9IdqAnVftv0j/vVclLbGjqzJ/mLBTQBne2uYalLiZDDdf
	 44N065p5Adab47o+f1uOhmBeWE5BfLEGZ2JApxKGz4K95/XL7l7+45CE+LfYQ4sjr6
	 BZyUbaZyaeoJAPSukU+ZM6NoY6EyEP3amGUkg8GSaE7gcGLRIov3ltt3YhjDq88MMW
	 mlUhrEmaxwrVA==
Message-ID: <2023cf0e-85a8-4128-857d-cae806ff0e58@lankhorst.se>
Date: Fri, 29 May 2026 11:50:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/audio: use generic_handle_irq_safe() for LPE
 audio irq
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, clrkwllms@kernel.org, rostedt@goodmis.org,
 jerome.anand@intel.com, pierre-louis.bossart@linux.dev, tiwai@suse.de,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, jianhao.xu@seu.edu.cn, stable@vger.kernel.org
References: <20260528154551.3708290-1-runyu.xiao@seu.edu.cn>
 <20260529074816.k1K16jyy@linutronix.de>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260529074816.k1K16jyy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lankhorst.se,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lankhorst.se:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256581-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,kernel.org,goodmis.org,linux.dev,suse.de,lists.freedesktop.org,vger.kernel.org,lists.linux.dev,seu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@lankhorst.se,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[lankhorst.se:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lankhorst.se:mid,lankhorst.se:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 781266003C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hey,

Den 2026-05-29 kl. 09:48, skrev Sebastian Andrzej Siewior:
> On 2026-05-28 23:45:51 [+0800], Runyu Xiao wrote:
>> intel_lpe_audio_irq_handler() forwards the LPE audio child IRQ from the
>> i915 parent IRQ path with generic_handle_irq(). The forwarded child top
>> half is not an independent hardirq entry point; it inherits the context
>> of the outer i915 interrupt dispatch path.
> …
> 
> This looks very familiar and is work in progress
> 	https://lore.kernel.org/all/20260310115709.2276203-16-dev@lankhorst.se/
> 
> Maarten, where do we stand on the i915 series?
> 
>> Fixes: eef57324d926 ("drm/i915: setup bridge for HDMI LPE audio driver")
>> Cc: stable@vger.kernel.org
> 
> No stable fix needed because i915 can not be turned on PREEMPT_RT.
> 
> Sebastian

It's been absolutely rock stable since the last time I submitted it.
I've been using it on my local machine, and the amount of times >100us
(evasion failed) with and without PREEMPT_RT are identical with
the vblank changes.
It still applies cleanly when rebasing.

The vblank patches are the most involved change, and they ensure that
absolutely no lock contention happens in the critical path with irqs off.

Unfortunately the status is still same as the time I submitted it before it,
and pending reviews on the series.

Kind regards,
~Maarten Lankhorst

