Return-Path: <stable+bounces-268587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RZyALn1EPWon0ggAu9opvQ
	(envelope-from <stable+bounces-268587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:08:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 170186C6F14
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:08:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fSv+Mrsa;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268587-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268587-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0961D3008A4A
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B77E39281F;
	Thu, 25 Jun 2026 15:08:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DEF2E7394
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 15:08:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400089; cv=pass; b=ozBM0FEf+CJLqKx3R73Q0fv1lmW2gUMLqlAbJmzHzPyTU+4fflryn4XDkI4UWyHPlRULw9s3wQqH79UMYU88tf56y3n7K2o/4tK3ZU2WlB+Ww3hVnqYFc3d3BFVt6SaGThH/PjFZUkZDwRKUn5oY544JNyYLSmtEXcdIvffkUOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400089; c=relaxed/simple;
	bh=MkO3fCXc1ZaOKiTnsnssleSvXkY2yN/+fGVR08qjueQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pbY18H0qhL6bMsYJe6qEwekSVBv1NKsTDzmO3SwBgvA/vINvS/Cs3tPUD2SAqt4lzYAtFTNL47UR5tXTZbDMPnnxtUEd9enQpNcLdGw9yh+H4mlESi0+uu64fCgLmWD5wpbToXwTDhvQd5y6QaTIP3uuAVKNlgfJnJHJkNI9w5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSv+Mrsa; arc=pass smtp.client-ip=209.85.218.46
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1214dc027cso71428066b.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 08:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782400087; cv=none;
        d=google.com; s=arc-20260327;
        b=OKpiB/BkUfW6wsRx0ckctFZk4tNU6dTG4I32pE1x1vyBgfA45MHU+swcM+wcZyM/Us
         b6IGct67dSgDsYD42xWnYdkYFPx8BcE5yFG9fHc++mhU1YVUsBgDRxqRShEUclt7xfvG
         nCByP6K+eas+f3rplFSR5rx2sqrL6amZQXkzRhWBsta+0bQt4ynzBCGOk0qpb1HTfFle
         4dibARqX68HM7ZvYxyExT121elJ26EvdA1CAJzWDRHEInSkf8QwMfoks6jeC0uGIvYj0
         iKZYA1sdj4D7Xgs89EjgTdj/iAJWfcRpmmFVhd6k71alLomYIzxaoYY/G+FcWkwaTOHj
         7R9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=MkO3fCXc1ZaOKiTnsnssleSvXkY2yN/+fGVR08qjueQ=;
        fh=AJ4wr+Vi7zKnuQ0MLruaL29ZfvBsaOkHYgXURjmQGRQ=;
        b=qCt3r9tgos1IskoJeyClU/jkY8dnuvIGCp0EI/iOpKGuGG5p1vo1xKmn0gt1VGK5z6
         oLwJHiqtbKwFJyRYu7L0QDm7ewhpAjpEywFPhUCnonB6n6VMhw3pMc35rYlhx+3B+GA5
         bXky1kzSgchT53neghC1eZo0uCVS/Hdo3TCaCIpJR9PmC7S1XqPr1U8LMsCovl8PysuM
         9M1x7RNQt/rgTigWLCP9i0GnYVOAHFdDX9NRhqhNRx45lL5NLFZW8svdv/ZXvIrDQQPy
         dtjGfImtjQKq30W64WZG8olCZIZQ2YYBvAq2aq4cu5kskeXDaxNi+s2Bah93SnHnDl4s
         8dRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782400087; x=1783004887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MkO3fCXc1ZaOKiTnsnssleSvXkY2yN/+fGVR08qjueQ=;
        b=fSv+MrsaWE7mMOXMXnZPNUDyQDVQ4Tz0enLSDwkuya+4W5n31sedpmamaKaqZN3drp
         sUVd3x4xxh9iegn8jxY49mMy1lRxI0owIqMTtYjP9jwscuaR4BzMrbXToBgfAmpscNKP
         z/dSBgYbmFIQofzkXSOSYguNsyQhR6lT0FYOOcYs/L8k7b/2fp6fYydymPZfzgHGU8tW
         mqrk4WmqodTr4Yc/Ab3AexbC5JRo/qFI7WO228bXeBJae+asrZBxA0TD7tVtX/lRhpjB
         hjC7B+HgZ7el7oNgCjJGSgRlZRSxwb0JCnJ31OOJI3Jq5GHKPRCIdq5FgV0PSc5YVYxe
         /vWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782400087; x=1783004887;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MkO3fCXc1ZaOKiTnsnssleSvXkY2yN/+fGVR08qjueQ=;
        b=FX7ziQeuYAQ+Pt6CbT1fuCx0RDO0JdWFMlqcZqkQJxtxAUoTzes550dbtKBDmLJVCv
         R6MCpZqFlXlLUOG2w/qACPXwb9seZnxRpC5311zl3MOHgdP/49oEDhnNCq/eCr8O78GE
         XgxO5RWUM165fgAtM0azlAs5f4rQeSgkNaANp7M+5iTShnwPTJFp4v/GOkFGJWnTl2+L
         ynXzUH2ousJVkz0VU4Ud8YtssI7dXJpA2XDnGcDafQbiYrMtpaLN2ZslQkePnmpzmyiB
         HcsX+4XSROumz/WM2lrvRVffBxj+JvnIK+KCxIV57tDjqEz9dv5h1usGkn3mL/J4I/8s
         vk9w==
X-Forwarded-Encrypted: i=1; AHgh+RqPfHEXybcZbWzyzPCzZ1bFrh5nHLHIJxOKdMBRfEVaCl1cvG0XIWk+c7dKNnEBjMtDnRfRow0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsFJk3P54LoaiU33SSJcUTEiwhqxSEjQvXikURfk58eXQ7J4YY
	CAFTsX2/Ameg8IholUGy0aJ0FSHpJ1RuvyQwC98p+t8IV4SAlC1GlNkKJyPW4tFyw5LuKOzA/72
	Y/IXLRlZ4ZqYOutE5mLFQ29nIoHuZX30=
X-Gm-Gg: AfdE7clv94d16CJesBt9JYKClYK+tpav46VUrm1f18rLk/MZa9sptmVyTjqWXV1IgVo
	uAiHGijqCJ6c7DHR7q1FtExxS8PJmIA95jXgbHL3rsDHxtoILM1JfXvcqaZsi/0+BZxz78GjgnR
	N4c/4CxqGInTAkpwzAJ7AwqxmMp7U1p0Wouo8oV3j33IyoWk9otmvYyqqgPFKz3OEcxPNu9eCwH
	5aRlmhO7MCU5CTsGPx9gZzzgkDCwYA6+sKUA4qyoA290XZDoqEV1BhEgya5FnkzzfxPeu5v
X-Received: by 2002:a17:907:8d8e:b0:c0c:2033:c078 with SMTP id
 a640c23a62f3a-c1205ef178dmr223399166b.26.1782400086250; Thu, 25 Jun 2026
 08:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: liem <liem16213@gmail.com>
Date: Thu, 25 Jun 2026 23:07:54 +0800
X-Gm-Features: AVVi8CdXewmKMx24Id0KrC4KlPydUzifiJZC1utFI6DQTmNGydZ-bYS7JAqj14c
Message-ID: <CABoz+=2PHMv0mqxPwHyR5rBOhT7xFxGVok69JoYhadQTuNnsdQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: imx: Fix slave registration error path and missing
 NULL check
To: liem <liem16213@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, Andi Shyti <andi.shyti@kernel.org>, Biwen Li <biwen.li@nxp.com>, 
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, stable@vger.kernel.org, 
	Wolfram Sang <wsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	FAKE_REPLY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:liem16213@gmail.com,m:Frank.Li@nxp.com,m:andi.shyti@kernel.org,m:biwen.li@nxp.com,m:festevam@gmail.com,m:imx@lists.linux.dev,m:kernel@pengutronix.de,m:linux-arm-kernel@lists.infradead.org,m:linux-i2c@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:o.rempel@pengutronix.de,m:s.hauer@pengutronix.de,m:stable@vger.kernel.org,m:wsa@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[liem16213@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268587-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liem16213@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[nxp.com,kernel.org,gmail.com,lists.linux.dev,pengutronix.de,lists.infradead.org,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 170186C6F14

Hi,Carlos!

Thank you for your review.

Q: Have you meet the issue on one real platform?
A: No,I just noticed the error while reading the code.

I think your idea which cancel the slave timer and wait it finished
after disabled IRQ is better.

I'll fix the issues and send a v2.Thank you again!

