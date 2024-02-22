Return-Path: <stable+bounces-23355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A9D85FC87
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 16:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C563F1F25D58
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706ED14C5B5;
	Thu, 22 Feb 2024 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PCvJXAJX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kleUI2Q5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PCvJXAJX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kleUI2Q5"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9383D97D
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616224; cv=none; b=CgWWss64TZtlmefWnfjIX1h+1AN+4jDk+VCHkx8i6M05/8qT3hVsRjteOT2LtN6KQ+C4f0OHuGXfVHUG6pyR+IrphIXyWToT3S6QJgoHjjrowU2YDWrqW2oU6Y05xgX10TUlcFd6zKBjQbRMlSo1CRr8mvE8rrjxGcHYk/BN/f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616224; c=relaxed/simple;
	bh=RvhPjI+1rz608SV6a47x8gqZr8gALKkQ6bqKvved3AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kz7KdGQNsDZVOa+ufc7Y/me064dHoPFMAm8NqeQIcrZ4KeCDmmnBDxgtG/ZKlX/nIHtIw2NZrQIMNsn1/V9tCG6Ga18+/Cv13GPVnEnC/+DG9/MdwKVetfftNnuUsz2OJnGfcCmrYj+Wb4V7S39T/FZpU/7z/HIIgRSTeSEBjJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PCvJXAJX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kleUI2Q5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PCvJXAJX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kleUI2Q5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C1B8B22193;
	Thu, 22 Feb 2024 15:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708616220;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvdshU2P1qZyGomav2zf9h5nIDF5pqmVtpSU9Xs+wiY=;
	b=PCvJXAJXiqu6Cc00kQgohChQVzToUkxInq8JVsB03ccVDV0Qe6ZJsjxT8sTH/CYCTXfdo7
	44u9OKX2wXgMqGPQTW54sS904xxcwVXECaQQjel77hfStD/AjcTTPo77elBDcQ0894MKio
	nzm+ZjjEVfiCSa333q32B5Y1dDPCDAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708616220;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvdshU2P1qZyGomav2zf9h5nIDF5pqmVtpSU9Xs+wiY=;
	b=kleUI2Q5dAG4KhfbaBTqdoYemyxD5bY4+cdO7Zd5wBY2G+M9aQ/xlgflLhY1lAfSuWKt8B
	piKckZ2NOt7wRwBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708616220;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvdshU2P1qZyGomav2zf9h5nIDF5pqmVtpSU9Xs+wiY=;
	b=PCvJXAJXiqu6Cc00kQgohChQVzToUkxInq8JVsB03ccVDV0Qe6ZJsjxT8sTH/CYCTXfdo7
	44u9OKX2wXgMqGPQTW54sS904xxcwVXECaQQjel77hfStD/AjcTTPo77elBDcQ0894MKio
	nzm+ZjjEVfiCSa333q32B5Y1dDPCDAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708616220;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvdshU2P1qZyGomav2zf9h5nIDF5pqmVtpSU9Xs+wiY=;
	b=kleUI2Q5dAG4KhfbaBTqdoYemyxD5bY4+cdO7Zd5wBY2G+M9aQ/xlgflLhY1lAfSuWKt8B
	piKckZ2NOt7wRwBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C98413A6B;
	Thu, 22 Feb 2024 15:37:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id MguaHBxq12XpcwAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Thu, 22 Feb 2024 15:37:00 +0000
Date: Thu, 22 Feb 2024 16:36:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, Cyril Hrubis <chrubis@suse.cz>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] sched/rt fixes for 5.15, 5.10, 5.4
Message-ID: <20240222153650.GA1366077@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240222151333.1364818-1-pvorel@suse.cz>
 <20240222151333.1364818-5-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222151333.1364818-5-pvorel@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[41.66%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.70

Hi all,

> Cyril Hrubis (3):
>   sched/rt: Fix sysctl_sched_rr_timeslice intial value
>   sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset
>   sched/rt: Disallow writing invalid values to sched_rt_period_us

I'm sorry for the noise, while this patchset is working for 5.15 and 5.10,
it fails to compile on 5.4 due missing SYSCTL_ONE:

kernel/sysctl.c:477:14: error: ‘SYSCTL_NEG_ONE’ undeclared here (not in a function); did you mean ‘SYSCTL_ONE’?
   .extra1  = SYSCTL_NEG_ONE,
              ^~~~~~~~~~~~~~
              SYSCTL_ONE

This is because 78e36f3b0dae ("sysctl: move some boundary constants from
sysctl.c to sysctl_vals") was backported from 5.17 to 5.15 and 5.10 but not to
5.4. If you agree on the same approach I took for 4.19 (create variable in
kernel/sysctl.c) and send patch for 5.4.

Or, we can backport just to >= 5.10. Cyril and others who merged this obviously
did not consider this important enough to backport. OTOH we have 2 LTP tests
which are testing these:

* sched_rr_get_interval01 tests c7fcb99877f9 (on non-default CONFIG_HZ)
* the other two commits are tested by proc_sched_rt01

Therefore I thought fixing at least 6.* would be good.

Kind regards,
Petr

>  kernel/sched/rt.c | 10 +++++-----
>  kernel/sysctl.c   |  4 ++++
>  2 files changed, 9 insertions(+), 5 deletions(-)

