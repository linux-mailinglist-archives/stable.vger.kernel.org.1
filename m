Return-Path: <stable+bounces-225646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEgiJm1DuGmLbAEAu9opvQ
	(envelope-from <stable+bounces-225646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:52:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E4929E921
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14D463026310
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C175333C194;
	Mon, 16 Mar 2026 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nv++Vmla"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387133BBCF;
	Mon, 16 Mar 2026 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683550; cv=none; b=DC3AcFBxtyiT5W42gUrbzICOL63lYlJgmC0NKNccA9FEZ6cDPl5wZjfTbjB1if26Axh0N3F19ix8TITS7S784iCqOg9RjTpkd8wlqSRcQgGEeK53aZRdNX702oOsuaC8gb9U95MiLv3wj6Ckj2Dv0E3QF+K/2O7sq8ZD4AwKu3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683550; c=relaxed/simple;
	bh=ihYgF8mmfqtAQfrt0I3Lt05gQbo03eKgyfzu5ZUwvoA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rp1wO8rNn27c8xaF4hXa6R3AA1UBAVALQqdXQl8owwdTuSdLMyRjwR1jHPhzYPPsV8Azk3ZpOrmmlpP5ftEK3pWU8uAqivjwqhlmQxCNcLW9u6MXm/kxy7GwIC1zcDqRKhQ+bHiYEFUB7mayNdrOj6PrXAEfWmJZhA0BOdoOges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nv++Vmla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E9FC19421;
	Mon, 16 Mar 2026 17:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773683550;
	bh=ihYgF8mmfqtAQfrt0I3Lt05gQbo03eKgyfzu5ZUwvoA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nv++VmlaXtX96TrZIjE1V0eTCxueJcOHtZdVxilkZpaSJPEbLJqKqPOoU25RmHAOc
	 Yg25adfQS4CxkX+p4M+P8/EOc2yujV/y4Oon0Li/iJc/d0DygrlMBOWgnIIS0VIcpO
	 znGjxnmYaElb1kryNIpCmdQyR4VyDlmcvnDwt28T2RdrNuM0AM95ZdHzd7estvek2n
	 P5LIgbQri1D41W8Nvtnn152C3uspl9IwFm3JUMvN3001ZqhqBkQb//0Dk4Z8vTCH+U
	 7xsAOcpNig5Q3aqQSWAZlRkZqYggZ0eCzFqxQB5WnPmuN860SOxMH/BoAzjmznnsC8
	 vhQFEFQBrUoIA==
From: Mark Brown <broonie@kernel.org>
To: Kiseok Jo <kiseok.jo@irondevice.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Chenyuan Yang <chenyuan0y@gmail.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260312084749.365325-1-lgs201920130244@gmail.com>
References: <20260312084749.365325-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH] ASoC: sma1307: fix double free of devm_kzalloc()
 memory
Message-Id: <177368354813.146755.7830782283950300831.b4-ty@kernel.org>
Date: Mon, 16 Mar 2026 17:52:28 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c239c
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225646-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[irondevice.com,gmail.com,perex.cz,suse.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 23E4929E921
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 16:47:49 +0800, Guangshuo Li wrote:
> A previous change added NULL checks and cleanup for allocation
> failures in sma1307_setting_loaded().
> 
> However, the cleanup for mode_set entries is wrong. Those entries are
> allocated with devm_kzalloc(), so they are device-managed resources and
> must not be freed with kfree(). Manually freeing them in the error path
> can lead to a double free when devres later releases the same memory.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sma1307: fix double free of devm_kzalloc() memory
      https://git.kernel.org/broonie/misc/c/fe757092d232

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


