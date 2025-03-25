Return-Path: <stable+bounces-126044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 586A1A6FA8D
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7FE1891591
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598EB256C7C;
	Tue, 25 Mar 2025 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YoGtcwGW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9082F25742C
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903884; cv=none; b=q/FrlbkcnNOowIp4czSxmAh59sZxh9zWRm709SmovtD620H+9IQJVAukOUJ6r+EBUXRjV8x4IoRdZSxJVNDfvnVsz0pW8S9pJoyIpuqT+agIs8zMIEyTvLzM8+c5jCWK9B46NLtp6pHhf+ZMDCxyc+QSAp77s1gfRP4J77g5v10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903884; c=relaxed/simple;
	bh=EhkCcKvMO5FXE+BxXjdos8aDqMsGvPPSOVvmXd199Ng=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DdD7ZPN+XuLuBKYvJdPOfsd/e15MSlFTiJz8g6LCpR8vyJC4V4cblRFu11Jn81lm608oJNQ788dEQdSeiBbwLI4YJ67MJLVa3JPZYzH5Xe7n4RlKC+CsElGn7JfHXFdHRfDf03bvfLvBdUOMRCtWbQlOIzkvyVdJ1W+BUr0571E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YoGtcwGW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742903880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=66ScJ5U4mFltzfqo02WJQQOu9FrvajI5Tu1fFaDtkl4=;
	b=YoGtcwGWlxXcBPkefsVhMcj+YflSAOe01Pm/3x11FvKBL9tUMqdcdpCrM9EVMqQPDYlDoE
	SuSK48HSCFV4PU1JI/hO13UoHcytkPpgN/fQU6rZy5NtgfG8RMbp3sTt7rheAylY6oP3qe
	MljvtTvZwf64jCk6dv0KapwA8a1hPQk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-n3Kwj8azNV-ysUPQlC1MwQ-1; Tue, 25 Mar 2025 07:57:58 -0400
X-MC-Unique: n3Kwj8azNV-ysUPQlC1MwQ-1
X-Mimecast-MFC-AGG-ID: n3Kwj8azNV-ysUPQlC1MwQ_1742903877
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-30c0c56a73aso26292031fa.1
        for <stable@vger.kernel.org>; Tue, 25 Mar 2025 04:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742903877; x=1743508677;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66ScJ5U4mFltzfqo02WJQQOu9FrvajI5Tu1fFaDtkl4=;
        b=RxH6dC0GWaTDqz2mThPqPCj6bZZpMcm8YVYUZnez0uvHo+txXe920lx3B4eNgfBWwQ
         wSySKAMEklT29ufuZBfje3qcyWi5KmoTpbFVPPUEyuVcMbNr5AZp9iB0fkm05RqXl1e/
         BEtzsUZPRrB8p0kWSMPGP1zQ0JH48ugcWFnaGxuEmwZRCaWZeHfWdZ0hY/cmXgYFrBlO
         rCbf3sDuLP8dW9rMyQDZMonVnhQYR/VK6VUjGrRn7Q8VS9s4v2B3hptQE67ez8J5PKFp
         DaRsOXxuooG9Co4DiWXdXUWgcNhzTG35KEYrGpcKVzXIjJK9qXPYMT8wJapBD3CJnaoP
         a2+g==
X-Forwarded-Encrypted: i=1; AJvYcCXjkQwVhRBpcNHBG6snGwr6OiQJG7v9eHA6nKsF3/EQt2Cykg0Gx6dfPOyd/zDrmdBh8vv98YY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy3lxsFARsQOsyTnddEAUFwkd5+W31ls6OZCFh6bQmefEkzivQ
	uiFY2Bdh8ZXc86STNXWq81qL/BxRiV5Jz7ZujSdKUpEfJsgqdyjVuM/xx/kofY9oXwVycTZHbQG
	OzmIAx3ljlIIDSmkX6qGO8DjCrQMEENdYBL4vbnu7APVcKGETeM4wEw==
X-Gm-Gg: ASbGncvDVFxlAAfzDF3KOA9bSVF+WHYoWbNMRLD1WqX1/5pEq2jyjxmeE9f0YNSsPC8
	TrJtA7Ufmrknv0OgfD4SAK5jXeYUDmj8KsmouZHFos4GoxLhmGSYqHfE8kzjq7Iiuup9eoK1yzv
	W6iaOqyJTr6FrB/9tGTJkC89ZxQXzxAzj/ffG+0I98zH5lq6bkDSho9BgM1GUQZfAPzTK0+uhrg
	L++GAK+Clsng/aoDIo1sGRVQVt+PcFb+eW0Eyp1egNsFhrTPfUmDPkGrO6c+FRITWp3KWDyS5uj
	P45y2Vyr69nPN3jXczXe+AttEVqoseuRiJdwu45pL+fFowS7NN2g4u0=
X-Received: by 2002:a05:651c:170d:b0:30c:460f:f56 with SMTP id 38308e7fff4ca-30d7e2349a2mr51836631fa.20.1742903876760;
        Tue, 25 Mar 2025 04:57:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFsVQ5ThcgNl6aFdF7RZUEJ9ftLWGxPNlNQbEsFkk48iEQQ4ebeeG5mcwR88P3gcTTqWHXCA==
X-Received: by 2002:a05:651c:170d:b0:30c:460f:f56 with SMTP id 38308e7fff4ca-30d7e2349a2mr51836521fa.20.1742903876296;
        Tue, 25 Mar 2025 04:57:56 -0700 (PDT)
Received: from [192.168.68.107] (c-85-226-167-233.bbcust.telenor.se. [85.226.167.233])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7c1d8esm17547331fa.13.2025.03.25.04.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 04:57:55 -0700 (PDT)
Message-ID: <636546d444306b8af453cdf126453a8a1f0404d1.camel@redhat.com>
Subject: Re: [PATCH v2 1/5] ovl: don't allow datadir only
From: Alexander Larsson <alexl@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Giuseppe Scrivano <gscrivan@redhat.com>, stable@vger.kernel.org
Date: Tue, 25 Mar 2025 12:57:54 +0100
In-Reply-To: <20250325104634.162496-2-mszeredi@redhat.com>
References: <20250325104634.162496-1-mszeredi@redhat.com>
	 <20250325104634.162496-2-mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-25 at 11:46 +0100, Miklos Szeredi wrote:
> In theory overlayfs could support upper layer directly referring to a
> data
> layer, but there's no current use case for this.
>=20
> Originally, when data-only layers were introduced, this wasn't
> allowed,
> only introduced by the "datadir+" feature, but without actually
> handling
> this case, resulting in an Oops.
>=20
> Fix by disallowing datadir without lowerdir.
>=20
> Reported-by: Giuseppe Scrivano <gscrivan@redhat.com>
> Fixes: 24e16e385f22 ("ovl: add support for appending lowerdirs one by
> one")
> Cc: <stable@vger.kernel.org> # v6.7
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Reviewed-by: Alexander Larsson <alexl@redhat.com>


> =C2=A0		return ERR_PTR(-EINVAL);
> =C2=A0	}
> =C2=A0
> +	if (ctx->nr =3D=3D ctx->nr_data) {
> +		pr_err("at least one non-data lowerdir is
> required\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> =C2=A0	err =3D -EINVAL;
> =C2=A0	for (i =3D 0; i < ctx->nr; i++) {
> =C2=A0		l =3D &ctx->lower[i];

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's an obese crooked filmmaker trapped in a world he never made. She's
a=20
provocative red-headed stripper from a different time and place. They=20
fight crime!=20


