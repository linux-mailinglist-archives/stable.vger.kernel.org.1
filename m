Return-Path: <stable+bounces-89341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF499B67FE
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 16:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5DBA281644
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 15:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0821D2139A7;
	Wed, 30 Oct 2024 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CJHcwzjf"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8481EABA2
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302683; cv=none; b=cBSuVctKboFwsy+SdF3zKF1vA/L3lxluiM/ycH3YrTTRM2sCMFBAh7WEPQEu9+9aAj5mMxR4Yhgt4gK+0E3hquABekfkBH+4D5zHUkxzTsDEcCr6RrCQSTzJLUq1A9/WDDozcYnduCZ4QQV1ZpmN2gir4mp1Yyn328d6ECJem9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302683; c=relaxed/simple;
	bh=lWLNB6NauvSC3irEBTZhZs6g8sLTn5D2zaDYEGJJkAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhc0hK8E/Xdji6TqFOAaU7kY8nrMtyhmJ/Qk1wyT1kOyxV2LTjtipSfId1DNbpun6qq8jAzrF5JrhUR5g1dKHVyQTL65vzlGxktuW+MWqUJ7xaMUkF5XRZIedvkOJL2L8gD7cWfnAI+Y+Hnv1k0DGeNFCvcKlh/oJEBOES9B54s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CJHcwzjf; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb561f273eso61964131fa.2
        for <stable@vger.kernel.org>; Wed, 30 Oct 2024 08:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730302679; x=1730907479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrMCWRpczwyRTmnrS6nIF4HKYVkA9torv7EN4XtnnJI=;
        b=CJHcwzjf1DlXkV6asHilDSL94o/kA4VH8E+t9Z3/aJmTDMv3QkosxlxGhUY3oiy7P8
         1BchP1MaPyxL8/NOpuRBxxIZwp9L/LYEOIrI/F6yi5FrQdSGN/nzgBVorOxUuME+9T0h
         fY/J/OzxTysMR5bRb6qXqf+qqaMsyFtRVp7qCvmnTxOuJbc+ZUB16QAIBXKbQiopXRGw
         Zq6bjabRArF7CszFm2/uhy/Kkrgm6MWCFhwRJUXSlKE2GShG20sCstoubv7tpOOmvZ9g
         Y2glRGQcAoCCdEoAbWJB00jZbXc425k1sWEkxOfWlbVwBWAbzhz9V6bP4RU2GMIf6yyT
         r7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730302679; x=1730907479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrMCWRpczwyRTmnrS6nIF4HKYVkA9torv7EN4XtnnJI=;
        b=bdMRM1WvGEFNAPJ641aTh+Wq/OF2jL/OWP+Txnm7Ujydy1V69klz9utUlJ/q7CGn/q
         ht63FXn6eUSblUdFui2ZUwcsCRs9BwdkdmYX8KsBWGLbkN4tFWWVGJkzaTWRDWdQuQjA
         33Tt5cNAQpNM121ng9VH9cLnC1cD7sbw4zojNc3KWiBQ0hqDaSYNV49+anqQGs3Isln1
         TCTd6l+acg0IP09C/Fa6WJ9ds9oFW3WHwXleM+lq4e/ReumW9CIAIo74iaucBApBg6Ze
         VWp9VQthimUjeviw6SCAxvQTOcmgl+MuEGzCD3+xg9skXCt+X0smbAPkcocDlMJz7d9g
         gC2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2an/HTVXQBNyGKKsfD4w51EfmcU3CtKBfW6rVllLOl0BvJ1pwZ0Atqt+uyXx4l11MKK8ccc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGp1D65rhM1HtX5vaHjWyKaUIWEZrGx/Aow8JPK+DAbS0mTi0B
	lbdVCWjO5JiP5XNanntnxTFg5Syhnx5s1Y/gVWTc+E+fuQZH+KPJYFSVqUv7sw5Iz5pdffY/FQD
	Sfki1lZqWam2uRRTlh/y9jbshMvqfIGzl4z43
X-Google-Smtp-Source: AGHT+IG7DRpQ0VVMTcG6EnMiWykyPu51ceO5M4tUaSNQltNn+7su5SexoUVL9I4k/XDx6ioEftGeQAPKiITlI5Hsoro=
X-Received: by 2002:a2e:4611:0:b0:2fb:382e:410b with SMTP id
 38308e7fff4ca-2fd059d31f3mr18514061fa.32.1730302679117; Wed, 30 Oct 2024
 08:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030140224.972565-1-leitao@debian.org> <CANn89iLbTAwG-GM-UBFv4fNJ+1RuUZLMFNDCbUumbXx3SxxfBA@mail.gmail.com>
 <20241030-keen-vicugna-of-effort-bd3ab8@leitao>
In-Reply-To: <20241030-keen-vicugna-of-effort-bd3ab8@leitao>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 30 Oct 2024 16:37:44 +0100
Message-ID: <CANn89i+1ddxa3aQH=1ev2fX5+T=PBT2C0i0YwqQzWaJuMfVi=A@mail.gmail.com>
Subject: Re: [PATCH net] mptcp: Ensure RCU read lock is held when calling mptcp_sched_find()
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, horms@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vlad.wing@gmail.com, max@kutsevol.com, kernel-team@meta.com, aehkn@xenhub.one, 
	stable@vger.kernel.org, 
	"open list:NETWORKING [MPTCP]" <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:05=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:

> Thanks.  I got the impression that the scheduler list was append-only,
> and the entries were never freed.

mptcp_unregister_scheduler() is there, and could be used at some point.

