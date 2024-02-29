Return-Path: <stable+bounces-25466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DD286C3C8
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 09:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E1E282876
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 08:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1622F50A7E;
	Thu, 29 Feb 2024 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EqM6kLGp"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDF15026C
	for <stable@vger.kernel.org>; Thu, 29 Feb 2024 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195754; cv=none; b=AIq98/c2TOlJFH3+YbXCBIPVwJ28ZEu7C980Y/JFcSd0uzxW7CQUPh2v3Lkfj37ZCCwZMMb8QmwWa0ZTEE+cQECAj4P+EqXjI0Wg5XZ5vKokY1RXMhJR9ZwiJPHwcafmlN2mSo2KjcAdfKfIjIfXafITb7g5EWgkS/1R6ZFNnMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195754; c=relaxed/simple;
	bh=KHe0vd4rr+vXYf1UU+ivDsnmuP3b1rCoT3r0Q9r8Jyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCW4P06nrh1deXRxB9LV+wrMYAzLVR0HEd1WhV9Es2ou9PeHEcdo889s/973nZGtRHa4/CWPE1p2ESlbotjAWqf2h4SfSbXMp+PtjB50Y3NbPLHqy3W1cPWC2k0NvivPbCTUJCeuT9WJzZu7lRg9p36gVHzrkIV/ZwRAbFWw8h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EqM6kLGp; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51320536bddso510943e87.3
        for <stable@vger.kernel.org>; Thu, 29 Feb 2024 00:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709195751; x=1709800551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHMiUMkfn9Ln8Fptw7oIajJ2wzJq68g7qAFUPipFhuQ=;
        b=EqM6kLGpr9Md9gzJXDbdEtEemlLDwqQVkf8bzZOLRkR6nyi5Uf3JrAi+jZllTNydWz
         5ba7FVzBnSnVQieZlBuRaX/6ZPZe6MzhoMv3YwPEjBZHEwpVLQ4h+tnmuA2AarDsmnvL
         1KhEuhXnFjJo7D3oKON19NHu/YFGrUaA0KdXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709195751; x=1709800551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHMiUMkfn9Ln8Fptw7oIajJ2wzJq68g7qAFUPipFhuQ=;
        b=ueZkiJphfdGvITX6QsfX6WaTjbYrGGWjfg09aHXXIEITd5w/RaWAKd68egXQvljY3m
         494HXL+UYepTUuu+ef039e5eD9vfDdxb+58m8ugFX+Bmi3u78n/6VJJFb8/fmh1meZa/
         q5yPyFhQJce2HOrhOfsITxqArH2HZZvGbE/LvQQRqoXWfomsynKkt1AOdjLTX17kgkO1
         urmBY9eq85tzYOEIZz418e+rN1Sxm5AxHkeXE4rjBywX5Dpkg5unJmooEqHGJWYkKb7W
         Qpw1h0WFgbjrSxWNYRf7MPz24hdyDPYeofIEM5tbZRdnIa6JA60OmBZcAasLBqnbCX2l
         iOpw==
X-Forwarded-Encrypted: i=1; AJvYcCWGpm56xsy2LjYQec6NXCZ2FLbvvDWEXzjOaapNHa4VDknUuM9o2RtuRV9UJ8naeTfGFG7Nm/zLtUoi3TLM0/TfhPfV7kbL
X-Gm-Message-State: AOJu0YxJLik1gUjtJH8Xb3maIkMHIb5YR1NujsVKHSxzHTYHosHdCtpW
	XPNof4wqMQ3whKzjJWZlmYeT4rVcARuWzN5YXsjNlsncbYLVgC5WtQZEmrr1ah1A73NtVKiqIPe
	EMVFgvOJsE+q2suxIeyYZwUH5GP3ZnbtAlJWQ
X-Google-Smtp-Source: AGHT+IGSsG/uueGLw2cyz/KSj6na0BXpIY0/hQdZvIVZp6sI+Iv9U6g4cM8USKMBNWQz2AWeQVMbrg4PCd1wjeiq8qQ=
X-Received: by 2002:a05:6512:2388:b0:513:2985:5e05 with SMTP id
 c8-20020a056512238800b0051329855e05mr456199lfv.57.1709195751120; Thu, 29 Feb
 2024 00:35:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024022817-remedial-agonize-2e34@gregkh> <20240228184123.24643-1-brennan.lamoreaux@broadcom.com>
In-Reply-To: <20240228184123.24643-1-brennan.lamoreaux@broadcom.com>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Thu, 29 Feb 2024 14:05:39 +0530
Message-ID: <CAD2QZ9YZM=5jDtqA-Ruw9ZcztRPp6W6mZj9tA=UvA5515uYKrQ@mail.gmail.com>
Subject: Re: Backport fix for CVE-2023-2176 (8d037973 and 0e158630) to v6.1
To: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, phaddad@nvidia.com, 
	shiraz.saleem@intel.com, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 12:13=E2=80=AFAM Brennan Lamoreaux
<brennan.lamoreaux@broadcom.com> wrote:
>
> > If you provide a working backport of that commit, we will be glad to
> > apply it.  As-is, it does not apply at all, which is why it was never
> > added to the 6.1.y tree.
>
> Oh, apologies for requesting if they don't apply. I'd be happy to submit
> working backports for these patches, but I am not seeing any issues apply=
ing/building
> the patches on my machine... Both patches in sequence applied directly an=
d my
> local build was successful.
>
> This is the workflow I tested:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 8d037973d48c026224ab285e6a06985ccac6f7bf
> git cherry-pick -x 0e15863015d97c1ee2cc29d599abcc7fa2dc3e95
> make allyesconfig
> make
>
> Please let me know if I've made a mistake with the above commands, or if =
these patches aren't applicable
> for some other reason.
>

I guess the reason is:

8d037973d48c026224ab285e6a06985ccac6f7bf doesn't have "Fixes:" and is
not sent to stable@vger.kernel.org.
And 0e15863015d97c1ee2cc29d599abcc7fa2dc3e95 is to Fix
8d037973d48c026224ab285e6a06985ccac6f7bf,
so no need of 0e158 if 8d03 not backported to that particular branch.

- Ajay

