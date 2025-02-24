Return-Path: <stable+bounces-119419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E10E5A42EA2
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 22:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CDE2189A5E3
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 21:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD731957E4;
	Mon, 24 Feb 2025 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDqPCwGq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CC421345;
	Mon, 24 Feb 2025 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431402; cv=none; b=uTqXyFjm421fpGbRmpLrzMEj9LI5OULMnjUiajOafb8JK7ytZ24WddZmH3PrPRcUCF0cZQWAmOQ4pH4OHzKfrQAE0bxKloDfr2XKIxGMysGTWE9vq7zxAmgfowpEq+65lepK1vtOiuwpquWzil2PmUywDN+hh1f/GFdT/7EvYk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431402; c=relaxed/simple;
	bh=hbW/SJlFMzuudS0GacEN5aJw+CSrtge6vWyr9X+ARNs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ppVmfrTNJK5gyZjPOlr7kbpnWk5gehwtv3Mq2tbkxH9Ze6HrUaLVl/oUteU2xJvpAZmWj8UtJ4U38xy6FGFJWH2kYZW5mizPL8lfwMRwm4/JUlOC4msnelqMMnq3tnbPtjmgIfRTQBO90XjK3jH4GsBUi3x0cyahgLxIXemKGxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDqPCwGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D64C4CED6;
	Mon, 24 Feb 2025 21:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740431402;
	bh=hbW/SJlFMzuudS0GacEN5aJw+CSrtge6vWyr9X+ARNs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UDqPCwGqxDMF/yKvJYMFIzD6OBVp7ih8GAeoV2H4KbIzml6xSmnCA7UFUVS2ICXg+
	 LjFNAv+NAJXlr53+RY2wXujtNOfM22nZRuVa1PmP2tb93fzIFhq8x1ms3irow7SSJo
	 ghoSUUj72tiDlJyPu/U3OwSRkoYt5kXuTSJpDZk5wdFEcxubcLS7iz/uWOoh0Xw3Hv
	 rbnMQ/Z0QbTpaDDUYlyswffLbP2vqcT9houRZft57/E00GD9UiVFWIFc5UkInpR7km
	 DoFz88d2Ig3LV9RCzTkpoMXTT0nk514cwYCp0jFyPndi5O3Mq7hpp5l2+iQ/9LojvU
	 k55IrQmbjEdjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE264380CEFC;
	Mon, 24 Feb 2025 21:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: Add check for mgmt_alloc_skb() in
 mgmt_remote_name()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174043143326.3609111.3392148851063113279.git-patchwork-notify@kernel.org>
Date: Mon, 24 Feb 2025 21:10:33 +0000
References: <20250221084947.2756859-1-haoxiang_li2024@163.com>
In-Reply-To: <20250221084947.2756859-1-haoxiang_li2024@163.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 mm@semihalf.com, acz@semihalf.com, rad@semihalf.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 21 Feb 2025 16:49:47 +0800 you wrote:
> Add check for the return value of mgmt_alloc_skb() in
> mgmt_remote_name() to prevent null pointer dereference.
> 
> Fixes: ba17bb62ce41 ("Bluetooth: Fix skb allocation in mgmt_remote_name() & mgmt_device_connected()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: Add check for mgmt_alloc_skb() in mgmt_remote_name()
    https://git.kernel.org/bluetooth/bluetooth-next/c/62ee156d6b29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



