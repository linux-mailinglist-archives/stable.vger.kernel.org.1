Return-Path: <stable+bounces-244074-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNkBO+vB+Wn/DAMAu9opvQ
	(envelope-from <stable+bounces-244074-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 12:09:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A28C4CA95F
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 12:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74828302AF08
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 10:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653333358CA;
	Tue,  5 May 2026 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxzmaiou"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFEF335091
	for <stable@vger.kernel.org>; Tue,  5 May 2026 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975506; cv=pass; b=g0c8tnbmDapEJ52jKicOW6P6IuAc5y/mmSS41tVt1/OEga3BZbOyR9EK6OSIT7yvdTgfwcOelllos0BsxU0sQaE5JhMDwNKmz+mXpdhZbK2YnAx+Itpb6sQO+9V1Fwu5xeQgWKCCdZJeqMnkQ77SrrAUnjh9IgxmS6YC9Bjl2Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975506; c=relaxed/simple;
	bh=XexUs3O5JcQ4u9Xdflg7ex0VD9OVSFnQ+ng7seBz/HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8K/vnSVgbmbXxIO9UTozjkSfuKDXlmcrzQz/pfLqreGaTx2RWhZHV0vDFGqpEsm8NpU4mnyhVD6+hshzR4GiILZtxlefJL6UfAqMx29Iiq+Ex3WFl93v+847Mk4iCQO5l1vJP9aGklcdeygUif2rv6hr7ImPPNjkH4oeCXdOQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yxzmaiou; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso3125782eec.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 03:05:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777975504; cv=none;
        d=google.com; s=arc-20240605;
        b=WzwvEsIk6G/Q8MbU2oY6EG+Golyq/iVg4U3DxS+ZiJxfiAKqeK+he/YhSNETW50B17
         d+L4u7zngabyqFjboYHqaDdMW/QikiAMcWLHjaQeV+P2jRLVwXtyNuSuIsgi67nxxh34
         Y0hBy7jaTtOZ4TC4p9WbvGw/7DoNdlTn6ya+I+AOV4kms3C584uXNNheEykVICJCBTZl
         OmXFVCWlLIkEOMt5mWlweMry5CZCR7988PpWUkE+u+XeZfv8PNrKxDu65LGBVI6vvl++
         p8M5HJ8ZuCNu0y3JnA1TVmwTOVw5+t0ml4M2RMxwWMey3dhRtqK3wlI//aGfD/H5IybP
         R5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=89ZQvEnB/Na6jCKTloQvTLWsQnIxqnHe04nVB2+E7Rk=;
        fh=FhsPy1KdPvpxZ9pg/iJ8qOjaWJD6SnZvY+NbeRjz950=;
        b=gyG0Wodf8bYKHGvGFosekhISmitoz6AOA2c11wiMqVWpz5O9e9YrM1O+fgt67JFR91
         NuP4+pvjw7qfcQYLxrBQ5dyyJrvXa1GSK5ZxccgAlZ7mUFqCy4+/nHSYmy1juR92LxJV
         MsPWYHt2NlgkkqYZINOptueiYyCYLuh2jATPqj/rDFAqh/6GgCL/RAbkJQS4TjWxI6tN
         Z9PbI9gxZocft+5BoLYoOoh8Hv8EYbfGyAE+8bqq8oQA+HRqiGA9OaG2+n3dqCBXOnw+
         Q3VxBd1u/erVwVpzrL8mUhydlp3UbrsouxxCoZDIU4GaXNOcV4uhwfXuKveDPWLg6dcw
         yIXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777975504; x=1778580304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=89ZQvEnB/Na6jCKTloQvTLWsQnIxqnHe04nVB2+E7Rk=;
        b=Yxzmaiou7SnLyh9OhzW+XyR4FyATDVvZR7+7rj6mi9MdpTQ2NK2pKlN86IzkxRapt3
         FGXgtdKQrUZd2M92XmKjC8LfpRRxsj9Lhjij4iXv7ytjvPWQrTZFT8WqDzd78Xja0++v
         EOi42zY/vk7KyaffUC+nzP0BKYnnHhgx7MJYq2jKNA0klAtY6tO+5+i5InTXw9nyUWgS
         QPAzjrupizlCd1iDBlY3a4TFOiiJ+mOU/H64DtB059icMHuW4aLoyE9rFXgioO//8kj7
         C7cs+tCp82yVO4bRPoepL4J1bSVKCyClsZyc2oa1YxOt55yDObi5coJDftQPq+QyuhS+
         4++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777975504; x=1778580304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89ZQvEnB/Na6jCKTloQvTLWsQnIxqnHe04nVB2+E7Rk=;
        b=D5SnkjYokhx36JXIHRpr8mz3WDZTQ4wO17bJXYE4tX39WQnIPH0Y2YHvyqusIv5GUs
         Nb4V0sKxdXfx4vevckroFZ8QkYdbVufK4mjGCRPIm9D9STJc+1rbv/+kNC0NhAwGCzwV
         Aiq1pZBV5Zy7dY3gKoGasMWz8sWjCek2q/V2iYvH++N0a96VjAXw6v3ror4Dslt1LbFU
         UA+rfonqFo/I72PIwsf/N3T33LgGRB5HWdIQ1C4dpkvIWiE2ZVxOiozMDfEI7C3z8QWK
         ZRyS8T/9VmGC3tDmE7pu/Caf73LqZJ4VBdXsVGPeiqOZNLKb6We7NYi3yYMHoOBDZzLH
         ZFng==
X-Forwarded-Encrypted: i=1; AFNElJ+NP8DtnL5fd+ScTj9VZ4WBIoIeqpNaW4hjZHy8/IgbsE+LQDlGNSH70Odo7y8Mc8OdxijGcR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy39ZcNFNE9ocARS8Eec7B1UlZcyZBv84vybwS4Z06WGTmiJfRh
	W7JeODSxxz9ZZXkGr7PbUXf6sIcBkcXMwVh75YSNqDmIayZke9/St6Xly9BzZqihjCA8ZdN3O0k
	yQ+Kxmor81HCqnaKMFlwSKF1Edwc0CcM=
X-Gm-Gg: AeBDievc5rzFLDYe38qy2TZLs/7cblTgUtBQYrQlxrVzBj2nggt+RjgGodv0PzqJ79A
	5388+m8UCcjjxa7Tx8MAbYQ4VC1gR5KFeoAv2OTPo+Qs4fV7DD23s1SsZ04kRHMAlUswuko6eVM
	AffVEGjTS9tcpugB3lsT6MRFjs8uN0Ih6qrVbITDRHTTfeRmNgLmtkrEp2uFY8pJzEjhjP8fEqW
	QlJ4fPmwu8ahzkoXnp5hpCRBKvLuuxYbvzaXPPb0zEsa8viqmAUfq4A6LHu9aEi7gjmfMOpsV72
	eNNGxmGMXDHfqb4eMRMxeNhpbw/ULC7TvnsZ/U3kXbPUcRt2QMCrTly6APBwItQW49n91PBbNVC
	5IRENh+O6kupOJ8YzUBXuN5Yev1zut1ZlGTDyEbugmuwDJUlL+6a1N61szjwtSObj4owkQqVsQy
	pF9Pdaz8bfKJa836TcKh4tDH+15aO3+Z1fKg0gssDvWtwJlshL
X-Received: by 2002:a05:7300:5722:b0:2ed:e14:7f5b with SMTP id
 5a478bee46e88-2f40a18f7a9mr1151611eec.31.1777975503761; Tue, 05 May 2026
 03:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504135142.814938198@linuxfoundation.org> <20260505095136.246649-1-ojeda@kernel.org>
In-Reply-To: <20260505095136.246649-1-ojeda@kernel.org>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Tue, 5 May 2026 12:04:50 +0200
X-Gm-Features: AVHnY4JT-cjkqUsEG3M4nzqCxjgyAeD4QIKJnnEsRIfTNKrdc0pPZlp4BBbDtvM
Message-ID: <CADo9pHgoHWTP80u=bt0mNB4fsYcOELs00ToG0LsZddGiWAb_6Q@mail.gmail.com>
Subject: Re: [PATCH 7.0 000/307] 7.0.4-rc1 review
To: Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luna Jernberg <droidbittin@gmail.com>
Cc: achill@achill.org, akpm@linux-foundation.org, broonie@kernel.org, 
	conor@kernel.org, f.fainelli@gmail.com, hargar@microsoft.com, 
	jonathanh@nvidia.com, linux-kernel@vger.kernel.org, linux@roeck-us.net, 
	lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev, 
	pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com, 
	stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6A28C4CA95F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244074-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[droidbittin@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,mail.gmail.com:mid,gigabyte.com:url]

Tested-by: Luna Jernberg <droidbittin@gmail.com>

AMD Ryzen 5 5600 6-Core Processor:
https://www.inet.se/produkt/5304697/amd-ryzen-5-5600-3-5-ghz-35mb on a
https://www.gigabyte.com/Motherboard/B550-AORUS-ELITE-V2-rev-12
https://www.inet.se/produkt/1903406/gigabyte-b550-aorus-elite-v2
motherboard :)

Den tis 5 maj 2026 kl 11:54 skrev Miguel Ojeda <ojeda@kernel.org>:
>
> On Mon, 04 May 2026 15:48:05 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 7.0.4 release.
> > There are 307 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 06 May 2026 13:50:49 +0000.
> > Anything received after that time might be too late.
>
> Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
> for loongarch64:
>
> Tested-by: Miguel Ojeda <ojeda@kernel.org>
>
> Thanks!
>
> Cheers,
> Miguel
>

