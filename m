Return-Path: <stable+bounces-254457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LidFXVAFmpMjwcAu9opvQ
	(envelope-from <stable+bounces-254457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 02:53:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1325DE131
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 02:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C67BA3012C8A
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 00:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFFE2D9792;
	Wed, 27 May 2026 00:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LfUsYgbq"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DD929BDAA
	for <stable@vger.kernel.org>; Wed, 27 May 2026 00:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843186; cv=pass; b=UaEPmEQZ2kzGBSOMPrbKtLkDmM4ZCHNW4D9cRLyDh56RdL3fIvO2u8PEKfetVD5bR6tJo9VWKkUsx+5iK/tQ5dPCotAlNWTlL+KZCvpG5hPrBVnifuSYuCzamrUkgyd0D1hUF0lgR8l6QgIDHq5fQUcxD5zar+/2+HKXj+Xg+2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843186; c=relaxed/simple;
	bh=/esISb0a6/GGltUROVXYrwUEcLnOf315MU1CqmdWxFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzDubqCFsA9nIpkAltB2XTnqc5BIuE5HEHLEoEGwwjWr/u3ffnZAdNB05WZgePHPm4Z29R/IPAAUzL8slmttbmsgfImTIAqEQ+FXQXteGPz68Sn96htBwNtN9ckJu/twOcNxYLpuXzeBK7cXY27djJBljwShGr27Cp6HTjM+HNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LfUsYgbq; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30455f77e0eso838344eec.0
        for <stable@vger.kernel.org>; Tue, 26 May 2026 17:53:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779843184; cv=none;
        d=google.com; s=arc-20240605;
        b=ONSe01g8aRt7vHVIgCZ08T4X1wxWiUfSkLKyzjQccHb4zdn76PSqyPgveSahPIjhGj
         7ZXDAhOBckTPDv+ZyY7s1UkWs4nZ+8OojWXyDFzoYZVcS4JmHyJLtROEqzc/XqnhbD82
         /ISS/ykSNTDNdfwfZ0YsbSojh5h1oyTTyy8axjPmi6L4U2+eEfUPu8JsulX+g1QYykAO
         jyQcIWekQbBKcfPYeKPZyCAuYK/KkQk6MdWfkFa/E1tAXfCj7U+iDXeCPKM1VVzZnaoc
         Nm71uKTk4NORHqwkIZBKLYpFbMiSlF2GMOSjx9KasbROzZumgDaU7rR5sNti6P/esRUm
         k0yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bcbwfShk68TwXkrE3Y+HrrrNxmqrDdo7ws3A+Wa6dFM=;
        fh=h6eRGRY4E9lcG85QxE7DGu7WrgIXKsrJAMJOixagXuQ=;
        b=jARv8szSZTbhC5Gr4ophgBOKHULUVw19k1kjP1z7s2m0MmjmlsPymqOeIN7uLbAuft
         XWrEvu4TF5Q1Yv6CTYq8Avhom4XJrse9NeFGIY7A8Uwlk3+S94eDnlzBMz6N7/zd3v0c
         y++C2W4FHPVDwi0G+JFf6mzSebW6579LXgVNO1jTSXznETJ65BtgmOBl7MOwIItPh+8C
         9mAZAhRd08A3iEjJX4ToGMXK7O3sFvLfBLSs1WUnI1rVRxLaiU/kdGvyUYbiVL9VG+Bg
         4mSPj/meTwYZEWfI9MLXXhOCxLK4bcjgqHSq7y82IXNFBjFhVICBb7Xmr3BCcRfKDkSO
         WyHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779843184; x=1780447984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcbwfShk68TwXkrE3Y+HrrrNxmqrDdo7ws3A+Wa6dFM=;
        b=LfUsYgbqSeStyT25vpCuph2clvmjUXYxQjeOLTFZ6rsjssPRKZfM1mYNJrxCnM0X9t
         LkHs23yXjcgOwpwLuhldF34aoy8UJFXFh5gE8vwnkl9n6/za5XD6N9Gxy0CY3opm1+X6
         pUJRFuJSHhZEEKk0ZwwefCnUHUI0AvIEmWLL9V9QzkZMNhWEqOdyrQMbMEiZq9ZZJDf5
         +KW7vyox/csm1C/5G6BgBzE+bFtZNLs8k7JHaDSH5NuB0mrxTg7uNpyWzB/mMEiRVKlb
         Axn6S+S6VFIcmGZXLgP1XZyfDVsIZmfD0EbKMqSVw8VzNa+IvcLLa0XnEn2dJYxuhI+O
         FTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779843184; x=1780447984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bcbwfShk68TwXkrE3Y+HrrrNxmqrDdo7ws3A+Wa6dFM=;
        b=sN/C1ElnzTMWf+H3TS+FB9EkbWHWCoAr5esSR+KZj1HI54E08FFsfUOoElFTeezCYU
         lwsTytr1NNcsmkGiWrURc9MoREM+ocRlNbeca96XZMSvv41ahFpqIoo4qGfOvJnYTyfh
         jFKnnXZyVagi2ctZmRiNEQrIReLIrhb0I7WfU7l1+em7qCjDfMpjlFkPSa4tEhD73P68
         VSNp78nJBxSEEXzZyYUo9ublFyFFbLsW/jvSOF2t2nTvfuPPKs4b//RJVnSZarwN41ZD
         BoFCkr59AdfNGPm0xgKHdAwbFotY4ZFaJOvE8aEWSHtyKD+HImmh0Ei4oG8cC7CknjCN
         gCWA==
X-Gm-Message-State: AOJu0YxQAluAIRvoEUucnDmPJs1YmvMOg0nz8W0592qkqctMPLfW7tPk
	zqwGHwBNn+0yeFkRdLbjZ7Mzirm/UraWDkUQ5JD5PWGTN5nz+OyZcHV6YHJsWhMTMQQ4a0888qx
	vHt20zwYhxMwfMG9f2yuqTyE/F7kCUsn9s+MOdbvj
X-Gm-Gg: Acq92OEbqaPJBEoM9eKJnYPmufimlg1AAKW+bVpw6LzOtsHclnR4oxddZAxOksSPXbV
	y9dgeJWKI9bQUbH8B8Sj6goCBwDHkRhXTByrMjaTPBdiLQQEawZgMCv9TO3u1T+jk/TGroKx4Sa
	zEwBaEyNEUtjUB2NtbWqS6L5As4CqlyZeLT8nIW8ZnA6T9qf/VPhdB0vprzD27TUrbxFd2Ju/Bz
	zu3dYCpfiZFVne9RPChr/Onou1Pn7WEvLLFWIISxnOgV9+MKm4KgRaXgaLq7nwdWyXyYY8mMVhQ
	S05kfUyq27bf5j/WC1cQ0i5yq8DPvHjv2ZFXwgDkgo6g2FPkN0z7zhqA0G6h7GPf2QpcpUj8NVI
	LnUaw7LsAiYjLs4enE6/jWe7pjRFh2XU=
X-Received: by 2002:a05:7022:128a:b0:124:9dea:188d with SMTP id
 a92af1059eb24-1365fc6d615mr8591681c88.30.1779843183792; Tue, 26 May 2026
 17:53:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <48BADABE-4DFB-4DAD-8248-E94D8F5238D2@amazon.com>
 <CAAVpQUCfMsWBpPpywbwBLRCdHUqWqFBoDK=17dwDkG6T0dQxzw@mail.gmail.com>
 <A7A3F2FE-B18C-4F6D-A5E4-78164D6904F5@amazon.com> <CAAVpQUCKQQF=noqxQwD=dJvO3tuhPZxssDygyuVaZxTQGKiWfQ@mail.gmail.com>
 <9E49374E-D1D6-4D41-BFE0-03EE734DF9F2@amazon.com>
In-Reply-To: <9E49374E-D1D6-4D41-BFE0-03EE734DF9F2@amazon.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 26 May 2026 17:52:52 -0700
X-Gm-Features: AVHnY4K2vO29GyKK3bQJPNlMMEc6xFAH60H1WHHv66s_2zPps--4POJYlI_4jPk
Message-ID: <CAAVpQUBtKBzq36Wz9p3MaHR=G10-NFBtQXgGW3S3QV5THW2iCg@mail.gmail.com>
Subject: Re: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when
 closing sockets with pending send data
To: "Ahmed, Aaron" <aarnahmd@amazon.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ncardwell@google.com" <ncardwell@google.com>, 
	"edumazet@google.com" <edumazet@google.com>, aws-binance-tam <aws-binance-tam@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254457-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,readme.md:url]
X-Rspamd-Queue-Id: CC1325DE131
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Aaron,

On Tue, May 26, 2026 at 5:25=E2=80=AFPM Ahmed, Aaron <aarnahmd@amazon.com> =
wrote:
>
>   Hi Kuniyuki,
>
>   Just following up, were you able to try the reproducer I linked?

Sorry, I didn't have time to look into it.


>   Happy to help if there's anything else needed on my end.

Could you try reproducing the issue on the latest net-next.git
and/or the latest LTS tree 6.18.y ?

And if you can still repro, please update README.md accordingly
and upload your .config file since I don't have access to Amazon Linux :)

Thanks !

