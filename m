Return-Path: <stable+bounces-28398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7E687F843
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 08:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214621F228C1
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 07:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8482C51C55;
	Tue, 19 Mar 2024 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NV1+MpRK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435765103F
	for <stable@vger.kernel.org>; Tue, 19 Mar 2024 07:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832923; cv=none; b=nDsaDvcwd2FGmiOigEgDjKbcXaAMgiVYXqObfM/ScY4HTK3ICdw4vjjdtRA3JDzJEbaiN5MsOiaU+Rjl1358U/xY02xJmuuCDaxT9N4SUfrhtLqfahYefYsWuVq97nTzCx/KxHVSqqZAO80Q3raof1tS3qT06AaVPyPI6Ixkhsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832923; c=relaxed/simple;
	bh=P8oWE9t6OZmsLWVMIX7d4dqr0ZscXMJ7aAKIhpFmJ1E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GdQKD9Qbz50fkUZCuL2hotIv8lRT6MzXE3U5lxxesx9owNlpuwppO0LrvhOtCsOLoYoKV64/AuBjACzXMN9umUOi7bEDyZgDs/x3c9L0vek5kTJEcA67CpsABpzb0S9eVJgG+qSUbeP4sId/4+ug+W/ZXdcDc8w3qtU7eG44qR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NV1+MpRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBB8C433F1
	for <stable@vger.kernel.org>; Tue, 19 Mar 2024 07:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710832922;
	bh=P8oWE9t6OZmsLWVMIX7d4dqr0ZscXMJ7aAKIhpFmJ1E=;
	h=From:Date:Subject:To:From;
	b=NV1+MpRK70EB52DtHx4YYGU61lps/wYzFihxs/Bxrod/WdD9Dg8z08/Z74iCRFxTG
	 j1PnlVM/rtWFmvX+2nY6eDFWEruDa5GsMQIyKlVS5o9gao/mmbPlEWuO73ANLWeBmI
	 o2uIyv4FyVVgco3t7aFO239kcX06s9Iyzcc3p1jC2hCXRjKbfy4zC/5cLnWwaO1/9w
	 4WQP+c9JqErJJc3cZd0073qNBhMKBeyS6eJJw0T2HfF8IYj1mc9ZDEAoR9jlAwuguV
	 lkxf0iW4EihzOCMLKtkOce5rdgBH6cpkSUR98/vrNTgT6Eb5M5RL0hAOA96ZraSy48
	 H4Nbv8uqVsjaw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d475b6609eso66930991fa.2
        for <stable@vger.kernel.org>; Tue, 19 Mar 2024 00:22:02 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw239aXRymbR/0FpRb8gMrxH/okdwNc6bii1kZlkzlOwjCCPadX
	IvJCnttd46XmXGI+ZA90KJZZl2P3c+sDym2LsXKf7XT0LOho0k7rrzlJ2uBQU774xnzLTUSmIuQ
	GLrkDVh1TVBP/HSPt018wYB438dg=
X-Google-Smtp-Source: AGHT+IFoIwVo5NmZspFYGxaNXyBNtI6jwDlrwnK7D5juBBxJyz6Gpd1dRXZWR1opFeyduO11qyWtLOr5917JcJwl8OY=
X-Received: by 2002:a2e:3c1a:0:b0:2d4:6c72:97fb with SMTP id
 j26-20020a2e3c1a000000b002d46c7297fbmr1257443lja.26.1710832920942; Tue, 19
 Mar 2024 00:22:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 19 Mar 2024 08:21:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGE5OuqY8=F+_YV0p0mY2wjkdkh3L9-i-3z6tfZdmYMaw@mail.gmail.com>
Message-ID: <CAMj1kXGE5OuqY8=F+_YV0p0mY2wjkdkh3L9-i-3z6tfZdmYMaw@mail.gmail.com>
Subject: stable backport request
To: "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please backport

b3810c5a2cc4a6665f7a65bed5393c75ce3f3aa2
x86/efistub: Clear decompressor BSS in native EFI entrypoint

to stable kernels v6.1 and newer.

Thanks,
Ard.

