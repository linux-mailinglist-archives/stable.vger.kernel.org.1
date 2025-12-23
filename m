Return-Path: <stable+bounces-203323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E912FCDA23D
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 18:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECC1B304E390
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE2634AB14;
	Tue, 23 Dec 2025 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWjsUYjB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A85334AAF9;
	Tue, 23 Dec 2025 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766511246; cv=none; b=ntHmKhN2hLrTe/WH+7lCZ/1S4TiSaKQwDxjjhlBtIiIM3RnIwO2RdZ+YBEC2CWZ6LbqtmrIUhIvtzvB/628bNbzPqdeccrytknLRpilb96ZqU5gPert45J1ikJS4cNkmNnMslsd/28U80XyLn0vkwk2qlI7jOnJNU5WcnXwU5HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766511246; c=relaxed/simple;
	bh=klibO99i4aB/Xo+DGoJGR3MAFXB2GespfAli0mACiiY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eWzamUSuzTZ+6Bv69P55wwI3FCbkZl7JlZ9VRQcGrgDoyscKWCAPWHr3SqSy82wuA53fHzdQO/UmN18ygzh7HmlHVwsMdBTGd6jNaAGJwPcDV/icWixjd0Z/+jPvdETN0ECH0Z86QMxM/y4tP8EaVvdhVm+x7b1UoWru2WXlFFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWjsUYjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829BFC113D0;
	Tue, 23 Dec 2025 17:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766511246;
	bh=klibO99i4aB/Xo+DGoJGR3MAFXB2GespfAli0mACiiY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fWjsUYjBYwBHX0lth5HUJME9v3vKSMhgJqk6s0xHSjrNPOjTMpgpP+Er25++AbAQf
	 oQ0FtZ1I3ZIz+G1B8+eyptX4zTF05vQj7D7/CFed+kw9cB3+UQhGoXt5HHTHpPMMEs
	 e5h3QSXH83wcSz9/hcwXe5DX7iwWDNI90dFvUzZFGzZzqB/q950heyjJC460swEXQI
	 aNi1VUV4uUegBdS3IQcMRqM8jYB+XfDvSZPVNxoyOS2UCPVq4btU6ciBjKd2CTA11i
	 x5H1OMLNpKBrVBKLrbBJmFSJIU15Zq3TyZbMCokyUzs4vQAOdno+fnZkCa/KeM9ER+
	 GzVQ7bJOswwzg==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Johan Hovold <johan@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Andrew Davis <afd@ti.com>
In-Reply-To: <20251127134834.2030-1-johan@kernel.org>
References: <20251127134834.2030-1-johan@kernel.org>
Subject: Re: [PATCH] phy: ti: gmii-sel: fix regmap leak on probe failure
Message-Id: <176651124417.749296.3744607103286976233.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 23:04:04 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 27 Nov 2025 14:48:34 +0100, Johan Hovold wrote:
> The mmio regmap that may be allocated during probe is never freed.
> 
> Switch to using the device managed allocator so that the regmap is
> released on probe failures (e.g. probe deferral) and on driver unbind.
> 
> 

Applied, thanks!

[1/1] phy: ti: gmii-sel: fix regmap leak on probe failure
      commit: 4914d67da947031d6f645c81c74f7879e0844d5d

Best regards,
-- 
~Vinod



