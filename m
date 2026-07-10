Return-Path: <stable+bounces-273187-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WEkBHHPLUGrX5AIAu9opvQ
	(envelope-from <stable+bounces-273187-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 12:37:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D28AA739C52
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 12:37:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Wnt3ZsV0;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273187-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273187-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00CDB301D32C
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 10:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FB7407CD8;
	Fri, 10 Jul 2026 10:37:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C19040B367
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 10:37:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679853; cv=pass; b=n6ShdJ6us+68T9ZRmz3TwDacwNkj0m1/eHZxN5yTOq7scJtPrpkieVxpbW0MygoF1TnuR+fp9wGp40UmAS4++qJYwFujDGtohYYdNYLRhhIuRzlqXeKC1pViDAb/g5vyg7sW2KXdDUiRrvJQtFPhxcf1aXT+Q7LJD2VW/uYTL80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679853; c=relaxed/simple;
	bh=0JCCK/TG0jvCYWzkXuH2FOsoNpOIN0Oi1w32Ig5m1gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pUBtueeYFk6Muixe/aYQSfrUCz5hyl2JNGoiVXwoPUaQEkjS4YQ0lgRhlbtW9KVOcXlQmP++3vo31xwUtAxBE/kcG4praEQJ+rYWYAKbhMVfty2todIMxIRaI4iHCNiKlFPm5xsOoPaj+IeM2YNUKX1lcnbRrT3zJg0ijO5dL3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wnt3ZsV0; arc=pass smtp.client-ip=209.85.128.177
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81e771226b0so11302417b3.2
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 03:37:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783679850; cv=none;
        d=google.com; s=arc-20260327;
        b=HFJDEhiKq+N/+taCen4xVPsDeK+7HQLDxuGrvH4DWMQifIw4Ag2PjEIURPksDyQkFG
         qh0w+kkFRXhCf6zxgUFDZt3MZbk89s3j6QfAL0r1IvGWTz92SezvJkif1k7GsfBU12ZZ
         9owAQ1pq/FfJ9h9QJADipMm1Ji80aGVshV2WcY95XP72WLHHlrxllJe/Df6maXIlNWlF
         8eGcPW4QveiUAoO3BMu8TJ5GJoXfGWbnjWREedvIZynR3l7xU47jdD8cfxNBHu/q/gmo
         kFitUOQnPAwXa/yB2xS+TxACcBAEhiMeCiSy/dm6DXstZubzTsk1YyqMUpGCP36UzmEC
         r5hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0JCCK/TG0jvCYWzkXuH2FOsoNpOIN0Oi1w32Ig5m1gU=;
        fh=RGs3bzzWTcmgd9o5cSnTZ0l+vx77LbQ9p/uPb9Uqoqc=;
        b=lJm0RmW0g79k0mxHonRZUBd+zQzs3R5bZ4Pa3vta5wMMldvb7H7ghDUuuqeFDeKdgl
         cNwjogK30nknnrhJ0fCmI94/eqEhsph9i2/9YxVuKTw0DuQ+7grdcI+HYNcyY3g2PUTt
         SqPm1xtuBJqSzdKJdFvTjGAQXj8vOplkTAnHYuCvbkDQ3eZT+7xIY/0nxPiJaQGewJfr
         ILYIuowZrITfbYJJkSzN/bton0pqxgYv6C5cYTxLRJdQNKMdcNxmd1e5Xfp7EopOS3iv
         23Epo2X6ueKoHAR3mjmxnBvmpopTiH0+vG+RMQK/wmHPdN/vBD/d2XmWErodyGH2osQ5
         aOTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783679850; x=1784284650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0JCCK/TG0jvCYWzkXuH2FOsoNpOIN0Oi1w32Ig5m1gU=;
        b=Wnt3ZsV0k0q/s96jYmc5AYt/Es1Q4i+EAM1TnM3T+cFftI3HMb25mIt9+Kzfyebv9p
         OuFKzFSJBy/oinJ+b/sw9EHVcPoWCtIgjXoRDlaUA0sCxxVJGGELTV5QE3tA9Hl2fD/0
         c1swxRsQQQsP0DTkHSJQ/eFt/pN2iCPVeSuwmfXIN83NmIjHmgeCmGjNgsOOQhs9ykOG
         l4Lc4O9lPA60EZlmg1gbr60Ub1vk2rN0//hiDl3ql9MpczaHBGhSRt+aFAcrejoRx++R
         4NMyl10gl+XJM+/swfb9GCmKRgMalfqlI31RKNm0T4BQI1+QKrryg9eLW5wuM4qM3v9H
         9y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783679850; x=1784284650;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0JCCK/TG0jvCYWzkXuH2FOsoNpOIN0Oi1w32Ig5m1gU=;
        b=azsb6Q6hnz+dBQVvsHblx1ILtMEJfngQknBsZ3A+pLHG+06ptMYyxBujcJCAoP7z8G
         jNSI2BY7Kat3OA6r85hnwMxoWPnNfGCh0aEhcgTbSPHR83VqDvFeR8LAF+5vkNV0AH2B
         AH/4vtOeXtDsAp1YiOiDYnS6GD6pe7mE3FxHxXNxuA84fZc8liKIM1ZAO+z6JxgWc1Ob
         9KGwghl6sY4KYg5C4Fkj+Zp1XWWLWah2nlQYQLiO3pe5JcSdnH71mggAdC+AP33m5CO6
         rl/DvgxxGHF7xCdYQqy0ug32M4F4SwFLWIcVBj2AE6CdKmk878rkAWXVEa6hEIPfjO/E
         /XhA==
X-Forwarded-Encrypted: i=1; AHgh+RoD8gVd9paDLJzg2r2Lj/r320hn9LYNnXuV7S0rG8mEaMuxcFxxhkcKRx1e1Ey5m26acFQmg9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4IeitksSaqAcFFV5h2YS8GhwqebzmRj/NZ74GA4iMcdU4F9rc
	GDKyhbMaqp1iahpJcBRwJnud1+/BPs5b4UcXq+qHnvyq84Gc/RCZVsoZBOSBlp7fBsUDZJrCNH2
	FDb/jzy8DxetNy1QmrdzpljbO7cENLWw=
X-Gm-Gg: AfdE7cl+wyJzLyPKPUoan8sazRlvX+Z79MLmA7Nqt557Jqa6dV+atjZhcqiHEQwe3Th
	3f2ryTuu+lThsd7OYs878wPrbhM0LrWrJP3cezIVwF8hxNt/itwRwFlj8R2GlJoGi55MzxH8Gui
	pzVsg5h4Ro9vg/vHIYgJ3xbnQcXzRVmGQXwpjbYeksbKmLvprDfR5vYG3BL4If6gyAgJ+uada1T
	xTZr6v6z/HOxpknr43S+pxZu0LZ2DdJOaTDy4txc0KjUkN7vYPieUrw1RHfVTUUwP0o8T6j5yKz
	ZEQNjwuGavH5V7w0TA66CJdPXg==
X-Received: by 2002:a05:690c:e0a:b0:80c:85b6:75b9 with SMTP id
 00721157ae682-81dbf56ec3dmr90488607b3.66.1783679849851; Fri, 10 Jul 2026
 03:37:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710023036.3745254-1-michael.bommarito@gmail.com> <alBcDlPeV8IPEngL@debian>
In-Reply-To: <alBcDlPeV8IPEngL@debian>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Fri, 10 Jul 2026 06:37:17 -0400
X-Gm-Features: AUfX_mxE85m0PgKq6exSlea8kQElVFjkZ94OrrDgW-o3O-BKH0z00Einlr7_ibU
Message-ID: <CAJJ9bXyTZRNUzSy5Y10zbx+1LyLguobgGm7FdGPO0foSzunLpw@mail.gmail.com>
Subject: Re: [PATCH] erofs: cap LZMA stream pool size
To: Michael Bommarito <michael.bommarito@gmail.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273187-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linux.alibaba.com,google.com,huawei.com,vivo.com,lists.ozlabs.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D28AA739C52

On Thu, Jul 9, 2026 at 10:42=E2=80=AFPM Gao Xiang <xiang@kernel.org> wrote:
> like CONFIG_EROFS_FS_LZMA_MAX_STREAMS, since I assume there is
> the different setting between the embedded systems and servers.

That sounds like a much nicer solution.

Do you want to wait for any other feedback, or should I send a v2 with
that approach, and if so, what do you want for the default value?

Thanks,
Mike

