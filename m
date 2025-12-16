Return-Path: <stable+bounces-201145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DA8CC150B
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 08:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D779D3022A96
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 07:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE1D2620E5;
	Tue, 16 Dec 2025 07:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqQYNnEj"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151C41DDC33
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765870319; cv=none; b=DkZ3z78hAPKhEwuB0Ezo7dR35IN1+ojZg5L82UWqTiHP3cQ2+sVuziG0izp8uGiDh5vV8q0yProhsHxMDNdmK7zZx1oLZz+U9dC4PWPWcz30FTpKahPtOPk0hbPbN6mhiqPshXUSVbqh9yeRRSqEc0jMXZBAfjUBNp1Es07zcQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765870319; c=relaxed/simple;
	bh=56pDNBRnCd8IeTo2aYkwkfbBEAXuU0fbTgxbB6X8B5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dd9G3kVeeLMQj02E9KfPrPBMb1M3Ytja7DyxpDtNrt6SkzjjRpbkSBV46cbGyNS8ZhfW2bx5SqJymcKBfSRETEX8uk+F+p/Zk0PMyN52SuwWJENz+9nW2BS5pWNNw3PalJZtpEjrVqLfj0ngIReMacD/LFiLjaHCb4WAt8Vl4Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqQYNnEj; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4503ee5c160so2430563b6e.1
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 23:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765870315; x=1766475115; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:sender:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=56pDNBRnCd8IeTo2aYkwkfbBEAXuU0fbTgxbB6X8B5o=;
        b=fqQYNnEjXKWvkBEWb+gFaNodeWMjoKi4l1pe0R6MMPPhJz22DA4KelEDh9/ZfyMqGG
         dvNfk/lmfAD0mrNN8GgMmmv0ovIE7qhgC1RQwIPj2Zj8L4g19zph21/rn+1PC9n7z2DJ
         91uQqLxqP3NMLL87rA/lkgTpYT2ykQa+ecrCjH+oDOrA43MsWxxsLX4jEiX2GMmU0ZTA
         2QW+TqFnLwWpTMQ7qKmpJFCR0X8KuyHSsh7b0OAnz7n6HP6gxkQ1S3R4BELIjfbxhcPC
         E0sgfI3fOiJostZ7bMGPHsD8Z+YOOJGwcqpXWyrmSiTe6VBX3x/L1wsS3Cp0AN31eGuA
         qysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765870315; x=1766475115;
        h=cc:to:subject:message-id:date:from:x-google-sender-delegation
         :sender:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56pDNBRnCd8IeTo2aYkwkfbBEAXuU0fbTgxbB6X8B5o=;
        b=SXvSzYhYv4o/YMUiUxe5XrWLFvMkPJyoJScfZC2Y2fZvvQwCGb8eStnEm4WTcoDOvf
         yb/EU64POPtdmapVqjL0ij0tpUm/YptXaDdGem4Hstf2EJkkMhoUaQSUQZhbpwvEpc79
         2KbyJPzIZy35z48FEK+SyxBjSjgPqGTa8mlN7PPO/3hd+fMIlJYC2N7BEYBKIAid0BvL
         6V9MVXOsAZMdMPrNNT7PCdpTALYwVVdnWWxdY0964M7Dn1XPP3xlN+poVjzkeYWaDAT6
         LCNXbf15jgZ9H7cMu7+Ai1vYuvQp+59l7UZSL7YyTLEZXSFY+ModZsv7TX/mKQWVfpED
         0qkA==
X-Forwarded-Encrypted: i=1; AJvYcCUDkLwoIS9KEBeZRY1JkU4GomWdIbiSjGh4d9SFsJy7VbnOpDTA9JYDUFHO5/O32HjgidQortg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaAtGEQIgiMyiZPXCmBNW+Mprox4YmE4TUjranpS2Cif5i1i4V
	HYNQjpOikZw/vHSKdNEVrqVsrq2uTdfKJtDB+/Ak1Of1q/WOIOaV8mNXn1JGEHdXuTgDrK+yn+C
	KwM0rzJ+t/wXCW29YHxT3F4U/DjOJbwc=
X-Gm-Gg: AY/fxX7FAPoFfSGvV9pBVpGROE57GNx7G6iEJM3p20EzCxRaPyRFz9/JQiNpeRvFyW8
	ZC1Ysual2naSb1bPfhhmvoGKHW4koTcZg6zlWeig5ICS+Trib1DyM+7Qf1/X4fAZxsWtsSKrkpT
	wEiOKf2g3VNxqKLZ49zZJcOwEFwx4SaPtVDaAGYkcagw2dOts9DIgTlmZG/VcEHcr2O2BAWBknA
	b3Ypxl93mIJzvLT05ZeZUps3gjFnbdW82hw20k1xOJTANr7z0yNQfWN2flHJk22KUD7tNdge5vF
	vf+2eDgb1fHg0st6NOvHo7UCx0kxBovR9MosJz9GmHYTd9VHnnbwx3eHSC1oIl8=
X-Google-Smtp-Source: AGHT+IFzI7ofXoz6tqiamTePNQYiATxWPq14YAerOxCZ4uyzeaSK/NErrG3N1vsrCRC/MO9C5GFQdlL9RJQrRJeeA8s=
X-Received: by 2002:a05:6808:c2b4:b0:450:1e0f:58b5 with SMTP id
 5614622812f47-455ac837a12mr6166224b6e.7.1765870315162; Mon, 15 Dec 2025
 23:31:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202174438.12658-1-hanguidong02@gmail.com>
In-Reply-To: <20251202174438.12658-1-hanguidong02@gmail.com>
Sender: 2045gemini@gmail.com
X-Google-Sender-Delegation: 2045gemini@gmail.com
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Tue, 16 Dec 2025 15:31:43 +0800
X-Google-Sender-Auth: XvPtkd-Gxef3gjczpCiP680NwtM
X-Gm-Features: AQt7F2rig2jn6EnuFacoVlXo38M5SBoWgs_YMwg_E1yYr_ObaXqwPpcO1npb5GQ
Message-ID: <CALbr=LZvZJn=Qoyfsr=m-_eCJYwRafmdXV+TAUQSib4H0j27rA@mail.gmail.com>
Subject: Re: [PATCH] bus: fsl-mc: fix use-after-free in driver_override_show()
To: ioana.ciornei@nxp.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ioana,

This is a gentle ping regarding the patch above.

I understand you are likely very busy, but I wanted to check if this
might have been missed.

For additional context, I have audited the kernel subsystems that
implement the driver_override attribute. Out of the 11 buses that use
this feature, 10 already hold the device lock during the show
operation to prevent the use-after-free race.

It appears that fsl-mc is currently the only remaining subsystem that
does not have this protection. It would be great to align it with the
rest of the kernel to close this gap.

Please let me know if there are any concerns or if any changes are needed.

Thanks,
Gui-Dong Han

