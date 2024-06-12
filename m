Return-Path: <stable+bounces-50190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A3D904906
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 04:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E39AB210AC
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 02:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5FC1CD38;
	Wed, 12 Jun 2024 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="If4E4wqj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678251804A;
	Wed, 12 Jun 2024 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718159432; cv=none; b=fZ1XHB+3mJySkTV90JduInJx5JoWeEGznFy0nnQzAqTwbpXPMVn1Esf3TNQL2jcqIhyFNDJww8WqBRfyE5Hn7b9GicWJ6HSJL1bN/75MiC20T+8QgiBQk9Jkk2Z9QbnAmtdQDEsAd4+ruviAd+Jd46ox7FNZh+J3A2oNwLerRD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718159432; c=relaxed/simple;
	bh=oe/vlcdGQmfyE/zG7tYganammuOgKBrVXvsFAB0U1KQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DqcwPjoBMpHoeUrzoTGu8yWZVDjOL8qHFLZpeuTmw0dBQzcS4YCTIuM71numhUFVAS8Sto5/Cr48VXRVB9b0dtB1diUVwzmvTQxUt4DDOYYlgX3y4vq39YkmxKTffxTX3QxnDst+S2k4tSgu2RrDIDPXKo1vDpymN1RzlhQ/aLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=If4E4wqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1BC8C4AF4D;
	Wed, 12 Jun 2024 02:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718159430;
	bh=oe/vlcdGQmfyE/zG7tYganammuOgKBrVXvsFAB0U1KQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=If4E4wqjZyKsWbSH/azlZCvaWevC1caUsPPICvqobeB8+HJNiow+WGDjfnaC5uuGr
	 kwenHlhLx3XOOb18O0ElYp9I8HsPZY3B0X1A6zAimYrw4129bbYAwVGHsQq0u2vrKS
	 l6Bpxjo8fIdrghDGLpX4Qu6cfIIlXfZ7Ihg6fz4788hpKacKB3cXQIQ/e9JtpDwi2m
	 JXdS+UX58m8yE7KeM/K7CjNo0LAeGGEY1T2O7NbgN82tJxrtJ5DjNGX3nzdI7ApGH6
	 VRjADUNGJEaHB0zfrRJ4gErqvWXDE7n/MH4eHDoIXC6/97pB9xBuHbPja7UIAtSQwK
	 zH5mLvo4kQrNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7A31CF21FA;
	Wed, 12 Jun 2024 02:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_ec_debugfs: fix wrong EC message
 version
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171815943074.29023.6658122810617260075.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 02:30:30 +0000
References: <20240611113110.16955-1-tzungbi@kernel.org>
In-Reply-To: <20240611113110.16955-1-tzungbi@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, groeck@chromium.org, chrome-platform@lists.linux.dev,
 stable@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Tue, 11 Jun 2024 11:31:10 +0000 you wrote:
> ec_read_version_supported() uses ec_params_get_cmd_versions_v1 but it
> wrongly uses message version 0.
> 
> Fix it.
> 
> Cc: stable@vger.kernel.org
> Fixes: e86264595225 ("mfd: cros_ec: add debugfs, console log file")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> 
> [...]

Here is the summary with links:
  - platform/chrome: cros_ec_debugfs: fix wrong EC message version
    https://git.kernel.org/chrome-platform/c/c2a28647bbb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



