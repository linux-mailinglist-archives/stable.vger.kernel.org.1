Return-Path: <stable+bounces-222801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHznFEaBpmmIQgAAu9opvQ
	(envelope-from <stable+bounces-222801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 07:35:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 588A41E9AB3
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 07:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84652300D774
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 06:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CD33845CC;
	Tue,  3 Mar 2026 06:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Co6oGvTi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OiIapXlc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lxB1wLlj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YqUEABvJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C454130DEB5
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772519744; cv=none; b=i/pMJczDvQbgJr7zbQz7qOXmHIdj8t1pJHUQlr+XvZINY/lJ17TjhboFBO/E3V5LolXBiR7xaBGPi5iSAuZS9np1F06ZkcucxcPl8sU/N/HbGaxinQRRgvskMJoFRUgKngABz2yrU4Lu+wdeoGhy4/S1falFQ9hM6futWyaTBHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772519744; c=relaxed/simple;
	bh=bAz9pcyHQRBLCF+YmexQ7iExl3uChwqBNcU7naZ1yVs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6QU9OYuVPgieoOO6P505cK64rkymksT9gl5hDWzsMQw7ZeSOUCX9/LV1gSVp1ZFOeoiRq1ombc/SICRXkK27Koy+WMT/ptgxSQesDEbNVH+T7BzHeWmnNgwCXDSfyy+JWphT4jeX03hXyVxSO1jG1I2iNAhLI2Xpig9k+9SCbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Co6oGvTi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OiIapXlc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lxB1wLlj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YqUEABvJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9D5E3E802;
	Tue,  3 Mar 2026 06:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772519742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6OKrT+STPu41Pzgef9XUS7YWWO9D4G5H6sgRM2xRE4=;
	b=Co6oGvTiFVmcvr/hiOAwSmpmlncR0cMK+7VpNyudVCIaKyWmj4hODAOEAMFNsvyoKi+1mM
	Wtp3RJybrKUGwkittGVJAnM7069qqqyV2C1cWOmlI3KDh4XnUBLP2e+lOZ6PlWbWBapMy9
	UxAhoHlb53IVt00k42ZBY5Xy8GakHpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772519742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6OKrT+STPu41Pzgef9XUS7YWWO9D4G5H6sgRM2xRE4=;
	b=OiIapXlc35PEDoq8ZKD1lBPiGLjSqPNMJBx2k1UDmA/0Zize8Pza5iKdW412RMzcZTs1sB
	Axc9OEjiLvl4y+Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lxB1wLlj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YqUEABvJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772519740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6OKrT+STPu41Pzgef9XUS7YWWO9D4G5H6sgRM2xRE4=;
	b=lxB1wLljnYrUJ8JVpxsjfwdQmgzZeByTLExkZl+IMtoCsMEea2Se3RcqTzO4I+EfWPwjfS
	gxHyelR9DofCaBWkK8OnhsNsFl1EMtd+kudzszzNFyenLM1/stjGcr6nRFYnGKvGcdvp/1
	Eu+Xr2DCiYuQ05wGtnDg7rTo2nS/t+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772519740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6OKrT+STPu41Pzgef9XUS7YWWO9D4G5H6sgRM2xRE4=;
	b=YqUEABvJ75HDENPK6VUoPgLJi/uc/YoG1u9eT2kGHre/wyF2W+hd8K9FIYCI/K3nZrMpI4
	AxRPIdq6MuKoWmCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A7FC3EA69;
	Tue,  3 Mar 2026 06:35:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yzgEIDyBpmlrEQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 03 Mar 2026 06:35:40 +0000
Date: Tue, 03 Mar 2026 07:35:40 +0100
Message-ID: <87fr6hl8sj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Rong Zhang <i@rong.moe>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Cryolitia PukNgae <cryolitia@uniontech.com>,
	Arun Raghavan <arunr@valvesoftware.com>,
	linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: doc: usb-audio: Add doc for QUIRK_FLAG_SKIP_IFACE_SETUP
In-Reply-To: <20260302173300.322673-1-i@rong.moe>
References: <20260302173300.322673-1-i@rong.moe>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 588A41E9AB3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222801-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 02 Mar 2026 18:32:59 +0100,
Rong Zhang wrote:
> 
> QUIRK_FLAG_SKIP_IFACE_SETUP was introduced into usb-audio before without
> appropriate documentation, so add it.
> 
> Fixes: 38c322068a26 ("ALSA: usb-audio: Add QUIRK_FLAG_SKIP_IFACE_SETUP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
> This is separated from https://lore.kernel.org/r/20260301213726.428505-7-i@rong.moe/
> (thanks Takashi Iwai)

Applied now.  Thanks.


Takashi

