Return-Path: <stable+bounces-23534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D28861E22
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 21:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8E81C24E46
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 20:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDBE14CACF;
	Fri, 23 Feb 2024 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bLBv3fYJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D6C14CAD2
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721293; cv=none; b=ZjdiWvzJ/Kwp6VMzZLxHY74QwGeBH0q1IfrZaWBAbesLYIKhB8nsfBatc13WG9zpFMaFZTM+ge+HCCRrox6laQl1KWQXmDM01lVjohD8mUovYBepZijWkCU/DRL5CJ6Fn/DUQTUEvlwxz9eSQf4RF4CKK6Xe2CUoKk9xFic2A+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721293; c=relaxed/simple;
	bh=XrIweBt1xAeTI+DcqMD36fsii+srzNHP7jHLCDfCPsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reTmpSjCRzY/VqTg0pOhMx10d1Yj5el0OtgzSckFgG3Gk1a1MUhn35TD5EqQ3/81ksk8SN58HjH+IczUgM+aN5swED530SFGD4fl0b4OWQ7UjaBzkI+cWFPG3S6BmRkSBRpXrhKT2wG05GwfNbGhT0KrXFImBumEePEbZ4rJs3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bLBv3fYJ; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so1093680276.1
        for <stable@vger.kernel.org>; Fri, 23 Feb 2024 12:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708721290; x=1709326090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrIweBt1xAeTI+DcqMD36fsii+srzNHP7jHLCDfCPsk=;
        b=bLBv3fYJELOZ6nfGWoobO0anvO1jTjRBdTd2oTf/gIyOGKQst9Uq42SlO1Wu5izh8w
         5EazRfsfXx9H0Owe+vMv4NEDOMfS5SLY8Qik6ulvw4UyoYqGsJbnBcrzXVfH6ixuSAk3
         bhdbjzSt6P7jDIvPggMXzq9RFeD2i1ROAOmcZhTU0YZM8AqD80EO8M99nUzDdUsqJd1e
         RIAFE9CBKWelkK+Y9m+O19AOaqzdYzVyd0o+/u5aFKwnOpSCERJddy/pmhfLO0B8214t
         mEs2lyznZZZxzNf6CZq5X1XZzK1USZCCcVtQaJ7LRc0xS/RNAbn8KC0o5PXKStetuwR7
         Xf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708721290; x=1709326090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrIweBt1xAeTI+DcqMD36fsii+srzNHP7jHLCDfCPsk=;
        b=PpoZGRz3vVuPGwcma37+s2j8eggmT3e+BuoXP40fgytkdaoUlQjvK50nY9tbq3g6g8
         YoRJbStdoPHJEk8fa387/wxf/U9JM8UxsBx3UA5utMfeI5ikfuwpOGGUOB95OTIyDUi/
         Y0oPCvt/op5NiOE8BrExWzBr7oIkFOwVkyW9T70ucH0JGt0a2UBOaB7SIfBf8+GgpzjS
         67fibMQSQKKTBU4RjQbg2atBm8oOVUNjTwlkSvwQD+T+RPy+FbvdlxRGJ0SCYDm1Z2aT
         A35MU2HrLBudZjA65xj/UesWJiAPV9kVfRpOcFQXBoHy0QHWa3VrMQKIp3cJJQmQnnf4
         0w/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3N5DVDS/2GAc17Q88H8pF3P5JBIPWRTZ+kOcMt3owDqkfgx8L9sSkmosSrnAMdYUXYHHjp+9Q7dQYChytPQ0x1tgZtm8u
X-Gm-Message-State: AOJu0YzDJeH/qRJR7jKpqa2cOIsN4Xji0SipGAbGRwW7rOL9jSzNSGl9
	4uSAhXims5FE7Zy74jVt9a9KB/sjUgo3G1ioWSpfZDw0ywuahQpRWe2Ez20TdDUO4opo6mQPRgs
	MTiFqbSYHrd82tsXUdYQ83uD0OPKtwQ06tuDm
X-Google-Smtp-Source: AGHT+IGupIAFw7nMLiV1//RpofK99g5hxlJIZq7LOh30Kty2WViyFfQDmsNjq2ePE9NcWOZZ8IBp5gns5fSynhBzG9c=
X-Received: by 2002:a25:6642:0:b0:dc2:4fff:75ee with SMTP id
 z2-20020a256642000000b00dc24fff75eemr837275ybm.3.1708721290133; Fri, 23 Feb
 2024 12:48:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223190546.3329966-1-mic@digikod.net> <20240223.iph9eew7pooX@digikod.net>
In-Reply-To: <20240223.iph9eew7pooX@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 23 Feb 2024 15:47:59 -0500
Message-ID: <CAHC9VhRpE2rFya6t4p=sUUbpUzDw1cYWQq=UX4cYJQwNkNnvfQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] SELinux: Fix lsm_get_self_attr()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 2:17=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> These bugs have been found with syzkaller. I just sent a PR to add
> support for the new LSM syscalls:
> https://github.com/google/syzkaller/pull/4524

Thanks :)

--=20
paul-moore.com

