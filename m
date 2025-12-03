Return-Path: <stable+bounces-199934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AD1CA1D84
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 23:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D2953026B0A
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 22:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAFA2E6CC2;
	Wed,  3 Dec 2025 22:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5ufsYc3"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584BD2D46BB
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764801485; cv=none; b=Q05RE+ZsO5d/4cQuS1FhhQKttYdBWHC7Di/079ce7AlsiJM3hrcfuoq6t0WEqg21M7TJQbPm9PwAbipM7/cEECIVxiWLy+x+rYWJLLCqLRyW3UTAaje8pkAPc1jMNlhNM2gPSWc3wSibkk9n5Kdw/troN5HcBZrQ2fx5AJWs+iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764801485; c=relaxed/simple;
	bh=TMPU0xrGWiZwINZkiG/dk9MKBkGkBQOX2ye2cUmVIjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8jFqAnxmRz7Pd/5Ze63pVrg5Ao2ag0/p7L6cNQEamsitBJD+7IoRnuqDDZfNgPq6XN+4inpmpEkDHyP2wVeoa0RepbgaAqBj2o+rSfeuYkR8KvwtLNqin1oaBUwuzB50jksukvdzKlHt3i5AfW8BzRfqw6tAqLsoNYOuFfciqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5ufsYc3; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b2ea5a44a9so28534485a.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 14:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764801482; x=1765406282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Andm1ZX43Hu18AjXpwZtY2kfGZSXKYycpsTeFL8sOYs=;
        b=U5ufsYc3fSRFZYYyo7PZaniSiq8qwizeAnnojW1DLQb3b+jEJookSt6+q8uTVIhmad
         xlTDnkh+tz0QJDYRinBIwkqeKj2lYddXdlVJOD9Pr50utq1GsYF/P4VoiPXAyY8cHO4v
         uc+kccjTai6Xa9eBzYlfj6JhSXI5vmdXBvNb1w5FVjsKbGnZTErjqGNFbd+HSIhCaQHF
         nqn1HMexqAZ8E7SMtGIIBVzQgLNgOhDsYfZpilYN42mtzfppSmyGTyOOBrwBWOqFbE+4
         D0zG/QdYJMwz3J7IpJA+aNFHBjnfboKgpBi19ITdDmF8HcMmGnufLHcaRDgwrhZzMs61
         J4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764801482; x=1765406282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Andm1ZX43Hu18AjXpwZtY2kfGZSXKYycpsTeFL8sOYs=;
        b=T45BeK2pb5voab6jYV8+tkLYDdM4QUa4BDS06xVqn7+tfg99tA6obsBMNc9PiITD0J
         aJN0X54GQu5vOwhbvBBDkbKwKw9WVjcznwn2fMrE+/ogmsjDUGiH/7fC2uC+PL7C3YV7
         VjkHPh19f/sGnW0wilYGbybLNR5DoJNIIMx9jo2zYrGbrnn4fsqQGe6XdRHZrJS1KhRn
         ZNdeb3DcMSvyM+m0ZiTS4i+tUORkU/OhdyaY/uwgpmxrUAmYrAYlg4nK3szwn2KvnT1P
         1RIEximhSW9a83iL9HgJ/zXMKZeYUmWovgIx6cocXN9H/nH7qaTp7vjZ9QbW62WHmTst
         Yltw==
X-Forwarded-Encrypted: i=1; AJvYcCX5GrG3vCRxucjhKnQKjjN9HrpaMhoXhgYxfCkKXrWhYsOrkmM59iJhwwVqUlM2KiKVmDX3W48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3YdQNN+4MgFiMyNShQtMiPaiKkN0eqPGul+9SMGTwF/wsWS18
	8fqgb9tJmek/6n3doNNT9WvY7qkAaurG7fCjOeQ6U/QZzthgs+zuZAHF928ux2WP+BMXity1EVy
	dESxy3dwzspLt32K8BJtfWBNb0pcv1ZY=
X-Gm-Gg: ASbGnctBMf0RMKmrTK6KDghALoWh4FBInyMG2ndQoZ7FdY1GX19ObXH+4TAn449bpif
	U/yeQMGTnU9B6Cm/dbn0RNaQ16dUoWDbTLCYJnF7uEqlKE1LQiW/9O5RSGyqXLjDrFkAGtFYGH7
	GtOfercUnGKKb5oA+IC9MpbeFHp3a+IWoKaqCzuikElkE0m58T7vKADyHal/zNM+3fuqikAZ7eZ
	5v7r/miUsEqVm9M+WZP2OsHcRW/cZzN2MVMvc/WE72S1lXH5O8rbdOfjTn/3JI4+OnZKhgkDmxi
	Y33AJM5ivHXjqNilvh5arznIew2XJp8WgG1zsPbpiqY+NIyzkRZ341ns4umnVDFgvu0RILrsto4
	YDQJpemnAUnGdTjFKlHGMIrZxqvDkD03BdHGMeDXZCg==
X-Google-Smtp-Source: AGHT+IFytlRyeXS1uo6MPquKUsZiOY2RJ5VrFZffuPwZSJBbbxqOfStW/5ly+RkBCfgIJEDGSlsmPnv0qNRl59F2Dh0=
X-Received: by 2002:a05:620a:28c2:b0:7e8:46ff:baac with SMTP id
 af79cd13be357-8b61812b33emr126161185a.1.1764801481992; Wed, 03 Dec 2025
 14:38:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1597479.1764697506@warthog.procyon.org.uk> <0cf36b63a8f7c807a785f3cbee41beb2@manguebit.org>
In-Reply-To: <0cf36b63a8f7c807a785f3cbee41beb2@manguebit.org>
From: Steve French <smfrench@gmail.com>
Date: Wed, 3 Dec 2025 16:37:49 -0600
X-Gm-Features: AWmQ_blWPzWa-cXgJhnkMvErK2UGojdZhtDpX5kWgWoq-BIPUg0a3Kl05PfYHXs
Message-ID: <CAH2r5mvYVZRayo_dJGbSKYuL73kpBM+PwSiNm39Pr0mt37vx9g@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix handling of a beyond-EOF DIO/unbuffered read
 over SMB1
To: Paulo Alcantara <pc@manguebit.org>
Cc: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>, 
	Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paulo,
Added your reviewed by to David's patches but wanted to doublecheck
that I didn't apply it to too many of them since I couldn't find one
of your notes

Does this look ok for your RB on all 14 of these - or just the SMB1 one one=
?

a6fd899da60f (HEAD -> for-next, origin/for-next, origin/HEAD) cifs:
Remove dead function prototypes
1b7270c879f5 smb: server: defer the initial recv completion logic to
smb_direct_negotiate_recv_work()
9d095775a0cb smb: server: initialize recv_io->cqe.done =3D recv_done just o=
nce
667246dbce2d smb: smbdirect: introduce smbdirect_socket.connect.{lock,work}
2b4e375e4006 cifs: Do some preparation prior to organising the
function declarations
c3bdaf3afd87 cifs: Add a tracepoint to log EIO errors
cb416ff96b83 cifs: Don't need state locking in smb2_get_mid_entry()
a64fa1835237 cifs: Remove the server pointer from smb_message
960cd2e1e28a cifs: Fix specification of function pointers
2fdd780130d1 cifs: Replace SendReceiveBlockingLock() with
SendReceive() plus flags
bb8172e800b3 cifs: Clean up some places where an extra kvec[] was
required for rfc1002
41daa3d4a238 cifs: Make smb1's SendReceive() wrap cifs_send_recv()
3ed72b50d276 cifs: Remove the RFC1002 header from smb_hdr
271b1138e8b4 cifs: Fix handling of a beyond-EOF DIO/unbuffered read over SM=
B1

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
>
> Thanks.
>


--
Thanks,

Steve

