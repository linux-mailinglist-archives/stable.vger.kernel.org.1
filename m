Return-Path: <stable+bounces-230215-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM6MCr3iwmmPnAQAu9opvQ
	(envelope-from <stable+bounces-230215-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:15:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D56CD31B4C2
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0274030731BE
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 19:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF213C0620;
	Tue, 24 Mar 2026 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml2A5gc2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA903BF69B
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379391; cv=pass; b=djxBHSoMkGOp2btunRNti1UdYgVAwtDpI9yh2CVeDakO6NwaEEn4QtngKYn8KRm7ki2biVOXhf1eY3WSt1FUs0Sfsk6ybeBJlN1aO8kA2S23wc1XxgO3D5Zu+OfJzfIdpH+EgnlQZSxGF3nGPC11P2PI8VKOnT6Bx5sArZLBli8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379391; c=relaxed/simple;
	bh=ga4JV9/szVDdjkZ43SYWlrewDuBoIpvwjFPyFW+tFfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEySl9/kQwNYMZfbM4z2cLtXvowT2MqXbwIj6vKKMMR6rAXyrZ5pEViT5t2JjtTw6ogc3088/rsAMxoh32QQyELPzVl0dnCBNJQ6lXopr1MnlD5w3LpuxVcmrTz4VyPHHZcMLdV4GI46AKArQscg3hOMvbEJ6/+3eG6R0SmmLe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ml2A5gc2; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9825ba7f9dso28221066b.0
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 12:09:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774379386; cv=none;
        d=google.com; s=arc-20240605;
        b=RPdh+exv6E4M8fJBZYGJmJ8yRYystg53IlZHjmFRiEJmINz8LPq6Du5sbq5ersCdRK
         xFCWf6UzmcEvslcVHc0wt6BSiPiNAPf7qftPcXoxHynjAWcWC0AyBj+idgN5rhe7Jofs
         my/lQ89Rg1wUjZXFQcnRhXPBpgZSu0jFI5K9qWG0I4DxGyQO+VuNPYY/sdXPS11Firmv
         gnt7xu2dL9Fh15KJXvzXA+GkC6J35mZrHnM5oPffqNLeJ00kV6KrHD6RDsHYVhgVB7Hx
         /TLg3RVe0u8DhmmEO34woNbyTJdblIRXysnCf+6u0FRU/fgmeOymzhxTwu2pw3GR9M+C
         nfSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ga4JV9/szVDdjkZ43SYWlrewDuBoIpvwjFPyFW+tFfI=;
        fh=KAjne1zqX7H5TzQdRsaAK5wDVuaKDr70ckV+9YnjQHs=;
        b=FVGdmzFqeeassCdSfDUcFuqAGJr9zlxy3hOsmkngZ9dTq49yo9bd9ECztuOZmz8zoQ
         5Y2wmi17hzy27DnYvPt7QUbFpDmEitcChQLnz3QXFTIbArHVfaUEEHhtUA7Q9SE44++3
         4QwnJMXyD36fpBB/KgMV7G/KNOBvynpHTygzsw3QFeRYxavXjUO5wychlLT8c/meNBcs
         Yzb4jegXB1vDnm63btz4Zl2GYyNrrWv/zUnFC0YaxlxFMl87Lnu6CLB8oolYVb4UTcLe
         zEBGLBsOwMkI6TIR/GGCT78J7UhrR1h0EkwRCDVc1wf2O7gekL/36YAPbNbdCgu/ysUf
         tSJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774379386; x=1774984186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ga4JV9/szVDdjkZ43SYWlrewDuBoIpvwjFPyFW+tFfI=;
        b=ml2A5gc23gixB6w2ls+wZD2LzDVFGcFqVAWFp5zsZv/MTpUePrCo+GHu/6tHQFzwTI
         7IhsnArMGNH2e3jlv+eNSqD04QiwQ1L1uXA71LjyFfMYuE75zlikwCu2B/dDphs3EcJV
         0L8HDliyyqdMqL6NwF49ZCn6bRqZ0DwQ570biJ9lBBBfVvi7KV5KyNbzfpEp3teRKabs
         4a16yx5QOxVLZtA+vYg/8bj5uImShoPztCO7zkIWFvlXJt+sdE3uLP9QkE2VOkKRqcEL
         +cX+jaLZBSQ5affNchdCwL0VyScyaFNOf1RTe6dukca41DUC6z2uzIYEX4KfeUq6jK8x
         HeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774379386; x=1774984186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ga4JV9/szVDdjkZ43SYWlrewDuBoIpvwjFPyFW+tFfI=;
        b=gvPAIR3Zseyl5mueovZn9J+VzLZh5lk4YlA4WWy+rx6XAZAzGWq4MeFeKHLKWXXJ8c
         3c7L5km2On2pdTCE6K/YBRS9ky3v40kLYTulj9yton3nHMvoemVCF+7AYWfedy29y4zw
         Bqq+MBnSzkbH/TBjvvFN0KZs8MKaqz/d2zmVqQ9Zm9BKJgQquKE8xRTqLNHyYVeHHI/O
         4OJLymtUo9HyYU6vWNPSBwqx38Bl6La6Lo+XDiMriize3959raVhcVQYPDNLnejkOgPX
         Th9ysrcPO3ESBtXuplM59ovZ5jbAM9J0koNgru1VMQtsOMtQPFVn0xLGEXyc99mEGEvl
         USpw==
X-Forwarded-Encrypted: i=1; AJvYcCX8BW6i/MG/3neNnyCeWNnHFpna7EwZ0Ayk/pXoxFnNvGfMB+Nm2vV4/hTiWqUWILkUAqdYQ3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVtxYe70+Efr2U0v32am1OAtjMt55KOHvFWUJdACMKQaUzcx9J
	nhXt2eV9ltzMEzN2lYpu8KxWi+MeJAP6UaxbzD8j91lCCLN1p+0xMDTjoyODryipSF2KIRIg9qr
	k+PgcwWpXREQxLe43m2sZtzIn71agZHU=
X-Gm-Gg: ATEYQzxYMwwOVdhiEnVwBVBZk+/IfLlE2pTr13SpwGC0vaFwF2ACwGkscS9KkppU2D1
	NKT2yBMNi12XTogJcj9fGEtYfiZ0cBhx4kk5qproxoMLYVyUMVtDJjOzqfYR4B+oN4mtuA5xucz
	YxutYQf0IXG/bQnBNXnDYMcyGRURA61gBVEftfoxOedCxZvg05AEVDA+C0N847wE1+Pl1+eXemo
	WZRoXMHewkMsAK9ayGwLYoegMXZbQibNsmygGXoSN94+cBTdHE5vAc9Sgo42MPF0/NnZDK51EtK
	2RL0jaZlm2tqnGDF8FJK+bvQ0BNDqAyxaZ6y8kk1dA==
X-Received: by 2002:a17:907:d506:b0:b98:65e:8fb with SMTP id
 a640c23a62f3a-b99ae1f8cecmr68146766b.5.1774379385581; Tue, 24 Mar 2026
 12:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324145750.90719-1-amir73il@gmail.com> <CAOdxtTY0jsqrJVXH=eQzYcowEpkDxwrk1DMgg8QD4ojygWJQ_Q@mail.gmail.com>
In-Reply-To: <CAOdxtTY0jsqrJVXH=eQzYcowEpkDxwrk1DMgg8QD4ojygWJQ_Q@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 24 Mar 2026 20:09:33 +0100
X-Gm-Features: AQROBzAWKQvwMoV1EBx8nxLnWhG3imj_5RCL11KUWt-xZJuWrBziHsnhxgQh7j0
Message-ID: <CAOQ4uxhdpJ5+awnceRzRxmP-ot25_w0LogLYpncLJZXxQOj33Q@mail.gmail.com>
Subject: Re: [PATCH] ovl: make fsync after metadata copy-up opt-in mount option
To: Chenglong Tang <chenglongtang@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, Fei Lv <feilv@asrmicro.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-230215-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D56CD31B4C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 7:04=E2=80=AFPM Chenglong Tang <chenglongtang@googl=
e.com> wrote:
>
> Hi,
>
> Regarding the patch: because we are currently locked to the 6.12 LTS
> kernel, this patch doesn't apply cleanly to our tree (due to missing
> mainline dependencies like the str_on_off helper).

Hence:
Depends: 50e638beb67e0 ("ovl: Use str_on_off() helper in ovl_show_options()=
")
I added it for bots and humans that do backporting to 6.12.

It is not a "real" dependency. It is a weak dependency for clean apply
which works well for 6.12.y.

>
> Since we are actively tracking this for a Google COS customer
> escalation, do you have a rough timeline for when you expect this to
> be merged into mainline and subsequently picked up by the 6.12 stable
> queue?
>

It's queued on the ovl-fixes branch to be merged into linux-next
tonight.

If there are no rejects from bots or humans, I plan to send it to Linus
before the weekend.

> We will officially pull it into the COS tree as soon as it lands in
> linux-stable.
>
> Thanks again for the excellent support,

Your report was very informative and well prepared.
This helps :)

Thanks,
Amir.

