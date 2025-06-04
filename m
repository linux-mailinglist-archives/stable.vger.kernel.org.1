Return-Path: <stable+bounces-151386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D793AACDDD5
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 14:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F0D16CF3D
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 12:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1DD28D8ED;
	Wed,  4 Jun 2025 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODZVwePd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A48328E575
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749039876; cv=none; b=oMxTwU1oUOTHJrbFiWHouRGzEJcMtu3vQhF3hb8iVy4Jg1QkFhWioB5ut+Y+1Tj5Gvkgg5f9Adf9JPyc+zSybYF0ArQ7JbwAT9uiUORBBxXTHUWC8l3DznuN/7wHZNp1SasgYqr6PMGuJvhI5SF8u88VqTpCunHajZe7GF+PIpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749039876; c=relaxed/simple;
	bh=X5HoV4A18Es6cQsPxWdpN/6HMNSRex6GTYKxJ1FSTdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0w38aqnCbCE/fPCJJr8/eCDD0GhqXkFuFDS0i+Ilrs5eEI3/eWPHzOgh9dLfLh2oDjDatAVDUUzowwD1/6dJeMHNRLDLONIQUDH422tNxqaAAKo51vmDlGwWea0/bPzaekQB/5xyOvk7RkHezZB+BcE6AS5Z66glNOKHnCdIZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODZVwePd; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-312a806f002so480475a91.3
        for <stable@vger.kernel.org>; Wed, 04 Jun 2025 05:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749039875; x=1749644675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5HoV4A18Es6cQsPxWdpN/6HMNSRex6GTYKxJ1FSTdI=;
        b=ODZVwePd6IaD75VwJnZzR93QIl73LJ6/oka9rhlqxXLe1kjsHyfou7Pw8Hdc2SQ+mV
         5AquG4veTEvuqu8espks1Ehhi/JKEBuPpp0jSWy8JVs5SRU8fMNw3oHgGKfEzNnNMZ3p
         uX9dm+DczvloYp2hWm0Bs7NHcu4oR24OvA2E2A/5VTWjhAc3bazSLjLCVdFJNO5jk9bP
         aRTrPcUv4FUynCVlJsgoiXaGwooLsgVzQ28QgeZrYwlNFT1AOZziyx1qdKBDjqXcmSd3
         BR4TgJKISBc3y3/cH5Acbu8EEdQ8JlJsebUuPv8eME6JYn6Eo/Q7BI4zFKY1bbm0o/jJ
         FD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749039875; x=1749644675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5HoV4A18Es6cQsPxWdpN/6HMNSRex6GTYKxJ1FSTdI=;
        b=mOFho7pkY6STXoXUGkwmZ4ZD7ygjJbdTF9fMf5qsJBmbVpwVswqlKTSb0MyKhT8+pz
         0ajWfgFVGhFU1oHtKleHLriciYl7lnFfkP9e/f0A6s1FDIie8fxBlOXS8+aa4ZzM3zGD
         cgkYcZCem4zec4R3tgLYnJu+yfd0S2t0WvtSDLjvB55yZLgzExlMPo/C2b/tIik4mMF5
         zp89TMOmBoyhlu12b8C34A8ZBj3aXBtg4adbdrCq653YyK1nIbvgCV7g5NxzE11gonQ9
         NAAYP4R7LpYHk7fHqAVuVQ/nPrsb4RdjFnJUwLZ3g1WwVUIddmyAEfWCjRew8wPPrNtX
         RtuA==
X-Forwarded-Encrypted: i=1; AJvYcCULSRxiskWQFpKbZ+kRZpoueSw2hQ/8cqHzNkB6Cz/7+vRdjEI1gs4amst0dQE2ecSa2ANM8Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnEcjRLdHN0BfEIjXbrsXw8tjlJDzMj8HhcXxO1IdKahP0SQvG
	HsVso2BYQV1khNBVGSixp3lPL3YSCTJreqIZpDt2BLTTVMk5q5AXDj2dKuhCUoQIyYvYokCZ685
	YwKPwh9Gaefu0c6chZfiDu8UFEmC+3gE=
X-Gm-Gg: ASbGnctuCaT97Q/qx+vYgWjWv6SkaaBzZ/ecvG3qZvWZMHdC0gtR4ZJNQvAGbFRHjHM
	JI/J19+TwLfGhFyCxEubnI1LWHK+eDKb4dXC/zBdMXPZGdH2yKFdDeZSIvsZ4thZ1gsa313YJEx
	73o1egFaH93cmlAs1s9Sqx5KC+AJJMdxQc
X-Google-Smtp-Source: AGHT+IErLwtGSYQMv8xDY353kuF+fsT1I4lfY5UDw62Z+Lk5yJh2j12Usxk6xWco51Ijg6BndcQq9Kq/vDbhiZClOm0=
X-Received: by 2002:a17:90b:1b42:b0:312:ec:411a with SMTP id
 98e67ed59e1d1-3130cd3ce2dmr1484250a91.3.1749039874684; Wed, 04 Jun 2025
 05:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604114923.208380-1-sashal@kernel.org> <20250604114923.208380-2-sashal@kernel.org>
In-Reply-To: <20250604114923.208380-2-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 4 Jun 2025 14:24:22 +0200
X-Gm-Features: AX0GCFsrP9iFTYtJTClz9rDnEXWcTEpyeBtPkQnKTXB_q9gbKp89nIFoYXOWykw
Message-ID: <CANiq72n8oZGOkUVU4MAjDb0W+OwX8PuEykA_2Z=DY+onvj-T8A@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.15 2/9] wifi: iwlwifi: mld: Work around Clang
 loop unrolling bug
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, johannes.berg@intel.com, 
	miriam.rachel.korenblit@intel.com, emmanuel.grumbach@intel.com, 
	yedidya.ben.shimol@intel.com, shaul.triebitz@intel.com, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 1:49=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> Now let me analyze the similar commits to understand the backporting

I think this ate the newlines from the AI... :)

Cheers,
Miguel

