Return-Path: <stable+bounces-231293-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMDzIzT+ymk2CgYAu9opvQ
	(envelope-from <stable+bounces-231293-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 00:50:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E43DD3621E3
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 00:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE926304C111
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 22:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3405D3A1D0A;
	Mon, 30 Mar 2026 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faHov3gX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5573E3C6E;
	Mon, 30 Mar 2026 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910541; cv=none; b=J3r7VW+Wgz1F8cEo/EimR+PqeluUFNbKQjFdAzUetRffDYLKv//Mx7C+wvdwC/gJZhEGnEinpp0t/3UJIgKrj5PwvjrK8/rGei+Jix5PD+hTMIY16t1kvtpBErGVfEmA9hZfbpzyxcNvThmfauVF0pBGyXjwOTYWiE4PmldasPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910541; c=relaxed/simple;
	bh=gwATsu8ZZjXHQkyabRMdm97pkQYai65eXJBnHZ15OMA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gzkbHqzXLsIvf/4AO7aTAxsf7bBhtcz1koknM42lomvS28mMFGTMNTkunBEli8NplnYITBQ3TgdwAvYEWquKGniDTPEZtdDXQw9ih7dvd1CMaXahjSwp8Mce2JCbIU95ZscLFuTtWNwP1HgUwUxTXgmUWvaeMWAnwUNOzzSiw/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faHov3gX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96B5C2BCB1;
	Mon, 30 Mar 2026 22:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774910540;
	bh=gwATsu8ZZjXHQkyabRMdm97pkQYai65eXJBnHZ15OMA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=faHov3gXtvlYY4u2L5fM39dYt0wL4qFpOOnADVRPKyMZOWmwmhGRfLL/vlha7jQhe
	 BKj1POUnz3UqIVt266XIzgBMvXsUd5HjZ6U7RXTc2IepPzQKO2msn93NjxvLMu4ixh
	 tCRVch1+f9xSFDog3cxYo89/zud7ZgKkZM5uw2YYzbaCpJwz2BQINvMNYEEA1msw6e
	 r31ItkLXi7le/shCFd6cOvA9CqxtjGzlg8sHwFiHmAEwgTYJNW6LnmzWlchOW1+7va
	 7hAR2ICztX4Opr2yzFOIV/KgtuFrcVSVp0r03rajhZOLA7xiZuaEp9kSUT5t8yaiRf
	 NoP//jgLvnDmQ==
From: Mark Brown <broonie@kernel.org>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 miquel.raynal@bootlin.com, a-dutta@ti.com, s-vadapalli@ti.com, 
 mkorpershoek@kernel.org, khairul.anuar.romli@altera.com, 
 stable@vger.kernel.org
In-Reply-To: <20260313135236.46642-1-ghidoliemanuele@gmail.com>
References: <20260313135236.46642-1-ghidoliemanuele@gmail.com>
Subject: Re: [PATCH v1] spi: cadence-qspi: Fix exec_mem_op error handling
Message-Id: <177491053855.513566.10943555752858611940.b4-ty@b4>
Date: Mon, 30 Mar 2026 23:42:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-3ac6c
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231293-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E43DD3621E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 14:52:31 +0100, Emanuele Ghidoli wrote:
> cqspi_exec_mem_op() increments the runtime PM usage counter before all
> refcount checks are performed. If one of these checks fails, the function
> returns without dropping the PM reference.
> 
> Move the pm_runtime_resume_and_get() call after the refcount checks so
> that runtime PM is only acquired when the operation can proceed and
> drop the inflight_ops refcount if the PM resume fails.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-qspi: Fix exec_mem_op error handling
      https://git.kernel.org/broonie/misc/c/59e1be1278f0

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


