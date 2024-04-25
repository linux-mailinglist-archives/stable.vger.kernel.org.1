Return-Path: <stable+bounces-41464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BD78B29F8
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 22:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF0A8B2437F
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 20:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9D55B697;
	Thu, 25 Apr 2024 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2FXxKhk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0CD43AC4
	for <stable@vger.kernel.org>; Thu, 25 Apr 2024 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077347; cv=none; b=OcFwglF3Z1B+XVeuu0VJT6C3+BS9li05GzZURlM4HxrCcBti60BlVrnmL4+E7y9B3HxH4sil8ZFnCr17Rmt8QWDYll2WEMtSv+3MmVR/iGdfU09WmLfh2TouwtYTZnLndM/TITufr1XoE5IUPT++cNW1XTzjVe+5F3VpQmqO1VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077347; c=relaxed/simple;
	bh=bCiSpeEajhHeA3ZWzQjdXp4dGEPuM9XZsenh7JoVOkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UmCvcoDuoB+GkN99gFCbsvz/WXtgSCCwFXCMAs248IhIZlUNg+oQUin/gslX+GGIvQiY/95Nnr387Hf9TqjA7b8z1l/Mu3qJx8bkANEQXQ1K/OUm0HIP+BG2sSBgt7kVCStNInfhN8nsWkt/7FNRTknJPtLl2aPOzbImlc5OXAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2FXxKhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CA3C113CC
	for <stable@vger.kernel.org>; Thu, 25 Apr 2024 20:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714077346;
	bh=bCiSpeEajhHeA3ZWzQjdXp4dGEPuM9XZsenh7JoVOkM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c2FXxKhkwd6Itw2qDAVxynj20Lr6ewh7IrxW8WDhk/ZIhpQtoiyDh14iUfsDMEMpm
	 ol6ii7UHyauQpjwBGQhUsGMpA29tpfXlNimUeS3XvQC4qpaAX+jbYfO1Bf7BbE2MQN
	 U+LFlN4MCTQ4CeTnwFWeQzLAR4olkP+IRKO5cU6hgR2qC6P/dOu+YLxBW+m9Q7es2M
	 9xk3eNFPrkYztWfzINWXpWb0T0P0DHxIbj414cUf9UhlfU/FSRjkqYsEG2eD2Eo1FC
	 DyXxWPJBKrzywc9DEgu3CellSC0+dqg7EJMDilx2hIrwAonQc61ht/BwQso2R0gT22
	 r31KqR14KgX6Q==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2def8e58471so17431561fa.0
        for <stable@vger.kernel.org>; Thu, 25 Apr 2024 13:35:46 -0700 (PDT)
X-Gm-Message-State: AOJu0YxOmDl3G7xCyT7ZXVu+KjRkniH1HaIILfJiF4Xp35SGBmxWShww
	PjIlGXNZmp0v4Kh4rF4iurGiEq/14O6gd0wNAXFeuMKhoyFvGZDAmyn2Q4A7s8g6Tefas9mNSPB
	r2V44AOGWqeL5Rd7fjc3QrDkEDw==
X-Google-Smtp-Source: AGHT+IH0jiWIh0gTBhNm2YA98qh5jrinfKFsibAguPX98MIifI5V5pnmVMwPJxq9jBukg3E5QxvEmCk36DlAbIM05Uo=
X-Received: by 2002:a2e:a286:0:b0:2d4:5370:5e8a with SMTP id
 k6-20020a2ea286000000b002d453705e8amr335215lja.22.1714077345322; Thu, 25 Apr
 2024 13:35:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423213853.356988651@linuxfoundation.org> <20240423213855.436093838@linuxfoundation.org>
In-Reply-To: <20240423213855.436093838@linuxfoundation.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 25 Apr 2024 15:35:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJHa4j5p8V_wkWFf6G4Xem5P9X+2vK5p0DYbBShXLdM4Q@mail.gmail.com>
Message-ID: <CAL_JsqJHa4j5p8V_wkWFf6G4Xem5P9X+2vK5p0DYbBShXLdM4Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 068/141] ARM: davinci: Drop unused includes
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 4:45=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.1-stable review patch.  If anyone has any objections, please let me kno=
w.

This doesn't seem like something needed for stable. Are the hundreds
of other commits like this going too?

Rob

