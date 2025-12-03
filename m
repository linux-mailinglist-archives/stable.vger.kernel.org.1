Return-Path: <stable+bounces-199927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C52E2CA1B0E
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 22:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66571300AFFE
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 21:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948232D6E4D;
	Wed,  3 Dec 2025 21:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JopjRNVf"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B902D7814
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798019; cv=none; b=dutvpA8nQ8X+c7jcaIUxB2IWB+QF1O15qZkGDbqA8clUroKChxAABdUQPsHSEXufGM6/lUarmsVQlNgQx2tygcTCBf1183X9Rdzv+TqpbltuD14mIdq1KoMcElbF1mYHVXSY1raH1CypMr5zP2J1dQ1Ia05vW8hFM9jH8fbjoj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798019; c=relaxed/simple;
	bh=4mv07ydDIBDY+yYYyDcrBWUbY7+M8hTG8ElX+6UDZ0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dI6uBaktcQcvowL5rWYjETZoV+5vEvzDN6UfXIlFI5RzVwcYRr0PCQclnqBDWc0Y2ePGu8l9A0UCAF/XtNbKMMyXXjfRXpX4dWz94ZJUIj48WBb4ZODmwE3qBlV322/uRAxFNbTAyQlm9HyNsS328Uw/hX1nH3kVOCjzEjwMV7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JopjRNVf; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ed9c19248bso2335661cf.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 13:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764798016; x=1765402816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4dm3yP8EhvjXM7HY/9hUsT4foK9V8lDuxE0CKRUWT0=;
        b=JopjRNVfU98l9It7LMYoUhECOIZCRNVLf0qZlNdpSwpW5jgp0T66PjPIXbWyNoPj++
         3SRcvNaHbMhd9kwusY/dUlBn8TC9ba7eAsfXVOI3qceQQJHvbOCFy/gq913qo+/ewSb+
         RGaF66b1947U5FPdmNczKYBuMREq7O6Sqq+ja3EokwUNNVE1xQOcrehoouzmKMJhj5Gu
         T3z2VluD5UyRB7LdBzOwQlGFlZT0bivIkXWtnJ2s74Ik4tUlm+la5i4S+XN4FpKiylhK
         x70cgbsdtTJvSjd+jzS6OEU5bFS9B9ejKTcTBuzzG/V6T2fdyEFcrezEWyjd2eAfiq9g
         Ifcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798016; x=1765402816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q4dm3yP8EhvjXM7HY/9hUsT4foK9V8lDuxE0CKRUWT0=;
        b=Wd4DMo0UxtqivrIugu9FV38YH8MkWo2enEm3j+5lRG9oK091c6AlILLqiiGmJiMnLY
         Rjiq2qcVkvsfrZFr23o475yVyYhO+2ArX8NtHJlmsiBIwGUk2bfxU1p9XiINgf+NX4gq
         AXW0MUqXeNWA50uQl2HGHorp3kr6HJALkkhC7ZhRCzc4BqP+yZOr+ugl51qC4thEQIGG
         8M+LqhcBGlRLH74xE627bo+WGDpV5309LEfqYKH13PdXVt40w+T0jjO2CGD91loy0EdP
         sNnsSkjD0YPKMtPa7eUFRoIroHV0hAALl0f9FB51RICUo5SynrQ0zdFMaD7Yp6HV7ydM
         Le5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVh/8gf5zfrEds7pwpSm7EL+F7Sss1pPz90DzJWWnKAIDpWPFCykMsAqWnzd06L6oOBxQXadNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2TPdbORUJtmVDZ/D6M964LS0jWCL9kE8WK8EH7UPz/K9TOQyP
	FZDcGhbZrOreotrqCpchIYpLxD4mcKaPgyIg9ql+4osTiGhZzNe7hT97TxNL0xWBF/fbIdHGovF
	OpI5fWt40HjPPx2vkE8Pa5N9HygDY/xw=
X-Gm-Gg: ASbGncte3/E0jlZV07O2OfIlF791r9vCSYxsRlZlQqLS9DNHxPh+hiIzcs/FOvZwEXu
	CNZ6CeGi8xxHXUaER8GnNLpKde7sWqjl9btiapgHbAGVczLfwYFzZX/3IhedXpwe9LlohOAuz1e
	ZMmk8KrVEqlMTjIC2Co4cFj/7dW5HW1yxCXKpLzPz+E6HXorj1rBo3gQ8a82XX3EJomQrIM7A4o
	W90iEuFjwGtNzR1m+r9PJJsPhwoIv3uhsWhryUp7QpUg+FBlDzLQgDQpqoYj0xy0r0xZ/V27x7b
	REsUQM4FyUJoAjWNI1AZujO7Lo+5yrJnDgXBN2HVF0I8nfaMFPLPjyQTLRNsRw67opg8Tf7cz6N
	dBTmi1yvieDaNnry6v8/8sZcf8HRPVUub+QoQmJyz/EsaidkDQjlMxECE5N0FTsh7zeaN2jK6+G
	+HANWkMQbUpw==
X-Google-Smtp-Source: AGHT+IG1RqtM4CjFZIoV9HQ/AGJf69t++XxRfMRR9/KEWXX168CW0sh0DFIGvs6Sts+Nzs+IjWJ+CH1r+PDY8raGX3I=
X-Received: by 2002:a05:622a:188e:b0:4ee:4a3a:bd10 with SMTP id
 d75a77b69052e-4f017691727mr61297771cf.60.1764798015667; Wed, 03 Dec 2025
 13:40:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1597479.1764697506@warthog.procyon.org.uk> <0cf36b63a8f7c807a785f3cbee41beb2@manguebit.org>
In-Reply-To: <0cf36b63a8f7c807a785f3cbee41beb2@manguebit.org>
From: Steve French <smfrench@gmail.com>
Date: Wed, 3 Dec 2025 15:40:04 -0600
X-Gm-Features: AWmQ_bmPZtnFFmlM888CIxDrVHAGDo88ZyE8SdWbeAXL99pNPNJhCXfBTmmIgG4
Message-ID: <CAH2r5msAgsWfnCt171TcmhvCw39GtQ8nU8SwzrVpP=xw2vGypg@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix handling of a beyond-EOF DIO/unbuffered read
 over SMB1
To: Paulo Alcantara <pc@manguebit.org>
Cc: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>, 
	Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 12:03=E2=80=AFPM Paulo Alcantara <pc@manguebit.org> =
wrote:
>
> David Howells <dhowells@redhat.com> writes:
>
> >
> > If a DIO read or an unbuffered read request extends beyond the EOF, the
> > server will return a short read and a status code indicating that EOF w=
as
> > hit, which gets translated to -ENODATA.  Note that the client does not =
cap
> > the request at i_size, but asks for the amount requested in case there'=
s a
> > race on the server with a third party.
> >
> > Now, on the client side, the request will get split into multiple
> > subrequests if rsize is smaller than the full request size.  A subreque=
st
> > that starts before or at the EOF and returns short data up to the EOF w=
ill
> > be correctly handled, with the NETFS_SREQ_HIT_EOF flag being set,
> > indicating to netfslib that we can't read more.
> >
> > If a subrequest, however, starts after the EOF and not at it, HIT_EOF w=
ill
> > not be flagged, its error will be set to -ENODATA and it will be abando=
ned.
> > This will cause the request as a whole to fail with -ENODATA.
> >
> > Fix this by setting NETFS_SREQ_HIT_EOF on any subrequest that lies beyo=
nd
> > the EOF marker.
> >
> > This can be reproduced by mounting with "cache=3Dnone,sign,vers=3D1.0" =
and
> > doing a read of a file that's significantly bigger than the size of the
> > file (e.g. attempting to read 64KiB from a 16KiB file).
> >
> > Fixes: a68c74865f51 ("cifs: Fix SMB1 readv/writev callback in the same =
way as SMB2/3")
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Steve French <sfrench@samba.org>
> > cc: Paulo Alcantara <pc@manguebit.org>
> > cc: Shyam Prasad N <sprasad@microsoft.com>
> > cc: linux-cifs@vger.kernel.org
> > cc: netfs@lists.linux.dev
> > cc: linux-fsdevel@vger.kernel.org
>
> Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
>
> Dave, looks like we're missing a similar fix for smb2_readv_callback()
> as well.
>
> Can you handle it?

Any luck reproducing it for smb2/smb3/smb3.1.1?

--=20
Thanks,

Steve

