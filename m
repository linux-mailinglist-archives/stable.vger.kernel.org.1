Return-Path: <stable+bounces-116371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E04BEA3582B
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 08:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 464797A535E
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 07:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1E121B1AC;
	Fri, 14 Feb 2025 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qI7QAWdG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GsacvUad";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HuZIErAO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JAMJAT5C"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051D5189915;
	Fri, 14 Feb 2025 07:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739519271; cv=none; b=TERcd+FCUrcLHYJK6bbOiKzE4yH2egmFSRYxoxHdTAeWdnuFHMK3FaU4Z0vDkadmSunEWiJ26/qIUseC9dw5cPSWlY6XXR1b0TccYgPQmlxkJHztNJ/HQzZMCkgf4OYlsGPCkBNP8n20Es/21/vu7VkuCIAoh+k7tz8n92OPIL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739519271; c=relaxed/simple;
	bh=9Fx1ADP2d6/0Az/8gbXuqq/P/ru93pf9PBS1UT9ATrE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+6KyYcnsNCedlZsxLH5A8Ar72gwwJJRk+tEXQjLvwEeF206lPoO9s7OCVVFsHmz+NMu36lhUVMPdR9cSAe18ci7QifZk5gdl7vTn73bqv78oqFNqNV9uhCWSg8CN0B3CO7/hDCmlqkghhVvqVOfaek1qWVnfChMrQU9ZaAlix0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qI7QAWdG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GsacvUad; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HuZIErAO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JAMJAT5C; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CCF5C21D63;
	Fri, 14 Feb 2025 07:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739519268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w0EGkOWHhFPkNIwh0U247/lhdtEDCXIZ/GRopnWrhFA=;
	b=qI7QAWdGkEzSdkGWKnCRrBsCP15AI+a8MQG9MtkE/BB+jrENAAQwpTe+E2Xm+2NHXJ5Nc6
	+DB89DIAKBPLAYeQDYAtNg2JrEglc/ox0W04DgWs+QUj11uA/K7jrGAMymQwvHC6HLMq7M
	kcU0aEIr8TuzhoIiXEnLod4iZZFXvJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739519268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w0EGkOWHhFPkNIwh0U247/lhdtEDCXIZ/GRopnWrhFA=;
	b=GsacvUad/BiRMJcOJ91IiZZJzQ7nlkp7iqAg8SBNBRX9DoKrGpaN5RYMsZkz2bSzeCOzrg
	5KhUQiB8j4vTDACA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HuZIErAO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JAMJAT5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739519267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w0EGkOWHhFPkNIwh0U247/lhdtEDCXIZ/GRopnWrhFA=;
	b=HuZIErAOtkLwIx+u/+YLGmdowSprAxYlqy1qJ0h1SjRvnEibH0NtMj4YhXBXscbBoHLBrC
	UNhiGu1lUDZ0iVPYeAJgD68zeuhbXLQtbGJiqLgrRcwFogKpzfzagfieMkZrAyRyro9e5B
	NNg+8CoQ9BLsWNmc+JbQGxa5UOsdXr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739519267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w0EGkOWHhFPkNIwh0U247/lhdtEDCXIZ/GRopnWrhFA=;
	b=JAMJAT5CF/DosKKP5vjP62YuxO3HM0pEteMsnt8lVNIfTKerBbzecL9HLC+nrSZOhjcWs5
	PdJ5/IctVT7fRBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 370CA13285;
	Fri, 14 Feb 2025 07:47:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4iuXCSP1rmd9GAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Feb 2025 07:47:47 +0000
Date: Fri, 14 Feb 2025 08:47:42 +0100
Message-ID: <87frkh2cip.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	cezary.rojewski@intel.com,
	Julia.Lawall@inria.fr,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda: Add error check for snd_ctl_rename_id() in snd_hda_create_dig_out_ctls()
In-Reply-To: <20250213074543.1620-1-vulab@iscas.ac.cn>
References: <20250213074543.1620-1-vulab@iscas.ac.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: CCF5C21D63
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 13 Feb 2025 08:45:43 +0100,
Wentao Liang wrote:
> 
> Check the return value of snd_ctl_rename_id() in
> snd_hda_create_dig_out_ctls(). Ensure that failures
> are properly handled.
> 
> Fixes: 5c219a340850 ("ALSA: hda: Fix kctl->id initialization")
> Cc: stable@vger.kernel.org # 6.4+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

The error would never happen because this is a rename, and the only
error condition of snd_ctl_rename_id() is the lack of the control id.
But it's better to have a return check in the caller side, so I took
now.  Thanks.


Takashi

