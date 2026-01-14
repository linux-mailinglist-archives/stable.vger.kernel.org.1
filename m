Return-Path: <stable+bounces-208319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E38D1C888
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 06:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F023316C1D8
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 04:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEA7239E9D;
	Wed, 14 Jan 2026 04:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ExYLN99T"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68323325706
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 04:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768366209; cv=none; b=ivLlU/xnVTpn8x8/9eydW8/lgQ+3PIGz4jvBW4NAB3nMG7B6Puv1Nk1C2RKYL8zU9FR6qzFPkeXPSQm8oaZfxfeB7X+T8zn4T3rmW2m8rUdpQlSvHYmyfDHaljSWIMsbbKmmisPcZXQOyRwn5/3p0rXRcdNpFzSu9+01X1uPU9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768366209; c=relaxed/simple;
	bh=V/1j1ORswZY1aYqvHaFsO7Zm0k8k1k1lTRx3lDBeRXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3kjhimVI9/6O8npjofg6XlNEotBFGjcKHuPbThDZEaH72nnfmn+V+JgkpJ9sdbKtanlSzNVZF95Tn1PVxmFhlTXCYB3nyFkieQCh+ZlCrZWmigH4qkJ1w0hV1V41HuU2HeoWaC3burD8sgwe26zJHd4cZPPUnlObr7d9x5cHro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ExYLN99T; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81f3fcdb556so1921667b3a.2
        for <stable@vger.kernel.org>; Tue, 13 Jan 2026 20:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768366182; x=1768970982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S5OrhVo7pPk7eDVCRCc8EFrnL6xGq7csvkmXA9lcAHY=;
        b=ExYLN99TuWhTRRks/qYU1YfP6q8TOiX4SQl5oNlsVPxFZNoh60JXAVFyiZG/t1juxX
         Y3GCPNBczmQ6Brm3wtcFmB3b7QXaBAzfzcbP5WIAd4zyzeWnBs/QT0a5j8Bv5v/maahk
         TRiHolXHhmCRCgdhW7fe+9cPsqQfXgcBwuZcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768366182; x=1768970982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5OrhVo7pPk7eDVCRCc8EFrnL6xGq7csvkmXA9lcAHY=;
        b=sZ8z4jKR6yA4BrUyifo672HK2nNVN9XvQLZNTFvGKttPn7Bu06XQXM0BzILRLfgf9K
         LKACjY7PvNwAbF9eTaGqYpFBlqv0P+j05yaDdASQeCk7Lcjie8judtruCECHzKt/8zx6
         dba3/gFVUT6yyvgeRAgLEGG/X6EALYZJaFqShUgUuMa48bEVyRWIwxFNVmUMdEwL04Ql
         vthpxqm1hwVEolbjLYm7aWzv5MEECRqWj/cDGF9v3YbGdFq7DWCbn2lZIpH6sRcgurrM
         AMoabzVPqlcs2pP/dxhyB3RaPfTXymRaFqaFc1RM8E0IazDyE3NmrnxYgJ7WRkfXQMqy
         EAnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmXmBh1Rj0J9e/CPxCJ6LwnKRulRjnaMBUTSk0l5txBCPJXEzVBjtkA40WMCUIw6dsFoRXRcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynsNbS3eZ64G0rCrbKlVURqMTx2V53L5Z/3h9+44r2n+rXOCH7
	2j38WzMuNe9vEh91CfjhjtI2QZC0yQviXbTYtU2k0LG68sNYvTB/79h1YtIws5XKWw==
X-Gm-Gg: AY/fxX7RsLUjaSF8SQVLxEkyam5YJtYP+bMTxrWVB9G9KBCUvbV1DAOdLCLYvyYLJDz
	g7Z7UOcf1pSptl+im/vTG18v/yn01GmLjVOobKahETk/3BsJDquFRYSK9dA/bOx6CmSSAr2SiID
	7+WqTfDmXmUJjBNehU0DBY3VCNZv7XxBc99X9M2uWb2mLoNl8cvysLbGtW6rQ1kG7G1Gad55p6d
	Uj7VKf+h36x4kkjvyGhb8zMuhOuLzWBDhTRYt1sx3xojSvY6H8nJ867jRBXt9Tz8MePtvTggpe5
	+wrR9YRdc4tcwAOfZ4o0rfNc/YpvG25Vq9sQRoxoFZCSsZFpnGkAW+Wg8w5xf7Qh1XC4xO6aHo9
	3a2LIWFBlrYPQoVVpXLyc1xHu7uLdzIFo3PgJmc0DzKns5NzfFkscnOXkkoXVML6pMGU4P8cqbU
	vMRhBt0KfyPlUS/CQEJ84Y48tPwohYA1Ll3HmhqPCU1QJSF6kB+/s=
X-Received: by 2002:a05:6a00:4209:b0:81f:37b2:5657 with SMTP id d2e1a72fcca58-81f81ca9e58mr1139786b3a.17.1768366181800;
        Tue, 13 Jan 2026 20:49:41 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:8065:d8f9:6e13:25a5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81db6e09161sm14267226b3a.24.2026.01.13.20.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 20:49:41 -0800 (PST)
Date: Wed, 14 Jan 2026 13:49:35 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Tomasz Figa <tfiga@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Harshvardhan Jha <harshvardhan.j.jha@oracle.com>, Christian Loehle <christian.loehle@arm.com>, 
	Doug Smythies <dsmythies@telus.net>, Sasha Levin <sashal@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, stable@vger.kernel.org, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
Message-ID: <ndqg2mysdc4bsvokmrqubx6rw3oj3lrflxw3naqiohbg7yablf@ccm3rl36dnai>
References: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com>
 <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com>
 <005401dc64a4$75f1d770$61d58650$@telus.net>
 <b36a7037-ca96-49ec-9b39-6e9808d6718c@oracle.com>
 <6347bf83-545b-4e85-a5af-1d0c7ea24844@arm.com>
 <e1572bc2-08e7-4669-a943-005da4d59775@oracle.com>
 <CAJZ5v0ja21yONr-F8sfzzV-E4CQ=0NqLPmOeaSiepjS4mKEhog@mail.gmail.com>
 <CAJZ5v0hgFeeXw6UM67Ty9w9HHQYTydFxqEr-j+wHz4B7w-aB1Q@mail.gmail.com>
 <rsqh4kpcyodnmcxcdd3yvysdmnfj34fgjtr4pmfhlg2cqtvlhh@iakffruxcnac>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rsqh4kpcyodnmcxcdd3yvysdmnfj34fgjtr4pmfhlg2cqtvlhh@iakffruxcnac>

Cc-ing Tomasz

On (26/01/14 13:28), Sergey Senozhatsky wrote:
> Hi,
> 
> On (26/01/13 15:18), Rafael J. Wysocki wrote:
> [..]
> > > > Bumping this as I discovered this issue on 6.12 stable branch also. The
> > > > reapplication seems inevitable. I shall get back to you with these
> > > > details also.
> > >
> > > Yes, please, because I have another reason to restore the reverted commit.
> > 
> > Sergey, did you see a performance regression from 85975daeaa4d
> > ("cpuidle: menu: Avoid discarding useful information") on any
> > platforms other than the Jasper Lake it was reported for?
> 
> Let me try to dig it up.  I think I saw regressions on a number of
> devices:
> 
> ---
> cpu family      : 6
> model           : 122
> model name      : Intel(R) Pentium(R) Silver N5000 CPU @ 1.10GHz
> ---
> cpu family      : 6
> model           : 122
> model name      : Intel(R) Celeron(R) N4100 CPU @ 1.10GHz
> ---
> cpu family      : 6
> model           : 156
> model name      : Intel(R) Celeron(R) N4500 @ 1.10GHz
> ---
> cpu family      : 6
> model           : 156
> model name      : Intel(R) Celeron(R) N4500 @ 1.10GHz
> ---
> cpu family      : 6
> model           : 156
> model name      : Intel(R) Pentium(R) Silver N6000 @ 1.10GHz
> 
> 
> I guess family 6/model 122 is not Jasper Lake?
> 
> I also saw some where the patch in question seemed to improve the
> metrics, but regressions are more important, so the revert simply
> put all of the boards back to the previous state.

