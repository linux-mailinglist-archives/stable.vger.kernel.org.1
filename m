Return-Path: <stable+bounces-180472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A829B82BEE
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 05:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB9B1C22EDC
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 03:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E86A22A4DB;
	Thu, 18 Sep 2025 03:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqQSzHav"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0211E25FA
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 03:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758165858; cv=none; b=Q7ZE+Nx7hWtlnj3swQ0r7UJKvzKKyrX2WgEMKVxg0H5HufQzRlnhduG3vX6kCtIYevWExbDki8VR93FkW4fyP/pNu78Eb6hB3SIGDmWombalHY36VUNiugxu/nn1aNFdrc2a1IAUjF7F8eP68WgPpF9C5hFrVrmZQEXho+KCd6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758165858; c=relaxed/simple;
	bh=DvWUuw32eTmD0TBOxqoUtKRjTwAHv8x8+456fT8H83A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JUuZJiPrBsxYO0P5OSpDI2GnhHbU9p7Lyd5AiRWfPLpJyL3PmsNImIoIJ2JsJ0lYqqgmzeUnkDPZpbXuTb0u048xMwgr7v4BwVCSZlQxCnFCr5yP3N5yr+356DFUWDB+2zKdat2tGYxwX2/3cunPBR41hyCL6RzWnPC5rLaR8qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqQSzHav; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-42401f30515so2885425ab.0
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 20:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758165856; x=1758770656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DvWUuw32eTmD0TBOxqoUtKRjTwAHv8x8+456fT8H83A=;
        b=UqQSzHavKO8bNoOS5GJuJjjmFKpG2Vt9+mSlxKqbXd8ndtw2oEq+XUeATQOSQQoErP
         Usn9+iBzREgMsPLeDmwnwfIMB42uIT56LWuTSMswHR6VvR0uvEoIAOG77ITEDql2TWz6
         F7eW7PqUCBCXwPz/pJOD24JJBi1mubUj0lRCCpKlyycufgyXSLpJyR4JvF850JXFUHWG
         k2YR4e4qqSnSQqZGBrwKs1R4ZReD5v5dULh1b+uR7aSTKZqYj4pMjkewxFmZ4uytKGZP
         6YxxsPLIsL/ynYGJM+ZKiXEEKsn6tCOP1GQ5zl2lZjVDoMuX5tq6MSbdC0evEgPmc+Z3
         3XXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758165856; x=1758770656;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DvWUuw32eTmD0TBOxqoUtKRjTwAHv8x8+456fT8H83A=;
        b=trwYFkTJ/iNnyyxJ9ZxTs0DCXNaay7rneyMek/WByJA6y7mmWhI85DLKaifhcOTxN4
         713onIi1kET56jNYQuRfPzv736vuQRlqwBolF1T/T/UrV3qcXfvaOYitUQnjMCvjUazJ
         sFdkvGFNKB95X58CD29SlywSZNMGeN87TKW+7zsm9hnsuQeOk6IJmAO3sSDcA36YRc20
         OZBQmLxdxcgnzntWw6HkT6a1MmO3t+0VsXox/J0i4wl8bdpoNX2Ce6svNy5Sizyfia0V
         ImDnBlIWjm9h/oV+dSI+9ST4XYaMKJIx/k7sfQJz3ufKq1HByUon0J2wW7NYDAZGHsCH
         Rs9A==
X-Forwarded-Encrypted: i=1; AJvYcCWzUqWmeqs59J3Gjh4fUVke47jT1AKJCx2ggZzYa6mPx0GVRgJcOUpd2j8Wlh1XgHADrxZ4LGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Z92Se5ubwjFnbkaRpI/p+vHboH4E5eGPz8ZSCGiqCDYlLqsM
	fN4P+XXT+J1Atf98VaVnzvWr82KxlMTncVRU5FoxcraYbOc3WaXjJbBjhuZKVM3Edz+HRFO7UJn
	nOS4Ffdr+no8jHDWw2ciFVnp065sM+fU5lzKN
X-Gm-Gg: ASbGnctIJVur8yaHYE3U5xNaeKmL3LnzLf+rlq1Sg61lxwaMLptrB3LwBWziB2jnBXV
	F6VPYlxFxE3Y2J7NPvHgXFYh/Fpqe0bw2GTvdmW1qE0j1NC1JmLFf/yH5Gzn2/F0f9jb0xR/lns
	FY6UVKFhH3aLdcd/JrYZnSIvrdqCRfT/jKIT2wMl8C/kWL7ElsGQsIwMdiRgPQPB0tPpVrQBf/w
	L+SFVkGxjul4kCJqMiYf7hUxj1OUS6s/lGasFtp3gTRo0YRDZ3Fg0txP94=
X-Google-Smtp-Source: AGHT+IHfDggKv5QOJ/N9XWK5VNhvBo2x601ZNaTZuASjaVHdh6hja61z3hw04catZiFTV9IVWU2JHH32rSqA68zyY2A=
X-Received: by 2002:a05:6e02:3787:b0:423:fd65:fefa with SMTP id
 e9e14a558f8ab-424444e68c1mr26363375ab.6.1758165855748; Wed, 17 Sep 2025
 20:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: CHANDRA SEKHAR REDDY <ccsr007@gmail.com>
Date: Thu, 18 Sep 2025 08:54:49 +0530
X-Gm-Features: AS18NWAP7q_fkSyvuwb8OByZDBUBkGuLAC104wFC2wov2kFHWMzA9WOBzEoAGSk
Message-ID: <CAHD5p1U5vrrcT1QpqPDwEgQJANdX67N-j0Hy4sh2ED+6BPMstQ@mail.gmail.com>
Subject: [REGRESSION] v5.15: UDP packets not fragmented after receiving ICMP
 "Fragmentation Needed" (works in v5.10)
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "arun85.m@gmail.com" <arun85.m@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Team,

We are observing an intermittent regression in UDP fragmentation
handling between Linux kernel versions v5.10.35 and v5.15.71.

Problem description:
Our application sends UDP packets that exceed the path MTU. An
intermediate hop returns an ICMP Type 3, Code 4 (Fragmentation Needed)
message.

On v5.10.35, the kernel correctly updates the Path MTU cache, and
subsequent packets are fragmented as expected.

On v5.15.71, although the ICMP message is received by the kernel,
subsequent UDP packets are sometimes not fragmented and continue to be
dropped.

System details:

Egress interface MTU: 9192 bytes

Path MTU at intermediate hop: 1500 bytes

Kernel parameter: ip_no_pmtu_disc=0 (default)

Questions / request for feedback:

Is this a known regression in the 5.15 kernel series?

We have verified that the Path MTU cache is usually updated correctly.

Is there a way to detect or log cases where the cache is not updated?

If this issue has already been addressed, could you please point us to
the relevant fix commit so we can backport and test it?

We have reviewed several patches between v5.10.35 and v5.15.71 related
to PMTU and ICMP handling and examined the code flow,
 but have not been able to pinpoint the root cause.

Any guidance, insights, or pointers would be greatly appreciated.

Best regards,
Chandrasekharreddy C

