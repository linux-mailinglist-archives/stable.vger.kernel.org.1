Return-Path: <stable+bounces-197636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C59C8C93B6D
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 10:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DC3B34875E
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 09:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22D32773CC;
	Sat, 29 Nov 2025 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JdU+YkPm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hntlWK2j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lbJ0gUT7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2KCT2/wO"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482D626CE36
	for <stable@vger.kernel.org>; Sat, 29 Nov 2025 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764408851; cv=none; b=Mtd+8ydHa5gNmDIhaFOkDsU++mffZeomSWlQzgMTx5cEDChd7oiuS4c5biwGYnUTPTJd5Cm+9WcF7/NaXjA3bhnzSnR878pkWGvRvXTPdRCui9hBokJGsdT3vs7HfOCz3uRiPByH5tDOmUJflankooR3v4jvdUHhOnAxDLjSuLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764408851; c=relaxed/simple;
	bh=4x/5Zc18FlEHr1bMQhxGeUQjQ11p1NUAnxeZNhYJJko=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+eM48AMiD+cltJipj9mkPIIGOVGulfkWCRQ5NUMp/8NpW3jsmNWb+BoRLbPSDLRPQV4cycxlfNz7RvF3x5WosIiBxgSVlxcDy9nO5apG298skSvjlnpfJQQoMcOk49tLRw2guk88Hb8SpVHSqt6ZHDUMdkhNJ0wbvf/cLAoZeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JdU+YkPm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hntlWK2j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lbJ0gUT7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2KCT2/wO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 736295BCC1;
	Sat, 29 Nov 2025 09:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764408845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c2lsPOZeTQ9RQZ04TOJk5LJvYq14wi+N67c/zp4S+PY=;
	b=JdU+YkPmsHaCca7gp4S/R1/xmLK8zfXDJXX+dnOGHeghNQrsSEwLx3IYrWeiheXM0AUQUr
	CXtbC4C07k2htzIY/FouR30D9rO8S8OA9nHQdN3k5F2KO625EvcHS3eClCm/Bx03d7cyaH
	Ktw9YLakOs0NmMPKJAt7wF3teeybxYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764408845;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c2lsPOZeTQ9RQZ04TOJk5LJvYq14wi+N67c/zp4S+PY=;
	b=hntlWK2jkFlZN4M1B/lgpoVCsXI4Mo6XI+VXqII9Au7fXxZ9d+dQYbWN3t+8cPEWSnfceK
	jAsRu5/+sv11mmDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764408843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c2lsPOZeTQ9RQZ04TOJk5LJvYq14wi+N67c/zp4S+PY=;
	b=lbJ0gUT7c2ZhMhXarWY603Hmj2yx+AxK25KffALERvM9JMvKQev25A2S+MqqQZwhHf4oGZ
	QkS++NH3cy3Db14GawyDBzmaOhYpb8IwjBSWbHTE0HO35I8slZY5aw8dlTOZQSXiiwRpZv
	ugXArdbeA1JCniUnoHgCbzG6QVdGj1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764408843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c2lsPOZeTQ9RQZ04TOJk5LJvYq14wi+N67c/zp4S+PY=;
	b=2KCT2/wOIzoj5k0kaLQAN+hQAY7IWNVb5KEF6Iw0/ZQtFR7/Q525y5TL304SGwwN2AYlVO
	+1eFZTjVx5rm5eCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B8BC3EA63;
	Sat, 29 Nov 2025 09:34:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SOEJCQu+KmnuaQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 29 Nov 2025 09:34:03 +0000
Date: Sat, 29 Nov 2025 10:34:02 +0100
Message-ID: <87y0npchdh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Clemens Ladisch <clemens@ladisch.de>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: dice: fix buffer overflow in detect_stream_formats()
In-Reply-To: <SYBPR01MB7881B043FC68B4C0DA40B73DAFDCA@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB7881B043FC68B4C0DA40B73DAFDCA@SYBPR01MB7881.ausprd01.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[outlook.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[ladisch.de,sakamocchi.jp,perex.cz,suse.com,suse.de,vger.kernel.org,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Fri, 28 Nov 2025 05:06:31 +0100,
Junrui Luo wrote:
> 
> The function detect_stream_formats() reads the stream_count value directly
> from a FireWire device without validating it. This can lead to
> out-of-bounds writes when a malicious device provides a stream_count value
> greater than MAX_STREAMS.
> 
> Fix by applying the same validation to both TX and RX stream counts in
> detect_stream_formats().
> 
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Reported-by: Junrui Luo <moonafterrain@outlook.com>
> Fixes: 58579c056c1c ("ALSA: dice: use extended protocol to detect available stream formats")
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Applied now.  Thanks.


Takashi

