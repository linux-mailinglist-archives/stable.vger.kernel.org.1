Return-Path: <stable+bounces-89573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1147A9BA263
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 21:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476841C21B2A
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 20:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193971ABEA0;
	Sat,  2 Nov 2024 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d90hMuzB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AFE189F5A;
	Sat,  2 Nov 2024 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730578168; cv=none; b=VuhIDfiXBqfx/vnVb/mdMiNbm1frKfOuKG/J4+TDeUoJIxYvNzUDM7fg+3R6L2aQmQFQLONv5bFhEhnG6NqRNsCaNIoPK2obeMvREc2ywKgXGcdYCFRbfpZnGV2nsqCRqyR/gwGWjZa2CORlcQmRpJcsGpkTWig334CqHL11vh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730578168; c=relaxed/simple;
	bh=zgksz9s1bG4ueYcirt3fqcKq1nNzoJLO4iph4NdY0Yw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKaMUKD/zxssktjaLmP0/qYNkWSJnyWXRx5JZI9f4PVKfg6OvDMqL13TxExaY2Fk2l6DKCs9L0F5nk/OgE1LX7zKX/iggkqxrMwEOnqgu60JLGDJLrgpNQ5lHa6xNYcTyov2PTkCZQQtf0ODcqwsBUVfhAhfp3hBsewH174oYrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d90hMuzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C14C4CEC3;
	Sat,  2 Nov 2024 20:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730578166;
	bh=zgksz9s1bG4ueYcirt3fqcKq1nNzoJLO4iph4NdY0Yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d90hMuzBwrHdx0loVL54+Tn9PjYGzSSByJziUPp+tsAs9tT14j/eGiP6R1swFJhtY
	 iTQGWjms3fcRCZvQq/8t+3vCGh7YL5me17/AZFXgUQ90267AQ5c/grUfxVN6x0dI0G
	 +bzpWpTZvc8mKlUzKb/NfDdlTCPdq/1NTu+E9GYorTy+KIERm5sOOsiQXb9kTgK9Er
	 tthymMflrAh3kyfTTjpKGNw88PJZOr8F3A6CS/uMvxQakjlXGRBBTuUuFO1kY6eB2g
	 +j4V+zwMtAB9lI2loiz2d70pChiEXl8KK9J2ESBhmr4tyVsPbQFYlY/J6TzJpezcOR
	 C458DS3kxospQ==
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] lib: string_helpers: silence snprintf() output truncation warning
Date: Sat,  2 Nov 2024 13:09:22 -0700
Message-Id: <173057816122.2383427.17386979359924647248.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101205453.9353-1-brgl@bgdev.pl>
References: <20241101205453.9353-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 01 Nov 2024 21:54:53 +0100, Bartosz Golaszewski wrote:
> The output of ".%03u" with the unsigned int in range [0, 4294966295] may
> get truncated if the target buffer is not 12 bytes. This can't really
> happen here as the 'remainder' variable cannot exceed 999 but the
> compiler doesn't know it. To make it happy just increase the buffer to
> where the warning goes away.
> 
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] lib: string_helpers: silence snprintf() output truncation warning
      https://git.kernel.org/kees/c/a508ef4b1dcc

Take care,

-- 
Kees Cook


