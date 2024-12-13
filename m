Return-Path: <stable+bounces-103964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B16F9F0429
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 06:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC997188AA80
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 05:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4EF18872F;
	Fri, 13 Dec 2024 05:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FgHLwlSp"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80231684AC
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 05:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734067629; cv=none; b=GUP352yjfm03tJv8MSNS+Ljx4eF6XROwnRo+CBkHBSQqkbDUa+YAOIGHqk3FKNnu9G8st+TN7SQSA2sAQCElenWYBZVQCHMU8yn/14B+70lYZCxiWCOiF/cDK5tu6x5wfdczyztg3i1mEK7foxfAFZOaY2Zpgn8mekeKRtPiJu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734067629; c=relaxed/simple;
	bh=Sdf13U4qdk1cMSPMh/hmbpEG7cuPIH7P2wBu29YqNYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMvh/5CW/wcv6FwPYAvNG3G9ILnvMZdliahrAX1m4UJlPABtC1Vm4ONOdME4q9olmqc2Zvj9MuHFDVUdDaR6hbwdVDGmD5+TMuedrANsgY+MsS+khpMpjkeoCE7wUU98zLcZhhnGjNwI/mwyAUgrW2ClDfFte2IRYYjo4qnbZJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FgHLwlSp; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5401c52000fso1337802e87.2
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 21:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734067626; x=1734672426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgQ1AfOgEV/WtM/A3+uz4rEIqiFfux5uHfmCT0tsGtI=;
        b=FgHLwlSp/kysqN0ivzcXMSIr0RdaGObx2c7a72F9DZAi4iJL2TfVoADtDal/cE+xnu
         cCMtnO2Hyl6oo2vAxqB714ToJ6bCA9fxCG+sbcjuCPAnBjHWXh62LqmmWGdbojqw/omz
         qyp5DwKjCQJnV3m7a4hEdbk99hI6FDwEpdC5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734067626; x=1734672426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgQ1AfOgEV/WtM/A3+uz4rEIqiFfux5uHfmCT0tsGtI=;
        b=wgZ9hL2Yh3JTtaCFdMfsPIAoDCf5yXtLW8LQ8mVSOZnvKABev/iQw3q0g+gptT/2TF
         BH83sXeRnf9yPscsWBoyaRG1E2JsESm0OUW6mdZakYylfnc8gOI4edrIue5wXwgdtKF5
         u7qbM2MROKbMpEjgIrtf0FMIB9rQnJsXR/C6iCNKaCH8k6lkcuOlZ2yK02PtI4QFlqRJ
         yBe2p8/ehx7V6mVk7lUrSyMZ+tKfO6t4VlDmmOnEhm/2GbQh0rP2HmT1BtQmJTtsbd9A
         sncAovDwdnPO7LyBw3/+EQ7DfK6+2dmGz/gYKUvmhZibHrPQt3OZJ5HSAVW5Q0woBVen
         2tzg==
X-Forwarded-Encrypted: i=1; AJvYcCXAbjLL731eLDtuDSYhQcVcq1Z7dVx14GrpB2QHmeIXwMNLIwnGFBEAZly0YULIxMF2U3k/kIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMBOUI7FamjcvUUc350KJNU4yyvLXl0tdWbfriXtsSuUqaM04z
	/oeLPXvh3tz/igRLjqQzA6kRaHlfUUS4FHrXuyqOb6+huLrnFS+f9MERfO9tWJzv/XpdIBoadfj
	IwBwhp7QKthHmuelf1u7Bbhi9my46meO0mjE+
X-Gm-Gg: ASbGnctjCjnCF/msbK8OVwSIm0rQl+55w4lW5cr5EhqJvX+8Amia/Y7zT8qj8RSTdZk
	2ReJ0f3l+2ppb25xkDfeyDHPDwn3t/Ln9/31boSsKT3cVl8fhzvaBmxDbvW68/vw=
X-Google-Smtp-Source: AGHT+IGhA9h/qMEh3kQO//+RlkgxCOjtkEXubWQ5cyZXn60MBtkXvqcni0KnjZPJqjy4n1nnTxAQnsTV3Ek/V6fc5uA=
X-Received: by 2002:a05:6512:104f:b0:540:3581:5047 with SMTP id
 2adb3069b0e04-54099b69aefmr240381e87.48.1734067626143; Thu, 12 Dec 2024
 21:27:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025075630.3917458-1-wenst@chromium.org> <173381930438.18469.15845444123528821647.b4-ty@collabora.com>
In-Reply-To: <173381930438.18469.15845444123528821647.b4-ty@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 13 Dec 2024 13:26:55 +0800
Message-ID: <CAGXv+5HY4s+0Yn35BezRWLKPnYkURhgg59eSVED1_6Z3QyQHiw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt8183: Disable DPI display
 output by default
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 4:28=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> On Fri, 25 Oct 2024 15:56:27 +0800, Chen-Yu Tsai wrote:
> > This reverts commit 377548f05bd0905db52a1d50e5b328b9b4eb049d.
> >
> > Most SoC dtsi files have the display output interfaces disabled by
> > default, and only enabled on boards that utilize them. The MT8183
> > has it backwards: the display outputs are left enabled by default,
> > and only disabled at the board level.
> >
> > [...]
>
> Applied to v6.13-next/dts64, thanks!
>
> [1/2] arm64: dts: mediatek: mt8183: Disable DPI display output by default
>       commit: 93a680af46436780fd64f4e856a4cfa8b393be6e
> [2/2] arm64: dts: mediatek: mt8183: Disable DSI display output by default
>       commit: 26f6e91fa29a58fdc76b47f94f8f6027944a490c

Thanks! It seems you haven't updated the for-next branch, so it isn't
appearing in linux-next yet.

ChenYu

