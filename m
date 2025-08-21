Return-Path: <stable+bounces-172222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9C5B3025B
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 20:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E306F170260
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB7341658;
	Thu, 21 Aug 2025 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YAW01N6B"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF1D2253FC
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755802506; cv=none; b=XmAshIFskWgizwcGzHiEUvHZACRCvuWc71i68cWdXQHAFzba+7PI9g37yxgkUgOS/NTjIzgudeRyaeq+dL71lQ17XIZYB+tW+RnDfDJQeozVBpp/K/JK1pPGknWFeqIcrWcktSwjYY1L2YP6zhTFCdD9H7oHDggyf0PnmUfobdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755802506; c=relaxed/simple;
	bh=vV7oPr9msy3vmhpWdf7heCm5ZVEbOV2WJGQ0WQebzEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRM6X2Pfa1wHBsGwWgX62DxjSB8MY+6F5xZ6ZgWbfsrONgHAdf62PBOwGqp55Bi7eiXTauvCumbPY1Qte6MepQiOFeSNZdy8K9sAyWCVhPYyVcTOyF0X6ZiwJkzXxneXfm25xZX0M9ucRxSB38848Zomhnhf3TtMwlUATueRzZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YAW01N6B; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55ce5097638so1444118e87.0
        for <stable@vger.kernel.org>; Thu, 21 Aug 2025 11:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755802503; x=1756407303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vV7oPr9msy3vmhpWdf7heCm5ZVEbOV2WJGQ0WQebzEU=;
        b=YAW01N6BeFX2is6FFdpuOJ7TwEfFcNJunSEfcxHWv/7J3EMlhlY+Gc0sd/1ml2ISMn
         S4dcEOg6iePFSd2divYFgAmrMP5m98yWNqvEOW8CMrEkLRuFb7c94nzOsPmEH8nzupKe
         X7ou0g/TPuWtaE310Sne6ko8pODWKzH4VWaZt72s7w+6W53LIo7MtOtGSdTPgFs/S6rE
         DeCvWONigrLFrEAE+ZFBN0e6nahqMGAs982zmqka4ehskrBkCjnH+OiCkASagixeglKu
         +EPz9cDEMV91CEqXY8EY9VGPa80v4szslfBHyIRCyKdQFK7ORN4gBjh7g8UzGq6ADxxH
         BzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755802503; x=1756407303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vV7oPr9msy3vmhpWdf7heCm5ZVEbOV2WJGQ0WQebzEU=;
        b=SnFB2fZRRzL4qQPxwnuDPBjPGPlmj0kblMOr+ocCBeEbf+iAAlItnqlRAKuQ9lGyjW
         FF38TQguv9IucxLCvDYwV2mg51JHQPGotdz5iqRwDs94PNDjti6BfFJJRH/of5Nw02Lc
         +/IfLSnWeMbInX0RlP2XHnAYLy3Ks1RNgF/sMvpPWMrXuB0AXcWLENa4TxGlbcgRlRUf
         cQ5Ln13mc/Ayq500pmHltkQopBEkgu8fOJDLsYN2vKPyUa5TFIpyve3a68q/bIiNQYXK
         rzMCCKLyB3Eh1BuaqkmFbdhSewO8NeJDCODp6HlA46DQAe+sEln/TJTUIUdJaXjDJRp2
         TFLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQR4y2uAHbjfzqsJBTvcPOvIjQlnhTCxf6pMWwhll4la6voljgkTkRQkj/8UpgFi19kpAsrOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygoXQghmvMl2YHXQ2W3lnBhn5igdnYR/pSvWoepMPglJ04ujQA
	u/mZ+q3vrZ3B+iP5bL1Th5NIbxznRU2nQwUB4CmiiSGBJkfOimAK2GW9HEmpmWBPYiz7kR8Ocpi
	q1FoHO7i+y4nRcCpCybVm9UMlATAWTbEXsei8ups=
X-Gm-Gg: ASbGncs32BZ85eojRl3OOYs0x07/88WKwJlOhcYmGsb0piu2VODBvYtwxnyr5Q8fkXo
	iLCOJJGhs6Z/DksZvFKtejllzfY/NqPnqWNGY86qb5kiqny7OUp75FrIZC4yIdspJswrSyGmIjU
	xeW8KybQWzxzwl3Ra9qx2n7hZerTdWgKa5MkI1qiacNl3kPeNtQGTCZNtDOFNUGNiF7WV9GCvKh
	84ASB4mzCEloq/uZ+P4uRUVOHrk8dLTV6+fzqzdkJ01oO8bOzQyxw==
X-Google-Smtp-Source: AGHT+IHZZIjN6g1zYUADrxI4BD2krvDOeWcnq40aUOp4JXZVppT78w8gSvLCCuaqIwOLzEMB7cMuz5N0bPi/URvyahc=
X-Received: by 2002:a05:6512:68e:b0:55b:910e:dc10 with SMTP id
 2adb3069b0e04-55f0ccd3689mr198822e87.36.1755802502567; Thu, 21 Aug 2025
 11:55:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812161755.609600-1-sumanth.gavini@yahoo.com> <20250821184055.1710759-1-sumanth.gavini@yahoo.com>
In-Reply-To: <20250821184055.1710759-1-sumanth.gavini@yahoo.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 21 Aug 2025 11:54:50 -0700
X-Gm-Features: Ac12FXyudxm68vNxRiaRi-JpYNUUJ9ypqKjjiHgpfDn_K-UyK_k-qh5laH7nQtE
Message-ID: <CANDhNCr3E3nUjwYqFq1aC9P-EkX6iPs-X857wwN+a_QK9q7u4g@mail.gmail.com>
Subject: Re: [PATCH 6.1] softirq: Add trace points for tasklet entry/exit
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: boqun.feng@gmail.com, clingutla@codeaurora.org, elavila@google.com, 
	gregkh@linuxfoundation.org, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, mhiramat@kernel.org, mingo@kernel.org, 
	rostedt@goodmis.org, ryotkkr98@gmail.com, sashal@kernel.org, 
	stable@vger.kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 11:41=E2=80=AFAM Sumanth Gavini
<sumanth.gavini@yahoo.com> wrote:
>
> Hi All,
>
> Just following up on my patch submitted with subject "Subject: [PATCH 6.1=
] softirq: Add trace points for tasklet entry/exit".
>
> Original message: https://lore.kernel.org/all/20250812161755.609600-1-sum=
anth.gavini@yahoo.com/
>
> Would you have any feedback on this change? I'd be happy to address any c=
omments or concerns.
>
> This patch fixes this three bugs
> 1. https://syzkaller.appspot.com/bug?extid=3D5284a86a0b0a31ab266a
> 2. https://syzkaller.appspot.com/bug?extid=3D296695c8ae3c7da3d511
> 3. https://syzkaller.appspot.com/bug?extid=3D97f2ac670e5e7a3b48e4

How does a patch adding a tracepoint fix the bugs highlighted here?
It seems maybe it would help in debugging those issues, but I'm not
sure I see how it would fix them.

thanks
-john

