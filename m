Return-Path: <stable+bounces-98294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 015B99E3AD1
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 14:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1192161EC8
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 13:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEEB1BC08B;
	Wed,  4 Dec 2024 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DPWSlsl7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E9746E
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733317553; cv=none; b=D/gAFgnIz+a8mBaDIlPCTIqpz6JayON6aCwH1IbINZc/HTZ9VfMvvt2Bit/oXRhtUk9SdCcNxejg7U8eitirihkoNO/8XVn7lFbjohR4Wl4Gd5fYre5njllwUlgV0KJS+Vfp8zM741Ssqpw1h9bd3QOSNvqz6qoprEBU1YgEkxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733317553; c=relaxed/simple;
	bh=Z3EENbcgyMum84QzWlYJALT23zS7loMokMBszOJOSX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mn4EWNmKyH4zFEjNrULJ4iFggSAQ5QSkcXBALKW4to6A40GDESR10t3TEUwlDCmGw938ta6rDkbnq+dodHl9I1jL86a9FjygBIH1be4eD8quWWZ9rhDirZULmx+yh92psSnfJIwlBy6qU1xD7hkb0+EU9e6De6OvXh/uaxnm2oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DPWSlsl7; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so7595037a12.2
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 05:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733317548; x=1733922348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3EENbcgyMum84QzWlYJALT23zS7loMokMBszOJOSX4=;
        b=DPWSlsl7sjY4NmrKmvWt3tRZMtRWqkcyrBKrUYMvEta/xr1bWiKbRyJyhdpZGSuEHD
         ewcejePyZq9mHxYJ5QwjPWba/yFpO2eudzyONjs+nvbiET5O+sDO737PUxdRlkZYKDbo
         RHK2eA3TY83w2JitClwhGvhkHQbpOsV0eWsZa2Hm5NuEeUB7aLP4QYitiqswC6H42Ft0
         mSFmlcT64FSJ3rXwqxmh1o5HehBmPRtJKwdmNlS3ZkhRMJvcfOmhpjsfksxwFJFlULzF
         pqxS9XXvK7fRp4nuB1J8yboy4QHIHWWYO0V6U8WGuN31wkxvQCbIcJQTv9HwRLklM2Tr
         yhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733317548; x=1733922348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3EENbcgyMum84QzWlYJALT23zS7loMokMBszOJOSX4=;
        b=tS1FS5gFWnCIVw2if16CUDyXr8zGXOK96u4ma0WqQvKdNfl0QFcKRkd5+HdB5k+Pdz
         BuEAozDWDdrPyGYGPVDVxrog2eSQfQfV82kmIJ0GPNuk5eS2MjcAvqjCDrB7kHlxMZRu
         B9/x164vVM15UIOpc1bT7Eftr6lwhMz5Nwvl9pYsxK7KkSJpSaxCUsFPDpA9EjanLRhy
         mzNY/FM5BdJGpiiujoAynljlXeaAiCaPsk34jedrhBNk/qEhsf5w/WX/sE9E5uzFpU64
         hmYWpr6dRZ9dKNsKRcM8hEuAVV0KVZQT75Pi7MG4QLIS8uCtPsRwYTDL7NftaJUvZBrt
         X7kw==
X-Forwarded-Encrypted: i=1; AJvYcCVCs91Qm5SWpkhIp+KHEO9FAjrk8GhiP8klZMC+l6ShuYRasG7gOh/xHhv7QoTui5I16inFs50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF+crC6qX8HrRZMhpfUehWNepeY2VG9g+nQHnCPy4JTWRndk04
	2+gd55rs4sOsqgdQqrgPsNH7pCsnTiUzUqbTH7uf02fuMIjwIgLC2buk9y2s+CFgMPRW9YRrzM7
	NJWwE3lA2ecqK5nZYWbjIN3xjDSxmu6lPenLweQ==
X-Gm-Gg: ASbGncv+CbqFt9Zy9z4PBXdM5ZAEIE+ibBZenXmGYfO9uvI3mfOBHYP8CHBEEgpuWMQ
	gAUU649+VGZTQ/y2gfyt7MmYk9jO7mScJtFfLldrv9KX7KETv/zU2HaNO4fxu
X-Google-Smtp-Source: AGHT+IGrdr9TGaSHAfS1s7UDwKK36JSpdSVugCVWYYvYdWQLSIIW7IxynDRCS9finSrEfHe9b0yvURkSkUzxde1WavQ=
X-Received: by 2002:a17:906:1ba9:b0:aa5:3853:553c with SMTP id
 a640c23a62f3a-aa5f7f4ae96mr404733366b.53.1733317547869; Wed, 04 Dec 2024
 05:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118222828.240530-1-max.kellermann@ionos.com>
 <CAOi1vP8Ni3s+NGoBt=uB0MF+kb5B-Ck3cBbOH=hSEho-Gruffw@mail.gmail.com>
 <c32e7d6237e36527535af19df539acbd5bf39928.camel@kernel.org>
 <CAKPOu+-orms2QBeDy34jArutySe_S3ym-t379xkPmsyCWXH=xw@mail.gmail.com>
 <CA+2bHPZUUO8A-PieY0iWcBH-AGd=ET8uz=9zEEo4nnWH5VkyFA@mail.gmail.com>
 <CAKPOu+8k9ze37v8YKqdHJZdPs8gJfYQ9=nNAuPeWr+eWg=yQ5Q@mail.gmail.com>
 <CA+2bHPZW5ngyrAs8LaYzm__HGewf0De51MvffNZW4h+WX7kfwA@mail.gmail.com>
 <CAO8a2SiRwVUDT8e3fN1jfFOw3Z92dtWafZd8M6MHB57D3d_wvg@mail.gmail.com>
 <CAO8a2SiN+cnsK5LGMV+6jZM=VcO5kmxkTH1mR1bLF6Z5cPxH9A@mail.gmail.com>
 <CAKPOu+8u1Piy9KVvo+ioL93i2MskOvSTn5qqMV14V6SGRuMpOw@mail.gmail.com>
 <CAO8a2SizOPGE6z0g3qFV4E_+km_fxNx8k--9wiZ4hUG8_XE_6A@mail.gmail.com>
 <CAKPOu+_-RdM59URnGWp9x+Htzg5xHqUW9djFYi8msvDYwdGxyw@mail.gmail.com> <CAO8a2ShGd+jnLbLocJQv9ETD8JHVgvVezXDC60DewPneW48u5A@mail.gmail.com>
In-Reply-To: <CAO8a2ShGd+jnLbLocJQv9ETD8JHVgvVezXDC60DewPneW48u5A@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 4 Dec 2024 14:05:36 +0100
Message-ID: <CAKPOu+9vUdU8jjdEi76z847JGh5XU1AR93HXuRMv3=D8Jn4i2A@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/mds_client: give up on paths longer than PATH_MAX
To: Alex Markuze <amarkuze@redhat.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Venky Shankar <vshankar@redhat.com>, xiubli@redhat.com, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, dario@cure53.de, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:51=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> w=
rote:
> It's already in a testing branch; what branch are you working on?

It is? Which one? I checked
https://github.com/ceph/ceph-client/commits/testing/ and it's not
there. This is the repository mentioned on
https://docs.ceph.com/en/latest/dev/developer_guide/testing_integration_tes=
ts/tests-integration-testing-teuthology-kernel/

