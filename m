Return-Path: <stable+bounces-135191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A5FA9765E
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFDB3BE559
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF45298CA7;
	Tue, 22 Apr 2025 19:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfqOTqA1"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FF510A1F
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351977; cv=none; b=pnUqiejYONnGK8OG7TvJB1HhaN4B+ZLaQqTEH94c5xN8bBq7xM2HqNAgTIfD4sewx3rchQXHpuDRaaphsZO2X6gb2IE6yGjBFIR+uOgbemVtqHPtWtA8tamjCAW+TV/ZTRJNdDgVAq8YkqJf3ow8oaVNvHWBnnoCCoZ4Pic2c9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351977; c=relaxed/simple;
	bh=UbGIG7i0NzKo1+u8xQW3mbtmAxhdO+m2bsQrUBizX3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hniEneiUaiXYjehDmyRJ6RW0z81V6qIbiKdKZ4h3sLPFRZpTJy5sx5FY8fg8NcoB9VRZcMtyxoBEoSkg7DgJ4lgB+oT2m04QKy8+S4C0D4fKs34D+nZSNtpwAMgsw1TvvbneHfICa5gq5NOO7SVt+Y3TkujPFKWRaNqcg55ThlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfqOTqA1; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54d42884842so7232629e87.2
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 12:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745351973; x=1745956773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ty76n1wOFkwp5qHN3wcH9JcxPufPeZW2s+1Yy23nN/Q=;
        b=LfqOTqA1SBrypKzqdU16M5RiAXYvbN/krCyvEQviA5cW3O/GxvmL95YN4jzf4cmphR
         FGPOuSexNG4P+nSNWNT9ZUJO/u/Nk2JLXrxeANCjo55vH5A4IlQV+Il853vy9TkDOzGS
         u6NgPFElt9L1LiBb8IjH53uc4zAL6BhaouYdZXPxcdK9c0F0SuNn4WZGBqBQL2vrGfDx
         SZC8Y+leHQIJiAMCry+h+Dc+Lo2ZmTwSa/zkjOFgmD/oDY+Gd/otcs+1+VkWmwOlYD6+
         lpAa0ZIzN3ffBA6YmnvI5RQHpXtMkO/oDaKLHaPalLcP/Be6QDJLBCK9Gi5WSICcUwzU
         nh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745351973; x=1745956773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ty76n1wOFkwp5qHN3wcH9JcxPufPeZW2s+1Yy23nN/Q=;
        b=KWAPh+aljHCvbBuUZpR6wduyiX4XlAcvOSnCOAjJL/Qf4tg5WWViEq5WSMm/39/zGE
         AFiytYgiPVmfEiirj9f8ivboILnXAt7QTxNptK0BkYc8d0Qr2r45e3aaiPWRic2z4taQ
         tbcJZvK4bvpnI+meqOBBwpk2eDQAkukE4Z0Oo6bA21npzY52cv9XO1U/FpUubvApg8HV
         cVwJSWlIjfCIUpshfOZ8ZUF3ku86TN2t9tieFl1TTXfL00mamWynL/QINZk308Iq0Zu6
         jDHfK5SHQHLoOQVg1nwZh1VDuFfqskX95XCoyPShSkokykBGCejXEXsrOZJ1qzSAx/rO
         mkZg==
X-Gm-Message-State: AOJu0YzBcRT/SbfCyt8X4tv/xLOdAw5w0wv64QOwQUZF68VMEFqEKhwu
	VM2UvjzDu4tZzXExbmVGNtDCa3vnmXf/yyaHdUlPr/rxB4kG8ctT
X-Gm-Gg: ASbGnct0CDP+/uaxPeLekruxg9nC+xefztD/QUl+bSYXEmZt+PWVlYW/KtXVndRkP0Y
	RwPexR/QXaFPMIR0N9u2WI0jjR1zKFcLn16HWhB+j3+ditsS4XF5Or/e8eulxp2/wt3QHabKZ+0
	clj4nf8CYIPaGT67jFfSR0B8LO3oADZ5UnHkeHYdcoJSXtIAN7Sl6UKJtQWT71Bp5eP/NTGj9mb
	SL/pEA7iyM8pFAwrfggZzq6S+3Pu708qyVDY6198HTnXZc4c5yKOIcAaSBxzU3D3AwUxoVY24TW
	SRTQh9GKCgRshuQfYTWaHmAVRqZFjNMCOeg=
X-Google-Smtp-Source: AGHT+IGs9D3pg86XqGlmPHmhgKXqjxtAm261sE5bAk9tWy9T3vo+d0kKd/A+DcFpp+fdXrK4Q2sNdw==
X-Received: by 2002:a05:6512:138b:b0:549:5769:6adb with SMTP id 2adb3069b0e04-54d6e619433mr4240819e87.5.1745351972867;
        Tue, 22 Apr 2025 12:59:32 -0700 (PDT)
Received: from parrot ([87.249.25.136])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3109075e3d8sm15166881fa.15.2025.04.22.12.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 12:59:32 -0700 (PDT)
Date: Tue, 22 Apr 2025 22:59:31 +0300
From: Evgeny Pimenov <pimenoveu12@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] ASoC: qcom: Fix sc7280 lpass potential buffer
 overflow
Message-ID: <20250422225931.7c3101ff@parrot>
In-Reply-To: <20250421193020-123e6255cd3f396a@stable.kernel.org>
References: <20250421193733.46275-1-pimenoveu12@gmail.com>
	<20250421193020-123e6255cd3f396a@stable.kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 21 Apr 2025 22:15:41 -0400
Sasha Levin <sashal@kernel.org> wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Summary of potential issues:
> ⚠️ Found matching upstream commit but patch is missing proper reference to it
> 
> Found matching upstream commit: a31a4934b31faea76e735bab17e63d02fcd8e029

This founded upstream commit is correct.

> 
> Status in newer kernel trees:
> 6.14.y | Not found
> 6.12.y | Not found
> 6.6.y | Not found
> 
> Note: The patch differs from the upstream commit:
> ---
> 1:  a31a4934b31fa < -:  ------------- ASoC: qcom: Fix sc7280 lpass potential buffer overflow
> -:  ------------- > 1:  420102835862f Linux 6.1.134
> ---
> 
> Results of testing on various branches:
> 
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-6.1.y        |  Success    |  Success   |


