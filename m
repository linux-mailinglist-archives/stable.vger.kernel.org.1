Return-Path: <stable+bounces-210758-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEzzNL3acGnCaQAAu9opvQ
	(envelope-from <stable+bounces-210758-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:55:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CED65801D
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 796204FE2DB
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38AF481FC8;
	Wed, 21 Jan 2026 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xaESdTrH"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DC9355049
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001934; cv=pass; b=Qw6UZC9v3cXNgfM5EGPdWR3IW8Az4yA7P8bkyxscCSo3BuqU3iTtuDaInFdjQw8XMfdyMbSmbydMCzqCSoMR2BapEBNJrq9S6P8eHtmopZZ/+ut7YKcT0zqW9QLAecL8RYwGtsufm0poqtCxyPBkPr+BXP+qlkRYK3HNt4dawEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001934; c=relaxed/simple;
	bh=f02HHK5xaFa+IVn4ZBSqEjh06+Q2Cs5toRGhg0b38zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nj40C+sKDCwkT7c3YcCMQZe3Sf09WW+DBEOBektNKrJB10r4cV6Av2/goI94i+UZBIcPCWkUNckmNUMWkRsYu1fp7ppGVUNYFJqKHNr/XDgnn+8fJB7Qxs9AKT6tiQuBM04lUB7l8X+zwtvoe+obZ3sdsJVR8HUe9xfPI1x4R7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xaESdTrH; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89469143ebcso12348126d6.1
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 05:25:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769001932; cv=none;
        d=google.com; s=arc-20240605;
        b=V2vujU7B/VDeNhi1qn2hKnw5CJX4AkG3JfEqHadbQt4FKgt2oK7+JgkfkXcVKALg/q
         rS6x9gpG85nMyWxLl8y44E1tui7XJfIDF8nJMWxAXH8A1heyc0p2C6VYU5+SP3S0Cusl
         ZN2ZVIP8oaMuP5PrjYtRZwJCEjCXxLow5V26sEQK43PL2WRItckdgbVHMFz/I7T4aYet
         vlxoCvKhHovVex692zywpXsoUB8GmErpMxlHsDUb4OvrmDrygUp9gy5SQZc71DyfC9xy
         ARP/mIBENsvupsNb/mS+PG0SAEi9gBFONqr0qLLvopLPtnMe1/h8DZvEJvNv5NCEgUmE
         i8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f02HHK5xaFa+IVn4ZBSqEjh06+Q2Cs5toRGhg0b38zs=;
        fh=AvlWk9nJOgV0ziqXdiLbwKQ22U7Ivfpa8zWEMryKkp8=;
        b=kzDiI3ypWcDjOSrVkW2u6qT56/zxH4y/lsIWlMfscyLgaV8wg/SUYtWN3fOrmdObJD
         27sl59qlEAlquHIFpIe8FaZmAFJdthnbyQvTkxI5pH4iiOl4WVs4lMGRhwYcnerprhDE
         ey6E+pgwvbBCepSIN9QW12H1k+fh4+WRTuPxjqAg3bMOe5Gvl9lzzApFB15yTi9h5qzB
         gqpG6GrtcQtDDKq00ih3pzgE4SVjP50eu2fQg/uC0o6KGRZOUGD6yuy1ChZeOsRg4OPo
         /29WkhhCbxQs3GR8LfR2xWO21Jxsy+6iNEsCWmtKnCCMnFdFqSj9Wv/83GpGDopeyY2F
         ylSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769001932; x=1769606732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f02HHK5xaFa+IVn4ZBSqEjh06+Q2Cs5toRGhg0b38zs=;
        b=xaESdTrHLodf7O5HIEv2td0RDPCAEHu3lRd0c1LZdvJ+3ncfcMYVq2J0HcdxyfedCA
         CxBXpfrtpqhX5dHMlT6wNnxfmBLYNftDIO9EtrwpLajVUD9REzWgmcxKEiMtvn8pwTe/
         v177C/krp4JLCzDJMpc8mJ7+orDvbWTJacsHmFdrzi+bCCdu6mTrmAzHFD2Rr6vQIcUE
         1SypTQWf3IqH7tB+SR1noz/QH4kW1XpT8634QUSNDhTj9pA2m2NuTZ+9UIc2scNKUSCq
         /gKkIObrK3HQROe/uFNxeBJgA2JoL/axvoX4tLBURDKqmm8ymdLQMB8ukDNNIFUdyGk0
         sbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769001932; x=1769606732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f02HHK5xaFa+IVn4ZBSqEjh06+Q2Cs5toRGhg0b38zs=;
        b=U9MW6sWBAOsU3psMVB9jmJ0RAXgnTl3RKqyCdk9bkmEZT3BuDpuQb4fqLYXbNuUKvh
         6dEKuZ3BctdFFXlCoouWfHuFffJaeLuotQKFpsLJoWChFOeWWa/GQaBC1lkA52SJ6cuQ
         4AChPEsi7Bx0ioudd8c7MB1xiZYDrLXrqMVynKoIe9p5JeW21DAzAffjbF0UvFMQeCf2
         dln2W2T4T4yzngA5NCyXRcAanhO5t2KOI8KBY1oRbwydI0RTSojpoD5fPcRq1AXwnxRw
         VTzTGh/8vQgkZ0fhYUam7cDzU8XrLV0GVGJF7UTPoK1PJivrRVLDcFXSGKGAGGBnayRF
         8DgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXGvYWxaKVmDTFjXVeaXW11Rz2bxx9qwtfrww6rIZohq5nFUmmpB8IHCtSfSYZU3n2zI1fyuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ1puVUsDSoxBWiU2gF5WThxZn6tiRdUeGbnOi2+9EZiMfx0mN
	z/xYfqI6h8qtq16lAZBFvyzlZaW4vgAvFbQ8ytlzHC6AhaDbXi3TSDmxjzGQisjb5D2/01rbPyW
	YfJAJ2Fz+t+P6BFlJQJ0UGfhDkn92cL+OUgMsfXkW
X-Gm-Gg: AZuq6aKwkmQzGx3l6JS7E24iyQuVkAKo9OFZWlH7i9vICby7BM2ANa/FKWsASEYJsyq
	uLuHSVc+qGOgsxXIGuoInJy4cpWF4zTqDK8sQLyUMctzeTar5rzWngUEk8UkvxOD5xboW/c55ij
	4+QOjEfrpuM+kcQD12vQuaENnBudBhRa3C02szTcXhmNHzSc0KSZw16/USaPiR2M8wSDj0C64I/
	tCPeQmMS6c7EBMEPy7GnU8aS5cB63LIJmsep3pfl5Edbj9EiI/uWWhJwSrG+fgLsDa0EAs=
X-Received: by 2002:ac8:5a48:0:b0:501:4d61:f02b with SMTP id
 d75a77b69052e-502a1f33411mr211159971cf.59.1769001931639; Wed, 21 Jan 2026
 05:25:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121131954.2710459-1-p@1g4.org> <20260121131954.2710459-2-p@1g4.org>
In-Reply-To: <20260121131954.2710459-2-p@1g4.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Jan 2026 14:25:20 +0100
X-Gm-Features: AZwV_Qh5xzzuPHPucGa6c8FsRbqoTm1le321JrFwUbW4p5vrfGzEM-uvOYLyB8E
Message-ID: <CANn89i+8_ZDxVGwQmo_44iCRs5Wexwxy1Wfhw4WmYg3qA7_t1A@mail.gmail.com>
Subject: Re: [PATCH net v3 1/7] net/sched: act_gate: zero-initialize netlink
 dump struct
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210758-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2CED65801D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 2:20=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
>
> Zero-initialize the dump struct before selective assignment to avoid
> leaking stack padding in netlink replies. This matches other actions
> (e.g. act_connmark) that zero-init their dump structs.
>
> Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>
> ---

I do not see a bug to fix, current code is fine.

act_connmark problem was that "struct tc_connmark" had a 16bit hole.

No such issue for struct tc_gate.

