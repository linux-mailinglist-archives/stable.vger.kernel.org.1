Return-Path: <stable+bounces-238163-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED4yObvC32m9YgAAu9opvQ
	(envelope-from <stable+bounces-238163-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:54:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 911A240685A
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCBA63065959
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C183EDAD9;
	Wed, 15 Apr 2026 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIaKy36D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171A53ECBE2;
	Wed, 15 Apr 2026 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776271868; cv=none; b=Mv9kKtjEf0g9QUDzi2+8K04AqggbZToH+CLSsTSa0YWQssmRg6vaID+XrUZczDL/QwaTB7Nb7OVCMeDRv9GtijgQENLYNwo/JjdLMVNoAqtdlDKkjNYYorjRUsyyCVDWNwxYk1V86jCiAoe75XziehSShiJX8mCF+pUERZlGHVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776271868; c=relaxed/simple;
	bh=RA4k+nacALW64Qpgyul1RIM9M5oMRL9OXhrdVtb9T+Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ni5t743f7GNo+BmOYXIFpyjf+GHvWCM8nWAsFpEW1zW6176qcXxjNPhOMh8/lTIzNR+JqekJmGp6xcuTtEQHD6KYFu7/ip/lFdy0wxWhfQoctPYyUefLftO79hsjB0vnYnYeIS/lqZtRysWoDJTQ4rDxXc9WxgRTQnW4CXE+sR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIaKy36D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F176FC19424;
	Wed, 15 Apr 2026 16:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776271868;
	bh=RA4k+nacALW64Qpgyul1RIM9M5oMRL9OXhrdVtb9T+Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fIaKy36Dsycl6i8U5S64aaDar5Mr0+/mq1zT7GlPO3RZdfUVujqfMXCR6F1u0CT82
	 IlfflI0RCU+Z2xLaxb/LAP88js9GEAfC/zXyuxUGNrkAenWUyT5l3KN0Ga6u1oTTHg
	 7J/8XX8pBp0zhfAEuPHgGMVDQ33J9TaMzcEIWoPDQ18fqT5xX7ZxXWB/hoziqwdzrp
	 +7ubmvrlcVbJSochw7Sm9WFtq4yGLjW+yMmGmsfD1q/3Z45spFjCqhzmPLd+N/jnaW
	 6MmQ7FrLv6MxCZ00FYkG/2qG8pHivD7q73jgNBciOicsFVpQzom7RTa/2zVk5k4sF6
	 iw1sDkzQeAiBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F30380A963;
	Wed, 15 Apr 2026 16:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix uninitialized kobject put in
 f2fs_init_sysfs()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <177627183769.2303073.7362996361597300412.git-patchwork-notify@kernel.org>
Date: Wed, 15 Apr 2026 16:50:37 +0000
References: <20260410124726.2035729-1-lgs201920130244@gmail.com>
In-Reply-To: <20260410124726.2035729-1-lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238163-lists,stable=lfdr.de,f2fs];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 911A240685A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 10 Apr 2026 20:47:26 +0800 you wrote:
> In f2fs_init_sysfs(), all failure paths after kset_register() jump to
> put_kobject, which unconditionally releases both f2fs_tune and
> f2fs_feat.
> 
> If kobject_init_and_add(&f2fs_feat, ...) fails, f2fs_tune has not been
> initialized yet, so calling kobject_put(&f2fs_tune) is invalid.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix uninitialized kobject put in f2fs_init_sysfs()
    https://git.kernel.org/jaegeuk/f2fs/c/b635f2ecdb5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



