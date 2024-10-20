Return-Path: <stable+bounces-86977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2D69A54BC
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 17:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0911B1C20DD0
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 15:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C6219340D;
	Sun, 20 Oct 2024 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xxio5o9R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jb7CmTqp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pXPifta3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lC0U+ql6"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F4E192D82;
	Sun, 20 Oct 2024 15:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729438117; cv=none; b=OTv6dJC/DUyFq5ZTFqpXDGWhcM5ueh3AsGUyOw9HQFLHMreDkUxRMtImIT69/Bb415dXNL2RbmKillZ5AZVds+6O5B7ueMF3XYsnjZokehUW9Acx2rxxQ6GoifYHo2F7P7/7xsNamQF8EAvgzIZsJt3HLmQ+GQIqoaxiz+Ab4Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729438117; c=relaxed/simple;
	bh=AohIeTYNoBoHq94O30qyMyOIqcz8GgmKwpQIk7nurgI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVRPK+rLPmEq7WbaL/DXY4Fo18w0ZLvW4b8UbKb3AQhhSzu5yt9X9kfD3b1iKuqC0vFJE0TLWPGuIJf4rgESeDEA1B+iVLsHoL8EgNAfwpcKW4RMjWHkmDmzDBXnTXWU+P8/g43YA1dwZgQpIVkV7zFSegjpGBXtEwo/xYDXhww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xxio5o9R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jb7CmTqp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pXPifta3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lC0U+ql6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2692C1F7C9;
	Sun, 20 Oct 2024 15:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729438114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fh6IAoOoG0W1zGLc5TCF8ycUpJ7khyu2F7OOmVea+V4=;
	b=Xxio5o9RGj++CDHBdHAMnPTIRTAteW5yn/VjUJJUYnz6gyI47pLgWQbn7L3paFCIs4cTNC
	qPX/qnfusK3Lcwk5HYyI+V25yH8hJSCxQU9NahN1OGaMwovVUbZvXGUmBhiEcmaGP+RDwh
	s9AR7iJX1tdb63GYNOueRyymyrWPQMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729438114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fh6IAoOoG0W1zGLc5TCF8ycUpJ7khyu2F7OOmVea+V4=;
	b=jb7CmTqplHmPQnEBjc5PBU89ffPOpK5O4lPpiS/w13/yF+dUTJgfqumr7Ewh0kSGYivcs7
	qp38ob1iF0KlViDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729438113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fh6IAoOoG0W1zGLc5TCF8ycUpJ7khyu2F7OOmVea+V4=;
	b=pXPifta3GuwrpLw9XsDj2nTjo9ReNDUKwN02wulDhJwqxnzIbqCKaTTtqL2o8cnG0jVocx
	augSLeedDOMZ7pz7Wrqp2jFwO09+eY2UBcx55oLIN6d5ZVtmbjOWgTCRXmcVOLFVgIEdLF
	zEsopSzwK1QrIMcsaMJ+nBbQVlkQdRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729438113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fh6IAoOoG0W1zGLc5TCF8ycUpJ7khyu2F7OOmVea+V4=;
	b=lC0U+ql6/x3nX8tyZzrZzI8nqlawnZOAKMWS4P4Iz2VZcCGTw36EvRms11NDeYsoPhmlQw
	CwDviYtOIOpniiBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2EA213894;
	Sun, 20 Oct 2024 15:28:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WRwrNqAhFWeFagAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 20 Oct 2024 15:28:32 +0000
Date: Sun, 20 Oct 2024 17:29:33 +0200
Message-ID: <87ed4akd2a.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dean Matthew Menezes <dean.menezes@utexas.edu>
Cc: Takashi Iwai <tiwai@suse.de>, stable@vger.kernel.org, regressions@lists.linux.dev,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Linux Sound System <linux-sound@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: No sound on speakers X1 Carbon Gen 12
In-Reply-To: <CAEkK70TWL_me58QZXeJSq+=Ry3jA+CgZJttsgAPz1wP7ywqj6A@mail.gmail.com>
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
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Sun, 20 Oct 2024 17:12:14 +0200,
Dean Matthew Menezes wrote:
> 
> The first change worked to fix the sound from the speaker.

Then please double-check whether my original fix in
  https://lore.kernel.org/87cyjzrutw.wl-tiwai@suse.de
really doesn't bring back the speaker output.

If it's confirmed to be broken, run as root:
  echo 1 > /sys/module/snd_hda_codec/parameters/dump_coef

and get alsa-info.sh outputs from both working and
patched-but-not-working cases again, but at this time, during the
playback.

(Also, please keep Cc.)


thanks,

Takashi

