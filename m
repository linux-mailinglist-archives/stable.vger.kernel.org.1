Return-Path: <stable+bounces-249608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uINzKDtzDGqihwUAu9opvQ
	(envelope-from <stable+bounces-249608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:27:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8AB58081E
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 797A130053E8
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D104028FE;
	Tue, 19 May 2026 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hRKJuhlL"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE91C4028DF
	for <stable@vger.kernel.org>; Tue, 19 May 2026 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200528; cv=pass; b=Wt5Ux07fWf+G1tXHLGflvqXIH+gYr8ZTO2aeDAnWOKnpziatH+m2rK0v8eDmCcLrMC8avLHuPx7h9gNj2MsGdbSutsgr8i4E6EnuC1BFIuMiJDEJl4tWEinVq2wwElX4oKTzQ2I6mo4rYlCYgbq9yICQPJ5JSPd3xSKF4GVNG0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200528; c=relaxed/simple;
	bh=y+M1i1Jwkb3OqjTadF8kS1TR5MfxLtXzn9n20tTMyW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBYmygFWtbFQqi6eRgwT7XWieepEKdG0+APH0omvaSrTJG2MCtaIZT06sDDlGG6mHePmM2aNqtWjfxYF2iqYOvlDJ4fWDZ7GFtp6KCcSJLKTafTksu8SzmqrN7DAv+uQvvLu1WGfLYuqVBIAwikv7NQg7BzsH7VkxsWlIJqN//E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=hRKJuhlL; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e5bea4045so27855181cf.3
        for <stable@vger.kernel.org>; Tue, 19 May 2026 07:22:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779200526; cv=none;
        d=google.com; s=arc-20240605;
        b=NUOlxQ0CR/umXG3/PJ1RjFF8BT0+kdk9QggA/hFzEVZeHD23E6LGUxTiOx0QaLsUxZ
         oq/9q0xCBwgDnbfW1JSXiBLlM2FosqhpfmAjlAVtz6CDEj4Ig3hS2dCKzUA+XPLhooyv
         XOEXuTGlqorkGKU223vcXIYUdayrjHx+o+SaFmMMdQcv7/r7BAfbKsU+89+WOUY66/6A
         rmt1M5r6pj94BdLy/dhV+U+Nfs6r3VUuySR4latMCrVk4vB4uG4oCywYDkO25gfRXhUd
         GZIifO65vomy53ONta7TdsQpLo/K2Wvy72SP7R8ctqx56AsZ+nm07Ygtp67+yTvFLsci
         nDpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y+M1i1Jwkb3OqjTadF8kS1TR5MfxLtXzn9n20tTMyW4=;
        fh=Rn+eYcT2x2M6CSQhPkajO40UvhRR/5EYRv4y7Llim5o=;
        b=AM8YDBtXC8ckWQ9+QCFxILoob5CgCEAYaIvB2zs7L35GPXHBKcpTx4CNVKIWJhs81U
         FoejuBhkHWQ2Dzl2TCtuJDCx4XGlLpmhAnxFzlICmbRUvmeRhRkcJb7/K7yE+wFAhkJ6
         pZuXGo13lBm3VOHWQ12hEPS4NxxgVHzUG9r9ZSRBH2RzXaHihDibBfhPCYnhgXowLPiZ
         2oKzqAkgsWCSZjQVCDZvYvkaRi6qb+n8NnNZwNowMPCaoWOh9j7Y0+WcizxmJgG5nCu2
         gVRC2UuwHyTKkutDveK25sxaVhl6CPHaXMMYvMlrR3ViiLzMWScYsYEFHT8dIk02B5/G
         cPIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1779200526; x=1779805326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y+M1i1Jwkb3OqjTadF8kS1TR5MfxLtXzn9n20tTMyW4=;
        b=hRKJuhlL58fyI7+79yckyoy52Q7uISZB+DFfJ2STt94ZK/v0rRuR7uu+4jYm9aZsKF
         7pzSZlsx0jO3F3QeXyZsyo/AKwi/VMj3Ss9LEdGybuKqjH1XYBzSJ76LoY02mPHlAMec
         3M/hGo/NgXzXr/jVvyCUuhMCTDv2Zqrj87fKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779200526; x=1779805326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+M1i1Jwkb3OqjTadF8kS1TR5MfxLtXzn9n20tTMyW4=;
        b=SSvbZzUtwTazHJRB5L81dDVitZjH52FFFIv7rsWIYRdZ4Ga1OFEL2p4anN85WNJh6O
         +ZLvX9YbCGdypjsGvci2/XcUQ2gg0LuKxeu/ds/Wh4w5CeZwP41VsuT7pnwxXR04I8DF
         1kPmtGy1+YRkUAo5Wm0LGwqC+u98NeLYZsIH5q2puz8PDQh06P7z+yroWfjlTUczHBjc
         BA5GOOdlmNK2GMW9xvov1dMB/4NLO4m+9jMACve3Jok1nYXQGRDIqSsQWiFlqQ1H2ClY
         FVsTSY0ekt0Cvt9eF1FfxhqKoLDIlqG2k4A+HyB09/Crso6PQ3DeO+bPcCMPLp0ZU62I
         +HMQ==
X-Forwarded-Encrypted: i=1; AFNElJ+J5jQn+3nAFC3MWC1UlSzK3mg7st9c5TAeTGVRueoRzQCBtuS+65PrNnAedEE9l8VRm+shtcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGyOuT82fkny9shtvNEIu6py9MM5YUs0r5wpU7/aM7wa+HZyyI
	KhglU+DzFD8AMA8wUt1nRaM7HpSif3WE0LGeKkvRC6AZ3AnlT79yyAfCFNfCVVTUpOuDWiJcvV8
	0x7GphqjQozSAxdKgEXiSpVBDmg54/Y29d+2Iguo7Ug==
X-Gm-Gg: Acq92OEBuQk8uY/05nva/bQJAwYGFKv4P8erWgCjwSOtyvfetmEt+4nYk0GaZgs/jz5
	a4vdYkrGjO9EC5K+IolDWpmjd5Kwa9QtWjIPP1A6fGm4uZHzWxFn12vYeCP4a2+wmR4ZP264J7V
	1jKLZ1Xc8wYc8VW12brfqeOHbx220Dvl/UabYq1YqLxLQJCPihHbS5A6+DtUsa/Fu8BoPtgPZWq
	WIlqKt2UUyosAzyvHKBeKNgEIHf6tcsGgY+M81fOryqs/1yW+YbIQn5GgfOsIVpOtcaHP1B1vJy
	1oiaGBO0psdSwwriT/OdYyxWQXzlHmMUb9nSuGk=
X-Received: by 2002:a05:622a:28c:b0:50f:b4c0:62ff with SMTP id
 d75a77b69052e-5165a26a6f9mr287555641cf.54.1779200525585; Tue, 19 May 2026
 07:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519-fuse-dir-pagecache-v1-1-1f060c65930d@google.com>
 <CAJfpegv63pO9k1mvYct_U+aSuiHHVBxCdNgsaj3FhK8ZX_m0Mg@mail.gmail.com> <CAG48ez2gP5nfASBgZe_QiFcAQfnHd2D68gDiofOjxuGix2jajQ@mail.gmail.com>
In-Reply-To: <CAG48ez2gP5nfASBgZe_QiFcAQfnHd2D68gDiofOjxuGix2jajQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 May 2026 16:21:54 +0200
X-Gm-Features: AVHnY4Kj6tkpT6WfW6pmL4BP3mlQS7MBLS5jfC_rf2HODZRB_pKQgRciMoje7gs
Message-ID: <CAJfpegv6N3oQnTmvjNbHYno7nn_4yuy47mKYvUHU76F8bC-asw@mail.gmail.com>
Subject: Re: [PATCH] fuse: reject fuse_notify() pagecache ops on directories
To: Jann Horn <jannh@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-249608-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[szeredi.hu:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+]
X-Rspamd-Queue-Id: CE8AB58081E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 at 16:12, Jann Horn <jannh@google.com> wrote:

> Should it be `!(S_ISREG() || S_ISBLK())` ?
> I think block devices are supposed to act roughly like regular files
> in terms of pagecache, but IDK how that works in the context of FUSE.
> Let me know which way you prefer and I'll send a v2.

Handling I/O on block devices (or any special files for that matter)
is completely out of fuse's control.

So definitely shouldn't allow manipulating the cache for those, though
I don't think it would actually do that since in the case of block
devices the page cache resides in struct block_device, not on the fs's
device node.

Thanks,
Miklos

