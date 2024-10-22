Return-Path: <stable+bounces-87696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC4A9A9E2F
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 11:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB7DDB244B7
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 09:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF126197A98;
	Tue, 22 Oct 2024 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EV3teINF"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAADE185E53;
	Tue, 22 Oct 2024 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588574; cv=none; b=utrPOARa0IEw5PfQ7DdaE+3/Usk/t+aK7C6itxt103Vn8a8E9+YEaMOJ8kvtgZdurojC4idKnJtGqMkWBRH4wamvgw5cxVBH+cfhS1OELnpb5JqCygwSIgM0dggeIFAnYROjt3Vg6Q+v4M7t1/bpbGmAjMlid9+9KCGom6HQ7qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588574; c=relaxed/simple;
	bh=oZqxNr5h3vQ0uP3hNOVEPnUyAFkS2/lR0RHev89YgiA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n2DD0aEKz56/QzMTSVRPqv+vcjZ8Mzh7Xva3MJVE3shui8CXhUA8maF8JPX8N9rKnE6icuSkZlomUcVtF+oj2t46VK6dahl3q0gAUKtsZ7RwfNbU9dkGWYmJb4yaaj0w4+SNc+4EQuA6B7TYkiKnzVOOTYGGcWCawZcCQ7sbyPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EV3teINF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729588571;
	bh=oZqxNr5h3vQ0uP3hNOVEPnUyAFkS2/lR0RHev89YgiA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EV3teINFeBEch8w6KugJk2OFI6Ya5fJFBqHZg/PkqGeyqzNKzOPAwFE+6SoS/oQFV
	 jx4rCvydgo/uTYh28ADiWp3tHSfMtW1kPhcxW+qQ4DWOARtIUUbLbd+hXC+MtWH88C
	 Qa35boR0yFp5vIys8pCFbXtkJU7LvF8c+isELSDrceKxrTiy1XHcalGNgtLjot/BEY
	 YHTVBb+ZbPHepd7a9x/xtPFe50TVM6lRI6zqj01z8aZOxKNaIts5l55GBehXpN2Vu7
	 w9jPHxfXgIhmuA+af6rDCLJ1Za2mn8SdGaQMQgQgwclZpiBgc+a3yxano7HCJeVUEK
	 Vbc/5TUfuQmZQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B7F4317E12AC;
	Tue, 22 Oct 2024 11:16:10 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20241018082113.1297268-1-wenst@chromium.org>
References: <20241018082113.1297268-1-wenst@chromium.org>
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8186-corsola-voltorb: Merge
 speaker codec nodes
Message-Id: <172958857070.72613.8421801066398473811.b4-ty@collabora.com>
Date: Tue, 22 Oct 2024 11:16:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 18 Oct 2024 16:21:11 +0800, Chen-Yu Tsai wrote:
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
> [...]

Applied to v6.12-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8186-corsola-voltorb: Merge speaker codec nodes
      commit: 26ea2459d1724406bf0b342df6b4b1f002d7f8e3

Cheers,
Angelo



