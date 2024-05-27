Return-Path: <stable+bounces-46291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702D38CFE9C
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 13:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E931C2107C
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 11:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A2813BC1F;
	Mon, 27 May 2024 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="kI7BqML7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B27249FF
	for <stable@vger.kernel.org>; Mon, 27 May 2024 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716808275; cv=none; b=ORRtPlfMBjhhPYqHcxSqSZDMM45VllimuHNQsNZrLGxaNRX8AIDOXf4PnqRYO7n6pDO6XABajddZj5MYtrODLRTvP/w7nJNbLc4NUKfC7dsUZf/DOxh2WOrLzykqvVmXVXQQe+8/kKop7sVMGoiVzU2ltGGLL8dzg9fICuXtmF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716808275; c=relaxed/simple;
	bh=iXkGcMZbP88UzAo1e5KtvVcxwQyPn6GChRIx3IT263w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ez/wvFzc64eNTj/jMoFEgvXsw/sw1tFUFtADHZfId6OIEGwSeendCYAb0V0BBJWzy5bQXj2Tue5yl1OO9D09Lmm4dbHjG1GPGp0a1KuYeUIQK4DAMvPdPXReLLVmPsK+a3JguDXdA5rsZmCPCoywumonaHtHS5fzpBspB3EoXQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=kI7BqML7; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57857e0f462so3085994a12.0
        for <stable@vger.kernel.org>; Mon, 27 May 2024 04:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1716808271; x=1717413071; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JqVPmqMW3RwT9jY3UHYAlf2fizqk84xYkUyQh1OxMIw=;
        b=kI7BqML7AjpVLBArfiN1t5uzHowcVGgnfuXqBOoZBb+6zYY70f2X5sZMBABG1NUoKu
         8ghrr4JXpQRx6j30Wg+It8R/rUM/ngnr1ciK5pWw6bKEQ06/3w1vcTNfurp5lHDOXa8J
         w126UqzzjZehcEaQtcrTRCtd8ykBPwIXO70FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716808271; x=1717413071;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JqVPmqMW3RwT9jY3UHYAlf2fizqk84xYkUyQh1OxMIw=;
        b=SSDZ/j+UJCgTfyAfW/H/VD80+qfwe7gKShm7OtX0DbX8d2sSw0hYRrWhRIKCAQQ/TU
         1w7D6+BOcByaxkE0RSzCWAzOwGMql7IO2TF0DrBwJtWSaaznf+GGL/RdBX7wlPC7Hf+m
         ehfUi99WFhneel7e+4pmm1ZOcjjgjIvvWEIwc27EoSVze2bwzuSsuuxYGN0y2cjJZEwF
         a81ETlcBPW7+AZ7Z6IHVSreSO7obr+Nc4TV8a/RL6rJAo6w+4THi28I2D7RiCyWnO9sA
         loVTlyUXzFbBE7pgY0W87GRKyIEpGEi5lXu7SYjiJjx7NaBn0XrdEq0E0S7gtUb7opIQ
         9sRA==
X-Gm-Message-State: AOJu0YzQZ9t6+hNzqacIqmtwBVt+p+UnpfsMP+/HuPR4JVvzQ9N6QlOA
	p90+dRlfYcjDrk27Tn7M6LISzqntaq16kaOgfGuwzJDcRtbTycIJqS6l2OC+qw/89RzCzZpw+/r
	FubqAp4qCw39L4WOiHELgo9RSXQzOWJcU8RN5sFSwvKHdDJHcBfRgmw==
X-Google-Smtp-Source: AGHT+IFK78sbj8F9aYzF43BQ+0nyAttrwZuUMXQGpdkKZGmyAWergBhJTSzj15pnQQ9wWK0ghTjBEdwS0PCwFXtNtX4=
X-Received: by 2002:a50:9514:0:b0:578:6c19:47fa with SMTP id
 4fb4d7f45d1cf-5786c195f61mr4235979a12.22.1716808271471; Mon, 27 May 2024
 04:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniel J Blueman <daniel@quora.org>
Date: Mon, 27 May 2024 19:11:00 +0800
Message-ID: <CAMVG2sv-ZR5UET0wDQM_FvNsARSgrtPsyn+PBzX-U91ainV7nQ@mail.gmail.com>
Subject: x86/tsc: Trust initial offset in architectural TSC-adjust MSRs
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On present kernels, HPET fallback occurs on some 8-16 socket x86
systems due to the TSC adjust architectural MSR not being respected.

This was fixed upstream in commit 455f9075f14484f358b3c1d6845b4a438de198a7.

Please backport this fix to -stable for 6.9, 6.8, 6.6, 6.1, 5.15,
5.10, 5.4 and 4.19 branches to allow correct TSC operation on existing
distros using these kernels. The patch cleanly applies to all of these
latest -stable branches.

Many thanks,
  Daniel
-- 
Daniel J Blueman

