Return-Path: <stable+bounces-185719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E7FBDAE63
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 20:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0D454FA913
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 18:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C81D30BB9A;
	Tue, 14 Oct 2025 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="vHauQUbQ"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8820B307AFB;
	Tue, 14 Oct 2025 18:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760465220; cv=none; b=r6BM9Y3mZeT/s2lesA6pVhmWaav47XkLSlNgbnSfuUXchN3N8RZf9JGtTkWeLJPxwLgg65Lz4H7NG1S3ma1hFn1Vc2ogI3DLuwzDLT/dfNlxDBwkqp4kboLDkcDL0dZYbBQDR5rqUrw41tdkrxrns8869GM/c2PocfoL8RSDJas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760465220; c=relaxed/simple;
	bh=MxlDFvaIPrqx2sW/iUtcyFfQxZJQ0KowjWlefyaTGvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saSSDa2ONi7vnyPEg71TOl/UZh4knW66C9OvjjfqV13WrDpt7L5vZWGQ4gSgoo2DK+8GZi2rlQkNjj5UISbvp037WIv0ENVkpS7gxVgs2UaWfF2hVznkahUpOz4aIm650b8W6JobmkEjF8E8P8MFlJP4DnJwbSoFIzG6j6LsOdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=vHauQUbQ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=gaZVoYZh/DeywsMdRAGvKGBBjxuFtSLH97k3RMBvBnw=; b=vHauQUbQQaphdvNiOk1IoaB9P+
	83Q2gMIGw2vLjQMIj/Mj6PYxeP3CbcoPAJYlNkEa1yRF6hE3BORFsUzPKp6sKm5f3IAV+k0d0Lw6u
	zJYw2oyM98Fbo0YZ8eUfwPsn47BOAIGtmWdcA278NBr8LG6N3R2IyIR2jTpMYVBIj/gyIZLUaGKGT
	6GFehC6zmjj1rB8CGffFmiasATUCLKu8D59nrlWpSTUD/CToe5ZaREE8GPpaFtksCQnzqK6wcYiHx
	gg4hPc9e+Ncol2m2s7AOxLOsCzfSJybaX3s4jAbJaYQqI0nnV6e30sMIaDITBy5ytNCcfJL7+YUUo
	3Rz9kdhg==;
Received: from i53875b75.versanet.de ([83.135.91.117] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v8jQ8-0001Gj-C7; Tue, 14 Oct 2025 20:06:48 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yifeng Zhao <yifeng.zhao@rock-chips.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Liang Chen <cl@rock-chips.com>,
	Alexey Charkov <alchark@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Remove non-functioning CPU OPPs from RK3576
Date: Tue, 14 Oct 2025 20:06:30 +0200
Message-ID: <176046473174.1662867.8203194428926902068.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251009-rk3576_opp-v1-1-67f073a7323f@gmail.com>
References: <20251009-rk3576_opp-v1-1-67f073a7323f@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 09 Oct 2025 16:34:01 +0400, Alexey Charkov wrote:
> Drop the top-frequency OPPs from both the LITTLE and big CPU clusters on
> RK3576, as neither the opensource TF-A [1] nor the recent (after v1.08)
> binary BL31 images provided by Rockchip expose those.
> 
> This fixes the problem [2] when the cpufreq governor tries to jump
> directly to the highest-frequency OPP, which results in a failed SCMI call
> leaving the system stuck at the previous OPP before the attempted change.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Remove non-functioning CPU OPPs from RK3576
      commit: 05b80cd1f37db042e074ecc7ee0d39869fed2f52

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

