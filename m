Return-Path: <stable+bounces-50191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED94904905
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 04:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E841C215BF
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 02:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40E820332;
	Wed, 12 Jun 2024 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6Rqak24"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943DB1C6BD;
	Wed, 12 Jun 2024 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718159432; cv=none; b=Jt1xSf75YoOddf/rnGAON+dNZF3fUmmkExVNBxkU1c+spw7T7ayR5AdSP4wHoLOYFlXm2c2yzlPlDaVxh+iLRs3ZY+rf0sJIXO9srtv2yv3dRmFp1iVu2eDlZWz+t+iYK2gO4iiEw+35toYGyurQrOW+xvRgFYzL5DoAbZSbOGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718159432; c=relaxed/simple;
	bh=sL68/p5fx9N4glXxswRuEb+CPuAV/pOcY27ovpcXSh4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LqeYx2LY7bIljh68FI9W9kcEnDwkCnZqqqyEv3UFuPmngMiYXeL0GSLxN05cWLzJBE05KNKPCz5IxHf6p8EOtWe+y25z5c/8vCDaIlmu6/yQihBFZpYb6l7wfz6hNZhqilhoYgVosS1P/Q+7yuE7vFx3dVyk4zznV8V9uaBQvyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6Rqak24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38CF4C4AF60;
	Wed, 12 Jun 2024 02:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718159431;
	bh=sL68/p5fx9N4glXxswRuEb+CPuAV/pOcY27ovpcXSh4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S6Rqak24B6bsjkx/oJYfiBROfmJGPzlJL+WFlfYs3wg2gej+zK5iaYYA76uPCl+Ip
	 TYx5RYC7hyNdByXgGK6CrlNb978QEwdvtUyRY4fBF9zNAJzjpfSykdyTNav+xtl7EF
	 GeofartLDAJicbmiVVRPcpEQZZhDBHw0aS69H9mjxrFGdaTGpcFyVHOcNn35f+wc4s
	 BcqCVzzbn0HeUsVuRelbXO591P/72k1qrnZXH9MRpPFZ3SV2Tr1lusUINlAkvUQKrU
	 ycq784u39E39IAIKG1p1ntC57D75d6pxXlb6YLrYBC4Xq5ACWui4UTbdZA1keQylWL
	 /HkBdHSpEi5yg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CCC2CF21FA;
	Wed, 12 Jun 2024 02:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_ec_debugfs: fix wrong EC message
 version
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171815943118.29023.8712192231610331664.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 02:30:31 +0000
References: <20240611113110.16955-1-tzungbi@kernel.org>
In-Reply-To: <20240611113110.16955-1-tzungbi@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, groeck@chromium.org, chrome-platform@lists.linux.dev,
 stable@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Tue, 11 Jun 2024 11:31:10 +0000 you wrote:
> ec_read_version_supported() uses ec_params_get_cmd_versions_v1 but it
> wrongly uses message version 0.
> 
> Fix it.
> 
> Cc: stable@vger.kernel.org
> Fixes: e86264595225 ("mfd: cros_ec: add debugfs, console log file")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> 
> [...]

Here is the summary with links:
  - platform/chrome: cros_ec_debugfs: fix wrong EC message version
    https://git.kernel.org/chrome-platform/c/c2a28647bbb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



