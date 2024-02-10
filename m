Return-Path: <stable+bounces-19420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 545DC850656
	for <lists+stable@lfdr.de>; Sat, 10 Feb 2024 21:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9813CB2257F
	for <lists+stable@lfdr.de>; Sat, 10 Feb 2024 20:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038A35F879;
	Sat, 10 Feb 2024 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bjaL2uJv"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AF55F55D
	for <stable@vger.kernel.org>; Sat, 10 Feb 2024 20:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707598562; cv=none; b=OcakqqfuTkUjrmqHXL5uDfN46H10jGH+SnruOVOPiuweAc2pt2J56snm3H/y4Dh9mgeNka4fdUag8/JtimFd8WJDdWiKTxJH6XmdCqnuG4pFSvaZhpD8QKkLocvx6AsaPOUQ3rirpB9YKyQ9cLt+sUlkg1rxcjnfvEi+0HWYRNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707598562; c=relaxed/simple;
	bh=8qfyACAcgk3tJ+TW7OcsczxVCRDCyL9gnpY3wK3frW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uO61Dm6r2BmnNsarFSKLiljMC2Ts52dSsV1+JUhJYILVelTXNXy/SornalmSb445ajVN0DzdWQwc40ptR5AvUr9pAP6FAbbvQMMsij5oN7Onp1lAGRHiH5kCSOynJ6KVJR2JcwAAx6tS7kYFmo+Yd7pYGVxn2oQ7BQ1flwYeYh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bjaL2uJv; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a293f2280c7so285354266b.1
        for <stable@vger.kernel.org>; Sat, 10 Feb 2024 12:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707598558; x=1708203358; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ar3WME4JMU3/yObf6RECpMJoF90CRKIcM+tRaHWfvE=;
        b=bjaL2uJv6gsusqOiHTLRG9TffwtUVo6BOrxSxN6qw6VdTcVEbHNaPh+RSyAf44Bb8s
         tetipT9SmXCpuVqmE0nIGWvN46KMpKNLj7mZdswRDdMw1tTE3TUkgz/h2XCBxNev30mq
         fjGnAJfJHEJpT4JGoaJicDpgBMnT2CSmHGwUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707598558; x=1708203358;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ar3WME4JMU3/yObf6RECpMJoF90CRKIcM+tRaHWfvE=;
        b=d9Vl6dG2eh80Q+0rZKSdkRtbhrM2C4Rzcu87O/ZhRPx4/4DRGL2yRNOQC5fQe0gtjP
         tFcCpeqAJbob76PXaMmxPsa5B4N5r5qL9AgD8Qrsj7jJK2ASNUqjhBYv+ghVoxEG8g17
         dMnXUp646lnYHEjlcg8LN+0+W22CUVBctZI3fqROc6pgWE1Ctq+G/g0SVDEWTOH/wOsS
         OEZhxFneuJyiTxwZ7tXlt5FmHqnXWvfBJhH+nOByqkJUVKY8bcDNWGOfTD92A9a48CFk
         QF30/Z47m8O0WncICwfOgOiIsgu1a7RBb2oZxRQyLSsccFm5ImymCYW1NUdSm5x3ic5t
         oUVA==
X-Gm-Message-State: AOJu0YyVKz+NvQLH3EJERScFvVmG44nO5XCUUkOWd/tdQ/LWIGZ1X/B6
	mjBzy8RIw+x8nFh0128U/5+xW55nBrzK3k1XJIB+7lgw0x9rCCDifeLwmtgPglXOtwCGP69WsRL
	4LoWWO2UEcYLrX+KHnuVRXFdO3XrqgvQTLa0gjTapXA2fTVfBLFii
X-Google-Smtp-Source: AGHT+IGnYzoGlJsJuegUPX2HzAR0fTUiANkdIEaS/s2EDlv02XKF25E9AIOWGjo0VHf96giGF+yWpJbjwMhTnJHbbJc=
X-Received: by 2002:a17:906:190b:b0:a3c:4543:98eb with SMTP id
 a11-20020a170906190b00b00a3c454398ebmr1183087eje.68.1707598558411; Sat, 10
 Feb 2024 12:55:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210201237.3089385-1-guruswamy.basavaiah@broadcom.com> <20240210201237.3089385-4-guruswamy.basavaiah@broadcom.com>
In-Reply-To: <20240210201237.3089385-4-guruswamy.basavaiah@broadcom.com>
From: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
Date: Sun, 11 Feb 2024 02:25:46 +0530
Message-ID: <CAOgUPBsTgdqko3MwpWsjLfSDZp_4CRiRwALcsWSJQKTuML6aQw@mail.gmail.com>
Subject: Re: [PATCH 5.15.y 0/3] Backport Fixes to 5.15.y
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The subject lines for patch 2/3 and patch 3/3 incorrectly mentioned
"5.10.y" instead of the intended "5.15.y."
These patches are intended for the 5.15.y branch, not the 5.10.y branch.

On Sun, Feb 11, 2024 at 1:43=E2=80=AFAM Guruswamy Basavaiah
<guruswamy.basavaiah@broadcom.com> wrote:
>
> Here are the three backported patches aimed at addressing a potential
> crash and an actual crash.
>
> Patch 1 Fix potential OOB access in receive_encrypted_standard() if
> server returned a large shdr->NextCommand in cifs.
>
> Patch 2 fix validate offsets and lengths before dereferencing create
> contexts in smb2_parse_contexts().
>
> Patch 3 fix issue in patch 2.
>
> The original patches were authored by Paulo Alcantara <pc@manguebit.com>.
> Original Patches:
> 1. eec04ea11969 ("smb: client: fix OOB in receive_encrypted_standard()")
> 2. af1689a9b770 ("smb: client: fix potential OOBs in smb2_parse_contexts(=
)")
> 3. 76025cc2285d ("smb: client: fix parsing of SMB3.1.1 POSIX create conte=
xt")
>
> Please review and consider applying these patches.
>
> https://lore.kernel.org/all/2023121834-semisoft-snarl-49ad@gregkh/
>
> fs/cifs/smb2ops.c   |  4 +++-
> fs/cifs/smb2pdu.c   | 93 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++-------------------------------------
> fs/cifs/smb2proto.h | 12 +++++++-----
> 3 files changed, 66 insertions(+), 43 deletions(-)
>

