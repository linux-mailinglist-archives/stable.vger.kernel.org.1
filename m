Return-Path: <stable+bounces-255040-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFgTAbVYGGoQjQgAu9opvQ
	(envelope-from <stable+bounces-255040-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:01:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6775F411F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FA30301BA7B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F8948C402;
	Thu, 28 May 2026 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DKXluEVU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEBB3F86F1
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779980054; cv=pass; b=GUPrYDtLShjKdjABnYDV3hGpJqVOx2I7rXTsPoNkXbzeStnwSikCUu4A9n8DbWtTAdPMSghJ1fO5Im1VujJyu4OUAF+G0YHh9X0rFkbTHuStOHyOkqPLEZPl07Djxoyl7AGVAzlUg+4G/k0+5SeisOENOnljHHpNprMbMFo9/3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779980054; c=relaxed/simple;
	bh=BnmP4dPy4FDVByFtz0lAGPhCBqLsWkN0Jv1LQoJfels=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/3+v2JMin8SG5rAbzVItyfYfa0JuUOSEgjKM+3V/SkuJ2rwkrXHxPn2/ImcPB/Osq1tQ2CfBvkZbILdu4myhPtEC+Pd2rv4d4BcrWYY7OtijdmUL4luMgKp+wjbRJZsLzCJXaN1PfbelkLOR4Sr6zYTtzebTlEvM4/u+ampJZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DKXluEVU; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-689be822f34so7137433a12.0
        for <stable@vger.kernel.org>; Thu, 28 May 2026 07:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779980048; cv=none;
        d=google.com; s=arc-20240605;
        b=IEhA9KCvwxbPBZwciwwAWG9Z63W5jGT0Bc6sB+RLE135q6ametVbgGQina8vfAscc+
         pR+CbYSSCNqiqQ5V4UCADP1yG6eqxD1enkQVxkV9lZK9qOGKFgGSLqMiCfsDa9pDJR/+
         jEzAlnS0i94OFwcJCXp8J9rmKn/EOAPe160ej2Cz4AM+XgNgYbuoPh/rr/nYr1wZYl8j
         I7gnt6GuWBYAricoQCM7GUvDXgd4RhVUawCNtwwC2l/HIVN9j0iZinfx1wEN75dzNy6O
         JCF4K9VxX6+zdHMwlnU3bme3/M6ShkI79/8fYXRdPKeTQ7rp9WHGW8v+IUGS8otUtYev
         /jlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9OXz/l5MhiOrtGyFdSgSY2UmTjKKZnnagh0u7LsCdfw=;
        fh=1Ho7w/CB0dF13B8fQId2fY1FUlOe69QBFSXolcCIIz4=;
        b=YvN/guvTxNZdTFwkFi4Tassmh7iOiLtIyzNUTpcnbn6DxDj3sN2hRO7KDSeS9Aynmv
         FhJp4BuNLzk5ENeDLQwjJHcgVJNyknRSF1K7p8Ej+dLoQb432jzyp+tzOM3stEwB5uuf
         9kVV/aIdmbM1TOXB0mdFRK/nr4AJU9JjcKSCB835g+ScOZl1h4DwRphaeDQ3Jpr/AwHl
         6deBZIDLehCD0dQB19SP51R/ntRVrc0RIJrI39tY4QH8OWIymzVmMjMeSsj4pNrJ3lWs
         aw8fASQQSuHdI9AiTPMtYeP1sUyA0t8qBWfv5s9VVFH5SVMsxzzSMu1KV4IuE0Tvx3sR
         A6YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779980048; x=1780584848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OXz/l5MhiOrtGyFdSgSY2UmTjKKZnnagh0u7LsCdfw=;
        b=DKXluEVU2BkFOC8xGrZ55LgCv54YARMWCPmGaXEHvx6/VqPxH15uNPr+ePOcntXtiO
         /OwXIyqM517513rCSgRFYhdHTnuWopY14uqJLHePM2AOVLRLHsOSKHF4XYmEcGIWnVmP
         I0fe7iDXJRInKlhTHAG3iYUO/xTl5UWZwlWaKQzm0MvnDdR/ojpVhm8GHL4aIARG3Oho
         FnKuqlMdlRQZHqeuz98Dj6Pzv838ZDvFMiciO83e2XhwIIe92bgPEbV1G+upfY8VrNdc
         ngeonglUM1S1f8FpsGztnJo7Di8NLFODVvDc/wYQPz7gMuzQg6FRZJZwkjgtX75yE699
         RAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779980048; x=1780584848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9OXz/l5MhiOrtGyFdSgSY2UmTjKKZnnagh0u7LsCdfw=;
        b=EsN0NDt9VcCU2iTUIzKWCwLEBixjakOA0DvfdkyzOiJeFG7x0DoZDNqE1e7LojP4QN
         nh0yD1QmNox9twlaYgE3ujaQGXxo/WRVYcN2UL/LmyX8XzzGQDj6ycWJKVSj5jCNi7CC
         xMO09h12NL9aUO4TlWCQ4Lr1jn/4nuynv4fnuXDHcvXa2kN0iGFiccwxHpD2eV7NqYn3
         qBnroN5Gsp8Qf4XG68xHoWP40AoJKt+5y54SbNFj6acGb6TLktVR1WOwQJAzJ/QjYlHj
         S+nVns9ko+Ah5ITJHaxSrYe5tOFNwUGu8F/gkcEtg0NUa6FNAYS62r8g2wA926gdF39H
         sifg==
X-Forwarded-Encrypted: i=1; AFNElJ/R5IMSyMclN8jPYxd2TzLaUaYlecXI4P54dABQBeTBaytWY/ME+dyXHLJ3TRg+y/9ZPibpibk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBrX05GppcvKxFJhta+bAzVdxWZPndzPzoRJ0zd7j6tE0LUUs0
	K8WU0WoD7soaG3WsDD5mjltrbg5/5SfZdYtFh+Tx5Hz6gXGfgeGvE+ahCNvMRV++N991GQiLy8w
	FvDaINHebJ8kktyL2wBJyCFC7noLVo9rD5TFN9n/vJT5+vRO9i1Sb
X-Gm-Gg: Acq92OFvHau3c2lKbxSoDHf7r+T6CbqmuwxaeXN/jFDQ3BcjXf/+0QGt7uMzfYtLcHW
	yNk16myIdQM2j0ZvgOd5bSCcTFspRD7bNr/eC1UHtk+tIY7gfD1xzZ7auZUO3eCw0VUd7ZRv4tz
	JKPPWocYppHx76nTDZk3eJJ/IexYLdMqz5xrhK5wBS1NhG5VyG6Y0V/3qYdctN5LtVJPeJL4MPc
	eK8kJ/42kQSI629Ua317fpuiZv7dGFwcV0c7sjRpICPcLTHVlh3TsquW4VdqpOY6Xp2JseKqwPl
	L8t93bEDY9hmlBSjLfm21mtrKmg1+9FJbpGaLWFm0ch4sTvb
X-Received: by 2002:a17:907:75d9:b0:bbe:37ee:8a2b with SMTP id
 a640c23a62f3a-bdd279ce23fmr1206290366b.33.1779980047494; Thu, 28 May 2026
 07:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523181446.69525-1-devnexen@gmail.com> <ae16f5c2-c6d9-4274-9a27-f87bfe931b1f@amd.com>
In-Reply-To: <ae16f5c2-c6d9-4274-9a27-f87bfe931b1f@amd.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 28 May 2026 20:23:52 +0530
X-Gm-Features: AVHnY4LutoQ-7Ka86XumSZSoxXa9nFy3SHyGiarPBSsSmWM-nR_geKS3HNuAjkA
Message-ID: <CAO_48GFOZESPnm5iLa0D+4itq7hjc9EyRUjMY4QwN5EsLn97SQ@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: fix UAF in dma_buf_fd() tracepoint
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Carlier <devnexen@gmail.com>, gaoxiang17@xiaomi.com, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+7f4987d0afb97dd090cb@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255040-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[linaro.org:query timed out,appspotmail.com:query timed out];
	FREEMAIL_CC(0.00)[gmail.com,xiaomi.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[devnexen.gmail.com:query timed out,christian.koenig.amd.com:query timed out,stable.vger.kernel.org:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.semwal@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,7f4987d0afb97dd090cb];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email,mail.gmail.com:mid,linaro.org:dkim,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 8D6775F411F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

On Tue, 26 May 2026 at 00:25, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> On 5/23/26 20:14, David Carlier wrote:
> > Once FD_ADD() returns, the fd is live in the file descriptor table
> > and a thread sharing that table can close() it before DMA_BUF_TRACE()
> > runs. The close drops the last reference, __fput() frees the dma_buf,
> > and the tracepoint then dereferences dmabuf to take dmabuf->name_lock
> > -- slab-use-after-free.
> >
> > Split FD_ADD() back into get_unused_fd_flags() + fd_install() and
> > emit the tracepoint between them. While the fdtable slot is reserved
> > with a NULL file pointer, a racing close() returns -EBADF without
> > entering __fput(), so the dma_buf stays alive across the trace. Same
> > approach as commit 2d76319c4cbb ("dma-buf: fix UAF in dma_buf_put()
> > tracepoint").
> >
> > This undoes the FD_ADD() conversion done in commit 34dfce523c90
> > ("dma: convert dma_buf_fd() to FD_ADD()"); FD_ADD() has no place to
> > hook the tracepoint safely.
> >
> > Reported-by: syzbot+7f4987d0afb97dd090cb@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D7f4987d0afb97dd090cb
> > Fixes: 281a22631423 ("dma-buf: add some tracepoints to debug.")
> > Cc: stable@vger.kernel.org # 7.0.x
> > Signed-off-by: David Carlier <devnexen@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Thanks very much for the patch; applied to drm-misc-fixes.
>
> > ---
> >  drivers/dma-buf/dma-buf.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 71f37544a5c6..d504c636dc29 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -792,9 +792,13 @@ int dma_buf_fd(struct dma_buf *dmabuf, int flags)
> >         if (!dmabuf || !dmabuf->file)
> >                 return -EINVAL;
> >
> > -       fd =3D FD_ADD(flags, dmabuf->file);
> > +       fd =3D get_unused_fd_flags(flags);
> > +       if (fd < 0)
> > +               return fd;
> > +
> >         DMA_BUF_TRACE(trace_dma_buf_fd, dmabuf, fd);
> >
> > +       fd_install(fd, dmabuf->file);
> >         return fd;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(dma_buf_fd, "DMA_BUF");
> > --
> > 2.53.0
> >
>

Best,
Sumit.

