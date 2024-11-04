Return-Path: <stable+bounces-89610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16A39BB0A5
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8532D28293D
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 10:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBC11AF4E2;
	Mon,  4 Nov 2024 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZS8rdhD5"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799D31ABEB1;
	Mon,  4 Nov 2024 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715008; cv=none; b=H6KvfzQrdto08Xsj9yDppks9syu09qisRhvyyLgReu8jictrQ0jcQWsPJ6T4cgcsQQcXKwsUhNfS5LbDmZB9AHCWTk+Cr8GNCClskz4ASE9mhHF1gAQPSLjePYG1CmQiwI8o3JmyZGl+ZBqLvqneNLFPAlxk1uCM4clTkrie4gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715008; c=relaxed/simple;
	bh=lLbyBoAV8LAAMdgY2WJPPlbx5TE3cUhhNB8Q1ZTzIcA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JrCz86GTF0YoyuVc5hEuGuSZS5/sRdlq/5za7eMzc8F+/BGg5z+2WRagzke7JAGXzCUqqxCtiAlbn6h+Cil1O6CXP3rOz3ndFI8UZD0SkSBJM6n6MSeKm8vXQfCi7UgbPEtDcT+ei+nDIiHKjsWozzonMHsuWDOMbB1D2GbKNbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZS8rdhD5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730714998;
	bh=lLbyBoAV8LAAMdgY2WJPPlbx5TE3cUhhNB8Q1ZTzIcA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZS8rdhD50IHxY+5Rbx8r7cZBPvPyB6xYWC2v/L0hAjlXLYIJaIQnpK/KX7TlVjHbz
	 rHmHYWcyHxEAidWoqcfCp9gywzr/GbIR4VcnC7mr2ltpJ5s2zbtwWupskX1d5hEujo
	 K9Fym5ilmXMygh31eFMLzJ3OCwI8JJj8aIlKX7Yfq/z22gyTWkJUX1Sll7LT4dukRI
	 mTXSp0TUiBspnV5zj0kuQ44tOSav6QtX75717Ogobq1dcwpjcfL9DSlva3pEsy2UVN
	 G/5sGyge0T6kjWHznZwdk1V2RkwSUH+vGWDq4zG68iPQ8VIRqX4FL7U35Eg9VtiE9v
	 21dC8e2AFkipw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1451B17E14EF;
	Mon,  4 Nov 2024 11:09:58 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20241029100226.660263-1-wenst@chromium.org>
References: <20241029100226.660263-1-wenst@chromium.org>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186-corsola: Fix IT6505 reset
 line polarity
Message-Id: <173071499802.113773.6669341556020572344.b4-ty@collabora.com>
Date: Mon, 04 Nov 2024 11:09:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 29 Oct 2024 18:02:25 +0800, Chen-Yu Tsai wrote:
> The reset line of the IT6505 bridge chip is active low, not active high.
> It was incorrectly inverted in the device tree as the implementation at
> the time incorrectly inverted the polarity in its driver, due to a prior
> device having an inline inverting level shifter.
> 
> Fix the polarity now while the external display pipeline is incomplete,
> thereby avoiding any impact to running systems.
> 
> [...]

Applied to v6.12-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8186-corsola: Fix IT6505 reset line polarity
      commit: fbcc95fceb6d179dd150df2dc613dfd9b013052c

Cheers,
Angelo



