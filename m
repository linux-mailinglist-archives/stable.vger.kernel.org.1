Return-Path: <stable+bounces-159301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF92AF7154
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 13:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B290F4E68CD
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 11:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40892E5418;
	Thu,  3 Jul 2025 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRjHPSCk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DCF2E49AF;
	Thu,  3 Jul 2025 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751540385; cv=none; b=Pil0TLAPmL+z9J0Vri85TYagKVYPUDF5riMMbJ+xex3yUwqAyUgGkf+RY6sXIVqTvLCigf7/y52ZnGr930eY/TPzOWSHRvfXiyozbzYNo9fJMfxq1740jDZvHUPsuaOLqBv7GUN0KHpyHyDcAkXWr+GxvEXeoaYWcEnoH1mgt5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751540385; c=relaxed/simple;
	bh=5Wfu3BOvo6JOU2//k5Zq3JqFIi9e1V4gRH8NmL7fsD0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ehZtSO3yEgHccbAxi3E1vFHYGuEIJo5PgNYiHfWlSYAv1vySF3MHoY1vp0uPBUqsNLpp+58xKXiXzTkTSL4p4858X7lhYohFbn5Bjr9vGUaW80MuKYBXFmm5Wf3g0YUtHZMJUGPrZtLYexSPJyDsVOPjyYpf4CUPbAmc4fWstOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRjHPSCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E22C4CEE3;
	Thu,  3 Jul 2025 10:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751540385;
	bh=5Wfu3BOvo6JOU2//k5Zq3JqFIi9e1V4gRH8NmL7fsD0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oRjHPSCk2Ehs7XgfW8EUvFjU1aHTAOW0sFsEX1FpOe8ck4oDoyJ1v2kYG2IfMSqpZ
	 lTTlaCa66BWx7SvJzO8UmMWEztsfmgz9rDDAgebXt3a74c5GqpczqmgrCmvK+ngK80
	 ryiqHtAvh2yqR+enjVPW0a/dFz3ZJP32rZEo1Sz8emihr8Mo3MbWBbc9Vl7i4/iHXk
	 2KCgQNYCu8SxlSzU8SVdPxNiE8MQlfTRWlpKWrIYTHR2/1b08eLyN5ruvqVRAcDAuN
	 rETvLuvaazPFvXDieGc/COmJJh12qx45jYgYL1EL5QSrwVaZc4xkhmmuqH9zSXbRw8
	 8WNlk4yW2L3RQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0B8383B273;
	Thu,  3 Jul 2025 11:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dt-bindings: net: sophgo,sg2044-dwmac: Drop status
 from
 the example
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175154040925.1407041.4796273578925200591.git-patchwork-notify@kernel.org>
Date: Thu, 03 Jul 2025 11:00:09 +0000
References: <20250701063621.23808-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250701063621.23808-2-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, unicorn_wang@outlook.com, inochiama@gmail.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  1 Jul 2025 08:36:22 +0200 you wrote:
> Examples should be complete and should not have a 'status' property,
> especially a disabled one because this disables the dt_binding_check of
> the example against the schema.  Dropping 'status' property shows
> missing other properties - phy-mode and phy-handle.
> 
> Fixes: 114508a89ddc ("dt-bindings: net: Add support for Sophgo SG2044 dwmac")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net] dt-bindings: net: sophgo,sg2044-dwmac: Drop status from the example
    https://git.kernel.org/netdev/net/c/f030713e5abf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



