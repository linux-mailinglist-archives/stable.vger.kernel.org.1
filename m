Return-Path: <stable+bounces-172464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079B5B31F34
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 17:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2578BA505E
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 15:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F00338F50;
	Fri, 22 Aug 2025 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nlnz52Yc"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BB327FD7D
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876923; cv=none; b=SGWmNvWRZ8SGG1V9N3cHfTf7k7vXrG596S+NiZEvgZYydpSWR78YLP1TNO+FLQA9qIFzaEu/hE2Ir6Rpe/laVPnoG04hP1AnyCz36AhZSK9PgCiggooZ7TiYvnVTMOOqPuDVJRxS/T4VVXPQeweqydijW2qOEfT54TsLeOe7SjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876923; c=relaxed/simple;
	bh=okm6zA57Md77y6JONMzrRLC8xuz5n12dHItHDryubbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKdlxQdP473LexGeUHaux5VV5l9VN/ZjEKW9fTsZ/GyV++tHz8nUicU23SOLGyxPzkbAhGGANtvX+W3TyckgYQO88MLLFzHGeN/4qmKlBevl3XujTaW1TKDb5fBM54wwcaiqFH97Z96B8J1o84c4k8QHSCrBMdxCS+zxSX08+Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nlnz52Yc; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70bb007a821so27616756d6.0
        for <stable@vger.kernel.org>; Fri, 22 Aug 2025 08:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755876921; x=1756481721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okm6zA57Md77y6JONMzrRLC8xuz5n12dHItHDryubbo=;
        b=Nlnz52YcZRHOBjBUpkFtd5jlZuuSm7YEevOktPUQVRZO4/7Mn2BBNS9KRp92t0bZ9y
         3PT+geO7eXT7bglncECuXc/N42eKZtbc3bHagJiFExl29d+6FpXgDIoWVIMOeZ28f1l3
         3+psxajc1o9OVxyox8wiznBRZQf/MSWy3utUpn81Ob/37+A4XaLlRxr44tzzMEnQDTVn
         V3P2JliQoQ/tTYyH0PvwAUdS68iY4PEpgOoPuHhvbQsYk4GEWe4COgCXjGD+r6GYUQ8K
         X56wkJpjdekqtf5RAnHKiGWpSXHCN0PZxgPIfW27rdlGOgxgPIvDJcnHscz5n/UXJhwa
         +O/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755876921; x=1756481721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okm6zA57Md77y6JONMzrRLC8xuz5n12dHItHDryubbo=;
        b=Ac6w3Y0B8zKVb5JnQYFUZ05wbwe+4SSEq9j5BSz3AlkGwo0faXQmagKsdszXwLgYw0
         kschQtC6BCbkjTOqCbMuqFgIjqhOyrAc+FYJSSXah+mhmczwkJ1T6qIWlcZMOp4zlax7
         mEElC/gR+XpUh/4ByIeXPSMv5dhQXJuQ/9ARTK8wicfvfwoSaHbrayRjNAi4mMfAUldx
         7cu8quuCYBMkpFm4+qBLS8txYuppvYcqFKhR5HsuEgvzmozqJgXhZu7MmUacL5Ip+mjH
         GLDDMl86YLvAPJT5X3vzkZSfdOn5n/MR4SUzzo8EP0BradcuHLF5E/3VogLprWUZ7Uw5
         eVAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7kVfLMYuZx/zSyq5Tf53GtZFYGZmbp/snSiHXDV8iPMkWd9vA/1E8vonuuKOYlNjsHh1nosE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvQxKrgiBN7MrpkxlQ5ycso+XAT3jCGih4kzlVoZnZTFTVcFml
	qH/mfybsSQydWhkQZyzqaIsy5a/p0Of+Q9++SVueoW48aL0pWNoiZky2BH+1gERckhSAvPrjS5Q
	Vx68slYNUPumCgMxzf6QYwXgVbK0w6SN/dtd4OOWbgNCNXNq4C6o8QODZ
X-Gm-Gg: ASbGncsE9X68LtaO8rQouwPMmWS9YfCqgm2398atMIXSlin63iQPJoiXcfparfybuJN
	IhNWkbgspd8cwTvLDaipl4n6LA4QpdGnKuUPhqjLUgzAQ1oon1uG/C0yn88MQO747pV+sdJULyT
	OVxuoKPIV1rvbif9zg5sH0wnQ1DfYa5hAHJ2fMR7Wmm/hfg3gwQgzIq6UAJRERWhdJlftrDuNfk
	lr6h9ggazs1sYLBYtSgIgMiLSkGybzqAhwKec8hxMLUDF/BXICuFFtCc/B6lD+VUCKs
X-Google-Smtp-Source: AGHT+IFfa2+wyssIHv+pja8l8YwH3FkeujuT60EJbe4ixX5gW+HkmFu4e3BUkaKH+Np6afO8m2e4fQvcqolHi1x73Ns=
X-Received: by 2002:ad4:5cc9:0:b0:70d:6df4:1b06 with SMTP id
 6a1803df08f44-70d973873b9mr36505246d6.52.1755876920362; Fri, 22 Aug 2025
 08:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANDihLGGcVHO=8uX6+TWciJyXqy6KtRHGgjbAGq4a1hZ36mU8A@mail.gmail.com>
 <2025082206-blubber-ought-421a@gregkh>
In-Reply-To: <2025082206-blubber-ought-421a@gregkh>
From: Alistair Delva <adelva@google.com>
Date: Fri, 22 Aug 2025 08:35:07 -0700
X-Gm-Features: Ac12FXwdFet5Qn9d8RRgGTFpEujZpD-BOla8qmKuJnoIGHFsbQVO_L23EDRedk4
Message-ID: <CANDihLEu2dMMpYdQxJK4q7YAqqiwdroH8J7q+w6FmhX7mcQQuQ@mail.gmail.com>
Subject: 916b7f42b3b3 to 6.12 (was Re: 2a23a4e1159c to 6.12)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, Elie Kheirallah <khei@google.com>, 
	Frederick Mayle <fmayle@google.com>, Cody Schuffelen <schuffelen@google.com>, 
	"Cc: Android Kernel" <kernel-team@android.com>, Linux Stable maillist <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 11:32=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 19, 2025 at 03:00:25PM -0700, Alistair Delva wrote:
> > Dear stable maintainers,
> >
> > Please consider cherry-picking 2a23a4e1159c ("kvm:
> > retrynx_huge_page_recovery_thread creation") to 6.12. It fixes
> > a problem where some VMMs (crosvm, firecracker, others) may
> > unnecessarily terminate a VM when -ENOMEM is returned to
> > userspace for a non-fatal condition.
>
> That is not a valid commit in Linus's tree, are you sure it is correct?

Sorry, the commit is actually 916b7f42b3b3.

> thanks,
>
> greg k-h

