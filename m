Return-Path: <stable+bounces-254378-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMHzHe+9FWrYZgcAu9opvQ
	(envelope-from <stable+bounces-254378-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 17:36:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E37875D8D8A
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 17:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B85523094CA1
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 14:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BC54028F0;
	Tue, 26 May 2026 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ayAt3v2a"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25E44028F3
	for <stable@vger.kernel.org>; Tue, 26 May 2026 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807297; cv=pass; b=WDvnv3z6uZBuZqo8PBQyXv6Bc+n/nmbMHQom9lGw/2G86ENnOj7DtZBS/iXwKxf8r/PX3Twf8TOaI39vHQ4gOno7FXTMEADkjqDDcVk0h+A+L0P9sb7/TCBrHr0rEIofXTtW/4JcfJh+lIyGpoYAHJEhBi8qpUKt2WEyvEp99ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807297; c=relaxed/simple;
	bh=AkOucIlmB4Jplha55U+NWq9Hu0uEg/rLFAnM44nrMRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVbMiBaA7e8XsakkXxDxfBk1STZV2RU1RXiw8P7G/L1Kx6ftiHKLhkiG4o3+t/LTfFbHiWGMzMpdxuA3bHiC9by9USFAW1EqlBQTCLz9+YmfTlUqe0lYM5XCF2oZ8/e48ZJy1reY/Uu6c0jeR4k8NVw/CwRLwvSHsy+mLboYxoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ayAt3v2a; arc=pass smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-914cf9248ceso244276885a.1
        for <stable@vger.kernel.org>; Tue, 26 May 2026 07:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779807295; cv=none;
        d=google.com; s=arc-20240605;
        b=PGnkTNALO++a2cwdy/ymObK7lB3I/JkVTqS6yhYKUtOkB3vEtz+oTY0O+q2Eus5uN3
         hnWdjrDHS5uFUwnGR5gQ6LMKSaA/eGgtG28/D1pl8N1dh7MXbA9t0/M8N5AYLTlYgmqy
         P82OqE7QgLxTiyE4bcl+rtV4N+AIclcPIFBV7wnHIYZ0oULp58FcXSGDqcgw0BlyuceO
         hixrnh7noUOILJnXgmOEBZiuid3GaYL4skHhEf43mOvFWQglKpRvS14gE7eL5GMS7a3I
         IFdba4AsKQNbQ4UNgMHUmtGFal9RrxEB9whgJgTJa4xQFmOW/q5ePksLoCZWlpAbc/dr
         uiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AkOucIlmB4Jplha55U+NWq9Hu0uEg/rLFAnM44nrMRM=;
        fh=vXNY9zPZiWfBROdt2Klx3KCvUzX97CUBh0Q/IZc13C0=;
        b=D/W2IcpRnur+fiGcDfVd2OzW6SP1sNpR9RsyFXGNJlJK0PKSRHYGf+nX78HM7lC055
         vkGVm0EJJQXQfaxmcNdy3cIDjB83ZKaVLs98wAioMDdCvKY5aQ41DBd3mVRy6uyKb2gr
         v09RSQvPXxhbRPGHyrQoZrvmNwZkbmY4jPGh+rMzApwBHLSTAYCSXV3ZMxmYigrKkj0h
         8rK0Jh1B2xKmwTrlUuiTvYNRuHG5nkX1VfF1817lvkRaCFNbWbaX+GTJiTIvBPeSNf5v
         q8wSAfrG/0Yi+USf4vJeXKiAu/7NsKA7r8hxbe5QBoNkXhx6g8LvQaC05eLmhq36POHY
         5+sQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1779807295; x=1780412095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AkOucIlmB4Jplha55U+NWq9Hu0uEg/rLFAnM44nrMRM=;
        b=ayAt3v2alZoKk3tfwEQQPrtCCNmz0J9CAv+Hzo7Iktq6eqXDLCxtU46flcf+jiP8z/
         A4Me1NuyDWirQOyEbXhI/qbcAI8ph7XXtXVMWFg3BcSnJXFO3NUHmNKQ+vHnUMt6KV6Z
         PBfSzMzTcQwhliLLBq/jjGYd4z6JEH0Ei1b/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779807295; x=1780412095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkOucIlmB4Jplha55U+NWq9Hu0uEg/rLFAnM44nrMRM=;
        b=l/Qu6un8ZJCydo+/X4eOY/ZCLW1hMmp1h6ct2f/RfG6bIy7W3M2I1dOTiuldxZpzdK
         eczNOQbzv5aH/F3eHSy2x0CGmSrV5sc9Fg8JEJMEUR8By1zW9DpKTHw2aqHmCim43UDc
         Tl+zCHn6byukeYKwxbnbHSfVxKojfes5Ff18aA9XkIK3NWt1jghaYLSW0Z9LdxC60TAY
         xdinenmloB7DdIs220RS9ILDVmT01Jqc3mknVIRxLv8xDlEYw2hiKlxAyuOSz33Y0zFN
         FSiJM13wI+GVucRX4CuhogoNmy7ucxAn7Kbup13/hI4YJ7g1i8Vnxfh3hWx1jLftgbDC
         a2mw==
X-Forwarded-Encrypted: i=1; AFNElJ+4ovRgrjP5PoOQhr5rBVcOrD/iMR81cgCbGlRY8sFaTpO1BACpcoe6ak8FxE9AZVX3KDuKjwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxQDP4b7wRYkLudlq56DSC49Soz+9sqM6O9gNkJ8ItScBRq38M
	h8hY5r99vdIdw/AcqR+Sswn/JP6pUwnNmbneXHEsV+pkLW2QdOKgyOY1sZUH1maesUPL78swUw3
	r403ist0xr+K5ZRcqPOGNlIZJF3JmUcJisohXamk0Yw==
X-Gm-Gg: Acq92OGoslD5kqmDFVl5ZxyKaOFy2hjjUr/wyTjoPU4CbRDvFgKgcKq8nxMj7QJIZUM
	FX+wJ/WoGw7WAyVouM6xUCHXv8N5p2rwwu3fgFNvjtBnW1piInk5gGxsSiDcaKm1bZhyz0AtuQG
	HInPkOTwtUe4lCkHHAXL0PIkWNMhgsPFn22i2IPcWXL0R0UidDBdixwUmn68Nz53J3BTQrbtf2b
	7cHBZIXq0bISrfoPNXPtBxOz0AAgKWFAwlkjiGMgwyGNJg2v9YEiHBl0VRy7aca0W+qUuGBuqK5
	GIGXvAnGN6OrKJUkeZqR7GXKNq2j9tIBJb9aPArTXcHg5fHfHg==
X-Received: by 2002:a05:620a:2794:b0:910:79bc:606c with SMTP id
 af79cd13be357-914b493782fmr2995044585a.19.1779807294679; Tue, 26 May 2026
 07:54:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519052807.1924269-1-joannelkoong@gmail.com>
In-Reply-To: <20260519052807.1924269-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 26 May 2026 16:54:43 +0200
X-Gm-Features: AVHnY4I0pTGLEvHzZLiDytHbS7uJ2Wm3LnrlwKLUWZ9BdsG2wkNTFAMaHZOBdJU
Message-ID: <CAJfpeguWcYphxBjfTyPp9vBnPvF6OmgmXvuy_NxYTB6HH0wyHA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] fuse: re-lock request before replacing page cache folio
To: Joanne Koong <joannelkoong@gmail.com>
Cc: fuse-devel@lists.linux.dev, stable@vger.kernel.org, 
	Lei Lu <llfamsec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254378-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[szeredi.hu:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E37875D8D8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 at 07:41, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> fuse_try_move_folio() unlocks the request on entry but does not
> re-lock it on the success path. This means fuse_chan_abort() can end the
> request and free the fuse_io_args (eg fuse_readpages_end()) while the
> subsequent copy chain logic after fuse_try_move_folio() accesses the
> fuse_io_args, leading to use-after-free issues.
>
> Fix this by calling lock_request() before replace_page_cache_folio().
> This ensures the request is locked on the success path which will
> prevent the fuse_io_args from being freed while the later copying logic
> runs, and also ensures that the ap->folios[i]->mapping is never null
> since ap->folios[i] will always point to the newfolio after
> replace_page_cache_folio().
>
> Fixes: ce534fb05292 ("fuse: allow splice to move pages")
> Cc: <stable@vger.kernel.org>
> Reported-by: Lei Lu <llfamsec@gmail.com>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Looks good, applied both.

Thanks,
Miklos

