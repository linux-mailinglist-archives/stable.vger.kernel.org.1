Return-Path: <stable+bounces-206233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4198D00545
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 23:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B02F3025A6B
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 22:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CA12868AD;
	Wed,  7 Jan 2026 22:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlOaL7Yo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ab+ZtrwL"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FDE22B584
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767825209; cv=none; b=B4ouC0GqzPkFLXGPG8lXbOBkHeBCbPxqtf0a4Ii/QEAxFvAiyFVBJiUb+WTczAX4ypCS3VJzNFa+F7faH5JENP4urQ7nEf+VY24NKYinv85p/orK3g5BsFJVgx57r/ydly3/3auFy/EXgi0MxSJEekY7LZo5CjK8JAAvLt0MWbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767825209; c=relaxed/simple;
	bh=nKQQImQ1hZC5gl08Mlnp8GyGft7UUB1mwBlEWEHAg/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnypn7ExdEhg6WmcU2OB0odRqlk/pe2Z7A+KBZJ9KTznlN1vupdn41L3TC97Vs7lr0HQJQ3YGHGQdIbv/Xfg8mpdWuZAdP9ipN04NFF8fu3iTtXF5LhhcJhcs1xD9HkAtzkja1G6Fnr/lb8O88q7ppENZrc8ADQZ+wJbND5B7Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlOaL7Yo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ab+ZtrwL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767825206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YKiv0UN+Y/p0lp7y1aVLPcFYjbDuoHshQ2ZIqZot05Q=;
	b=DlOaL7Yo/muwsURpT4y/z14TRX1Smaec3vYMZoD+vmGpFCaw2LUWj6KZzyrzpz++vE5JNc
	ckMV/DvEcNRZTdsTsliYz7tizj8hla/DIfgB4F+2TRQFP5LWEW2qoYMAUidmTJR7enb6cW
	c/j7V4qe+/98e49fTMzvkNsgdm8sv88=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-cB-E9G3ONeWDnSeZxnxjEQ-1; Wed, 07 Jan 2026 17:33:25 -0500
X-MC-Unique: cB-E9G3ONeWDnSeZxnxjEQ-1
X-Mimecast-MFC-AGG-ID: cB-E9G3ONeWDnSeZxnxjEQ_1767825204
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-432c05971c6so994704f8f.1
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 14:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767825204; x=1768430004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKiv0UN+Y/p0lp7y1aVLPcFYjbDuoHshQ2ZIqZot05Q=;
        b=Ab+ZtrwL5eymV8NoWxkQwhIjjnTc6GGSwgC/M62pwAbGL/arJ23wdrN6mGqwdmdRIM
         OFtF6Ou5lamYp+71Ah+HcXERkykjnj07Ng8idOwvRD1SqVDr4AXseDkyIyTiaozLtaZU
         SoPa2K7kK0AFMJBzzKntVjs9LTpAfn9ZO2djTGWrGDTn9qUwia9rVQ9J4sPdB8t/LyGV
         07nA2g+OFpHxT3ns5k5df8tWPFvpwEBPXPkQKj6Ssm9qW3C7wScasesZi9qJo2rs1PSC
         zl7wZ37wvxCQYjekT7iPv0KD3TRR8QUXPXyZYSPBqH1FjupjB2L7B5KV0n0CpVYTrINW
         Is1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767825204; x=1768430004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YKiv0UN+Y/p0lp7y1aVLPcFYjbDuoHshQ2ZIqZot05Q=;
        b=ZlzW24ZJ2kH8Rf44XhwLgXUhFSTDumZ8yt09dOyN7txExuI+8kT251bvobdYFmk4RH
         s2bOKnZtfe8z2gxLtkBbtK0zZ3/zfJTJqndf4APE63fNci/tNbZY/ThJlYAWN+RUahDp
         ztEZn7QEAIaGVqLX/2ugfA3EdrtnT5+Q5wNjD8JmFhFMhr5tdKN/EpyNWNbgqx93N+2C
         1uGfzttiwXT26uvF769FChxK4ZXoEXTkmQNeXlgIm9cqGyN5MD+58Cw8v0HXAI4awH6B
         joYhqlBnqRBQGt1JpX7H0oAHdmywFXPJcQevyy+idxTwOSYYaLYtUzVYAqmfWR0i4Bx3
         vkIw==
X-Forwarded-Encrypted: i=1; AJvYcCW6+TQc5BqdmO8Mf55o3fA4Oj+OVSOu066y1BzwsiG2bHDjCqdiSgzrrW/d4F1eTtVdfGs7BV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy3cYEuJs6xEEw6ZBb7P/DxaN+Oc7sVhN8G3PCpmjC9Moe4+qJ
	cwHAJQiwgnqcZ2wHIOW0C94jMcNZycypF31I86fNf0nlb6jot+3JxHL1yJhExkAvEw752y0oTxx
	xBSH+sWBl5fV/eMAVPEoS/ozUePU4irjTbIrwHTLHOd8yTTjGALEX3uTlL+oGEejY7vaqITriuB
	fwZ0nZGpIenOpVh9I0ViBcbNOHjsf401+7
X-Gm-Gg: AY/fxX58eEg4RuHjlFYbYCfyCsefCHAVpLrYW/+movGIg7t7jBmSapXW5jxHD0VKeND
	4ks1wKLWHizfVP2Jii7TfpQxMn90sibEhHyaJoU66v7CUcLNPxbzHekU2D34Kywz9YyRm4T3ARm
	pXb5HWqrUciXR/3lw3GwC/9jDHeOeD2ofmLl5aV2Vb+RelSvdYqao0/x4WoChwxpdXUD0ZKWM4f
	QFfgMI6ajw2UCDK/me/Hk3MXTRQMb1xddmF8J7jNgksiVfKqS7kYv6vZ5p9N/w2F9qBKQ==
X-Received: by 2002:a5d:5d83:0:b0:432:86de:f396 with SMTP id ffacd0b85a97d-432c3778dbamr4719705f8f.26.1767825204296;
        Wed, 07 Jan 2026 14:33:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIN2Du1SnTyzg+3OHwU4Q86kR8t4orcibSR0LaDUW1yBL0SOLJpnq1WRIlbR5jNipu5lBqW9irEzFt4CIPLS0=
X-Received: by 2002:a5d:5d83:0:b0:432:86de:f396 with SMTP id
 ffacd0b85a97d-432c3778dbamr4719684f8f.26.1767825203946; Wed, 07 Jan 2026
 14:33:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260101090516.316883-1-pbonzini@redhat.com> <20260101090516.316883-2-pbonzini@redhat.com>
 <c79eaf34-766e-4637-aa09-7eebbec26e0d@intel.com>
In-Reply-To: <c79eaf34-766e-4637-aa09-7eebbec26e0d@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 7 Jan 2026 23:33:12 +0100
X-Gm-Features: AQt7F2q_9pEgHsXT2Qg_PuwHAW8sbGhk3udXGcbrhYZaUfOKpfpMhUAIMA8t1t8
Message-ID: <CABgObfZz4hBscKLMhzTK4YMVWPRiUbH9m19qV4a-2DZ9C76XmQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86/fpu: Clear XSTATE_BV[i] in save state whenever XFD[i]=1
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com, 
	x86@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 1:29=E2=80=AFAM Chang S. Bae <chang.seok.bae@intel.c=
om> wrote:
>
> On 1/1/2026 1:05 AM, Paolo Bonzini wrote:
> >
> > Therefore, XFD can only go out of sync with XSTATE_BV in the above
> > interrupt case, or in similar scenarios involving preemption on
>
> This seems to restate the scenario already described above; I=E2=80=99m n=
ot sure
> whether the repetition is intentional.
>
> > preemptible kernels, and it we can consider it (de facto) part of KVM
>                             ^^^^^
> I assume you meant 'we' here though, you might want to slightly rephrase
> it, given the previous debate:
>
>    https://lore.kernel.org/all/87iko54f42.ffs@tglx/

There are two possible "we"s:

1) the code - in the context of this patch this would be "we force
XSTATE_BV[i] to 0" or "we can be preempted", and I agree it's bad form

2) the community, or the maintainers - this is the case in the commit
message, and I think it's acceptable. While I (Paolo) cannot forcibly
come to your computer and clear XSTATE_BV[i], I certainly can decide
that KVM will do so. :)

> > ABI that KVM_GET_XSAVE returns XSTATE_BV[i]=3D0 for XFD-disabled featur=
es.
>
> On my side, testing on AMX systems, I was able to reproduce the issue
> described and confirm that this patch resolves it:
>
>    Tested-by: Chang S. Bae <chang.seok.bae@intel.com>
>    Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>

Thanks!

Paolo


