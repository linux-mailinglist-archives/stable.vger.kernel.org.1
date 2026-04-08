Return-Path: <stable+bounces-233754-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEswHB/g1WkW+wcAu9opvQ
	(envelope-from <stable+bounces-233754-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 06:57:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BF53B704B
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 06:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57DB230157F4
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 04:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BC9352C39;
	Wed,  8 Apr 2026 04:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWotXj7H"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E534E765
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 04:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775624216; cv=none; b=P1r5vA/xpyZTDwbBRUe2Rzd32NAP+knAPJpyC3/vh/rNkWYUlBF5bsAWczbAVUg/fbZxhNil+ZmrQQypabhQ89PkMfVb4l4Qk4vNQZal96o13wWA9EoeeNBdawcU0Q9ycmQEEdwWb44LEBXM6QI1dUG4jRpxo9hz9kVajgVtY3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775624216; c=relaxed/simple;
	bh=XEkNsmWLejJaEAa2btyI+2+LS9nihG6p+YzF1yRW+TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXk04eNAn+sqp4+0TuJCGA6A1jxFfDpGctOMaZipRmB1Jakf6dEHzhU2TKJAQpnfs4cXTy+McOwYQ0voMCK6mK+EbMx/Qm3wsd9fOAJcCOwfclAowhJtRLAhiqyp6HRJT084OHN/VZcWWWSl5yi0SJL8r+3a/3UjY32v63+B+Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWotXj7H; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-126ea4b77adso6868706c88.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 21:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775624215; x=1776229015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+jJXI3O21KfFgoB4qZzgO2BFty+d1rzq3Wn8c+oB3WA=;
        b=FWotXj7HuNUUpOTdkd/qKRj0CfbTZDwXp2EzSNlvFHEAS8da3TCLr/rJI15COOTn6t
         pzQXnvMYE09u2yaZkl//WhQmmY35cO8hJeL6xcGNcvnmQ18NK8RPsbm3kKiz38IM9b8k
         +VHaU5UbYmkSGYJvIN5mYRGxJ/YQM6nN5jdVMlwgO7Bq6kz/Kef7kXCsqeOiyQe8u06F
         5s4IMtPV5MFof4hA7i8GFd6jI3ZC6yEg/276WCQiQD6NYduAWT0ZT7zHi/++4x68v8U0
         uAPeYbL/PZTNhtHsB0KrBBQbId2b+oApnPb98aqFmHS3wganPrLUHYkf9rcJ4QbqWM90
         yh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775624215; x=1776229015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jJXI3O21KfFgoB4qZzgO2BFty+d1rzq3Wn8c+oB3WA=;
        b=JV/OzRg9KZb1gRAhtdxiMSlSdAU/AET9SSzCwlrME3kEapE5ikFIxSmDYLg8oH8mjI
         HDzQXSPtLGgLSYgGlxrTsi+tLVn3714OlsK169km/R3erdft023JWHnOcUGmknI1IdUZ
         AqlLfFo8MwxB6BBhmpCYyLZqQ8C3eoYPJoQWKgBICOwET7ZWOGOI/VMYa4t1VQIKMqfL
         v192GeN0LKOubAs4C2A2wNTxNeVB5zmiOBdpwrtetu7wXHhjuYiWOwsHAXJvLr1DZOAy
         SKrOm+Ti0Ae5kzZaQWotNSQoa3pkGuzPt84NZG9eVdsLQQdzCEhBJUzGoWlFmdMtehOl
         YhSg==
X-Forwarded-Encrypted: i=1; AJvYcCVJh6Rk69lVTdrFxMrVrenj/K/i+3CM6P+m7pjF8nurg0NBAv8WtE0TEb+KS61fumAE407E5qc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7BewXIdjaQ7m/gadBnzxYWOfE45iPvyXht2aBUtrMRgGB9tCg
	HGcFZNbTEeB9k0PfhukmaTlaDZyOA536VtsSOWDPg31p/rVoxt2jN6P+
X-Gm-Gg: AeBDiesDuEDwuozmJ6nSjtAPZ+f9dlQxjhbFVbuyR4VFaCLqTtUzHMBOGGpDiGktVUJ
	/aIwWZGZ138xTTKQygY6CevyRYRK6FwGIGolRpAti6YegVSl+sFkDK8mXkiQhRpUk8koNzYgqOO
	BNygIwwTuDAd+QGOYvjIlxYeCtCYm0asO3Zn2TvE4u5JLlGUVCXNS51pIWeNchZ6BD/S72UoO/G
	k3N5xfTAOuj2/YJzJMTNo9+6uXiBdRKmDQCVWr0FnWxT33jIi6tKdN0ZYbYDsDvrI8lDTqGMida
	R1z0NM8HvoUFwC00bz9FrOk60gM2TowbsUq17cohrMLv4KJqVMXh5NX3Tdz0mKPC4tVDH6kI0BN
	yQk6y1PrabSB3omEpcMQ31/NW1v4QuBwUNry5/NtfmJ6/58S9LPEshPf5UbmkOxn7GocG90XF8J
	P0njZaenAXtwFLX75u4DnTDibi100DIqQs6wP1M71M2xsr0KGq95K6ANR4G9VDzKBl5TiRBbHRw
	M0=
X-Received: by 2002:a05:7022:b9c:b0:119:e56c:18ab with SMTP id a92af1059eb24-12bfb760b8cmr8584264c88.19.1775624214588;
        Tue, 07 Apr 2026 21:56:54 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:4faa:4b67:d989:bce2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cc0c6ec215sm17449902eec.4.2026.04.07.21.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 21:56:52 -0700 (PDT)
Date: Tue, 7 Apr 2026 21:56:49 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: uinput - fix circular locking dependency with
 ff-core
Message-ID: <adXgDI9yOU5L-7D-@google.com>
References: <20260407075031.38351-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407075031.38351-1-mikhail.v.gavrilov@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233754-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32BF53B704B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 12:50:31PM +0500, Mikhail Gavrilov wrote:
> A lockdep circular locking dependency warning can be triggered
> reproducibly when using a force-feedback gamepad with uinput (for
> example, playing ELDEN RING under Wine with a Flydigi Vader 5
> controller):
> 
>   ff->mutex -> udev->mutex -> input_mutex -> dev->mutex -> ff->mutex
> 
> The cycle is caused by four lock acquisition paths:
> 
> 1. ff upload: input_ff_upload() holds ff->mutex and calls
>    uinput_dev_upload_effect() -> uinput_request_submit() ->
>    uinput_request_send(), which acquires udev->mutex.
> 
> 2. device create: uinput_ioctl_handler() holds udev->mutex and calls
>    uinput_create_device() -> input_register_device(), which acquires
>    input_mutex.
> 
> 3. device register: input_register_device() holds input_mutex and
>    calls kbd_connect() -> input_register_handle(), which acquires
>    dev->mutex.
> 
> 4. evdev release: evdev_release() calls input_flush_device() under
>    dev->mutex, which calls input_ff_flush() acquiring ff->mutex.
> 
> Fix this by introducing a new state_lock spinlock to protect
> udev->state and udev->dev access in uinput_request_send() instead of
> acquiring udev->mutex.  The function only needs to atomically check
> device state and queue an input event into the ring buffer via
> uinput_dev_event() -- both operations are safe under a spinlock
> (ktime_get_ts64() and wake_up_interruptible() do not sleep).  This
> breaks the ff->mutex -> udev->mutex link since a spinlock is a leaf in
> the lock ordering and cannot form cycles with mutexes.
> 
> To keep state transitions visible to uinput_request_send(), protect
> writes to udev->state in uinput_create_device() and
> uinput_destroy_device() with the same state_lock spinlock.
> 
> Additionally, move init_completion(&request->done) from
> uinput_request_send() to uinput_request_submit() before
> uinput_request_reserve_slot().  Once the slot is allocated,
> uinput_flush_requests() may call complete() on it at any time from
> the destroy path, so the completion must be initialised before the
> request becomes visible.
> 
> Lock ordering after the fix:
> 
>   ff->mutex -> state_lock (spinlock, leaf)
>   udev->mutex -> state_lock (spinlock, leaf)
>   udev->mutex -> input_mutex -> dev->mutex -> ff->mutex (no back-edge)
> 
> Fixes: ff462551235d ("Input: uinput - switch to the new FF interface")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/CABXGCsMoxag+kEwHhb7KqhuyxfmGGd0P=tHZyb1uKE0pLr8Hkg@mail.gmail.com/
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Applied, thank you.

-- 
Dmitry

