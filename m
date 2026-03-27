Return-Path: <stable+bounces-230665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ2eKuyUxml7MQUAu9opvQ
	(envelope-from <stable+bounces-230665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 15:32:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 194293461C3
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 15:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D8F230E1024
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 14:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2E33F23AA;
	Fri, 27 Mar 2026 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFD6LXEw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2A53F0A84
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621549; cv=pass; b=MiyKAF1vDwswtuaJE+I4fB12YaPBe2oinm/rhcLYyF4XcYwccVfyxgNth5zfziW2JDVr9/3/X0s5WbrmEiAnDVpVOwFZdHLZQeYbz4qWtjCOweJthlW8z78jQsc59fjiBlsHFs/F70uAsP2whrn2Ev/bXruzAkX+LqzHHEvz/m8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621549; c=relaxed/simple;
	bh=Y9XqaeQh8OozS3JKs8ke6BoMKRYt2QxRWf/1HB35n+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3s9En7KlzwEqT66+p5zKjbm7XJK1t3pJ+H2i0jaTVRjOWeBgFUQPpXmPhWUwrCePjd5LCi6bJZOl4kNKEbECiWblJPOhLMYvWbBu2Q+pa9XuLf1mJkbKe7gKDBIDNMC01GjFHJVGqELfNLxIEHV4FI+24nqXNEzZ0qRP96WClM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFD6LXEw; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d1872504cbso1995931a34.0
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 07:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774621546; cv=none;
        d=google.com; s=arc-20240605;
        b=HFKFV44j62mHQnwUDXMEJESashnk3Ek52DdqxRJJi3UJ6MSoSL/F4LulRQWLp0aJax
         POxSshYBh+1wjkCoM8JdiCDpUDT1xLMCwg9fY5vd2FLIXCoTi+N/Ei387N7xCQ28DDEq
         xVs9UrWu+IJPOklbxU+N/n7aIKQ25exyEtlk91USvM9tPnPk9oxj/jme77mi1vEHhSO/
         +bYBYg7GKP+wh0b1HicHFUsVg/6anRJPJB5fIMwDB3NP5tcybQIOBcimCAJw5NL5JhgY
         5TjNUhmSvlS3BHQW2Jpv11As87ZmY8ZOhMhDjcNtS5hZda6yMEE4vhROGMTYWi1lM3tZ
         FEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4CkbRyLOqwqwWGIOpFw2bUHzgPgIG2tUM7yOxEtSZu8=;
        fh=AAbkKzzW0BWQakSapxzlCwoNv0/wq66WfCsocPX7LZI=;
        b=Xs8UDSTD906Ymz4XEz6JiX6eGeouvFrQQVlgRdI2OYQPj7zgL3sJYp+kcQ/Eo5awyD
         igIrehkoyRGokChSTjcIVGM7Jp6yc3HaU0+QvmV6wfSjCBhFR73cWVldZlSSjIWc+Goq
         vSrp0plKAsc8bPvqrCH/nXsyQW4+Yc3ovlTchLF34KJ0Gxb17kn3t5dAYymHXZLjRFg4
         MV6kg4FtMif8u5/Ax3Lv3mCkJTqttbasyw2afJALdKtn+vpnY5DlvNIostBVinwKOfv6
         aW3XgjnkWZwZC52hIEE8Y3K+SqoQ3dIkLcbKCpzotVa/oyF6Xz58Yj7P3OFbnJKK3OlZ
         If/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774621546; x=1775226346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CkbRyLOqwqwWGIOpFw2bUHzgPgIG2tUM7yOxEtSZu8=;
        b=JFD6LXEwFeaqS74S8TP1GUQxztH5YVnEEAuTIsjFlLNMMQwuA5O15nqZyBe4QxpxD4
         r7WvUtsCaSRoVEmGI3HF45D3130Jkcyz7do3O57wiDQY6KrOL2Thvr06ODf4deCdifpq
         gN4K4pjgclY84O2SHOVfSv0zpzNgzgkXxNqc8YyQED21sNSAwKcajP4speg6g583ZRbf
         yewzE4K6ryVsa+YCbQOnsb/y0qug6j6lZLbpQbbDLi989pJBzYRikHcbJSK+AZV4+eo5
         SbsqBCglQJyTRp7r0OsZ1K6m0GYJDIwA/Ik3wfzg8naQQYHw9A/iOPgdRydt1VI3Q1Az
         iqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621546; x=1775226346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4CkbRyLOqwqwWGIOpFw2bUHzgPgIG2tUM7yOxEtSZu8=;
        b=fOSds+uIBjTISg0b9cBv/JIV5m3lsNQulwg5rjWQRfhyzBoBB9sldRinzjPMcNQ5lu
         f3kjqYN0YgAJXNbBF7TTkAdr+ix6pf0sVcLQvL3AWj2n6/edzwPR6c1WmlBinrn57lpK
         2mSD2BX9Q8ccUd3Y8BCQbyWtcl6oYPmO/8g3AZr3saY/OZraRHQwvp9MUbjgIfm22Ii3
         Wv6l1CmYWTaVZJxMYEHKmBvLxQgEm+j2T2qi6GwaJL9tE7wiOV99vM6+LORW8496glj1
         SUVl2u4j87Wc3QauN4GNGNffLqAQ/fXyxYmJCpHWyYAwvv4vjcL8tpCfRy7Gt4J0UF9Q
         Z43A==
X-Forwarded-Encrypted: i=1; AJvYcCV+0dNOmWuGav8PXtYpnPgOskhs8exdC4ovYVG7dA+m7kHCdzLy5nq9+osnI11CDiRB0Ma+dB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykMPLx5G45MxDKbUEOPMjyDCDaBEYizlzpnCbsqG06Qqt/mS99
	Qvwilbtq4YeLl8NNrSJgtPHLr4v7kzioq/VWeHKA7mLfSpyPH5E9+pzPHJJh335f2DqdU/IVrEk
	cHM/BpDg7tOjKVBYHwqWsAh5m47ZbOaI=
X-Gm-Gg: ATEYQzwU87PNDWjbErMRXyoPT0A9VW0UpDkDupBfbx6hcDrL+nQZ6348rFGA6vkY1S6
	u9BpUuVaTWrcvr9FIG9khCnFUf/hK3J9aA4r0jVs2dqnXN8mvxgQ/YYUouxZ1GPq6TlKTEgnx05
	I4vEjkVd5QcZPXJqkH7lo453DX4Eg3XP45OMsAgJWo/tY2bjsBSyvq7s/NEuP0bT1LJmhpaALaE
	dmkTEkMbKrACOCJvfSzJz5Oamr838Ogo9ClqXCq/Jn3w0/ppmOe+n3NcUG7h7giG7V1lSpkXf0Z
	MxPqlIdaKVqXbtSpMQ==
X-Received: by 2002:a9d:7dc5:0:b0:7d7:45b7:ed8a with SMTP id
 46e09a7af769-7d9ee135024mr2298331a34.5.1774621546467; Fri, 27 Mar 2026
 07:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317053653.28888-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260317053653.28888-1-mikhail.v.gavrilov@gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 27 Mar 2026 19:25:33 +0500
X-Gm-Features: AQROBzAfh4NA1agUQwts4_skWqTwNVSjJPXSowustcL8qGk_2W0rk3crVq32Jhw
Message-ID: <CABXGCsOCjQQ65uO3c8DFGx+ErLtn9jSVnktb3MgVdHRfU2pbVw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf/udmabuf: skip redundant cpu sync to fix cacheline
 EEXIST warning
To: kraxel@redhat.com, vivek.kasireddy@intel.com
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230665-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 194293461C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 10:37=E2=80=AFAM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> When CONFIG_DMA_API_DEBUG_SG is enabled, importing a udmabuf into a DRM
> driver (e.g. amdgpu for video playback in GNOME Videos / Showtime)
> triggers a spurious warning:
>
>   DMA-API: amdgpu 0000:03:00.0: cacheline tracking EEXIST, \
>       overlapping mappings aren't supported
>   WARNING: kernel/dma/debug.c:619 at add_dma_entry+0x473/0x5f0
>
> The call chain is:
>
>   amdgpu_cs_ioctl
>    -> amdgpu_ttm_backend_bind
>     -> dma_buf_map_attachment
>      -> [udmabuf] map_udmabuf -> get_sg_table
>       -> dma_map_sgtable(dev, sg, direction, 0)  // attrs=3D0
>        -> debug_dma_map_sg -> add_dma_entry -> EEXIST
>
> This happens because udmabuf builds a per-page scatter-gather list via
> sg_set_folio().  When begin_cpu_udmabuf() has already created an sg
> table mapped for the misc device, and an importer such as amdgpu maps
> the same pages for its own device via map_udmabuf(), the DMA debug
> infrastructure sees two active mappings whose physical addresses share
> cacheline boundaries and warns about the overlap.
>
> The DMA_ATTR_SKIP_CPU_SYNC flag suppresses this check in
> add_dma_entry() because it signals that no CPU cache maintenance is
> performed at map/unmap time, making the cacheline overlap harmless.
>
> All other major dma-buf exporters already pass this flag:
>   - drm_gem_map_dma_buf() passes DMA_ATTR_SKIP_CPU_SYNC
>   - amdgpu_dma_buf_map() passes DMA_ATTR_SKIP_CPU_SYNC
>
> The CPU sync at map/unmap time is also redundant for udmabuf:
> begin_cpu_udmabuf() and end_cpu_udmabuf() already perform explicit
> cache synchronization via dma_sync_sgtable_for_cpu/device() when CPU
> access is requested through the dma-buf interface.
>
> Pass DMA_ATTR_SKIP_CPU_SYNC to dma_map_sgtable() and
> dma_unmap_sgtable() in udmabuf to suppress the spurious warning and
> skip the redundant sync.
>
> Fixes: 284562e1f348 ("udmabuf: implement begin_cpu_access/end_cpu_access =
hooks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
>  drivers/dma-buf/udmabuf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 94b8ecb892bb..9c6f8785a28a 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -162,7 +162,7 @@ static struct sg_table *get_sg_table(struct device *d=
ev, struct dma_buf *buf,
>                 sg_set_folio(sgl, ubuf->folios[i], PAGE_SIZE,
>                              ubuf->offsets[i]);
>
> -       ret =3D dma_map_sgtable(dev, sg, direction, 0);
> +       ret =3D dma_map_sgtable(dev, sg, direction, DMA_ATTR_SKIP_CPU_SYN=
C);
>         if (ret < 0)
>                 goto err_map;
>         return sg;
> @@ -177,7 +177,7 @@ static struct sg_table *get_sg_table(struct device *d=
ev, struct dma_buf *buf,
>  static void put_sg_table(struct device *dev, struct sg_table *sg,
>                          enum dma_data_direction direction)
>  {
> -       dma_unmap_sgtable(dev, sg, direction, 0);
> +       dma_unmap_sgtable(dev, sg, direction, DMA_ATTR_SKIP_CPU_SYNC);
>         sg_free_table(sg);
>         kfree(sg);
>  }
> --
> 2.53.0
>

Gentle ping on this patch.

To summarize the review so far:
  Vivek: "Looks OK to me"
  Christian: Acked-by

Note: while my separate dma-debug patch [1] would also suppress
this specific warning on x86, the udmabuf fix here is still
valuable as it removes the redundant CPU sync at map/unmap time
and aligns udmabuf with other dma-buf exporters that already
pass DMA_ATTR_SKIP_CPU_SYNC.

[1] https://lore.kernel.org/all/20260327124156.24820-1-mikhail.v.gavrilov@g=
mail.com/

Gerd, could you take a look when you have a chance?

--=20
Best Regards,
Mike Gavrilov.

