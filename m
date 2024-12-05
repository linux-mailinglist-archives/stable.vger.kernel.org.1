Return-Path: <stable+bounces-98732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 563809E4E60
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 08:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5DA169136
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 07:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ECB1B218C;
	Thu,  5 Dec 2024 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2lkAgf8"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F6A1B0F06
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383865; cv=none; b=iHiObomuOR++yULV0h7JTTwhPVkErkmn/HMNu16t+XAaEU/zaFFR5h+WIdD12xo+BETX4+IQGgsbrXl/W++Apntryr2DNKf22g5hOJPgJbVaI37pNr704csQMhsDGrsoAFtvkrX49Na14J0ZdwBXpI6yWT++rt+j8kiNvrmczeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383865; c=relaxed/simple;
	bh=gBsazSA+2P8jNheF6Uy8VcoZ1wvAMnui60NL3/2jmLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TV63Fmwbc1Y9ODU5uKU3g5HuyvrwiZTmg7Atvg7jiECwy9DiDp8dIBWlpMTqokm2EBZYWCZ5QSYE5QwB+QHbk1D40eh6ZqKayqMFPDBpCjwxn8ODUpGSireXjGWhMTJo4KKMjzKSEjagoUnWhh/cCaSqRPPv88o6GYD8OxNudsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2lkAgf8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733383863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fQByPnPwbfne/yS8JI9pQTP84ZOieAk2em/vkGbruFk=;
	b=X2lkAgf8Bx1Md7lj76LD0PoHnb0nHaSW3yCTGGu0T+G+DfAZbkDSh1NiuUHmucScrGJudl
	G4CJPWDvRNJClR93yNLGLVofYd0sgqpSm1zGOFSw442BkEeZGJIzZ4DUW4Ilh2T+sWgX3D
	X8j0WhZUYMS8burLdQp9wLKn6pB1vLk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-0SE_5O-kMJmbI1KBekHopQ-1; Thu, 05 Dec 2024 02:31:01 -0500
X-MC-Unique: 0SE_5O-kMJmbI1KBekHopQ-1
X-Mimecast-MFC-AGG-ID: 0SE_5O-kMJmbI1KBekHopQ
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ee6ea04326so1133836a91.3
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 23:31:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383860; x=1733988660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQByPnPwbfne/yS8JI9pQTP84ZOieAk2em/vkGbruFk=;
        b=t4gegQtu5f3CnCz+hdy/0kdr+szuB6DgCsXupBmO7k4IHoFVXNdD4Revj9qckIVqbf
         xVsUGRvvugCA6tr5Hb4R00Jlx/nOv1GRuqR5+WEfdy7gDGZRbO08PtRnASEF3zdbaRBp
         YrJZ65bLLuGzbuHyGDC6rJxQvbjcOyNxC4j7Wn7XUpJniQvaXM/pUfkI5qTXFghSfh2q
         Rdje8yvkIgy6xtXf/Ytg2hI7FPwTY6iu5yIPDfLI3CyqwcTEmsKU8RUm0xSLHBBKuT1R
         44I1GFIsmx6ly0NZTGq7TdP5nJFxYNTNcbGAK7i5w/B1hTQjNlnmX2sperhCHmdnaEz0
         rrQg==
X-Forwarded-Encrypted: i=1; AJvYcCV0S9WZgyTxL8HEupBZumQAmMTZXY4gwRAw0EpbiGxxXo6zKUL9SzMm8ZGUieOgQ3KpQKnsmG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbfG7w9ZcRYYnwlq6Le0KyU6Ux22LhYCn1XeDnrRh2Ljr9it3y
	w1pRY2S3q/EiOq9uI3NrV0rLkupNT5Qgg2hfw+OHq//qKVxX9ywvyQ83GJSJm4dFQ960Stx4C4N
	Sf7CvyxtoakqZgnLzf3ojQR2RCalzzOHVLJmJ1M0oR117RLA7K9Gzh0lrU2zpNc0jgETK9/6vGC
	y9cFWRYp1/bhpxodDq84p489riiQtp
X-Gm-Gg: ASbGnctPGV4ivvNxFFEbYDulOoS/6BbpPh4VVN69CIP1TaRsmO/FGgImupc7D4ykOGK
	Ae6fbCRL25pjRDSx+PNw2kJpkl3hEOuHBIND4
X-Received: by 2002:a17:90b:4a41:b0:2ee:a127:ba8b with SMTP id 98e67ed59e1d1-2ef012730dcmr11339467a91.36.1733383859156;
        Wed, 04 Dec 2024 23:30:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgjvvMf7JapTRuI1SObNMq7BvZhIqMSi6SZblyK6LzMeh4bpcCn3KV3lIBqaI+D6cczvydNaQWvE4gxNRWDj8=
X-Received: by 2002:a17:90b:4a41:b0:2ee:a127:ba8b with SMTP id
 98e67ed59e1d1-2ef012730dcmr11339393a91.36.1733383857900; Wed, 04 Dec 2024
 23:30:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-3-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-3-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:30:46 +0800
Message-ID: <CACGkMEuhhgNWZst2LAWStw+agvLjPrV+c2ZHe8JL4zLej2ZzGw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/7] virtio_net: replace vq2rxq with vq2txq
 where appropriate
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:08=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> While not harmful, using vq2rxq where it's always sq appears odd.
> Replace it with the more appropriate vq2txq for clarity and correctness.
>
> Fixes: 89f86675cb03 ("virtio_net: xsk: tx: support xmit xsk buffer")
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


