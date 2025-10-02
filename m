Return-Path: <stable+bounces-183035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AD7BB3D24
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 13:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C1B421D0C
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 11:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA16D28E3F;
	Thu,  2 Oct 2025 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wdovkm52"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0192F1FD5
	for <stable@vger.kernel.org>; Thu,  2 Oct 2025 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405870; cv=none; b=oBNzlwr64nfCj2cbWdCzZerYCkw71SIe58IpF409TjcCv9RfYpM5xAwxMCu18DZ5cZzKTIfEVqKkQSQf93Kur4+1ERXCzc1pk6VzQk+TthmXxfi91vvCF0KAX2VwMnNUBvRn7BUKlEANNEmoE7/PZgjOu0L73pZpFV9QIchN74Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405870; c=relaxed/simple;
	bh=FGLQ2Uj+CWbIJKZzhsAmoLQqBs2S93GpxqQTJkIDe1c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CzS2vXW5Ai4KtP4mR/XYAT3AL2IQUxFENHqnABy6coLRqeReo8kxSSMd2nNvx6UNW9VZgbGLKTCuzhzeElm9IqDfbMJGgGHMdk8V5e2dCyQ1lNpaN+aJqZx8ge3nKifPvOEreQb1l/0NDnyewo5PHtSvskRZzPRZmtbHB5eTwkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wdovkm52; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759405867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O/UdOTSJuFeuz61ETEUJOhsl+GvhZM/EvZcDfUCVmxI=;
	b=Wdovkm52kKZqXRcCqnibVUjnbKEdG56JqSVgvnC4JX4hAqATc/OyjCzW0MdbZG3kxUoFrg
	IIMDbZkAN0Ov8gGzLrWiuWjv1zzoIUZNc+Yt55GnIRLUo2bnCQQ88juqJ2ugNLqbEwt12Y
	7+aDmKYxf2rT5Hb3aJuxsFzs0v/p+i8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-yWue_FpMPuabypZZDdGtgA-1; Thu, 02 Oct 2025 07:51:05 -0400
X-MC-Unique: yWue_FpMPuabypZZDdGtgA-1
X-Mimecast-MFC-AGG-ID: yWue_FpMPuabypZZDdGtgA_1759405865
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f924ae2a89so727925f8f.3
        for <stable@vger.kernel.org>; Thu, 02 Oct 2025 04:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759405864; x=1760010664;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/UdOTSJuFeuz61ETEUJOhsl+GvhZM/EvZcDfUCVmxI=;
        b=apOD5AXtKQVhyq5HNEZOyrZ4UFQ8PjvkLv5yJQ+kSmvkQjbKDXl58nXgWz47Y43rr0
         nSFw0TsnWk3i+8Bg2kgDhj3FTv/VFjCA5S5PKMHxcAfSfRn6R3PipmzA8U+yv0KZvUEG
         scRC6+rKPQzd1nDKDJ3L8K2NDIleJppFgGWixAeDqg2JBTFbp01AmoGQdVxMFDQ8ueTy
         RYwk1efBmGY3q8CVrnGlUkvMI+X9bBpaeo5OvTIK0KflDFg+wXTyA6N17PgW4eLMfOEa
         9wjRTZMvf2wYu9BlA92tSmfww8/gLUyd4wP1K8DyUbr0EFEh1XoeTZtyuDKTgJ4ao6TS
         8u9A==
X-Forwarded-Encrypted: i=1; AJvYcCVtvvElFDt1k5b2DSwO85NlxAhSi+TTf16rXEnoPC171TyEMVqPLuI1dm5PFkmVHYVzfnxjS4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUVfzJEnYMFRhoN+XbEHcP9JNwSDaxVzeMN5sVPI0hMrF1anoc
	lPEL3SRkpllyKx7aLo8xsK1G47el7jZT5xMEMTxcATUxpSr+Ni8dbglvksjGmBMpIxM9Jt5VjHu
	7L+2Xz0RLretn69lzaBTJTQKrzGKHfDNnEjneVmZTWp9EJx45Fl5hFqLgTw==
X-Gm-Gg: ASbGncvaHVAPXNV2KkAl3HWEA+bgYCYnzGjtYTYNUQMPCaVGhhTWwrnEMPHkc+EA3GP
	5ffVYzA4fHlB5NT6IVNJRmvbK3ACcN7kWV/ioYVJdfR2tdHgEmLCvImw5zCUh5TYjbUWCRnFEI3
	OdNovaHKbW0VV6cJcmHaUoYqKIBUTmR4EODbbw3ziWNnr3uj4wbhUo1qJc7CMLR4g3Qak1WKeA4
	robmnc60fp2kwu62j8M3v8Npukzu+LdVF4UOT2ezuw29b7p5gKiuRB+RQ22pbupDOFwQk1iC79j
	6q5vajBhE3bDSR4YnAZvDb7a5lyPN8KnQpoPq+5cXRoFK9/Qb0nZKehjQMU3OwD3q7XeZBk=
X-Received: by 2002:a05:6000:40c7:b0:3ee:1279:6e68 with SMTP id ffacd0b85a97d-425578197dbmr5097951f8f.47.1759405864534;
        Thu, 02 Oct 2025 04:51:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiZ0Tp7eiBzvf0DenM28iIPgbDIMFoVMsSJWueKET191HqUB2L04iRl6mrUsuKThJQn393hA==
X-Received: by 2002:a05:6000:40c7:b0:3ee:1279:6e68 with SMTP id ffacd0b85a97d-425578197dbmr5097936f8f.47.1759405864120;
        Thu, 02 Oct 2025 04:51:04 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f45e9sm3367076f8f.51.2025.10.02.04.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 04:51:03 -0700 (PDT)
Message-ID: <067420a47d3fd7d9f50e4bc97248d0b4b812f9cd.camel@redhat.com>
Subject: Re: [PATCH 2/2] rv: Make rtapp/pagefault monitor depends on
 CONFIG_MMU
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	stable@vger.kernel.org
Date: Thu, 02 Oct 2025 13:51:01 +0200
In-Reply-To: <20251002082317.973839-1-namcao@linutronix.de>
References: <20251002082317.973839-1-namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-02 at 08:23 +0000, Nam Cao wrote:
> There is no page fault without MMU. Compiling the rtapp/pagefault monitor
> without CONFIG_MMU fails as page fault tracepoints' definitions are not
> available.
>=20
> Make rtapp/pagefault monitor depends on CONFIG_MMU.

Makes sense.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

>=20
> Fixes: 9162620eb604 ("rv: Add rtapp_pagefault monitor")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202509260455.6Z9Vkty4-lkp@intel.com=
/
> Cc: stable@vger.kernel.org
> ---
> =C2=A0kernel/trace/rv/monitors/pagefault/Kconfig | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/kernel/trace/rv/monitors/pagefault/Kconfig
> b/kernel/trace/rv/monitors/pagefault/Kconfig
> index 5e16625f1653..0e013f00c33b 100644
> --- a/kernel/trace/rv/monitors/pagefault/Kconfig
> +++ b/kernel/trace/rv/monitors/pagefault/Kconfig
> @@ -5,6 +5,7 @@ config RV_MON_PAGEFAULT
> =C2=A0	select RV_LTL_MONITOR
> =C2=A0	depends on RV_MON_RTAPP
> =C2=A0	depends on X86 || RISCV
> +	depends on MMU
> =C2=A0	default y
> =C2=A0	select LTL_MON_EVENTS_ID
> =C2=A0	bool "pagefault monitor"


