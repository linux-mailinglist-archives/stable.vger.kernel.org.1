Return-Path: <stable+bounces-216292-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGnnE5ttj2mNQwEAu9opvQ
	(envelope-from <stable+bounces-216292-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 19:29:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F2E138F15
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 19:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 289D23032982
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 18:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720EF27F754;
	Fri, 13 Feb 2026 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBIDoGkr"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5D27C84B
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771007384; cv=none; b=ftoapkbY00swAJ2dLobtvyEzjfQZeVw1j+DupoxHs7EpUynb6L0YihWzTnpWaffohHVBoNZYXRHM09gCBd6GZYFeFAKDk1iBBA4GUvn71ZA8AvrNzp0fG5aniL1Jl/oC+rVA47LeYJFfB+Na4r+4wZIC2E7Vl1JRX6bzUcTku2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771007384; c=relaxed/simple;
	bh=W52K/wPAaq32CCmZNnr9ljKa7NSzbGiF+ZhsZRw7kBE=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=IAL2ZfivtzpASyMg/57LHpwVFxW8CFsHECJN2spJYLwejA7r6MxJtkYqnwdj0LcwJmf2eKV/8xviUIB/6YwdWBMfdf2UK9aS8lPzgvcooErtsnTisVEOE1pwrVNovNdeVn2OZMJZvPI0csoaZPdVSHdE2hb2cZfMlgKtW5l9aQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBIDoGkr; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-797ab169454so3431417b3.3
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 10:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771007382; x=1771612182; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W52K/wPAaq32CCmZNnr9ljKa7NSzbGiF+ZhsZRw7kBE=;
        b=EBIDoGkrolRpcD0z7gc4OcTf11Ge9x2561b4wR7VrQ2U4Rb29hCHvkfdYqbAfEtVFQ
         fcdf9Gd2unT9RaRuIykrM4OiqRkLqdKwaFA4GSIuscAblhbKmCSsbu4goqaJN1g0wIsC
         VaJkQQ+9GasBhJnZfuuddbgKIEYQUpBz2PjMxT5wmBUpESDYiofo5uV2V71owOYuVJ0d
         dy5P505cHrXaLTgyTYHSAG6l7RtfHqggXS0tGPvowRqbCB/6mOky1XwJNUrk9F7tx/KF
         seskiwQkUpqKDpOnG72xGHBsMvc5hz3dlLY1cbC5j1NiS1u1eyRIUmu5hDuPQwykvEHO
         2WkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771007382; x=1771612182;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W52K/wPAaq32CCmZNnr9ljKa7NSzbGiF+ZhsZRw7kBE=;
        b=LgEf9uM0ZdP1P7eD+IHW6tF8dCuSub1X95AjVQ6W+dguFuA1evUdyAcyR7g50gRQor
         rYOIBEGYUDAE6oLzaOf3HGOtqpMSS/fr4j+yMaXKvdR4Bh7c3Pk42qwbqH8JS0l0AQoq
         IMhp7nPwv9MQdD9k3eWjnpPFW23LDk3g1lUpzFS7udwSXsmHmpvMPezowKcp3mTs9WVc
         8xqk4HY9Pl/7PACkcb8fwIoR11ugCgWfLksUZQn5U4o9UND+8whi9W8wtmzasUudDd3q
         Q26HVv4tjxS/PiadLYRTbEt6Cz+YsPgNz9M3zElClwLz1NnMlIIPJTssAJfSH2OxgfFb
         FQXA==
X-Forwarded-Encrypted: i=1; AJvYcCW7kiCdnJ6PnHkMy79EvUKu9OgSMtUvDkdWLQbMTTcRQt/funhv6tXo1bLLt0QyN8C9BGCb/tI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2IBUx4HWxyrW8PLNk0b8aOv4T4iim0xcjTRLzlhtS9hCCZHSP
	ObloPfq3vOBDQO27rjou5iAJskBbqKxwkd7DhmnlBp6Mw0M0tMGvwDErDhCpKQ==
X-Gm-Gg: AZuq6aJ5+JWL+Hs5S+G+7rshKWYS+czl1t9vNPS67WEGReXZl0UWV60dW7BZsJIVz6r
	bDNVzAauC05O5TbyUxyB98SgOWaMIVxkwJ0yhsfGPk8ov0kUJ/EZZlT0w2lwCAZK/eytM1r/xQs
	Y+qSgKftHVW+ebVrIG66AxKygWvP1uRgN3efmqeoXze6nP5UVyCAEy4AR41Uz/xvyQgR/uwCxhm
	DexscRKl6P7srEKsn70Im9aIkMvsEopqu5gUXMRAPUVIUfo79E2ygOktXUfqiqkWpeIoiYd1gbD
	n/ceTQ2t+yCC9pYuxeLqbCAeUSyXrg4bRY9mkvtdcETduOxC2yDZfh/BtB5PRuqgOl0Hwru5l9g
	oMxzbAgUEsz61+zZJYOQJ8+L4adfkWpcrSrDXP2bwiWJKwVAnuJ71pMC+M3zJGF/oEGYGYUDXke
	ZaKOYFhuwtGgLiMQ7glOJiJ6tnOFdptG4KlAADYyGmfEalYrRSDFFD4ZA5JD22YRmGmamf
X-Received: by 2002:a05:690c:3583:b0:796:3a4f:68fd with SMTP id 00721157ae682-797ac5d4506mr2004217b3.41.1771007382208;
        Fri, 13 Feb 2026 10:29:42 -0800 (PST)
Received: from smtpclient.apple ([2600:1700:e60:2e00:28e7:e954:c7a3:adce])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c23d1edsm76138987b3.29.2026.02.13.10.29.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Feb 2026 10:29:41 -0800 (PST)
From: Shraddha Phadnis <shraddha.phadnis@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6.1.21\))
Subject: Re: [PATCH] usb: yurex: fix race in probe
Message-Id: <B1347B59-82B5-49F4-BF5D-9575CDCDDBCD@gmail.com>
Date: Fri, 13 Feb 2026 12:29:29 -0600
Cc: gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org,
 stable@vger.kernel.org
To: oneukum@suse.com
X-Mailer: Apple Mail (2.3731.700.6.1.21)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FAKE_REPLY(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216292-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shraddhaphadnis@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99F2E138F15
X-Rspamd-Action: no action

Reviewed-by: Shraddha Phadnis <shraddha.phadnis@gmail.com>

This makes sense. Initializing dev->bbu before submitting the interrupt =
URB closes the race where the completion handler
could set bbu and then have it overwritten by the probe path.

Moving the initialization earlier ensures any early interrupt sees a =
known state rather than losing valid data.

Agree with CC stable as this fixes a real data corruption case.=

