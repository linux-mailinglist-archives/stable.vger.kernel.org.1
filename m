Return-Path: <stable+bounces-269954-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 96l0IS+pQ2rkeQoAu9opvQ
	(envelope-from <stable+bounces-269954-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 13:31:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 198E56E3A11
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 13:31:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YCJ+wqT3;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269954-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-269954-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D1EF30878EE
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 11:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF1F40B6E5;
	Tue, 30 Jun 2026 11:17:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7AE23A99F;
	Tue, 30 Jun 2026 11:17:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818261; cv=none; b=MifYUjlTHO1BdhNxQ1DxxLGQTjkEeE4OFh+LMqDyMpCmnutKQxQtcjbxLmAbv/tIomy7O628//kNylmB9WI/DfDPCn9fKwoVAUfW5Zo+OJAAVnw43NGktfEb3EVxlfk3pzXVfRHPw5S3j9VmqdwFjl37btIm07XrjH2RWpSSiMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818261; c=relaxed/simple;
	bh=+pzVlDLY1JAWqC87iVkSYzzMIyWnp7ilg0qVsvTgGYo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HxrzwqA5eMqgyLnU1GtMxutkFw2nNLwxfjDbLLUMwHhiI/ZPMHpdI0Sb8ocErhi6fQ2NP800gFUONII/tnfjmAA4/DPg0ds5lLPdQo1APVqLY35Uv2h7x2zHF9PzCaWZdV+9PkXCgqTX3xJru2mX0Ofr1ZChzOjICjT+KSxmdWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCJ+wqT3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181871F000E9;
	Tue, 30 Jun 2026 11:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782818260;
	bh=eWErjEHMXrBAqZq3Vq7mxcKe/AWtpJ3hBdzLT4L4FaM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YCJ+wqT3GlL0vlsc2XBaRSnsNz/cNj4xnc4DbIn7dI1oBWDOLDQJfptWJgRqpptt8
	 /5HoWFgJpaUcZPWB3B9IFbQIForqb6XoZkBPjBBsfdd+UyxSc55HnLL5RCgxpEfk9o
	 O/OfTGUMFkKBLvNaJF9so7sHYzBljZ6S4x6JtEFpTlUBdRY+Ow9BwvYoBc04Ujl5eP
	 dTGbxqMtep2zxQ81cABG5KWSehuSNdNsu4vrY+4IOB40C/Z8yxUcma7s9mQd0yG/0N
	 YF4xrbNQWu4EljaaL/mGAsSvf6W8Lr649eN2bbwIW1Im5711UV+hcGWQgDAuS378Yy
	 iGrD2CPH/ncGQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 emillbrandt@dekaresearch.com, Haoxiang Li <haoxiang_li2024@163.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260622094822.926166-1-haoxiang_li2024@163.com>
References: <20260622094822.926166-1-haoxiang_li2024@163.com>
Subject: Re: [PATCH] ASoC: fsl: mpc5200-i2s: Free DMA resources on probe
 failure
Message-Id: <178275534193.47562.5080617272977636428.b4-ty@b4>
Date: Mon, 29 Jun 2026 18:49:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+pzVlDLY1JAWqC87iVkSYzzMIyWnp7ilg0qVsvTgGYo=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhiznpZc+NX6T22xu5c8YtyTwvMZXlfi7xxt+aNpL1PK02
 ISERzF2MhqzMDByMciKKbKsfZaxKj1cYuv8R/NfwQxiZQKZwsDFKQAT8Z3F/pv9Lo+/eo5yvmSN
 s+nlU48dlonG8OZsfvP8p4t9i3rFpcN6Ymd+u+54khKy9eI67cokkaDTCywWXg3vLvjSxTopOOu
 xxQGt3B+xvS13bT818u54ebpIOP/hjq6413xHXk6//VJGLpv5sVkyj8H3AI75Uw94TmS958Slv2
 hhypq2/123Sz80VKcucrOT2yeYrnBbvKPd0tQvX1TD8+s9ifZZ89S//pMzCnQLOsvPf+HB61THp
 nbntMmHt5vLK/l9/XRSKZKPM4kt3SKrJeCo8jSp91Ls7402cAnzF5rNvPJps0bdlxTTh97Las+9
 Znvmd8PhgsxM279GU1a9j/SKl9OZMFmWYUl59SeHHQdLAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:lgirdwood@gmail.com,m:perex@perex.cz,m:tiwai@suse.com,m:emillbrandt@dekaresearch.com,m:haoxiang_li2024@163.com,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,perex.cz,suse.com,dekaresearch.com,163.com];
	FORGED_SENDER(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269954-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 198E56E3A11

On Mon, 22 Jun 2026 17:48:22 +0800, Haoxiang Li wrote:
> ASoC: fsl: mpc5200-i2s: Free DMA resources on probe failure

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: fsl: mpc5200-i2s: Free DMA resources on probe failure
      https://git.kernel.org/broonie/sound/c/3a89ddcf0c3d

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


