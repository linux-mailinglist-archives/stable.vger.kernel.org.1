Return-Path: <stable+bounces-42789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B06F8B792D
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 16:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF7F1C22573
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 14:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87E41A38EC;
	Tue, 30 Apr 2024 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IRzstxTJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36D51BED66
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486253; cv=none; b=UADzChMQcRp2GFweESnGEfBTod+DGXgw9zxmyOTaAkuTVU+oVmYhRQSTkhZjxGIREvUViPcPZzW2DkxJFoFGpamQGgEkQRYlOlN+VTrP0RBnJffXumxvRDZXMYMvnB1DtHZSoevfYHPtYFCx5Z1YU3XjSfAHW7Eb+NTbYvWc7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486253; c=relaxed/simple;
	bh=wXeEDI3PBBpnP38xgjZueBZM8hRXH32paMvVIPlN0zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=If9rQjJfhoJJqUJ/EwXFLRKKVaCqI/XaRwmzqCSshIwf2kj7KbOFHKS9suwlKDFPDpjyb8qMGkUSD5fhJU2BdrrpLz598PbF9a77MEYfAYT9cpaiWtFRRcx4BaUlbVS+Qrm+/yLju44yYH0riZ6NQ3Fvg1X1kZXCfdKRDqbvpWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IRzstxTJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5727ce5b804so16248a12.0
        for <stable@vger.kernel.org>; Tue, 30 Apr 2024 07:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714486250; x=1715091050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flcLrs0CTLkRp4lwBH/tgPTamGYUt9unQEu51+eSG9A=;
        b=IRzstxTJEA+Opkhlppnte2uXbIU8lKD78ueMsFfsrZXc+DI8S3Cps4XcMMpx0FzZjh
         EHa+Jy/KGn2S8lv62OKXMskW0Hzg0HKcWzsSj5swMBSJMMYDEEcZqqfl2VMj8w/W92L+
         yQ+V+JcQqql7WBgXNDpFPFGJ8D4klufyYQlaNQ8aInVdZdnev75y+pDD/HVVvBVRrr4m
         dqws/f1gVzsZqJCEojC9zuoo9Yx4RU1ebqHvhW5nuo3UJN3iGoJIQysPtyk1QPx+l9bu
         vQJpIPykR90YuX251jvuXP/Moq2eIMjJq58PKUERi61z1GIvmNKdOix7TL3PO3fJWMQG
         hdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714486250; x=1715091050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flcLrs0CTLkRp4lwBH/tgPTamGYUt9unQEu51+eSG9A=;
        b=ZZRzvW9oPfbeR0WW5PHf7ACm482w8UMQz9bV1+3Sm+M+8kc+hXgKzOKT5mwmbxOfa/
         vVtHSqXIzw+kqX8A1kozlZ+uvvUJx94Rgh1BHwL4PIL7DFtB6P7yh+ytpkrL5xwpcQrf
         kpZtDOo6E89HLnaCM8aVRKuOHaFEmHsZm8AoYgLd5u6KAbg7t314O0GWuyWF14L8cNgn
         B62J0QIF3i3Wk6I4oHTkb+vjkZURxcs+PvJ6OgV4pJs4trwK/EfdWHMAkusVTclB46TH
         pGFxUTRLvjxe5NAujmWRHM0i4bvlnsMKzWE3i6I8gef8BaAQNmzYrBJ5efVTzoHh9XTj
         kW/g==
X-Forwarded-Encrypted: i=1; AJvYcCU7bpiQJKGU74LfeioHA+uTDg2L6SBGWOo3UP06JGiFLKmEuQ1punEEThpTaFK20kBC73QL+MgwPMGjamEAyKYgmC+UQbdJ
X-Gm-Message-State: AOJu0YyBXeg2BNyWST/Q+7IoOH6a0b3svC/HSoZSA2oglPQrJ6LwcFGP
	R4i2Ow63l4VqDshbkeneX9wShAEc6KWSA5objLEnlXwm2aIbiaaL1BWV5W/PIJFDHpDPXFTX4du
	MmDTECYXsi760VovtgJ2l8yeH0wGayV5hQ0eK
X-Google-Smtp-Source: AGHT+IFRVUNJVq9usLqD0aQ1nwKNEZGrhBiNwqO1rXgfFnz4VSVNxq2azlgdwljeZ+D7Qn5hsFjHAEsrjNRxWkII3/4=
X-Received: by 2002:a05:6402:2032:b0:572:7c06:9c0 with SMTP id
 ay18-20020a056402203200b005727c0609c0mr272713edb.0.1714486249968; Tue, 30 Apr
 2024 07:10:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <752f1ccf762223d109845365d07f55414058e5a3.1714484273.git.pabeni@redhat.com>
In-Reply-To: <752f1ccf762223d109845365d07f55414058e5a3.1714484273.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Apr 2024 16:10:38 +0200
Message-ID: <CANn89iJoxoA92tF3avTTL+rthen_iYfA6pc6wevNRkwnvaLWjg@mail.gmail.com>
Subject: Re: [PATCH net] tipc: fix UAF in error path
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>, 
	Ying Xue <ying.xue@windriver.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, tipc-discussion@lists.sourceforge.net, 
	Long Xin <lxin@redhat.com>, stable@vger.kernel.org, zdi-disclosures@trendmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 3:53=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Sam Page (sam4k) working with Trend Micro Zero Day Initiative reported
> a UAF in the tipc_buf_append() error path:
>
> BUG: KASAN: slab-use-after-free in kfree_skb_list_reason+0x47e/0x4c0
> linux/net/core/skbuff.c:1183
> Read of size 8 at addr ffff88804d2a7c80 by task poc/8034
>
>
> In the critical scenario, either the relevant skb is freed or its
> ownership is transferred into a frag_lists. In both cases, the cleanup
> code must not free it again: we need to clear the skb reference earlier.
>
> Fixes: 1149557d64c9 ("tipc: eliminate unnecessary linearization of incomi=
ng buffers")
> Cc: stable@vger.kernel.org
> Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-23852
> Acked-by: Xin Long <lucien.xin@gmail.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/tipc/msg.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

