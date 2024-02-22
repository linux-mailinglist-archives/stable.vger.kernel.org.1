Return-Path: <stable+bounces-23359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CD885FD78
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 17:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77203282C7E
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 16:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ED0138496;
	Thu, 22 Feb 2024 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="W8A7bUhH"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E359B14E2EE
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617761; cv=none; b=SOBkZ8Hu0obybJwzzL7rgneb/0Fqr6ouiwLCtdW1KXGYpwvFHkz69ahgLFh44tePcYZZK4NiChSzXcP4XxErg5/tSukiNZrAJaELOFAy2OmgpqNwmfDFFI0yHIFtrrbvEvO6dVIXZw6nabsMn37UXL3UqA6/Njz5TikXOf0r1H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617761; c=relaxed/simple;
	bh=ioVEnIIv2LvQS9Mc31dLdEn06oO0KtIapfHuVw8sKBs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=en+Iz3lsmzrayAcEa9Sbe8CK0mJ63X75Hz8RWUEXHbgwrwr/vOYO+1HgWr2tx6fYldqpzst5P7H0C4Z+ij61spAkcUnhYOcng2cYp5+zWLkKxkPke7BA7g8RahOOsWO5KgppsLv/n/mWgf0PC3dZyyYsuKEW7uepZ4MVq4NBvvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=W8A7bUhH; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 03FA83F44E
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 16:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708617757;
	bh=YkK9+VrPFY7+ZLGX32kMFSkGxVvUS8BKp2ngzff50Xc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	b=W8A7bUhHpaWPAtxhlQPJKYe/VAD08D4eoKeDN7PQ/3b+n3fZglnEmOc/uWsPkTJ2i
	 1ezmGiICIA+Ljv+kvT2I/wAVNY1Roc55g9Ngv3sLLnMXOgOf0XkYXjzkU0SHkqBznc
	 4bluN/w3UNLBmWGerCPdOE+/QNGvjCg5dUtVNrvUhXcJd6TVfCOrNLMqKwNkw4xBtZ
	 GepIoUGo67kI0IlbplcYvIzWO+5QgV23uTDdweMSQDYasHUjU65N2pLz5BJIo1NI5m
	 8d6BnWEijemtQwGxR+5B23ztX8Dh2NAZoxdWq3rSTWiaBHVUJB9QDjbbiXnjv1H1h1
	 6jQtUeszFXq+Q==
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-59d77bac3beso2248032eaf.3
        for <stable@vger.kernel.org>; Thu, 22 Feb 2024 08:02:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708617756; x=1709222556;
        h=content-transfer-encoding:to:autocrypt:content-language:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YkK9+VrPFY7+ZLGX32kMFSkGxVvUS8BKp2ngzff50Xc=;
        b=VmV69E8R8Y0dEIUMHx2RcbC2HKl20FsG8lOwx/GLU87IweUlakEbtshErDEDt75v0v
         pQY3E4qzrTs/an9xgjs8DFEGAu3UEzFFz8EE7wKmS2+osFQlgmTaKEpWxAHryff0iClc
         G8043kjuPYbRe7Md4CsfNUhdP6F0NggXZAK/lKZujfGpu6Nln+LIYl9FOEqYUxMs57sZ
         H2z0NPnjOHJnHBJbNXonS6UlU/HMq53pD7VhZUxf3u2waSle/teHgmv4INgMqq1ZQSD5
         ojQc/wG3/rp/ntIl1mKYx76HcZRayRKfmokhGrbIe1oiZBXxLbSt5ivwgZzXCC5fNsyF
         iR/A==
X-Gm-Message-State: AOJu0YzDD5ITqYiZc02AeYWebaaJFA5g7pqxx3r0h9cpG74lZjV1jY2T
	v1FUvSH56TXxYBHNQ7hq+kM5wfTaLKZxE6i44ukzUU6BDdb1MHNyX9cuu9aj/UrnTa2K6yBZyc/
	7sBpk9E8HKOSg0UrniUzZZ8zpY0qSZIFHsi818AfkmTsFakYWY0MZQ07Aw10BhOKId190VOQzrc
	m4Z6iw
X-Received: by 2002:a05:6358:6509:b0:17b:602f:24ba with SMTP id v9-20020a056358650900b0017b602f24bamr5836208rwg.21.1708617755676;
        Thu, 22 Feb 2024 08:02:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbjPpLd10zcDumNGG4frYX4cS4ZZHsoRjXrDu+I9rfWW32AmiPfbarfmnCxkA5NQrtt3v9EQ==
X-Received: by 2002:a05:6358:6509:b0:17b:602f:24ba with SMTP id v9-20020a056358650900b0017b602f24bamr5836168rwg.21.1708617755313;
        Thu, 22 Feb 2024 08:02:35 -0800 (PST)
Received: from ?IPV6:2001:67c:1560:8007::aac:c490? ([2001:67c:1560:8007::aac:c490])
        by smtp.gmail.com with ESMTPSA id a186-20020a6390c3000000b005cf450e91d2sm10669810pge.52.2024.02.22.08.02.33
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 08:02:34 -0800 (PST)
Message-ID: <8a078070-19db-4ca7-8210-077818224f67@canonical.com>
Date: Thu, 22 Feb 2024 17:02:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Roxana Nicolescu <roxana.nicolescu@canonical.com>
Subject: Backport commit be80e9cdbca8 ("libbpf: Rename DECLARE_LIBBPF_OPTS
 into LIBBPF_OPTS") to 5.15
Content-Language: en-US
Autocrypt: addr=roxana.nicolescu@canonical.com; keydata=
 xsFNBGOz8dUBEACbW6iR0smNW8BxmNcHzzktKmKImDxMdQlHZDYbKfQLBwNPGXaBq9b8vq2h
 Ae9pdbwIvaHmx2dL1hWuD1X1S7CKxqH9lsZXF2FZk/l1wlHSRIsElTaxau5lZP+EwzES2kXM
 9zSRE+R6bD/MkGbwPl5fkRY0yhgLt2pEuc+yBLHVkENpr+cC3saikSRwtI6jfApHv2C9DKlq
 +42n0urEI7WR4l0Gdvw/t9c9B3QeEigxz5u1OicnhKcG4GK9gwmCYP2wbjPVwHr1zAxMxHAY
 sKSmR2jb32N+3QnyoLvvQekk8wG0ainqv332+vvxYeTDXTrohdSg5OZPON1V7Wh3LPLAlQbe
 agI0g+lCRXriv7Lu33tLlL7a2ph3bUEMAvagI4rhsgg7NSg4uzeOeLDAdW42qHQGDyRxX0Lw
 U8ZXuN551KLm0u2I/Ruo2AUFIavkjUfSsXqHJpCY2CXmvjDeHcBsHlN7U8VqNeYsqXn0EnjN
 OqgW94WWDZTS8ZFM8kkYbA2d7DQZstmhS9h/zJ3Y3wdsph4BDebp5yMH3vXnwOh85ijqQXM7
 iUkjIfjpXCejDOaeb9RT4xzwEmxChhGYqBk5mNr/plSyyLD+OkOLzAMeFmh5sx5x+/Oui/Xn
 s97hNlfOKOT42WLkcXcRF8xGborT79Nv5ird9E8qDwpkFT3gwwARAQABzTFSb3hhbmEgTmlj
 b2xlc2N1IDxyb3hhbmEubmljb2xlc2N1QGNhbm9uaWNhbC5jb20+wsGOBBMBCgA4FiEEuTxl
 ymcAhyYitf9DENoe7adEB28FAmOz8dUCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQ
 ENoe7adEB29U0w/+KR8ikSBennP/B26R8KhFVFUAJCxBToGdHWWoNzmSBMijTvrz4pSS3OfI
 F8fOFPel0aQqoZOOgqC9rWPMy++o20qSg2pUCRrPvqK1YteIX1PTRfoxRSYP5NPp0uQz8f5w
 BKvXSb6eu8JHNzlFlKCvOt5EeMICsl47qf8vGh2/t3PRsp9aLOed1fXnNUXNxqCLphcRwGy5
 sGezEFK690x6oJHmTkq0r4jCCaJpDvUwx4VAAL1SsaEjRwgyN9O3Hp78KlJq+wdfjtMrtheY
 AnME9B0OjuE/PeScNy4qG/jmmjTmlkT4n99JkkQXTiJeiWZSkBAh/1zR/j59q5GiyTOCEIFw
 IZJNIBTdfHfwEYoPiRiaZk3zCVGgey+F7trwXXM0AY4IoBwvpB671RFxsrrbS/Pz7i1WgtW6
 oSK+u6OqmewRqZAqg+vYCzflxfFk6xKiAuKtLiZED3e2Lt0aHFCKyCDpsdMsTDSupO8WnqvB
 4yJkoO6QyzyGT2Rv5eWI8S3/R7MTtJMt/K+fYJ8+/ltlHqKIcmpFrByft779g3D5dyKtRfWV
 s1FMHwoAdr7xEc8avcVbqTXSurFcnwMCYuM6G9zCB+q2yaKGhMzPA/LHlbGyS8QpO5H3ksp+
 bx/87wRw/0ScbT/eswhg53tZx//Gxf5zIMcPDytp/vwcyk1HWiDOwU0EY7Px1QEQALRjXzH1
 KoYC1+9B2+/s7EQWx5lfXimqnVG+qPl01q9qEPZqrjBwXOWJhLaFYLFa3GWOVxSpzRpZNL64
 wwmABJWQEWqDoW4p37q51TxjcQbs/P8jIy0tvDzYixWUj/NwBJnIuI5ge+GJ9xBtsN+e6/34
 pXs+hOAU2d9HPmpmU4WnRNqIfckBABZK5wB19Xhljo7usXKRciuJkTLp2rQDcmpxBv+VqqKW
 icFmW4iam6ZHuElU56/Li/U51L1LeMOCtXWnrKKoiaRSBK1XiItij1mYs6ayaBlxXk8xceeH
 bAHMgZXnltNJeog4S/1doGnrlJYkYcYdDu+Fzf+c5A5bFbe/s89uSpst3kbEqAD1AFEDBfgK
 Kc7CiI3L0uQJ0oYFRMMeu2FM1GMYFF24VZi72fI9WPpU0HmXF0ZouIcud2fcCVmG0S9euif0
 abPi/1Fhn4zIl7bG2+TeBeS28RYZA7XC4exbiPOPRETbFBsTWp8KloRNdIQGg3FCudMz2LKv
 UOu/IXafwBtgORLDr1dj2Ze2Krf4EkBJh8xRgCYbvBOycceyIkBb+F3IfDxqvmaDqnEnoJyS
 lZ84o8R3V3lhP2OD/Yvb+gBl+O/xXzfP6rRMrruZRFof3AXsuKKOcgDpIXd2/MsG/MK/HTHK
 6KFfZCGUdTxhoAr3XVg8Q0CuwZ3jABEBAAHCwXYEGAEKACAWIQS5PGXKZwCHJiK1/0MQ2h7t
 p0QHbwUCY7Px1QIbDAAKCRAQ2h7tp0QHb9HKD/42ya1pLxmkJ7pAZeWIiszMwDEEmxbQicS9
 fZtjRN/IL3AiVvcWyN8cqsESx9xzCnjad+rCHr4PmuGvTHasolFHziCX5B2bCRAVAkGIBcJC
 2mCPQEGZt8YysGS/y9KxqMgCy045pcBKtmPtRWab26+3FbkjJ/eje9vcDv2GyN09Rh6R57Zx
 2hN4rZjZnbp7vfZPrKhPbIT2ckV5ZtUm9Er0/Vy/Lu/CrnOOYwJrpgLa8R3thBR9t0pDZdFd
 VAwl12qzt2C9Js+XjuxhYuywTtpvr8QgBhu4U/JN7OFfxD5WSanJ38KSFK3FeUdeqIfDDTQK
 d0f6ntHmjLqteo87cedJGwtFIZTW1a5eCZiKsfhosCSmrFw3DLDI5Cun7Sm1SWMShYzSpnSC
 i75PB8GYiH5T12ZSxRhRXCIri0OzPRYvfKZ82Ji33UUG5MZvqKpttEXaK8bxqmAg0TrJ+nLd
 jn99r9WDQokRITZRW4GCUDFY/K6p8MBfGM+sm3oi50hGXi4SRIYD0dZpC7QWRYNmhR9AsxWR
 EGoQV+X6XMEh1XFcBpExwvFrIpD+5SZrWp4e/lGLGA70EBHKFO15YL1Pv+fChskp3wRYr4mG
 Ao8E1tCv1TJZdkVZ7z93qUroOf8qi71FSzApqEHX7OyT3ad5/fYRzeme+3VlwGS6MHMWnpuo Og==
To: stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Please include commit  be80e9cdbca8 ("libbpf: Rename DECLARE_LIBBPF_OPTS 
into LIBBPF_OPTS")
to the 5.15 stable branch.

Commit  3eefb2fbf4ec ("selftests/bpf: Test tail call counting with 
bpf2bpf and data on stack")
introduced in v5.15.39 is dependent on it, and now building selftests 
fails with:

...
linux/tools/testing/selftests/bpf/prog_tests/tailcalls.c: In function 
‘test_tailcall_bpf2bpf_6’:
linux/tools/testing/selftests/bpf/prog_tests/tailcalls.c:822:9: warning: 
implicit declaration of function ‘LIBBPF_OPTS’; did you mean 
‘LIBBPF_API’? [-Wimplicit-function-declaration]
     822 | LIBBPF_OPTS(bpf_test_run_opts, topts,
         | ^~~~~~~~~~~
         | LIBBPF_API
linux/tools/testing/selftests/bpf/prog_tests/tailcalls.c:822:21: error: 
‘bpf_test_run_opts’ undeclared (first use in this function)
     822 | LIBBPF_OPTS(bpf_test_run_opts, topts,
         | ^~~~~~~~~~~~~~~~~
linux/tools/testing/selftests/bpf/prog_tests/tailcalls.c:822:21: note: 
each undeclared identifier is reported only once for each function it 
appears in
   linux/tools/testing/selftests/bpf/prog_tests/tailcalls.c:822:40: 
error: ‘topts’ undeclared (first use in this function)
     822 | LIBBPF_OPTS(bpf_test_run_opts, topts,
         | ^~~~~
   tools/testing/selftests/bpf/prog_tests/tailcalls.c:823:17: error: 
expected expression before ‘.’ token
     823 | .data_in = &pkt_v4,
         | ^
...

Thanks in advance,
Roxana


