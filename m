Return-Path: <stable+bounces-124803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30628A67555
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 14:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886B4178856
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 13:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250FF20D4E6;
	Tue, 18 Mar 2025 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1fEYIhzG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3/xlkDBI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vUdxEEWb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rKJdWq17"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F8F148827
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305224; cv=none; b=poVOtLVJTawOvV9pEv8hK4XNxjZCxyN2eb7qVqOgJKjXyBKImc3TZkUY4DxyzW7is1CleInRDZNYdFa/VYQiOWsJ3RtGU76PFfpVkIZHBNorEr8Qc4YjZQiTErWFYKStfmaDJ8EBbXTq5A1H4oy8KwIHO5fNCF8i857aPWI7HMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305224; c=relaxed/simple;
	bh=cvajKkvuqbKU3jmB3q0F6N9Su9s3Rg3eh8HYzmL+ajE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULi68t5XHuixs/hVM10ZwioqkOb8m/TnSyiqhIMiiCptSC/1IcMdHjJ9oHUu8uPhbIov0EcsT7Pn2JnSuu4epqco7ojLol1tuMdhonOcgOCKQZQ2y3P4+Gy/+cHebmr3iynJ5Mk2dHkkqtr8qtoo4yT7q45wbJBDxy8CDSSf1jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1fEYIhzG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3/xlkDBI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vUdxEEWb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rKJdWq17; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC1A221232;
	Tue, 18 Mar 2025 13:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742305217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/5krZYaFQojyOXw3q5Pi7Cp5WRjTZ9YjAT8NAGmDKM=;
	b=1fEYIhzGu9k0PzFkTbCgIg4R6MOTDFd+nwwoOeds8uz6l9Ocxy8X6+OLbNWSTcVUfw5kfv
	H6EcYQBTuJHJX3/XCx8mMlk0f3CxwJxRt1AhGgFMCGbpdpHqq6rj7Ut1oENWUPUtEwvIFz
	Obrm6OZZyuZGoeqGqonuZ2loaJ/yw6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742305217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/5krZYaFQojyOXw3q5Pi7Cp5WRjTZ9YjAT8NAGmDKM=;
	b=3/xlkDBIhLBpULrXTFSoLzyPYj9Tc58c/HqtHLhgWd/qsUE/hljZTPq5mPUPclk73y0fVe
	M2AVMDePgrO4kQCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742305216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/5krZYaFQojyOXw3q5Pi7Cp5WRjTZ9YjAT8NAGmDKM=;
	b=vUdxEEWbmCOhAfvCg8s0JuM0MhBpN9Age+TmlSjis+ANiHmrXz1B6UOYwD1QA1wpYQorwu
	Ht3mvTYUcqgfIjwPrhnLkMaqnPYMujto6LhxM64zBOtmEQiM8Ldc4zckhNPo+DQWXUyTWX
	TVn21d2i65m6F3BjnwWFIpX/SD4www4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742305216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/5krZYaFQojyOXw3q5Pi7Cp5WRjTZ9YjAT8NAGmDKM=;
	b=rKJdWq17VN6nXT7nXaBVl1mbGkbbylu3BAKjXnqWyevmUBJkOekcohzPS4igBbrt3CQ1iE
	hKJSrMuDyrkLQgCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8F7F139D2;
	Tue, 18 Mar 2025 13:40:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zt3VL8B32WcUdQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 18 Mar 2025 13:40:16 +0000
Date: Tue, 18 Mar 2025 14:40:16 +0100
Message-ID: <877c4m1mpr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dhruv Deshpande <dhrv.d@proton.me>
Cc: tiwai@suse.com,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Support mute LED on HP Laptop 15s-du3xxx
In-Reply-To: <20250317085621.45056-1-dhrv.d@proton.me>
References: <20250317083319.42195-1-dhrv.d@proton.me>
	<875xk8f3ue.wl-tiwai@suse.de>
	<20250317085621.45056-1-dhrv.d@proton.me>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Mon, 17 Mar 2025 09:56:53 +0100,
Dhruv Deshpande wrote:
> 
> The mute LED on this HP laptop uses ALC236 and requires a quirk to function.
> This patch enables the existing quirk for the device.
> 
> Tested on my laptop and the LED behaviour works as intended.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Dhruv Deshpande <dhrv.d@proton.me>

Applied now.  Thanks.


Takashi

