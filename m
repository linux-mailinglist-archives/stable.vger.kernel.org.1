Return-Path: <stable+bounces-242645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDI7J3Dh9mm0ZQIAu9opvQ
	(envelope-from <stable+bounces-242645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 07:47:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B974B483C
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 07:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59C89300BC97
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 05:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AF639B94A;
	Sun,  3 May 2026 05:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJdoVGAc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23381FF7C8
	for <stable@vger.kernel.org>; Sun,  3 May 2026 05:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777787241; cv=pass; b=f8Qqja0bgKDJzYYl8hY6wedYHidNBWLcUssvAHc60E5SqXxGesCRXsV3f2BzPzzsoxAqFz7W9jAvV2cO+fJLMI/HMouzReJV1sTQGO9ItdBY6CyO3pzM+srxcFeMNVY3OIOODhHDScIc3/YQ1cZTtjSCWIn9uNf1dMP7f8DqnW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777787241; c=relaxed/simple;
	bh=Gwi6pvb3hjcMt8fTNF3earE9PfFGE1h1a2RJcXF/9wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wc2iONn/NBVmYleXDs3FjUFe0o59OROey6ovV3UbvgHXPPkUCWQdyzq3FmO0j4FNbpzQGdKUi8NHpLza9NRXdL4XZw9/eYZdU+siwwgKa61u5t4AcqtA1dEgrKTh/f+EOsSi3YFyEJsUmbQlEz1pcLw8jh9Sgv7HI8CE71FBGvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJdoVGAc; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso21687255e9.0
        for <stable@vger.kernel.org>; Sat, 02 May 2026 22:47:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777787238; cv=none;
        d=google.com; s=arc-20240605;
        b=ebXH8ZBDl4JM+aJpE+cYxinwBiRCHD4UPEMRlnPx6TszYwnwGw5C6/A2oWcpxr/wKh
         dLWGsbKIeRGokHLIXEtSqmXziO1lCZmgTu0arxcYmJQdOBS2CNiAIPxllHWGeimPJo0b
         p4bV01fHX0le7YzD1qxtSsN8DH3Nj0yo/7UrusgE6uztS7jl9uy83g1S9YkzrRVib1zM
         rhghM2qf5Pd4vF5foY+J/3+aJMsiIHrUKDQsKcGv3weL+WgtQL8hZJOEMYAsqHpqpd55
         sa9Qm//OtyGGYYzLmGvGBBuLNu/ebPdQ4fNrgWGyfkS5pCPrA43QY6A45KxFD5eOqbHB
         Lnsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Gwi6pvb3hjcMt8fTNF3earE9PfFGE1h1a2RJcXF/9wA=;
        fh=x/kksy6D4B9EcUWnHEmHtWcH3FU6el1SIL6TaH827mE=;
        b=aSzjG2GQHlr7r3Ud9UxyCpBmo0H1iEDoxnS5oNyMhG/sjNItepMUf2T07FgA/kCZKv
         ON6AgqhIdeDfEsTqOh16zwjJQamv8Za6B92U7fMcz88eWffISfSm9iW9ermHRLQSLpwO
         5XB6hD3xlfjq7jPhOG2f0pJfj9wM/dc92qhorPLrYrGBru7cBX295RRQFl5jQTNFRjWf
         koKMZeHRjAbjzAW6vKrmWUT/k/DrP3iAWnrwzxWevsaTPSvErd4Lf5XURto1fKHPxm8u
         hmsTZz+uXXIgI2CcSxlZUhVblgPUqIL6ms/0CIcX0IVImh0AZXRMOdh5206uiHWVKlkZ
         Taiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777787238; x=1778392038; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gwi6pvb3hjcMt8fTNF3earE9PfFGE1h1a2RJcXF/9wA=;
        b=nJdoVGAcEkcwvwa2YZYPP2mz+YhC84bimEyCWPP+kbuBLCvkU3IkAqUHU7F9d4aG72
         NwxRy0qKroYp1kNfgg3bjYeonrFqgH2NtjnNI5MjPnUZMVt7gIiQ2EN3RX8AuhybMRH1
         wvureBrzTlW3RifpBIIRcCoit5gMWlKX4QimQhomim8qUwULBoI6V0tO3hKi5Fg3zn+G
         gOSbC1raMyKFM+TlaumxvoeuKYqXHO4gJuZ0xKtvsflwVwJRR+I7Y8r1zxupXelrHPZQ
         rt+TRenDrmdVWVPgew41vQvZJfY7V12riaem5j5c4xlvE6A6SQbLfKGsloGImCgz6i7E
         006w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777787238; x=1778392038;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gwi6pvb3hjcMt8fTNF3earE9PfFGE1h1a2RJcXF/9wA=;
        b=c13B5JIzqZ8X55lJ4oFEC7HuU2ov9UJ1RLKVjd/BdAW1c5TLXeQN2LHkRPrz9BNVyU
         yb58Ovirc0rpKf4PVzqa/xCD8dRw3qPEpEhpRlnMQN42YXHoi7bUI9uPaPRAwVUTo5Zl
         eyVvMV7wDQPOxLamSwhzN2HBWw4bALN5hD4c93T7gOfAULZ5EEPnU4zeqZvmaQae0Izu
         NgLGIYbHrdYZTgEjdlSZ7+xZciVWtq1u3oFfbmlYPiVi7GvnsqGsSDVvEGoZyKK5H3DE
         EBRmXuQvEWovC7h2ba4lvmQUD3s/vjjGBbJViL12SWNpApUzZcBYOjxF0BZGYFSSZGPN
         5X0A==
X-Forwarded-Encrypted: i=1; AFNElJ88BmylYhCDb1EeVXpupy2oZLfFUs1DvYQVdCzCe10bHtORZgnAWfzd94hFhEA2xklTLqg1FYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw0OFKvzwI46UOCxMjoN1pmKZrB0K5EAIRBKaE6qCHKblp8zij
	f2D867CfMFc6eP1J2HCA8O1aroanzVeb9OxCFsl3OQQf09U7GyB5805EHdBYzY/HtERyTZj0DVj
	DspqjCT47m+X6jmMmH/EmY9vTjXVgIWY=
X-Gm-Gg: AeBDievB0MxeofPhLUAxKz4yzBgnpI3sGqlGRltwZw+9d6n0DA+cb9H5BMLDnsKN/i2
	y+ahUh5tVNeM9mv+g7kNOIPJ89Dk9JgewjJQtEnYcfGLvBuePYbsbhwtu/yC0I5coyD/v4EXsM1
	4PlQEb0X9mMLBJn1obermxErasV5GcvQC7FcV45MQ0i+DNz5fcpBP50gJ381Ogi3ExlnEYgnd3F
	joLCcYbu9w9dK54nKIz5QjyP+Jg0eFhUHBPTC6CT3bKOR9fIyE6fO/R3LfCQo/FcbXuu1HAyjtp
	RgpJpaVEo97DwL+zcA==
X-Received: by 2002:a05:600c:8903:b0:48a:525b:e148 with SMTP id
 5b1f17b1804b1-48a9886c261mr50519415e9.4.1777787237939; Sat, 02 May 2026
 22:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502150918.4171847-1-maoyi.xie@ntu.edu.sg> <20260502095359.496aae9f@kernel.org>
In-Reply-To: <20260502095359.496aae9f@kernel.org>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Sun, 3 May 2026 13:47:05 +0800
X-Gm-Features: AVHnY4IEGWL4tTeNfR67_PQ1mfQ_U47NZBvXSzMFrhIM5oPqayxpX6ibwbvdygU
Message-ID: <CAHPEe=HWWpXR_eR6OLgyPATeBW3CmyyifQrKZ02JN2GPGP9Fyg@mail.gmail.com>
Subject: Re: [PATCH net v6] ipv6: flowlabel: enforce per-netns limit for
 unprivileged callers
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	dsahern@kernel.org, kuznet@ms2.inr.ac.ru, willemb@google.com, 
	willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 00B974B483C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242645-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,google.com,kernel.org,ms2.inr.ac.ru,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Sat, 2 May 2026 16:54:00 -0800, Jakub Kicinski wrote:
> You're getting emailed over and over by the bot telling you not
> to send new version of your patches before 24h passed. Do you
> not understand that message? If you keep violating the rules
> your patches will get automatically discarded.

Apologies, Jakub. The 24-hour rule was clearly stated and I should
have honoured it. I will respect the 24-hour minimum on all future
revisions to net. I am sorry for the noise.

Best regards,
Maoyi

