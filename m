Return-Path: <stable+bounces-208206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD82BD16176
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 01:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 702B9301E922
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 00:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0366E23817F;
	Tue, 13 Jan 2026 00:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmivJll5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3D021B9F6;
	Tue, 13 Jan 2026 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768265611; cv=none; b=Ijs17ZbqfCkbFf+UCwzx2gN8cmR04RroCSG9DXfdvaqW1ciPizi84FeV+PGRbwgd8dV4miG/4ghUEWEE7clHPX9b2lMNad9lw/5/3KFnm1K1M5uoWsTIgIxjo1hmSp4i6fLsE2CaJY7IPtnLZ3W8xtGOjweuuOli2/NBfj2pTvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768265611; c=relaxed/simple;
	bh=EvvB6/WbIVvCrsHcEq2SG+Kse8Izaug3kCrqUhEiGSo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OUhrQciDZGCz5YpFEu5Gh3/uCWvvrKJsrAFLtm/KgGO0Q8HYnFQ5BHAsX4f1i3+d4FXA2l7OwxENONTPG3aTJeXpDz/A0gmRmQElf/eNSrUKA24PZUbHW3d3B9AvvqIrASaThndSBfXpuUoy0wWqXgFdgvo5WLlYE7JVw823WO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmivJll5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0988BC116D0;
	Tue, 13 Jan 2026 00:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768265611;
	bh=EvvB6/WbIVvCrsHcEq2SG+Kse8Izaug3kCrqUhEiGSo=;
	h=Date:From:To:Cc:Subject:From;
	b=FmivJll5UiQtl59+17eVl36vj3k0407XPme34niXvDS+MpUjpbA7YLttwf/efwpRO
	 KSNo9RGuLhkaQ9BC1ItKDaPd6IsClkgvwyQDcGolzN9YCN2gDvGPT8hN/GfGKbR+cc
	 ybrzvtws1Zjo5PY7Iq/WFOCKFSn1q409Ixi8rlcAXiD0u9jEB42l1Ij9IN75m+UnPS
	 +joB9L4E8OeTQXTDw2rxszKQqt4tJFTqpvItfUYuIxjXncEw2PYP56ibnDrnph5+Ol
	 uKq5/tRQBauywj2UVs89TwQC0eThI+ezT12TDEzIvTZwBYrr75HYuZtazkBEu+Lwlm
	 7BZaE2qgs1rwQ==
Date: Mon, 12 Jan 2026 17:53:27 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Apply 70740454377f1ba3ff32f5df4acd965db99d055b to linux-6.12.y
Message-ID: <20260113005327.GA2283840@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg and Sasha,

Commit 70740454377f ("drm/amd/display: Apply e4479aecf658 to dml") was
recently queued up for 6.18. This same change will be needed in 6.12 but
it will need commit 820ccf8cb2b1 ("drm/amd/display: Respect user's
CONFIG_FRAME_WARN more for dml files") applied first for it to apply
cleanly. Please let me know if there are any problems with this.

Cheers,
Nathan

