Return-Path: <stable+bounces-62585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D122793FA64
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 18:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C118283B2A
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 16:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0515915B14C;
	Mon, 29 Jul 2024 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CH7o+GN6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ABC80038;
	Mon, 29 Jul 2024 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269684; cv=none; b=Jb2eS0cDxs/pU4i0axYW4j8P9n45g2U3QSF4mYaV/PRIqSILV4pwIbRJY84gBVH8eSDI6q1oVTlYNCEoVnayi9j79CHU/K6jSCIT32kRU+/EFUrE1Fh99hstzbcklcYg2nsSQTS44aCc+NmsAH9l0V7g3ZBV1O9rXItsJrsl6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269684; c=relaxed/simple;
	bh=NCb9Ld2V+tyLAS+OJSGqh04B0fBxFGet5NP9pLw4hEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWtqLJQU+fCwBQMKM6fOjEHqJ9VcQDguwWke0hZaRRuODsMbnBf2oRlwV39eJf53bJmU6saKoQMucSpFHF2tAEML6auUN00ItQ9bZmIeY36+AvhqhzyTi8abMsWB6USCJhmXjURSUNCdy3USoKhr3EAj8wqRjq9vrjkvbiL0Z/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CH7o+GN6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3687f8fcab5so1438069f8f.3;
        Mon, 29 Jul 2024 09:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722269681; x=1722874481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCb9Ld2V+tyLAS+OJSGqh04B0fBxFGet5NP9pLw4hEo=;
        b=CH7o+GN6+nlfETXWUpRHJNUW8C2FCuq3tbWpnLiB2A/ImkDCgW52H49dxBZerzsL+l
         0rRekJ+5rXtVs6EilwF1x42PdelB2tJwN0y6d3rh0cN8b5CVZO7JQhiSumOBsI+BcJfw
         T9oyNkBzpPGpUS35tYJXHJK1MQyxeJDqqnQTynkg9Ac6GTmLH8VLnk9oPJpdsiAFT9Hk
         HRSzVjafMzviQpN2Va/zpPOX4ORbFwVfY9ZW9vWTiJicE4+6qbGDVywTV3whomgEJ2QJ
         v6p7K2frGLIepaWbd7I3ax5+BaRpxLNnb08aiBiDlxyLo4df+JDkHDxuCsaSsuz3FsgN
         yb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722269681; x=1722874481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCb9Ld2V+tyLAS+OJSGqh04B0fBxFGet5NP9pLw4hEo=;
        b=i+Es2B1yUw/5gqy5LdU0tsEUTQqoRHQQvXc3xXvA3AzVk+K6mZYf3BStNOEvXglgdX
         JKYH23jOY9RAZYR71b8DOPXxUlFlQdi9hEj0zfXcKQihFLawz3401gQ1kTaBSMf9BPBS
         27/n0Lv6IRY3M5GcgH569AYqjDCHfIRMTjpFusE3dqRmAFhzwBJifl5R22/UTkIt13T6
         ilINMVuOzpM6Fud+fonEHEB6I78JPAhyXCrEgNpE1bbYFc2jc1MC2grJbPeyQ6EdfgXa
         0aRIQ/JR1Rtjw7ClBSMNa6ENqCnl4l18d28b7ff+cTKU+qgymqG6vpFPdz3kv4+1dbCB
         xTqA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ5u38FxI3NrE9nUTx9KxnpGxIfF9mAhQNHi0Wj/AoHnyGJmMpGJ+zKoZQ8igOvMLVu5XnaBtO9X1l9WpKOw3Ao1L0l/x+kjoTKkCOYLbyLmPk86RXzHWeWOkgCaO4+RQA/qUlhWSWClDFf1KYU4DXfZERb0rjc8uP7Vil6yP1
X-Gm-Message-State: AOJu0YzCVJcXmbs2Gga3Kytve0LkqkzgXlbbEe19Z4ELJHmrYX1wjdWY
	luIhVtFxbXti5+L1IrCI899q4gFAXDW6fZf7/cpFv++sHA/OLIGdnCkcaHnw9Q40nsVxF85AbT0
	NiCN7P7lu95pDUGPGYaXgQCQ94SQ=
X-Google-Smtp-Source: AGHT+IH0iUHS+mfnOnQclj0rSTTnv/QTU5hLTWKAlViB+oUnmnavFRQv/N6b7puMEHLT0xEpDzIQ2UGOCU3CC/vmOZM=
X-Received: by 2002:a5d:64c5:0:b0:368:7f4f:9ead with SMTP id
 ffacd0b85a97d-36b5cecf32amr6545711f8f.7.1722269681301; Mon, 29 Jul 2024
 09:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729022316.92219-1-andrey.konovalov@linux.dev> <baae33f5602d8bcd38b48cd6ea4617c8e17d8650.camel@sylv.io>
In-Reply-To: <baae33f5602d8bcd38b48cd6ea4617c8e17d8650.camel@sylv.io>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 29 Jul 2024 18:14:30 +0200
Message-ID: <CA+fCnZcWvtnTrST3PrORdPwmo0m2rrE+S-hWD74ZU_4RD6mSPA@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: dummy_hcd: execute hrtimer callback in
 softirq context
To: Marcello Sylvester Bauer <sylv@sylv.io>
Cc: andrey.konovalov@linux.dev, Alan Stern <stern@rowland.harvard.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Aleksandr Nogikh <nogikh@google.com>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com, 
	syzbot+17ca2339e34a1d863aad@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 10:26=E2=80=AFAM Marcello Sylvester Bauer <sylv@syl=
v.io> wrote:
>
> Hi Andrey,

Hi Marcello,

> Thanks for investigating and finding the cause of this problem. I have
> already submitted an identical patch to change the hrtimer to softirq:
> https://lkml.org/lkml/2024/6/26/969

Ah, I missed that, that's great!

> However, your commit messages contain more useful information about the
> problem at hand. So I'm happy to drop my patch in favor of yours.

That's very considerate, thank you. I'll leave this up to Greg - I
don't mind using either patch.

> Btw, the same problem has also been reported by the intel kernel test
> robot. So we should add additional tags to mark this patch as the fix.
>
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes:
> https://lore.kernel.org/oe-lkp/202406141323.413a90d2-lkp@intel.com
> Acked-by: Marcello Sylvester Bauer <sylv@sylv.io>

Let's also add the syzbot reports mentioned in your patch:

Reported-by: syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3Dc793a7eca38803212c61
Reported-by: syzbot+1e6e0b916b211bee1bd6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D1e6e0b916b211bee1bd6

And I also found one more:

Reported-by: syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3Dedd9fe0d3a65b14588d5

Thank you!

