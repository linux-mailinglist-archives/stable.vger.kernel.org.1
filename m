Return-Path: <stable+bounces-124090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A898A5CF1F
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 20:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000273B2348
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024E4262809;
	Tue, 11 Mar 2025 19:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhzgNZ4k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B319F188915;
	Tue, 11 Mar 2025 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741720666; cv=none; b=LqqWb8Zgk2eHSdy8mfQBqXwd40ffF5hcWBJADsegGA9gv50Cr5trV6xxCYmFbtpOvLnXjALqA3S/gpcOFGJaz75pEUYU0IjHlKvEAK5o90wyQ+UNjFhZhG6PfwujFDAmYiswSOmwfuCxMfLFEshn6OQQsMajPYL8iWvugwpZCII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741720666; c=relaxed/simple;
	bh=Rrhem/4TadYScfoMHUjq9NIf/1Hx6GlTEg/zosNSBpw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PL4sqC1V+Gd0ZPBTmuX3k16lcxl93y7YeQuGzsliF4URfu9gft9+aYdJwE2npZ7YeocrlkEbQWNl/53ItXqACX3ZiE3omUHPWIXf3InDcZhk85wlEUTYET0U/uenK9Whldke6dDzOKOaT7ZxMP2o6hGGWwZfJ3rhCqmFeCyafY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhzgNZ4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B046C4CEE9;
	Tue, 11 Mar 2025 19:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741720666;
	bh=Rrhem/4TadYScfoMHUjq9NIf/1Hx6GlTEg/zosNSBpw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fhzgNZ4kw2TG38pKJXEnneAGFla38j1BXJKWZhB+GWPtl9fUBJwWZur2cWF6KB5WL
	 swca5A2A7jrpwk3Dc3lBhNEexcyuuQvQnNSM82Jzw4fVUlqKZmL6v3tJQbgu0TBt9w
	 DZGRYHETurVuKbSATEP8zQHpLUjh9vq3tzXlly23rYWj2Ohi5r5oRKrhdo/oIg5L+c
	 m9FXzL5EbRQlxUNniMwwQUmonJgrOxZKirCQjXEAwchNIBnlgPlO1M3M3nO/OLyrhE
	 QCC9wvv01Guxsf+whBKY530QWKyRXNrZdmfVlNJ67tlJ3WdjP014XRBDmNC8LbaB89
	 P7nZpr5F0nOwA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>, 
 Christian Eggers <ceggers@arri.de>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250311091803.31026-1-ceggers@arri.de>
References: <20250311091803.31026-1-ceggers@arri.de>
Subject: Re: [PATCH v2 1/2] regulator: dummy: force synchronous probing
Message-Id: <174172066480.347000.17075085482466373426.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 19:17:44 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 11 Mar 2025 10:18:02 +0100, Christian Eggers wrote:
> Sometimes I get a NULL pointer dereference at boot time in kobject_get()
> with the following call stack:
> 
> anatop_regulator_probe()
>  devm_regulator_register()
>   regulator_register()
>    regulator_resolve_supply()
>     kobject_get()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: dummy: force synchronous probing
      commit: 8619909b38eeebd3e60910158d7d68441fc954e9
[2/2] regulator: check that dummy regulator has been probed before using it
      commit: b60ef2a3334ca15f249188870fc029ddf06ef7c4

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


