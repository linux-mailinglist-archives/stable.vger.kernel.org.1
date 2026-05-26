Return-Path: <stable+bounces-254245-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDf/CjM1FWqwTgcAu9opvQ
	(envelope-from <stable+bounces-254245-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 07:52:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4355D0F83
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 07:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BED693009E1C
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 05:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBC73BFAEA;
	Tue, 26 May 2026 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gK5c0TFW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fhYrqnUV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t3iQt7cF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sV/8+d+m"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224BE38E5C5
	for <stable@vger.kernel.org>; Tue, 26 May 2026 05:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779774751; cv=none; b=Jrf8QO88IsWBDAuTGbHyBIqDXJAdhpv+Cp8tbOqfZBq72P5eS1Lq+1aZQKiGI9Si6+fYYwjqbThj8aqimp2Imd4CJn+CeHBZBnU3ppZufUp5habFAgNJBbSvRY5slXflY2Vwz5DAl2D7C+BcopcJ0bnfYlsySRsGEX4Lao5MXmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779774751; c=relaxed/simple;
	bh=bGe4cwPStpYQC0uwq4oxXk1cHSjFCcv6+PKMm2CrIBA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbVTkzFN72Up0BUEFAXRgLEeak3g+nWsOgqZoFsBZFES6Jj48EDwRXycMx3Cez72keJ8kRC/hxk6MrNhDq+Wn5doaiB/ivkdKtVDpssX3c9jwrQ6HHJQka2D1GjgYOwoeCFqlKPKmulUCd4iFR09ERZ5/UHjxTNPnVd1G4WPIjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gK5c0TFW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fhYrqnUV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t3iQt7cF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sV/8+d+m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F2F665380;
	Tue, 26 May 2026 05:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779774747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KyDzkxxGaOeOY9M4hGt8o8J1+NOKaE8R3F4Qz0rezkw=;
	b=gK5c0TFWBBaXDN9MzbGqmxKT/tT7J08YkCroO4mou3YJ5561X/r5q5c2Fw4vMzvmPj9JnH
	iGjNIiE+rNwEDmgog2n++uVONVwCnUPOMsRNAMF2oEffIS7fwp55cqamZ+XwjKzuM6pif6
	hq+NjkEHvOxRdhXUcFcBKeKHL5uF6Yg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779774747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KyDzkxxGaOeOY9M4hGt8o8J1+NOKaE8R3F4Qz0rezkw=;
	b=fhYrqnUV5iasDSQmDnGS4rIsvYgu0I1YJGAgeWt5HLQzh/jCAsJBGmbI4EvS08BvMr1cf1
	e2CNBnUM+hMRTWBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779774746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KyDzkxxGaOeOY9M4hGt8o8J1+NOKaE8R3F4Qz0rezkw=;
	b=t3iQt7cF/6UAKExkkSjdoXUQ6WhbOudd8UR56Fn2Jjn0CNVbJRHmif9fq7uZf28hOt4lno
	XJ9v+V7bSqNKHc5IXOafdn5AlI1bWKyz6uLdT3ozb86TBoyCafGYPnVOpcbv3miM6xHkn/
	7CLYIGq6K1duL3HSxCuts5aNBzMi9es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779774746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KyDzkxxGaOeOY9M4hGt8o8J1+NOKaE8R3F4Qz0rezkw=;
	b=sV/8+d+mxB9j4M2BWBfTYcDb25BXM437twDS5mSDxP2ja+OsV9oxcTLfgHJUJK3HNc5hfC
	uncdFrHhCpC+iPCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E49F5A052;
	Tue, 26 May 2026 05:52:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ytO7CRo1FWoaJgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 26 May 2026 05:52:26 +0000
Date: Tue, 26 May 2026 07:52:25 +0200
Message-ID: <87qzmyzpie.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Fix speaker output on ASUS ROG Strix G615LP
In-Reply-To: <20260526013611.1954949-1-zhangheng@kylinos.cn>
References: <20260526013611.1954949-1-zhangheng@kylinos.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254245-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1F4355D0F83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 03:36:11 +0200,
Zhang Heng wrote:
> 
> Add quirk for ALC294 codec on ASUS ROG Strix G615LP
> (SSID 1043:1214) using ALC287_FIXUP_TXNW2781_I2C_ASUS to
> fix speaker output.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221173
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>

Applied now.  Thanks.


Takashi

