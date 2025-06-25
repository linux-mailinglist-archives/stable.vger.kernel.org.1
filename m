Return-Path: <stable+bounces-158557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE47AE847D
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 15:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6E63BD437
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 13:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EEF262FC5;
	Wed, 25 Jun 2025 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVE0CaJ+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234E32627E9;
	Wed, 25 Jun 2025 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857634; cv=none; b=gZqRk8yr5F0h8+55spyX5Nd/kYrkdTC3mmg9biT8YV6qtgMjtz4SqSwo6FMQqTlgV1aGDMlXSh6S00fWgan7r1tcaOjFtxcwjt+CgmLzUwPFemvbUdTlzAMF6IAYxEx4ezu4/sVImVTROrHwxvPPziGnAAZ9WcGo5V+hI/zGFaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857634; c=relaxed/simple;
	bh=EWBsJf0RFWLnL8G5Ts1cRwIaQph+PvDjEzbM/tZiU0A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NRwynIMsAetBGGzLsCqGWuEFOY8w0xW2/8fBIEzKJSZK598nNt8ErpIBDO847/GV+R2Fe3j1OwnJETTM+XYwYlX0VNR4+wXjryrz586GHjFz/JPP5lSoK36ScoS9Ns0tX3CLookSvYm19fx34PJwKFrRU+eWTuxV815lNFE0UPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVE0CaJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6829FC4CEEF;
	Wed, 25 Jun 2025 13:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750857633;
	bh=EWBsJf0RFWLnL8G5Ts1cRwIaQph+PvDjEzbM/tZiU0A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MVE0CaJ+Ldp6NoyAB1DA3ScR7Ct5PjaeKP2+Hu7TQE6i8DD5wFRKZ5dy5zz8s/+te
	 5TtnfzoiHfT8NdMkgiajZxYWJ/iNbjCpyietr7u7lxcc+T/sGp3WB4RsRdlqcc8Ntc
	 G2tL4lDgqdzJeoV1R+KGokLrf2zVy350OJ9e2KNTQph2pZCKC/JkDoE8Y+0eiwnAEe
	 C53gujKaT6XZ/S0q3fZ09JaTdB3c8N69d6q1/V1QMwo3pVAlxrHoO5akpNAjMRUPTu
	 6LsKf5MeZk3gq5kOFkdohgSuvb6Rpkb9RCuZwrZiqXuCBTmV1j2Xb3f39CbpcJokic
	 f/sYqmfNiUQVQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>
Cc: stable@vger.kernel.org, Andy Yang <andyybtc79@gmail.com>, 
 linux-ide@vger.kernel.org
In-Reply-To: <20250624074029.963028-2-cassel@kernel.org>
References: <20250624074029.963028-2-cassel@kernel.org>
Subject: Re: [PATCH v2] ata: ahci: Use correct DMI identifier for
 ASUSPRO-D840SA LPM quirk
Message-Id: <175085763212.1222616.11590478108629299286.b4-ty@kernel.org>
Date: Wed, 25 Jun 2025 15:20:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 24 Jun 2025 09:40:30 +0200, Niklas Cassel wrote:
> ASUS store the board name in DMI_PRODUCT_NAME rather than
> DMI_PRODUCT_VERSION. (Apparently it is only Lenovo that stores the
> model-name in DMI_PRODUCT_VERSION.)
> 
> Use the correct DMI identifier, DMI_PRODUCT_NAME, to match the
> ASUSPRO-D840SA board, such that the quirk actually gets applied.
> 
> [...]

Applied to libata/linux.git (for-6.16-fixes), thanks!

[1/1] ata: ahci: Use correct DMI identifier for ASUSPRO-D840SA LPM quirk
      https://git.kernel.org/libata/linux/c/3e0809b1

Kind regards,
Niklas


