Return-Path: <stable+bounces-19441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC04850A8F
	for <lists+stable@lfdr.de>; Sun, 11 Feb 2024 18:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CE71F22582
	for <lists+stable@lfdr.de>; Sun, 11 Feb 2024 17:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72AD5C90A;
	Sun, 11 Feb 2024 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zHHiLQo1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C4E5C614
	for <stable@vger.kernel.org>; Sun, 11 Feb 2024 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707672618; cv=none; b=S6UCUhjdUVUeQ2aOGOCAbVBed15bYMu3KVSMLmOzL+dG7/N2vofQHQwfDqZiD9V3hYA+b9qf2SwlHD9iT+ja3c7Ni50f0AGqCNcZsS1HW0QQ9KJT5/TvXWMZk/h9jPAw7AotanM47ce0F4VgiXmXztnuc8go6eDvVYrS9VQNTNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707672618; c=relaxed/simple;
	bh=hngWTmrLeBeNi8ttLPeG+EuTMwR3drMyE+3mK28cfzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVMcdLuLQX0mCwlc4c/bRRZkXnkzDpqiMIbOndIlsc4qBWUwQ2ua/nlv/wdnY19XgrUYObk+FCj/qY8Re5iaFBfrCfzklTGtEOhC5C+woSor4EBAPPvNR6qiEAaqBBMV9yhPjOAiHxhv8PHhSTAl9OgscvWvUODjEgo4bzLqRE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zHHiLQo1; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5611e54a92dso3042289a12.2
        for <stable@vger.kernel.org>; Sun, 11 Feb 2024 09:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707672615; x=1708277415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hngWTmrLeBeNi8ttLPeG+EuTMwR3drMyE+3mK28cfzg=;
        b=zHHiLQo1bQ8btYuhJWA4JGMA1hRPL/BUPWU6EhDGTnSMGtqxA7KW63hd2FixgNOxnB
         T1CpTvNjU1MoLXyJkB5bRZyzzv+FPTVWK1ahjiQdpPDAXSru9iUbNrxl24GHoWcT+HPo
         yhrXc6HRMgx5kVHkghbqxLUxlbNNd+NTTk8r0RqEp7F+jkj9tcUUCo8WQwnPeckwvpax
         EyiyY6NQZejF3N1VANDku0yC9h7rUQtFFhLAmdWUdjjvx9dVtPEsOLuH8uFdxxH3t1mk
         6iTxsr01+Du4daG+2xnFI5ZcNMWEDPpHPEloLG5c1/mvLiaO00ClJgvVWYrDCU2qbact
         i5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707672615; x=1708277415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hngWTmrLeBeNi8ttLPeG+EuTMwR3drMyE+3mK28cfzg=;
        b=mJjNuoON71URtFnLAcSC0LncZ01B/oHC86ww3jSmurphrnamYjkypcRyyM6xHn8nfm
         vQBQ/ApAA0+eFm+qAbNqVVwmC+yZLi4sVgw7lU+h/HBjn52+Zk9C44B2oHYU6XnsMpw3
         ybUYV0CAe7rWENNUX8Mo3LkltvsFt729bnH87vf8DXv7JOEb20I4J7XSNmySDyrc8O4a
         UshyRBLEWU7SEqER7e45t2Lpm393UepcgoxlGf+H2CowBrCRWxA2K3MJleXcn/XasCBF
         ybP9VEti+4gOcegCbKj0/rJa6eek5RFLQuKfGtKPqk01oBVtwCKtGMWh142zekR5Mlps
         EJmg==
X-Gm-Message-State: AOJu0YzZ7W9Gacf0NsW/JrubJK8y6NU8A30HuXvB7usb8tY6sFF53h41
	Hsj54ClQnv+epy21haVDPiVa0M2O009zK0bxkD/UbbgAKmZIToBHjXiE+8qKnCo6Z3zln8C+6wl
	YfnKXuwIY1A/jhyE0SIDcL9xFCjPMa7ksVu2U
X-Google-Smtp-Source: AGHT+IH8X9eg7e5sqwdV+AG9S0K2cYpoei2j4qPQ7W9YaWCWISTcicrNIrNZ7wqDLv0c+DAvwIsbV6U7y3tbw0X74uU=
X-Received: by 2002:a17:906:abc4:b0:a3c:8e87:f04a with SMTP id
 kq4-20020a170906abc400b00a3c8e87f04amr969832ejb.21.1707672614913; Sun, 11 Feb
 2024 09:30:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209162658.70763-2-jrife@google.com> <ZcZ0Tb13ZG9knz_P@sashalap>
 <CADKFtnROEHN4w8pRz7u1Udjg+Jm3kVb5meJSjGXZQ_=zQp-=qw@mail.gmail.com> <Zcj17ysVY9kU8xVs@sashalap>
In-Reply-To: <Zcj17ysVY9kU8xVs@sashalap>
From: Jordan Rife <jrife@google.com>
Date: Sun, 11 Feb 2024 09:30:02 -0800
Message-ID: <CADKFtnRk9HG0=SPhqCG-72eG8Hb4dMoWjUCV6Wur_uQgGKEWPQ@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] dlm: Treat dlm_local_addr[0] as sockaddr_storage *
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, ccaulfie@redhat.com, teigland@redhat.com, 
	cluster-devel@redhat.com, valentin@vrvis.at, aahringo@redhat.com, 
	carnil@debian.org
Content-Type: text/plain; charset="UTF-8"

Sasha,

OK, fair enough. I will send out another patch to backport c51c9cd ("fs:
>> >dlm: don't put dlm_local_addrs on heap") to 6.1.

-Jordan

