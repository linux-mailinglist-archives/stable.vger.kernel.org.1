Return-Path: <stable+bounces-207956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F91D0D4DB
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 11:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB3683025A58
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 10:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F16E313271;
	Sat, 10 Jan 2026 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHlLmRX4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3856C312805;
	Sat, 10 Jan 2026 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768041596; cv=none; b=EhRXmIJEGpvhzLFlRteE+25UO/NOuWaNoouMvscuW52d7872FNtlChUceG9+hVLztYabq8hX3XqfAA9uNK1/xlR/mEa/oNsKiSo+uuIvCVnQV1fK9+4UPridmRgpxikpGRd9wQiSuWaBEy3rGhof6jRkxWndqriYsRTs9PB0tJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768041596; c=relaxed/simple;
	bh=dp45UAvDX3D+LDpNdQ7rxwJJ7Dat2HjMmkqIdx1vX/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TiqIYk37Epdd32v1he7JOXHO9iLjJ8iszUkPRRYntu2Slk1WgagBo2bnzvzVIzeweR/4b/er0KKKeq2JIgI0RLFQ4J5aJC91uLah1EGaClz+VKm7/OVYRAanAnCQj74Nfb8ddg59Xy+WJTpEP5K4G8ELonWD+Ki3y+qxQh2uSQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHlLmRX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EBBC4CEF1;
	Sat, 10 Jan 2026 10:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768041595;
	bh=dp45UAvDX3D+LDpNdQ7rxwJJ7Dat2HjMmkqIdx1vX/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OHlLmRX4hLNZ3b0RgWa2z/hDviakBqbwIpUCxsoeWH+LbhiKvekoYBvExUtGcP4kP
	 0cgqeuTs2SUdaO1wPL6Sn3vnCTMraE1ycTZXF8IEi86nzZbDYtp/Q9iSR5wobFYYya
	 /eAnMJQpdeJyu6ugVvtzNpGzEBYpDYefdGZTwMYbxmuKlyUNuH+s2iizZjv98U6L/q
	 mYWUApHO5qIdyL7rfySj7u2z/0soNGLBH6h/eM4RnjH6OZ4g/IKxY8wVkWL7IT/4Vs
	 Dopxr1Da8O8ZmRtJQLLY0ZxQDdqF2Dq7Xdr+hf9C+BwppCmMuST3dMIqxyKJkmzdDY
	 c8/qJHjD2Mt5A==
From: Sven Peter <sven@kernel.org>
To: Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 0/3] arm64: dts: apple: Small pmgr fixes
Date: Sat, 10 Jan 2026 11:39:36 +0100
Message-ID: <176804152717.3568.6544517123602866395.b4-ty@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108-apple-dt-pmgr-fixes-v1-0-cfdce629c0a8@jannau.net>
References: <20260108-apple-dt-pmgr-fixes-v1-0-cfdce629c0a8@jannau.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 08 Jan 2026 22:04:00 +0100, Janne Grunau wrote:
> This series contains 3 small pmgr related fixes for Apple silicon
> devices with M1 and M2.
> 
> 1. Prevent the display controller and DPTX phy from powered down after
>    initial boot on the M2 Mac mini. This is the only fix worthwhile for
>    stable kernels. Given how long it has been broken and that it's not a
>    regression I think it can wait to the next merge window and get
>    backported from there into stable kernels.
> 
> [...]

Applied to AsahiLinux/linux (apple-soc/dt-6.20), thanks!

[1/3] arm64: dts: apple: t8112-j473: Keep the HDMI port powered on
      https://github.com/AsahiLinux/linux/commit/162a29b58c5b
[2/3] arm64: dts: apple: t8103: Mark ATC USB AON domains as always-on
      https://github.com/AsahiLinux/linux/commit/f15cea4e84ae
[3/3] arm64: dts: apple: t8103: Add ps_pmp dependency to ps_gfx
      https://github.com/AsahiLinux/linux/commit/35e794fefd47

Best regards,
-- 
Sven Peter <sven@kernel.org>


