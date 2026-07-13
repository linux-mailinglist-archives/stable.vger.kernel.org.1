Return-Path: <stable+bounces-273626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QnowLyq4VGogqAMAu9opvQ
	(envelope-from <stable+bounces-273626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 12:04:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9767499BB
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 12:04:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kkIIUh5D;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ARZSpYWk;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cxPabTdl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=I8PDkS4d;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273626-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273626-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A9B13034A08
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 10:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC203E5573;
	Mon, 13 Jul 2026 10:02:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703933502A8
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 10:02:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936954; cv=none; b=QkoY67REzVAAklOlnUdxF/RPle0/NxOyhcdTPZDPG25DLMtghyfbS6UnpsEAlakmAYvrpfDJPjIM9zJDTxg4Y+3WPpRu++2FJfaaRpZ32I9BJklo8O3cKaYKmqv+3PWALppNj4RSO06dbaEXcALlGO/tN/cnKeS+Li+iAMwKVcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936954; c=relaxed/simple;
	bh=xtICORQXo2BBb4funtYSGJxNK+ir0SY18hPMCPDEXCQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1LkzMq9zDqJJSoUsPboDf5zV/GTzJ8v+W3EXlwfymxmcNDYHe4ZJB0faehSoeOChHGcluODJpJ3MeGPAkBQM6zMRvfmcpj1zqZKC+mV4CHOHhIIaDoshT8k1DeTDGT3dFYmGS2nKIh7ziHU/GrJfxU2f8NNssnMvjSSrv910z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kkIIUh5D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ARZSpYWk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cxPabTdl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I8PDkS4d; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2AD66773F7;
	Mon, 13 Jul 2026 10:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783936944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XP2a53hPDpisD5o4rYPu5HqEIeNhTTXuEkXL4tU2MIw=;
	b=kkIIUh5DkgfrwKvzLwQQuF+x+sg6lD58QxJAVAuEBr3VBU6URxgKlZZOsv99KO0/+SUTQL
	csj1r7FEGxLoTmzpxIhazzjsz//FH9NcVJtD5SzD8H3w0TQzvstesw8VKUNQTsUJ8CsETw
	2WBDL3pba3VgLhP3zisETHRzZdMgWLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783936944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XP2a53hPDpisD5o4rYPu5HqEIeNhTTXuEkXL4tU2MIw=;
	b=ARZSpYWkHly1TSc6qJZn5hvWVdx465emgZKs4iVix9MTL8lQYFYFbJWedMXxnpwSrJh/NV
	TOKvA7YHzh31f1Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783936943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XP2a53hPDpisD5o4rYPu5HqEIeNhTTXuEkXL4tU2MIw=;
	b=cxPabTdlRbfpRNchVXWpdc37Wj4Qw5OyrsHky4iNJhF7Cuea4CZGcLiaMg2kuhXVCD+HM3
	omi0VIWURPhgLHyCc/QhcfgSiojp8o9df66llMDdJ6Bws+L6gv8nDhM1b2eSUtL4neS9BE
	g8q+/yfHU/jT1DMKb74qM4b3FcsHqkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783936943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XP2a53hPDpisD5o4rYPu5HqEIeNhTTXuEkXL4tU2MIw=;
	b=I8PDkS4dDa7fJtQVKqC1TmZ8mJyIM9kkuoFWXZw8SegFQcL9v0RwUZnuCwEKtrA8RBXYKq
	RPJ1JFYhz0IRR1Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0567779AE;
	Mon, 13 Jul 2026 10:02:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mUYyLa63VGr9GgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 13 Jul 2026 10:02:22 +0000
Date: Mon, 13 Jul 2026 12:02:22 +0200
Message-ID: <87wluzyzpt.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Evgenii Burenchev <evg28bur@yandex.ru>
Cc: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	perex@perex.cz,
	tiwai@suse.com,
	kees@kernel.org,
	eblennerhassett@audioscience.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] ALSA: hpi: Check transport errors during HPI6000 adapter initialization
In-Reply-To: <20260708141147.18253-1-evg28bur@yandex.ru>
References: <20260708141147.18253-1-evg28bur@yandex.ru>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273626-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[yandex.ru];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:evg28bur@yandex.ru,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:perex@perex.cz,m:tiwai@suse.com,m:kees@kernel.org,m:eblennerhassett@audioscience.com,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,suse.de:from_mime,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C9767499BB

On Wed, 08 Jul 2026 16:11:44 +0200,
Evgenii Burenchev wrote:
> 
> create_adapter_obj() retrieves adapter information by calling
> hpi6000_message_response_sequence(). This function reports transport-level
> errors through its return value and DSP-reported errors via hr0.error.
> 
> The current code only checks hr0.error, causing transport-level errors to
> be ignored. As a result, adapter initialization may continue with an
> invalid response.
> 
> Check the return value of hpi6000_message_response_sequence() before
> examining hr0.error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 719f82d3987a ("ALSA: Add support of AudioScience ASI boards")
> Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>

Applied to for-next branch.  Thanks.


Takashi

