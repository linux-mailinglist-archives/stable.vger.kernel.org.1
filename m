Return-Path: <stable+bounces-254078-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDggNdfkE2rhHAcAu9opvQ
	(envelope-from <stable+bounces-254078-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 07:57:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AB25C61C2
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 07:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56BFC3031305
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 05:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C915735F176;
	Mon, 25 May 2026 05:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ScWi9n3U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9538A231829;
	Mon, 25 May 2026 05:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779688621; cv=none; b=jEeiPVR01AtNUsBX85fV0iO6ZVTfJXhFk6ghyMSDQwOCcfFgpu5qU5yh9HNYaAtBHZa8yb2nCj4HLIf07SQi69erogdy7flC+bsoS5mnQkHRvlK7CT/ffGmqGOkMMbCSX9Evn32Se04aljbHD/LBRzvPYxPKBYn1PWJr7/Qg7S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779688621; c=relaxed/simple;
	bh=wZb4x/+jKWgIHXP8TMoLtT+vRqL37/1HO8tDIr6IwZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVdURkhbFd0iQV9UNakkCmrbRi1uBvyvT8cm16CkvoWCApGkVfC0brvZxCG/yo741MBS94EuyNddVXCbnx5ZUUbANR6F/Xn22byMPy58S1YkKfGT4DoRMk1vSDViHp29gdTFG6Po1CR2E7DvVHL9FlOPko7Spf6ceJbSTOkY/H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ScWi9n3U; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88961F000E9;
	Mon, 25 May 2026 05:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779688620;
	bh=DY2ehnCEyY61qDirHApJdL305WYU68zGn1Hu+Qqf7qI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ScWi9n3UbjAdbw+xbLONhVpDkmdj2uRblt9jHFNDZXj2r4tnxqYuc3H+JGNVU9PSi
	 IKTmfo9vhUHt8NTO1M+1O9Dbhj29DSXk5lgJhxErgu/gtjrVMB3GDJ3JF7pg3UPJa+
	 l9n2csx2MIFFlKO/+SyGgSegr5yAANlayDChPmBU=
Date: Mon, 25 May 2026 07:56:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Adrian Korwel <adriank20047@gmail.com>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_uac1_legacy: fix use-after-free in
 gaudio_open_snd_dev()
Message-ID: <2026052528-resupply-fanatic-496a@gregkh>
References: <CADgB2mFBdTbad5+W=bDOMO+fe1S4jg+aCNjkgd3B3Guq0WFQdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADgB2mFBdTbad5+W=bDOMO+fe1S4jg+aCNjkgd3B3Guq0WFQdw@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254078-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.957];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 84AB25C61C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 11:33:21PM -0500, Adrian Korwel wrote:
> Three bugs exist in this driver related to ALSA device file lifetime:
> 
> 1. gaudio_open_snd_dev() opens the ALSA control file first, then the
>    PCM playback file. If filp_open() for playback fails, the function
>    returns without closing the already-opened control file handle.
> 
> 2. playback_default_hw_params() return value was ignored. If it fails,
>    both the control and playback file handles are leaked, causing
>    gaudio_cleanup() to call filp_close() on already-freed file objects.
> 
> 3. f_audio_bind() guards gaudio_setup() with an 'audio_opts->bound'
>    flag to prevent re-initialization, but the fail: error path
>    unconditionally calls gaudio_cleanup(). On repeated bind attempts
>    after failure, this closes file handles that were opened in a
>    previous bind invocation and already freed by RCU, causing a
>    use-after-free detected by KASAN:
> 
>    BUG: KASAN: slab-use-after-free in filp_flush+0x23/0x1b0
>    Read of size 8 at addr ffff88810d5523a8 by task bash/306
>    ...
>    gaudio_cleanup+0x59/0x100
>    f_audio_bind+0x4b0/0x590
> 
> Fix all three issues:
> - Close already-opened file handles on each error path in
>   gaudio_open_snd_dev().
> - Check and propagate the return value of playback_default_hw_params().
> - Remove the 'bound' guard and call gaudio_setup() unconditionally in
>   f_audio_bind(), making setup and cleanup a matched pair within each
>   bind invocation. Remove the now-unused 'bound' field from the opts
>   struct.

Why is this not broken up into smaller patches to corrispond with each
issue/fix?  Please do so.


> 
> Additionally, f_audio_disable() was an empty stub. Add
> cancel_work_sync() to ensure the playback work item is not in flight
> when the function is unbound and the audio struct is freed.
> 
> Changes since v1:
> - Added removal of the 'bound' guard in f_audio_bind() which was the
>   root cause of the repeated-bind UAF
> - Added cancel_work_sync() to f_audio_disable()
> - Removed now-unused 'bound' field from struct f_uac1_legacy_opts

The "changes" go below the --- line, right?

thanks,

greg k-h

