Return-Path: <stable+bounces-225410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Td1bFTgNtWlavwAAu9opvQ
	(envelope-from <stable+bounces-225410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 08:24:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A18DA28BEDF
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 08:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DEE43047E49
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 07:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B2C29ACF7;
	Sat, 14 Mar 2026 07:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6lHSctm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8032952F88
	for <stable@vger.kernel.org>; Sat, 14 Mar 2026 07:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773473072; cv=pass; b=V7ncxHlNUdlY546JFizwQ29QEREi2j6r/vE1BZ0V8TbO5ix03we3DQ0qAd31OCJWj97zhAxxMm0eeAqMnP3m7s+oHGiDapBqLljEM/UeJ91/NcTF1UfwME2BApuK9T70ie0T16n7/iZZ1GtbJFjsCAbVUmhgE7EFsYgUGconBXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773473072; c=relaxed/simple;
	bh=qd1mApvWSGdixoIc5To2ikkz4kciaMH/nUOF9Qefu6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSqnEWsp9Hdu2rSDZT4+5sp6ky4NgdgPnJAimXFZJfQYFgqLeInzWOc7CUq3X/5L13m21wpf6QwZHAxHiXpr78K4BjwOWTBubSN6ss8gaYzRwFXyPj2LdRVTfKQo9q/NsIjAVzyIF8bLIHH8mr0gTwVhomJrZcCCbqU43JIE+Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6lHSctm; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae88e16485so20819255ad.0
        for <stable@vger.kernel.org>; Sat, 14 Mar 2026 00:24:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773473071; cv=none;
        d=google.com; s=arc-20240605;
        b=G942CeqgyrpgoxkodpEAH49a+cKTwUBugErXTrmsvsZJSdvpv7BHdK82SO9gbALrWX
         RPMIbHEtJ4x5uzG3A0baLVl1IAtFo/rX5Hv7sclifZ0jzH3oWfnVi9njOC2sp8u0Ot7D
         /yfcxn+x7qwlTJ4r1VnFtWvRdkxJC47xHoO9LHaCzjzhXpPdLepT223Iw8Wlofz54uUU
         PnUTHlKJM8njzfvljROuCuHYCdkDxitAI4MInNmr3tNGcjI9gLMakU2uSLtq70/RYuNL
         J/e/0o2ibu2ZQhuspJk6M4QTNDLiNaLTCI9t97rx+ufgw6yv4AZJe3Oyn599REdkeh4z
         hprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qd1mApvWSGdixoIc5To2ikkz4kciaMH/nUOF9Qefu6o=;
        fh=zxoxxQQ1tBHnYkhHJ8RUM4rO5AduDnWZovfRFdE8LQ0=;
        b=lkXqRGGSNBGpnkRLdMXpRi3H5yGXuHJ0mKy20hQaS5GKsHrNo8XfAdZiHCtgKYK3Ei
         9stys7pO2ReSMCnOUk74tsrtTI/yTqm9Q18a7BI7oKijAvj4P311fhBxPXNP4u6hvrWn
         CHwx3dsdOQL9t0HE+lUZ0S6XgWpIsIqmsSwHQJ4uPuKKZlhTAUoMmVx6IRGbonBkrbGK
         roiZUp2rqfjUcIwC93qDrjWvjhk6ql/DmFW+4Na7RLN1Pnsx3TgpR61EJU2ZFS/05iKq
         iFBcJYtpX1qQVg8TsZrjqN6KVWh5Pr7eZi/3aCOMZjnIv+7Dq3gfkkmWNDmj8OehmOvF
         0A+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773473071; x=1774077871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd1mApvWSGdixoIc5To2ikkz4kciaMH/nUOF9Qefu6o=;
        b=D6lHSctm/Ja8kNjZu5VMxO5SJO/CS1SpfBE5Komf9ziuvuId3tq0FlYr5p8dD1DpeL
         YxzZQlTNrZkL/Ry9QhsrrqeGwBLUlYemzs0AUj6ldi3sVINozvMf3IILMi9Y3qHtoqPg
         ZfBJ7ifGfD4U01hN5ylbQhuR1FZ2WRxujyhMGM7FKRIWB3DX9d8EEliNu+/PQ9pFUxnd
         3GOwIeOZdP5ny/vS+V5ns8BSxz2tqOQ9V/335hvss1BNwmbWFHkszX5EI8fNHGZnhRZd
         8/BcpS7bpNadHDlcACvTQiqKOEPBFHNVkmPrlJIinM1RWT05j0Bpu0cWus3RjzHL53iQ
         lkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773473071; x=1774077871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qd1mApvWSGdixoIc5To2ikkz4kciaMH/nUOF9Qefu6o=;
        b=MvjEF9mLrW7L8NZtRCxiNI0yMVUiCDtFBwRKMlgtMJKtSCBiBMu4mMRk+Jh8GFeOMM
         NwifSBewZkFSjvQfXrZm+Skq47+8nKFVJMLJq06/uG9gDJnQEUKH6irhgQldapy7coE9
         MAoYO3pHnGhmpb+iGf8cl90jDKAU/Diym9Pyba6f7U+fIeArYOSxeHzmS8lKZ0Xq2gxD
         9+JvLX2DgBLLVGECjXojWAf/+mFF1dMh5GMpdOztsiv4p5hc5WJmoJ2BNstgKA4OL+fU
         A6nmj4utrTmjxV+2zfQjdRkLxWX2aR8m/tqz0icJxjYlBnYJRpVYKWgVmQeY1ypXeZ2m
         Lkug==
X-Forwarded-Encrypted: i=1; AJvYcCUSAL6Jxl4QnMOFznYci53zz29t0y1iHpIeu2viO4XiRymZE6sa48JOa//04ieSRq8aAQTvqPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ewcajsYy3671EgosBikoHXPZVM2lO43Lpe3ZOIOdwjKBYEBo
	p73/UfuaGNzyeaD/FgVjlSY9sY/zeF3dvewc0WlgNtaZ70sPjNLv2EsSjPY9TFI08UdM1j6H6L8
	UkucECQb9HhJ0cPvlZ16vFTxkrj8lIFE=
X-Gm-Gg: ATEYQzwHmxEhY7jBQ601GEiQkBhYKFRfqwsGw9wrqFI7y+0kIcPntTzAi2rt6ey8/fS
	cNwt9m35R90F8aSzXwzdwDKTYL7cH4BdTPAxJ33HhYr5qeopgH7CV4SeabHxvm4CorqU4N6cxlQ
	m545mAhi7tCjp7oAyFolcYhjvHPMTK1z5uJv2osE35aNFjmynsQPpKP1NjLZkBwGkFQwAvmzaF1
	cx2kTLEV6SeKsocy2Vbj1Ka8R1weM//Ft8NuJf7P/PcKjyJyIu+j08YHEblpFbBhOa+QHVfpo2I
	QPq/Fy0=
X-Received: by 2002:a17:903:19e5:b0:2b0:445a:8c7b with SMTP id
 d9443c01a7336-2b0445a8fcemr11849235ad.15.1773473070880; Sat, 14 Mar 2026
 00:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313171659.1225180-1-jhj140711@gmail.com> <abT5tabfYV9a9RF_@codewreck.org>
In-Reply-To: <abT5tabfYV9a9RF_@codewreck.org>
From: Hyungjung Joo <jhj140711@gmail.com>
Date: Sat, 14 Mar 2026 16:24:19 +0900
X-Gm-Features: AaiRm524CjQgXxwQSi91n87psT0kd7Ixm0ZGTwgZZypsCLtk7Hh1FbeoE-z-Zz8
Message-ID: <CAP_j_b9i2n+ZUriWceZJgAKz_MeGMFkRiOz7yCYE4as4T6auVQ@mail.gmail.com>
Subject: Re: [PATCH] net: 9p: usbg: clear stale client pointer on close
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com, 
	m.grzeschik@pengutronix.de, gregkh@linuxfoundation.org, v9fs@lists.linux.dev, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-225410-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhj140711@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codewreck.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A18DA28BEDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for the careful review.

> Just to make sure the problem is the usb9pfs struct being freed, not the
> p9_client itself which is still alive after the usb device is gone
> (until umount)?

The issue I am addressing is the stale use of the usb9pfs->client
association after the transport has been closed. I am not relying on
early free of struct f_usb9pfs for this bug.

The lifetime mismatch here is that struct f_usb9pfs belongs to the
gadget function and can be reused across mount sessions, while
struct p9_client is per-mount. On the close path, p9_usbg_close() did
not detach usb9pfs->client, so late TX/RX completions could still
follow that pointer after close, including into a later remount that
rebinds it.

> I'm surprised free_func isn't called after unbind, which should stop the
> queues (through disable_usb9pfs)?
> or are the ep being disabled not enough to ensure the callbacks are not
> in use? (e.g. disabling prevents further calls, but doesn't wait for
> currently running/queued requests?)

My understanding is that the unbind/free_func path is different from the
close path at issue here. This patch is not trying to change or rely on
gadget teardown ordering; it addresses the close-side race where
usb9pfs->client remained attached and the completion paths still
dereferenced it.

That is why the patch:
- clears usb9pfs->client under usb9pfs->lock on close,
- detaches any pending TX request from in_req->context, and
- makes TX/RX completions bail out once the transport has been detached.

So the intent is to prevent late completions from using a stale or
rebound client association after close, rather than to claim an early
free of the gadget object itself.

Thanks,

2026=EB=85=84 3=EC=9B=94 14=EC=9D=BC (=ED=86=A0) PM 3:01, Dominique Martine=
t <asmadeus@codewreck.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hyungjung Joo wrote on Sat, Mar 14, 2026 at 02:16:59AM +0900:
> > p9_usbg_close() tears down the client transport, but usb9pfs keeps
> > using usb9pfs->client from asynchronous TX and RX completion handlers.
> > A late completion can therefore dereference a client that has already
> > been freed during mount teardown.
> >
> > Clear usb9pfs->client under usb9pfs->lock when closing the transport,
> > detach any pending TX request from in_req->context, and make the TX/RX
> > completion handlers bail out once the transport has been detached. This
> > keeps late completions from touching a freed or rebound p9_client.
>
> Just to make sure the problem is the usb9pfs struct being freed, not the
> p9_client itself which is still alive after the usb device is gone
> (until umount)?
>
> I'm surprised free_func isn't called after unbind, which should stop the
> queues (through disable_usb9pfs)?
> or are the ep being disabled not enough to ensure the callbacks are not
> in use? (e.g. disabling prevents further calls, but doesn't wait for
> currently running/queued requests?)
>
>
> (Also, thanks Michael for looking -- I'll let you do a first review
> before looking deeper)
> --
> Dominique

