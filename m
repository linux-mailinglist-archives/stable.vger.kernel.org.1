Return-Path: <stable+bounces-200167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23869CA8094
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 15:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FF973135628
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 13:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33900331A5D;
	Fri,  5 Dec 2025 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dW3lhkFT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17585227E82
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764942897; cv=none; b=KmzI8I2KAAGhbpUA8yaVHHou19JbfJU/+s+IMyhVtPOgUTuQJY8cjF6FAMxJ2wCVcr890zfnLgH1uKZtsyJhDp7mKg5iqVGKeNvxwB+aNzVzUJRoXceCTGM0G4jWqEd8r0e6J1YayVqe9a7EdBXHO2nTdUGjqdmveEzM9qBFax4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764942897; c=relaxed/simple;
	bh=XqA0GadxzNDdiyG36a0fVSlW+wUaJcQziD5Q44Wd8q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLR/Hg3GzXrssIpNkU8UQfRUlsgBjl6muWf0ipg1haYel5Xqay7CZjkkDNRpBFu9XyJMNRQNponmtU7TsoaA1U93RbWvvBLnI9k8LVYTfDUT6kV1lhwSUIqLTuL8xDhKoN5SnoNg09HhHkKmbnVxGGIWiZw0B+aeTi4VkF5ZOw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dW3lhkFT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42e2e671521so1399163f8f.1
        for <stable@vger.kernel.org>; Fri, 05 Dec 2025 05:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764942893; x=1765547693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqA0GadxzNDdiyG36a0fVSlW+wUaJcQziD5Q44Wd8q0=;
        b=dW3lhkFTnDjwZukJdoSQpWIonUxUCv6Dc/RKQGP8C7f9ziLhKUdc+8jp4A6vATA6IG
         TXAEzQK753dwTGknwu1ADyfq9Z8GIah1HiLJNybqj7RByJcimMq6FgpZ/aH042vrfQaO
         E55wWgY7ZSeID62zzMu5N5Jip7pAeiKZVB5YjMlDdO9kpIGu5pI2566sfUgEpg16aZ01
         ny+u5BLOKcCZzULEfUXg89hbFDBfsax9/oAJxdR+PLKV8azHG5jcuiPd2QUCSZEwVKkr
         s8MB1G7s6UvWpgBIwSt+HTKK/ECzX3yVoUtETQr4EyxX1Yii/ye6Gcer4sZmTyQvRmKl
         9iEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764942893; x=1765547693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XqA0GadxzNDdiyG36a0fVSlW+wUaJcQziD5Q44Wd8q0=;
        b=YVbpl41hW8h9O6f9m/+zMK1lmqBUOa0D9Hr1PqfZP1W1AytluBOuU1yt8faJUNS/YJ
         5is65CCIXlUnxtcYQDyb6weFX8F22atT7lPhU/nA+fXoUTVDh8oKJ44baynpQMFNR2Ch
         88Wnk2tYJeY/jDnvlsN3VmBB+x4PpYbxHNf9ffV1R6svNhy8PtYaw+KeciXUU6PZmULx
         YzuhpPV3NN02T/L5k3B6lo2fgx/5aZO9dfijoj/7xXzvoRqn55q2LTol51hvz7idHv5x
         8d5kI52kV5HnDwnkUTQZa0D3ZNrD3zAHsgB/SoHu/SxKHYW2axqPiy/j9ITiXuKSYsBK
         fscQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEDFyT8Bx4pLAxH89lQMZWjfkgyFrUEtUzGtQ1VA3OA1LbJr01AoHSDTJj7z2VC0esqh+F30Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUsjipOFmLWk2u5K4leXyA+xoublZrlj8u0UgS+fFmAvq5QvYj
	FxvixjRvEy6t3y3Fbs0NP/JsmExu856vPO/oENIQdcpIv75i4IFONjU6vGaZEGtxkssBSG+9fRV
	OfVjrJO5BJM5WoomPyomwLGOEiVBM548=
X-Gm-Gg: ASbGncte/VRm3+LM7YZGycbwM7jUDo7sGAexuC3BMo6KAfyHtk4qivnt3V6kY1iMSyP
	yB1i2agCjg9XFDQEmKuxTrgRhk7F4IIOpuari/kakyn1u2gKEdxorkjkK6R6ZYM85WJcLkKbkyu
	YjnXu1HG69deWm6qG2qNaa30LWUGUtbbOcHmk9iRLxbkd1mS3+UMju4V7unfZf5teidy5SyyPi7
	ETkgnyh5Dm+JwIFVnGpupticDt69F9kZDDZrwyEcjByA15OYX2WHOHhmXNIiOrzvXp+gPYcRGye
	NtXdWw1grbehpc1pET+d6U6TJK1Ujl7Qdw==
X-Google-Smtp-Source: AGHT+IFKSWTL3hPVglpUiyvk1EerA9GEspZ+MoPANPg5V4fZMvViVoVP2v1WgBqbthmdzniP274hp3CHzGJhnxBcszg=
X-Received: by 2002:a05:6000:430a:b0:42b:32a0:3490 with SMTP id
 ffacd0b85a97d-42f7985ea53mr7266209f8f.49.1764942892496; Fri, 05 Dec 2025
 05:54:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1764874575.git.m.wieczorretman@pm.me> <873821114a9f722ffb5d6702b94782e902883fdf.1764874575.git.m.wieczorretman@pm.me>
 <CA+fCnZeuGdKSEm11oGT6FS71_vGq1vjq-xY36kxVdFvwmag2ZQ@mail.gmail.com>
 <20251204192237.0d7a07c9961843503c08ebab@linux-foundation.org>
 <CA+fCnZfBqNKAkwKmdu7YAPWjPDWY=wRkUiWuYjEzK4_tNhSGFA@mail.gmail.com> <qg2tmzw5me43idoal3egqtr5i6rdizhxsaybtsesahec3lrrus@3ccq3qtarfyj>
In-Reply-To: <qg2tmzw5me43idoal3egqtr5i6rdizhxsaybtsesahec3lrrus@3ccq3qtarfyj>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 5 Dec 2025 14:54:40 +0100
X-Gm-Features: AQt7F2o1xS0hHM8DgwvkRj9a0T3Q-4e4zvUroh1u1jgGrLZaZp4ZkwOF-iWjFVM
Message-ID: <CA+fCnZdHU=0EL2nedasTCRUjo45RHg-U=0JTe6VrAiG=90cm4A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] kasan: Unpoison vms[area] addresses with a common tag
To: =?UTF-8?Q?Maciej_Wiecz=C3=B3r=2DRetman?= <m.wieczorretman@pm.me>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Marco Elver <elver@google.com>, jiayuan.chen@linux.dev, 
	stable@vger.kernel.org, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 8:55=E2=80=AFAM Maciej Wiecz=C3=B3r-Retman
<m.wieczorretman@pm.me> wrote:
>
> Thanks for checking the patches out, do you want me to send v4 with this
> correction or is it redundant now that Andrew already wrote it?

Either way is fine with me, thanks!

