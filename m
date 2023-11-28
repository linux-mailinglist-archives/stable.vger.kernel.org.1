Return-Path: <stable+bounces-2881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF47A7FB671
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 10:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243411C20F02
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 09:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640E24BAB8;
	Tue, 28 Nov 2023 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6C5rTA2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F4E4BAB0
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 09:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C22C433C8;
	Tue, 28 Nov 2023 09:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701165522;
	bh=5ArrUEd+VDRb8Mp2oGnmeMS9uZXS+0nOcVm4HzoTmAE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=m6C5rTA2jAjEF8afeKlTB6aBB9Y5ULymK2S/fsN64B3SFI91nsJ6ePILQZqYd9eSY
	 mAweO/BFcgEkt6UqPYBX19PmJ9vxOQxLdfXLtsFMAX8HtzdA6prob5zH4W3nN2oyUF
	 32SQbTFqlZMIog6XdU2X9+hJzfbcM+E01OpMIjjqnDBcn5qRsN9q97q+AmZByEioxm
	 a+SpdW2IGa9U3m/Vrgdm++h0wKzuNkN8e6SCsicjYGJivIlw1fa0eZzxG16nM+r52N
	 T0oPjRqtiodzRpUZi2YQKOPcCvydBjMfi4neVq8Fo62ly1aHxVRJ33yKgYalYvsw0w
	 Gt2MLo5g/4Brw==
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, 
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: stable@vger.kernel.org
In-Reply-To: <20231124180136.390621-1-krzysztof.kozlowski@linaro.org>
References: <20231124180136.390621-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] soundwire: stream: fix NULL pointer dereference for
 multi_link
Message-Id: <170116551879.73476.11576514501948917974.b4-ty@kernel.org>
Date: Tue, 28 Nov 2023 15:28:38 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 24 Nov 2023 19:01:36 +0100, Krzysztof Kozlowski wrote:
> If bus is marked as multi_link, but number of masters in the stream is
> not higher than bus->hw_sync_min_links (bus->multi_link && m_rt_count >=
> bus->hw_sync_min_links), bank switching should not happen.  The first
> part of do_bank_switch() code properly takes these conditions into
> account, but second part (sdw_ml_sync_bank_switch()) relies purely on
> bus->multi_link property.  This is not balanced and leads to NULL
> pointer dereference:
> 
> [...]

Applied, thanks!

[1/1] soundwire: stream: fix NULL pointer dereference for multi_link
      commit: e199bf52ffda8f98f129728d57244a9cd9ad5623

Best regards,
-- 
~Vinod



