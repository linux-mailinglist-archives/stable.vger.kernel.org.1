Return-Path: <stable+bounces-134893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB121A95AD7
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D46175414
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EA11624DF;
	Tue, 22 Apr 2025 02:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X71I1xhZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46B933C9
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 02:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288144; cv=none; b=EbOKTW1UwqIFTwy2hdr28uxjTGR3AUAOWJG6hUFoptNVMs8UbnNW4y5UeJDHAXEDLHQONCWm72/Xa3m41qS6M/XKxmnrCr0LFhjA+lj1Aezh1ymUSCM364RfIH600wR+G9ZOh0N6VFZQXKnnYe+yjqB34pTGW6ZPNt3e7Ztb+s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288144; c=relaxed/simple;
	bh=9YP0e4WA6dGN53tvZhg4jwIrrAnKxcHCv0MgVrMwYY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YaaKN5+MuTPSUQkUXWubDFVOhnXFivgBdOxv/AS7v662WiAlU2JvWrigjN+mQRJKW4Tag2VE2sHlTb57wkDwzB3cUwSROypoMhzvXAI17jqODUOaI9lu6JLPPIGR1lWFsJo/+xTmCGP+Kj9RUw3Re13Xu0hhdZWGEC5XbwY2yec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X71I1xhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8202C4CEE4;
	Tue, 22 Apr 2025 02:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288143;
	bh=9YP0e4WA6dGN53tvZhg4jwIrrAnKxcHCv0MgVrMwYY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X71I1xhZiHrohTqBPPN/tVmIBhqGIOcLqTvUwM8NRvlspfFUHun5oVjSfX9XjM57O
	 5+xWHbJ04C208wAngeYPo5oWBljtAHxtzsbUMap1/Jmqgf+b3tQ7KsqW/+Wv/SbQCC
	 JJ8jg+rGymudNUqY2g0CtahqZEZ/VOAqlQ870YHOB7AQaeiKMyL9YJvydBqayMmTrs
	 4hpVrrDA8F2IzSmQhLMxuOww+5sS7mtwp28ZaZ4pUe1Mea/R+dSh53QeD47X6e+Nyb
	 7nP3kyIYQ6nTeVzq+FVVsGA1O6dAUVF8nlZK9fp9J9Wa1aAuUqLJSvcYQjx9Srrejb
	 cYomzJIUIx0cQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pimenoveu12@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] ASoC: qcom: Fix sc7280 lpass potential buffer overflow
Date: Mon, 21 Apr 2025 22:15:41 -0400
Message-Id: <20250421193020-123e6255cd3f396a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250421193733.46275-1-pimenoveu12@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: a31a4934b31faea76e735bab17e63d02fcd8e029

Status in newer kernel trees:
6.14.y | Not found
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a31a4934b31fa < -:  ------------- ASoC: qcom: Fix sc7280 lpass potential buffer overflow
-:  ------------- > 1:  420102835862f Linux 6.1.134
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

