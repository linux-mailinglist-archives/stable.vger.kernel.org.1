Return-Path: <stable+bounces-50102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184D39025FF
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 17:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBCD281C32
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 15:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE68A13E8AE;
	Mon, 10 Jun 2024 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uh/DzNTj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9502812FF86;
	Mon, 10 Jun 2024 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718034628; cv=none; b=ctl07P6g9tMjJg8UvERTqV8qi3asl7ABXNZ8aP6Y7HH41OnBdtojdP6tHLCo2e38dr3XI2OtG1ddbkt7oXPxLKAvLMkrzAbZvANKSElvYsucqMwwmq1xy550xpN/J8fm8u9x2WG8NXl4q9k+vuKMwO4LHt8X6IdAAFd+5wXNbAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718034628; c=relaxed/simple;
	bh=DrI94N/CMFz9UeD3iRMchAh5KrEbhkgUgdn+R0UGJbo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bIeQ6EEriaX5TFoIvkhUNxZ0w5bgROvlugjmjVoNzZXWwGaluLGXOebx+/2BFdgDD7EVRa7XW4HYzS6j8aBm+K2K6WqtjOlKrELLszq75YKo4U3S7i/pYbTBwofthqSfxy0l+0LEd4/FXaZitNK4zbl6s2kSCRSncizEbZ89nC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uh/DzNTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C8E4C4AF1C;
	Mon, 10 Jun 2024 15:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718034628;
	bh=DrI94N/CMFz9UeD3iRMchAh5KrEbhkgUgdn+R0UGJbo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uh/DzNTjjz9v9j4aWLbgrRhEunQqttJ26/jVrcGHqYZz3o5vlV+3LZMU6M2J8fvoD
	 fkFgXbTI198a5XQxhPDu1WWcHssVp99TdTFm2rUyLP5kykHCDDJ2bZbTsEvfgtuyWM
	 pqg1NfP3ZNtcqO+ZKKEbkbqUWbjdrA1zzESUz86xxvhk0vGUJgS0T7pKZTiQQ8hahJ
	 DZ0PFQvHTllcNBWBh5sYHEX7yjJ8IpxQ2HgkDCVU5TO/W/pveEp+FctyFq64L25x/u
	 26/cbjnj2w5gE93vyhsJPKXKmED51d9BIkuuKMGAxL8ghBfL96lhazVgtF/QaaL5wA
	 bi6LKjzjy56Ow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0018AC595C0;
	Mon, 10 Jun 2024 15:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: qca: Fix BT enable failure again for QCA6390
 after warm reboot
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171803462799.21636.13193353610709896415.git-patchwork-notify@kernel.org>
Date: Mon, 10 Jun 2024 15:50:27 +0000
References: <1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com>
In-Reply-To: <1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, wt@penguintechs.org,
 regressions@lists.linux.dev, pmenzel@molgen.mpg.de,
 krzysztof.kozlowski@linaro.org, lk_sii@163.com, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 May 2024 21:31:34 +0800 you wrote:
> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
> serdev") will cause below regression issue:
> 
> BT can't be enabled after below steps:
> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
> if property enable-gpios is not configured within DT|ACPI for QCA6390.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: qca: Fix BT enable failure again for QCA6390 after warm reboot
    https://git.kernel.org/bluetooth/bluetooth-next/c/d2118673f3ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



