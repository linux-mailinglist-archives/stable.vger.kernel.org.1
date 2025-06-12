Return-Path: <stable+bounces-152515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF19AD659A
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 04:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5D03AEF38
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 02:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934D21E5B94;
	Thu, 12 Jun 2025 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acxXt0WG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445C61E5711
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694966; cv=none; b=pbYDmRVgQuCHzJ+0IcbBVI+w+v/99R7S3B/tBLNzJFdsu9cgKviBgaXB662+LGaOrFZxQZ3Ws93BxQL5x9Mrfm03WkedCKixxKA05J5G7UyrvQM6yRNsQ4L/zxrDAJ+1fJTvZ5EixokechPcYkORaB3Dm6ZWV7X8jGI07Ec0C4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694966; c=relaxed/simple;
	bh=gJzMjWnOdeAd60hSVCdAALtX0O5Fyp2g62GsNhBrDwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTXZXDb8aOjdynJAj/iPZ5hDkcxD0jHKflK0YOxwZyXb3BgBmISDF4iWglgf8SeH0WfxbTIrtR1/LEiMsONZMS04yJOV3XB4ejga7FdL3m/Lntyz1sFrL+WsDB1jLG3sURa7fcizD2kzyhsy1yGpSNBSOW06piNMSvOssqEyCEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acxXt0WG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF034C4CEE3;
	Thu, 12 Jun 2025 02:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749694966;
	bh=gJzMjWnOdeAd60hSVCdAALtX0O5Fyp2g62GsNhBrDwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=acxXt0WGYplZOrnbGgIT8u3egMURbs8fCAzPcX9PfAQFwRCaCn1eOmT04FfwUPoHG
	 p42bcEpfEuKu4jzISTkF7592Z41+XRqTMkuuT9JHMK9HSGQq8tkMVppNTI6LZNSZXP
	 juRZVC+B1FGryNRkUm0gMRGosqoYVkEHpWkiv5UCpZ1yUmcmsZk5Mwg5D295it7lTa
	 gbGg9ouvMmFcB9S7EysjC0uGTt2n3t5O0e/3Sq/1izUXk5+NWmxYErd8e/SVuKdhCK
	 EpT/SqrOVIi79DX8EzvHLHN/croy/XPBzbI8O41AG5qZVbDjd5kEfpVGWqiJ5TO5/S
	 zy2KpIzYtzsQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 4/4] serial: sh-sci: Increment the runtime usage counter for the earlycon device
Date: Wed, 11 Jun 2025 22:22:44 -0400
Message-Id: <20250611102136-ae8e0a4da15fbd32@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250611050552.597806-5-claudiu.beznea.uj@bp.renesas.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 651dee03696e1dfde6d9a7e8664bbdcd9a10ea7f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Claudiu<claudiu.beznea@tuxon.dev>
Commit author: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  651dee03696e1 ! 1:  87975fabe1bb7 serial: sh-sci: Increment the runtime usage counter for the earlycon device
    @@ Metadata
      ## Commit message ##
         serial: sh-sci: Increment the runtime usage counter for the earlycon device
     
    +    commit 651dee03696e1dfde6d9a7e8664bbdcd9a10ea7f upstream.
    +
         In the sh-sci driver, serial ports are mapped to the sci_ports[] array,
         with earlycon mapped at index zero.
     
    @@ Commit message
         Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
         Link: https://lore.kernel.org/r/20250116182249.3828577-6-claudiu.beznea.uj@bp.renesas.com
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
     
      ## drivers/tty/serial/sh-sci.c ##
     @@ drivers/tty/serial/sh-sci.c: static int sci_probe_single(struct platform_device *dev,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

