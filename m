Return-Path: <stable+bounces-164385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCA1B0E9C3
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCE01C27FD8
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F128F21765E;
	Wed, 23 Jul 2025 04:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOUnKlrk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6BA2F852;
	Wed, 23 Jul 2025 04:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245937; cv=none; b=OKqdq6TXMQExiJ9PVgEs7f+KwWsTLBHaSV70tv+kq31drbtYddaGFoWIwW/IkOJkZjatKMDj7ZEIwF5x/PkQEVKj3pE0tyMmUdkmswAgbtRYJAGEljtx3rOxaRU/AmDrTvpD+Rc9h4dLAXEazwAPx/1pnUdNBiOIZCfrhnnzvnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245937; c=relaxed/simple;
	bh=BKZAmLwgvxaSIoSf5Jl7qz1ZZWhSXwuKKwePOfDXBws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hlfbs0oTvn7QISfz/sJD+9BSQgv849h4c3vB9NQedLFD1Jk04fcCWe19eXWDr5g125fHBjLCc16uGG5uwWWk7nXQU6Mvo9A4/l7Ge+Q4q5W93NIIgbVWuUSOpihVoRir5wlYHBv/3QmTWQVrplKiKwjEEy8ZyipE+Mm5aPQo2oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOUnKlrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AF1C4CEE7;
	Wed, 23 Jul 2025 04:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245936;
	bh=BKZAmLwgvxaSIoSf5Jl7qz1ZZWhSXwuKKwePOfDXBws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tOUnKlrkZNQ30wvJmNd91NZsyelRJzyrBXpucF0GkpPNv2/hc+ynZF8gb4NJfMYte
	 16HxU0tdOTDEXEAoNx3m7k8yQGfvbxDg7pfgexxilMUv6wdGjzWdcJJ6F75VRlHlv1
	 mYEXS+DcNrI6MjpSD6K9kd+9FyscX+akEu9YC+yQf70//QiZ3yp9MubsEnQs8F/to9
	 ErCotnPuTpVdwFlcUrAlZuICDe1BSvv9CCFBQwIxXErv1J2zfFmLaolLwFHIkS7GUl
	 MFL6d5prxc+CvXLAd1ISFv4u42Rj5QdOzglqsVl/MAv356fD1Uf5R0YJDHQ4qj7YF7
	 GRgBpOVmVJ40Q==
Date: Tue, 22 Jul 2025 23:45:35 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Macpaul Lin <macpaul@gmail.com>, Peter Wang <peter.wang@mediatek.com>,
	linux-scsi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Pablo Sun <pablo.sun@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>, Ramax Lo <ramax.lo@mediatek.com>,
	stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	devicetree@vger.kernel.org, Bear Wang <bear.wang@mediatek.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	linux-kernel@vger.kernel.org,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Stanley Jhu <chu.stanley@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: ufs: mediatek,ufs: add
 ufs-disable-mcq flag for UFS host
Message-ID: <175324593457.1217884.7283187331572765587.robh@kernel.org>
References: <20250722085721.2062657-1-macpaul.lin@mediatek.com>
 <20250722085721.2062657-2-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722085721.2062657-2-macpaul.lin@mediatek.com>


On Tue, 22 Jul 2025 16:57:18 +0800, Macpaul Lin wrote:
> Add the 'mediatek,ufs-disable-mcq' property to the UFS device-tree
> bindings. This flag corresponds to the UFS_MTK_CAP_DISABLE_MCQ host
> capability recently introduced in the UFS host driver, allowing it
> to disable the Multiple Circular Queue (MCQ) feature when present.
> The binding schema has also been updated to resolve DTBS check errors.
> 
> Cc: stable@vger.kernel.org
> Fixes: 46bd3e31d74b ("scsi: ufs: mediatek: Add UFS_MTK_CAP_DISABLE_MCQ")
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> Changes for v2:
>  - Split new property from the origin patch.
>  - Add dependency description. Since the code in ufs-mediatek.c
>    has been backport to stable tree. The dt-bindings should be backport
>    to the same stable tree as well.
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


