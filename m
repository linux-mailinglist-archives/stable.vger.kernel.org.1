Return-Path: <stable+bounces-241063-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPhACtXm62nNSgAAu9opvQ
	(envelope-from <stable+bounces-241063-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:55:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D73B4639D3
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 975433022F77
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 21:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BD934A788;
	Fri, 24 Apr 2026 21:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwzicBAM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9150227FD74
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777067730; cv=pass; b=DrgVxJTR1sA0s0NZRFRLqa8+mYcw7KZ46NqPdOfy7cHY7RK74aQ7E34RWmJWB6p31ROPRiJTYFdHOPlMRYNQuXrp0zKcojHCSgubIZUwJcL0JNlHq+zDXARrgiKJXJPgmpm7lkH95Rd/Ecihle2TU/GQwb8OZmyKzZZGNOiVQfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777067730; c=relaxed/simple;
	bh=14hH6MJSJt1rLvJvDMs0E8Uap9zO0DF0fK1TJoEhudU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFg09npxyQfE5vJJ5QhiZzhgkQINIXt3Itxe8fjEnOvzcYzCuUaVsxxgOKxYumAjYrxEbVEk1GDe30mS24ejUXADTe8l9tAH+xGW3xjw1EZzacAhlJEX68ODReR4DulmMqYUgie+7QxVf+t9l2JQBYlFdY6IdsEDVAUjzVOlWa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwzicBAM; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c7973bbc16dso5446126a12.0
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777067729; cv=none;
        d=google.com; s=arc-20240605;
        b=JNUrRfcd2+1Hr8xxuzfDIaUlJfBHKL0L6YHAm2zvr7ZGrK9gIUIOtu/+79GrxXt5ZU
         eOKqzjubxkhZE9rO+ozXbnDFpoIwXnvOE3JDxG73uOGvxKffwcAOsQlza/hNT5HH4JyN
         mBik52ZcyyjLpnS1pC3R60r3sciBXitKdDIFZYjU1UU+7ngiseec3vQf65RN5Jn3B2qy
         S8yVIaIipJXCswq92vzyoBAMxpSdR8kPqtOYTH6ALtK/yxDoTQvyEbZdCGA07Wd6cxVa
         xVJLyz4F4QspU5DIU/OwJqlDWxtZYhy/3joeMwQFioq8hzTk3n/RT/J9zn2BGKxnutkq
         f/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wV3WwlEXBochrsy1CA45CmB9c2B1ZTUDcYL4AxMb+u8=;
        fh=dfYJyRJLaxbHt/Y/5fLYeAja/7amU5viP1xhaZZnL+Y=;
        b=ZjUrf6RlON0NYbH0tRmElhEJ0LB3lYgAeYKJD7HX1uP/emYR503zfKICi9cPF3cZPe
         m0MoZTvTnzKWNDQq/O1Ms+v+1uId0rsu2venBu/VHwiTbibCJqlf08FuzXv5l6HP9upu
         yKY5eYHdYsI73tS52TeZ3yl+kgzyesBCZSDPRWtiEBRSIt9fAbuSpk5jA2YImTY/NpEJ
         ckYdMxblXPjp8mERsjLkI8IRAgUkArL+ML1ySypkjfIe0Lu4DUAtsLFvZLIkerVOR7EF
         1zHGiAOwWGL+dUIAKCGI8f5zKHdkY5+OXPwjjjACUzlfNnp7fIP43ry0o878wG4dJIAP
         K/LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777067729; x=1777672529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV3WwlEXBochrsy1CA45CmB9c2B1ZTUDcYL4AxMb+u8=;
        b=cwzicBAMQVNCwA7QtfCjqGwftDxOo/+v/ni8RcVqh7x5gBEIb2990BswUfWE0ajYHR
         3ITW8NJy0Fl4YoV3i8oL5c+b3tVHrnA63bbmip2i0ijqRHLhDhXyC2eQzZHVFRo4qp3C
         i2SukwBDic0uDTFXdNH3qoVSUs9v33AEJLWXjUz4nZ+SAdD6fLANfpD0/A8hgKivr1tz
         s+JT5FibKLYO81Ud44z37nSOoO4fQL65urtVD+KzlMX/g2FnKM2ZaLD/XuVI7EYZxY1q
         t6BOLY0/4aU1V9owWl2gq0pqdYaMfDRA++bbwpdLbbg6EijLPNajh/vYwv9V94RQqT50
         JqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777067729; x=1777672529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wV3WwlEXBochrsy1CA45CmB9c2B1ZTUDcYL4AxMb+u8=;
        b=alSLcW3tZBJQTCT03434yrerHfVxGmD/bF5cbIS9IZ7SDx9nDnb+z9Sdwl1p0DYCMf
         xEWJSpB1BH+ZopbrL6csN5gVUlKFJEjofRjb9U71YfvFmBhMnV8ih5vDba+Qd0hrsy0r
         gtyI7wNYEnKtFZR/lbldg38trEyQhZ8pvXwce6vVF4UsvF+jmD5gW607rXWIMkkvA9B2
         u4Ior2ZKxKUndinlQ4o5GgU9iVuCdtSGg2ZHj0RUq2fVM6KbYl3n6a84+RFxZbeDgr8M
         FWg/BnsQu73J34ZZD6y9zK5cs0edZNMbRaqjMFr8Z2rcXNck7u5jQ3G36THZzmiv1K0+
         RJ/w==
X-Gm-Message-State: AOJu0YyXAfJ5W90mMZVA41ehPth9a3LXY0YdtCB0+X0MPC+EVALFOui+
	ATfzJ7l/+0G7kYBhGB9UjpKvlNjbt3a2vZy7tjSrN4/vIFV21vSDHLkK90zzfnkuSxJ3rWPaBoV
	va133vjQI7CM4cr2Rcvm6IJDnvM1OPHM=
X-Gm-Gg: AeBDiesCGSSSOd9Os3dEdkE1jX2+1lLyiHiYbzNCPcPEDWtZwsEZ9zZystM6M52Qbk3
	QBfoEMQ5YCxScxuLy+VDL8JWERtMy4UE4/kOELNsAcrpeaDUTeOynEZqsdORCxPSLK5/v58/4mx
	A76BJRcDeAzmqB7kF6AdVQeaZV7S2cNneiuAxyR+aHQrsuyYi0zO7q5Uw/oXTfAdqu2Y1rpb9WV
	eCbhlU2Ah3wFbRsrJkSwvV4bGoIkCH8oG2tY3icgtgg/Zga/uAJcZscSfZGG4f7AlBAAdOSC3Ok
	dnOIX0eYsScRNG50mA==
X-Received: by 2002:a05:6a20:3949:b0:39c:39d1:dbf4 with SMTP id
 adf61e73a8af0-3a08d8ff840mr35917229637.46.1777067728871; Fri, 24 Apr 2026
 14:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424211315.1072123-1-elaidya225@gmail.com>
In-Reply-To: <20260424211315.1072123-1-elaidya225@gmail.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Fri, 24 Apr 2026 14:55:15 -0700
X-Gm-Features: AQROBzDN_E_Xia8560eNxbzM6hD9BoLzIKdVdqtBw9a4JXpxaFyoIMTKdTXXxG4
Message-ID: <CANaxB-y=SD7V7dcBXuAqq8=p2R46SAr1uKZtMACynvk1=Cftqg@mail.gmail.com>
Subject: Re: [PATCH 6.18.y v1 0/9] mm: backport sticky VMA flags and
 soft-dirty fix
To: Ahmed Elaidy <elaidya225@gmail.com>
Cc: stable@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9D73B4639D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241063-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5]

On Fri, Apr 24, 2026 at 2:13=E2=80=AFPM Ahmed Elaidy <elaidya225@gmail.com>=
 wrote:
>
> This series backports the sticky VMA flags infrastructure and the
> VM_SOFTDIRTY-on-merge fix to linux-6.18.y.
>
> Motivation: CRIU incremental dump/restore can hit a missing-parent-pagema=
p
> failure when VM_SOFTDIRTY is lost during VMA merge operations.
>
> Patch 8 is the target fix:
>   mm: propagate VM_SOFTDIRTY on merge

Have you tried fixing only the VM_SOFTDIRTY propagation issue without porti=
ng
the entire series?

I think this fix will be small, reducing the chance of breaking something e=
lse.

Thanks,
Andrei

