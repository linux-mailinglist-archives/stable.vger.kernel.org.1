Return-Path: <stable+bounces-255051-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F4cLYpsGGrpjwgAu9opvQ
	(envelope-from <stable+bounces-255051-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:25:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B305F4F75
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6BA83142E8F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3113F8709;
	Thu, 28 May 2026 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NySxG9P6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s4w6+xv4"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B79044103D
	for <stable@vger.kernel.org>; Thu, 28 May 2026 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779983015; cv=none; b=K0NyV9acXHMnnIuTgzpxPEUfAjoc20dtPFIJlWFgyVbMRC92rPSH1FF7zmLlGerbKZtcYPD0CEX4AkzFgZm/VvFHzyYoAedaJB/hDC/NUX2ir02N053I2D1+B/crZoNHzdIp6NJZDqGMeCgttDcmLSgn20887R0UaVuBIFCUDnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779983015; c=relaxed/simple;
	bh=JOYb1qbpupmLv49/bB8v7lgpwCmHZeUA/4hrn2WUFAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2aNKhGRnbzRMUzQqSJoGp/2pxrb/SRdTxFGlSCRaNUVPBKukM5985mXOi9K3qMOG25AwcNiHsX6IHsKCE06c6Kh5jfZTZtbyPuMKC4UOuuC8x391Zj24OPq0BNy7nonUIIbSU5weMd1kR+v4FS4DW+GM1PNlHiG07xr0ZjimNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NySxG9P6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s4w6+xv4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779983006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oo6OTSed6Z//i2IY96CVe2S4QINrbKUBBFYr5Tsi8EY=;
	b=NySxG9P6I0TkaqZSIh0QKCRvEPFqiDjamcak8PIh39X5HUcQTJpRIp6elOCFrZ+v2gfKaG
	NCPNS0l0uJT2hKx/AoxXhG2jJjHw54c5Sjl9zAqG/MxuCwOSuJ9PMXvOL9GXGgDbYIpuxr
	qre2zsbobSW3QVUI/hfNNe6MKtn3T9o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-L3k9AE3OPLmX9CNJuSFIOg-1; Thu, 28 May 2026 11:43:24 -0400
X-MC-Unique: L3k9AE3OPLmX9CNJuSFIOg-1
X-Mimecast-MFC-AGG-ID: L3k9AE3OPLmX9CNJuSFIOg_1779983004
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45eee3f9f03so295466f8f.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 08:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779983004; x=1780587804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oo6OTSed6Z//i2IY96CVe2S4QINrbKUBBFYr5Tsi8EY=;
        b=s4w6+xv4ZiSVIzzlBsxoKhUt2LOcbyLAVxkW7G54tR8ZTv6TAnhgGfc17kqqWRxqer
         4kKEQMedaK5jKPxSZTLBSOwt90I57MQQcoG6bPBcsGvoLn9Wnbvkdb7czv9vuHNh2HpF
         9/Mcwt+qyhZpv2IwU4UFHwEHb0vf8AagxwqRZElsfRNaqhWPQL1GVQHUhVNmaCnxIyLI
         sWcnLtCtKv5JOLWNMrOfBGZ5WQVyArPz2xIQ8/ATkuF6lANnx0pCH9VChCWkTv+j/qdS
         WOv7sf9skJqUcjeQG09xmmZMi6s91mj8s4w6w01UZKADbjrDPYz1gqY6sljeQ4vmnCXW
         6suQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779983004; x=1780587804;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oo6OTSed6Z//i2IY96CVe2S4QINrbKUBBFYr5Tsi8EY=;
        b=hzmlgwbTWI2pXtLHIKuUXNMH1PZLjBpCGy2KWuLNJxbJFoOYtLqgwlGyAB0XhArKWv
         zZad6GYD9PcJv8W07CZFU0fl3haKs3XAhxjOG0rAApOeXAVWVJwR1NydKGaJrTdtzF4Q
         TXYwpaI3ep0WwHssbXZsJIX6Qvbsgwepg0Hg9Rom+aZjord7FdZrDFsYOO8B11Oc3Y96
         CxhNeUOmlYM9NFwDBf7o6HWJcKqeXt8Uej+6lrMQwiKn5tTuYaMcVI+19xE3aAzeIVQD
         nFshoyQEM6XwoqnyzbAPhdEn5ffA/25tC5Z9X7wRpg2bb2O/Z5lxgy4L+GRr10e9rnxh
         ocDA==
X-Forwarded-Encrypted: i=1; AFNElJ+AIKnNJ8ItS9jR9MLEIJtxfkRIRbHLT4oN8OEDyzfvan7pC2lu5r7AYp2hoVG4ywH35I3GFEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7o2zdKHnGt4enkdAkEEVn0YXyIm9AT83m4sAvKz9+nP2aYgxd
	9tbIV1r59LPwC3Ouk/4X72rgJIJ/pbdJPhn7y65Gzt1k0Wd4ayLrWYFdnJc+VuO9h8nOoAquann
	3i/K/tQ7WO7S6BRRUaYIBE6JJAgzNoRvu2nRU8P8igKlW0/79z4oXEREvnw==
X-Gm-Gg: Acq92OGU6ZuhXWkKOE87BTb3NJBsGu5VXrHkR7Y7iwAiYq4sw5dW1c/xXjKN518tc1V
	i1Qm9KfWoO1tYQETbekl3aa1fEtkiL9g0bGe4U92j7sTVBqMXiHlOZ9ZvwMdPDJ4Ve0M46R7ay7
	evaxHmDrWAYaEU7BRiuVFbRJJo7KwbKnDEstPF73YXY0gFTiHtVczBknEwtED/MwXVV7Yom8IpA
	BskaVFu49t5ZO3ha7C4IQR2XpNXOJPOQWvtowgnD47XCmIMwsod5FtaZP7LdvWmhduQBZWd2Lo/
	Whres3yW0UJBYsXtKNc9XKnxrUOFQZf42e1cm+z+893meUfIXl1zOpAadoqsmKLNEKDXgEtLTtv
	teoI1s+ctdw==
X-Received: by 2002:a05:6000:4917:b0:43d:dd:8ca4 with SMTP id ffacd0b85a97d-45eb36ab5c9mr47695419f8f.14.1779983003722;
        Thu, 28 May 2026 08:43:23 -0700 (PDT)
X-Received: by 2002:a05:6000:4917:b0:43d:dd:8ca4 with SMTP id ffacd0b85a97d-45eb36ab5c9mr47695366f8f.14.1779983003210;
        Thu, 28 May 2026 08:43:23 -0700 (PDT)
Received: from bahia ([2a01:e0a:cc2:66b0::60c0:1640])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb557679sm25169342f8f.10.2026.05.28.08.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 08:43:22 -0700 (PDT)
Date: Thu, 28 May 2026 17:43:18 +0200
From: Greg Kurz <gkurz@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: fuse-devel@lists.linux.dev, =?UTF-8?B?QXVyw6lsaWVu?= Bombo
 <abombo@microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCH] virtiofs: fix UAF on submount umount
Message-ID: <20260528174318.2d97e373@bahia>
In-Reply-To: <20260528142306.1792392-1-mszeredi@redhat.com>
References: <20260528142306.1792392-1-mszeredi@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-255051-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gkurz@redhat.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 56B305F4F75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 16:23:05 +0200
Miklos Szeredi <mszeredi@redhat.com> wrote:

> iput() called from fuse_release_end() can Oops if the super block has
> already been destroyed.  Normally this is prevented by waiting for
> num_waiting to go down to zero before commencing with super block shutdow=
n.
>=20
> This only works, however, for the last submount instance, as the wait
> counter is per connection, not per superblock.
>=20
> Revert to using synchronous release requests for the auto_submounts case,
> which is virtiofs only at this time.
>=20
> Reported-by: Aur=C3=A9lien Bombo <abombo@microsoft.com>
> Cc: Greg Kurz <gkurz@redhat.com>
> Closes: https://github.com/kata-containers/kata-containers/issues/12589
> Fixes: 26e5c67deb2e ("fuse: fix livelock in synchronous file put from fus=
eblk workers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

Great thanks for the quick fix Miklos !

FWIW

Reviewed-by: Greg Kurz <gkurz@redhat.com>

>  fs/fuse/file.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 3bdab8d03373..e8833e2a6610 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -380,8 +380,14 @@ void fuse_file_release(struct inode *inode, struct f=
use_file *ff,
>  	 * aio and closes the fd before the aio completes.  Since aio takes its
>  	 * own ref to the file, the IO completion has to drop the ref, which is
>  	 * how the fuse server can end up closing its clients' files.
> +	 *
> +	 * Exception is virtio-fs, which is not affected by the above (server is
> +	 * on host, cannot close open files in guest).  Virtio-fs needs sync
> +	 * release, because the num_waiting mechanism to wait for all requests
> +	 * before commencing with fs shutdown doesn't work if submounts are
> +	 * used.
>  	 */
> -	fuse_file_put(ff, false);
> +	fuse_file_put(ff, ff->fm->fc->auto_submounts);
>  }
> =20
>  void fuse_release_common(struct file *file, bool isdir)


