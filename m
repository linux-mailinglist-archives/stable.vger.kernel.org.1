Return-Path: <stable+bounces-89701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C849BB526
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 13:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25FFA1C21648
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1CC1B6D03;
	Mon,  4 Nov 2024 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F+PLu82O"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1551381B1
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724931; cv=none; b=OnGqeKNfKHtyKoKlwi+L2IOEctMgqgoTLxKh4Ge150PNxJYK0gnHREsUVPeRjim37Fvh8Q65BbSUex/f/09PCUekyKMkfFcS4FmiCznbpIxRnrDmrN7AASeynOgToWzbOQpxN9W8DOaCOFlu6t3dCxil/or0gY6Vla3Tw8yQ7D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724931; c=relaxed/simple;
	bh=wMQqOv2i9jpSD1GCk+gH/LpMZLCzxoID0qLFQkTCEzk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MCPGi62YDqlt1ZsY+xEmm7JW3YusVqU8VbrxBDZUM62EMR/9xS2THlr4cfi/5htl3Xm8zzTRyJrPTBB92gTjNxXrM0p5ExPB2+epqiZEl8Ss3VwOISN0IYr0K5HhUJ5axBGTFaHYnGrXo6wdZ4tNh+ZQs7r6e1OdEWt1xeLdByA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F+PLu82O; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e31af47681so3245528a91.2
        for <stable@vger.kernel.org>; Mon, 04 Nov 2024 04:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730724929; x=1731329729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUT2MUhoOe9iu2p2kd8BI2aLF+LB/mKyYJdsiPsn1AE=;
        b=F+PLu82OP47bO09itx5AP22edIU1Pni/VSHyOAmh4lTu7XJI2KA/KVrR+qzouMlhtf
         TESqMGIPmox/7IZ+0H9Nv/dJ1du6MOQ/4PlGIx08H8t9zFyFC9MAqztfFj83TwAn+LYD
         cbi5pFnCqpkBNka4xVN3pJ5gslmF7bMkXtjTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730724929; x=1731329729;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUT2MUhoOe9iu2p2kd8BI2aLF+LB/mKyYJdsiPsn1AE=;
        b=eTRWYa7eW57Mixn3HdOtjGaJNrUUxf5QiiRH+mekcVChOBPh3rBqjrG3WIJvsn78Bp
         NpnJwInt7rwJZnjFh/Jt69+AtEUzm0vhNlGv/KxWwcOnTwCkjVd+eyILyf6Iqot1ZiJ7
         YQVZdZt/Bxmh1SjRXA0BU29dWUnieNJteaj/fzp75p2i/Lyll6ElAj1IL33BkXFWv1+z
         Els00AtAGLiWhkO5rJHM5BMsk486TqjSuN8jGPNfdFJA16uNfCPkZmfFS9LnVJ5Y2i2O
         YvsVX5MKV8h5PNb2Oye7EatvufU9rXc+HBPbfODj27mJP7Tbo9cTZOtEzRgaAoDvJuTZ
         NjZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzi9TQAuafzFgmYeo2QY8w7NQG8kgVM7amr9kfLGi8dJ5/tyKhYi3dHgKKSUVoa/YeD1XMmZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3JeRu9KKOf96hg68s5j8Dch6bcSA/Ya/dKkbL2xmPkwE2o8bl
	4+uK44+atdj6gys2p8awVm+3PEqmy8CQJnCOipn4S2s2Ii2XZT7yDckqPi7gVA==
X-Google-Smtp-Source: AGHT+IGw2My2dH4dIXYJt5UAfh9QheTuaxvz/yW07aa/c8zRoSfhpBhW/1Yv0E1txryL8w9UJYPxAg==
X-Received: by 2002:a17:90b:250a:b0:2e9:5e21:24f7 with SMTP id 98e67ed59e1d1-2e95e21257cmr10927134a91.38.1730724929339;
        Mon, 04 Nov 2024 04:55:29 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:f5f8:ffa1:d9e0:6eab])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93daacb4dsm7534611a91.24.2024.11.04.04.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:55:28 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 stable@vger.kernel.org
In-Reply-To: <20241029095411.657616-1-wenst@chromium.org>
References: <20241029095411.657616-1-wenst@chromium.org>
Subject: Re: [PATCH] drm/bridge: it6505: Fix inverted reset polarity
Message-Id: <173072492636.262894.11094550143215575349.b4-ty@chromium.org>
Date: Mon, 04 Nov 2024 20:55:26 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 29 Oct 2024 17:54:10 +0800, Chen-Yu Tsai wrote:
> The IT6505 bridge chip has a active low reset line. Since it is a
> "reset" and not an "enable" line, the GPIO should be asserted to
> put it in reset and deasserted to bring it out of reset during
> the power on sequence.
> 
> The polarity was inverted when the driver was first introduced, likely
> because the device family that was targeted had an inverting level
> shifter on the reset line.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: it6505: Fix inverted reset polarity
      commit: c5f3f21728b069412e8072b8b1d0a3d9d3ab0265

Best regards,
-- 
Chen-Yu Tsai <wenst@chromium.org>


