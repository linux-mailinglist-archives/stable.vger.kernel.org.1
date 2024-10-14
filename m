Return-Path: <stable+bounces-83724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F3F99BF51
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 07:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8331C21529
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 05:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDF74F20C;
	Mon, 14 Oct 2024 05:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cNQRk0kj"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CD44C7E
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 05:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728883082; cv=none; b=KAoqYXsMOsDNzTVZmdB5VUh1yDX8rJA0WYbS1V5MX9hXYaDWXVH0PJfXgGakJyvYogUDrNDC+uvkiZLIzI5Axb8O23G0yVhCc1PDTOme4xwWRo6DrDB6OlckGNIZ2nsdP1v+5treZt5Rb3kcfosxZBhxO20uJ6sfy+7mNEFqriI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728883082; c=relaxed/simple;
	bh=dBXNFah00QnG2qYNzAu4gkeZhXocfmsU1zzXZjTcd1Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aytH8Ozdh/A5M8Kaw1/a5Nv/z6ZyMSsgJCVP6yv23ir9Prwk4J442ha2d72QqnyMb8fjUU9GeFxn3hMgWqRRnOtwBI/+FV8pTQ2QmdF0rXRCiliSNNd8W1b3tXxNs7nyUAldMOMzQzno6ixNeB8ihu3O7zjsWOtwdvwcN6zWs+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cNQRk0kj; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-288a5765bb9so34887fac.3
        for <stable@vger.kernel.org>; Sun, 13 Oct 2024 22:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728883080; x=1729487880; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pZqdnd/M8grsLw0V7qaa3EKv94X/atMg+zy+8M6cuA0=;
        b=cNQRk0kjDJSvkFnS3CYzAHY41wlFm50efxiQ6IJgZxx8gHvDpsimxZe0g2yTXTyDag
         +Adg6sUYiEnTncUk06qONxu5X4GQsncBmKTtUmKLvIgL0TBy16jYbptAEsDRzWz4zkF7
         mbvxGhqftGQL2SSMr6xdFssL8Q+hlunTRi/Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728883080; x=1729487880;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZqdnd/M8grsLw0V7qaa3EKv94X/atMg+zy+8M6cuA0=;
        b=n4eb/4cSJB7rGTZVCcYZh4CYXTPx8XCkjzNVYPknHUx+B0yFZJY4h3HhWiY3aOOlZh
         UM365iAoCLdl1891DdQg1qd/CD56RgouZGASc/RLuxbBtv3DL1lBtTpU3LluyH9JoAhB
         O6ICMUXwuCYKyQAEIhRKo9zHISHbnuGSdnlJKPFDh3MqbgIBXWOAjaVdB4kr4A6Nxdbt
         X6VNZjN1jZOkFqxOY+6nHc9NS5KSbt8N5zuD/NFbeRsVp76TI7+Ynl0qVHJD8frV+3Me
         YzjL59YxELYoHhJhKITZfHEbf5wJIRt0sTODEW+U87VHXWvpzGQJqv7yEPVPNdOjA0tv
         PB/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8wJwS5b3tyqo/g/8TwEcQ26IlLhmHB7/2wXarue0VCNnAT0oUlBAWIpshehKlnWBK9/gtePs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWz1pRDFs1fRD5UHOln0Fp50SLR+EQ00iyp5lQxikr3QenJ0oi
	Xfhc6JMbrNVo3xxXuVapOBmOrZVc5uAIODIVp3YFvI+UwuqUl+vj+uO/y5ToI6aSy/96hE5Uyuc
	meM+xfphKnQjwKCgE58WnrCYjFyvaBRPnkqEZ
X-Google-Smtp-Source: AGHT+IHp32OrZHVC+V1P/Lyygpq7x+P4mmHKkb6tWf7cYUk8+LdloiAZzfuJI9YzoNUF0vpLquz31PwuC8QR8w+722s=
X-Received: by 2002:a05:6870:51e:b0:285:82b3:6313 with SMTP id
 586e51a60fabf-2886de506camr1892001fac.6.1728883079880; Sun, 13 Oct 2024
 22:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jeff Xu <jeffxu@chromium.org>
Date: Sun, 13 Oct 2024 22:17:48 -0700
Message-ID: <CABi2SkW0Q8zAkmVg8qz9WV+Fkjft4stO67ajx0Gos82Sc4vjhg@mail.gmail.com>
Subject: backport mseal and mseal_test to 6.10
To: Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Pedro Falcato <pedro.falcato@gmail.com>, stable@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Oleg Nesterov <oleg@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

How are you?

What is the process to backport Pedro's recent mseal fixes to 6.10 ?

Specifically those 5 commits:

67203f3f2a63d429272f0c80451e5fcc469fdb46
    selftests/mm: add mseal test for no-discard madvise

4d1b3416659be70a2251b494e85e25978de06519
    mm: move can_modify_vma to mm/vma.h

 4a2dd02b09160ee43f96c759fafa7b56dfc33816
  mm/mprotect: replace can_modify_mm with can_modify_vma

23c57d1fa2b9530e38f7964b4e457fed5a7a0ae8
      mseal: replace can_modify_mm_madv with a vma variant

f28bdd1b17ec187eaa34845814afaaff99832762
   selftests/mm: add more mseal traversal tests

There will be merge conflicts, I  can backport them to 5.10 and test
to help the backporting process.

Those 5 fixes are needed for two reasons: maintain the consistency of
mseal's semantics across releases, and for ease of backporting future
fixes.

PS: There are also three other commits for munmap and remap (see below),
 they have dependency on Michael Ellerman's  arch_unmap() patch [1] and maybe
uprobe change [2]. If Michael and Oleg are OK with backporting their
patches, then great !
Otherwise, since those commits below don't change mseal's semantics, I
think it is OK to just backport above 5 patches.

df2a7df9a9aa32c3df227de346693e6e802c8591
     mm/munmap: replace can_modify_mm with can_modify_vma
38075679b5f157eeacd46c900e9cfc684bdbc167
   mm/mremap: replace can_modify_mm with can_modify_vma
5b3db2b812a1f86dfab587324d198a5d10c7a5cf
   mm: remove can_modify_mm()

[1] https://lore.kernel.org/all/20240812082605.743814-1-mpe@ellerman.id.au/
[2] https://lore.kernel.org/all/20240911131320.GA3448@redhat.com/

Thanks!
-Jeff

