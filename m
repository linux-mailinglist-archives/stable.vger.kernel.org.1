Return-Path: <stable+bounces-132704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D994A895E3
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 10:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3863F1899F08
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 08:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C8227B4ED;
	Tue, 15 Apr 2025 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HO/S8o+h"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DEB24C68D
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744704014; cv=none; b=K4NJOHhSiiXT3P1ST1XHwP63Io90oherWIgRW6w2QYq4yehOJw0ueUWSrhaaoX9336R+6L3TzvqJ7Voq0t67FegKQNXKzSJYULg+vY8gHl1fJIkMKUv7PcHFWGFYkw+TncxfyDQVaELjHLjRTKPfXARpkmXU8JY3myoQKT0DMrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744704014; c=relaxed/simple;
	bh=QuiknlKiSA+WD7K8fGty1GjBqI96wU/H/9BL6EACW14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AebiivWb3C8K805dLSCrRjZdjlNZ2zbTLP9291PfsUrPXZDQLGbE83wRNsJvqEUPaAZvxCKhKy8BbzDsk/ZsGMwo6jpWVMCIIJjCW+mq/qNx9NQ+FW8iRDcsiivAE9HGpQyFeuqa/Y/e/u37+85360dbDW9PpXkORp8CCunJHx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HO/S8o+h; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-548409cd2a8so6817271e87.3
        for <stable@vger.kernel.org>; Tue, 15 Apr 2025 01:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744704011; x=1745308811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuiknlKiSA+WD7K8fGty1GjBqI96wU/H/9BL6EACW14=;
        b=HO/S8o+hH//VO4PFiDPmLKyG6tre9uFK5KG7a3Q8ouystAPkpSCL6JoA+2aE/u3H/O
         k8G3KxIdrof/Ml/SXK5gGXtk0S6gTqHExciAgXGIzWQcdg3JrTn/ORzHBm3pl/Tx6iqI
         bcTNuQka4j3ilQIy9lpGppcaY+kv9pTlhBlc/o7FFRWbSkKDew2eNzRPpuTHzQubyak9
         YjFhnF4StgMZTjpAHQ/DK3O9NyqJd7UeLkdy0MoNNXIh0vil3TsTtuBp+gU1F5TtLVH2
         3J2m9nnyckQXPGe2SafxAJsW1E4bKMhz3FvCF0ft59hpIs/rThokKGvTcOPnsjLBCPof
         6olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744704011; x=1745308811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QuiknlKiSA+WD7K8fGty1GjBqI96wU/H/9BL6EACW14=;
        b=ls4I9c3F9o42X5Sy0bavU/JyzXfvhK86vNjgm/ZOwtg2CRKfGc3jMcyojyWGT8OrxO
         v2NdC0SN1IkjmsWxygevwwVmi8464SwN+N4ruALhXX+2PooDf9ZxETaSH8bFynN3KfgJ
         SR5Bw++0jR/eMLPJNdOgmnyXQaO3uWuIQsE1S2zSbZ2a2RfJoP3t4fZZJr3+Frxf4hct
         kjrVk8MYyLkzJZaBRbOQ/WAab7rgp2dyyMvMoQqmt5KqnZkJGyYNi8/o+3i3dc/N5H6W
         rz8zl+whwXzKx+mYZlcxgcEDftHNa1mJGWceVnRyaGGCP6xwN6oN7DmSF6LcNaz4F1tn
         +B2A==
X-Forwarded-Encrypted: i=1; AJvYcCVLoJKldydDxFzdzoaBSxLv5+ydoLpTTnSp6LWEq7biUfmz+Xl0wy3FGD1Fiwc5Z90eqJmLYNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQBbSeFrxjFY1yFulQy+gwkicj+zaxQw0xoG0FdhHc2nZx69yl
	wgmwjZEZ/HDQHxl5W887Ufg+385txeex05OijPaEVW2aAhwqQZFLDBrvNEzWcisRaviVK96owl3
	E+5O9a6coQN9g5Luj1ztygptZkOgJhcunqMl6aA==
X-Gm-Gg: ASbGncufsKWDvk6l0U9L+XPpD5COHvXzpBgQf5PhmuL8WHos0MmEatuwhxlvC/RmOmD
	qix5Uy7FeZAcABiI133h4cmtzA+yQefOiynTl2CKGlLQwamUhCGzobx3zmswxkcDIXMlXZca92O
	sQTA+bzMkmP5nspUWPFPCWlA==
X-Google-Smtp-Source: AGHT+IHnxXKT+pyd9gBpYCbMyVQZAO7XqVpYGkBSNYSVfaaSRz2f0QOsZvZ5bl34m2PPRdwZD5oWN80iP0qENOxIShY=
X-Received: by 2002:a2e:b8d3:0:b0:308:eb34:103a with SMTP id
 38308e7fff4ca-31049a7ff11mr54687661fa.28.1744704010562; Tue, 15 Apr 2025
 01:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401135026.18018-1-ansuelsmth@gmail.com>
In-Reply-To: <20250401135026.18018-1-ansuelsmth@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Apr 2025 09:59:59 +0200
X-Gm-Features: ATxdqUE1-4C5Fb1JmQvyH7hBozN_RXpvZiZvSLKiPhH1VCoFIEKXbvFQJXlM6ls
Message-ID: <CACRpkdZdFhpixdhsmN=oCEmdAuabUpXtQ9RRh0cFRuxfYXJ0Ng@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: airoha: fix wrong PHY LED mapping and PHY2
 LED defines
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benjamin Larsson <benjamin.larsson@genexis.eu>, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 3:50=E2=80=AFPM Christian Marangi <ansuelsmth@gmail.=
com> wrote:

> The current PHY2 LED define are wrong and actually set BITs outside the
> related mask. Fix it and set the correct value. While at it, also use
> FIELD_PREP_CONST macro to make it simple to understand what values are
> actually applied for the mask.
>
> Also fix wrong PHY LED mapping. The SoC Switch supports up to 4 port but
> the register define mapping for 5 PHY port, starting from 0. The mapping
> was wrongly defined starting from PHY1. Reorder the function group to
> start from PHY0. PHY4 is actually never supported as we don't have a
> GPIO pin to assign.
>
> Cc: stable@vger.kernel.org
> Fixes: 1c8ace2d0725 ("pinctrl: airoha: Add support for EN7581 SoC")
> Reviewed-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Patch applied for fixes.

Sorry for the delay!

Yours,
Linus Walleij

