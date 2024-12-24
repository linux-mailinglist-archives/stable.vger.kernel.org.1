Return-Path: <stable+bounces-106079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B51719FBF99
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 16:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE3C18853B0
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 15:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5AE1BFE06;
	Tue, 24 Dec 2024 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP6oNNrD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F4E1DFD1;
	Tue, 24 Dec 2024 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735053919; cv=none; b=t1KbwLAlTCFtXZD1TK/3k5awu3hwJyFYqETLv1oWbSCpHzdtFf9x4O/Ze7WfQX4xDQw0qql1mdiPnMeoCatuwg0vv2mK5dp5D/UVWtHPh7IAA/IV8bmwIBxfJiRqYR07ZVK/RSfJFqipVBlL8qsH6kaobHIXIHe4zzPjnekAg5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735053919; c=relaxed/simple;
	bh=V/7XXPcXHWaRNDVEGaRoIRGDjHQ/RXIhkdCB+v2zD5w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OSnPeu/QLcnkDVims/Adon3BB7UEPFXOWRaqPladmY0PkdsbHb9zytlu/MaJcN/amjMHmthYVkFsQ2vTbujCwfaMkP97+L8th5/ToXr+20JEAruY8ni5AAy7WZIbFoqjMWZ6MOCLgWuO5exS0vYeT52xUpeAwenHrlQjpZwhDL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP6oNNrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EF6C4CED0;
	Tue, 24 Dec 2024 15:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735053918;
	bh=V/7XXPcXHWaRNDVEGaRoIRGDjHQ/RXIhkdCB+v2zD5w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JP6oNNrD0tYZixKdkO3Oujay9RO6fkwcTqq3siXrcXwNyfqXn8nFaJQMMbGxcl3Bm
	 gwFcO8Twgu9bttkVR3Qg4HC4mbq2RPAgHJ9t3/NBg3RX2NCEagpFqa1h2qdHMTuJsg
	 rvc1dE6XsS2U68yQemmWZ58lzq/RBQWWBiePC6bjpb2//dyvZTNLXfk2NHDmJmKRAz
	 unDBCi6dAC2YYfdRGmO81XqHCLcTfP1ZJLGgIFBeDm/32Cwh3krZLccawW6+v55rZ5
	 HLp/zwDeTzzIgpmKiTGbgLkwQVuu5qyen6wtUvOAwzUr0RDgfXCvtZdGv/i04IIJyu
	 zHw4Ot9OVuZiQ==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, Felipe Balbi <balbi@ti.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Lee Jones <lee@kernel.org>, Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Johan Hovold <johan@kernel.org>, stable@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>, Johan Hovold <johan+linaro@kernel.org>, 
 Simon Horman <horms@kernel.org>
In-Reply-To: <20241213-phy_core_fix-v6-0-40ae28f5015a@quicinc.com>
References: <20241213-phy_core_fix-v6-0-40ae28f5015a@quicinc.com>
Subject: Re: (subset) [PATCH v6 0/6] phy: core: Fix bugs for several APIs
 and simplify an API
Message-Id: <173505391227.950293.14243235099163713416.b4-ty@kernel.org>
Date: Tue, 24 Dec 2024 20:55:12 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 13 Dec 2024 20:36:40 +0800, Zijun Hu wrote:
> This patch series is to fix bugs for below APIs:
> 
> devm_phy_put()
> devm_of_phy_provider_unregister()
> devm_phy_destroy()
> phy_get()
> of_phy_get()
> devm_phy_get()
> devm_of_phy_get()
> devm_of_phy_get_by_index()
> 
> [...]

Applied, thanks!

[6/6] phy: core: Simplify API of_phy_simple_xlate() implementation
      commit: e6625db662120572c32ac34c371f9deefb321411

Best regards,
-- 
~Vinod



