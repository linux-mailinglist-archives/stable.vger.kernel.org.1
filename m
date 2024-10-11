Return-Path: <stable+bounces-83461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCD299A5CC
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 16:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB0C1C21E57
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40719218D90;
	Fri, 11 Oct 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3Gz4Nc/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5C92185AF;
	Fri, 11 Oct 2024 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728655783; cv=none; b=pwMaLr7iSaBTFSGu1ZPOZB7mWcik6hXl36vLTvn6VDubabWmB7B0+ftAQtrIE44qH6Pr4+lLygB2rOONaw61AYY9wCFi21sWKdEOmS+LWVsLQmT1b4HbMxIaIWPAjMja39ybPYeN1WhRDXT8Wtf0QfZkeXW/9NPtYhOSiB4roYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728655783; c=relaxed/simple;
	bh=kW9CDWhL8cU10uW30Ctc/KnAKpjn0N92tlitb9iuIII=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NuboeepslK1QCVvJKSCJK8ZMb3e8znlyivij1+n8op0mKoNy6bbuhIlRQcGPoCytfaxoAHw3FWHlIvLAItfgiMZlJc4Rl4kqr6pk7kGQQq9bXO4quetL+VXlWIvqMrPAttH2HyPdcghklWGQxgbT2uJU7inDOLCK56Q/rZ3l5HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3Gz4Nc/; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46040dadedfso19676351cf.1;
        Fri, 11 Oct 2024 07:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728655780; x=1729260580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csdorD/XI9vvOYRw8oWUox4UAr37xXSbNh8csh0YlvE=;
        b=R3Gz4Nc/bwVzExpNfEDGgoyuoBVNd8rRZuY0XWVReV5uhrjKgXXGg844OqxHL2zV/+
         af3Ms58epqjeGpUa5OEElE55uKwFdHYK3qTXHvEq3/azETGpT9DQq6TbT8IfbSMoPajF
         kf4ad2JQJ69cK0fx6JGnzZcj1Y787VSzWWGhoB8oZa4OLB0He6U4X8n2L+pPH/jwoDmP
         Zy8Nj+PSW3Q+MfsY8oondFCSldSCRV3U9hkzYWqjPlrLSm/voN4WStwe3IZKsYonLvGq
         XFUpJS7jvIcOi0TgDvJ2x2XdllFu2Lt35NoBcsX1Gg+UcMIFrl33g/07g2/OCmVjl0NF
         /73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728655780; x=1729260580;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=csdorD/XI9vvOYRw8oWUox4UAr37xXSbNh8csh0YlvE=;
        b=GaY8q+WtIPgrc6LwbN7/MZddMvERZinbO4tuzsc+3aN0ARKxv8ded7sR41eQ30t0SM
         pTgqARSzV+MkZ1LNLjoyMTj/h7dq50GowCTNDzuqHj89Rm25CL2TLdWagrxE9HYQcUHb
         te0g2h3ZUB9SXh/CsnidKMDTmSGTm1V6pSF30prswuH9mUuVRqpfdpTsMKZqAQuT0l+D
         Ah4TVJd5Dns3Ls1dNm9POlyMajyqiDclz3O++9tAAnv5+/emILbLS0W1ZLnQg+lRRxAh
         BQHxkiCzHBGF2Bzu4Uinhz5Dcy5xFGGIMibUUsrbUSbhR9wSp2oTyd5Eyyogdezy9QQ3
         DpxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcLBBBEuP5xKdDJxMMH4inoNfOby1gmF1Lz84zXEnKbAHoRasPK5pWJQdv0mGhVaEyUGwUtqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKDkwws/5p2W7QqX4xRjlpubH5luJRsV08DQeCruYEX7JLgE40
	NR5KMJuPAeWuZrRfV+/HFuyc6npfHkKNGf07RkB0nbqh4vxAUyqq
X-Google-Smtp-Source: AGHT+IHLko3U+XuJKW4KKsn1xXk814wIHDBygDMBFuKBHZLLU6nMu+8vFr1dqz3VYQ9FPYHGnkmDPw==
X-Received: by 2002:a05:622a:1f07:b0:458:4ded:fe99 with SMTP id d75a77b69052e-4604bc2e4ffmr44246951cf.42.1728655780094;
        Fri, 11 Oct 2024 07:09:40 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46042789ba9sm15573261cf.14.2024.10.11.07.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:09:39 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:09:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 kernel-team@cloudflare.com, 
 Ivan Babrou <ivan@cloudflare.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 stable@vger.kernel.org
Message-ID: <670931a2edb62_234aca29433@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241011-uso-swcsum-fixup-v2-1-6e1ddc199af9@cloudflare.com>
References: <20241011-uso-swcsum-fixup-v2-1-6e1ddc199af9@cloudflare.com>
Subject: Re: [PATCH net v2] udp: Compute L4 checksum as usual when not
 segmenting the skb
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> If:
> 
>   1) the user requested USO, but
>   2) there is not enough payload for GSO to kick in, and
>   3) the egress device doesn't offer checksum offload, then
> 
> we want to compute the L4 checksum in software early on.
> 
> In the case when we are not taking the GSO path, but it has been requested,
> the software checksum fallback in skb_segment doesn't get a chance to
> compute the full checksum, if the egress device can't do it. As a result we
> end up sending UDP datagrams with only a partial checksum filled in, which
> the peer will discard.
> 
> Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no checksum offload")
> Reported-by: Ivan Babrou <ivan@cloudflare.com>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> Acked-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: stable@vger.kernel.org

You already included my Acked-by, but just to confirm: LGTM.

