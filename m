Return-Path: <stable+bounces-211625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBofGoh5d2n7ggEAu9opvQ
	(envelope-from <stable+bounces-211625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 15:26:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB460896D0
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 15:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 390D5301DAFB
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F9833D6FA;
	Mon, 26 Jan 2026 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1r0HcEp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bb0xGDdK"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C1F33D6DC
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769437573; cv=pass; b=taeSZOmYNsZjJzDtdXaLLPW+3v8zf02nLcv0TCH830PxXWgrb8ngwr9emVSijI+EjLlWsNVLxoITu/RIeasAUo9Usiu5mdydcn8DwVNQ6DMfxJ78iq+l/WbT2UOcoGfb/7ylxPK36wTRbunSxbu5UCWumr/xc1tLLkhE9jMaO6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769437573; c=relaxed/simple;
	bh=R39yI3zrUVBRoImFLGoBqsOKE4XKwQsDK7ICxl0PndA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwBSuEOfJDnD4CgsYhEfuoJDgnRJ6zs4NjLT/NR6h9iopDXcS14wMcOZtOdJ1w0KX3AeB2mX+Cdl4Iga2TkIocBqqes/61n6Ep3fVQxq97einJj0L3UfPDkXV8T7CSllFldgWfWctVqqFrmEkC0O9LFs4Lm6AnGZNu5GxxZxm4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1r0HcEp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bb0xGDdK; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769437571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0LQyvuQCM9ruI9QQbyiNGANsOOzKEFGJPablDXgQe7E=;
	b=F1r0HcEpzuf/FiTeWq1LRSHMXtq09bEROmGTmZTr9hHUUJeCgJqpf+tc2+XOMe//8ze5N8
	Ghb2qBrtp4GBAGSrEv9rgoR4HyqG80lQGR9tgVBsf0GcT6aC91fXDtRtudB7TrlBBP2B/C
	iEHEQw7tpg/JbG85g5jwEB8hwPTiOsM=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-ktTJcFizNReVtg9Ytc_rbg-1; Mon, 26 Jan 2026 09:26:09 -0500
X-MC-Unique: ktTJcFizNReVtg9Ytc_rbg-1
X-Mimecast-MFC-AGG-ID: ktTJcFizNReVtg9Ytc_rbg_1769437569
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-6495d7d6a30so4378652d50.1
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 06:26:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769437569; cv=none;
        d=google.com; s=arc-20240605;
        b=kUoyO3ZhTH2XJFA8UTBBTXJFeuUfWlJJCBXdT8b6LH/U723XSfZMbuAPOWUEyO82no
         5SZ49Djrr92lgAXGa/isK97QBks7bIJy9nygufKLDcqHtCtjZ/YslXliGBaujxamYn/S
         6xuCXGqwwCkZFeXALVngNe+zOcFs2+aI7c+4RvCPgwDvTspubPqgy0KKSHF9iJhD6jNO
         hOH9pIGbdgiyzVlExccv0ravc3/sNoozrsvYj6Vndl6gSOlN412yFvoOL1oMbgsLxiAg
         DUy+KN/S7xx71GIc0a12SzwtHGhpNux7KmxZE2Wi5lbTUcvRS02Qiijo9Gzc7hVT7O+d
         s0lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0LQyvuQCM9ruI9QQbyiNGANsOOzKEFGJPablDXgQe7E=;
        fh=poOVoxbFtcSZvTvguXCvlD/RCcMOoVuJf0f2gHGkau4=;
        b=PZGpyWACGPETzzb1TTU9y584yEHkBAw+vRBTNBmO3R8IFkoaY/NjcsAIQbyLrrnV+l
         2cpe2VxYpPfaTg2BzdGycxm2eUsGEP9odzOuLJKq+N9kfXim5GLtqZuFT9uxAxqypkdn
         y6+Cyrz04CiI6crII+GFj8p6ONRJV3LJ9hB6qFlCxqFWUhgN2LTIwttuoGYJUls39CNF
         RfRTSYf2fCIshsbFw/00tB5/OpVGuO0cw5h8hH04A5kr2NecsJFxB4X66HBbMrVDLIMV
         3/CVjgK1m7OOuLENg2zUdRaxer6f7MQUX0Y3HomWuDLSmRqUedXmBKmsvlDienO2Vn6h
         SdTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769437569; x=1770042369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LQyvuQCM9ruI9QQbyiNGANsOOzKEFGJPablDXgQe7E=;
        b=Bb0xGDdKF6oLwRmRwQK4tk+/tvLobqrdBs9/dVTUfPPspFOnsdCpsmbBc9qCN684yN
         X1SPkIzzBHbhi+rX/iEoA/XmwJF3pL3PTQ+STzEw8s2yWjUpDh7jJGAzxc/pdDntgKtk
         GGqIzrj+63TedDTQCQSteg/YDLin4OnfQgC9d5Fk6tmP8TfJu4rJLkVIBqpQnlAq7cq8
         6unm+Ndm4nUQqsplKgJoIYWawqnF9aJnT/5Hec8uv8V0ElZYNIn2FJhAi1D8K+UYfVtJ
         xPjZD6acQ74gDIsUfBeu47RRLnu50po1tqxIDKYHtpsfVzlGLc6UJwSn9EvK965b1X+1
         gkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769437569; x=1770042369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0LQyvuQCM9ruI9QQbyiNGANsOOzKEFGJPablDXgQe7E=;
        b=QhU5SLNi0X+P8ZPX0fwiRc4FZcUOxcvRvnwNDGKUVxS2M1J3aQ49APyxaNONuqWlz4
         UA/vIXQd+R44/jf9eBaAFqAiKK52elD/q6CWeDgWTPFtDYgB7lVzvKh8Qtncdn0BtBxj
         F9/Twx7ikEZ037ClZ1MpuAG9MPhogvDqynfeHpP0Cu2oR0DRJ86lAKhF4pGQ3O12NPE/
         lHq4JpKGRCi544yp7rvpD8MBuxofN5RCFWSpl76htNHNPtPvTRuUOyqyWXog3kyVB86c
         ioB0E0KV75d/Gf+x4eVD66N6lfWPFDxwgI50voWJuAQ7jynR1ZC9cP17qdXHCNGoK76I
         3+Sg==
X-Gm-Message-State: AOJu0YwtwNqpHcNCiNOATX2OB4JooUp2cbYvNbLGophs7rIEQ3vCzDfD
	hFV2gdxp3MiE8pNWaQ136ygBVOS37/Vyk8ZVwQsumyvBULV4+jOKCV1MPZTwbvmL090/T4CHRI4
	e6+AjXJ/XGubSP4N+hPOj5xT8ijv8wWNznezgdQE2z/Amp9g/gkhCJzZ1Msu8NsJuThExzi7yeE
	qP8PT4O9Q6USloBhiW4X/hAeqn18fXkqHV
X-Gm-Gg: AZuq6aLzjy0iaMn3V0SbFMrN2q8TWOVIDlqsMpuLylqTeyIEQJoSvtf775WagzUi1no
	s7R7vhY8zng1Y5Y2YPDjxEgXBOsdnhliAhDirG50Vl1A9qyMuV10YkoU3M5PWSWCqH89XcvgQH6
	li/e47May4L2iCMzHGTGBNcjKI5LYMp+G4TpsHFWrBvmZfA889EZGZOX8dqnJ3N8Icrq7GkOLAN
	QYwXEZ0HAQxs32FIo9kxWdwIkpBLXSJghjsC/WKXyIkqdmyZq7TOQ==
X-Received: by 2002:a05:690e:d03:b0:649:2e3c:7d6b with SMTP id 956f58d0204a3-64970bcc1b3mr3695908d50.26.1769437569286;
        Mon, 26 Jan 2026 06:26:09 -0800 (PST)
X-Received: by 2002:a05:690e:d03:b0:649:2e3c:7d6b with SMTP id
 956f58d0204a3-64970bcc1b3mr3695891d50.26.1769437568931; Mon, 26 Jan 2026
 06:26:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123153105.797382-1-agruenba@redhat.com> <20260123153105.797382-6-agruenba@redhat.com>
In-Reply-To: <20260123153105.797382-6-agruenba@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 26 Jan 2026 15:25:57 +0100
X-Gm-Features: AZwV_QjE4MMgKxvc4KIUhZ3qTyu6516o9EPDLlxbX-_2X3jlvKviLbQ2yRVzs7c
Message-ID: <CAHc6FU67iqcqCAAg49ygDQ+joRg7pUds++mMMS47gZHKkcQRiQ@mail.gmail.com>
Subject: Re: [PATCH 05/13] Revert "gfs2: Fix use of bio_chain"
To: gfs2@lists.linux.dev
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211625-lists,stable=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[agruenba@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB460896D0
X-Rspamd-Action: no action

(This patch is upstream already.)

On Fri, Jan 23, 2026 at 4:31=E2=80=AFPM Andreas Gruenbacher <agruenba@redha=
t.com> wrote:
>
> This reverts commit 8a157e0a0aa5143b5d94201508c0ca1bb8cfb941.
>
> That commit incorrectly assumed that the bio_chain() arguments were
> swapped in gfs2.  However, gfs2 intentionally constructs bio chains so
> that the first bio's bi_end_io callback is invoked when all bios in the
> chain have completed, unlike bio chains where the last bio's callback is
> invoked.
>
> Fixes: 8a157e0a0aa5 ("gfs2: Fix use of bio_chain")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/gfs2/lops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 97ebe457c00a..d27a0b1080a9 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -484,7 +484,7 @@ static struct bio *gfs2_chain_bio(struct bio *prev, u=
nsigned int nr_iovecs)
>         new =3D bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_NOI=
O);
>         bio_clone_blkg_association(new, prev);
>         new->bi_iter.bi_sector =3D bio_end_sector(prev);
> -       bio_chain(prev, new);
> +       bio_chain(new, prev);
>         submit_bio(prev);
>         return new;
>  }
> --
> 2.52.0
>


