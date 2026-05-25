Return-Path: <stable+bounces-254121-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGKiF/kiFGq3KAcAu9opvQ
	(envelope-from <stable+bounces-254121-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 12:22:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F0A5C9364
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 12:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B1113009F65
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 10:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216AC357D0B;
	Mon, 25 May 2026 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bYfRC+Lo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="duv0jh4+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lCaJczez";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CmsjN3Q5"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9369635676B
	for <stable@vger.kernel.org>; Mon, 25 May 2026 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779704557; cv=none; b=DQk09ZUEtlbUTg7m3xN4xosNepp6y1iSc6Bxyq2A3bYoHocWmtCNOteTIhWvNc48F2zKqeTuzmNfkSiENMVf+pD0UnW0J+xCH+D/DFN83GmImDbEvDT9MlZr9AFpvnZzbKEye9zyUDIhS28NH/TMx0AsGc4FC1ko9SsX8GTjJik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779704557; c=relaxed/simple;
	bh=pxqVJ6HoP/cT0126zEOaUbTl7MDVVL2VirOs3GO/vr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMv/xCdxBsk8LSOcDP8QAKxhkrmMUxWSBwAoP1dSNw8mnOmjTx6i+HTOLVh0O50URI/uioJvwvogvpzILGCZpwKDFtdLtRkMpunB9bt/qqnJO+RUu6rmrLqC7eQ6urSwAVlZtxLZOAo2dl/fuz3sjHenkO70ut26W3hLdVVkM4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bYfRC+Lo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=duv0jh4+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lCaJczez; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CmsjN3Q5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8FA267AAB;
	Mon, 25 May 2026 10:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779704555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ThdqGsv2rLMdwzw6UEj5fzyxWAsWZbNlRiJKd7M9gM4=;
	b=bYfRC+LoGEaDp7Ep+F+7BRV5cTow88OKiGDDmz/ap7KF/iG9ZkkgM6sJ4CvoqHIGS3rK6a
	KzqPD4TsUo5FvvKLS7bS39Ien1ou78x9peV5PAb4yXZD92EAL7bgzGP8q/R4wmt9wPz5fy
	rocesAaRtdd0MKzJYeGCHI8V6haytHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779704555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ThdqGsv2rLMdwzw6UEj5fzyxWAsWZbNlRiJKd7M9gM4=;
	b=duv0jh4+atwYq00sUGbY0uBOJcZ8sZPISHR+EwW31SP28RLZ8KPWf1xe49rTJLYLAmgfji
	/0YJ0AjGGc5QU5Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lCaJczez;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CmsjN3Q5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779704554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ThdqGsv2rLMdwzw6UEj5fzyxWAsWZbNlRiJKd7M9gM4=;
	b=lCaJczezht7/t13lskI4+u/+rEnK2VY/Ah/kAWLYlC4xAY9aPDi9NuM3fBA7mU/5dJW93n
	IGgn9UCiJ8KZv66or6XvIC1ulQNPkGNeR2j6zxu6fO7PMQSftmcnI9Zxi+r/26iTyr3T3/
	NkW8zE9zKJbF4yz6ZY3mGUXn4bvOeUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779704554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ThdqGsv2rLMdwzw6UEj5fzyxWAsWZbNlRiJKd7M9gM4=;
	b=CmsjN3Q5GBTg+c8LXO6Won5GM54Rqt10WVCNurkdbMSCQG4QhZQjk1FVD8oVnMSjo9Q0OH
	VdL/kC0B0swSKkDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4227859BC1;
	Mon, 25 May 2026 10:22:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6CoZDOoiFGrkPwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 25 May 2026 10:22:34 +0000
Date: Mon, 25 May 2026 11:22:32 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Takao Sato <takaosato1997@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, w@1wt.eu, 
	davem@davemloft.net, herbert@gondor.apana.org.au, chopps@chopps.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] xfrm: iptfs: preserve shared-frag marker in
 iptfs_consume_frags()
Message-ID: <ahQiuEhVjnes7gUb@pedro-suse>
References: <20260522142504.1394864-1-takaosato1997@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522142504.1394864-1-takaosato1997@gmail.com>
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-254121-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 03F0A5C9364
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 11:25:04AM -0300, Takao Sato wrote:
> iptfs_consume_frags() transfers paged fragments from one socket buffer
> to another but fails to propagate the SKBFL_SHARED_FRAG flag. This is
> the same class of bug that was fixed in skb_try_coalesce() for
> CVE-2026-46300: when fragments backed by read-only page-cache pages are
> merged, the marker indicating their shared nature must be preserved so
> that ESP can decide correctly whether in-place encryption is safe.
> 
> Apply the same two-line fix used in skb_try_coalesce() to
> iptfs_consume_frags().
> 
> Fixes: b96ba312e21c ("xfrm: iptfs: share page fragments of inner packets")
> Cc: stable@vger.kernel.org # 6.8+

Why? This code seems to have only been introduced in 6.14, aka the only LTS
version this applies to is 6.18. Typo?

-- 
Pedro

