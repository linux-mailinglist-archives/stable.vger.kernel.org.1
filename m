Return-Path: <stable+bounces-8679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C879781FB4D
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 22:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6371C20DFB
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 21:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D16107BA;
	Thu, 28 Dec 2023 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KcAuSLVw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C50107B9
	for <stable@vger.kernel.org>; Thu, 28 Dec 2023 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a1915034144so736259266b.0
        for <stable@vger.kernel.org>; Thu, 28 Dec 2023 13:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703797799; x=1704402599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+AajggGxr3GEQriePdKOBlkuW9RTdJPGAnYZl8As+M=;
        b=KcAuSLVw/rep/rpQP0wdRpm7CyenckutKi58G3VyAu1uCbp4Ccp6/qH0Q9aump6ju7
         8CWQVPZtfjn8e+ns6IRWIse82j0/ZWzD0yb7io4JjaiDmeeAdHllF75mmhRrwX4XwxMP
         M6lrdf8S8FTzs2C+YLonA9q0Tb1RAnnTDstFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703797799; x=1704402599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+AajggGxr3GEQriePdKOBlkuW9RTdJPGAnYZl8As+M=;
        b=MZiKREsTgtbfaURmuENZTVJXdRDBx4NeH9iQGu8+d6Vg7SSeNOXjrFjVPkkPo/vj42
         Ceb2iwQtvICL2b6uaM4Vc0aWQS5JVEw+Kprqpv0KQosVrvNnVjc5B1P3fK0MEC79zw52
         LlmIcwT3tFoA5A3GoScZbThK5hiz6dqGA+JpYW/6QrLK7g+CSZcxUk/G8NXsYHNcZW2Z
         tfyMxGKdwjRlf/c3P8pUymXSfkU1DX2ok7H2oUo+WVuZcCnUcjIMThl93sUka2iKQrw8
         CNZsV0Xl678v72JwJuPPBzCq+waeRnxJgNQt5Y+YkPY5cuYwdTy5lHPQEk6CzPiI2Yyy
         wPsA==
X-Gm-Message-State: AOJu0Yw0yAJwlFDU4GtdRFHLNnP0l+7ek7aFgcCYlJElomZxvtEx34f5
	lbdHioX98vBfEC0JmgNNzWCqK7t0jbGBqrVC2YAe2QhMlRQsnDpW
X-Google-Smtp-Source: AGHT+IHUS+3a5ER5QvRADceQ3TSYc3dNMadwOhEocQ3iLs3lQD1b3nWa7Lzv5RRYYQbeUtnXoa6MUQ==
X-Received: by 2002:a17:906:10dd:b0:a26:d9a9:ffeb with SMTP id v29-20020a17090610dd00b00a26d9a9ffebmr3747562ejv.82.1703797799388;
        Thu, 28 Dec 2023 13:09:59 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id ex17-20020a170907955100b00a269fa0d305sm7714987ejc.8.2023.12.28.13.09.58
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Dec 2023 13:09:58 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-555936e7018so880604a12.2
        for <stable@vger.kernel.org>; Thu, 28 Dec 2023 13:09:58 -0800 (PST)
X-Received: by 2002:a17:906:71d1:b0:a23:5905:1521 with SMTP id
 i17-20020a17090671d100b00a2359051521mr4039305ejk.100.1703797798163; Thu, 28
 Dec 2023 13:09:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228143737.17712-1-wander@redhat.com>
In-Reply-To: <20231228143737.17712-1-wander@redhat.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Thu, 28 Dec 2023 13:09:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg1VJR4WFT4VhEqXgE14dogJe9kbpYGBZdtai3ORomfOw@mail.gmail.com>
Message-ID: <CAHk-=wg1VJR4WFT4VhEqXgE14dogJe9kbpYGBZdtai3ORomfOw@mail.gmail.com>
Subject: Re: [PATCH] netfilter/nf_tables: fix UAF in catchall element removal
To: Wander Lairson Costa <wander@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: security@kernel.org, Kevin Rich <kevinrich1337@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Dec 2023 at 06:38, Wander Lairson Costa <wander@redhat.com> wrote:
>
> If the catchall element is gc'd when the pipapo set is removed, the element
> can be deactivated twice.
>
> When a set is deleted, the nft_map_deactivate() is called to deactivate the
> data of the set elements [1].

Please send this to the netdev list and netfilter-devel, it's already
on a public list thanks to the stable cc.

Pablo & al - see

    https://lore.kernel.org/all/20231228143737.17712-1-wander@redhat.com/

for the original full email.

            Linus

