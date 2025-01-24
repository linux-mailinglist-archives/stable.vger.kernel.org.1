Return-Path: <stable+bounces-110366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E54FA1B1C2
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 09:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C519188CA1E
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 08:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F63E1DB12D;
	Fri, 24 Jan 2025 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMbDjvhi"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBCA166F32;
	Fri, 24 Jan 2025 08:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737707647; cv=none; b=ldVZhaa6M/0C7i1nfpHcHDW4NvGtr1Accg9cX/LcBgvc5Kk+t0AggmzGDdgA4hVUY054HT490vD2vNH7iy6uXgnIMDmZPANn5DPcjKG54A6nIeIUjM65guD0QKl0oD9/Q8y+su7ASotVi6Picx7mRzr3AEjutvlk1Zev7MBl6Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737707647; c=relaxed/simple;
	bh=GZ0nIwGZcKWC9CI9oPaF+selKdSvdGUPn/XTMbdZTRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dcOmYyETtoo3VyGPmrJXlvn8898JoIQ7HzrvGFCKcrLZZot4Vdb01mLuthPgHpLyJ491bQMgzVDkT0xa6h3OACGtvsKdvDlYidjdqH101N5H/Z4iKnajUJGd6KF++mdXSzkuBD8MX6vqdEhnTgQtD/PJsqa8evjllXPs9TPZCfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMbDjvhi; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467918c35easo27474801cf.2;
        Fri, 24 Jan 2025 00:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737707644; x=1738312444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZ0nIwGZcKWC9CI9oPaF+selKdSvdGUPn/XTMbdZTRM=;
        b=DMbDjvhiTIFli4b3BpOxFjwOsY6uhxaDlt8i7m+zmwlmVYo7r2TP+ts2sZF3IN2Axn
         G7H8ro3i4Ue5v/UJ19h8sMyYbgnbO0tpO8CtIjxugGAZhaSWCl3qvDZxtYOR908KxAMG
         2ET/m38vDqs4+4jvzopRor6qxGZADCRSJrGVFr3bmTzQRT/+MI6ynu3ly19WvsZi6xOy
         NcfpJb3ZRUJxpEvwMbUwYDgpdKI1LBYTBNiDLzTuOJcOEpygBGD3A9mSebokHHOdB8LC
         yWRoV1pI9OimFzp645UeumBhO9SSE1cO/iALpiOW4FtUjETFfymQ84dwvWAZpYTiMU3C
         i9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737707644; x=1738312444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZ0nIwGZcKWC9CI9oPaF+selKdSvdGUPn/XTMbdZTRM=;
        b=VyBu7qLm1yw+uL7rDK8W4TV4rnuRoKy81Lnl4s+rZoCXegsvAqwInEXtSgAgfJIsLx
         4297VbiCZHB+3fI+Ul37hdrWoWErDvXXGTrdEhCrN9qI+Kih9cRURuQWhi14MvWW4XU7
         HpnV8Lyz8nOOG/XpOzczRYQSXlxHCiteQ3KR9p3FocY5glxtCKc0D/tu6C0/7TMfK+Ub
         +9ZSYdUOobaxFEeJoHVE0dGOOGmmQQ5Y33OznGOi1sOxlWZJR5LUP1XINX6jWQP7Y8wv
         0NuFgUeBl/5BMLcPf05tvfEP49ZuQrZ8pHz/zjmXfwGe41oaHqlsFJ67wzTd9i38vUED
         LClA==
X-Forwarded-Encrypted: i=1; AJvYcCU4KAYkj8zYICjKIuTCR31dUca1xxg/cf4z6xkqDbkXVVniwkySWB+YY3XMdFO32o76T5PbUsJ1@vger.kernel.org, AJvYcCUwDLLf0/xlJtzBhxjC3x8Wb6Fm3z+3olKvaJbvHZSY6haGBFj3FZuTqjdPSuuTRwEBlvAY/kBv1nbGhyDU@vger.kernel.org, AJvYcCX44JVQ+FXLDvYNcISHeESvbi7wKNqboIXMWrSiEJNQHJKbZYCWvmnOWXWvwEcmhEMjM5S5C2ZbrZBr@vger.kernel.org
X-Gm-Message-State: AOJu0YxlByWCg5YZo0igQWtWfPCfpnF7EmR+RCq9/udfq9VpqIxqdo7D
	HPHq+Tzdns3tNd/7UFl0CQYU83V3BhsSSD/H1e4bozqJOPnoIeTAW899yg+8kPLh7EES6r3WNIQ
	9gWtULDWOQ4jkQWCmlv4xmEUwy8kIw05Iecc=
X-Gm-Gg: ASbGnctA4E4N9lG155wQSJymeHDglwlLAf3dgSRYMXBbPVyfc+kqRa3O6L8b3uYHayR
	zoPJsqRPzyGrekf8e3m1pi3a7h98R8PVPQ8aZ9E7WchnL23zb17CPg2XRZITgZ5L4rdBCb4u/ak
	/AVOUYxAtN7XaOls7NGEE=
X-Google-Smtp-Source: AGHT+IFl2RBQvd/ETvziDYSlPrmT7mc177y845BPyOUXEov808xJd8TLaJbwsWABklQa7ECj77cxjS4eIL3qMRRl/jY=
X-Received: by 2002:ac8:7e90:0:b0:46a:1932:b07f with SMTP id
 d75a77b69052e-46e12b94a7emr491045021cf.39.1737707644511; Fri, 24 Jan 2025
 00:34:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124052611.3705-1-eagle.alexander923@gmail.com>
In-Reply-To: <20250124052611.3705-1-eagle.alexander923@gmail.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 24 Jan 2025 12:33:55 +0400
X-Gm-Features: AWEUYZmQaM4V6YVDY2n2Q6kv8IFnTIzybv59I_cdQvKs7jFSzvTBO42nz64fyqA
Message-ID: <CABjd4YwA8P9LVuDviO6xydkHpuuOY7XT0pk1oa+FDqOo=uZN4A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix broken tsadc pinctrl binding
 for rk3588
To: Alexander Shiyan <eagle.alexander923@gmail.com>
Cc: linux-rockchip@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Dragan Simic <dsimic@manjaro.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On Fri, Jan 24, 2025 at 9:26=E2=80=AFAM Alexander Shiyan
<eagle.alexander923@gmail.com> wrote:
>
> There is no pinctrl "gpio" and "otpout" (probably designed as "output")
> handling in the tsadc driver.
> Let's use proper binding "default" and "sleep".

This looks reasonable, however I've tried it on my Radxa Rock 5C and
the driver still doesn't claim GPIO0 RK_PA1 even with this change. As
a result, a simulated thermal runaway condition (I've changed the
tshut temperature to 65000 and tshut mode to 1) doesn't trigger a PMIC
reset, even though a direct `gpioset 0 1=3D0` does.

Are any additional changes needed to the driver itself?

Best regards,
Alexey

