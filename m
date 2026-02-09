Return-Path: <stable+bounces-215506-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wI4pHiL4iWl7FAAAu9opvQ
	(envelope-from <stable+bounces-215506-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:07:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1621118CD
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CFC2300668B
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 15:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F3137C101;
	Mon,  9 Feb 2026 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2NHkCrZg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DBvoYZtF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2NHkCrZg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DBvoYZtF"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D80D2116F6
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770649629; cv=none; b=Ipwo28J/UTBP/O8dGaBsaX/I+c/xE/ivBTq2JZZtV3YExwgK25bW4M82YxmJEje0ZWcWxR3BeT3xLx8j+UBejAJF0sRBVR7ERpvK/3JIfltllm2ftVJ4hnu+iP98WS8/InRbIyHLpV+D1AaueaADv8qCzLZbXTgj5nkFZrq8J74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770649629; c=relaxed/simple;
	bh=jF9RSM5Y7pBiaLJGZcON6IUJF0aE5pB9qleNg7wJqmc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1owu8Pk5PJ6p7mlUAh9+nMQ6bXS8KUTk5o68Ghg6BjDVh1SemfbJ8ASEVTLEyXsqFaz8uf2ITayUQbyQNbs4bp2/nLccIJwSwV8Q2gLbqsXg3kCWsHJCmcYM8WpRItlxD7W3RMzOuUsxHF62yMXkMMgbdMLKRChqfR/zQgGQLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2NHkCrZg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DBvoYZtF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2NHkCrZg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DBvoYZtF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 602C65BD14;
	Mon,  9 Feb 2026 15:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770649627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E+wrrYjlwUDgajjGgiMcvhqhawv8sly7a28Vhc4YD4s=;
	b=2NHkCrZge0ItcV1HZBKO/ugoIAzguqKtYhFY+vVkJjVY89mPnImq5AF7bJIfx1X1djnd/r
	6vsoCNXP7poqLyZTCnjJMNrpSRMePF4JeSM/jTHXXtjFzI+Vj8QrOMVEZqhWm4OIeeYTi+
	S15JQgoQrSWvmVlBTmt5/Vz7VQ/l6Xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770649627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E+wrrYjlwUDgajjGgiMcvhqhawv8sly7a28Vhc4YD4s=;
	b=DBvoYZtFrM+pV3KGd3DkpwyiGhCZdGdTyb45JrEbzg9sA5cy/5BXneJqzBblRVskiCEXau
	AZ8xfYKG45qp6vAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2NHkCrZg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DBvoYZtF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770649627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E+wrrYjlwUDgajjGgiMcvhqhawv8sly7a28Vhc4YD4s=;
	b=2NHkCrZge0ItcV1HZBKO/ugoIAzguqKtYhFY+vVkJjVY89mPnImq5AF7bJIfx1X1djnd/r
	6vsoCNXP7poqLyZTCnjJMNrpSRMePF4JeSM/jTHXXtjFzI+Vj8QrOMVEZqhWm4OIeeYTi+
	S15JQgoQrSWvmVlBTmt5/Vz7VQ/l6Xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770649627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E+wrrYjlwUDgajjGgiMcvhqhawv8sly7a28Vhc4YD4s=;
	b=DBvoYZtFrM+pV3KGd3DkpwyiGhCZdGdTyb45JrEbzg9sA5cy/5BXneJqzBblRVskiCEXau
	AZ8xfYKG45qp6vAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17B4D3EA63;
	Mon,  9 Feb 2026 15:07:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h6RTBBv4iWniDgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 09 Feb 2026 15:07:07 +0000
Date: Mon, 09 Feb 2026 16:07:06 +0100
Message-ID: <87bjhy0xd1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	chris.chiu@canonical.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: add quirk for Acer Nitro ANV15-51
In-Reply-To: <20260209134149.3076957-1-zhangheng@kylinos.cn>
References: <20260209134149.3076957-1-zhangheng@kylinos.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215506-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 1A1621118CD
X-Rspamd-Action: no action

On Mon, 09 Feb 2026 14:41:49 +0100,
Zhang Heng wrote:
> 
> fix mute/micmute LEDs and headset microphone for Acer Nitro ANV15-51.
> 
> [ The headset microphone issue is solved by Kailang]
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220279
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
> ---
> There is a small issue now, the mute LED stays on when I mute the
> laptop microphone, unmute the headphone microphone, and set the
> headphone mic as default. Is it possible to fix this?

Can LED be controlled dynamically by writing to a sysfs file in
/sys/class/leds/*? e.g.

  % cat /sys/class/leds/platform::micmute/brightness
  1
  % echo 0 > /sys/class/leds/platform::micmute/brightness

If the direct write changes the actual LED status, it's not about the
sound driver problem, but possibly some plumbing in user-space via
UCM, etc.


thanks,

Takashi

