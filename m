Return-Path: <stable+bounces-208283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0B0D1A21C
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 17:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D53E4300DB19
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 16:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F762F12CE;
	Tue, 13 Jan 2026 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XedH2MOI"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C792A3446A7;
	Tue, 13 Jan 2026 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320882; cv=none; b=uaKtblZBA1kg4+1yFdDimsmPdyWdpWLwNFQ7kzQadham0AKYCAM41ph6R1zRRT5vLxtFBiOJbYYS/FSQ+WQ1cxT2ItuQRQJtUkWxMAE0saCcWKzYoB6RjXY1vwj9feeUQheYjkr5BP+vEcO9RiUcVIDVp8sjlak5+paxhK3SGGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320882; c=relaxed/simple;
	bh=2YW3/cPoutnCooMdmymtn+e337rPX1kRy4+1I4m7VUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uDnC7maWYt3tjHeChReuZccx2L+1DTbr2HtMhQMZ2eWepJpJGFzZ1lFfCqNyR60g7EW8IDMrBwuwiQ49kbOt+ZwGhFTTPwBuatY9U3eqFFmXJpEdSRErjNWIq/3qh2s38Cpv6KuMGCrC82o3O4c5mg6LWpGt6zKhZiQS+Gp6VKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XedH2MOI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768320877;
	bh=2YW3/cPoutnCooMdmymtn+e337rPX1kRy4+1I4m7VUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XedH2MOIpcd6couG9mkaZ4Fl8l1e6a/voT52yGUm+RbFki8MzaViyLD2P3g7qPjDD
	 tDvsMWRGJ8dC+8k5JUSGj3OPlznZYkNQ3xieiywt0vRgMsp4ei+lgwiAW2SdQfrRr8
	 dzkMuZMni1oKf4vUbwrk5jJREv6nK4NC19VAo9e4yw4x/dpOOpTMKhO40f+dqiWHNK
	 W4u3azu/3vUxT00CHgMUi3zqKNjx3qNxdk25MNXpN79BzBWPmDL881sBX99IPAEksG
	 QU9HJ+mlKHkW73qzZYnVvnvFtt283W4CIgVXw6mXepsTETn9vAt/XryQk6zh8RznWh
	 SJuXhhC/JE1wQ==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:366f:770f:eaa8:d3d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 388A017E0B8E;
	Tue, 13 Jan 2026 17:14:36 +0100 (CET)
From: Laura Nao <laura.nao@collabora.com>
To: sjoerd@collabora.com
Cc: angelogioacchino.delregno@collabora.com,
	kernel@collabora.com,
	laura.nao@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	stable@vger.kernel.org,
	wenst@chromium.org
Subject: Re: [PATCH] clk: mediatek: Drop __initconst from gates
Date: Tue, 13 Jan 2026 17:14:16 +0100
Message-Id: <20260113161416.1256164-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251223-mtk-gate-v1-1-e4a489ab33de@collabora.com>
References: <20251223-mtk-gate-v1-1-e4a489ab33de@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 12/23/25 12:05, Sjoerd Simons wrote:
> Since commit 8ceff24a754a ("clk: mediatek: clk-gate: Refactor
> mtk_clk_register_gate to use mtk_gate struct") the mtk_gate structs
> are no longer just used for initialization/registration, but also at
> runtime. So drop __initconst annotations.
>
> Fixes: 8ceff24a754a ("clk: mediatek: clk-gate: Refactor mtk_clk_register_gate to use mtk_gate struct")
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

Reviewed-by: Laura Nao <laura.nao@collabora.com>


