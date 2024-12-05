Return-Path: <stable+bounces-98817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1349E5828
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 15:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84350188412A
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 14:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6CE218EA2;
	Thu,  5 Dec 2024 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIXbnjZs"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9611A28D;
	Thu,  5 Dec 2024 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733407906; cv=none; b=EgreNr/Mr76vA1xYSgHVqL2hGwX5pXXU4Jnyi/awZCoV2NN09P5QHigZasq7igw0cmg7pUQ9fqsMYaODOP5a2Qg/eIJS/FJvoKmp7Ac78Cz4DHhiVSRFbMeuKUPSi+3l7qOLKTOQm7PTZfpHZ5riDWu0EIzxGp3XHxd2FE8jlrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733407906; c=relaxed/simple;
	bh=xZpSnmgGYgmYjC6S22jHypxExV3HUWtrI7m8C5o84Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtdK+cn2j4rrGKvKJm3uiXvFXdML2HCSyO2pFGTz5ZYAhhYBlifyQPa4nTcIVYUmk+QxgtpIryQHAtJyN+E5zz85BJNLt3kdipVq14mNUUpBp0zxKW4xDujGlUYZgi9ZkYgXtlE1yEzprSM3XY2OLWz0k15JIErBi12N2x4+tDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIXbnjZs; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa5f1909d6fso181847566b.3;
        Thu, 05 Dec 2024 06:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733407903; x=1734012703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfYe4ICab1Py8zIDsrFL3Y6kzaJuAiZekwVzc5KCQik=;
        b=aIXbnjZs37OTph9oH/2kdJWiW2ATHqv52ywmN1khgIbqLZLjFhkcW+uScUnD+522oZ
         5WcbbN/wD48sAk3iV7npkw4FswQn3AUUIRnd5+rXgieU8QF6pcNsLxbjGPqMGKnhNJW+
         pvwbpzx54xBTX11rw2VGtq8wvBDrAbt/KRDiDoMF1Eyzem4PKEIkD0/IGWL89shDA8ZF
         S0PyJtBExLfCd8Te0jRsZRCYoV+9qb9QvSopxZVjJoiHNsrKMRcLx1ltC+8DmFxUrOTZ
         d6FICcPZrUScmNKQf5NYOS9dtTolJ6VByjjN98fsW/sGB0ipCLhW6aONJzqXFfMfnta9
         c84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733407903; x=1734012703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfYe4ICab1Py8zIDsrFL3Y6kzaJuAiZekwVzc5KCQik=;
        b=ekmuSzXCvg4hxGj4X0NzZgyC8CPbUxzy6pDhDQNc2O1wpytgi0kR8GcjG0tqDUWMuR
         wcwGv4kaCMZEiQsZ19NjFgFx5utDpiWjJXaV5mQhqIgxb3cP0pPZuGuDiX7aasvLKZyH
         0rOQRpHG+7yef4UbObRN5bMI8dR53kyzuvBGPq73w4YgxyKoswFmurp4KYoHaGBwa+/h
         zO9ggajTe1xioseUnsjnzK8DgSPzscYHIzuWfOjXjwrIZXGrbKxY0LeKsBKIprFen6yx
         9mQ74BfUXLi491L7Hj30/pdist1c+q/QtRdj3kGXgsXhYDCz3so/kuRHJpAudwCuZRnS
         /e8w==
X-Forwarded-Encrypted: i=1; AJvYcCWh7XiwkMUYjLDXh9JAoSZfLumfEQwRZV0X6yuF0GF5RO1WU/MGOSsy1epoqI2ZUTQrvjeeD1Ew+HI34su07/LAfm5i@vger.kernel.org, AJvYcCXGUrKcSk5lW/+9o+9jiVvV+logZNtiVB1QcLAseLgz7xmoU8Ph6r7MppL8Y7c6ocMrszIW+avh@vger.kernel.org
X-Gm-Message-State: AOJu0YyaJIXuO9XSHblfSmBpJhYX2VRLMmOgetHNF6j3n/N+FYkGfjoY
	IjauTqyEObdVp9Jb+gaCLwVow8cRWTEy3OIKebXSALiS/dVIJByg5JNEf9VnodQYEh/LIg8H0hf
	VT36HRMimvY5LtYfZmZGGFdK4Bis=
X-Gm-Gg: ASbGnctzSZCgLLtG9cisx7pJNbHbqUSk1r6pWf8c40Rf440cICFW3qKY0EjHzJT2RCN
	fPHghIJQJ1jFRnfY6GvVnRM7M/YaX6I4=
X-Google-Smtp-Source: AGHT+IGctkYgzZhHQFrVjRvY1pRz3e5HXkV0aSBJupJhfyZeVFcEsAKxqf5EKb+Hbe8s6jFO1wWJt2DP8x1TcHZSXYU=
X-Received: by 2002:a17:906:9c2:b0:aa5:f333:bb96 with SMTP id
 a640c23a62f3a-aa5f7eedd3cmr893400066b.43.1733407902971; Thu, 05 Dec 2024
 06:11:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204204227.95757-1-hdegoede@redhat.com> <20241204204227.95757-4-hdegoede@redhat.com>
 <Z1Fs4j8g7uC-Cc14@smile.fi.intel.com> <d0a88f8f-dd53-c67d-b619-972000c23118@linux.intel.com>
In-Reply-To: <d0a88f8f-dd53-c67d-b619-972000c23118@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Dec 2024 16:11:06 +0200
Message-ID: <CAHp75Vdqv6natT8aUMMRGpuaxX6N+BK3AXy-nC-_G3f43ZDs2Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] platform/x86: serdev_helpers: Check for
 serial_ctrl_uid == NULL
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andy@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 12:32=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> On Thu, 5 Dec 2024, Andy Shevchenko wrote:
> > On Wed, Dec 04, 2024 at 09:42:14PM +0100, Hans de Goede wrote:

...

> > > +                  serial_ctrl_hid, serial_ctrl_uid ?: "*");
> >
> > Not sure about '*' as it would mean 'any', perhaps 'none', '-', or 'und=
efined'
> > would be better, but since they are error messages, it's not so critica=
l.
>
> Isn't not checking _UID (in acpi_dev_get_first_match_dev()) same as "any"
> _UID?

Ah, good point!

--=20
With Best Regards,
Andy Shevchenko

