Return-Path: <stable+bounces-61295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7B293B325
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 16:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B900AB2709B
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 14:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8DC15B0FC;
	Wed, 24 Jul 2024 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQcULf2Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB1A15ADA1;
	Wed, 24 Jul 2024 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832738; cv=none; b=K/K4zb5Pq9EclbsbqCb2MWq1lmQTcBkuRzItBGqY8iyhAAp/xQ+sZVVOHPWLHT7UCE/AAxGw42SxWiePXy/kZ7WqE71MkllTjHSEAOuC2HXXIgSFEoG1+aKBCQ3TPnoT8SWibHOVYpwWIbcg/0cjfVuan1hqLM90q1n2g/Lkw+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832738; c=relaxed/simple;
	bh=Ln3HGzrlfOKzqGtbw59RdK0phd7oplJGPbSpALOEYSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/65LsKMo+9FrsYlZ2WSnm+lulhkisKuJPOYF3thDC611UFd+mGitI33e6VDv+W1e3ehNwoPpnh5PuvKi70zuiy+IFnZaPL6vpvnY8jiFboBnYwM7y7v7RSb6/p++yfDRk77SzTLWHPEcIr8e9m+jpJznPnvIDU6DQlXX5kDrO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQcULf2Z; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4928da539c3so1107978137.1;
        Wed, 24 Jul 2024 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721832735; x=1722437535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ln3HGzrlfOKzqGtbw59RdK0phd7oplJGPbSpALOEYSU=;
        b=XQcULf2Z1nZwohNwVLmiJNLCs2/+XFSTGYYCQv4R8wEC/tS9dhdaR7lCwiEnuRO47c
         EMXgDwuCGGUEIRgsrR1wUjmEFxQtxM94FtRPX3v5D+JtAO0yVAIVsLdG1dYDRa3g2EmC
         zQJ/HdLWSxpM6T5c9KgHYEKnpmqtaihij0YHD6IZr+Rxqwe9cafeTdz5UgikS3bYLDUK
         NGq9suCqVEuZmf7Loyt/2kwCeKklERHxG0McHtn7SlbEd+k5rlZwf3TQNzmzSJY+S5Sj
         sO9FUAsJ3vrpc8VUL6+AsTbMuHW1QnXQDEtOtDZx8FclxgI66IszWsJ0K/2cZVNCUKsm
         RaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721832735; x=1722437535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ln3HGzrlfOKzqGtbw59RdK0phd7oplJGPbSpALOEYSU=;
        b=X8RF1wulwG4z5ahD6vt5eKEmKmKU3mf9+2ta28sv9KYxDpsqVvc4EH1J+LyiPMH6nF
         vZxEelxj1owm34hPq3eO8DGfS8SrogYsRbeqSXJpHguPwwfRF+vAWOvRaC6ZH7DXWfQY
         aBV2nijek8wkGox92SPGNsU2ZrosvkEcz03Y3oxQy9+rK6g0QqrsAeA20yVySYJDk5S4
         HXwnTOjXu+MX1PU4B2czlmQSVJn3DNgrx0MwzrUiqaN63w98sRQs8tbkkroz7xpd11IQ
         VZ/t4jW97l5GAV+xMVDXy43um6gQ+Cg3/vaWMT8wBQFOS7S4gXpgCeSQ1JietahWPf9G
         6MGg==
X-Forwarded-Encrypted: i=1; AJvYcCVA4/WNiwnwpygkYSE1Ubl4dz8vbO5S4a0Y3XsSfl27jYNNZgIR59bC8Dm7Toqg860m/ux8HvLcJPL6qvZpKE1am4HCuS7h
X-Gm-Message-State: AOJu0YyViUq53ixNNxM52YRsQagBKU+2mTyn/SNQZ2Jh4+iQLc6u0jTi
	M/OE9BtL2pogp1ZMiuunZQjdT+wdfWE/+ODx4YUYpncwzkbqh6SVQLSFJW8917n8N4PdgfEBDsI
	NshEuSn4z1QhvmV53WKM9Z2ugzgk=
X-Google-Smtp-Source: AGHT+IFk5nYeYr/7VZTRZ21R6FK7mPQAGXA53+XCraPsBaIg6FPxXz2GMt7WoUG26w0yIkF1KrM8MPzRC7P7sOigt5w=
X-Received: by 2002:a67:e7ca:0:b0:493:d1c3:1aef with SMTP id
 ada2fe7eead31-493d1c320b4mr807352137.14.1721832735502; Wed, 24 Jul 2024
 07:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724143431.3343722-1-pkaligineedi@google.com>
In-Reply-To: <20240724143431.3343722-1-pkaligineedi@google.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 24 Jul 2024 10:51:39 -0400
Message-ID: <CAF=yD-+y4Qd4nqTsOKq3cX==HvofeH_9FsgmiPXMcU3i9Hhn1w@mail.gmail.com>
Subject: Re: [PATCH net v2] gve: Fix an edge case for TSO skb validity check
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, shailend@google.com, 
	hramamurthy@google.com, csully@google.com, jfraker@google.com, 
	stable@vger.kernel.org, Bailey Forrest <bcf@google.com>, 
	Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 10:35=E2=80=AFAM Praveen Kaligineedi
<pkaligineedi@google.com> wrote:
>
> From: Bailey Forrest <bcf@google.com>
>
> The NIC requires each TSO segment to not span more than 10
> descriptors. NIC further requires each descriptor to not exceed
> 16KB - 1 (GVE_TX_MAX_BUF_SIZE_DQO).
>
> The descriptors for an skb are generated by
> gve_tx_add_skb_no_copy_dqo() for DQO RDA queue format.
> gve_tx_add_skb_no_copy_dqo() loops through each skb frag and
> generates a descriptor for the entire frag if the frag size is
> not greater than GVE_TX_MAX_BUF_SIZE_DQO. If the frag size is
> greater than GVE_TX_MAX_BUF_SIZE_DQO, it is split into descriptor(s)
> of size GVE_TX_MAX_BUF_SIZE_DQO and a descriptor is generated for
> the remainder (frag size % GVE_TX_MAX_BUF_SIZE_DQO).
>
> gve_can_send_tso() checks if the descriptors thus generated for an
> skb would meet the requirement that each TSO-segment not span more
> than 10 descriptors. However, the current code misses an edge case
> when a TSO segment spans multiple descriptors within a large frag.
> This change fixes the edge case.
>
> gve_can_send_tso() relies on the assumption that max gso size (9728)
> is less than GVE_TX_MAX_BUF_SIZE_DQO and therefore within an skb
> fragment a TSO segment can never span more than 2 descriptors.
>
> Fixes: a57e5de476be ("gve: DQO: Add TX path")
> Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Signed-off-by: Bailey Forrest <bcf@google.com>
> Reviewed-by: Jeroen de Borst <jeroendb@google.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for the extra description. The way gve_tx_add_skb_no_copy_dqo
lays out descriptors, and the descriptor and segment max lengths are key.
Now I follow the calculation.

