Return-Path: <stable+bounces-211230-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACnFIOshcmmPdQAAu9opvQ
	(envelope-from <stable+bounces-211230-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 14:11:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB60D67162
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 14:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0669C90928F
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 12:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE0E3164C2;
	Thu, 22 Jan 2026 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lyjbR/Mn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HF7jQ0dZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lyjbR/Mn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HF7jQ0dZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA2E346784
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769085200; cv=none; b=CZ92rQVX8aMpwYN4TmL4D84QvFtdTvlm+4ddOJRPA4T4wyDWp0wjpsYMsJSJlHz6vXBRRXGEs/65PIdlIZfSuLOJcMBDoOYLgzq2sOwQvTJXg4nt+we8Imx55qBX+4q/0O8FOgdNfHRkFc2SjKHveA7U36gkyAe+qVgVzJGUif8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769085200; c=relaxed/simple;
	bh=ALbcLl8uokk9H6x8tA66C5FLwVN1RZNN0BqtCgoRoJ8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFXlTAoi5tBpymOo53aacrKtvvT0HFb6nsmpXzIgJQf1p+uIdZbVdlrCcK4gMQSPnS3MCqV+MlQQ4QFJGgQqJyi3dK0c9FOZUooDD3DAoyAHbfvFZRUwN0YXSgcpJ4hFukqAuPOBJ+TvUMgRl5jMINnPWlTZUDfgh0p5j/WYoIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lyjbR/Mn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HF7jQ0dZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lyjbR/Mn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HF7jQ0dZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA7BA5BCC7;
	Thu, 22 Jan 2026 12:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769085195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0iX6pX1UbAHS3EnZvXdsqpQs9agwPrmslZb/baAtyYc=;
	b=lyjbR/Mnn275woA2EMI5QuKKN99w33rxp0RlX9FFqXkJSVNv0LFO7zC4ppUo3PkbCwcT9H
	xWQwnF3ov1wni5nIRHBj8Vje7IEx2PYQUny6xXliAxke+EpANyE8ZAKeRkpV8wpwlweiQV
	ohpdNeUkhV9irdGWxtoXxpvKKGtZvW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769085195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0iX6pX1UbAHS3EnZvXdsqpQs9agwPrmslZb/baAtyYc=;
	b=HF7jQ0dZITr7fREmprVhvCFq6pUODL5+HK6y1z0p3ti9MzG9L53Vc3bEGFntJE3pDInEp5
	Xicil/sIk5WavQBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769085195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0iX6pX1UbAHS3EnZvXdsqpQs9agwPrmslZb/baAtyYc=;
	b=lyjbR/Mnn275woA2EMI5QuKKN99w33rxp0RlX9FFqXkJSVNv0LFO7zC4ppUo3PkbCwcT9H
	xWQwnF3ov1wni5nIRHBj8Vje7IEx2PYQUny6xXliAxke+EpANyE8ZAKeRkpV8wpwlweiQV
	ohpdNeUkhV9irdGWxtoXxpvKKGtZvW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769085195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0iX6pX1UbAHS3EnZvXdsqpQs9agwPrmslZb/baAtyYc=;
	b=HF7jQ0dZITr7fREmprVhvCFq6pUODL5+HK6y1z0p3ti9MzG9L53Vc3bEGFntJE3pDInEp5
	Xicil/sIk5WavQBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A37713533;
	Thu, 22 Jan 2026 12:33:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dRDDFAsZcmmVDAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 22 Jan 2026 12:33:15 +0000
Date: Thu, 22 Jan 2026 13:33:14 +0100
Message-ID: <87zf65hlo5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	chris.chiu@canonical.com,
	edip@medip.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Samsung 730QED to fix headphone
In-Reply-To: <20260122085240.3163975-1-zhangheng@kylinos.cn>
References: <20260122085240.3163975-1-zhangheng@kylinos.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211230-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: EB60D67162
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 09:52:40 +0100,
Zhang Heng wrote:
> 
> After applying this quirk for the ALC256 audio codec, the headphone
> audio path functions normally; otherwise, headphones produce no sound.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220574
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>

Applied now.  Thanks.


Takashi

