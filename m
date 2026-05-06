Return-Path: <stable+bounces-244359-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qANuE1oO+2mbVQMAu9opvQ
	(envelope-from <stable+bounces-244359-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 11:48:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1300D4D8E32
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 11:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD2413008C34
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 09:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7233DAC13;
	Wed,  6 May 2026 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="EDY026vY"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87263D093C
	for <stable@vger.kernel.org>; Wed,  6 May 2026 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060885; cv=pass; b=D5HFEmsqkGukPYU025319YKGdpoagF3aS4iBcvVu5K4O50eWtjIwIws44fahnqR8nO5LR/xQoopgs8sXFs3UIRYN6Yr+/uYWLZgSZi41nm/0oQbb2uiKIL6vUOX64sWUra6CHNkCUkg5F367V5VxWILJDZeDESPQ0ts6E0vaJ0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060885; c=relaxed/simple;
	bh=yuVmWGMWhN3ZNWUjk6uvrYwBImF5e0LOXhUj/6CqfC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=b461T7sVcYZ1A4wZZM8OYgMFslvUkJJeor4dgxTb7dGy/zdvsyKS5+eaiHWguob4gmhOhyR88rKZaUe627zvQVLXby8kWaJKYtsAYE0u/G5AgwC0t7cPuDjBShYeNYuVv/mIaoRV3RUjG3GWZWAxkqKSX/rSTc6vfoi4sQ6vcq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=EDY026vY; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f3c623322bso3892238eec.0
        for <stable@vger.kernel.org>; Wed, 06 May 2026 02:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778060883; cv=none;
        d=google.com; s=arc-20240605;
        b=fzYOAdNrEqCLTrhZiBZOjYTqwCC3yklqWvp6LttzWfh0szZW2tao0iTYBgS7mmRgi7
         gIKPMvj+PafzbHVFxdOMC69qzNiCoSgBUdU2PfsweMUrgB7H7a7akc9/qYasqyp3ARSr
         U6OlesOLtHhbbnI+OtDoEN+UpE3rA0Z1bYH8/IVIsoRBFT/WiInahkzGhwdtOZEx/nZv
         FUGm32DkBGzLw0DOV3wzYnm+QoUYV4O2R5TDem9906wf0S7nxK2WybIQ1PMYIRlYoy8+
         8tZtZ24J4R3wNLbxR/dQm/J2xd4HxWbVLDR6SLLmDKGIP/uHVeFvNpyh30ROePoFnLpm
         LKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ygCZSnbBwDX3CST5NT0ABYrZxpQum0y60fD/0E3MDrI=;
        fh=DjD5YDT9Ups80R9cWa6IwOdWNLMl0EdG/ngUZ9xvFag=;
        b=B9weBMXsgaRFVsBnp+FYabE1Ne98pMBSkABtB6jIPl493gRha1knzM+vSfNL7ZxGdP
         8Yl0Kqyx6QdMXXHvzx0AydTDr0rECtWrnOWSX0ox9pprTMAWosCn9aBfMSFYryRqrXSk
         QB6xiOVpQpt7LoHS3c1WJtuSWXECZc2eWTBW3Lh7FLUsrShflmGNoKGL99RKbmszI7h9
         Si18Ja7jXrA2ubkaH2bi5kJOR9ZszklwCeQ2GTy3Grsk9/lQZKS6vsZHKWYvb56tGNR9
         kLTNL96niNReV4yrY1TlUdQd9HCwd8Vp5n1ttb1we/qXsMlv1XMoqAcquYpHnhOAjBZR
         vH1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1778060883; x=1778665683; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygCZSnbBwDX3CST5NT0ABYrZxpQum0y60fD/0E3MDrI=;
        b=EDY026vYwuZL3EBBTYJdT11NPIBB+FJQuuwx9MG/5SGLUZ77fAIbP92Cx/PSjtbVGq
         vVNOXnfBfP0QTfWu01VKu82SzLhA5vka0j+o1bKx940NcW/yJQRfU2h09AdatElEF7aL
         I3sTGZjy/RiCaC+XEoqufcNOD1PziitpQBbOsqUrS124UePkw/1Ak3mbhKp8rGWcR00n
         Oz+haEQxrByg3soY6KTdXayF5y1PtLlRU5EbHb6by7fgKTHhT0jYSIQlO3Rn/bP6kQs2
         4RL7izTvRO4GSe7d6MSFcfmq0JY1rd+qUYNbacwdmQ+cs9whBsamkYDWIpxi4KcodAkG
         1m+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778060883; x=1778665683;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ygCZSnbBwDX3CST5NT0ABYrZxpQum0y60fD/0E3MDrI=;
        b=CrSdb/MFTO1zqrAM7T9qh0NTpmSFu+YL42qyE7DwubxEAHZAVpoaDzYN65Zn7iSpwh
         7FqaAZ+tTxpyvAfYTzcjyLA3plsbDClCBlekeqlQAi0v10RA2HaepFefvo7kCX7rgHRl
         E3E9eZbapaaQ9J6GIJfsT/m8Shne8xZEhWAHnH+lcct4t4LmmQDfwgA1U+MNoAJVGJ1A
         Otjtk9VxDyZzx0zoSUaXc8gltPLiXDNNSarFx/mmDEsXokIvY+LcxJRbm9LH9UJXHu39
         GjyzQ+uJkCVQf7mhFxTmu+yuUnnuFxHHFAhU3Fi6XYUgJz1W1mAKMboCE8s1QuYwlFnv
         d3Fw==
X-Forwarded-Encrypted: i=1; AFNElJ9E+jV5shTzc7/G4utaF/ii6V+wsax7c7kwFKzab/bt4llI3HPjvelOm1N68DWASYr6szyBvGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc1zjEk/DAhtF05H8NDSM3pCOVAKtyawOfUF/dYz0aGoJFL5DU
	Yg1Q+/AfRjc9lqNrXU75yS28ROJi7ekEnPjvUG6HbuxtIaaVCm+pls/FrrJbM8HzLmIgeAkpREe
	CKN8x8vFq7wsDUKv37S1BurWBu17I9UD+Ct7TZrJONQ==
X-Gm-Gg: AeBDiesGQViCv1NTnZnH9ygShWoEZjaNrzA3kzRtRCKt8oCKPLjbZ1MMP1mbUnbGbOt
	xffGmUz9r6hlyODnvTQPkv2fniD0weiIpA5lbsoCKiNZpJNRATBdM17bnIr0YBiNAqIcMfrkE+G
	2KjGvNUCUgGzEuhBKWw4lHozG+Pt9kk9JbyFB1iJUDl56mJa28J2VQ0rpDna1wmF1FXvEJlDESm
	PV1m5+YaltcuKUSxUkQ6Dt5x3E298rGIo8L5JRNsW3ibs58uJN2wwGKFDRudfWTN/P8Kqeb7b43
	QFtr0UwaNCVyKYkLpW4=
X-Received: by 2002:a05:7300:dc92:b0:2f5:301f:64b4 with SMTP id
 5a478bee46e88-2f54b362e6bmr1463290eec.12.1778060882926; Wed, 06 May 2026
 02:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177771348699.1898023.16904466444228860838@eldamar.lan>
 <177768508393.32886.13183514325428485879.reportbug@pjp3.podorski.net>
 <CAL3Ev5070_=K9F9+03GrE2+4tgr=j_CO19=m4ZPTd17YSwmokQ@mail.gmail.com> <afsMUZa99G_gsve1@eldamar.lan>
In-Reply-To: <afsMUZa99G_gsve1@eldamar.lan>
From: Jiayuan Chen <jiayuan.chen@shopee.com>
Date: Wed, 6 May 2026 17:47:52 +0800
X-Gm-Features: AVHnY4JRr4dMAOCRYrbHzgHiTFh9CHKATaGLdQcQmiR2HXRECFWVHXqMtcFo5uE
Message-ID: <CAL3Ev50kzBn41s2twKjKAv=98sPHwPVCp5nmgmA8XGJA3FdVmg@mail.gmail.com>
Subject: Re: Bug#1135514: [6.1.y regresssion] 9a95ec9144ee ("xfrm: fix
 ip_rt_bug race in icmp_route_lookup reverse path") causes log spam on ping to
 unreachable host
To: Jiayuan Chen <jiayuan.chen@shopee.com>, 1135514@bugs.debian.org, 
	Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>, regressions@lists.linux.dev, 
	stable@vger.kernel.org, podorski <podorski@gmail.com>, 
	Brad Barnett <debian-bugs5@l8r.net>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1300D4D8E32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[shopee.com,reject];
	R_DKIM_ALLOW(-0.20)[shopee.com:s=shopee.com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[shopee.com,bugs.debian.org,redhat.com,kernel.org,lists.linux.dev,vger.kernel.org,gmail.com,l8r.net,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244359-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@shopee.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[shopee.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]

On Wed, May 6, 2026 at 5:39=E2=80=AFPM Salvatore Bonaccorso <carnil@debian.=
org> wrote:
>
> Hi Jiayuan,
>
> On Wed, May 06, 2026 at 09:04:24AM +0800, Jiayuan Chen wrote:
> > I think it because we failed to backport  this patch before:
> > https://lore.kernel.org/stable/20250207161555-b1a8749027831a1a@stable.k=
ernel.org/T/#m0c880c1f04f7211aea9b7f6b4de0b64aa1726417
>
> Which won't apply cleanly, I assume this was the reason it got not
> backported to 6.1.y. Do you have a backport of that, or should the
> original commit introducing the issue be reverted from 6.1.y?
>
> Regards,
> Salvtore

I tried to backport this patch to stable. Hope these patches apply successf=
ully.

https://lore.kernel.org/stable/20260506012057.285743-1-jiayuan.chen@linux.d=
ev/T/#u
https://lore.kernel.org/stable/20260506012115.286204-1-jiayuan.chen@linux.d=
ev/T/#u

