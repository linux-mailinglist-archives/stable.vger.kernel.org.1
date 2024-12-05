Return-Path: <stable+bounces-98752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4CE9E4F9E
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 09:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7266A282348
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 08:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FA71D2F74;
	Thu,  5 Dec 2024 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bDMJAuVg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362D61C4A10
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387097; cv=none; b=mSpla7hSxjnInvRaBJplY1vkwQ6vB5Deo/1Re+ajkIbRNT5ehc74Flvg9cuArXTPKhqOf1EFxhdoQY7WITIgHOzCfTfGkQcypDtUxq+QiHGuvoQ27LqYHnhCsR2DYk63bUMvDRYjsbLwTbbbbfewx2QCl0p5iyX5/LgfDHWNBbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387097; c=relaxed/simple;
	bh=Uo9k1X5K3r3Hc4fiemmVrrIOCep2IwuCxnhIE0FNAZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLtorQFlo0Y7badl8YX+UFMjSwYGBWni5VKNNo4Cv7t8fjpxFxoHtBTIWG3Fik78m8Hkd+QxCD+d2f4rqQ1j/BJQfAjIRTss3MfJH/PY+Bhq6dXu+zatsFuXSk63YazutyUWPpJiDO0du9u9XycJcH7nDz7UmQmJwpw+CaBl12Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bDMJAuVg; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa5366d3b47so95912866b.0
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 00:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733387092; x=1733991892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uo9k1X5K3r3Hc4fiemmVrrIOCep2IwuCxnhIE0FNAZs=;
        b=bDMJAuVg6R7OCggMtjkmf24FjME3urx061rEFQBtX3Sw48SehiFotTnOBEMMcbge6a
         D9y5s1rbiN96e5I8Gft8ppRn8/DH4sqCluiBN30mBiCL6KKpn+su0WQ4OWyFMmGMATJX
         6jRyz6nqrXfhK+ISlQngJb8lI54OpCMe4tz5B+yxhEUfWdveTZ/kWjo+QGICE4eZHQ97
         ARR2QVVKKZ/7KSYIKhpFCOgZwDwXSGptBwThI7YLOwmTnWSMUgFJeSO8LVTA2ys1mt6B
         zXkEV1wWlCRx3z6MO0VH3jEiHlMEVGQ/+FUd709bOcvS4nz3PuJPnP9PLPJdBv8FfURL
         NVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733387092; x=1733991892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uo9k1X5K3r3Hc4fiemmVrrIOCep2IwuCxnhIE0FNAZs=;
        b=Hde5X0VydVUEoprpRR8QcF2UpqWa5yKhCFZg+DT47IqS/nmjTJ8W8n6baPXlSKRQS0
         e2KKD4O5swEUTgMiMmzoIukwQNCB0fq95W7FZku08IhCKVAXRojgcPXeVjH4VmmBRWEV
         ks5ppfmOI40Wln86Bmp1s6dA65CEKxXwGq08evGkuR+ld/sHobO6E2vJY3g3iV/thK5B
         ZmJ4ikFMlU1s9mw19R8h6UtvBKMQV3AMfV3OJgfTMKyfOMq/HJJpVe+oolOfY2PSGs0L
         zP5aG5IhxSUvumm244cY5Pr14PBDg6xW6dZYju++G3hMZRi7nslyovaIlCCkOq98RJ6Q
         +kog==
X-Forwarded-Encrypted: i=1; AJvYcCXd4dl2QW61STZUqQAA1qrwkuo1XRovBqrMAANBcMYEyAQE1PEEIdVubNBOHePMOKPqSFUdUak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz97z/bhxSf7rFlqG0C3EqfC1fAiVh0/zn1feXwLuCUKSA34JNy
	qW8Scje5djhyDWKeFcocQ/DGxa+XzZ1yPY8dZC1DR+0WdRHTs/szf0qEsWQf6tZ47uIPbfcH9Gk
	9ewKr7o7UQzpaGaUdtopOox7rd4Uq+C/lCLtTDA==
X-Gm-Gg: ASbGncuNJPQNAmEp5qOE9pPRviK3A8ZiKrjtlG8ERL2gpeyKwSUGSo9BPfPB0qQhfHr
	8Bo+2VIlQdgOH6XjXiBC/SXHgf/Tw5lPiYCYiDxsLu+luR4BlC8+gxfSypXYe
X-Google-Smtp-Source: AGHT+IF2FUmzqqeTqCOHliK3GHeSyqq90+/gTLGnQGE6+L+NEFrr+o2g/bwcOvlBUZndiM7KCRfcrc2i2XJirDHBN4w=
X-Received: by 2002:a17:906:3ca2:b0:aa5:1c60:39ba with SMTP id
 a640c23a62f3a-aa5f7cc2f2fmr781184466b.6.1733387092618; Thu, 05 Dec 2024
 00:24:52 -0800 (PST)
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
Date: Thu, 5 Dec 2024 09:24:41 +0100
Message-ID: <CAKPOu+-d=hYUYt-Xd8VpudfvMNHCSmzhSeMrGnk+YQL6WBh95w@mail.gmail.com>
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

I found this on branch "wip-shirnk-crash":
https://github.com/ceph/ceph-client/commit/6cdec9f931e38980eb007d9704c5a245=
35fb5ec5
- did you mean this branch?

This is my patch; but you removed the commit message, removed the
explanation I wrote from the code comment, left the (useless and
confusing) log message in, and then claimed authorship for my work.

