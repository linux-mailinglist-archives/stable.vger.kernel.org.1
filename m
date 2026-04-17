Return-Path: <stable+bounces-238523-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id p6JVHKa04mls9QAAu9opvQ
	(envelope-from <stable+bounces-238523-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 00:31:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DE241EE3C
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 00:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A529F308CAD1
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 22:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816A836BCC9;
	Fri, 17 Apr 2026 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rg/1NLTD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RldPmhHS"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E505233DEE1
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776464929; cv=none; b=G7/mzgAtn9qjDgFJAunB3crrgsIuiyDTbsTtqjJy6ft4fiXKUdevrvXAYv+HoYbqB2xSxzmLuWZoApCFRXKXl+WPLQCpPP8ThaY7Zo6tdAOVJPPIhN1oaDC9CwCwVd2+KKaXFlrqPVWtB+t4prOaVIrIxpyrSWjbc9fT3K1ldsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776464929; c=relaxed/simple;
	bh=CUSSV5p2YNglH8yPy1E8JDrOG79TDiAp+XCyWPGEBX4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FyoYbQLLx7baPZoI+QmSV5HJAk04jnsLeo7LN2FSjdRXdieLvDkm71kVf+Bmdv8zaTvyiZR+MyKSNEINxpH+mEcUk6ZRKz/FVe7w+Bx8tmKgCeqb1HILMMh0kE6p8tsJMm4Mz5WkpEew6MECTn6MFLjiYexZ8Zd+RUtz6AmWrXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rg/1NLTD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RldPmhHS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776464927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPGF7Ew89bjaKVcHHIJ03y3YXUs4N+R29ZKBHaopb5o=;
	b=Rg/1NLTD3vQUJHCaIldZ1A26UcZnkNK40y146V2yGcGUMn/oPMTajWZViyl/7W7Zy1QaSF
	tEyvVH6uCD5eqnWsgvie2/K5CuV7DtHViT2uKnCawRV2+vaPHjfCJx6SLi/BU14wq0rV2b
	0bZ4OdYr0lpmPRc+mmZaLQP8jO4Tbkw=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-OKhLZsFNOFO69188oiNwWA-1; Fri, 17 Apr 2026 18:28:44 -0400
X-MC-Unique: OKhLZsFNOFO69188oiNwWA-1
X-Mimecast-MFC-AGG-ID: OKhLZsFNOFO69188oiNwWA_1776464924
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-64eb0bbab48so2714116d50.1
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 15:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776464924; x=1777069724; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zPGF7Ew89bjaKVcHHIJ03y3YXUs4N+R29ZKBHaopb5o=;
        b=RldPmhHSi9XdhZexy0uYqXcuBaMCt2+wy66czE9K5rya09/Gz9okmAZ6Nw40C7uHZ4
         fqNceZcjlG67SgpW93YJyGSWY/O0DXlPFpJyePEQhDoqkfRwPAJrulNOFvpgedJw0tHt
         pYZReKQqvgYEMpHmqIZOngul/P950cnOUM8a3rgLkyc36/PeDFIJ81nvBq16WvnB8qru
         PwRk8cA03AhFEYCESwaWreVSFlGkkBC+s5XQgmWpln+jj4uxmWQ23CTaHTem95809O0k
         t0Q9/MxZdXoSmcKEQNB32lqN1T3FOXJ53j5PbDSQOsDSvYBKdv25vhuGaXyesvJqYooS
         dkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776464924; x=1777069724;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPGF7Ew89bjaKVcHHIJ03y3YXUs4N+R29ZKBHaopb5o=;
        b=TteNVxdI7J3Po54wstBi5dYD/0f/+nyHHT3xHxEGTYKcaX5beTBOMWbmkTRVwIBCBT
         j1mrfXnytZ7yiwedU7NPv6GsWTnsdh4tQIOmmdajn4r0Qx1+u8voMOs3SgwpW5v8NdAp
         p3ZRMzIVCZ1vD0vJ2KyuNTI6vqRhO8v/jb9vByEnjahrzbH29P9QmgIUmP7nXgXoVY9v
         jxG4I/NX21jppBZvFLT2UMh+QU7bYTEIMuGr66WdbCjlZm9shXzX+RR3Hnp0IO/76BI3
         IwSJzr/UDpWPys+LobN7ZcxjxDFiFC0Hx0n3GnsD3glQUhTZkzCYbpmmERbJ8Hf3XZ9t
         eZ3g==
X-Forwarded-Encrypted: i=1; AFNElJ/4UBmdgBrBdoT3qmHjTmmGwCJTpvcWgNsusYGKh5nCCYoB4I8ssDBplR7/HcKfSs1gN9VBHlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI5/HHyBZ24P5Zr8tBQQDQe2EJFNQT8tL1SWgjOWrwVVpc5+1o
	gjejPcR62VDKiVnplas2qEhQ2I8v9MueCBzVG+wr+WackFgfk7qfLxsiRXJpaKXjlmCB1rtkNpM
	xRSUxrL6aKZQ3BVWrx7rIvRbNU3A4X69I6ZaDBfHlh32S+aNhyYV0WqNoJA==
X-Gm-Gg: AeBDievDItBF+KemNSFm9GeTaPUnk61taQ7AlP/EluSKVcQH6b74yO/1pMLUAB1OSOC
	W52iJqS9sZNiiBIQKFKa/FjpTfH7J2LKo4gc2DGidw3tzgjEkTdIIwdHOPwkD0qxh+LNdRJEr9g
	QLPmne0PHDtvrOJuRdss8oPugvc8eE2tQZUsQkkzeytd4kjxQyHNHzxfj5rXjPU4KdaPNIy9l57
	cluuCglkqOeZYdsQ8TNoBcY8SwSJsXH+XjkVdDKHqCaDSxgeBSer0IFiJHQgVY8ssft9eds7AKq
	wNlSs/QSpYGiBrB5zIVOBbJT8Fi/SYU3QGCsad95y+OqGYEKrDk6/x4XqggVGEsR85xaM4Z/4rT
	M1vAKKjs3TLfN8yeLdRKtverY7TpzyqAGoNQvAYQKUTqcjuIOw5wvQXWBlUb456Y=
X-Received: by 2002:a05:690e:43c7:b0:653:1b50:4ffd with SMTP id 956f58d0204a3-6531b505654mr1366076d50.26.1776464924226;
        Fri, 17 Apr 2026 15:28:44 -0700 (PDT)
X-Received: by 2002:a05:690e:43c7:b0:653:1b50:4ffd with SMTP id 956f58d0204a3-6531b505654mr1366067d50.26.1776464923830;
        Fri, 17 Apr 2026 15:28:43 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314ea3ee2sm1338811d50.16.2026.04.17.15.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 15:28:43 -0700 (PDT)
Message-ID: <c60b92d963294d97e5e02b52d05d5854edc4bf8b.camel@redhat.com>
Subject: Re: [PATCH] hfsplus: zero-initialize data buffer in
 hfs_bnode_read_u16 and hfs_bnode_read_u8
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Tristan Madani <tristmd@gmail.com>, Andrew Morton
	 <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+217eb327242d08197efb@syzkaller.appspotmail.com,
 stable@vger.kernel.org,  Tristan Madani <tristan@talencesecurity.com>,
 Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Date: Fri, 17 Apr 2026 15:28:41 -0700
In-Reply-To: <20260417193913.338982-1-tristan@talencesecurity.com>
References: <20260417193913.338982-1-tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-238523-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdubeyko@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,217eb327242d08197efb];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: A2DE241EE3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-04-17 at 19:39 +0000, Tristan Madani wrote:
> hfs_bnode_read_u16() and hfs_bnode_read_u8() declare local data
> variables without initialization, then pass them to hfs_bnode_read().
>=20
> When hfs_bnode_read() returns early due to an invalid offset on a
> corrupted HFS+ image (the is_bnode_offset_valid() check), the data
> buffer is never written and the functions return uninitialized stack
> data.  KMSAN flags this as a use of uninitialized memory.
>=20
> Zero-initialize both data variables so that an early return from
> hfs_bnode_read() produces a deterministic zero value instead of
> stack garbage.
>=20
> Reported-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D217eb327242d08197efb
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  fs/hfsplus/bnode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index 14f4995588ff..4404cd35c192 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -96,7 +96,7 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, =
int off, int len)
> =20
>  u16 hfs_bnode_read_u16(struct hfs_bnode *node, int off)
>  {
> -	__be16 data;
> +	__be16 data =3D 0;
>  	/* TODO: optimize later... */
>  	hfs_bnode_read(node, &data, off, 2);
>  	return be16_to_cpu(data);
> @@ -104,7 +104,7 @@ u16 hfs_bnode_read_u16(struct hfs_bnode *node, int of=
f)
> =20
>  u8 hfs_bnode_read_u8(struct hfs_bnode *node, int off)
>  {
> -	u8 data;
> +	u8 data =3D 0;
>  	/* TODO: optimize later... */
>  	hfs_bnode_read(node, &data, off, 1);
>  	return data;

Both methods hfs_bnode_read_u16() and hfs_bnode_read_u8() call the
hfs_bnode_read(). And it is widely used method. We need to make initializat=
ion
at all places where hfs_bnode_read() is called. Oppositely, we can initiali=
ze
buffer in hfs_bnode_read() itself.

Thanks,
Slava.


