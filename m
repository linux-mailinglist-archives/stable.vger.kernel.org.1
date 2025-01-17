Return-Path: <stable+bounces-109349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDF9A14E18
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 12:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08212168026
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 11:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7EB1FC7F0;
	Fri, 17 Jan 2025 11:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g3pq/zMj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355BC1F9F7C
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737111670; cv=none; b=R2DBdyYBPs3zKk1tXwcysVih4dhbnphA1wap1GZITzuoZu2wG6efXEmT52MoxhGgR+2CEjb/1E1xPFHn9Xcp2oPyUwp54eUPS2iyuwtcwX4cduIt1QS5D++l+h+ImFj2IRsGQoYd+NC35ZM80sCXPxAQhQQLq6vCjD5+UwMNzI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737111670; c=relaxed/simple;
	bh=HNaq/qpjM+Lp+y1QAqrM2LmodIggJiHYYuMdBVJwh54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WulFm6ipmDfUNn0owNYLLLiue9C2lBUFwdtIOY+dY84uCqEqtx6/A8prqCJUaOaxrmqleHJ3K+egzzR/HwEHUojdpmHlXiyXmFRXM9016msNhWVW8+TyuOIx+Rc6szlD73QkhUFqRh7n+IE03oxxhTCAuB4W13J1RHEpoxYcjdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=g3pq/zMj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-437a92d7b96so18335325e9.2
        for <stable@vger.kernel.org>; Fri, 17 Jan 2025 03:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737111664; x=1737716464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HNaq/qpjM+Lp+y1QAqrM2LmodIggJiHYYuMdBVJwh54=;
        b=g3pq/zMjsDIG0C4y60B8AAJFEAOYUJRom1F1lLT5ONhUvQ5lYrWzWg0a9nHHBiwrlt
         Pkz2X3b5+1Luz2yEYWlv5rsBS9Q6oQRp1mc3BNZJCqRoCoptlwAKOXE95bu2vf7jL0aU
         /wJ5JhimrBxU0Otbp/yYvHCbXeY/LiopKxt/o38LGolJQpCzWDiTKwHg8gVL9CTYzDET
         6v+vd8PpTGgEWb1DZxle+patjbSHCcg2zSrHpchDTTDhbI23Y7VcbtjdOx72Qau0lh9a
         +M+D/OQMtbQzJtwprlOPU6pZML+T4GlQptSsNXsNb6xUROSb2EMhmTU6RlIxC/NiTw7I
         yxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737111664; x=1737716464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNaq/qpjM+Lp+y1QAqrM2LmodIggJiHYYuMdBVJwh54=;
        b=NW99rzshdSxlyIOlGwWbAmsiX/okw0GGAOk7J0oTlKmjbAWHpZJEr1irp6qd4c0LS0
         71FLzEAEKTXVUoARpa8DagbAb0C0q7VJ++4ouXhm1Ak0PBX9Rtv2e02hnO/aZHJeWt0I
         CZ+iBsMQHL6tfhJwfBCXZbe2JTxKbEopoNvGlQNqTbSaS2Y5Y2pSMpCzYCYgRehDweE8
         Wi7+KH2grG9xsEBRj++vfuyKjQ+kOH7wII3hd1pohRgyYp4z7SK+nTpivEeSZ8O3dkjM
         PbN3fGjysE2pM43+4Zp+2E2k7OVvvc4XAuB4euBa3nFVettSgjmH061EZbzJ04+hrfwF
         B6LA==
X-Forwarded-Encrypted: i=1; AJvYcCVhtYn166IB7hqzqFkOWoB5/JBCtGjQrWlT7s9fr+F4yTh47iDE9gkZOCsbpOmgNe6eyFnxdBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJlF0qXK7mIjFFY3Yrj9yUenPyzGHyYbdikTqDmS5ujfH2NCpj
	MSRXfUkZgVv4clL2dJLKc1IEROEEvfUQtmoCuW0kdiBqY+NkhNiLENGjz5DjLc8ggNX3jDKvAfG
	g
X-Gm-Gg: ASbGncvzaDcxrf/g9kCy/E0sz26MqqD+7MYCP0RlXhwl3BaT4i/9pvUjAJSz7fkpSmN
	g11VAoG/rt7SUDabOonS/0u+BnbXY0iDOQwJvm4bf27lpZk/m46yNkkAzk07TwlpMvTXNOqhwL+
	cwP3iCK4jW/DfxRhsXlN6e1Ott4Q3FKMrPXARHNWQKGEi2Hpl0X5XUexNRfn59AlM1eF5hnJx1i
	647PiECyFtL5Xo8OFis7rfb6npDQSne9eCXdmECxQwzLOovNszA8lQGg2QU2GBHpIna2YrL22iA
	0XKqkj7l7CRTuZ1k4h0WkRA=
X-Google-Smtp-Source: AGHT+IEML3YLVc6aK+BsZs3AFs2wEYS42V9mqmB5eZF+lE5eeBoX5rHulP/VYNNxiaDHN/mhhuhdVQ==
X-Received: by 2002:a05:600c:4589:b0:436:f960:3428 with SMTP id 5b1f17b1804b1-4389144fbd4mr21807815e9.29.1737111664221;
        Fri, 17 Jan 2025 03:01:04 -0800 (PST)
Received: from localhost (p200300f65f0afb0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f0a:fb04::1b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c0f02c07sm75499565e9.0.2025.01.17.03.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 03:01:03 -0800 (PST)
Date: Fri, 17 Jan 2025 12:01:01 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>, stable@vger.kernel.org, ashutosh.dixit@intel.com, 
	dri-devel@lists.freedesktop.org
Subject: Re: AAARRRGGGHHH!!!! (was Re: [PATCH 6.12.y] xe/oa: Fix query mode
 of operation for OAR/OAC)
Message-ID: <jwnn3zov3akpnqzbk5lss3r6q4yupj6indmmapwvh6hadcdycg@pvquyntsvqpe>
References: <2025010650-tuesday-motivate-5cbb@gregkh>
 <20250110205341.199539-1-umesh.nerlige.ramappa@intel.com>
 <2025011215-agreeing-bonfire-97ae@gregkh>
 <CAPM=9txn1x5A7xt+9YQ+nvLaQ3ycekC1Oj4J2PUpWCJwyQEL9w@mail.gmail.com>
 <2025011244-backlit-jubilance-4fa1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6l77qy42ykife323"
Content-Disposition: inline
In-Reply-To: <2025011244-backlit-jubilance-4fa1@gregkh>


--6l77qy42ykife323
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: AAARRRGGGHHH!!!! (was Re: [PATCH 6.12.y] xe/oa: Fix query mode
 of operation for OAR/OAC)
MIME-Version: 1.0

On Sun, Jan 12, 2025 at 10:06:42PM +0100, Greg KH wrote:
> That's fine, the issue is that you are the only ones with "duplicate"
> commits in the tree that are both tagged for stable, every release.

Isn't a solution as easy as teaching your tooling not to create/accept
commits on -next with Cc: stable? This way folks intending to push a
change will notice it should go to the fixes branch. And if only
afterwards you notice this is a critical fix that should get backported
at least the commit that takes more time entering mainline doesn't have
the stable tag.

Maybe additionally make sure that Fixes: and revert notices only point
to commits that are an ancestor.

If I understand the problem correctly, this should make the stable
maintainers happy.

Best regards
Uwe

--6l77qy42ykife323
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeKOGoACgkQj4D7WH0S
/k41Owf/S1vWxe2kwIlsEQ1rjx5Iq00xhXeww7qBszp/kl/zoaCQMwrspFprc8KD
ItZchxCeJobqEcp30DsK4XervntQL12eEjbWoYWLZbHHaeTrcWHPclY3XQu8KrvH
15qz8i+Qe7smi2cFpNaqBQ0Fs3t1jO8U72QjulN2szzZN4yFAfCri9H/Hbq7ZkZg
OBdhlJWtwzMpS9h+JQbiCKqIfTTPJzExxEd533ypdEo95X5NPAkO49kU2c0zBxfz
7QROWA39IY7qr62HsB9at6lCjf2t5bZitrTixUvLk9Rt8YIV3gBNDcz0OZ2oEGiX
oOFGAHwDZ8TP3uBhSVZ5JKvI2/dHiA==
=dUfV
-----END PGP SIGNATURE-----

--6l77qy42ykife323--

