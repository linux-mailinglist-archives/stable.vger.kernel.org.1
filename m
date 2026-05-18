Return-Path: <stable+bounces-249336-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEwiL+U+C2pdFAUAu9opvQ
	(envelope-from <stable+bounces-249336-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:31:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AE2570F44
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00A1C3054231
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF45E371CF1;
	Mon, 18 May 2026 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoSb7SCJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C8423C8A0;
	Mon, 18 May 2026 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121441; cv=none; b=Y8k3EWzemBN4aYhNNq2MWYiVkQ6vn4S+xaUHBR/uh2FWNbgYvtZ6OJfKNalYoS4nYWwbJN+NhpJZLtfJUQmaHDyI1P2cgl2wN7Cla/Cp7f+bQqk9fjUIRKzGtabNMzCgVOmiW9OfBPWWXq7kRvIt19bO9/muUeYX8DO5eKcyw6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121441; c=relaxed/simple;
	bh=fKQruQ7M7VOk36Hro21Vq4MYVghNnUgHIPzzALWoe80=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rjUpjhvUZmVPjDNqVwaLA9jDkoTPQEi62nFu2JreuehR7RSrzCGUPBSHIIIDEsqtS9/2aYbQsdW0uklUxEi2XODC3byoQ59VG7nSVJOYihvOIqKx6oL0HdzSE0X0zl7eSVLEMALHEsLbIGKB/VfiYs+5zg4pNYX+zULBuM80Qy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoSb7SCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB764C2BCC7;
	Mon, 18 May 2026 16:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779121441;
	bh=fKQruQ7M7VOk36Hro21Vq4MYVghNnUgHIPzzALWoe80=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZoSb7SCJWAIlaksVZvaIUN7twee63cZ4OiACFkZgAtZTxCbUW/vFkgmfkpDpA8Jqa
	 0gA3bDn/PwKNwKUyuqywyCOtlewHkIpztBzcXekS7DW0kT6sthJJBEvlknqjfCIfI/
	 YZTzUA0shmqUu1QJbt64ppR1k0Xu5EFfjcLAB6mYboLx/JKOev62RDWPIINQ/flCBw
	 7rh0glknPoW/wICudz/5LS8NuK9HJbINnom0WuZJtf8TAIEjC188il2T17d2alTy9U
	 2fL1TIJ8LDDBh2czA9Bkyk7wa8my4dxDIVyYW+53i/IwlTZ7J3DYCITbXOUdqvvpxb
	 yiynRes4U3ImQ==
From: Mark Brown <broonie@kernel.org>
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Shree Ramamoorthy <s-ramamoorthy@ti.com>, 
 Francesco Dolcini <francesco@dolcini.it>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, stable@vger.kernel.org
In-Reply-To: <20260518083113.2063368-1-alexander.sverdlin@siemens.com>
References: <20260518083113.2063368-1-alexander.sverdlin@siemens.com>
Subject: Re: [PATCH v2] regulator: tps65219: fix irq_data.rdev not being
 assigned
Message-Id: <177909879431.31945.5152188699162995282.b4-ty@b4>
Date: Mon, 18 May 2026 11:06:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fKQruQ7M7VOk36Hro21Vq4MYVghNnUgHIPzzALWoe80=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqCz0dIZKaXCFTRvdCLqCORghGQdgopctLMQ7MM
 GU/sZ9BO9aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCags9HQAKCRAk1otyXVSH
 0EhFB/4yMl+qTHK9K/ZfiVdM5qcpjUxUQXNSdgcITtYRCQhPHCOXKTO8KlfCJZPZ57Hj12YKSUN
 nEtqGrvZApt6VfXJ86d7fBSWvz/Lr6949N6qWePJrt+7hP5FGdrR2dfaQvJAmUQk6RV/8exe2t3
 F2WVA1BWncZPQnO+hzc0TA9tPG0erJDN/NV4V6U77fUcuZXdvfvIrzdUgmv1R9NVZ31SahPBcCm
 1zLleZyifsOsx07bem1Ccc8NsE2mT7wDYF8tMXYYoRbJtH1glBEAwmXTniBTpTyIvx43+hwa0xE
 zxGgU8tjc4hSuLDj+rcdGG4opmYSsDRa6Jl3g5nRClOVEjNQ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-249336-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[iki.fi,kemnade.info,baylibre.com,kernel.org,atomide.com,gmail.com,ti.com,dolcini.it,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 40AE2570F44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 10:31:11 +0200, A. Sverdlin wrote:
> regulator: tps65219: fix irq_data.rdev not being assigned

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.1

Thanks!

[1/1] regulator: tps65219: fix irq_data.rdev not being assigned
      https://git.kernel.org/broonie/regulator/c/f9b2d3b703d1

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


