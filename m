Return-Path: <stable+bounces-87563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C790D9A6A28
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B751F2495C
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 13:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B6D1F708D;
	Mon, 21 Oct 2024 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TnZuXthQ"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8667611CAF;
	Mon, 21 Oct 2024 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517223; cv=none; b=OOKcGin94OUFDUpscKxJpTTRsDzeGeAfSPETsj8G3MwntoRqY0LUdl3beRj7J8wzQ5lpUr4FS1P7Q5g87u3NDbZeUhUwUF5kYxLeU4/6HiVHw8ZKcSoMFbtuF7w7lLDPRCg3BG6VVhO7GVXF8a4STy/PQgy3KbWrh7EisU/qHx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517223; c=relaxed/simple;
	bh=vHZReT131qYAQIRC36w6bRZrUk6yYQYEHOdtxNEqOno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmxobyLVGTZd1uNOF0IH8LsGO8nNlB7Z83LRkfzciz1VpaX2qFgVNwr6M+Rb5q3z3Ga1NJ1mbeP8imTPx5C9KmmvjrmTpKrk5V5PABnJTo0GWXzlnxdy/ZIMFvzGI2UzX6ZDg12UtE6fSVGybQl/bHpFs1PDUFp88SobTqnkGGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TnZuXthQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729517219;
	bh=vHZReT131qYAQIRC36w6bRZrUk6yYQYEHOdtxNEqOno=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TnZuXthQvTvqIhI8Sk0kmleB2OdsE5pZJAKJEu6M9GTGF5o3H/F5pLZdggbNWEQn3
	 SlmKIjoMYCie61uHVofuM+knmQgknm8OnkVORHsChJeutmZjIkjgsE9FSz5f4K/1Za
	 djl8BqkvzfKo7GTgjoQXmgFxWxYeFtkIZ0t6OOEMyX4i3V+17XWmt0nCzSJ9wL4Lji
	 fkgODNJOHDGPfRVgShXup1iXHj9yyEqa2AFZMNZaBHrlA5ug/mqjSNaCbGBK3YEuYO
	 BjFsyiDALgYpdl81UrSz1mfyB73toOQaYW406f3Jgbd7meprGe02KAWJjqda3ZY3kU
	 HjTRbLZVyCqYg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9D98617E3612;
	Mon, 21 Oct 2024 15:26:59 +0200 (CEST)
Message-ID: <3e218c65-608c-437d-a464-6502a8dcea6f@collabora.com>
Date: Mon, 21 Oct 2024 15:26:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8186-corsola-voltorb: Merge
 speaker codec nodes
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241018082113.1297268-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241018082113.1297268-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/10/24 10:21, Chen-Yu Tsai ha scritto:
> The Voltorb device uses a speaker codec different from the original
> Corsola device. When the Voltorb device tree was first added, the new
> codec was added as a separate node when it should have just replaced the
> existing one.
> 
> Merge the two nodes. The only differences are the compatible string and
> the GPIO line property name. This keeps the device node path for the
> speaker codec the same across the MT8186 Chromebook line. Also rename
> the related labels and node names from having rt1019p to speaker codec.
> 
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



