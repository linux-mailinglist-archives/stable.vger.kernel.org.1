Return-Path: <stable+bounces-144508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861AAAB843B
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 12:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C42C1771C5
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 10:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D67D2101AE;
	Thu, 15 May 2025 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vNRy2TM0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RdBJqzYs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n4KPlRid";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z13MK/ZY"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA891F5425
	for <stable@vger.kernel.org>; Thu, 15 May 2025 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747306000; cv=none; b=Fn+fROva6srpm/9nJ9Tl4lOopyI15dvip3kCCsg/j6IuEMi0VPKMR91kMN5QqioGVETGFCSIAPVSpjh2+BzjzebDjfyHCMbBOnnjqbI4cRvpTAHNIJX7tLkTzfUw7U46akTZvxb950fQ6N2ixDu7pWwy0Rb0oBeafXbjz2R9tE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747306000; c=relaxed/simple;
	bh=uSC3FoTK1qaBjKKoRPvmW8tbiie4H0XvqOQUs2s/3ys=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKXYxsHuo8IhBJ03FfxCMxfa6awHULSYMMYAMCHmpYefCBp0Nbeud1eughvXnUc9qJVFJPBjpu3yDPoVANlmJno3DQ5hGPSaEZXHxqOH1H8XnXSI0hvoWImp0xLSLU0hnFcXw3QzoGu+HGuamqhBYEP5fnC6HfHhEAFqfiMtXf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vNRy2TM0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RdBJqzYs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n4KPlRid; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z13MK/ZY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 754A81F6E6;
	Thu, 15 May 2025 10:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747305996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ESAwA4r7a1Fm6MOy9EpWBEBZFQFWv8V+lGLSeLMan4E=;
	b=vNRy2TM0g/sqcPHd4XgvJXZ3gBFm7L0bS0kOIPrc5u6U7IJtgZq7SCoE3+QvwZW4x6QqAV
	fS6mlxcPazf4F8FuxNvftzcHuIPQGa8AV9K/SHjWYjWBSoncy0qnVNtWFhNW3GWjMjy5Bj
	qGP+A+pH7ZrVL3rIFB/f9/E/ASYJMG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747305996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ESAwA4r7a1Fm6MOy9EpWBEBZFQFWv8V+lGLSeLMan4E=;
	b=RdBJqzYsNvFURU0/G0XfSOuja+M2VtR+zBffepSdgHjr/8dRtSvBzHX+BbxMDJA7CeSh79
	ugL9i34/AyFWM+AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=n4KPlRid;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="z13MK/ZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747305995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ESAwA4r7a1Fm6MOy9EpWBEBZFQFWv8V+lGLSeLMan4E=;
	b=n4KPlRid6ZmQ4M6D1PoznN/xv6+1+BQEwZrrO8EtKvzOUHVu0Pzn4jXojPKXD6wRhUg61G
	q7gA8RS3tF3wdg7ScTzJel/Bi3dQPCWhITQ7wZVG0VuJiBkSSzDIF3lMtbWOtonKdeEg0L
	A0vXFq3dUTolaDM+ihM9bRQ+fNl6Uuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747305995;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ESAwA4r7a1Fm6MOy9EpWBEBZFQFWv8V+lGLSeLMan4E=;
	b=z13MK/ZY5w8iw8L4TYj23tqkaYa2gdj7qII/qKUuF28Ke2nTJ93YRRkUEgNTAVPqI7Bkyw
	ZDhTeeKi/S4xVeAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A596137E8;
	Thu, 15 May 2025 10:46:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xvu7EAvGJWhQZwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 15 May 2025 10:46:35 +0000
Date: Thu, 15 May 2025 12:46:34 +0200
Message-ID: <87o6vurw1h.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Nicolas Chauvet <kwizart@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Add sample rate quirk for Microdia JP001 USB Camera
In-Reply-To: <20250515102132.73062-1-kwizart@gmail.com>
References: <20250515102132.73062-1-kwizart@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 754A81F6E6
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.51

On Thu, 15 May 2025 12:21:32 +0200,
Nicolas Chauvet wrote:
> 
> Microdia JP001 does not support reading the sample rate which leads to
> many lines of "cannot get freq at ep 0x84".
> This patch adds the USB ID to quirks.c and avoids those error messages.
> 
> usb 7-4: New USB device found, idVendor=0c45, idProduct=636b, bcdDevice= 1.00
> usb 7-4: New USB device strings: Mfr=2, Product=1, SerialNumber=3
> usb 7-4: Product: JP001
> usb 7-4: Manufacturer: JP001
> usb 7-4: SerialNumber: JP001
> usb 7-4: 3:1: cannot get freq at ep 0x84
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>

Applied now.  Thanks.


Takashi

