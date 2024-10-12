Return-Path: <stable+bounces-83606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2358C99B7AE
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 01:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3661C20ED6
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 23:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A551474A4;
	Sat, 12 Oct 2024 23:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xonZenvJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BB113D897
	for <stable@vger.kernel.org>; Sat, 12 Oct 2024 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728775372; cv=none; b=oBizYOskxg6uyKgXKZUu+WQA7hEJNJJI5Q+Y34xxQzz8tnO24th/VvjIyv9KIwcP3hulmWr+7ITwCRh1bj1veruiQUT9VY8NV/pCdgZWVMqb/lGabANUr3a2fmBoLgyKtbzq+ITddBEfyoV6nz9mTsWT1XQNb2ZYAKfRb9ktngs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728775372; c=relaxed/simple;
	bh=dZ2kWqDZeO92k4C9sR7En7LEnIxxx84BNgPdeCGB9yE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CtxPVflpfaPLFm1WSHA/p8gjobNwCaNXYptxCPhfRih87BelE80Pc577H9lXjLH4aAs0D694kMV2W5Zy2iFT6j1J7/sv+mmxpn5kz+oDAz/G7XOEC0w2YI0KHciy7zZ/1dU3R+EltVvzLmxNXb/CKl7ApH2bvU66raC6iUmK2RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xonZenvJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-690404fd230so62694037b3.3
        for <stable@vger.kernel.org>; Sat, 12 Oct 2024 16:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728775369; x=1729380169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qO0fNi/dBWB7Rgb+vFJf5SFKBufk+k/SaxINE1J9P7g=;
        b=xonZenvJxrLpe1IFt+eZhg/7hF+i/8CeeIIRL8W9gowtSenh6NY0RdFJgzCXo2j60q
         H7AJdMUwDTGwjVefhRgv1utP0nmOu/HxWEawuVqdGbCzPwQtwwGs/0OQaqXmV8FWuhb+
         5TVhDVKztyXRgTpeFqZFwhUnvkYUzKnybDSLK/reOcNC7AcmW7CVJyD/I4eZwjfRADb1
         J7weG/tvIl/SK4Rbf5szCh18aJ1YLeYzh39vO2erSIlwwAFpc2jyQQGMsT9g6RBwNQvv
         DDSzp2MQKy0CCGsICSn74JtAcLzI7g7rii9Mdui4fPCxY2Xhl0ef3Oq59ZlvTRkhV6mD
         JiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728775369; x=1729380169;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qO0fNi/dBWB7Rgb+vFJf5SFKBufk+k/SaxINE1J9P7g=;
        b=q83yTIatupCSoCu4iHmRRGHQiqj0du7ZT/DUU9Na7xPpKYdlYwvRzT20fJji6vKCIg
         dHuHjjC17JwkggALnwswVJghvj3Seg9IA8iYmC0IxGXDGoxCcZWpTaUcrx1t9nxGlBgj
         WY3uwDj04Clofha7Sjdgz53oJLv/7gZpgLcruYhrg3uqIoj6YpK/n6GuJledTOaLLMxC
         qgIMC08wT2lFQL3o59Muu0AYWIhdFfK5rMbBZT4qNYubyVTujyTyYgRHzE0yXdpyZgf6
         0j9cum0/6XEbQtu247hdglE0IBNttrJQcybY/qUcGHCVL3ekoEtc1rQUhL7Vjb2sCZ86
         gLWQ==
X-Gm-Message-State: AOJu0YxRbXJRGkopBcF6WGm6gIIMmEAw3GFfRk0p/xa7n/6lNzVH6zbQ
	yFcJKEAqKPVKOLZnCf2m8xUmkJbqyZJHGEOy+y71+UzXExiqOmY70CAwplsJrlbB/g65HY7hd63
	dexBteXWqdEPAhp/DLzOrleY1Rm0qs1GS0SMCTQeFyjgQC8FKWjrkSrc8Q4bIPmtAJIptOgkXbQ
	duVrWmNTmdr7/3Uo8YAhOzBZQvju9R0SzYgmjYMlLK5LU=
X-Google-Smtp-Source: AGHT+IF1XVOOeIsdbeadI6XZc+vI1iDCvPMN4Zygb8Oxt7iSzdYf8pOJ2X9VetqFd4CgkpQfNuIqAXljJiFBUw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:690c:6012:b0:6e3:8cf8:7b7 with SMTP
 id 00721157ae682-6e38cf80813mr36437b3.8.1728775368987; Sat, 12 Oct 2024
 16:22:48 -0700 (PDT)
Date: Sat, 12 Oct 2024 23:22:40 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241012232244.2768048-1-cmllamas@google.com>
Subject: [PATCH 5.4.y 0/4] lockdep: deadlock fix and dependencies
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org, boqun.feng@gmail.com, bvanassche@acm.org, 
	cmllamas@google.com, gregkh@linuxfoundation.org, longman@redhat.com, 
	paulmck@kernel.org, xuewen.yan@unisoc.com, zhiguo.niu@unisoc.com, 
	kernel-team@android.com, penguin-kernel@i-love.sakura.ne.jp, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patchset adds the dependencies to apply commit a6f88ac32c6e
("lockdep: fix deadlock issue between lockdep and rcu") to the
5.4-stable tree. See the "FAILED" report at [1].

Note the dependencies actually fix a UAF and a bad recursion pattern.
Thus it makes sense to also backport them.

[1] https://lore.kernel.org/all/2024100226-unselfish-triangle-e5eb@gregkh/

Peter Zijlstra (2):
  locking/lockdep: Fix bad recursion pattern
  locking/lockdep: Rework lockdep_lock

Waiman Long (1):
  locking/lockdep: Avoid potential access of invalid memory in
    lock_class

Zhiguo Niu (1):
  lockdep: fix deadlock issue between lockdep and rcu

 kernel/locking/lockdep.c | 215 +++++++++++++++++++++++----------------
 1 file changed, 125 insertions(+), 90 deletions(-)

-- 
2.47.0.rc1.288.g06298d1525-goog


