Return-Path: <stable+bounces-208432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE60D23E18
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 11:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8603730C21B4
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 10:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16DB357705;
	Thu, 15 Jan 2026 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lAzZtZCx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lovRlPHI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="veU/sj9s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lj0k8vJp"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F9D334C3F
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768471968; cv=none; b=GnfzLLtAKcfjJyX56ODK4DNj1ANLcIOXRmM+u5Eu7NVueWSewcet2o+w1YYd5pL+zc+etsqrqL25gBiI82PzXzuSFk9RXbR9nbuuVjJ0b2B0CI2XrNtyCgbG0OKyjG8aCrewtDpNDhDKaRFQloiCZ9sdv1TAV/Ig1DgPRk+wiS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768471968; c=relaxed/simple;
	bh=d5ngVleiPPWy1o60Vh8ktOGuV0JmU/+i7w5WiB/hr0M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HACWfkTQYurRfx8ReGo4Cj6nxrmncZ4VkeFduLseideV5hOw2efcd5jp5ZMMjT36qkDRkSriUIJY6+9JRlLCbLGDzJzpxCxwfdhMHM0fWsOahCY4hLaqxc2FrefOzEPH7EVTuakOrvK2hKTde4tfZ8ypYsahJF4pyobT3Iw6aLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lAzZtZCx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lovRlPHI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=veU/sj9s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lj0k8vJp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CBC413377C;
	Thu, 15 Jan 2026 10:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768471958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkOKVFsE+pvCCubiu+J9xx7tynRy2qeREVcfs5vbc8c=;
	b=lAzZtZCxw/6aXYECgexzQYtdSyjv64lFlmRshOTpU9HYT+U2+MGtQPcgqz6i9KlDpXDLIL
	22fhwEcGrIdYtAYXg3+6ZsIvnlx6lD/M5Pq9ePtsKfDd4g43tw5ZvsIbzVzAmgI04hIs2m
	mtzaisSbiwAmoGV+U5f9lddN6A7p4OQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768471958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkOKVFsE+pvCCubiu+J9xx7tynRy2qeREVcfs5vbc8c=;
	b=lovRlPHIMRK+diPJX07WytOvZ0wNJdpsSd3wAX34daYjbj4ugS9s0qVL7f2q3INur0k7/t
	Zsb8dHhwK1tskXDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="veU/sj9s";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lj0k8vJp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768471957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkOKVFsE+pvCCubiu+J9xx7tynRy2qeREVcfs5vbc8c=;
	b=veU/sj9sscWOwJlvR5u8ip0v8vTZaZm1rPsAFyMY+AcGsewJjseKMx29T2doErtjsyilzN
	Xwyjk+7OuFjazoVpLVB1MY9fUVsGRYeeeSftXKstmKOp/8Q7KfBEefhJxKszXwpl5LTh+u
	Fgs7n+KHSxYhsMXaP/1po75+8LVAbCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768471957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkOKVFsE+pvCCubiu+J9xx7tynRy2qeREVcfs5vbc8c=;
	b=lj0k8vJpBhOgR+uN1cPbCZxJ6h8nb5Pfhh1l1K0m7BlmIKI0MxOTmwLlx6Ap3qawbjXPhG
	IpY7BHHr3mcY0XBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 867AA3EA63;
	Thu, 15 Jan 2026 10:12:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4/2BH5W9aGlydgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 15 Jan 2026 10:12:37 +0000
Date: Thu, 15 Jan 2026 11:12:37 +0100
Message-ID: <87y0lznq0a.wl-tiwai@suse.de>
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
Subject: Re: [PATCH] ALSA: hda/realtek:  Add quirk for HP Pavilion x360 to enable mute LED
In-Reply-To: <20260115015844.3129890-1-zhangheng@kylinos.cn>
References: <20260115015844.3129890-1-zhangheng@kylinos.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.51
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CBC413377C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Thu, 15 Jan 2026 02:58:44 +0100,
Zhang Heng wrote:
> 
> This quirk enables mute LED on HP Pavilion x360 2-in-1 Laptop 14-ek0xxx,
> which use ALC245 codec.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220220
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>

Applied now.  Thanks.


Takashi

