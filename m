Return-Path: <stable+bounces-110995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B792A20F78
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 18:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5AF51889EF1
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 17:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412BD1DE3D2;
	Tue, 28 Jan 2025 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dcdBseBP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0sPoH5AZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dcdBseBP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0sPoH5AZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756781DDA20;
	Tue, 28 Jan 2025 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738084374; cv=none; b=mskBr/+H5rZby5MO5Dq6kREWAQg7Y7IgfRg/Cxt6E52DOaEY6QpWTrksq/eBQBYtFrWVmTD5GyIQvfoCxYSSdo6Wg9LA0APCOYRYsNZcg+4iM8mwUa0BBU8DnPHhrU99mh3WzcnKKfBpYLhaK3PslnfkXJyhOz2N0kSZDGzqDgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738084374; c=relaxed/simple;
	bh=4LjJCpzH5Yv7NN6OuJdtIRWKFGojGmAJhZm6xjENfog=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATFaIYYdXYj+e8aelps1y/1MXyQ3A5PSDw7ck9csVxswoxRjbnv+TXFdz/dcK+COwMVLzy/Prpv3ZbxWgbPA2WrFDW51r+oxX+ZB2gSu3pxNztvg9efu4I6yQNMwiL0eGiH93VQYXHfzMlo8NuRrmmB6/9//nSIlyAGkBiZ4n7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dcdBseBP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0sPoH5AZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dcdBseBP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0sPoH5AZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 84A891F381;
	Tue, 28 Jan 2025 17:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738084370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aAioC5LFKEiyTyOdaEBg/Xy+YGwJws1L9fuE0KpAnac=;
	b=dcdBseBPgxzEdHyH5Ps1D3mRlM1//AqLpvCLX6js/llZPe7MFX/3OhRe1AswuDeJ3hereu
	lE0NiKDURadZeRMe1FrZI78jPUsCuQueAfJw9EELdsS3AYbab6odOoAlOp0KN7I2GZ1sQt
	NhToJ1sjt6jprOMVQD1luRZU1pvaUwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738084370;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aAioC5LFKEiyTyOdaEBg/Xy+YGwJws1L9fuE0KpAnac=;
	b=0sPoH5AZYltkw6ZNt6/MPxJWchTjkoPcWYmYY87AqrN7VUoqHastYcNF+Zhwr1JUkwiWpf
	utro5QszX9WboYCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738084370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aAioC5LFKEiyTyOdaEBg/Xy+YGwJws1L9fuE0KpAnac=;
	b=dcdBseBPgxzEdHyH5Ps1D3mRlM1//AqLpvCLX6js/llZPe7MFX/3OhRe1AswuDeJ3hereu
	lE0NiKDURadZeRMe1FrZI78jPUsCuQueAfJw9EELdsS3AYbab6odOoAlOp0KN7I2GZ1sQt
	NhToJ1sjt6jprOMVQD1luRZU1pvaUwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738084370;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aAioC5LFKEiyTyOdaEBg/Xy+YGwJws1L9fuE0KpAnac=;
	b=0sPoH5AZYltkw6ZNt6/MPxJWchTjkoPcWYmYY87AqrN7VUoqHastYcNF+Zhwr1JUkwiWpf
	utro5QszX9WboYCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33D9E13625;
	Tue, 28 Jan 2025 17:12:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TikWCxIQmWdZNAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 28 Jan 2025 17:12:50 +0000
Date: Tue, 28 Jan 2025 18:12:49 +0100
Message-ID: <8734h2981a.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	gio.spacedev@pm.me,
	austrum.lab@gmail.com,
	luke@ljones.dev,
	akpm@linux-foundation.org,
	jserv@ccns.ncku.edu.tw,
	chuang@cs.nycu.edu.tw,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: Fix headset detection failure due to unstable sort
In-Reply-To: <20250128165415.643223-1-visitorckw@gmail.com>
References: <20250128165415.643223-1-visitorckw@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,pm.me,gmail.com,ljones.dev,linux-foundation.org,ccns.ncku.edu.tw,cs.nycu.edu.tw,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 28 Jan 2025 17:54:15 +0100,
Kuan-Wei Chiu wrote:
> 
> The auto_parser assumed sort() was stable, but the kernel's sort() uses
> heapsort, which has never been stable. After commit 0e02ca29a563
> ("lib/sort: optimize heapsort with double-pop variation"), the order of
> equal elements changed, causing the headset to fail to work.
> 
> Fix the issue by recording the original order of elements before
> sorting and using it as a tiebreaker for equal elements in the
> comparison function.
> 
> Fixes: b9030a005d58 ("ALSA: hda - Use standard sort function in hda_auto_parser.c")
> Reported-by: Austrum <austrum.lab@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219158
> Tested-by: Austrum <austrum.lab@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Applied now.  Thanks.


Takashi

