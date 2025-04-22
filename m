Return-Path: <stable+bounces-135124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1221BA96C05
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 15:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE37E3A5286
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 13:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FC428135E;
	Tue, 22 Apr 2025 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1gbh9z3q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QJff4qRL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1gbh9z3q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QJff4qRL"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05837280CFF
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745327278; cv=none; b=H1y8ohfKO99u/ka/uHnd1P4c+wRPY9WSoy/zqT4rJq0zEQ2mEeVk+Fg/CAbhNjdTchoqw/nuGqmHm8bddbWVT7LBgrOJZ2xcbdx3CM/fGKQs9XYO4XaS1kS44hMUFa7lPRTxyuetrCj1XvSMjnXSPjMtVPQgt71A0se/hxJm7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745327278; c=relaxed/simple;
	bh=7kBwtbcs+yThk/f775lv8ZXMweFAjc26uoxi/vcldRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3KzVN9xo9RTlfX4Umwtx++fnVahLVjsbjS+rmdfY7rbC2BjExL3S/mYmOMf5Q0QAbfFBr1zXmWoieVrH6GTiBajPbLNghYd55X6MM+668wHDLMFwWlcU41vKOwFGitqKqZVgVtiXSeBJHoMnCix4pJGwYhiFeB53PbScjssXMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1gbh9z3q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QJff4qRL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1gbh9z3q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QJff4qRL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2D76F1F38D;
	Tue, 22 Apr 2025 13:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745327275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=459wLOanZpqg4/wTTubPImQcdIHPEf/5eXqSk/5Gj0o=;
	b=1gbh9z3qlJG2bLbA/KBC+kPz6BbahXH8Alv145/rJ/T7i7y7oVPcxeEYpJrKYENtMwOTse
	hxtF87Nm5V09QI3BI2ydKBFJrmXD+MXjHIvvj0JyLhvQ6nnRsScdFXM9BwBcPtWkMMbaHy
	AkOClcSQ98ATwRmRUB54H+naTwel5ZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745327275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=459wLOanZpqg4/wTTubPImQcdIHPEf/5eXqSk/5Gj0o=;
	b=QJff4qRL8Pv5i2LCKHPnHNR5yeWpBvzxH7fJIyIpuAtlF+0a3NlgXyjqrw5PHKFfHAIKKD
	s0MLFtynM1J0xoAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745327275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=459wLOanZpqg4/wTTubPImQcdIHPEf/5eXqSk/5Gj0o=;
	b=1gbh9z3qlJG2bLbA/KBC+kPz6BbahXH8Alv145/rJ/T7i7y7oVPcxeEYpJrKYENtMwOTse
	hxtF87Nm5V09QI3BI2ydKBFJrmXD+MXjHIvvj0JyLhvQ6nnRsScdFXM9BwBcPtWkMMbaHy
	AkOClcSQ98ATwRmRUB54H+naTwel5ZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745327275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=459wLOanZpqg4/wTTubPImQcdIHPEf/5eXqSk/5Gj0o=;
	b=QJff4qRL8Pv5i2LCKHPnHNR5yeWpBvzxH7fJIyIpuAtlF+0a3NlgXyjqrw5PHKFfHAIKKD
	s0MLFtynM1J0xoAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04B2E137CF;
	Tue, 22 Apr 2025 13:07:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Si7UAKuUB2g/MQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 22 Apr 2025 13:07:55 +0000
Message-ID: <a7cf9864-6810-43d8-a7f6-f71cc1ee081c@suse.cz>
Date: Tue, 22 Apr 2025 15:07:54 +0200
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
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Ryo Takakura <ryotkkr98@gmail.com>, alex@ghiti.fr, aou@eecs.berkeley.edu,
 bigeasy@linutronix.de, conor.dooley@microchip.com, jirislaby@kernel.org,
 john.ogness@linutronix.de, palmer@dabbelt.com, paul.walmsley@sifive.com,
 pmladek@suse.com, samuel.holland@sifive.com, u.kleine-koenig@baylibre.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-serial@vger.kernel.org, stable@vger.kernel.org
References: <20250405043833.397020-1-ryotkkr98@gmail.com>
 <20250405044338.397237-1-ryotkkr98@gmail.com>
 <2025040553-video-declared-7d54@gregkh>
 <397723b7-9f04-4cb1-b718-2396ea9d1b91@suse.cz>
 <2025042202-compare-entrap-0089@gregkh>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <2025042202-compare-entrap-0089@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ghiti.fr,eecs.berkeley.edu,linutronix.de,microchip.com,kernel.org,dabbelt.com,sifive.com,suse.com,baylibre.com,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 4/22/25 12:50, Greg KH wrote:
> On Tue, Apr 22, 2025 at 12:20:42PM +0200, Vlastimil Babka wrote:
>> 
>> I admit it's surprising to see such a request as AFAIK it's normally done to
>> mix stable fixes and new features in the same series (especially when the
>> patches depend on each other), and ordering the fixes first and marking only
>> them as stable should be sufficient. We do that all the time in -mm. I
>> thought that stable works with stable marked commits primarily, not series?
> 
> Yes, but when picking which "branch" to apply a series to, what would
> you do if you have some "fix some bugs, then add some new features" in a
> single patch series?  The one to go to -final or the one for the next
> -rc1?

As a maintainer I could split it myself.

> I see a lot of bugfixes delayed until -rc1 because of this issue, and
> it's really not a good idea at all.

In my experience, most of the time these fixes are created because a dev:

- works on the code to implement the feature part
- while working at the code, spots an existing bug
- the bug can be old (Fixes: commit a number of releases ago)
- wants to be helpful so isolates the fix separately as an early patch of
the series and marks stable because the bug can be serious enough in theory
- at the same time there are no known reports of the bug being hit in the wild

In that case I don't see the urgency to fix it ASAP (unless it's e.g.
something obviously dangerously exploitable) so it might not be such a bad
idea just to put everything towards next rc1.

This very thread seems to be a good example of the above. I see the later
version added a
Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
which is a v5.2 commit.

Thanks,
Vlastimil

>> Also since the patches are AFAIU dependent on each other, sending them
>> separately makes the mainline development process more difficult, as
>> evidenced by the later revisions having to add notes in the diffstat area
>> etc. This would go against the goal that stable process does not add extra
>> burden to the mainline process, no?
> 
> If they are dependent on each other, that's the creator's issue, not the
> maintainer's issue, no?  :)
> 
> Submit the bug fixes, get them merged, and then submit the new features.
> 
> thanks,
> 
> greg k-h


