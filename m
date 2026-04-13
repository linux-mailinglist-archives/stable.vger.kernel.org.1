Return-Path: <stable+bounces-237624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNFqOo0z3WmiagkAu9opvQ
	(envelope-from <stable+bounces-237624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:18:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6753F1EAE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41BA63012D6C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B6F3431F5;
	Mon, 13 Apr 2026 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AbVMqlJ8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nvWvjdXT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AbVMqlJ8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nvWvjdXT"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E38340260
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776104321; cv=none; b=pHIKUZAZ77KwL62X4GPlAoZd/+nNfvX50p/+VO0XV4KqkdYcWhEuEuosWkt+rYQjy6mmEYxMfH5O2WqhTIhK1gpynZpApBjHqx8WiGA7p4WCj4WqPZQf+1jLCecFD8EdT7SFW8vWrN3GE/ENF+w1tovMm6ehO0jIuREHK8qs9vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776104321; c=relaxed/simple;
	bh=kib4dpjKNDV8GcR7C8BcnWoP0nPepltsTWs2JIovkFs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0T3NAF0C63+jAb8eYQtVlBbhdt1h+p+5uaea4a/WSpiflU9QwISXjsmnMMUvn7uRTmiE8WHoFTSLB3vsO4tBtWuH0TQiM1o2uXVHTlXLPTFgSK/jGFc/lyvdl8HJWINZ92Sx7vhL9KZe/TuALwmdlnluDcNv5FaqlJBgepVBGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AbVMqlJ8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nvWvjdXT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AbVMqlJ8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nvWvjdXT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 896905BE4C;
	Mon, 13 Apr 2026 18:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776104318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sdGJ+eT9P/YL/Do4T/hYX5l1K/wRVwAIJjf4Bu1dqx8=;
	b=AbVMqlJ8XCntU3deu8HMBt4GLLO32B+WysFEpfzMQ97HjQT2BkDgoExDokF4ni+VUEGbid
	k+X5nL8cFPbv4oMqThUD6T0316aTOZxaKnRAaYSXbqAKOdhFSzAV2bZDdY1r1/aTIBjkKT
	BlxcLeUN5TwLOum5ChPlkM52LWWRk4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776104318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sdGJ+eT9P/YL/Do4T/hYX5l1K/wRVwAIJjf4Bu1dqx8=;
	b=nvWvjdXTSkxSsK5BxqRqd9iep6Xj4VsSa7Ya4Vmo3PYipxxm9ALdd6uldDAcde0thNQAq9
	xxLomH+pLb0q0sAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AbVMqlJ8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nvWvjdXT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776104318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sdGJ+eT9P/YL/Do4T/hYX5l1K/wRVwAIJjf4Bu1dqx8=;
	b=AbVMqlJ8XCntU3deu8HMBt4GLLO32B+WysFEpfzMQ97HjQT2BkDgoExDokF4ni+VUEGbid
	k+X5nL8cFPbv4oMqThUD6T0316aTOZxaKnRAaYSXbqAKOdhFSzAV2bZDdY1r1/aTIBjkKT
	BlxcLeUN5TwLOum5ChPlkM52LWWRk4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776104318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sdGJ+eT9P/YL/Do4T/hYX5l1K/wRVwAIJjf4Bu1dqx8=;
	b=nvWvjdXTSkxSsK5BxqRqd9iep6Xj4VsSa7Ya4Vmo3PYipxxm9ALdd6uldDAcde0thNQAq9
	xxLomH+pLb0q0sAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DC464B007;
	Mon, 13 Apr 2026 18:18:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hSJ6FX4z3Wn+YAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 13 Apr 2026 18:18:38 +0000
Date: Mon, 13 Apr 2026 20:18:37 +0200
Message-ID: <87bjfmu3k2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Geoffrey D. Bennett" <g@b4.vu>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Exclude Scarlett 18i20 1st Gen from SKIP_IFACE_SETUP
In-Reply-To: <ad0ozNnkcFrcjVQz@m.b4.vu>
References: <ad0ozNnkcFrcjVQz@m.b4.vu>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237624-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA6753F1EAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 19:33:00 +0200,
Geoffrey D. Bennett wrote:
> 
> Same issue as the other 1st Gen Scarletts: QUIRK_FLAG_SKIP_IFACE_SETUP
> causes distorted audio on the Scarlett 18i20 1st Gen (1235:800c).
> 
> Fixes: 38c322068a26 ("ALSA: usb-audio: Add QUIRK_FLAG_SKIP_IFACE_SETUP")
> Reported-by: tucktuckg00se [https://github.com/geoffreybennett/linux-fcp/issues/54]
> Signed-off-by: Geoffrey D. Bennett <g@b4.vu>

Applied now.  Thanks.


Takashi

