Return-Path: <stable+bounces-86995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A899A5BD5
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 08:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DADC41C2166C
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 06:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3781D0E1F;
	Mon, 21 Oct 2024 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G0SsZITy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f83Z5ZGi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G0SsZITy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f83Z5ZGi"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A02515575F;
	Mon, 21 Oct 2024 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729493905; cv=none; b=jYKp/slPhsKzA4jN+DkajulghkOUYbHySkyI0YJorFOsdyU9321yj7D5qWbD2iQgrp1X42YSm1paVV29p5UTjJMa9fXYO7rkUSSFli4nUK+90GncgkVtUWZ0wsXMDPdIiABKshULlL1WEOCim85noxCBU1qOznA94ojYI/cHS9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729493905; c=relaxed/simple;
	bh=r1+ajr7Ccwf7FOPyRsv4iUP8Vg0NULxF2RXxTqvkaE8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5LWlHKhQh4kq+yYLTwk6x36XAsGyXy+I8quwlJbF3V51w5Ex34+XMCwQCa7xVWDeg5B0zu9UUMGMLRaiIj1BgFQsaat8pDAjWshPISH02Bg/O5aFakeH/dH8BpeGRuAs8lgRQS7i59DTFPwk4jaicXtE9HLmMX0Ds47X8zDDKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G0SsZITy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f83Z5ZGi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G0SsZITy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f83Z5ZGi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F92D1F837;
	Mon, 21 Oct 2024 06:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729493902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cDCKhgt17/0zSP9EdOjd4+p9m7LLtZDhPqilc4vY7lM=;
	b=G0SsZITyGknuCE00Lxvrgo35SF8FtupXEYBzfk68SWNhpc+58sCcVSh+2+6IKARfhiD7EJ
	jd4kKkFi85d3jLfi4S7np7p9aOKX4w4o1BkYArReKUzQTjRpgu2GLXmIaIt0xf6iGc/ev1
	yOyN4n79UGT7eLDUNtcjwuAExt1yp6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729493902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cDCKhgt17/0zSP9EdOjd4+p9m7LLtZDhPqilc4vY7lM=;
	b=f83Z5ZGi4bC7GSjU6VUeKLfDky2k+YpWmokhVVc0QMNNtyLRl1S2ZV8WgmLhX/FuTYaNjt
	giJ08F2bV5Z4JWAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=G0SsZITy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=f83Z5ZGi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729493902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cDCKhgt17/0zSP9EdOjd4+p9m7LLtZDhPqilc4vY7lM=;
	b=G0SsZITyGknuCE00Lxvrgo35SF8FtupXEYBzfk68SWNhpc+58sCcVSh+2+6IKARfhiD7EJ
	jd4kKkFi85d3jLfi4S7np7p9aOKX4w4o1BkYArReKUzQTjRpgu2GLXmIaIt0xf6iGc/ev1
	yOyN4n79UGT7eLDUNtcjwuAExt1yp6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729493902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cDCKhgt17/0zSP9EdOjd4+p9m7LLtZDhPqilc4vY7lM=;
	b=f83Z5ZGi4bC7GSjU6VUeKLfDky2k+YpWmokhVVc0QMNNtyLRl1S2ZV8WgmLhX/FuTYaNjt
	giJ08F2bV5Z4JWAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAB0C136DC;
	Mon, 21 Oct 2024 06:58:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T/oXNI37FWfrRgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 21 Oct 2024 06:58:21 +0000
Date: Mon, 21 Oct 2024 08:59:22 +0200
Message-ID: <877ca2j60l.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dean Matthew Menezes <dean.menezes@utexas.edu>
Cc: Takashi Iwai <tiwai@suse.de>,
	Kailang Yang <kailang@realtek.com>,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Linux Sound System <linux-sound@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: No sound on speakers X1 Carbon Gen 12
In-Reply-To: <CAEkK70SgwaFNcxni2JUAfz7Ne9a_kdkdLRTOR53uhNzJkBQ3+A@mail.gmail.com>
References: <CAEkK70Tke7UxMEEKgRLMntSYeMqiv0PC8st72VYnBVQD-KcqVw@mail.gmail.com>
	<2024101613-giggling-ceremony-aae7@gregkh>
	<433b8579-e181-40e6-9eac-815d73993b23@leemhuis.info>
	<87bjzktncb.wl-tiwai@suse.de>
	<CAEkK70TAk26HFgrz4ZS0jz4T2Eu3LWcG-JD1Ov_2ffMp66oO-g@mail.gmail.com>
	<87cyjzrutw.wl-tiwai@suse.de>
	<CAEkK70T7NBRA1dZHBwAC7mNeXPo-dby4c7Nn=SYg0vzeHHt-1A@mail.gmail.com>
	<87ttd8jyu3.wl-tiwai@suse.de>
	<CAEkK70RAWRjRp6_=bSrecSXXMfnepC2P2YriaHUqicv5x5wJWw@mail.gmail.com>
	<87h697jl6c.wl-tiwai@suse.de>
	<CAEkK70TWL_me58QZXeJSq+=Ry3jA+CgZJttsgAPz1wP7ywqj6A@mail.gmail.com>
	<87ed4akd2a.wl-tiwai@suse.de>
	<87bjzekcva.wl-tiwai@suse.de>
	<CAEkK70SgwaFNcxni2JUAfz7Ne9a_kdkdLRTOR53uhNzJkBQ3+A@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 2F92D1F837
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 21 Oct 2024 03:30:13 +0200,
Dean Matthew Menezes wrote:
> 
> I can confirm that the original fix does not bring back the speaker
> output.  I have attached both outputs for alsa-info.sh

Thanks!  This confirms that the only significant difference is the
COEF data between working and patched-non-working cases.

Kailang, I guess this model (X1 Carbon Gen 12) isn't with ALC1318,
hence your quirk rather influences badly.  Or may the GPIO3 workaround
have the similar effect?

As of now, the possible fix is to simply remove the quirk entries for
ALC1318.  But I'd need to know which model was targeted for your
original fix in commit 1e707769df07 and whether the regressed model is
with ALC1318.


Takashi

