Return-Path: <stable+bounces-109593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 156D5A17A1E
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 10:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4675E162914
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 09:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2F81BEF77;
	Tue, 21 Jan 2025 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgFOLCrA"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BDD1BE251
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737451594; cv=none; b=BCb21XlXhY9AklHZAaH+V3fQ3Y9pnqCM05hTWfHjSmK7ApjfEyBbZm/0A052LHbFl6lfPzscWFw1GCwt3dzsQFPlq3/8b+8GNjSxA1vBsGboFUKwZ0B7OGYc4pLhLsJ2MO9353MaBhdIuL7fYTiGv1yxs+munQE09LVHOd7Mnvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737451594; c=relaxed/simple;
	bh=ZcMl9T7RlCjxuLKbwC1f+xswYX0vEeEEzXWmHSpA/RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u36N2U8WIckzs+5YYhMzNBEnz6Zae6SCBLT+G9aSIJPDfJIEfIowep/RVyBGqg3caFg6JJsXw2N0/Bt/dizrPi2LyIKYO87pkwbojm4CLdkutwXD2hWJMUoFsdz/ybNvfeUEi5OE/h9hbXhcze06TpW9lPEn3XnxuxMn4DigOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CgFOLCrA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737451591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcMl9T7RlCjxuLKbwC1f+xswYX0vEeEEzXWmHSpA/RQ=;
	b=CgFOLCrA+D8frHpG+D6DN1+NG6mGXuwK9j0GUn77OR9dpWKX/Qjlml5QhKuehTXLuZnsTS
	LrjvEQgdGQ/GarORehSiYNSxt6DrDyJleFXQLc3adZN7cO9MIiG6btS467DwGh32lmOlB3
	OpZKGxjDwhGG/cx0e0vyIOt1B3mpydY=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-flt5p7mCPuyK9iWxiWwprg-1; Tue, 21 Jan 2025 04:26:30 -0500
X-MC-Unique: flt5p7mCPuyK9iWxiWwprg-1
X-Mimecast-MFC-AGG-ID: flt5p7mCPuyK9iWxiWwprg
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e549b6c54a0so14434666276.3
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 01:26:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737451589; x=1738056389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcMl9T7RlCjxuLKbwC1f+xswYX0vEeEEzXWmHSpA/RQ=;
        b=cxi9IMEtxW9CQ+aVoNu5ZBPGFQPVob7P+ZULr6jVnCx9NGjEKoWzL+Bu2BLloTT8uY
         2EzCSVzyvstBxTe7xvVwXiTDFEeDIH8tnP9puANkdB0To1YBstL+gi1Y8KUkVErvx01t
         BYGyQYkC1Krq8Z1dHZHPRjOYbPyh7PlUJghk8FCL27707zZDwkUXYgnK0kTstbqv4EZi
         w6EvYr+aHGFJcwrWWE5DsZllVohJfvJpwIAnNTzh9Pk5DHLc6coLV/fXWkiZPa8PCqoH
         Ungm2Xz85Pv9dzVtZEE7S7E5Ge/+RuQ9SM621Dt0z2BNiMN20bPLSMj3SNZhWvgQy3Es
         JTYQ==
X-Gm-Message-State: AOJu0YzdrqHmmpzsK+1YGK6YpxJG9aWoKDd/RqgdTEI9p0DyJSqBTD0U
	GN6xZ1lemhlAfHMjWk/yiRIVPYLDBdNdDgsg7ktijscev+vrhBxgXSbhp0Jzxw+jRYqSEyKR781
	egwwQTL59+bcJZz9wusli/irct2iuni6qwUK+g8LAfvVWSFS1L9vuILWQLSszQiwzvcN3HYscUT
	YqPpVyCZoofIs36j3Np+RDwjFCWQlS
X-Gm-Gg: ASbGncsF7SDS7b+Vco47EPBydV3Twlm7Rcxdl6j0WUEP5To7JpcbyYW21h3YN4y40Pk
	q2FXo5X1CgfJPZXLSzx4rI+elcKkxKGqymgOYFj3ZV1Im0FN31iE=
X-Received: by 2002:a05:690c:6d88:b0:6ef:9017:3cc8 with SMTP id 00721157ae682-6f6eb93dd94mr132985687b3.31.1737451589600;
        Tue, 21 Jan 2025 01:26:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPfcV3sMJ9miaggCNDkRQsuOLJFKzmLYHRfMh84OmMxnALANbXEYiHiQp4ay5q/2m8lQnVzMY1CSPQvi2vReo=
X-Received: by 2002:a05:690c:6d88:b0:6ef:9017:3cc8 with SMTP id
 00721157ae682-6f6eb93dd94mr132985577b3.31.1737451589172; Tue, 21 Jan 2025
 01:26:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACW2H-7QEMKA+LUAzFJ+srmRCzSuLk2G7shWt0SGR9SfmxwOjA@mail.gmail.com>
In-Reply-To: <CACW2H-7QEMKA+LUAzFJ+srmRCzSuLk2G7shWt0SGR9SfmxwOjA@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 21 Jan 2025 10:26:17 +0100
X-Gm-Features: AbW1kva06TUn80yX_7OVZOe0yUvWm_8e1UQkb-uvcAJGduBS1LrlbXRwFdyFD3Q
Message-ID: <CAGxU2F4_59X-Fj7vRCoDqM394699uxqLQZ5yCuH+jXUYcYO81g@mail.gmail.com>
Subject: Re: [REGRESSION] vsocket timeout with kata containers agent 3.10.1
 and kernel 6.6.70
To: Simon Kaegi <simon.kaegi@gmail.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	Eric Dumazet <edumazet@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Martin KaFai Lau <kafai@fb.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

On Tue, 21 Jan 2025 at 05:53, Simon Kaegi <simon.kaegi@gmail.com> wrote:
>
> #regzbot introduced v6.6.69..v6.6.70
> #regzbot introduced: ad91a2dacbf8c26a446658cdd55e8324dfeff1e7
>
> We hit this regression when updating our guest vm kernel from 6.6.69
> to 6.6.70 -- bisecting, this problem was introduced in
> ad91a2dacbf8c26a446658cdd55e8324dfeff1e7 -- net: restrict SO_REUSEPORT
> to inet sockets
>
> We're getting a timeout when trying to connect to the vsocket in the
> guest VM when launching a kata containers 3.10.1 agent which
> unsurprisingly ... uses a vsocket to communicate back to the host.
>
> We updated this commit and added an additional sk_is_vsock check and
> recompiled and this works correctly for us.
> - if (valbool && !sk_is_inet(sk))
> + if (valbool && !(sk_is_inet(sk) || sk_is_vsock(sk)))
>
> My understanding is limited here so I've added Stefano as he is likely
> to better understand what makes sense here.

Thanks for adding me, do you have a reproducer here?

AFAIK in AF_VSOCK we never supported SO_REUSEPORT, so it seems strange to me.

I understand that the patch you refer to actually changes the behavior
of setsockopt(..., SO_REUSEPORT, ...) on an AF_VSOCK socket, where it
used to return successfully before that change, but now returns an
error, but subsequent binds should have still failed even without this
patch.

Do you actually use the SO_REUSEPORT feature on AF_VSOCK?

If so, I need to better understand if the core socket does anything,
but as I recall AF_VSOCK allocates ports internally, so I don't think
multiple binds on the same port have ever been supported.

Thanks,
Stefano


