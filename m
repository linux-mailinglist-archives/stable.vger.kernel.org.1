Return-Path: <stable+bounces-152619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E03E0AD8C93
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 14:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6D6189A0C5
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E00339A1;
	Fri, 13 Jun 2025 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Op2Pfa3w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BBF1CAA4;
	Fri, 13 Jun 2025 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749819224; cv=none; b=DE+bHDoUCoUxlNc8sOEFMPfG1mF7M6vCQJJYEMqvKFwNm4vjTbMAkPZAIGrTPCR20vxv5MidPOHnVqgGeVptasmDBgb8bBuhQOu44iJzTUlSGVuhGwbQA2+/peGrBHft7ilGFNsRqlPlEZqyihfsJJbFg2BRBCZtj4+1BCasMyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749819224; c=relaxed/simple;
	bh=mjRwAhduECmKL7BbwbHbdJuhtcQUADum3aY+bJ4P88A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PyPUCKvdctkIhu8BxoH+yWgyUJ5d+Wr2nA8L2hQUgw5dX1mjTNijS7j9+9q3H9aqrMk2/U+9DLfq0P7SeM4PZF1yy+lhKtHBL+0uBMu5QtPQeC4pA4oh4Hi42rutB40RiQ+Bk9vF1fEGSEsHvPPq5Psr/XD6PmoacUKmCfcbdZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Op2Pfa3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0459DC4CEEF;
	Fri, 13 Jun 2025 12:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749819223;
	bh=mjRwAhduECmKL7BbwbHbdJuhtcQUADum3aY+bJ4P88A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Op2Pfa3wdGbeThKR/0sTnmIX88tz0gyMDyXmmC/8f4CnZe6wfKzoNBsc/u1wb4rLP
	 Tj4ireSpdQhycj1lP1nHrCt8uDYJI8ML/njcJ9lLHzzAk/EjXFbcuU3wXymo24Lf0a
	 dmPw8LsHrnLrVcR4Y37Aw3nhfvjFYfRcmMpxd8VrNsrBeJYuPLklBDxg3wVxRhERyO
	 W9gqoD/jiY1/wUmKJT4sEc/uflcXtneSDcvVoz2Uvejs/y0ZzLvGXzB1DjnUnvX4aY
	 FH/z2gUF8dbi6VP4usy2k1AnBUoi8faPg2hgki8UFC4nFFpevvZxPG9055FvZOd65M
	 0wBzIc3IyREKQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: kernel-dev@rsta79.anonaddy.me, Hans de Goede <hansg@kernel.org>, 
 Andy Yang <andyybtc79@gmail.com>, 
 Mikko Juhani Korhonen <mjkorhon@gmail.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 linux-ide@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
 stable@vger.kernel.org
In-Reply-To: <20250612141750.2108342-2-cassel@kernel.org>
References: <20250612141750.2108342-2-cassel@kernel.org>
Subject: Re: [PATCH v3] ata: ahci: Disallow LPM for ASUSPRO-D840SA
 motherboard
Message-Id: <174981922174.2204385.10727867277998165121.b4-ty@kernel.org>
Date: Fri, 13 Jun 2025 14:53:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 12 Jun 2025 16:17:51 +0200, Niklas Cassel wrote:
> A user has bisected a regression which causes graphical corruptions on his
> screen to commit 7627a0edef54 ("ata: ahci: Drop low power policy board
> type").
> 
> Simply reverting commit 7627a0edef54 ("ata: ahci: Drop low power policy
> board type") makes the graphical corruptions on his screen to go away.
> (Note: there are no visible messages in dmesg that indicates a problem
> with AHCI.)
> 
> [...]

Applied to libata/linux.git (for-6.16-fixes), thanks!

[1/1] ata: ahci: Disallow LPM for ASUSPRO-D840SA motherboard
      https://git.kernel.org/libata/linux/c/b5acc362

Kind regards,
Niklas


