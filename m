Return-Path: <stable+bounces-219674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAX4CPctn2lXZQQAu9opvQ
	(envelope-from <stable+bounces-219674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 18:14:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F7719B553
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 18:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E74530F8E6C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EB33D7D8D;
	Wed, 25 Feb 2026 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="KsEX2Bzz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99BB3E8C5D
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039543; cv=pass; b=fbnsahkyxrTQEpAH7mC+G4t0BqQ+r+vqCSnn8TMjHi2vQJSIudp7oSg6c5wtcVAtd/mwMDxMyvySiFbDJuv5f1WuN8gLdSeSbZ7iFTduBQdsySx8rDmBwjMBaomJDz/HnSZfpEEwosGICHtJ4t7qPTUe6ahZ2RBEO+vsZiuDlY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039543; c=relaxed/simple;
	bh=RlxeLXdmicJJqqSBt7535w6GmLiOvBVYNdBa7/H6kQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSaFlLEL5oGbhXgnn9MJ2mexOVG6TSUQBOIyorfP0PfJsbvWPLYUpoqQJ4Uwpz5/ofHajKc346Z3fcrtQAvzPAPPVkyVdPATy2U7PZftPwtOMwae38MR/aBHFInxNYNmoDRDmROn78NCF5QrOaMd0OdwJXSfrR65mCw3DvuL0tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=KsEX2Bzz; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b885e8c6727so214298566b.1
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 09:12:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772039540; cv=none;
        d=google.com; s=arc-20240605;
        b=SAcMYccXDmwwiY/orIYwVRhBy7Ok0qHO5xbjSvH86t5uNLVSDXiH13LoDio2TFeNK3
         BSIOEbJzk0vnqo0g0fQeby7eDlb0imB0oTGCXQ/2qUbdzK8/6c8mTqt4KyeQBRb/g6oE
         sHKx1VvgC+cJJb3O6BZeL3Z/6+lqXUNHI8nBBtHJ/Loz9YfYA2453YurGolvbqq19ybY
         ik8iJ9p3fpZTe8pSsowniEie78ChhjPxdfjqSUpKiCso+JJ3JmADWpzr9dEtCdoRqv+l
         NdbCUZv+KUuQU+gJR42EtSQlwfdg1OKvLVjJmTPnkWiO47OVvRJqurXcclA94Va863N7
         B1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8D0KlaQHiURMd3qMJO2dOqNEElEs7vHAzHYmLzebY7A=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=iRamRaHPNLzM+9V3On49GGIvBFPWSgJOf6dwHKhZ4PAelL7GwJ+CcL3pdr/69no8kD
         qKRMtXG5lR8bRaJm4INXLSEh4yGRnMN+Sj4w8rJj+pKl5WGxx7WP+gdl9M7+u65fieoA
         WAXjdOndSAWrLlssOqVf376K8wqU2/F9nNiBHrxXejNVyiZ3GG2hceqalHZoVWhg/43/
         hQiGM3cU13Ik4pyK8vtSkl8RAm6Jhb4oled41ARxWX8v8FK1J7Hxih11sx9xPrH7pzUk
         1ynDGFnwWY4KWFB2jgCPesFP4IHg6SbBjM8MDul57XkmqIqlxfa4jyKVOt3i+BdX3gBF
         d80g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1772039540; x=1772644340; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8D0KlaQHiURMd3qMJO2dOqNEElEs7vHAzHYmLzebY7A=;
        b=KsEX2BzzaPoOszgeEgoh15zSXd9UVgi8CG8cOQ5jptyCNRGdqOOnfJYVUPjk9HKzrQ
         5IgKLLIl2wlbfOe1jkg+yvgYQbOjF6/fxCGfZPwb5svxnxI0V28tixIqg2VaBCXpTlrO
         p8o4+hl8DotPHdgweqxI3twIYs4cT+2T3HlHVWB93iHA4Jt52wfjbtqcwxlSpfT9e889
         jjowOX12AmgM5YrQ1AQwuxP6vRHVS/WOhGX2vQ0q46QfRHImIDF+s3mqxYOnWETLaahO
         dY97TFHoPrMyT8T18Wh+32rSyrRbHuRGzrj32fOz+P5766addN7DMDdaK8VlQXk+lM8d
         aR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772039540; x=1772644340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8D0KlaQHiURMd3qMJO2dOqNEElEs7vHAzHYmLzebY7A=;
        b=QfVtZ5m52VUPWmppbcxKP2xl/oIXb6zTYxijmEFvWF59l5GHifsI3ClJyfWCSlSEpE
         XBFW+GJON/6cZoFhYrZNSFiDwJuCTrom51H4Sjv1+CG+hhnMjiJ0vHOeckWineTks5Gi
         egPfGpWf4Td/gJwao2bWBfwkyHrlTSQND2K6J2GEnhIv5/Rg1VRPNmcgtwQfxU/71t6n
         MedDe8fDpC7PL6ra1ohBbAuvk/O6kDkUSWeL12T6UqD43lFTVbNqkC6MQEmzodQ6UHsj
         Wy0UdzmcUz2W1bINLl1fTlBWRw+Ph2P7RWYv7wy+KqSE10kqdeLDjSWYmhIVQN5fLxm6
         SzMw==
X-Gm-Message-State: AOJu0YyFhLfVsuEuciWBUbklRSYaLV14VnpnrHR7mBq3hPMf86Alaupu
	BztXpCLKuz84eVNw3wAwNixNV8eqUj7o8SfRnWA6MVkRQ93aq+MGUB8TOKN+D///HpJNClk6V7e
	KmY0NQIZrbBSH3kpNo0Gzo7clV8nFR8jJjsWd7u+98w==
X-Gm-Gg: ATEYQzyyH36nYPtcORHbvYN1KCkLyQtaJ0H3+bkW0cLZyAAteO8c5VKUuPefaYc11Cj
	PqKJKtLQLBDQVV6G5ty/JcHlku52kEY0gNa3BJE9/RiBl35UUpmJiSuxRE6jtIMJTylLNQOc51k
	nbZCWe0Z1FhjQ5kPXjRh+1okMvaeEwUbrRZXYtO2vUyblcoRR2A6XmqcB8K9a9q2qCtyNdeeAUL
	bpPYldRroTibq/bniGZp3Fjpu8rEu2igHR2BE2GKW8zcDd3vI7VddaOkpMgcmXS59aM85VLyX+g
	n6hvYfOkyOLalzIP53rzA7jHhwcX8Ml+jz0nfjuHmLmY7gEdLxQ4ZEkkws/jYZ9F2+8xckY=
X-Received: by 2002:a17:907:86a2:b0:b8f:c684:db37 with SMTP id
 a640c23a62f3a-b933cb9cd35mr285540266b.9.1772039540109; Wed, 25 Feb 2026
 09:12:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225155341.094945851@linuxfoundation.org> <CAG=yYw=0DgvXdfhEzeBYguw72gHy5R0ZiTeLZ61iy6uixKe++A@mail.gmail.com>
In-Reply-To: <CAG=yYw=0DgvXdfhEzeBYguw72gHy5R0ZiTeLZ61iy6uixKe++A@mail.gmail.com>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 25 Feb 2026 22:41:43 +0530
X-Gm-Features: AaiRm510e6YQdvZJgaYW5-8K1wppbn25FfQOzC2C4iZ4Av-78QdAqwYgQG4Gp4A
Message-ID: <CAG=yYwmq3UZHr9wRRX=FNM5PVohZc-3f3MshxFAayJy5oKa9tA@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/781] 6.19.4-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[rajagiritech-edu-in.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219674-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,rajagiritech-edu-in.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 87F7719B553
X-Rspamd-Action: no action

please ignore my previous mail . very sorry

i did not test 6.19.y



-- 
software engineer
rajagiri school of engineering and technology

