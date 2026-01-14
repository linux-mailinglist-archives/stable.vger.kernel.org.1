Return-Path: <stable+bounces-208361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 377B2D1F4B3
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 15:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B011630836AE
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 14:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CF329E109;
	Wed, 14 Jan 2026 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psHXlupZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB51E280037;
	Wed, 14 Jan 2026 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768399279; cv=none; b=GvWDJUOlDbOD0Xn1LcKjsqwwpj5LKrO88ZPTtl+f1HsE/EXf6qC5THgw5ImPZbOzlGMR9JqMOdrGgGh8IinfTFkdRcg2V1zYIC+sflPiy6Oz93aLQRYjpCT8WRRS4cQOjclhb3WddgdYkME7b4WhbEhbwC6RR9OV6o1tjxhcyrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768399279; c=relaxed/simple;
	bh=NS4GOW/krUAkmuANNp5aNWD+Uu/DsbkydKZkOF5PdlE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BYlRHfftYBlhiLkOZWG6pFGXPdSk5/Zy+RaCZ/RiCv9pVPck3i7TXwTjAGJbIAysLAdW46oIrnjPFjqgSszyeebdnp1q/PfGCKeJ/kBSbQ9ksOQ2H0E322b/ij739Bnl3nmTeiUq+Ul19juhRrSgC0fQqJz6xsKshmWBZOf9bdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psHXlupZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EB4C4CEF7;
	Wed, 14 Jan 2026 14:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768399279;
	bh=NS4GOW/krUAkmuANNp5aNWD+Uu/DsbkydKZkOF5PdlE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=psHXlupZoLOYoS0KNWN769c7cdM6cZnylgU3MwlGG+gB5xjJUKWlsfJXUt6whVYC7
	 Y+eCjtsLDEXrfsRM0EybQAVifnNUK1Yy5pxLZ6hTF2twHYM27qY/GfCzbjvwkkczLm
	 3Ce2UDgUjwuLDdMsHuuzof2yQDjZKEROGsNjOzP9vcTwKJQ1s/sHzdg9ZVOoYzFf9m
	 AE5sGACEdh5nMo8qH4yEkHPTfGaDMb3wgw+UafgsnHfZqzQ3RA9MyPCklAik04dTbo
	 KH3nS2taen0nQZUoXwg+XKRkqHlo2Y08JfFTMuWi9Pk0OhoOmS9/Sb8nD7AkDJv4pR
	 ybQBGERh7dGHQ==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, heiko@sntech.de, Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 stable@vger.kernel.org
In-Reply-To: <20260109154626.2452034-1-vulab@iscas.ac.cn>
References: <20260109154626.2452034-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH v2] phy: rockchip: inno-usb2: Fix a double free bug in
 rockchip_usb2phy_probe()
Message-Id: <176839927689.937835.2359558250567308193.b4-ty@kernel.org>
Date: Wed, 14 Jan 2026 19:31:16 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 09 Jan 2026 15:46:26 +0000, Wentao Liang wrote:
> The for_each_available_child_of_node() calls of_node_put() to
> release child_np in each success loop. After breaking from the
> loop with the child_np has been released, the code will jump to
> the put_child label and will call the of_node_put() again if the
> devm_request_threaded_irq() fails. These cause a double free bug.
> 
> Fix by returning directly to avoid the duplicate of_node_put().
> 
> [...]

Applied, thanks!

[1/1] phy: rockchip: inno-usb2: Fix a double free bug in rockchip_usb2phy_probe()
      commit: e07dea3de508cd6950c937cec42de7603190e1ca

Best regards,
-- 
~Vinod



