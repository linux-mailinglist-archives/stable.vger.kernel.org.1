Return-Path: <stable+bounces-3151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 803357FD814
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 14:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8664282965
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 13:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C9020327;
	Wed, 29 Nov 2023 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="d2GCaSf0"
X-Original-To: stable@vger.kernel.org
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D770710C4;
	Wed, 29 Nov 2023 05:28:33 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id A6DBB66072FC;
	Wed, 29 Nov 2023 13:28:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701264512;
	bh=zpfPELY7wglGVGim2aiQUgNevSQhwaMs8bxwBu3nImA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2GCaSf0HHb/WcEFbaGeF+PowDdvtzLDIjiEJXD602hcWNS9wavx0yKtppPCwz75A
	 sUKvF73EcfszuB34bUPOkeE+GhPYMhw5YolQpquersEUkYbMSMUfLGskKE+4uYGVxH
	 D6gkXwYLwuqtC/jTAyfkjhJ+vtk7ubF+JZ++06Vu6lGR5VvoLrE3AmtjLMvC4eAOkT
	 En9SaoStVVbNP1m6YHFsMwD5p6kpzDW/YiN+hQFHMVJswZ9T0CBfkO2SiWflvKFP8W
	 MVnSo6Zz3lnD02EqXOOq/V8bQR9t1wk3ATCh/eaSG4m6xfLrlepvNQqx6R86+w8tUU
	 33TfhEGhez0Ww==
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org,
	Eugen Hristev <eugen.hristev@collabora.com>,
	Frank Wunderlich <linux@fw-web.de>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	matthias.bgg@gmail.com,
	kernel@collabora.com,
	Frank Wunderlich <frank-w@public-files.de>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/5] arm64: dts: mt7986: fix emmc hs400 mode without uboot initialization
Date: Wed, 29 Nov 2023 14:27:38 +0100
Message-ID: <170126437823.153055.14524036820842918746.b4-ty@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025170832.78727-2-linux@fw-web.de>
References: <20231025170832.78727-1-linux@fw-web.de> <20231025170832.78727-2-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 25 Oct 2023 19:08:28 +0200, Frank Wunderlich wrote:
> Eric reports errors on emmc with hs400 mode when booting linux on bpi-r3
> without uboot [1]. Booting with uboot does not show this because clocks
> seem to be initialized by uboot.
> 
> Fix this by adding assigned-clocks and assigned-clock-parents like it's
> done in uboot [2].
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: mt7986: fix emmc hs400 mode without uboot initialization
      (no commit info)

Best regards,
-- 
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

