Return-Path: <stable+bounces-89238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFAF9B51D2
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 19:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13ADA1F21913
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 18:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBE8201020;
	Tue, 29 Oct 2024 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECkJE7Lo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08386200C8B;
	Tue, 29 Oct 2024 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730226629; cv=none; b=jGLm7cNKWEjP+XlnhumbwsJs6WbKM6fNnxVOg42O4HB8VJm/DkBY59Tc+vHFfsnGVc7EpQgxe6jlMhU7ZK1ugBrjTCRKi7lM649LVlYI4IrUi7X8zwv+vqi0dG7wkmH2VxeCG3AmRQEPX29rPLCqoiWhpmhH4jQsaOF1T6qLm7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730226629; c=relaxed/simple;
	bh=U8F/e4YgpC/1gKny5fehwNCkkiJxiDhEwiTjIwvI2mo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EF1l5GI1Em2nkWUs1eE4Vv8BTOOebD4myN462y0gSJGT98gyU+Pf9kQm3Rwimruh1ShSfnjGk2e+CbUd4Po9S2wHHtYocmYykxfn3fry8qjkwbdQzR6iMd8L3EN1RXedpdDE84RdDvNsBeSObCFFHnrSeJ/FU0BLOvws/G1VEd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECkJE7Lo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8627C4CECD;
	Tue, 29 Oct 2024 18:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730226628;
	bh=U8F/e4YgpC/1gKny5fehwNCkkiJxiDhEwiTjIwvI2mo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ECkJE7Loyau09Zm+yTIXbAx3IatjQrT/lp3GVTXf/e8dz+GArqwr+fgY1mxZwFzTq
	 nxL92ex6O7N3vQTC7/6B+tY90xm+GyXX+bbfaekSk6DagkNa3gaURra99TVUq0+zIX
	 KMvNMdb03GNu20DN5KEUMip/4xLp1RyzrDEKU0pFuzsl5FUpga0ngoy1Yc0rR/ETbh
	 mfss5imgK9ErF04722VbCWzu8be+o6A62Qxm94YO8a4LUPWAZRgBqZ6ZG+bWdZgEdt
	 Lp1WlZPqRSEZoHI8MBWftFExGXpMlb6oZzB4NHKoUUGwLbXaEjzCdFqwl7jYBsZWxJ
	 PdLJflzTls6fQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE23F380AC08;
	Tue, 29 Oct 2024 18:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] mctp i2c: handle NULL header address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173022663648.781637.16899989912077374720.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 18:30:36 +0000
References: <20241022-mctp-i2c-null-dest-v3-1-e929709956c5@codeconstruct.com.au>
In-Reply-To: <20241022-mctp-i2c-null-dest-v3-1-e929709956c5@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: jk@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, wsa@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 dung@os.amperecomputing.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Oct 2024 18:25:14 +0800 you wrote:
> daddr can be NULL if there is no neighbour table entry present,
> in that case the tx packet should be dropped.
> 
> saddr will usually be set by MCTP core, but check for NULL in case a
> packet is transmitted by a different protocol.
> 
> Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
> Cc: stable@vger.kernel.org
> Reported-by: Dung Cao <dung@os.amperecomputing.com>
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
> 
> [...]

Here is the summary with links:
  - [net,v3] mctp i2c: handle NULL header address
    https://git.kernel.org/netdev/net/c/01e215975fd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



