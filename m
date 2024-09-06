Return-Path: <stable+bounces-73779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E768496F4DC
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 14:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0D61C247A7
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 12:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F2F1CCB34;
	Fri,  6 Sep 2024 12:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMvRo4Wn"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9D41CB338
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627491; cv=none; b=nnqKi26mUwFe5UtSIdbBgzCNJ7OdPOhMSQ8eIyznKpjL/Ko/8xtVNVcOnr/QZQLLato1HvPEq3nF7hSVfz9oVBy92SOb6puAM549Xe5iyTVJAaTNu4PC+REmoJ9SA5FRELFAqmol8tQZnqvlr/Hr3ejVnKv+0Gg9tznnlakBLPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627491; c=relaxed/simple;
	bh=i1Nwn0XSmK5ZTnfmP7suaQ37ZP54sYTUR7IvU2Fuqow=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VbOIfZ7VO9QENe46zXUUfFOSPRtEALd97j0Az4V8E3S4TsSufzplLgs73Q9umYb4THybiuYVrt6N8GSuLqWV9MoZMrgoEerCwYpx7oEHN3r8fqoQoVhzOB/wqHF21kVoNLaa6rKZz2Hpq+GURTgK96zvDLTqEhm2l5o0QWgiP5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VMvRo4Wn; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e1d0e74f484so2431816276.2
        for <stable@vger.kernel.org>; Fri, 06 Sep 2024 05:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725627488; x=1726232288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pZ4UXvk6Hc39FSBqf7SdNKy5PEKmHYp1NAIB/Pp/XHY=;
        b=VMvRo4Wn5OZkE3959QI9JstFBVcsHVLi3lcQk8TnI8xWb1/cQ4re9sLbl7kCsnzBSW
         VSMUMvZcCQJSm8Ep1d3JE+DrYrA3c7GITKC4VoxbDlxTkjRqXzHwvBwB8gbXsw+UhlGS
         Wyt936RgbMaxZjt+W37El496xbBm64Yb1dyyFY9NlDDpqMl0xC8VnOkA6bhjDC2Zqahd
         YN5uqJVoOQRowu7JjfW84dtSzfQtHhqHREbWnyCq5OcmsKGLYd6QKti93NPi3MEco0xG
         nnGgCsS7gpM7flxG+HyecDvzICxB9YD0LP7ld8eMIPgkTrsGCzIVT7tMJ9ZJbrTMbZaR
         D5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725627488; x=1726232288;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZ4UXvk6Hc39FSBqf7SdNKy5PEKmHYp1NAIB/Pp/XHY=;
        b=SB2eCwPRpJ2DqYglpFlVrS63IJpEGSLaxN9WfN6mCr24Yf2BnUeZWUUBxGfJFz31sT
         hoB+rZd5QnXBUGJecMNajuVn8nHEhIwUef+Sqevlnj2Ga3w4AU23AV7k2DEGtbPsrz9e
         6sOBg+KvtniOpJ9DMvSfop8CPuKv3/A7ek56JiszyvjeIlUVTmmX6EJ78xWm5QWXfl4t
         FsLWxnd3rUlf587V1eLXrTR0YXz4NPZnkNS8QCsBi81hCwMOhYXQPnKYNxPWwtvTyC+k
         RTzuQZnFv3ksa56MngIrM/c21ockcn/dV0tST1jFganzdXRvy/z9Zcdq0v02TDT19fmr
         sp3w==
X-Gm-Message-State: AOJu0Yzdjh9oRbO9yT45ZRugE3ry1OxLbmrGqmTmVIofg862FWjbiMxQ
	UsJKPhJ5HoMkp/MwxXPJFY1KmzeCQ53doQRNR8CQIaa/Y6j4/dyTbq4ci6SVf+8yjUd02gKBqir
	AasoQLwp8bWqqoFmClOsjgO7lH8yMWG+lrkH/UKTrf8rPVJ5viaU2ehV5
X-Google-Smtp-Source: AGHT+IEfPq+1SJTZN/kT/ogG50d/lurOKFue49//AbbEiwtDqcYrHS7wEFlOlmvzaiwpBHdDVphmTOmvHGU0aBmrA1g=
X-Received: by 2002:a05:6902:2405:b0:e06:df51:fda0 with SMTP id
 3f1490d57ef6-e1d349ef8ebmr3092635276.42.1725627488122; Fri, 06 Sep 2024
 05:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Fri, 6 Sep 2024 20:57:57 +0800
Message-ID: <CAMSo37Udb-DwXYdGp+RdvKS87-0nTXjR1Dj0W46CALspeW2O2A@mail.gmail.com>
Subject: [Backport request for 5.4.y] clk: hi6220: use CLK_OF_DECLARE_DRIVER
To: stable@vger.kernel.org
Cc: GregKH <gregkh@linuxfoundation.org>, Peter Griffin <peter.griffin@linaro.org>, 
	John Stultz <jstultz@google.com>, Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org, 
	Allison Randal <allison@lohutok.net>, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, Greg

Could you please help to cherry-pick the following commit to the 5.4.y branch?

     f1edb498bd9f ("clk: hi6220: use CLK_OF_DECLARE_DRIVER")

It's been there since the 5.10 kernel, and  this along with the reset
controller patch
are needed for Hikey devices to work with 5.4.y kernels, otherwise it
will get stuck
during the boot.

-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

