Return-Path: <stable+bounces-35473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A698944A3
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 20:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60FAA282AB0
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9860E4DA10;
	Mon,  1 Apr 2024 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cjwutLYA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C643B4D9E9
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711994960; cv=none; b=Irbpwis2cdYK2szrAgN2ITp1nhc9KgC4kVP5HetI4BbE3OecE54CzFnqeVAgVcwvNq8e5ogfxtwGvrDelL9liRdRNXN7TKLpogDa2D8dbmTwl//dfERE5FPIrbhLOSLOBzv8SWEJCT/LrUzBBmhHX2U7NyR4c2UR7UeWDmnV/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711994960; c=relaxed/simple;
	bh=MAD7jJHWI1MerMNbJ6JZRM7zaekKeRr0QWLh6bJAjTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lc8TRpmkYMV931okHPE0VrIgQGxV+57VZVD222pkcXOJZCKRzrSNDx6kYlnxmEvLjiGVYSsi1wOS6sURBhztfPDcrK3Yw65CeoiXftzA/lZJ88OjMKax4Knsp2K+k1IJEFUlY0kdW1wUMBwYcdyBcVwJGgsfjkjfbQbuzFtHaig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cjwutLYA; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56c2cfdd728so32577a12.1
        for <stable@vger.kernel.org>; Mon, 01 Apr 2024 11:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711994957; x=1712599757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7blAwDmTdfJr9smEGLceVYD34Yfb3pZ98T9fM+sm3Tk=;
        b=cjwutLYABqYD4ZWBB8bVGRwzlPLQ0+6jFU/SGNCoqVoOar4Yc7CKafCZuJflAPvtPc
         cj7fgpkkguIpwfUqxft+EArHLXWwE5sMrzhAbpPoE/5DICE0iSJpxSE+iIjV6dDXhz8Q
         tjsPEG1vToSHY1fhLNqewMRQTkJ//C1CGlAcRLVt2aWM+o/mIXe4N/CjPl/YdD2tKK9n
         Gp+9QdJROwlJkJC9fQvoY+/mjKWSDx/4i/HM7nPDOhYsOIQ4a2WtDckIHHQ8489vCfjc
         /CRbGFWqsEB+YUSn7yCNANIHHBwPG/Dmcn/vft1R2M5hUJ6jBuAo/XeDgaMXKZOmAhiX
         kJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711994957; x=1712599757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7blAwDmTdfJr9smEGLceVYD34Yfb3pZ98T9fM+sm3Tk=;
        b=wyAokKLa2M51yJr98ufLwx2dodCWqLSgPwO9pTDWd4zkuU4lhmRmZUwlzik3J//oe2
         ZE6neL+pW+OB66Ye7ivvM3AsNF6iP6cgr+HTU4gLT6icob1J05B+BYOfvg7SWP5my5ig
         B2FGA2dKBg4sRbC8F+2luj1J1UWgah5BnAlt1yC/XacXJyj9rPSV7MAgs9gsVL6GacdW
         lJInMr/51zpKKzZUSD8mzoVzSr+2W/fenv9T72bJqcl5KsnNXBv8Jbg6oORb5o+od6EX
         Qw4Uq/+Zxq+4at2I5eYLzNP79LMmpNAzi0sAAy9LGjEI2kvF9EVOIiG8FFE1Lmj6i0fw
         D+0g==
X-Forwarded-Encrypted: i=1; AJvYcCULkFuJ0ZrPIZTlQ26GIe0K0jG+c3wGNnWvNCRLalGnKH2uCP7LSyni8/2ubJuXk95b3J7T+ZiQ1llxWAaAZa1i2CkR0KPF
X-Gm-Message-State: AOJu0YxMBvX59oqnDTrVxC/c3woU+9HTYxyEbG1bZC21Wyy2KkD22jRg
	/2pl3ZFZKoxeWpn3np7g1i6kX1BF+aDZSeCX/hKyTdyY9R7rot6jD6KL7nFLdSpWLwNdOI0aOBb
	vrYrOSxYoxj4saglxPssnxL/3ibnWdd66AMc=
X-Google-Smtp-Source: AGHT+IG2/zHmhuaWgpEEC3cFRpMQGKtUj0uChASMxkuVmiuVsJRQdYFlkj9c41h+OAQwcYRF4wKCrUrblsSP2ydqvdw=
X-Received: by 2002:aa7:d784:0:b0:56c:cd5:6e42 with SMTP id
 s4-20020aa7d784000000b0056c0cd56e42mr571560edq.6.1711994956987; Mon, 01 Apr
 2024 11:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328062757.29803-1-mingyang.cui@horizon.ai> <073e5bf0-99c4-4dc5-8894-5442e2d53a34@126.com>
In-Reply-To: <073e5bf0-99c4-4dc5-8894-5442e2d53a34@126.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 1 Apr 2024 11:09:04 -0700
Message-ID: <CANDhNCoBh778bVOSdEtNTDQdw3rt6-zjnLFiiyYR6PZUrhOfew@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix forked task check in vruntime_normalized
To: Honglei Wang <jameshongleiwang@126.com>
Cc: "mingyang.cui" <mingyang.cui@horizon.ai>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, stable@vger.kernel.org, 
	tkjos@google.com, pjt@google.com, quentin.perret@arm.com, 
	Patrick.Bellasi@arm.com, Chris.Redpath@arm.com, Morten.Rasmussen@arm.com, 
	joaodias@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 8:20=E2=80=AFAM Honglei Wang <jameshongleiwang@126.c=
om> wrote:
> On 2024/3/28 14:27, mingyang.cui wrote:
> > When rt_mutex_setprio changes a task's scheduling class to RT,
> > sometimes the task's vruntime is not updated correctly upon
> > return to the fair class.
> > Specifically, the following is being observed:
> > - task has just been created and running for a short time
> > - task sleep while still in the fair class
> > - task is boosted to RT via rt_mutex_setprio, which changes
> >    the task to RT and calls check_class_changed.
> > - check_class_changed leads to detach_task_cfs_rq, at which point
> >    the vruntime_normalized check sees that the task's sum_exec_runtime
> >    is zero, which results in skipping the subtraction of the
> >    rq's min_vruntime from the task's vruntime
>
> Did you do the test on the latest tree? vruntime_normalized was removed
> by e8f331bcc2 (sched/smp: Use lag to simplify cross-runqueue placement).

Indeed (I was looking at an older tree last week and missed it was
removed as well). Though something like this change probably will be
needed for the -stable trees?

thanks
-john

