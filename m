Return-Path: <stable+bounces-88978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 888BF9B2B0C
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4951F22212
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 09:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067211C1AD2;
	Mon, 28 Oct 2024 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RKR/8iU/"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4969192D9A;
	Mon, 28 Oct 2024 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730106594; cv=none; b=qymcjJxuRLriWo2QIo1KVM4GCeSbYBuvTUO6bGa3qaokR5lWeUW7pYkYmJoTpQVDT+VP0kDVqXZLATQRslFoadds7f2ADalWA271XR+/EHNwmn6LxLfK5oHzu3Lt8qQmBEGc4ygOxCxYCd8ILmnCuMdGhZcsURV6HFpYGMB6XW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730106594; c=relaxed/simple;
	bh=RrNX39g0rq7db1nKULH9Y0fs1HbOSJyWDZQmvN0UvUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j67A52tOo9Fzie02dtaCgzXsI36L85sL3hX6eETeEjyclXTC0fToBwFch5qOod6SiWnlsZgu+tqU29/l/JJt+HYRYtanGAFK4SemBQSYc7qGsVWzXSEHqK1EKArRS/lft12TghhKteFj9Yuwcf8Ln9grHNrJtuqazwB/WuC5qg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RKR/8iU/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730106584;
	bh=RrNX39g0rq7db1nKULH9Y0fs1HbOSJyWDZQmvN0UvUg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RKR/8iU/wJEYI+J7N2dtM+s3eZv9jXzERl6VnGrqD2JLPag3hI38s+ANtc8V4AO/q
	 KtNVbFvzDonr/uSGfZ8tEZ4DaorTLxuInXyEN8+ePSVlrD/0WrFBO1dIl/ogw/ttJk
	 TlPmJ/xGGQLN73dfr6qUfzzaaserKqYijfCg/i1qlGFtp/Fu4ujd2kbBx+oKgvExqr
	 vn4t7k3XsoGSMsYq0YwxgEfIMnZM3P1TXlIDB+LUeS7l2pbAenJ/YJvJ8drnYZAwjn
	 8LcST6h1j8q9Xhp+9xdq4j8+M95MnlF/WTi0UtYAH0XzMkz70eq0DPouBD8xVUPYqt
	 SIrU8ttRCtE8A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0908817E1134;
	Mon, 28 Oct 2024 10:09:43 +0100 (CET)
Message-ID: <9c83ea27-1221-4920-920e-9e7876ceaf90@collabora.com>
Date: Mon, 28 Oct 2024 10:09:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/mediatek: Fix child node refcount handling in
 early exit
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Alexandre Mergnat <amergnat@baylibre.com>, CK Hu <ck.hu@mediatek.com>,
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org
References: <20241011-mtk_drm_drv_memleak-v1-0-2b40c74c8d75@gmail.com>
 <20241011-mtk_drm_drv_memleak-v1-1-2b40c74c8d75@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241011-mtk_drm_drv_memleak-v1-1-2b40c74c8d75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/10/24 21:21, Javier Carrasco ha scritto:
> Early exits (goto, break, return) from for_each_child_of_node() required
> an explicit call to of_node_put(), which was not introduced with the
> break if cnt == MAX_CRTC.
> 
> Add the missing of_node_put() before the break.
> 
> Cc: stable@vger.kernel.org
> Fixes: d761b9450e31 ("drm/mediatek: Add cnt checking for coverity issue")
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



