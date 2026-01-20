Return-Path: <stable+bounces-210471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F748D3C452
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 10:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A23197012DD
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 09:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81233D5245;
	Tue, 20 Jan 2026 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="jHu/EVLQ"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4FD3D5220;
	Tue, 20 Jan 2026 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901979; cv=none; b=XAIYFj2Leo5+COxWkdujJN5J+SeHkfwoyCyEw4ORO8I1nZZxWAU9qYjwqm62G4OajhOrF4QRScMpPBDbOs0yBWPZL1hP3IyiD17ipaVPQrWCdGUYfrX4saVDKPQ0pcsZ3PzAuqnZdVvxL2qEttodK9GpZdJnF8ZxsisHqvlkzoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901979; c=relaxed/simple;
	bh=2odh8yCUKMmU2qb+xhTR98g5Ui6wUMvjtfUEkILPuno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ch6nizFzkRvY5d2ywBgRcytU2jgEGzJ2nmp0hStM7gXQtrP8y0k60KXiGr7X3mprfAarsJPsqmfmX4fFEJnpZSyH3IFVE/7XeTlz6CXVx+ALzKKGaCU551no5LpNxIgMmx4XXfmPgRJ3pnDazAjTc3Pdpxg6RnyjM30bmPLiQDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=jHu/EVLQ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=7louDgFpxyU4n0BWWFhxWA7atRnSXCl4eBuC57wksqg=; b=jHu/EVLQCh4FX6xag2JDnMRWcz
	Tqa1YrbtdVCFqoTts8BA9KJk1qEUO1QD4qzOq/JktOmezMPQM0ewCcbiCKFByEktJ2lxxW9N8E3NR
	/obpZUzMAG6XdERx+GYKKTQrhlkcMHQkkDp+QQhznnOUWdR/grmqwPn34WBTzNvpOHMMGuWTzrmez
	dRZ+nM/h5w4cHRnTppYQrulIELOFmXcODGkabqWxXlhHNubl3rtYGSqcXUYowXgj4YeWTFiIMjhLj
	JCa/S12Re27rsJZ3OodC6R0MnSsxVWD7nZSJDebzk301HQ4tS7YC8REbIX5Zd+Ysk7ttZmD9kEF2H
	Uvvc8VxQ==;
Received: from [192.76.154.238] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vi8Cv-003KZM-Et; Tue, 20 Jan 2026 10:39:30 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Jun Yan <jerrysteve1101@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	pbrobinson@gmail.com,
	dsimic@manjaro.org,
	didi.debian@cknow.org,
	conor+dt@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Do not enable hdmi_sound node on Pinebook Pro
Date: Tue, 20 Jan 2026 10:39:27 +0100
Message-ID: <176890189896.310054.3689082098898178787.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20260116151253.9223-1-jerrysteve1101@gmail.com>
References: <20260116151253.9223-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 16 Jan 2026 23:12:53 +0800, Jun Yan wrote:
> Remove the redundant enabling of the hdmi_sound node in the Pinebook Pro
> board dts file, because the HDMI output is unused on this device. [1][2]
> 
> This change also eliminates the following kernel log warning, which is
> caused by the unenabled dependent node of hdmi_sound that ultimately
> results in the node's probe failure:
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Do not enable hdmi_sound node on Pinebook Pro
      commit: b18247f9dab735c9c2d63823d28edc9011e7a1ad

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

