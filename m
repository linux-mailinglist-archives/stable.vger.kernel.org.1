Return-Path: <stable+bounces-95658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B867A9DAEC3
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 22:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D77165E40
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 21:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681CF202F8F;
	Wed, 27 Nov 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ZvyVUvCy"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD955140E38
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732741610; cv=none; b=nm+H64dLabSX+KJvXm1ocG+2pbFI7cuPpuqx0KhEP2uF3nyQkiKV8VjxbeZ4H7C5TLRJ+2A+VwetBX4tw3HACkiYayNKVBC7MqsnTHxogJwNJAy7bCkn+89Wuf99BYkDdFraAVkKeEUrdTo4bku6eoJmySaXL4rcagUsIcCyisM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732741610; c=relaxed/simple;
	bh=9WWaNqbNFx7zDSvFdbXOioyNmBGET1MdjUtI2sIrRLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sY4Ocf1HQqDDSYt9Qbjg9rMW0CG2sfgBXB2YuaQ3cF0ZZILP8rwecylxnOQ1Ov2969itbek5MKbVgUpi8ZeJosms5A3hnQfO8EZettCTUryupyzhBS/bECXizWnvg6UptYD/tHVKQwG/0WKULt2mthJd4EQa7+J7t8mjkRpWF3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ZvyVUvCy; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53da209492cso112319e87.3
        for <stable@vger.kernel.org>; Wed, 27 Nov 2024 13:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732741606; x=1733346406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WWaNqbNFx7zDSvFdbXOioyNmBGET1MdjUtI2sIrRLM=;
        b=ZvyVUvCyVf6kirKb3rhxwODr4RUAQjy6v0cQ69J848UeJf38NxRkcwWaNxi5Dy1Dsy
         eGuYBuS4eGAoVEl5vJmyytxE56qqc6iVyuS93i78IQ+qFd/vfTYQ+EqVkjsHUKMPQAq0
         JqPyRucDdLMuvWCQAXoLi9i7tLiEjztYi/Qdp2MYXjYQdRlLOhEp4qo5MgiHdtwkjBHQ
         j+HQws1xq8sEWRg+d4l1qJH3oiZN2wNjOlXqPYgcXqc2qyMHHtWNki7DUq6hrsENQz4O
         ijDBcoqoDet6AnABiPwvnsceCxlY2YGjtYviiEHfHV8fYscCJyjkE5Bte/7LG/KeyZbA
         ojXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732741606; x=1733346406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WWaNqbNFx7zDSvFdbXOioyNmBGET1MdjUtI2sIrRLM=;
        b=dOHvmOmlNPrTmF49C6vy2qL756ieUkC2/hCn9Rwe6OjCAhe+vu1kno7sW7y3Y0PpKy
         kykoJpNVLiQvWDT71/MmZZRkCCV84EPZEHsq50HX+yWDKPC1nCckaQ0e5fQE1ykRCCH2
         hL0MSdZKMb8ns7RpbRqviErxCACpK3NzDpsI9KLV/R6flwqxYRqB4TU9g8fY64uTKAub
         XACVqI2mJosaAGnS+W2k0QS3hY/PzgyAnb9Ae1/kzfZ9PBWN/BVYvBTXY8Fmv3+O3C3x
         /lkg08K2r5U84FgZB1KIibTlXKg3YsGjMBb17wn7uV8copX34hDv/F2jPvZU2gEwXovT
         luDg==
X-Forwarded-Encrypted: i=1; AJvYcCVeBDgj1Vpvt5aL5j/e1vHLx1C8Pd017qPZ4O03iDqeyIZksD81Ow5gVxrXvylt4o9rHZNEOOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUGxWK29V0NVO9xPwr+d7XMmUkoM2UmQDKiKxCcHBS2zEd5ojy
	3jm8rgSzBOSUQFal8wOABZquxUHNt3CO75XZq6otNbtmnbGzokxggPw8KZxScKRaK+aJjnXT7K7
	Cy980knAFoOZw1VyWhaS0xKCcc7isaVDGVsMLPA==
X-Gm-Gg: ASbGncs8vzAzL8nkLn8RrOceSTi8AZMOMMn2rCfDICeebI77hgLG9bJ9sNaZgwFJYSM
	lUOnXEUAc5E4xYnBY1UI9krUysjcKhGB8clKfB0L5AFnKDUTBRYougGQcxoiH
X-Google-Smtp-Source: AGHT+IEdbHnRzGwZXtI3+5F7LoiEkUxwBFWYttWOWC4DjMa0W7DfmxC5nfBt/ZmmQAYZY28q23O20T14kyLO/bmqvB4=
X-Received: by 2002:a05:6512:b18:b0:53d:ed6a:4db2 with SMTP id
 2adb3069b0e04-53df00a976amr2672808e87.11.1732741606079; Wed, 27 Nov 2024
 13:06:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127165405.2676516-1-max.kellermann@ionos.com>
 <CAO8a2Sg35LyjnaQ56WjLXeJ39CHdh+OTTuTthKYONa3Qzej3dw@mail.gmail.com>
 <CAKPOu+8NWBpNnUOc9WFxokMRmQYcjPpr+SXfq7br2d7sUSMyUA@mail.gmail.com> <CAO8a2SiUL3T=MHcktWDaMbToqJYt7mYD_XN5G2nRAN0sxCHD7w@mail.gmail.com>
In-Reply-To: <CAO8a2SiUL3T=MHcktWDaMbToqJYt7mYD_XN5G2nRAN0sxCHD7w@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 27 Nov 2024 22:06:35 +0100
Message-ID: <CAKPOu+9kdcjMf36bF3HAW4K8v0mHxXQX3_oQfGSshmXBKtS43A@mail.gmail.com>
Subject: Re: [PATCH v2] fs/ceph/file: fix buffer overflow in __ceph_sync_read()
To: Alex Markuze <amarkuze@redhat.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 9:57=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
> You are correct, that is why I'm testing a patch that deals with all
> cases where i_size < offset.

I don't like that patch because it looks complicated; it obscures the
problem and it runs a bunch of code (fscrypt, zero_page_vector) before
noticing the problem. My patch is simple and breaks the loop as soon
as the new size is known.

But I found a bug in my patch: I forgot to call
ceph_osdc_put_request(). And while looking at it, I found another
(old) leak bug. I'll post two new patches.

(I'm trying hard to suppress a rant about C, after fixing several
other Ceph leak bugs this week that caused server outages over here.)

