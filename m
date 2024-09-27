Return-Path: <stable+bounces-78110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B09988627
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 15:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25FC1C222CD
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 13:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F409461;
	Fri, 27 Sep 2024 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+d+qCBs"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330414C98
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727443221; cv=none; b=a9a8QyCLGXbGxIs/ECFNdM/HnyqWUkDjwHyHYNZAxscpbwWKQmDpBT593xLvgZWm62jTXvhVOu5VHZP/sj5r/ere3sRAYkujFTbr+N+eH7s4cAE06RHKX8fz5xD6x+NRdXbNrCwBbPnRBAEutvYc4zo/xdQAB3NayW5RAV0PuPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727443221; c=relaxed/simple;
	bh=XLEq1M/49fUMTjfhqFfpf7ALhKCShm0WYNc+42j6yLw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=U0qAodK4y2NK4RpMKrKzjs9W40XXby56llz2fsdhLioKrXeUQndjQfh2heW2SoboVR6NZzUzE8jFD+CgaOr/h/VT+zNoVwWokQ94nazkcTY2HA1DjJdrrg70ghD7RzZF2u+3qwU7vXCE0tKT2vDzevzd1iYcQb+5+xWVTV8r7dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+d+qCBs; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f75c0b78fbso23902361fa.1
        for <stable@vger.kernel.org>; Fri, 27 Sep 2024 06:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727443218; x=1728048018; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FDLCOPi5QpNo5CUL/g9mtdJyv1l5jh4HEp5d5eTLWQQ=;
        b=J+d+qCBsIYyiUJahDFP5GOw4FRZItFb9tj9c2+qkDtvXs63wVd2bNxjKjQfv5BdYBV
         0gvAtI9rsNPDIcnemH+R8HFZzdKksyZaax1pmuv0TRA2L0jxXL2umpQBkpmN0cifHiPc
         WEutdZI1yT5CMQtJkOk9hri/ryUQ5ZzNU8ivyro4UY7JbhX0cNx96nLpze5AKCMONNTR
         SJCwoRgTC5Vcm5RlaTzk1u7XhLUTyGWflyhi5X8D77TLi4A/5gh/eYutAhXASEDIIdcI
         fy3/zAfath9eBZFECoTiVXWRMHrsZ7Za3xH+hZGE7GfGVYjVM8LTc7sS/PxeLJHnKuM0
         gn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727443218; x=1728048018;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FDLCOPi5QpNo5CUL/g9mtdJyv1l5jh4HEp5d5eTLWQQ=;
        b=jvfJT6QuycWFhZ5EMsdH9yZsQM9r8gmh+2ax7gOoAjbZ8FQI6U7Fn64biNsv9vyEOT
         uW1F4Fjm2iRwKwjjVcIOhqCkuBPw55MMU2CkqmdpkKA889xd9vv8vjxX4v5iS2tlPPFC
         QNBgCkzjbuohZr5K2BWD1uu5cDYLl+Nf6RNqm0aRZKM532LtQvT07gNVqC1sjyTdhtGV
         fe262umY1c+OeQ24lbaLKdZL4aA98vBRd9DGzHLGGf3ko17kQNNeSBmWdMKtmty6i4QZ
         N/OJVZbc0Hr/URxITv7QmisK3fZzX+K3ygCbGqX07xYtR7kr1/z1gK1p9S17n3OYyXZl
         csUA==
X-Gm-Message-State: AOJu0Yxo/JrLL73ttFKGz5L48GRIkgxSuLGOg9A6SW1tj3uSzM4D1I8y
	p5GHt5772Q/EVv16r/9sUS+ix1UUvJgm8+/DGsg+6jF9//0e4bBoO944vnoGktE7yHC020llAWM
	/i9IPYWi1RsKWQV2CKjAveeJuuXhAV6Df
X-Google-Smtp-Source: AGHT+IEUHQwZRK7jrAp9Ut+mkqO3YlI8KASsn2Gfd6yMLa0Dxv5U5m/LgKll+4N2LhE3PMxqHzUwm/udd+k9TeVx/+A=
X-Received: by 2002:a2e:a541:0:b0:2f7:cba9:6098 with SMTP id
 38308e7fff4ca-2f9d3e78d0bmr23175501fa.19.1727443217855; Fri, 27 Sep 2024
 06:20:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sim Brahmi <sh4224hs@gmail.com>
Date: Fri, 27 Sep 2024 15:20:06 +0200
Message-ID: <CAMZnB+fOn6YWNx5U8PYkF=wLgE-E4mcixJJQkysK=CM6JYbE7A@mail.gmail.com>
Subject: self-debug using ptrace bad behavior?
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

I am unsure if this is the 'correct' behavior for ptrace.

If you run ptrace_traceme followed by ptrace_attach, then the process
attaches its own parent to itself and cannot be attached by another
thing. The attach call errors out, but GDB does report something
attached to it.  I am unsure if Bash does this itself perhaps.

It's a bit hard for me to reason about because my debugging skills are
bad and trying 'strace' with bash -c ./thing, or just on the thing
itself gives -1 on both ptrace calls as strace attaches to it.
similarly with GDB. Unsure how to debug this.

https://gist.github.com/x64-elf-sh42/83393e319ad8280b8704fbe3f499e381
to compile simply:
gcc test.c -o thingy

This code works on my machine which is:
Linux 6.1.0-25-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.106-3
(2024-08-26) x86_64 GNU/Linux

GDB -p on the pid reports that another pid is attached and the
operation is illegal. That other pid is the bash shell that i spawned
this binary from (code in gist).

it's useful for anti-debugging, but it seems odd it will attach it's
parent to the process since that's not actually doing the attach call.
If anything i'd expect the pid attached to itself, rather than the
parent getting attached.

The first call to ptrace (traceme) gets return value 0. The second
call  (attach) gets return value -1. That does seem correct, but yet
there is something 'attached' when i try to use GDB.

If I only do the traceme call, it does not get attached by Bash, so it
looks totally like the 'attach' call has a side effect of attaching
the parent, rather than just only failing.


Kind regards,

~sh42

