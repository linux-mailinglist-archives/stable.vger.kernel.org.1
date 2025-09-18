Return-Path: <stable+bounces-180469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08882B82A36
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 04:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8E0E4E1EE0
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 02:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C95221294;
	Thu, 18 Sep 2025 02:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwStEsb8"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9C3223708
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 02:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758162100; cv=none; b=dqG7Ybmsl15oci26xFaGVkL0F5o0Lle87Nr9ig8ciTtwlzD2lvpsAYBpSoqSAiawSXVyUG6efVpG49Q0KFFrjoiXi0kjpMgdGJrtFYRcLUXgKK70LNsd34iBBYyMT/Kam1HDlJuhyJo20wrNWP92RumGERTXI0ofFiw6cZm1pp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758162100; c=relaxed/simple;
	bh=ebWucFsXDWMzdyZC6AqBlwW00MZe0MYweojXX8TIBP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPqER7mhvnZxLqQGrBWa9PnsF99WvA0M6DUOzNuw5h3vwtRCcCaUHabdn2ALfzCjChXf91FMTK9IsbyRlV2BnL8W+s7Utd9JQJ91QHGY/cKInaozGGEZf/WUutS/3d87uVwP/E6A7H9822DNU+77nOGnjfueS3HDnXBMXv4hN+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwStEsb8; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-43d2da52291so692298b6e.1
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 19:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758162098; x=1758766898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2TqJf5AbRGlHKv2lbhFK/JOV0pCd+aUBT6OgPSYYCY=;
        b=cwStEsb8UmY/CuXg0YDYhy4nRw4jFXIjVAgSBbkbP4JYEqX/DqLvG08+c/I+1zVJH9
         QPuJQpZr0E4zLWfPRoj44Unsuxdd9LOJ9xNOXHyrdjLmXWkhXY1Z+eqlp7n4fmQbnUYa
         wfsNoFcaamvpQFmsfO3V8h8ui6t75fB0L9JcM/RvLEmf2CSVu3vAD7FA1d7RcKxBcDSc
         N+ZO3tDVxZZ5NweLwdWPwAtYkuL2ukUNQ8H11Uqkaj+XzN/oCqkeHVMkL9pFSHRPuKMQ
         qdUeVDFZi1DxBv8W6VdC/sXdlJOjLqyFM3o/OjT/d/e2tXIntQhbpqMQWtaqkQ+/p3Px
         pNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758162098; x=1758766898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2TqJf5AbRGlHKv2lbhFK/JOV0pCd+aUBT6OgPSYYCY=;
        b=DLgqV7M3d2Tt08dVPU5uGGohkkIMXIWFntxbnvwr7oPi/gcH4fSLGpU2GQNcVTO27r
         7JWHbucqd8T9S+uF7En91apYMVfRR4SUYqmwhDz3M63jgr5+r4PY/D2/JzoIJ8dQRBf4
         2IBJ1ozlqt6Mu6TDV6zPLya+qfzENxV0PO6B7hPrM5aW56EcetEGMlEq28twupiorvXh
         skJHq1r8Egvgf51Ln42D522/VZ6cfKPfAyjHCIz5vQjckotAdT8VL0WEBroPMQf/ZjGo
         C0oUcrzJ/c0Cot5oxBX2ocibt6JpQvW+G/5Ju/EXzbCiIA7McnkT0x+n8B/q3cSm7EOM
         ILAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMjDQPZBXkFnnQw7rnK3knm4+0exHTHurgvZaB9n7XlUjs944u+LQJxafPUhEBSHhXU9zzjs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIZpAbA+bhjVk21LJD1123XprUaPFHtNd9BsHElfftBsvZyNAS
	JiXeBSTx4UQFudAV+E3UPT/hWZlG4geOVqSpp+xVq2Rl6ip5e+5hIPfYFEUGveAdwjzDItU5cof
	NXe6nKNqcDhIj3rTTs/J5U2F2774dlzw=
X-Gm-Gg: ASbGnctIY4+atogkqyWgjwxGTX8EkWN+KjiYi3lPQpVWx8niePKIHa63zfNZt0qcmEF
	9JjS2yOv+EmvIOPxUMG1HJLTJxvzGXiAW61aX6U04/9875zD8YH7ZBurRMv7dIod3DV6dhFJrdc
	naTnL5CaAj4nAXTWbVB4ca/hdiHNqTdkXB3wlFkCh0cn6hFXDMXRxHre2yQ6QQCXkaD34KPSrem
	/aXHzt14yj8kQ5mLPNUbe3a1QkKkzaVOXhI
X-Google-Smtp-Source: AGHT+IFiyC+IjhAbMWMow6p7uPNgXnstsaivtCdHNqfRscvhsSN/dyt0pD/3gEu1tlnG4bR/2rk2mlKMQTKp049LQN0=
X-Received: by 2002:a05:6808:17a6:b0:43d:1e76:2986 with SMTP id
 5614622812f47-43d5b47b3dfmr920609b6e.12.1758162098180; Wed, 17 Sep 2025
 19:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917100657.1535424-1-hanguidong02@gmail.com> <a321729d-f8a1-4901-ae9d-f08339b5093b@linux.dev>
In-Reply-To: <a321729d-f8a1-4901-ae9d-f08339b5093b@linux.dev>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Thu, 18 Sep 2025 10:21:30 +0800
X-Gm-Features: AS18NWDqJzoh_yFV7HHAEDZyUJiKc_hQLSWoj6UQ7QcKaPVU1R5EfBncWXG4_6E
Message-ID: <CALbr=LZFZP3ioRmRx1T4Xm=LpPXRsDhkNMxM9dYrfE5nOuknNg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Fix race in do_task() when draining
To: "yanjun.zhu" <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, stable@vger.kernel.org, rpearsonhpe@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 3:31=E2=80=AFAM yanjun.zhu <yanjun.zhu@linux.dev> w=
rote:
>
> On 9/17/25 3:06 AM, Gui-Dong Han wrote:
> > When do_task() exhausts its RXE_MAX_ITERATIONS budget, it unconditional=
ly
>
>  From the source code, it will check ret value, then set it to
> TASK_STATE_IDLE, not unconditionally.

Hi Yanjun,

Thanks for your review. Let me clarify a few points.

You are correct that the code checks the ret value. The if (!ret)
branch specifically handles the case where the RXE_MAX_ITERATIONS
limit is reached while work still remains. My use of "unconditionally"
refers to the action inside this branch, which sets the state to
TASK_STATE_IDLE without a secondary check on task->state. The original
tasklet implementation effectively checked both conditions in this
scenario.

>
> > sets the task state to TASK_STATE_IDLE to reschedule. This overwrites
> > the TASK_STATE_DRAINING state that may have been concurrently set by
> > rxe_cleanup_task() or rxe_disable_task().
>
>  From the source code, there is a spin lock to protect the state. It
> will not make race condition.

While a spinlock protects state changes, rxe_cleanup_task() and
rxe_disable_task() do not hold it for its entire duration. It acquires
the lock to set TASK_STATE_DRAINING, but then releases it to wait in
the while (!is_done(task)) loop. The race window exists when do_task()
acquires the lock during this wait period, allowing it to overwrite
the TASK_STATE_DRAINING state.

>
> >
> > This race condition breaks the cleanup and disable logic, which expects
> > the task to stop processing new work. The cleanup code may proceed whil=
e
> > do_task() reschedules itself, leading to a potential use-after-free.
> >
>
> Can you post the call trace when this problem occurred?

This issue was identified through code inspection and a static
analysis tool we are developing to detect TOCTOU bugs in the kernel,
so I do not have a runtime call trace. The bug is confirmed by
inspecting the Fixes commit (9b4b7c1f9f54), which lost the special
handling for the draining case during the migration from tasklets to
workqueues.

Regards,
Han

