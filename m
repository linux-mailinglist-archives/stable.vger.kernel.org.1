Return-Path: <stable+bounces-135081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B55A965BC
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 12:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE807A54B0
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 10:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D50213E6A;
	Tue, 22 Apr 2025 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N5AgF1e6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="91hkOtyt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N5AgF1e6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="91hkOtyt"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9460E20DD7D
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745317246; cv=none; b=nDkhqkYz6d33XuwY30xzhVLkXJwkbSmYPaRjMHWPS/HXo73AqTDjZXr43m2ohav5Sx0C27RGATtfw+mlCB5fP28S3ryM4RYcUXs9ByDJAvEix47VetGgWmVDo8P62M4jdyaKNRGG7tduoh6PuGu9tRbUwmbBsJLQ4OKUJBSBfOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745317246; c=relaxed/simple;
	bh=WA25M38AIR7ERueYwyzSBDmn05s7qtY/5PnKWB5/mWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+YyQQEFRld/rp1iWQ+siNYVijx00McSJV+yo0eWSDEob4vFF/DfvUkZ37Iuws6WOjoXlHiKj2aECPgyu1D7dWDO8OzKkV1kpdstuvrf4Et0cBTR9hJbZwmiiXqEGSOu9YQ2ivIG4isNYJeO2h7Vx7SCzgPBU/+WwKcYlR65LE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N5AgF1e6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=91hkOtyt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N5AgF1e6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=91hkOtyt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CDFD9211B4;
	Tue, 22 Apr 2025 10:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745317242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3D2poOov/3bFYZAbueXXC8mWTQq1cPjBbaHqWB5PKcc=;
	b=N5AgF1e6ldYFh8sXthel/HoK/0Po6kGmLJrOaJJ+EAGLxiF8vWxU1purTfHnO3ouwDC7gq
	6Mj0iefMkI+oRyEMXvxKu3euVEYFEIXCi5v1GGvaWGRXuiyo7aO9zmyDuhvwm5/dtJjNDc
	Pklr7S8xWhAvChkT7P67xlTTzLw9tv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745317242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3D2poOov/3bFYZAbueXXC8mWTQq1cPjBbaHqWB5PKcc=;
	b=91hkOtytm9qKMrfBYv+ryJG1RdH4MbBnBYifI/Q3l8TIL6qbykLxHma6bunJj5EyKYegQ3
	U0+QWc9WOpN0yiDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745317242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3D2poOov/3bFYZAbueXXC8mWTQq1cPjBbaHqWB5PKcc=;
	b=N5AgF1e6ldYFh8sXthel/HoK/0Po6kGmLJrOaJJ+EAGLxiF8vWxU1purTfHnO3ouwDC7gq
	6Mj0iefMkI+oRyEMXvxKu3euVEYFEIXCi5v1GGvaWGRXuiyo7aO9zmyDuhvwm5/dtJjNDc
	Pklr7S8xWhAvChkT7P67xlTTzLw9tv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745317242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3D2poOov/3bFYZAbueXXC8mWTQq1cPjBbaHqWB5PKcc=;
	b=91hkOtytm9qKMrfBYv+ryJG1RdH4MbBnBYifI/Q3l8TIL6qbykLxHma6bunJj5EyKYegQ3
	U0+QWc9WOpN0yiDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9715F137CF;
	Tue, 22 Apr 2025 10:20:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g6qTJHptB2i4dQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 22 Apr 2025 10:20:42 +0000
Message-ID: <397723b7-9f04-4cb1-b718-2396ea9d1b91@suse.cz>
Date: Tue, 22 Apr 2025 12:20:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] serial: sifive: lock port in startup()/shutdown()
 callbacks
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>, Ryo Takakura <ryotkkr98@gmail.com>
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, bigeasy@linutronix.de,
 conor.dooley@microchip.com, jirislaby@kernel.org, john.ogness@linutronix.de,
 palmer@dabbelt.com, paul.walmsley@sifive.com, pmladek@suse.com,
 samuel.holland@sifive.com, u.kleine-koenig@baylibre.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-serial@vger.kernel.org, stable@vger.kernel.org
References: <20250405043833.397020-1-ryotkkr98@gmail.com>
 <20250405044338.397237-1-ryotkkr98@gmail.com>
 <2025040553-video-declared-7d54@gregkh>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <2025040553-video-declared-7d54@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 4/5/25 09:35, Greg KH wrote:
> On Sat, Apr 05, 2025 at 01:43:38PM +0900, Ryo Takakura wrote:
>> startup()/shutdown() callbacks access SIFIVE_SERIAL_IE_OFFS.
>> The register is also accessed from write() callback.
>> 
>> If console were printing and startup()/shutdown() callback
>> gets called, its access to the register could be overwritten.
>> 
>> Add port->lock to startup()/shutdown() callbacks to make sure
>> their access to SIFIVE_SERIAL_IE_OFFS is synchronized against
>> write() callback.
>> 
>> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
>> Cc: stable@vger.kernel.org
> 
> What commit id does this fix?

> Why does patch 1/2 need to go to stable, but patch 2/2 does not?  Please
> do not mix changes like this in the same series, otherwise we have to
> split them up manually when we apply them to the different branches,
> right?

I admit it's surprising to see such a request as AFAIK it's normally done to
mix stable fixes and new features in the same series (especially when the
patches depend on each other), and ordering the fixes first and marking only
them as stable should be sufficient. We do that all the time in -mm. I
thought that stable works with stable marked commits primarily, not series?

Also since the patches are AFAIU dependent on each other, sending them
separately makes the mainline development process more difficult, as
evidenced by the later revisions having to add notes in the diffstat area
etc. This would go against the goal that stable process does not add extra
burden to the mainline process, no?

Thanks,
Vlastimil

> thanks,
> 
> greg k-h

