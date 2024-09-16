Return-Path: <stable+bounces-76534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C30A97A867
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 22:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15CC11F2627B
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 20:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CAD1422D8;
	Mon, 16 Sep 2024 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gd7eFRP4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Kc79pJ0Z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ONyxBSDC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MowPGmCp"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D623EF9FE;
	Mon, 16 Sep 2024 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726519469; cv=none; b=OE3HzFhxHHYiagJLXEvBeEK6X1YOebJ9Cx3zsxrSno8gVCzleOP6NCdLm8WR4lHJh8fkW1Mx2msWtpWgksLEdGlPX8+E5PP40fXki3Y6hjoIQxWUyauAutFUaLLbnkcy6mY3Krdc7frur8bY/TWrW/cORl91+B3XZ3Q7e6lMGHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726519469; c=relaxed/simple;
	bh=+vCLiYPOUQQcc83vltqTxE5+acjZZ+wFzRZBPezyw5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uXiExpVVnPxNB6/VakeMpBRveTMt3Ki8dsyLsO7V0USLO8LvyF5CucAYCdknPLnhgxVgYWJ7ewYDMhgxHAfjGauszznctPMjaUo7tMuP5SLqvBo9PSRrHmJoZgZYXThoIh1dsZBEsY8vD09VNsjh/i+LaeheunXjH5qqA3z7Cow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gd7eFRP4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Kc79pJ0Z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ONyxBSDC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MowPGmCp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ECF9D21C4B;
	Mon, 16 Sep 2024 20:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726519466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYB1BzjBJYR3QZfgkjjXkNSuaJnu7Ab3AL2Hwq3V4cs=;
	b=gd7eFRP4GtCb49kCy0vzhDXTmyE2zY8BOHejcxnJ4XrT3AEnTMjU0mFbrOSpmSEsPExZck
	wwrY8MMbsM3sEb8C1nZE1J2oDv/dZtK5BZ5H17GHLQj2R1z78siFziSR8TbvPmNMKcriub
	j0TV+7UFsAHDU2V0FOo1DBvp6N6PsJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726519466;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYB1BzjBJYR3QZfgkjjXkNSuaJnu7Ab3AL2Hwq3V4cs=;
	b=Kc79pJ0ZvUypSyJi/tU/v3I/idf4V3BMkcHtBnMjzE/b03b3WdF5xKNvwHgXcFvkvJd6Qs
	mXcd0XYvz6tDEhBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726519464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYB1BzjBJYR3QZfgkjjXkNSuaJnu7Ab3AL2Hwq3V4cs=;
	b=ONyxBSDCXP8qFh9Rx9BBeaE0T4YYXiVHuWtW+eCV0DYE8Z/kHSq9JXeJAzv88PVE2aYsbU
	8ReYEGSbt324nbeUU7N40KJF/QO+vhFxh8gUMY/6hDxmbfUoUR+hVsbbZ8CCNAQqkOIA4N
	fFpSfZxb43oqU6Gg7As/qRPl3gsst50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726519464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYB1BzjBJYR3QZfgkjjXkNSuaJnu7Ab3AL2Hwq3V4cs=;
	b=MowPGmCpp9QLZNtpmYQBvQ1WeFmGy3WMQJ/dAZYaBAiSFynNa3yCsTxJUBI+Q1/xWR2P0l
	TG8QDZXyWz5//6Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9D03139CE;
	Mon, 16 Sep 2024 20:44:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XPqRLKiY6GYOIAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 16 Sep 2024 20:44:24 +0000
Message-ID: <721f6543-1bf7-4b6f-8656-b5d84248e56f@suse.de>
Date: Mon, 16 Sep 2024 22:44:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-auth: assign dh_key to NULL after kfree_sensitive
To: Vitaliy Shevtsov <v.shevtsov@maxima.ru>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240916174139.1182-1-v.shevtsov@maxima.ru>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240916174139.1182-1-v.shevtsov@maxima.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtesting.org:url,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,maxima.ru:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 9/16/24 19:41, Vitaliy Shevtsov wrote:
> ctrl->dh_key might be used across multiple calls to nvmet_setup_dhgroup()
> for the same controller. So it's better to nullify it after release on
> error path in order to avoid double free later in nvmet_destroy_auth().
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Fixes: 7a277c37d352 ("nvmet-auth: Diffie-Hellman key exchange support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
> ---
>   drivers/nvme/target/auth.c | 1 +
>   1 file changed, 1 insertion(+)
> 
Now that is obviously correct.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


