Return-Path: <stable+bounces-115128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB94A33EFF
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 13:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AFB8188E422
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 12:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C62F21D3FD;
	Thu, 13 Feb 2025 12:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuL02+pi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE48227EB4;
	Thu, 13 Feb 2025 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449341; cv=none; b=ElyoCm9jH6RerL0yR7ilb00op774aBx/NvfxgC0i0trYIte1R4z01fay1LvihcoRDAugdppUZRg1j4U9ZB/u/4UDh64M0c/8iH8AN4uoUicGVHZHuZP1/P/Yj8tvzX1Emu5tCSHL7R12wT32oFMhlz42UIV4W4Jqw2BqUgHrfNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449341; c=relaxed/simple;
	bh=JhQ8USlPxenG52f+etBxdWz9DV+4IdlE1eKF2Q41L/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTaaEif1UqHjL6LW207TNMSnpKoxtaul4+uEil1G1nD7zVLCklG5C4koiGSregPKvNPm9M+5iRYc6tTUPsSmXSrW4Yo6gPhb0a2moGFkhwA9MIAB4Ji56zPs5lojyE+96mClOSYFAQmDgvoM+uK0iJCC+dX4b9bX547wr/Giydw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuL02+pi; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fa18088594so173870a91.3;
        Thu, 13 Feb 2025 04:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739449339; x=1740054139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhQ8USlPxenG52f+etBxdWz9DV+4IdlE1eKF2Q41L/8=;
        b=YuL02+pi/HjOjeGea+ITDt4AQJLkzdt6HVb2sz4rKEixkSluBb/XeNpMwHAvz9VXU9
         F8Cko2vpB84w1aL96P036hTceVevjyHpS+ykVHVseXVc9j3UQKqgJaSd4r26mofkJnDO
         LUlqQQ394PQyYhpCiCH9YtuBz3ga614f542M7eDdUGYBV5UIhABYIsqogs5ocxzaOLvK
         FbeRam9rb6LQWG3XvSBpfek8kjTg+UO6KFwdkMifkZeSDrkWAs7efzfgeumo/qf6YGY4
         4WdIguC2+O62J5p2o0mi+PwX0OO00sdGq75yoUyYj0gZ9V1axejaW1Ad30U6CWXdidi6
         sP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739449339; x=1740054139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhQ8USlPxenG52f+etBxdWz9DV+4IdlE1eKF2Q41L/8=;
        b=R0tuhZKO0jih0rZfXr2P7jLs8lwcqy52GU8Kqw/WqIDZT3T93Lp7U/WZY5NZgQtNkN
         V6bmPF870legLBrDJBLzQkIziBWUp/hJ4HHw5adnnK553fZd9pYkuPnafPHfGJNACA17
         kXBL074L351ZZUq0ZoricN+HcOKuOkDsjTQ4oIqo8v1iojTddYBZWFdxOOKY1PWHWx3n
         Koh3d4pV/yhDeTQZjySiSlyL7JzQzhvf+gDVj+onsTwyykqsPOKTlx6CDbReBx1p6XCy
         IqlH2xBu+PHfqqvNu/yT0clnNREvAjpyO5izQmFBkol9FPUfhg1Z5xQ7qVPZFio19/dA
         zbBw==
X-Forwarded-Encrypted: i=1; AJvYcCUYNhdW8nnmtDZtwxgaSVGB18qfTnOVH362oPbC2RDUAGtA6Wh9U4fzgFackJCc9jT40BAxHwttChrOQM4=@vger.kernel.org, AJvYcCWjmVnE0zahJifbm2mSMQ5tXd9rqPoJ8/fLRYxWGrOcaR5za2H8R+lLeVXy0u1S0Pbbszq1TP2688xuKkGPOv8=@vger.kernel.org, AJvYcCX9vz4u/KK5aD9LugtIZOaeskYqmnxhsXCIdFGzk22T2sQQUlvPWfMfNO0dvTUNs8RW2Xyhm5AM@vger.kernel.org
X-Gm-Message-State: AOJu0YxmJ2aiz6ftCd2LwCE0ipfZdUTUMq/zFVrrE0rF6yJAnUcx52ir
	GOhxmddvcIKCEzBkEYT5HcaCZ+zs97CMuUTZFXaWRTBmcXLXjslZN+JsqQbmVJP0Bywm9EXuW5W
	vp8wiVRDis0xfiP2islsYj7z+pps=
X-Gm-Gg: ASbGncumbbUxTktnX+lo5diLw5dOP8Umy7l7W1NUB5H2jfIXOk9bRZ0mw7fFZ815gHC
	Urzkv7iDItApmh0yx73LtfEyNZwmM3NGnUdZzRzht5IQPJDY/ElrXUz9cOvbnxdMm1Ofd/k1l
X-Google-Smtp-Source: AGHT+IHmYvEzL9KGp/GiZCJityFb8+Au3r1Y0YDY9cYrjSKGnUmZw+tnh/sBiqD37rnyvyHdxym1Eq0TTuz5tYj63uE=
X-Received: by 2002:a17:90b:33cb:b0:2ea:853a:99e0 with SMTP id
 98e67ed59e1d1-2fbf5c75392mr4064811a91.5.1739449339042; Thu, 13 Feb 2025
 04:22:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210163732.281786-1-ojeda@kernel.org> <20250211103333.GB8653@willie-the-truck>
In-Reply-To: <20250211103333.GB8653@willie-the-truck>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Feb 2025 13:22:06 +0100
X-Gm-Features: AWEUYZnMSt2s3upFBai0wYaA0s4vfSFiHEc-syAvZrBIXeINByCQBVsZZ4yEXKc
Message-ID: <CANiq72=n++Hb1KX5fHCN=XayfPOxgayb=sDG4AvyEnDOZqAsNA@mail.gmail.com>
Subject: Re: [PATCH] arm64: rust: clean Rust 1.85.0 warning using softfloat target
To: Will Deacon <will@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, 
	moderated for non-subscribers <linux-arm-kernel@lists.infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>, Ralf Jung <post@ralfj.de>, 
	Jubilee Young <workingjubilee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 11:33=E2=80=AFAM Will Deacon <will@kernel.org> wrot=
e:
>
> Patch looks fine to me, but I'll wait for Matthew to confirm that it
> works for them. I'm also fine with adding the rustc-min-version helper
> at the same time, tbh -- it's not exactly rocket science, but it would
> need an Ack from Masahiro.

Thanks Will -- happy to take it through the Rust tree for if needed
with your Ack, I have to send a couple other bits anyway for -rc3.

And, yeah, I went back and forth on whether to do the helper directly... :)

Cheers,
Miguel

