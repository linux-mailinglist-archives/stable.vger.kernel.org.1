Return-Path: <stable+bounces-211363-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIcCGMVBc2mWtwAAu9opvQ
	(envelope-from <stable+bounces-211363-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 10:39:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB477380B
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 10:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE50A306199E
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 09:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0E235CB6C;
	Fri, 23 Jan 2026 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+xjEDWr"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB2B346A1F
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769160746; cv=pass; b=fgiJYDfErcuuE5ps4Vrj2SzH8+W05QYkm67N8OPEXVr3ItYWd85clAIhG+LV7ycT0mr/dJ2wwV/TzuHpTp6OvjB3SKdBOQNgwRZs0xMjoHgpfVBSIbuUZz1sTgdvsZcgRborWfNxdIkmqwIvQQHtUoWWyESiEEVE7ib5po1zSug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769160746; c=relaxed/simple;
	bh=o7c+Ej4jUrjidb9rcGMaXa9mTwKoEZebvld5syfwi6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LhtlajvRLsALbOZqZ+288emnYcbC0eJo+v5btnGN15b1RCO7s4v+DknE8id/6Dyzjt8OlGdVQCvEgm6KrV621GpuuEWKNHLUZypYsfIOWNEeMQDdXCnzH8EmaKWJsvCHUobfouYXuubtw0X1NHa7vCEBk6Eq/vw7iC5hOK4q7Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+xjEDWr; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-649166a96a9so2062113d50.3
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 01:32:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769160733; cv=none;
        d=google.com; s=arc-20240605;
        b=cYbJLwVmyAOVftC/jbfm+7GypNv2fvGqlM10xTTd1sacCbft/NzE3Lr2i6Zd3KFH5D
         xJETSXKwM0aGozO6sMiy5/WnHhSCi4KIBfGeiuQ1063mEDgJ+JoCUfgjcRD23rHRamJV
         /XgM3HWM2OEUDDM1v98RmH/+JPdwuObRTpODiiXiq8OPJlMQOz+psetioXqBV3h0h7xg
         Z2wY1tm2v+if0Twq/1SmOibdmm33ZC0yOrNst3Il0th/Ybr96lGRfMmeZdcc06rtNxNU
         lydiSRovSKJIXmIttolO6ts8MnctTeAbAd88fgluJr7S5/e4EFxIyzi6gg2+0wGKA32c
         YgqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o7c+Ej4jUrjidb9rcGMaXa9mTwKoEZebvld5syfwi6Q=;
        fh=D4Lvm6QVYjsGoENpkkzXqlC9iYTVaCt3LWahqMd1JkU=;
        b=QIQfzjibraxBKONX1Df025eikQHQvzpRVa63jWJzUGUxOnd8oDQJVHezwADQtMM+Kt
         29WRtaky45DDbB2PqCNLmJTbahNOAjPTmfg/yiKmjpVyhKep82LbvEyd5gPQOWXVioxT
         +wT/uEjbb8Yp1P0hj1Npiq7yjyzkMnWzA1zyaaHTB7jJ/zEUP4fs+7qYST11BS8ZrYh4
         Suku1zdlhBmuz830qSL5IjzhiPg3HgpPv9jAjPj6cj9txV2TCs2GIXX6TPJyt2viwKMm
         A37oo+xWPnH7Xt0VLfAME16BMnDCYlM830OqCJ2eqHd1a8ceMuBs+XNad0TpdJG90J0V
         bLaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769160733; x=1769765533; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7c+Ej4jUrjidb9rcGMaXa9mTwKoEZebvld5syfwi6Q=;
        b=i+xjEDWry7pQW1AbelPp/SH279YxtQWGLNkqnDXZa+z87eYqNVO3fNqXi6hbpAKSG3
         ozjl3fYyVzES18Xk3hJ5AfB60M8Tzoi5KtMxMXMFWWHcZ7Il8ZFTo8YQmWxGU5GM38hy
         eSKt81aMOqJ4/rAMB0PBlJCNvo1lU1c3S8PmGdEhbbnEywo/re7qRcAldmQkvilF54bj
         e8DeVIBXuBEYMflJ1+soob9Hfwd1/eWxgucuiuOrsWSpvgkZr58f8a/DZe7YVbX4MES8
         6BKa5H6rKguYEaqHLJGc8WyKREvHucem5drfX3fmrjeMf61VCQ0czequXo5C9NNxKIja
         9kMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769160733; x=1769765533;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o7c+Ej4jUrjidb9rcGMaXa9mTwKoEZebvld5syfwi6Q=;
        b=gbMvJoY9Z6zoBaJJT/9Bw5fcHGUE4+S0p5RdXZZ14uuOn6nW7nUuUY3PbS29R8vVcJ
         EM+G2wC4lp9Lboro54UU+VIGDHUiad6NxhARC+JO+gef0Uk1cfesZCklZDgD8uW+lpuQ
         vZPdS7oehLp/8nrpGtUWa+ZOeRg3BF/sQq9nPh5n+ArRXiFQaVAvA7Ve94AcbPbBYajT
         EjwTYZCZ3sBbbdgS0ZxWqtlpug6/HoYzBZ9LekyeQ6IMT65BgQIZGe9oh98zwY7P0uNv
         D7+XNOHG0uf1l4IKzFRRjcySm0K+kGpXRtjdAFFSLWGVo7TRrNNUIPHmJ112QZcg1Rdf
         hKAA==
X-Forwarded-Encrypted: i=1; AJvYcCVwnmKQe2QHMVLUcmcSY0WYFsAKaA2/HNXZfNjCnrTmzqcDkg8AYqdXOW6w7CTN4JMDIjaRk00=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQY2Y0CZoglutFfy5EPMGMmpUJPfb59E9FVWB2xfFqC1qgVEmq
	zZcXkZ8YwrV6puoydL8IUUgS/0u3ckck0XhhcSK3w0hgufSsfUi0vSrq0DVDLkEhF3D3mXESfyN
	YNnD0ydSUEuzYJLpED55uZRkEa7qLW1k=
X-Gm-Gg: AZuq6aIXmJdvk49V2UVy4rizSM3hESuleD03KLzHGf+RCXUkMSFZxcrae0nGUhIGkvx
	oDED9zvLp8vDQW0lK7oBV1dOMhESVFhryNHlRJNy+awgdJ+8/5kCqrEHg/tN3Zo6ckA8jXXshWR
	VG4QTR+0Vxlgbb9g8oaYsFhRqiUKw8b3qtcFvNN1oZWdRyLJYvgMrhjmXXAi3z8UVwIjYPaAhTl
	qaKqd0sbSfb6Jw6ZYzdsUqllaDslSKPEE1JtpIoMephP67J6N3GveHnaqSRfBeT3jZD2A==
X-Received: by 2002:a05:690e:bc8:b0:63c:f5a6:f2ef with SMTP id
 956f58d0204a3-6496125f47amr390019d50.65.1769160733420; Fri, 23 Jan 2026
 01:32:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABVCGTr75UNvZkOzeYobL70fo6NgATywwDmTf98J7cSFQTuq6A@mail.gmail.com>
In-Reply-To: <CABVCGTr75UNvZkOzeYobL70fo6NgATywwDmTf98J7cSFQTuq6A@mail.gmail.com>
From: =?UTF-8?Q?Juanan_Rodr=C3=ADguez?= <juananrodriguezg@gmail.com>
Date: Fri, 23 Jan 2026 09:32:02 +0000
X-Gm-Features: AZwV_QgbiLMBeK1VlRPgK9quCiLDl1HBB2ktcDQ4UeKESQu2e696adOwcejLSTo
Message-ID: <CABVCGTpVxfzjWBs1p3eS-t3+21sM5S5ysyfXVfCanK1C4QR6Wg@mail.gmail.com>
Subject: Fwd: No sound alienware a51 fresh linux install
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211363-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juananrodriguezg@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BAB477380B
X-Rspamd-Action: no action

---------- Forwarded message ---------
De: Juanan Rodr=C3=ADguez <juananrodriguezg@gmail.com>
Date: lun, 12 ene 2026 a las 17:51
Subject: No sound alienware a51 fresh linux install
To: <linux-kernel@vger.kernel.org>


Hi, I saw this commit fixing sound on alienware a51
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dv6.15.11&id=3D5add3f3954fd8224bdb4d58452d39560f385eea1

The thing is, I just instslled linux on an a51 18 laptop and there is no
sound, tried serveral distros based on ubuntu, fedora, arch with same
results, tried to purge pulseaudio, install pipewire an several fixes
and nothing.

Could you help me with this?

Thanks in advance, apologies for the unexpected message

