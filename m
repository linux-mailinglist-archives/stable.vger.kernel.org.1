Return-Path: <stable+bounces-249504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNFSIlAuDGq0XwUAu9opvQ
	(envelope-from <stable+bounces-249504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:33:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDF457B5A5
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A2E13122002
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093D53FBB4D;
	Tue, 19 May 2026 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iulxbs80"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5433F6C49;
	Tue, 19 May 2026 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182735; cv=none; b=XDuvnp9zbuBzccpwaUmDn7I/z58+y3/Snqn1icNVOFs/vAENZ6JulXxkQ5+irrpIyF50btpAV34huUMbWLAwWZ+xZqsQEvCdDZpqQZ+EBqzu8l+3L+L3GEBDId35oX+z4jQqlWD0eZkVIZMmNAmMEyl4nXDGGemz7wAIe1hXRKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182735; c=relaxed/simple;
	bh=gSbC4vxvN6/O0thQ/G/IoxvEjhktiLOb6u6xT4rl5C0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kxHl2zh4fLiRGX8q3mu0T5KV8WKoETBCwDKctKaif53EeD4kApdEPtJXI96uB/E9qulZ9MydejTjpt5P3L3cdfu95CJQx5X6oXyOofrxAg9zhXwyAJ7Y32di/swJ5QIxmDUjbIBrGvNK8uuv7z4tXbMC/aJYkf1E4WuTxVTgank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iulxbs80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65628C2BCC6;
	Tue, 19 May 2026 09:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779182735;
	bh=gSbC4vxvN6/O0thQ/G/IoxvEjhktiLOb6u6xT4rl5C0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iulxbs80Wa6S/umEcfaS9Uu9pu52ZsbtD3PeBwdzqPrk6N3aru3dni48wqw0h7cqV
	 L7qV8dburCgepFlukiCB+eI60I5RufM6BNt0++Z/8YybzXYHGRkIXoolaF6yQcPbtD
	 uUTqvO8BSt//JBuhrjA446U/hPZ4Q66rUTycST24MPi75ngKJbIChMj6enZ/VBnIuH
	 4R3oPjwYTg3E6jGlErsuHI2Nd/qUh2hzC9Bl7HgiHTHM5Jzwdg2WrZaz4getrRnHm+
	 g/pY02Ps2n6ZlgSAO983M+apOJ3tFKybCPz3IgL1CNlF8ki/ZFfIcSMj7+YVAHJB79
	 JBuLQpRsUrQrQ==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Vignesh R <vigneshr@ti.com>
In-Reply-To: <20260512074809.915084-1-johan@kernel.org>
References: <20260512074809.915084-1-johan@kernel.org>
Subject: Re: [PATCH] spi: ti-qspi: fix use-after-free after DMA setup
 failure
Message-Id: <177912247575.352391.7008665146176186060.b4-ty@b4>
Date: Mon, 18 May 2026 17:41:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; i=broonie@kernel.org;
 h=from:subject:message-id; bh=gSbC4vxvN6/O0thQ/G/IoxvEjhktiLOb6u6xT4rl5C0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqDCyNq2wBktZlJ/gnMpnqJEIbfAMsKzB8dNZdT
 IyWFiuHnYuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCagwsjQAKCRAk1otyXVSH
 0JVtB/492/S25LYIqu0hDKasdjUmv1udJPhJ2xNY6nEBHpGF5aYcNpOiBuTc9dcy7z6aq33qqkM
 OQIyUEo0inzS0trbZXcMHG9I5cQJ2mFbK0GV2T1CprZaZqs8USIsWMH94OSkiK0thRanBFyo9x5
 Ya7nKhtC7+Ago1h4h4dVOCVy60mKDk+/Y7K/WXKuGVUS0EnMLeBQrhhtjptTA5CfTaD01gD8ctP
 lFwl/Nt3ZqZURMmC7F7is1oGt90qo0Xh7zXPTcIJZqip9txr97t5peuI4iN3wAGqhhjNegTByAs
 js/yED8t8oOZlqFo3MUiVW2ykNPw1j1tahNrGKlPEWPXs4/M
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249504-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0FDF457B5A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 12 May 2026 09:48:09 +0200, Johan Hovold wrote:
> spi: ti-qspi: fix use-after-free after DMA setup failure

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: ti-qspi: fix use-after-free after DMA setup failure
      https://git.kernel.org/broonie/spi/c/ea6ec3343e05

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


