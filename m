Return-Path: <stable+bounces-87576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF069A6BDB
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 16:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34542280D9E
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 14:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E8B1F80AE;
	Mon, 21 Oct 2024 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KPx6R/4P"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5171EABDC;
	Mon, 21 Oct 2024 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520126; cv=none; b=ETlW3+GXO00xWbTXgLOx5L4Xfcmy6M4KzJo4XRz6RflW/GTra9hTPEl959rgWpLaJsk4XF7XkcsoTm69VvPFfrTSaqTLVCM9F0beg+3iCwcjHx4ZQDjFh1cYC/x/ho6JjgK/xZbx0PFyua/uXoG5NR3eeNXmBJP4kIm3KDW3CdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520126; c=relaxed/simple;
	bh=pHf5twCTnnJnfQtRd2qMSTYSiWrNRBO3RQNcXpO/2E0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgI/hHyULpvnFYlZgf8tNc1RbV4SLT20bUvo5ZSffkNg4PNDStnXBXSftyfLA4DBcA+WLcWYsyYQ1QnHvQOYW7iaHbyWCXoll6ys2JFfnN7M4kqtCxxTB0KOi+k9HTtOzq2hKsBp/KDuwM01xUbpJXx7ABgR3zpkMCJEI32q1mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KPx6R/4P; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729520122;
	bh=pHf5twCTnnJnfQtRd2qMSTYSiWrNRBO3RQNcXpO/2E0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KPx6R/4PiHZUyF7n8wGcXnnV2x85EriAD8S+BM+eA3Q4CEj3onekWZW1AsjtP5noN
	 pxUPRFt+wCQLXNA2i+WeW/9SIagFaP3ndf8iT0vd/aSpDIF0NYuxtRAgR93uFkkodf
	 d4tXFpx2LgQdkgFj57sDL2n4gWkAOuz8/s9ntrcUP75aFtTPcyLOZnKS6hwR4dQ6zK
	 9FA6C4UVa56+Yvb5GwxvociS6wpdhAYvGiwjddSepI6MjuNDGc2IlfINu99q6yRhuv
	 QYxEcWPtjsNSGjdry4zSWKkUxsjcyaRG1Gmgk17v8DzPuUi7gFEpJp4SSUlwa69fbV
	 tZrXtgT7kK5Ow==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E6D7517E3621;
	Mon, 21 Oct 2024 16:15:21 +0200 (CEST)
Message-ID: <b403ea3c-6a03-43fd-a9fb-daee6e1c425c@collabora.com>
Date: Mon, 21 Oct 2024 16:15:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186-corsola: Fix GPU supply
 coupling max-spread
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241021140537.3049232-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241021140537.3049232-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/10/24 16:05, Chen-Yu Tsai ha scritto:
> The GPU SRAM supply is supposed to be always at least 0.1V higher than
> the GPU supply. However when the DT was upstreamed, the spread was
> incorrectly set to 0.01V.
> 
> Fixes: 8855d01fb81f ("arm64: dts: mediatek: Add MT8186 Krabby platform based Tentacruel / Tentacool")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



