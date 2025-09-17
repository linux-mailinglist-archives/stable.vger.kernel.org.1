Return-Path: <stable+bounces-180418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3D7B80C2C
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 17:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 376087BD9CB
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE1A2FAC06;
	Wed, 17 Sep 2025 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZxCiBCFb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ApZ95ZUh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZxCiBCFb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ApZ95ZUh"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DEB341373
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124041; cv=none; b=IJpSedg9w525Y5yzteyUU8LPOlqgFQlyHQlSW6SEYeK7oemZTtaDUdgDeNJL77cmy5e0VR38kM1rm4vMtoM9atb0+Oa1nXgNuGpMynM7B3edr6eeZEYEOqsgycnGk3DpS9vciRdbnaYLqS3WgGLq//iedvbNMVDC4qjc0ZhtEuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124041; c=relaxed/simple;
	bh=cttM0v4zr5UNmhmHqv5SD5wQCkXQF56FU/HufKxbH78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkKWqdijGlcaFpNSUfi+xSWXUxR+q4tzB3PH0HB2CH4aybrDTEUclKaEE55cSB//3wdSZNuGEGt9uqUnhtr16WzEy0g1Y4QeBkgA9RhrxgFhyMpxqpPDzKhpUzWKYPkGEkYPIlR93XbPMFe8TDVuZWwOSAmYFWEXzc5xf28EHL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZxCiBCFb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ApZ95ZUh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZxCiBCFb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ApZ95ZUh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7298133A8E;
	Wed, 17 Sep 2025 15:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758124037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ObyAi+/F9+MMCsMrv10KnpuSCq3LxR/g0Z6JsD2IEsk=;
	b=ZxCiBCFbUGn/1SfPra2LEUQc0PkfdqM6bTEdP1p9HGlL+swm77EvWXfsfmiMz/APHEBt2M
	jzSQIcaSaibsxiGPblZjcv7ejxpHSKc/vbARNuRyoCkpM7l/QZr6QWXYPcMAQlVsJdlKlJ
	RKu/6P2eq03iV6HZxBLeE38gDjiIEoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758124037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ObyAi+/F9+MMCsMrv10KnpuSCq3LxR/g0Z6JsD2IEsk=;
	b=ApZ95ZUhdS1WG7O0c2snLsxvNvIYIGU5mkOjVSpGMxWJsmlTcN0u8K5OEFsfFabWFdBzXc
	6E12gs4kNlVMfyCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758124037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ObyAi+/F9+MMCsMrv10KnpuSCq3LxR/g0Z6JsD2IEsk=;
	b=ZxCiBCFbUGn/1SfPra2LEUQc0PkfdqM6bTEdP1p9HGlL+swm77EvWXfsfmiMz/APHEBt2M
	jzSQIcaSaibsxiGPblZjcv7ejxpHSKc/vbARNuRyoCkpM7l/QZr6QWXYPcMAQlVsJdlKlJ
	RKu/6P2eq03iV6HZxBLeE38gDjiIEoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758124037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ObyAi+/F9+MMCsMrv10KnpuSCq3LxR/g0Z6JsD2IEsk=;
	b=ApZ95ZUhdS1WG7O0c2snLsxvNvIYIGU5mkOjVSpGMxWJsmlTcN0u8K5OEFsfFabWFdBzXc
	6E12gs4kNlVMfyCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65541137C3;
	Wed, 17 Sep 2025 15:47:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cYB1GAXYymjqJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Sep 2025 15:47:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 09F81A083B; Wed, 17 Sep 2025 17:47:17 +0200 (CEST)
Date: Wed, 17 Sep 2025 17:47:16 +0200
From: Jan Kara <jack@suse.cz>
To: Eric Hagberg <ehagberg@janestreet.com>
Cc: Jan Kara <jack@suse.cz>, stable@vger.kernel.org
Subject: Re: "loop: Avoid updating block size under exclusive owner" breaks
 on 6.6.103
Message-ID: <oqe6w7pmfwzzxaqyaebdzrfi63atoudeaayvebmnemngum4vmi@dwd6d4cs3blx>
References: <CAAH4uRA=wJ1W65PUYpv=bdGFdfvXp7BFEg+=F1g3w-JFRrbpBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH4uRA=wJ1W65PUYpv=bdGFdfvXp7BFEg+=F1g3w-JFRrbpBw@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed 17-09-25 11:18:50, Eric Hagberg wrote:
> I stumbled across a problem where the 6.6.103 kernel will fail when
> running the ioctl_loop06 test from the LTP test suite... and worse
> than failing the test, it leaves the system in a state where you can't
> run "losetup -a" again because the /dev/loopN device that the test
> created and failed the test on... hangs in a LOOP_GET_STATUS64 ioctl.
> 
> It also leaves the system in a state where you can't re-kexec into a
> copy of the kernel as it gets completely hung at the point where it
> says "starting Reboot via kexec"...

Thanks for the report! Please report issues with stable kernels to
stable@vger.kernel.org (CCed now) because they can act on them.

> If I revert just that patch from 6.6.103 (or newer) kernels, then the
> test succeeds and doesn't leave the host in a bad state. The patch
> applied to 6.12 doesn't cause this problem, but I also see that there
> are quite a few other changes to the loop subsystem in 6.12 that never
> made it to 6.6.
> 
> For now, I'll probably just revert your patch in my 6.6 kernel builds,
> but I wouldn't be surprised if others stumble across this issue as
> well, so maybe it should be reverted or fixed some other way.

Yes, I think revert from 6.6 stable kernel is warranted (unless somebody
has time to figure out what else is missing to make the patch work with
that stable branch).

							Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

