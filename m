Return-Path: <stable+bounces-247045-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC+VCRIABWrxRAIAu9opvQ
	(envelope-from <stable+bounces-247045-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 00:49:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 866AC53BA32
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 00:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B656E301CA44
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 22:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4122E38F250;
	Wed, 13 May 2026 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfBgfsZr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A933890F3
	for <stable@vger.kernel.org>; Wed, 13 May 2026 22:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778712461; cv=pass; b=L+ystIPuwvAsk414bxz8T+uU9LD+ZAQkNmBknq9qJn0BpHUURZkP3Wi9vQgaoOAvsLsldZFUCjNTCRKnAZvvs/DBjeJ1atrcFxQ38BnASkA1pJDkP5EDKRL6DZLxfE7y/vMa0zgDeL+0mgQjGrPgW5V/nndOq37lee9h0mA4EIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778712461; c=relaxed/simple;
	bh=dXe6VfIuGFH67gxrK9sy/rNh6PopvHLZ1zdITLllg90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZZsGLyyWRR0sl9lYutBi6gZUoR2I1wPX5kkKkaz+bnATfk42+zMFgIRSvgYg8jd3yfb5XvPREXqkbPDxXR27wAdOC5CG1xqSjuRiPXs9eyCIrQzAq5zCGdw3QBdwYwEAL+U0K35E1qFW2/HIOFHd9nJuCWzc1z0lS+pCeR1w2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfBgfsZr; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so122099525e9.2
        for <stable@vger.kernel.org>; Wed, 13 May 2026 15:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778712458; cv=none;
        d=google.com; s=arc-20240605;
        b=fdCOZdQwOrgOSXe64d3hDqjEOe7Ppfn1akxaeNN4tFAMUmIQe4Nudnn8CmgN/Kk3jt
         rgHcIGvLbbXv7D7FQaNFB34N5JtRXJnyGXmUfSp32G0zj1t2rI+LyOGlJks5Dj62i+LQ
         CkJZWOQlUBlP1lXroH6Jy4Touec5FglBer5GYWQnbpD0aEzPFs1ewEzS1UDKm09BN+Rw
         /s/nHGRNxKX8Wq8+tYHFlhn6n9p0hfcOoFExIZf8FIf7HH0kBuJj1ngTaXw1i9zUUj4O
         kLXQ+TarCE8WYNmsOqsCOxW2zq4q2kH3e+3y5/xUXX/GLHh2xGSsL0M5GYz0SQbwKEd1
         0/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dXe6VfIuGFH67gxrK9sy/rNh6PopvHLZ1zdITLllg90=;
        fh=5wYgt6ruji0/61PAVHgbF/872cQW+H2RFuCSzvgyKDs=;
        b=O7isVmS9nuq1tru96ikrvmzfhqUNv8ls8V3PdjfI7IriL+R0H6OLVrsJEdg5mtFhQE
         h2PD3mRkY2kdpNklyjT04OfMT/Eqs37o/1V9ZkYC+WtNUAG3Yu4OQ2BsE7OFw3tD3OYW
         srIJvi/rktEsxXFjx7srXc5aNLSbTrMYxImtB3cZeqIiSe+4bDA4RTUrOaJb045AhsYE
         TAlKCHKQKeqHKABaxKQ6rXgn5TIZx0RrlQn8AoAuckIW2NdrXPnXfnDwsTsekBcpy2LJ
         lwtW+AMhx5HaavFOaKqJ+6f4uvwXA6srZWiJPD5EHOZIWVfSA4FhvOYEdOoKNm1Y2Ppv
         tg0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778712458; x=1779317258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXe6VfIuGFH67gxrK9sy/rNh6PopvHLZ1zdITLllg90=;
        b=bfBgfsZr2yZrt8h4au8cOFQ0bOJuJVm0rgM0hyZzfrIJdXeRAklUfcnmQhoOkegPFy
         hUn4uhE0TF0qVrAGH9IcQzOdHb2ouNVsxLrDxlsn0jThGneh0rADuYjX8j7bMZ8FmN0t
         1YIj4C3AXnNkXns7r/5zCaNQcJBX7/KGCvntAyC7uzzmznocrQn++E4EQuDSvyfB5lOg
         fHgKLGjl68P8j7+ljdpYxveNYl98MlZTyqxjx1V2hAa7c7zumqDOOMabAz/KadRPHz5G
         1sdQDEhPyQoiS0aAgVahqteQRsy4u0iEsu0kxMayTlZN0q8ppESAdz6AQ9iZj5d4AePT
         e3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778712458; x=1779317258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dXe6VfIuGFH67gxrK9sy/rNh6PopvHLZ1zdITLllg90=;
        b=eK8froXSX/e6JXC5sLF82hu/2hl+J80M7J0Rkr3iAnokU6+izXIL8b9UPs+8cXurh2
         moHTAYRrtHHgKr2Gi6MJ6ZdyheSc49hvyGP2RwvO8oT1ZfUesoA7n5Kt1CWuBrkew4WB
         B8OFPR15zzDSk4p5TvHjge6Z/5NcSCqZZHqEv0rG5C4Wb2p2znVupwG43oJ4/G+aAeWc
         plu38/JewJK6+kkniagFSy3CWlkO+uHROgICvk7Offr/3FFpUozAx8gS8o1HCvGRFpAn
         6nAONd53XQTPV8irhl6zT02J2DdkHIp9k6XoptcQdR2w4gL7GQU1VSRLsRJ9KwJOL4U1
         fROA==
X-Forwarded-Encrypted: i=1; AFNElJ/2QN72JC4I8khl6SUwseNkAc1IiVHHFp/qO92HLcvwR5goPd8tnuUs0eAEmuWCKm86cKTIc5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3e4oc2/VEyl9DEUq0mN/sqRTZgN1pfMZJbjC/QsJ4RsuZt6Vf
	c2TGta5cJ5jln/DePJrf1k01UBy/L8gN2JenBol0IbFE+BgYmWhmvqZBfUnakGBhG9SYKPGcc6h
	Cj9n/VDPaz+q/0hz+Q9mdKSROnNwBbd8=
X-Gm-Gg: Acq92OHptF8iY0wM549CVfbeeo8crnYy7/QF0VX3FX/f1Uwuo4/VkMC85zvEUBBe754
	TTdU0htWvzttOboBWvTXu5g6qhEWBYV5Fst9gEgf7a83CBUVK+dCQdSZzxVk2wlqENoWOz0Ad8m
	OFGVmBOlFyiUelZ0VMpmidYeOtHx/6tg1jckhDNvLzSbKA9DdZBv4NG1FtQ16A8Z+LH97Ax7iWD
	sGRSybYYrJGNb3ZwovRXLSYDRJjpqVRVwbw4mHYF1ma72KMghnbFZClanGKidsSjUxnXcOI54y5
	wj+TV3a5B14OQ2b9
X-Received: by 2002:a05:600c:19ca:b0:48d:46a:6e5b with SMTP id
 5b1f17b1804b1-48fce9b9fb4mr64471415e9.7.1778712457857; Wed, 13 May 2026
 15:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512200448.3818665-1-joannelkoong@gmail.com> <CAOQ4uxhAbS+pQiOygY9m+UzqnuuWL9+Y0hj40Nck7_8NX0Xh_Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxhAbS+pQiOygY9m+UzqnuuWL9+Y0hj40Nck7_8NX0Xh_Q@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 13 May 2026 15:47:25 -0700
X-Gm-Features: AVHnY4K2G6L0igALgPi3k3y4keZWWbBkviejUU1uIjOG-CNWZJUCbMnRbxluwK0
Message-ID: <CAJnrk1aZDaPrr2D3xrccK6ixigwWX=J=kfXz5JBE90Y0eOcbeA@mail.gmail.com>
Subject: Re: [PATCH v1] fuse: use copy_splice_read() for FOPEN_DIRECT_IO
 splice read
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, fuse-devel@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 866AC53BA32
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247045-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 3:20=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, May 12, 2026 at 10:05=E2=80=AFPM Joanne Koong <joannelkoong@gmail=
.com> wrote:
> >
> > When FOPEN_DIRECT_IO is set, fuse_splice_read() calls
> > filemap_splice_read(), which populates the pipe with pages from the fus=
e
> > inode's page cache.
> >
> > This contradicts FOPEN_DIRECT_IO, which is set by the server to indicat=
e
> > that the page cache should be bypassed entirely.
>
> Generally speaking, this statement is not 100% accurate if you consider
> mmap(), so "page cache should be bypassed entirely" is a bit strong,
> but I agree that this is a good goal to aspire to.

Thanks for taking a look at this. I'll update this with more accurate
wording and send out v2.

Thanks,
Joanne

