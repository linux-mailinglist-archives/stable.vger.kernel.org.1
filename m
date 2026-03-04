Return-Path: <stable+bounces-223076-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBLJKO09qGl6rQAAu9opvQ
	(envelope-from <stable+bounces-223076-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 15:13:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E66420118A
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 15:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45AC431BC319
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 14:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922EC3B7B7D;
	Wed,  4 Mar 2026 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0JMGk+4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F33B7B6F;
	Wed,  4 Mar 2026 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633079; cv=none; b=snmOBEEQZ0KgAbKYttJFtfiRrB8eO/M0xoOshQv32OtwQ2vt1xluYrtFMvg0u+kkFPXx+Y8v+tlZGCRzVQO+OL0hBEhnSNW25v1BCCGx5dF3//Qe9Yj1iLt2xUG2dVjKNDVeNAbhxClQFYwqASV0uzP710XeIQS1cEO5G8PUHS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633079; c=relaxed/simple;
	bh=8hKpZqobONRAFI8JbyXl4XVl7XkoJta4OpzfLBMKntk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gqX2zUf8JEGqjXBYL8RNp+hLDfUjTL/68FvMGyMIEHjQT0XIgmLxPbIUu7PV02XGGcUG0+1XbUlOtDc3uuxMOLw0ISI8LZ9lki2lwZ/V6G8i8dWcWEnl3/tmotbHEzcbdSOomwG6/deYStuKakM6IKcOe1y8iYrky6EtgrTR9/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0JMGk+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76D4C2BCB7;
	Wed,  4 Mar 2026 14:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772633079;
	bh=8hKpZqobONRAFI8JbyXl4XVl7XkoJta4OpzfLBMKntk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=p0JMGk+4owySwHekczhJSMQkDp/fuhBSto6xM6+0YZZqDAcX6rA7Wzw2Qhp4IjBbh
	 rqr8zu9GrgpktD0P+9nU2n4cSwh1LUxserAID1nsSYFwf79zpQYE4fUwpYMlFl26c9
	 +A/Ez9DE0MQZt06s1ZmJQLjbMtxafxpCwWKX/IuQzwl/mktFJJx7j1qIzN1+gSs6Ea
	 /AIs1HYBdLSSiIhgM9m3nho0cpNocYoUnC901gfM2szvz5qdqzr4Rcj+7NZ5o2aGih
	 ZfliyegvNx6K/3ShpnAlg2e0N4yXbkX6KxdLSfLCx+wOpJ2lA8sCRX+VDtbKT3yi+S
	 EpWyTXaSIRGzQ==
From: Mark Brown <broonie@kernel.org>
To: Vijendar.Mukunda@amd.com, venkataprasad.potturu@amd.com, 
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Zhang Heng <zhangheng@kylinos.cn>
Cc: talhah.peerbhai@gmail.com, guspatagonico@gmail.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260304063255.139331-1-zhangheng@kylinos.cn>
References: <20260304063255.139331-1-zhangheng@kylinos.cn>
Subject: Re: [PATCH] ASoC: amd: yc: Add DMI quirk for ASUS EXPERTBOOK
 PM1503CDA
Message-Id: <177263307663.96340.2806963943399895082.b4-ty@kernel.org>
Date: Wed, 04 Mar 2026 14:04:36 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-6ac23
X-Rspamd-Queue-Id: 0E66420118A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223076-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[amd.com,gmail.com,perex.cz,suse.com,kylinos.cn];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 04 Mar 2026 14:32:55 +0800, Zhang Heng wrote:
> Add a DMI quirk for the ASUS EXPERTBOOK PM1503CDA fixing the
> issue where the internal microphone was not detected.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add DMI quirk for ASUS EXPERTBOOK PM1503CDA
      commit: 325291b20f8a6f14b9c82edbf5d12e4e71f6adaa

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


