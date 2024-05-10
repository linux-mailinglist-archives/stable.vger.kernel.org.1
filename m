Return-Path: <stable+bounces-43520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD168C1E03
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 08:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03621F21A70
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 06:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD631635C8;
	Fri, 10 May 2024 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rt4inDIV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8362D15E5D2;
	Fri, 10 May 2024 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322141; cv=none; b=HxAncz2ls19dS2l4I4yUA+YnLm5Ef25iSiOeHmkUZEn6GTwM/ZilellEOTW+0MBRyziV6RNNlbxT4FFEpHbLQkgSDrIiHV0TpG/wHX5rTYmA18iJD10b9KRthwqN+2iikcMUCW8dn+pSOf3JUCK5O9VN7CQhp1C89ofoW4//Gjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322141; c=relaxed/simple;
	bh=rJwMkH+P2kMp+K73anhEb7Mia5vIe/bN8bU8gl1X3g8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uXnmarwOjxUEffTYWjHoCDs6ycvdGAC9o2U+viX73iU1O5bSXbQ+KNl9/qT4vSPCt9dWx++NXuiBnQoJ4HTFKq0DfVOtK7VT9emEvAVX9B8O/gOS6JvT5lBtc1auPxB/0GSVnB52xQSpaujAwbZpaX1h65hNov+J7xRo4Pj4Yv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rt4inDIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F75C4AF0B;
	Fri, 10 May 2024 06:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715322140;
	bh=rJwMkH+P2kMp+K73anhEb7Mia5vIe/bN8bU8gl1X3g8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rt4inDIVaWDRusVXwFCgG4ygeSdu2HaZVoTUwn3RyiQM30QWHtmZbfUh6rcxk//Js
	 6icqEZ7CHD1dE/yj23BXxNm/1f0ScYPRTQQ2WB54I2BBuOlS74lQbIHtjADCUIc3rY
	 LV2NmeApV9hu1VluymzgMvkFqvLg+++TtQkNeyuMJnEjwfzkZCZAjZOXiBOkXlb+4M
	 xFhMhN3jP0/bj19lnWJJrdeD5GXKflkNn5oV4NwFARTPvOVFVqI1NnKU7r/rpLOIDk
	 YaYN9MMBqt53alWdZ6XfSaFSmsR4yjGDRpAUnl5TaZZEmlk3sCq6AsvC8CMzNpUyeR
	 FsD2nYlj6kVQg==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
In-Reply-To: <20240509133304.8883-1-johan+linaro@kernel.org>
References: <20240509133304.8883-1-johan+linaro@kernel.org>
Subject: Re: [PATCH] regulator: core: fix debugfs creation regression
Message-Id: <171532213823.2045034.12565472524888899688.b4-ty@kernel.org>
Date: Fri, 10 May 2024 07:22:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 09 May 2024 15:33:04 +0200, Johan Hovold wrote:
> regulator_get() may sometimes be called more than once for the same
> consumer device, something which before commit dbe954d8f163 ("regulator:
> core: Avoid debugfs: Directory ...  already present! error") resulted in
> errors being logged.
> 
> A couple of recent commits broke the handling of such cases so that
> attributes are now erroneously created in the debugfs root directory the
> second time a regulator is requested and the log is filled with errors
> like:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: fix debugfs creation regression
      commit: 2a4b49bb58123bad6ec0e07b02845f74c23d5e04

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


