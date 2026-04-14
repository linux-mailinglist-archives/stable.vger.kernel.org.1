Return-Path: <stable+bounces-237874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAX4LZtC3mlvpwkAu9opvQ
	(envelope-from <stable+bounces-237874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:35:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DF93FA8E7
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D92D301F5E2
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D49344031;
	Tue, 14 Apr 2026 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nD9ZTmgh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m8AAg6Bc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nD9ZTmgh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m8AAg6Bc"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57E12DB79E
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173515; cv=none; b=EmU9mbMdlLtU5rGBhfYgSOeQmkHlOjbqDg52TkIUXq6aVY9JssAA3FUjPNwxb8uy+WsAbIURnvZKjDmRjsPWpdN/r0cZ8QCe7N3Iq3BVImi+Bgf90XRrj8cYP2MBbDsYb4oFwqBOpn5rFEW0tC5tZorsYdE0HYiZCYU8BVT//jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173515; c=relaxed/simple;
	bh=DA47YLA8+iH7EKUyDkkru1Zwz/1IB1OgGUzmDngHtlY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwCGM+7m2//bpaT17QNc0T3hEHUEHZXV+X1Ns8Q9acToRVHkG2MhdbAyzgeXewacd9pmUy+DhgbprFWTolQnaJcSwIICMEKjtkA/n2rL2bXOZIAV/qdhKLyyJ2MMxowjP6wJZ/zrpDjpS0hEKkt3OCwBjCPQg9b7jzXEI2wZBgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nD9ZTmgh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m8AAg6Bc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nD9ZTmgh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m8AAg6Bc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 244D26A906;
	Tue, 14 Apr 2026 13:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776173512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8knfCaqAx482469gGvSsU0Xu/1N+7BGizQbTdNW3ft4=;
	b=nD9ZTmghK9QVRxGwnORAqjZwNENIMXxb4e/gCtCfk0zelXJU267if4rHLmxTSSwdWXred1
	uZNiKyFGThPilM8RgvLyJVCGHYunzYyXNT4ZxNE07QtXjOOWWc/Mlur92UCyI6HnT17HbI
	TXOxEy6EkQxmNTneTdx115XwA2ad+5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776173512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8knfCaqAx482469gGvSsU0Xu/1N+7BGizQbTdNW3ft4=;
	b=m8AAg6Bc+EsvCZPl+tY4MB/2q3O4VZLWibaKG4/19OU/l2oBge71JdiCaOkt1t58p8TSGl
	/vbhgWTZPIvKANBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nD9ZTmgh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=m8AAg6Bc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776173512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8knfCaqAx482469gGvSsU0Xu/1N+7BGizQbTdNW3ft4=;
	b=nD9ZTmghK9QVRxGwnORAqjZwNENIMXxb4e/gCtCfk0zelXJU267if4rHLmxTSSwdWXred1
	uZNiKyFGThPilM8RgvLyJVCGHYunzYyXNT4ZxNE07QtXjOOWWc/Mlur92UCyI6HnT17HbI
	TXOxEy6EkQxmNTneTdx115XwA2ad+5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776173512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8knfCaqAx482469gGvSsU0Xu/1N+7BGizQbTdNW3ft4=;
	b=m8AAg6Bc+EsvCZPl+tY4MB/2q3O4VZLWibaKG4/19OU/l2oBge71JdiCaOkt1t58p8TSGl
	/vbhgWTZPIvKANBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D51DC4B482;
	Tue, 14 Apr 2026 13:31:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lqq1MsdB3ml8RAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 14 Apr 2026 13:31:51 +0000
Date: Tue, 14 Apr 2026 15:31:51 +0200
Message-ID: <87340xsm60.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ziqing Chen <chzq96@gmail.com>
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ziqing Chen <chenziqing@xiaomi.com>
Subject: Re: [PATCH v2] ALSA: control: Validate buf_len before strnlen() in snd_ctl_elem_init_enum_names()
In-Reply-To: <20260414132437.261304-1-chenziqing@xiaomi.com>
References: <20260414132437.261304-1-chenziqing@xiaomi.com>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-237874-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,xiaomi.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 02DF93FA8E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 15:24:37 +0200,
Ziqing Chen wrote:
> 
> snd_ctl_elem_init_enum_names() advances pointer p through the names
> buffer while decrementing buf_len. If buf_len reaches zero but items
> remain, the next iteration calls strnlen(p, 0).
> 
> While strnlen(p, 0) returns 0 and would hit the existing name_len == 0
> error path, CONFIG_FORTIFY_SOURCE's fortified strnlen() first checks
> maxlen against __builtin_dynamic_object_size(). When Clang loses track
> of p's object size inside the loop, this triggers a BRK exception panic
> before the return value is examined.
> 
> Add a buf_len == 0 guard at the loop entry to prevent calling fortified
> strnlen() on an exhausted buffer.
> 
> Found by kernel fuzz testing through Xiaomi Smartphone.
> 
> Fixes: 8d448162bda5 ("ALSA: control: add support for ENUMERATED user space controls")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ziqing Chen <chenziqing@xiaomi.com>

Applied now.  Thanks.


Takashi

