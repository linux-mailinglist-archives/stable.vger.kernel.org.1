Return-Path: <stable+bounces-136701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA26A9C8C6
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 14:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF314C5D2C
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 12:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3924424BC00;
	Fri, 25 Apr 2025 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrTQkfhR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F4A38DD1;
	Fri, 25 Apr 2025 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745583447; cv=none; b=XIbUSPZ7d2taJ9RCCkLgbmRsRB4YvGMYXiTuYxsKES1wEiN0rcxn0kpX4BHpw1JaEHUH17pGJUKNECHgZMr9sjUYj7U9ROAYG05o+C3HDnCF53DdCufpx0AO7P02yRaD3JA67lCcQ1BMuxKkVwYXN3ANQ3zJBG2Xa+O9uNiT/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745583447; c=relaxed/simple;
	bh=doZ6qDg+DbMAdbR2WmMDGL0y6rqGhwvvHGOPXHeICvg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XfC2BqRhUoV89+4+ooFaaJwTbp4UGOQZHCkzc80f8RPeXSqxGk5YL+c94z26KDDh4VhVVXtwc40pamMw9vKHXUO4qaNaxhuPqtKwIAtL9h9bhyds+LsN1tWxtMsls1j9tHSyJSQlEm1FmAMCploqVXxsBg2uQmh1IK5HpZTfR1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrTQkfhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7D8C4CEEB;
	Fri, 25 Apr 2025 12:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745583446;
	bh=doZ6qDg+DbMAdbR2WmMDGL0y6rqGhwvvHGOPXHeICvg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hrTQkfhREHEQrTBngdq4FzGBs04WnOfpesHXqkZTIgR5zS4fORwuqnvaT6O5cPQk1
	 FQ/bAruUnUvTU6+wBMhsEDFibK930AulpcpVNgDoP1X0WYMBGO87/dgoea+WS9+W68
	 FkmTJocHck5b/A64LFtSk63boY49y1SeNDq0pMzqPT58J3f+1xy0BucuCJDi1XR6l/
	 NGNUQmrgQwYXcEUgmZKigoP4uwXFghthd84y+0jVPlQmdSmfmmB52EVxEC3yAMlLua
	 6/i1yjsF1OYsfAaK9zIU8j8KR6K0tl55vKjBBJZ1GKwSMiI8SC3TxzwjvtCGRCJnvO
	 eiOexV9/w5brw==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: jbrunet@baylibre.com, lgirdwood@gmail.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Christian Hewitt <christianshewitt@gmail.com>, stable@vger.kernel.org
In-Reply-To: <20250419213448.59647-1-martin.blumenstingl@googlemail.com>
References: <20250419213448.59647-1-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] ASoC: meson: meson-card-utils: use
 of_property_present() for DT parsing
Message-Id: <174558344482.35587.18106901736438016481.b4-ty@kernel.org>
Date: Fri, 25 Apr 2025 13:17:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Sat, 19 Apr 2025 23:34:48 +0200, Martin Blumenstingl wrote:
> Commit c141ecc3cecd ("of: Warn when of_property_read_bool() is used on
> non-boolean properties") added a warning when trying to parse a property
> with a value (boolean properties are defined as: absent = false, present
> without any value = true). This causes a warning from meson-card-utils.
> 
> meson-card-utils needs to know about the existence of the
> "audio-routing" and/or "audio-widgets" properties in order to properly
> parse them. Switch to of_property_present() in order to silence the
> following warning messages during boot:
>   OF: /sound: Read of boolean property 'audio-routing' with a value.
>   OF: /sound: Read of boolean property 'audio-widgets' with a value.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: meson-card-utils: use of_property_present() for DT parsing
      commit: 171eb6f71e9e3ba6a7410a1d93f3ac213f39dae2

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


