Return-Path: <stable+bounces-141779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864C3AAC0E3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 12:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB7E3A1EA0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 10:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5714A26D4D3;
	Tue,  6 May 2025 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJfdu8P0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DED2472A6;
	Tue,  6 May 2025 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746525986; cv=none; b=B6Fg7K5Vi9/HjXOKs1Rp2VrynucFRFqruOvplpyWEMLBcvbDlp18KXfEt7WCFHYLzSbPb6pTUsUY/vLjR4s2gqVEl8burNSS3vcoioHt3UVywEm6QR8UYVnHTIzKhIIDHqsKth40/ZQybbhOW40sEpT2CgrwN/Rzubn5c7VFfXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746525986; c=relaxed/simple;
	bh=uWcVkaDIWPWg4JuOYBhuX2xthL3fS8kru6FrB8vKM80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lks44gVghHIYAjXZs5Ina3BHY+PrNRDNu25lcWs2L8kvWyfJJummD0+U5gcIwIE1/AN88ntcpejCuijN4w0iTT/SiRMgzpGeMKvTRikt2mY5OZC0o/kCJs298st7b1RWedFlw2LwIh9D+vdgV2uG0E7kf36/ObN3zDZeKcwsJ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJfdu8P0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22e162515acso5809825ad.3;
        Tue, 06 May 2025 03:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746525984; x=1747130784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWcVkaDIWPWg4JuOYBhuX2xthL3fS8kru6FrB8vKM80=;
        b=GJfdu8P0rvbcOC6vMI5TsAXoqtEyYFNhFYrO6TOuzSpuA7kyjwng4GWWm5E4wV8dIU
         Kr8/RMs9H6MkOYx6GSULeN17TlP8i7/mQZWGldjjsXqy+vAHv6DXSvG59kZujJBtlkhU
         2Zc/P8unYSi+4HHCOL00V1gsmLDSlDROgYkp2JOFeaf+Z7R1n/xT53NqNCJ7f4V4DLHw
         Ncg8haiPOQe4s500ZZ80e9wKeZpvmI8kAXTkhGo6XKixb4+INhY6P4f+A+JpxHA5iYU3
         rDcyAV5bj9Dt9nQP3WiDbes11S3lycqNlZf2foo6+hEL8eGEVqjkAIYzUlR8T/KsHLHv
         OA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746525984; x=1747130784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWcVkaDIWPWg4JuOYBhuX2xthL3fS8kru6FrB8vKM80=;
        b=KA8LVZAOYY3HNVS+dY9yiRscyO+lquLmOGHgTRHMwxpqGkMztywoHLxyAGqkHh5GYx
         GS0/QuUBg1Ul5PQiIHqpfewiBA2dAmvHdlH4uw1jZNizBMzChhPuF0YY6uPYv+rjlF4K
         ++kb8p0PpZOp9iU7MkaoUtbj6ee2O9VK2RITxYy5Vjsex4SXEPk2K3XiQ1asepRcwzzR
         xPbMKZtc2fJ7iYVK7Bmm9h0ctoWq1suisPbybTUlfLfka+PCkfwIaK8AN5HsfdkCjnVm
         cU333T+pXSsBkU0bWWqanqrhHg5gUvP9PKh1unTW9cLUVKM/WXvpwoy0WbxybOCpqMJb
         xpIw==
X-Forwarded-Encrypted: i=1; AJvYcCWgTQ7xCJ1it2Rl5xWv1cJxZ5ZNjC81OzDRC3ggqS8ehgNOhGNYIpthrfszW3hLVGSv6VPxxiHXFtWMOmRzIg==@vger.kernel.org, AJvYcCXbDbaLI5gt8NfWV2uV2mBsjhdPfDxteY2F7A2xUhO9a0QNEZ+JP0Y8ENnekZFXS+Y2IM2fu3IQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwGX5Mh8xxwUegeALpXkul9H/cSo8gYYE3r7v5iEopPFrtjr4TZ
	s9jyJeReZQgcfr3kmNK1LY3P/69n5JFYRWESmYisRPN1r/wXM9EFkyNmuA0IvYFB1ZhV5pBrwJP
	AXZDO7sQAH4E5X8A2brliKSeoKOo=
X-Gm-Gg: ASbGncuGZDSLaRE/OPmDJ90psj2iqxzu6E2WL9e+jrQWIQcjSUJhjLcLy1ToTdIRbco
	KoEFTIqM6+BGctB3G6y3nodvdyGNHP1cCPLZS47SGaeXUEyYNtuKEP/DWcrNkcas2Bgx83SqfY7
	milSOkSKASRW2rns1itQybFQ==
X-Google-Smtp-Source: AGHT+IGNW1bQkgEPUzwv/u6V0505kRofrj6rLt2UXk3MK+zuogfsk17vFI3oZzjGvlZjlW1wjS6TUxvtJ7akkl/OTm0=
X-Received: by 2002:a17:903:1246:b0:224:1579:b347 with SMTP id
 d9443c01a7336-22e102f7c23mr86440685ad.7.1746525983961; Tue, 06 May 2025
 03:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505221419.2672473-1-sashal@kernel.org> <20250505221419.2672473-302-sashal@kernel.org>
In-Reply-To: <20250505221419.2672473-302-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 6 May 2025 12:06:11 +0200
X-Gm-Features: ATxdqUHI5rDYIPwUTcGU9NhC1qwWl_wMASLlZRTTRwZeP9y6bm1JKEA-XYZgxxw
Message-ID: <CANiq72=1cTG0d4-PWX41tLqr+C7_QjJZ_=n=_5D5+Zgy3PUmRg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.14 302/642] rust/faux: Add missing parent
 argument to Registration::new()
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	dakr@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 12:26=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Lyude Paul <lyude@redhat.com>
>
> [ Upstream commit 95cb0cb546c2892b7a31ff2fce6573f201a214b8 ]
>
> A little late in the review of the faux device interface, we added the
> ability to specify a parent device when creating new faux devices - but
> this never got ported over to the rust bindings. So, let's add the missin=
g
> argument now so we don't have to convert other users later down the line.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Link: https://lore.kernel.org/r/20250227193522.198344-1-lyude@redhat.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Does someone need this in 6.14.y?

Thanks!

Cheers,
Miguel

