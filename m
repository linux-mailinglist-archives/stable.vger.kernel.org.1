Return-Path: <stable+bounces-241458-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMs1GjkJ8GkINgEAu9opvQ
	(envelope-from <stable+bounces-241458-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 03:11:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC7F47C529
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 03:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64F63303799E
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 01:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F0D238D54;
	Tue, 28 Apr 2026 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qze7hzzu"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D65B1DE8AD
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777338578; cv=pass; b=mxaV2DyzGSHNYJAG6tB+zx+Fnf8/IK43slatOuENmZpxFRSGljVQtCSceNEYUnEJiXx8QleJwaPld04IH6nyCZktSTuXi2FGtwHUtzGIvyU8z8QXiWvtZmyt+iFcPHBquTz24Mx2TMLDW7DnpUHEM2MTJ0SZLkWEMWLvnPwLceA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777338578; c=relaxed/simple;
	bh=3sch0kI27Iw1ioDljaUdwhBKgz3IvHr+k8dBz6JKPj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIwMEqZg5Uv6QdI7SiR4uidciGTLBxyaPoZFgiTjT8s0d/emhOuusdH+z22tKXwlSjMl1kUR69SVJCtGo7Q9mjrtEs27F+T3UXTJ8D55xEd+7U9FHwoQcPM8tJ6GsSTcG6/tX1UhqHVVy0tNqkFjvyDTEm6HNoykigt/BOEHL2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qze7hzzu; arc=pass smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-89fc349b5ceso157327176d6.3
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 18:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777338576; cv=none;
        d=google.com; s=arc-20240605;
        b=djTXIHS6cb8zEgvaLUIzqe8d7/97C9RyGo3ZC1HGklFdhkA/UqZHgmFeVRyQzvnaEX
         jkK50Nnd+fG86sHun/qNnTulcKNOLgKuVKYCCkePuuD9n7k1ccpQv734DnjAdwAC7za0
         Dy5V38lQn/ANjF19bEa1jCm4EWHvjkoEfRTuP7w+2JxYCb3RwBh9vA3f3J7b9rWjPsE7
         LkHBDeRGFF8l/fGK1kQT+ImwvObSbvxWs5wyjrJchGR6fp/Ti3lkh28tIJUOSkCqWzmB
         qBceiUjHNaK0vo6dfPNnwCHgnqzUoppZc8ixyWncyZp96uJhxqmADrfhJTCSqDVNJaKO
         CfqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3sch0kI27Iw1ioDljaUdwhBKgz3IvHr+k8dBz6JKPj8=;
        fh=l/ndcPi+0KBA1ixHSyO8araAumitIVFpab+ezipDR8s=;
        b=iCO+DXIgDtZv8jjZdtVYDNBbnSOrtkM41FB9IG1Cza74hDQGMjABeVaygQ9v5eiDqL
         17YkuUZyBn8Yw0ttiqXxW7uOTmr9ke/NqfO6BfWuJ09WFUBFcZujGt3ScmLfUUqdRRZp
         941S8QedJFUsuLKbK92RqpIsQ2u+R3sS/Exf4yVXAlzWVduSbdsGu66EVu9i1xhr0HJJ
         q63HZMvTg9ZyMlKME30rRmnk+o4ehRXHky3VRHU7a4Me8fYRHyuf3OaO1w3blenk4W71
         0e1nYdx/CDI9TjSERhddoZv2/d+hzqlJE6dFHaRZiUxwNUhYs5PLE9ZSfgdismtD/aBS
         5ykQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777338576; x=1777943376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sch0kI27Iw1ioDljaUdwhBKgz3IvHr+k8dBz6JKPj8=;
        b=Qze7hzzu3b3wV4C2iBMNQn3N1zJh818nFnk2Mx2e/vip3YQTT9jhSDpHR9CSF/1kbV
         6OJlTcaFn/z438DStQ7/p1It24IOZRjJ3V3R5moZctczwWsxb/QQvyF6+zuP2ZuYQRzr
         Sunx5v0kC363iMwkUMs3RQu9IjE2mZ65wpzavYzzyBWAG7xjp/dAY3xlNpmuaPd42vUe
         e2ewEG9aUpCOw7w1zkxmvRe+kiFvwXVd7+G7ZGJfVRae0hOK/P86Fr35/qTxNrnFAY4B
         NtiNzpkPkIyuT8fzOvXBXVrfecgoA8DksrSX53ILHKKxzbRzoAqo1EsZZiZqG8F3hdoo
         UBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777338576; x=1777943376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3sch0kI27Iw1ioDljaUdwhBKgz3IvHr+k8dBz6JKPj8=;
        b=svwzfEpPG/nteKiOJT4noLE7nTnvOSWgYgWhxo9MZgLIDdGoIg4jAGo7w3UqT1ZVyv
         x7mnQBgWK+XiZiMK3ixeBMdAgFl/qVDeGy1CupUo/b6YI25EamCWDtu9HkxOvQ36QMUo
         8kUxKRolvDXSHOoBsUGwBU3gG49pFZmI+qWSjh9Qgw/MV4alw8IxNulJr2O6CKVphd7P
         Lafqyjqz95tKJxOBjaR8G9A9s6lHyc6RziGJhJObBB/ZP2FxCHsVycYZWg+69JrkMJ0p
         Tl/92YI/vrXj9AcTArjmNyjQk9xuq+WpG0SKoUoYrYLksacopYU7gY+pEyfwp91K1iDI
         gUNQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qAsOzuvHthE4pKCvOPZNJaunCa3hucDDC1P+va4LRIh00jyePmEZ5XPXXtsZq/f6r7SPqhcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLhljOLg2PFg0e76CKdRpZ5w+123a5ew10Cm/ovIxVNtvDxrtS
	VeLxcUOLCUvDs/QksDFmrKJUHv02T7SkuxCR6vD/G7WX41o3MKjLApx88RuQnICSZJu9I6hC2an
	TL+FCbibfbdO0nBimNeVpkGrmhereg18=
X-Gm-Gg: AeBDiev0qsvA6+Ma7lgnX7Dir2H0IOoXOAd/+C28sxMWWk1qfdUiLdX5Tg1Uk48RheI
	j7Cp55KVmMAmQVJVHulSBnJ00vz0O2IBjiIGp7RQ2RsteAbPIvZN7HQKzk+lv3WdPZ6vUEremgu
	S0d4t5czNSdRJryyVhOR9UYCVxDajH0ZL3waKoPmrCxlKZYqo5XFPXZL+uVXPcV2iEa1/0yK6/y
	7iNFDFoidl3+flQL2PaanngXmEfb9jL57KxK4/hHq3y456palm3rhrvs3mXZ+w/55A5ETGrViwo
	HsstDqhfaiTW1nz8O9dIwrzLT2hpau0lUww0x5R4coz3HoZDU5QvcJf5ir4gg0CPtw3PF7lRJh8
	WjI4=
X-Received: by 2002:a05:6214:5b86:b0:8b0:2b9e:9639 with SMTP id
 6a1803df08f44-8b3e305cf7dmr19913666d6.19.1777338576269; Mon, 27 Apr 2026
 18:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425041816.19070-1-enelsonmoore@gmail.com> <20260427165959.3a294f1a@kernel.org>
In-Reply-To: <20260427165959.3a294f1a@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 27 Apr 2026 18:09:24 -0700
X-Gm-Features: AVHnY4IOutGXbWP85VlfW8A-jXZcwYkaD-ufKnvdMGHabQzeiYY6WGgL79Y-ak0
Message-ID: <CADkSEUjrFBLFQEHBaKaGe3SxdT95GFQ8hCbgNaF7ZgVVB6txLg@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: rnpgbe: mark nonfunctional incomplete
 driver as BROKEN
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Yibo Dong <dong100@mucse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	MD Danish Anwar <danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0DC7F47C529
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241458-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi, Jakub,

On Mon, Apr 27, 2026 at 5:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> We can keep the vendor as is, this doesn't enable any code compilation

I disabled it because otherwise an option for Mucse devices which
cannot be opened appears in menuconfig, which is confusing.

Ethan

