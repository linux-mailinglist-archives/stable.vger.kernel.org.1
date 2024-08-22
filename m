Return-Path: <stable+bounces-69907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4E095BCF5
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 19:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C57B281692
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 17:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAB61CE6F9;
	Thu, 22 Aug 2024 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaLlGuGr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EEA1CE701
	for <stable@vger.kernel.org>; Thu, 22 Aug 2024 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347173; cv=none; b=jcnSbkT+eRoP2bIW/Go214gj2l6M7iUw6cF7at369rBIaXdp3kl2u1wwYap0OSxhXPCmmAl6ifdSTUQHDq1woIKlb+yJllK7piezemnyfaztImXmIU0HwtNiIY2bQcMw9vNoOpWkP05Oldi6BBfUZMCuJP0yP0vwZidcrbJS0dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347173; c=relaxed/simple;
	bh=BJjA9XBN7mCewDtkLp05+KNsAqPpHEmp1hrP0BUQajs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mjN79HqlEmEzcdWTPxv538QG0466gMkmG2oeWzYjRQEZLFQAofadR/dp+n9QDgqg4ju+NMi2TM/QO6iFBjt+0N4OkImFU7S6pX8hf31NEJoOa7eP0HLJrlHHgdZb4g7Ip/g0tWSMu0cQDSzwhTbjJlzq5hBmkx2i5u3dwwCqURU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaLlGuGr; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8696e9bd24so81897166b.0
        for <stable@vger.kernel.org>; Thu, 22 Aug 2024 10:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724347169; x=1724951969; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=34rVfFYOv2y3LSezYrphM0pmOukjA26qKhZaXpuAkwQ=;
        b=EaLlGuGrqyUeLfpnvqD+E7sMcrTCpIEUFuUAtnN1GmoCU0jDXtXusYtT10DSYqmipi
         qXW1GCWB5aPd30LGJLXKk6J7cal7g95BQw949B83UntfCwLZC6u3UdfdT1d7NDcM1Izy
         G895bv0aFvK5dB4Kcmbkep4c/38fH/qD7dGh9KKvmwlvvYb7UTWVEbyIzns3tgcCK0Sh
         yIyCrHpnFAOr3aNe6bkFh7Hil47CT9KTwbCU50G/P22L5XBpfsP8OocoVcmG+/+I9bud
         BpatMLFqbIlkUau9TSZ1Sx95iFVsyNbX1fjn0fg+TFPzXT1agZ6MrCmjbY7I+TAUUq9J
         pEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724347169; x=1724951969;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34rVfFYOv2y3LSezYrphM0pmOukjA26qKhZaXpuAkwQ=;
        b=LaSglzHvf5Ngievmfr5wZFmsI1bEgIsLZMxa6ZcfIqhRDiakOpvffZb5h0SdrHxhb6
         jF/igRWomkeTY3ZaX0CoBwMkFT+NzQoejorpx5rRxHGwx9otdFN20PtXRISuU7T8wKNY
         9cJwHmaC6KHeygWSSoG5XsmJ8c4ssCpbML+09nRFIsTVNCXrozG3rfbbkz7LU7mTXtJp
         DFuDW3XmfSkGPYRZQ3xmbKisPHZTL4FalYDbwdDl1HjL745rKmASqRrxhjPbjJqcjdgS
         SCm9wHjFUt8Yhp6CvC7wZ6HRgpCtH07JNz+p3KADBnRtQZiEyRb6kxLf5Ueb8H2isUpZ
         zyXQ==
X-Gm-Message-State: AOJu0YxgWpTKf6CThE00PFijF8emex7Ee1ty7+pSH8+G6pr+FBGVSiS1
	PbU2iOmzxxjnmSy1osMCk6jpFUuQsK0Gz19Aru/p1vgHVeMMrAA+VlFZZr/9
X-Google-Smtp-Source: AGHT+IHvRBRImVm60bFEBhl+XrxfrmB8txGIBc6s5TwhAyt4LW6liHayhVsMPQ/bOSqpanzuQscIIg==
X-Received: by 2002:a17:907:9406:b0:a7d:9f92:9107 with SMTP id a640c23a62f3a-a866f893f3bmr496606266b.58.1724347168681;
        Thu, 22 Aug 2024 10:19:28 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2a5771sm144194366b.76.2024.08.22.10.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 10:19:28 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 61316BE2EE7; Thu, 22 Aug 2024 19:19:27 +0200 (CEST)
Date: Thu, 22 Aug 2024 19:19:27 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: stable <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Aurelien Jarno <aurelien@aurel32.net>,
	David Laight <David.Laight@aculab.com>,
	Jiri Slaby <jirislaby@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Please apply commit 31e97d7c9ae3 ("media: solo6x10: replace max(a,
 min(b, c)) by clamp(b, a, c)") to 6.1.y
Message-ID: <ZsdzH-n9-9K8XYSx@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

While building 6.1.106 based verson for Debian I noticed that all
32bit architectures did fail to build:

https://buildd.debian.org/status/fetch.php?pkg=linux&arch=i386&ver=6.1.106-1&stamp=1724307428&raw=0

The problem is known as

https://lore.kernel.org/lkml/18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com/

This now affects as well 6.1.y as the commits 867046cc7027 ("minmax:
relax check to allow comparison between unsigned arguments and signed
constants") and 4ead534fba42 ("minmax: allow comparisons of 'int'
against 'unsigned char/short'") were backported to 6.1.106.

Thus, can you please pick as well 31e97d7c9ae3 ("media: solo6x10:
replace max(a, min(b, c)) by clamp(b, a, c)") for 6.1.y? 

Note I suspect it is required as well for 5.15.164 (as the commits
were backported there as well and 31e97d7c9ae3 now missing there).

Regards,
Salvatore

