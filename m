Return-Path: <stable+bounces-236140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOOPOG4M3WkZZAkAu9opvQ
	(envelope-from <stable+bounces-236140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:31:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 491053EDFD2
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23137306DE91
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE183CAE76;
	Mon, 13 Apr 2026 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUwx2oO5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F8926A0A7
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776093947; cv=none; b=oTyiHf7SnD9zJ5YryXz3Xw23p//BaoyFkmauRqxtezHbRFczZbQGzt5FjI3XLLgEsYYClBmHyiSmIjXG4B3YxMrEixXXXqmKHwPrIoB6sdlpmydR7NqPS78RRYVKVjyDq3IOV3pa5GC6TFGCmACif7ZHxQhDJeGLn2GeKNiWmn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776093947; c=relaxed/simple;
	bh=WlHTlTbf17Tb+GBGL3PvGuMhWynY5k2DWn6NxHGoMVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6UD/jZAwQFNcb9qE4sEWXcxZtLxbvS6h/i5KY887af3aktdFxgRjl1+vGzSdYUQr86kyAkgxE2i96zZpTMKWBxUrmYYVgLPM/8dCresXsQ2Pf4kIWsDMFDMZhGcS+oZB9qSSkxioNwLOCBoAH+h0QKqREHN+8fZlVHNemw16EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUwx2oO5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-483487335c2so50168055e9.2
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 08:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776093945; x=1776698745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqN2sV45OjOLBDqUsVl5Nao1bMFA+NRdxtqt3PMt3wg=;
        b=IUwx2oO5diwQpAPnP2iwAkS1YkwlLF319bL2cArA+2QWuVwfiW2cgztf7Ui7iXkceF
         OVuikFL2Bn2qtMA1mNqE+NsK5m4Zz7CEEg7UW+WNuyqXrCOpQblYVVi/rvoLIM8YMwiQ
         g/a0yCeRytVTKTfuNQZ0JH5D4vwB1J6VHns+1DakTSrsvFu73+9H8i31ehklRWn6aUxn
         dTdmBSLmX1nypgjrXj/y2q9sYNyTOZwpq2AT83dxQA/e8L2rTyoQV7LufL9PYlJ1mVp9
         KeMeOXfULLzzzEMPpZmrryQ1CIbAvO520WqpNj7xjmhZT4BZvhnPWbBJxrVZnbKivLhf
         qsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776093945; x=1776698745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KqN2sV45OjOLBDqUsVl5Nao1bMFA+NRdxtqt3PMt3wg=;
        b=MIVZWFCX1s7Splvw/z1ZNcTL37Yc9x/ko4/YCQbo5yUbvqv50bfLzrKm7LsYrOQp0K
         kytQTMqQFawTi4nd0d/5DQghrR4t0ykee0xHokhzOzIDuRkYtiLSLarLziD6E4mMXvL/
         Cai80YacPBVWFeZeCWLifxXg1E/FqIbPJiJxt3GgyDOViaSJolQ9ZaZRoDAzTb+HfbJq
         We1H6NV4gKDhoHumB77txBN5ibcPkfRbV/85thv89kqGqyXK8SjWHYWmwidVOjB8ckyV
         jWzcjG4AEj78PILs7NsF27xJLHrCiAtBpMyezr3hgrAdgmJhgXd+T5qIO2+hja5ukSn+
         oVyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+MCq7JfgA/PzJ/6qFuXvVAtD//qkckkGxAlSHA6StdNHcXH1v4UBftpOfrmcWhbJSSEaAGktQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFqA/We941suFsszce02uHGy+jxnvOJysVJ6tgKxSJww0KfPAc
	PCjItAeeghpyhfHCdV1XGHadqyTF+hMhLSsCDbf5MicwKszDEf2uOmwt
X-Gm-Gg: AeBDiesT6bIjwuGtiEoNdyg2a+UdvztiWfLyUfAv14hqHtvUbwFe7EH6dvl2fG3USEQ
	xiwI19weYww8saIjMChaG+6FFJs+JwFFs+y7Pqt47jsOfywv7if1fL5Q6Kd7Zf8Z8mMfnIiqajM
	7btVKQRn9qOhipnx9tNLROPXHigV2eylaq+ffUdbFFixII/ksyRfAt887iidUg1Fu3553PNxHNy
	Np2nVdFLTVu/LfCrC3GiXlri0sazIUyiT0C4Nz7Sv9+/cpmZzPQtlS3cbkIMrxZEcI4y79N1+jS
	TUH7aSdV9c4pHiSxcwMgtqhpdRs6qOHWOBcajVtawyMhQCuGgrZZH7pE7YbSf6PjwGOUPN06B3f
	RhB/JYGLEPd/n+lEVb/5qUsTuqKrVNSQVTiSMTdSiCgaasm7zMC/xVqQgmTEA2G3jhfdiN6ttvv
	bL4KV848AxGG55GCs0hQceGQ8LY6P5UjOMJzpRj+xWHHHHGSqkjQItUmPVqMAqv/V5JmgYw4c+v
	iJpQsidRXXG8q2TeA53mFi1uTiQHw==
X-Received: by 2002:a05:600c:8b6b:b0:488:be21:54b9 with SMTP id 5b1f17b1804b1-488d67ce792mr198565295e9.8.1776093944474;
        Mon, 13 Apr 2026 08:25:44 -0700 (PDT)
Received: from timur-max.localnet (20014C4E24DEE400DF3121E46476B2BD.dsl.pool.telekom.hu. [2001:4c4e:24de:e400:df31:21e4:6476:b2bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d531f1f9sm363581155e9.1.2026.04.13.08.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:25:44 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Rosen Penev <rosenp@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 stable@vger.kernel.org, patches@lists.linux.dev,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Vegard Nossum <vegard.nossum@oracle.com>
Subject:
 Re: [PATCH 6.12 230/242] drm/amd/display: Reject modes with too high pixel
 clock on DCE6-10
Date: Mon, 13 Apr 2026 17:25:42 +0200
Message-ID: <20304292.fSG56mABFh@timur-max>
In-Reply-To: <2026041152-slogan-chariot-c87b@gregkh>
References:
 <20260408175927.064985309@linuxfoundation.org>
 <CAKxU2N-WvGmbG=Zge=C1F6a+pR3kNW6J7uExUGTOxudBDT8YqQ@mail.gmail.com>
 <2026041152-slogan-chariot-c87b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236140-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[timurkristof@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 491053EDFD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026. =C3=A1prilis 11., szombat 11:49:04 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Greg Kroah-
Hartman wrote:
> On Fri, Apr 10, 2026 at 02:20:42PM -0700, Rosen Penev wrote:
> > On Fri, Apr 10, 2026 at 12:08=E2=80=AFPM Harshit Mogalapalli
> >=20
> > <harshit.m.mogalapalli@oracle.com> wrote:
> > > Hi,
> > >=20
> > > On 08/04/26 23:34, Greg Kroah-Hartman wrote:
> > > >   #include "resource.h"
> > > >=20
> > > > +#include "clk_mgr.h"
> > > >=20
> > > >   #include "include/irq_service_interface.h"
> > > >   #include "virtual/virtual_stream_encoder.h"
> > > >   #include "dce110/dce110_resource.h"
> > > >=20
> > > > @@ -843,10 +844,17 @@ static bool dce100_validate_bandwidth(
> > > >=20
> > > >   {
> > > >  =20
> > > >       int i;
> > > >       bool at_least_one_pipe =3D false;
> > > >=20
> > > > +     struct dc_stream_state *stream =3D NULL;
> > > > +     const uint32_t max_pix_clk_khz =3D
> > > > max(dc->clk_mgr->clks.max_supported_dispclk_khz, 400000);> > >=20
> > > >       for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
> > > >=20
> > > > -             if (context->res_ctx.pipe_ctx[i].stream)
> > > > +             stream =3D context->res_ctx.pipe_ctx[i].stream;
> > > > +             if (stream) {
> > > >=20
> > > >                       at_least_one_pipe =3D true;
> > > >=20
> > > > +
> > > > +                     if (stream->timing.pix_clk_100hz >=3D
> > > > max_pix_clk_khz * 10) +                             return
> > > > DC_FAIL_BANDWIDTH_VALIDATE;
> > > > +             }
> > > >=20
> > > >       }
> > >=20
> > > This is a backport of commit: 118800b0797a ("drm/amd/display: Reject
> > > modes with too high pixel clock on DCE6-10").
> > >=20
> > > The backport adds return DC_FAIL_BANDWIDTH_VALIDATE, in
> > > validate_bandwidth functions that return bool;
> > >=20
> > > drivers/gpu/drm/amd/display/dc/inc/core_status.h:
> > > DC_FAIL_BANDWIDTH_VALIDATE =3D 13, /* BW and Watermark validation */
> > >=20
> > > In this branch DC_FAIL_BANDWIDTH_VALIDATE is integer 13, which conver=
ts
> > > to true, so the reject path is inverted into success.
> > >=20
> > > So I think we need to fix this. Thoughts ?
> >=20
> > Best to drop.
>=20
> I'll drop this commit now, thanks!
>=20
> greg k-h

Hi All,

If I understand correctly and the function returns bool in the old version,=
=20
then the patch could be adjusted to use:
    return false;
instead of:
   return DC_FAIL_BANDWIDTH_VALIDATE;
then it will work and fix the issue that it was supposed to fix.

Hope this helps,
Timur





