Return-Path: <stable+bounces-67406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 014D094FA58
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 01:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33EF21C2223F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 23:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9180118455E;
	Mon, 12 Aug 2024 23:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s5VOG/At"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A087E0E8
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 23:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723505727; cv=none; b=U17oh9b79YimkGh2BDojSmsaMLolKfBHQc/ThpIuvU8dQXo6a52Ui7pydZBpn2WhZa/rTzKZYmN6zSKoq+8eOOA8CrVXgvSm3pXtXeysqa/1FQl0zRHctWwmgrtJtZ7Y3UD/a/tqPK0WyiwpUSPdpnYuV9plbk5ubd8o7cCg2h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723505727; c=relaxed/simple;
	bh=Hy0ZvmapsHnKQsjI2/9Kuh7dY0hLrow3eJAbXthoyh8=;
	h=MIME-Version:In-Reply-To:Message-ID:Date:Subject:From:To:Cc:
	 Content-Type; b=e3OHMvLjP7T12eWnYcm1SbwC+E/zPZIm61hmnbyQs+/y2lUTRFZFXHW1KkL1XyKpJpb8KVxIfy/ojcPrRPVcd5hiuiIi4QGhr7o3c1QLx71+rGNZ8goBl6w7VM19SHPOdmNAUoP9lkypvq10SxVij0EQoY5bUz+pUCq5tyc/HPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=cros-rc-feedback.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s5VOG/At; arc=none smtp.client-ip=209.85.167.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cros-rc-feedback.bounces.google.com
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52efd4afebeso5618858e87.2
        for <stable@vger.kernel.org>; Mon, 12 Aug 2024 16:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723505724; x=1724110524; darn=vger.kernel.org;
        h=cc:to:from:subject:date:message-id:in-reply-to:mime-version:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hy0ZvmapsHnKQsjI2/9Kuh7dY0hLrow3eJAbXthoyh8=;
        b=s5VOG/At8ETWbB3/1b6nOsOCOWh2oJ+27W3lmGhPe+pAGfgOye42x6IxU0vjqpy6qK
         Kqpu99BhZ2vcoztIDXHqTfBo7KfZgwxX1BHoh2y/TjFMkTu7Wr1+d7DK9TtKpuEIUPsb
         3dApBCHKW+kyYs9dr285o+TxBA9cejhqdUA4b/9NE9VmtVDAAxDf8587qPD750CijkeK
         pbVJTufuM213vORo4OaWPccKQkswlGC2B6UzzHXXqUkqyVDtBxGXvtzIDU6fU2pvHl2o
         AmzM2o7YZA4qci7IQnZP5ZCm7sefjwRUEUwYHZyVEIsNnXZCzkOcPfoCycpC6yxNfvkJ
         va6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723505724; x=1724110524;
        h=cc:to:from:subject:date:message-id:in-reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy0ZvmapsHnKQsjI2/9Kuh7dY0hLrow3eJAbXthoyh8=;
        b=tdBAzX4ILg6Djxu6/eQZbCfWilG+RmzklKPIj9c3mnZs1ccKnS0qNSTV7B8n4PLO09
         WVyTAzSlIq/0LSx4htNoShhMyzTiX44M+43Bsg/PyZwsUwtzcbSqS3FlDInTGwy1rtPF
         38crTen8L5l9GJVKpVHDmWaWZBeQbLi5qdNPmzTjcvp1Ee9WLqkeg9EdHz0IyI0uBaHa
         foein/2DL+JoRzJXHxL5x2VxB+S55+Yd0UTsIJR1rj66Evc4DPNjnFwiA8TG9++fb7+M
         2Drzl5p2sfSPrlfCyJzjbiBZpr++Mio+dd63VIsePx8HykePllRRC3l0O8IvZ19T5fVO
         eYHw==
X-Gm-Message-State: AOJu0YyPZlMeeLjdy0BMFYw+9u87gkJF76dxDkC6olK+WJWh0TTLw+ff
	cBxdJJHGheAzHlVcDuVOZnDY8c2mnfbcG9P0NY0VlifgJ0MpgDCxtdY3LYvty+oWVhqbll/lq+X
	HfcXf7Z446rA3vcoanPPYLL7aejkWTSmV1WSwElY3/RMD+/75CnG7BjYzZXEp5rUPcJ689ZBLsn
	rQGzTuQ0Gdnj65KMFhL9ToP6hhbidk
X-Google-Smtp-Source: AGHT+IGEp+AwdpeFm4dxHYRCCnoilgVvaClqAM29tGqqDOKna6lHdwZJdY1EXP7H5dtHO2HUltCC1HJ6Z63/LBHkMWlKRjtPdAWISN57IgE25B2mOg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6512:1291:b0:52f:384:1a1d with SMTP id
 2adb3069b0e04-532136a5aa1mr3029e87.11.1723505723801; Mon, 12 Aug 2024
 16:35:23 -0700 (PDT)
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
Message-ID: <0000000000006fd56f061f84f2f3@google.com>
Date: Mon, 12 Aug 2024 23:35:23 +0000
Subject: Re: [PATCH 6.6 000/189] 6.6.46-rc1 review
From: ChromeOS Kernel Stable Merge <mdb.chromeos-kernel-auto-merge+noreply@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, chromeos-kernel-stable-merge@google.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hello,

This rc kernel passed ChromeOS CQ tests:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/5782321/1?tab=checks

Thanks,

Tested-by: ChromeOS CQ Test <chromeos-kernel-stable-merge@google.com>

