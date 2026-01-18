Return-Path: <stable+bounces-210247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7E3D39B7C
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 00:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 640C730069AE
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 23:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616D322258C;
	Sun, 18 Jan 2026 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkzwHfvE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53332D6401
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768780025; cv=none; b=n7dCXot9LGyfVnNZ9WSgzLOEdqnbKwJQ75fxF3pRzguebijrXMTC+FX8HT+zJVE6zWUgHmaPHqq7Yuw8h9S10Pu/uHPhAWYj5r95fmHvODGP2XyyvLrD0JPhOiFenqL+/UKw6i7r6V1n38F3CASSAcUkLBvCz1i5AhrHS1xArDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768780025; c=relaxed/simple;
	bh=oM0XhPyvAJ9C00Onx0erqFBFaGcGHeVLlrf0/2NGCAI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IsotC6iLn7fdE6Vvyu67ISl82+jYCxe/VanRpx0P9uuJGU8SEbh5EcjsEWmGgZFrcMGUbzi9mhO2uB5LMZgrwA4Zl29bnL6br0+Te6/feaoIZOcY7croFRL+Zv3VEcIZUIvivsXsr6WLO7c8DkloeW8M33uKPmb9kU3rRJ8eUEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkzwHfvE; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8765be29d6so540677566b.0
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 15:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768780022; x=1769384822; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oM0XhPyvAJ9C00Onx0erqFBFaGcGHeVLlrf0/2NGCAI=;
        b=dkzwHfvEveojLY/J4yPhxCNu3Bt8MuMIoZZWfNcQ4oU8b+G/6aju9lkxA4wpfw4Zxv
         7ZfsBy8Zg633IGXMiWQLyGIFSKS0N9GeVsXdidQN4OMgTJOxFfOwLUUyTEGXLhO931XP
         Ac4swiCUZ4B3X/4S/iyGkGNcyI5b9TD7M4lfJsbj4xmRhrzoc+QKKlrAPLnPvCLnP8NI
         MEBtmBTgWMHgwbzwMdgnt4FXUZUymLqlj7elkpliMy+eLI48BxBCKwAGmppOkn1+G22R
         GvmznqeOv5QSenJ2ZuAPLzmmHNjfYxUKnI2s4uZPFTy0ojrdSCnQRdzufccFeAX9yqe6
         1cAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768780022; x=1769384822;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oM0XhPyvAJ9C00Onx0erqFBFaGcGHeVLlrf0/2NGCAI=;
        b=hW1qISwS2eSpEnnwGI+pYmh+yr37WYgd4Sp0P9n7n+VpdyGjkmPCGbkYdBHRsYFkKN
         1nC8eQigpe2Wl6q6VPSzKGXnou6BwQ/uR+VT59OUUPzZ4PmwJ451znWjpIV648yQT6n1
         GFbTRQ6PIhb0SlpsL68lG9xv32Sf8yA2p1VYYt4RqXThV+ypY2vUsBF7iYR5K1+ha93t
         rAxQQX0CuZ1p44kTzTEQ7dF7NXwJmD+iQXR//P8ytRIpGvyI0+dbqLUu36nPiss6vXz/
         8VX8dcIW2WCzLOlAmJNdT1PoJE3waOD7X/UnuKwnvye6d9ErLciaJrzvNNfPqGw6K5zL
         TE1g==
X-Forwarded-Encrypted: i=1; AJvYcCVI0SyNb6FFwqkjJQHEQGIaagO96mxorZPt/TJDhZ3DEzuUV9/sot2FaIvpV2pPdAN0uvUOIMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSRK342oZ5KMqLasARWC5y0mS/YfRyDtmkTIUrUsI7abusdyAO
	Llv6AlVhMS4cff0/A3gTLsFpXDq2xMxOw4GXy2eQ6zbTUkQl5B0TchpOzu9txkdzinkVfkZNkzf
	XrTJrIvQ8x5xfQYIrJkcqv2I6IW5UgDk=
X-Gm-Gg: AY/fxX4SrV3jNz2UWyIIQLswHz7+5cyV4gY45CavvzYD2QzRpbDwXgJ6O2rbvqgSJHB
	aGlv4Ep92aIJY7tNzOm6A6Y93x5b8kmaVgDarK2ghWUgmPyJ9xonZP3LliXt8F7A5dnwKH07IJv
	rbX2RWlfytrvliEREPyUnYkdAwpp0x6jEzeEldpHtr7Q8T4AQwSdgo2w5MZpi6wMJpM7y6HxcHM
	w5EAa09JyfVrey88RSrj4M32h5i4741YCPXG3Fgy0iB92l3JEF+DnRPUkeUFEAvSmNFTi2nMvSK
	vS5H1OJ+cW2Xx8rZHK3+Knle+FS9A3PZLjrOPg==
X-Received: by 2002:a17:907:980d:b0:b87:d826:8113 with SMTP id
 a640c23a62f3a-b87d8268b60mr100195566b.54.1768780022098; Sun, 18 Jan 2026
 15:47:02 -0800 (PST)
Received: from 860443694158 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 18 Jan 2026 18:47:01 -0500
Received: from 860443694158 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 18 Jan 2026 18:47:01 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: zynai.founder@gmail.com
Date: Sun, 18 Jan 2026 18:47:01 -0500
X-Gm-Features: AZwV_QgvnSRCr9U9GbrPqfghWNTFByROLEJHYlQeH1Na6GVQpzxShaCgo0MmOHg
Message-ID: <CAEnpc1YDO64c_iJEJ=Y5PmzT8t-yeG+BMK8BissNqRe2UqMJ=g@mail.gmail.com>
Subject: Streamlining Your Dentistry Practice with AI
To: gregkh@linuxfoundation.org, stable@vger.kernel.org, 
	patches@lists.linux.dev, info@morenofamilydentistry.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Moreno Family Dentistry Team,

As a dentist, I'm sure you're no stranger to the challenges of manual
patient scheduling and follow-ups. The constant influx of new patients
can be overwhelming, taking up valuable time that could be spent on
patient care.

At ZynAI, we've helped numerous businesses in the healthcare industry
save 5-10 hours per week by implementing AI-powered automations for
tasks like lead handling and reporting. Our goal is to help you focus
on what matters most =E2=80=93 delivering exceptional care.

Would it be worth a quick conversation to explore how ZynAI can
support your team's efficiency?

Best regards, -ZynAI

