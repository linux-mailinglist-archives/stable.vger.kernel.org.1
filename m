Return-Path: <stable+bounces-119787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C13A474B9
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 05:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C176D16FC1E
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 04:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5522222595;
	Thu, 27 Feb 2025 04:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJk3wNCD"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE54C221542
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 04:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631068; cv=none; b=aySf+gLdIGoM9MoymY634oyADlHCiGuZ+VDH0xERvtYwjVAheHu1e3XHXlhEXZdt6UPD3oRgdxyPP14SC9IVInEeAFu8XxV6lEoLn+c/2Xzxtfswbtfbu2aSTBufFZV6wEqSlnEo1Mm4L76OsZ64MY24Z/+tHf/1ZApK4L9MFJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631068; c=relaxed/simple;
	bh=UAKk9n2MgbyCZoN+0ucDNxhrBHryl2KbQSyyMlhtXZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SoHQeVc2ta7zc0ZhRO2vAvs1yuItzYgYAFnqmk7s27jZGfEwPf/ZyRSiFRk5V4nzzFhygioLnhoXUfVlcIhBmyQXQesMpC3WXhxfnTux0Jekw94N1jk7VE3G8gIDATP+Tgxz8eSwTCGIC9OUEge2blk8esrmZTtHijrDs8Gk1y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qJk3wNCD; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54605bfcc72so1943358e87.0
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 20:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740631064; x=1741235864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYRdSFJ0y3J8w0/MIT9m/pNCngOvo9+w+cz68lIRPZQ=;
        b=qJk3wNCDcBenA1zw9NZiXPn9QcJU6ef9qZhEJ2OKo1L6PuZwO5qpiNI3RXRs2Di0LV
         7VSdDJzVQbvAk+hHWQanPtaPqj1ZfLoAF/jUNDt6fXHLoZSINSt+bCSC4q4OxeIOFio5
         sBYSKxpCl32ywjmUFNERgyA/zix0nUV6bFkBj64D1UmZvO4SxNUdFsnIuuNvpbgnQrA8
         8NDoF8Ca/jgveY5pEXj76PtAavMvv8kjJFlF7DIB5xjbi0T7n91I3GqB7LeB8aS6cP9o
         XMTUFaa8ZfvD9DQONqWmmbJqXHnbkkTSg9DNOzDt53qKG/wqBZgYxFqHFtT5667fq7kU
         bHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631064; x=1741235864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYRdSFJ0y3J8w0/MIT9m/pNCngOvo9+w+cz68lIRPZQ=;
        b=kxY26dbtQCeItfc82e7fdfsxrYTbfxfAkLQ0GWv6EGY4c+4sKkNyBM5+GmqMUFSAAx
         IV0F6UI7Rr0xXT0SYB8ubHbb4PcV5KodTrRi+NtrsgHns5i0dypS38yj+BJLxiXEFEN0
         uGwzAXn8qTzDoQRhDPiqGk6MdwxRzZwWHjBOZ4Y03XA8/0loyHuSFzUm6dnXembdYqPe
         Jz4x9W6fZ7gdli6C9Yb8Ydhx2QUCxry7MARskDD7njm0iefOxf9qGm7SQGxwhZYA5lMW
         7hwj1Nr8yRPGSi2g66M+nsiI7neQBvh3Ruf8j2sQ4i7AZTv0XM9ay/IpIm3cuuZC7lRy
         mNog==
X-Forwarded-Encrypted: i=1; AJvYcCWqEAwi96NjVHOmc50Nu8AiVuokmfdGV5Ym1lGMqirLlWQygRto3AG5ZuBwhbHEyOwpsrCv7Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGSGW64c8L1hEzf0syiaavI1ZKDKOo2SD2tPMEa/0SiuZRDSch
	FB97Nl2MHAlP7j1Zf6nxkVHUBHNRhAqnoPoE+FKWlQ68wl6hIi5NKzm9vEXzLpQ=
X-Gm-Gg: ASbGncvOajJyChjNt/mYM+vVY3AnmrqBqAACQglj8yV0zTxb8jqHcvQiY7AZ9AbQVUn
	WoTflLvAqlC7wA1JZq/nyOmAaYqtIHuUF9nVwfrHZw4h3EvuMO6OVXW6V9hDId7UR9HfHP5LOCj
	cwzwJpLv6rgE85QB+9OMAOTuuS320ZSAYka96NxIldXdycaRHVIRCXK0d4kCdK4wWiZByUgo7/U
	1wnR7vxqLf5RTr/NKq2Br/8ttKwJ9OWtnsIVu8UNoPTaoY3YqbKgs/EsAWH5MprHmVMGC+mYlc8
	8YuXnLs7+fl3vnm3eB6y9SiYzC2SwGVylChPN9rhWw==
X-Google-Smtp-Source: AGHT+IHInNYeeu7RJnY0u41TSawSb/sSqGvIZ8wxvnotJqXxQ14P4JT9/11iwOVMUCOL38JGxUNb9Q==
X-Received: by 2002:a05:6512:3054:b0:545:5d:a5c7 with SMTP id 2adb3069b0e04-5494330bedcmr587647e87.21.1740631063830;
        Wed, 26 Feb 2025 20:37:43 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443ccf45sm63485e87.229.2025.02.26.20.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 20:37:42 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: robdclark@gmail.com,
	quic_abhinavk@quicinc.com,
	sean@poorly.run,
	marijn.suijten@somainline.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	jonathan@marek.ca,
	quic_jesszhan@quicinc.com,
	konradybcio@kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dsi: Add check for devm_kstrdup()
Date: Thu, 27 Feb 2025 06:37:24 +0200
Message-Id: <174063096227.3733075.13590017200932514746.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250219040712.2598161-1-haoxiang_li2024@163.com>
References: <20250219040712.2598161-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 19 Feb 2025 12:07:12 +0800, Haoxiang Li wrote:
> Add check for the return value of devm_kstrdup() in
> dsi_host_parse_dt() to catch potential exception.
> 
> 

Applied, thanks!

[1/1] drm/msm/dsi: Add check for devm_kstrdup()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/52b3f0e118b1

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

