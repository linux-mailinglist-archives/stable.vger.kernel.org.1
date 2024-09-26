Return-Path: <stable+bounces-77765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8D7986F70
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 11:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0231C218AE
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 09:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76CF14F114;
	Thu, 26 Sep 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmumwoTR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FAC610B;
	Thu, 26 Sep 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341229; cv=none; b=iM56kUhDWiJLCYGYmKDBr9KUG5KHeXDMRWGLz31/QQVjm6Rz/Rop/MpzZ+/FdPjBB6+Tpy+oAmEe4jfyIP2pxdI+nCF0XGzBKQpH/vJAJNTnBLkDFSLJhoM6Gh7R8YUzJwIW2GFdCf8dDcM7Xdjlt1TOFJGJ7m5ePf5xHCwQeS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341229; c=relaxed/simple;
	bh=UMJdoJY8tPgme2bAZ6M6eFWFlg8c/0NZ1rSPKltyKB8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i8mekQz75CjEFi+4WRGs4Va0I8laBxPnN+4lHCK1xQdfE5hTuORjsCyZtRzXD3D+c6rxFqHkztWuKDKFcDqM9i23m7tIoxEHdFIuMxrBoMyhlu9F3nJhD0eHLqTNHaRF6wbqILQCNWT/14pqx7OYSj0ckGvCwOBLcooo19g42x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmumwoTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CF5C4CEC5;
	Thu, 26 Sep 2024 09:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727341229;
	bh=UMJdoJY8tPgme2bAZ6M6eFWFlg8c/0NZ1rSPKltyKB8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CmumwoTRBLqKNmwM9+43L/BETXs02XSso9VHoU7yA/cInNSHHYU2ogfyEFpcKKBcB
	 eL77XqmkNzKr1ePbF0lcEXuDOCp1ZKNCtCuEqaA7TLQfXoqcmSJpkuL86TdDRE/Dco
	 JTpm0APPtVpztqpibJvWrCtA7KWbiZ0PZm8nOhfgBDEbP/oMogxFkv4+WePgFT02LN
	 8JyLHWGh2xjk111z82ZxfgV+MwzasZZhWjBGjQMrF7eFPmeQ1hqRv33+Ke5Z8VJeC+
	 almue6WdTTKDbAapBCzonvSeuPbfOsK3KBNlAAbK3H2lXXvSnA1mysBM3oWjxoMHPm
	 YsfSdBVWbb0zQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF6B380DBF5;
	Thu, 26 Sep 2024 09:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3] usbnet: fix cyclical race on disconnect with work queue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172734123152.1176897.11617917642549187841.git-patchwork-notify@kernel.org>
Date: Thu, 26 Sep 2024 09:00:31 +0000
References: <20240919123525.688065-1-oneukum@suse.com>
In-Reply-To: <20240919123525.688065-1-oneukum@suse.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 19 Sep 2024 14:33:42 +0200 you wrote:
> The work can submit URBs and the URBs can schedule the work.
> This cycle needs to be broken, when a device is to be stopped.
> Use a flag to do so.
> This is a design issue as old as the driver.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> CC: stable@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [PATCHv3] usbnet: fix cyclical race on disconnect with work queue
    https://git.kernel.org/netdev/net/c/04e906839a05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



