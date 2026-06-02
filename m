Return-Path: <stable+bounces-259984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WVtbLG3UH2pOqgAAu9opvQ
	(envelope-from <stable+bounces-259984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 09:14:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 132D96350EA
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 09:14:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KfsjrNxc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259984-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259984-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86AB1313D2A8
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 07:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8637339C002;
	Wed,  3 Jun 2026 07:04:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6374939B4BF;
	Wed,  3 Jun 2026 07:04:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470279; cv=none; b=LatpEj5CEkdqumlVuJziGAm7R1VT67In7qAk7wye0PtRENMT9i139VHk1bZMBaQ0sRGRQv4Vtw404PRwFJus7oHIbtGZqNAicweQxMy9RL1HWEnZfIhglCBZ0h3XHar0+ajTbpo6drHdWn+gvc7ZapMzdVyKBHr/2q10Ipwu7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470279; c=relaxed/simple;
	bh=eJuv17eLJZHSwOzwJZ0aqFGo6sAVK3Q/bWt1bbGlGf8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PUaxE3xeFVhRs1s9gjWiZ3exI3AHpr9tlL1o43ZHGNjUa2IwEloTfj0cqhsDCbQ32PpI7IdAU9+0sH1JGvvfdhVbjTiXWi3IspHKuz4XCWlck3tZXVaXVVVoR/jfSepy7zfvzWx/fCGmvyELxDywZTObTWJW6kvROEWY1I/cz+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfsjrNxc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1531F00893;
	Wed,  3 Jun 2026 07:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780470278;
	bh=6SqQTJLSLTc5ORTNNPdbBL07+KG62ToCTtBK3V8opPk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KfsjrNxcj1VMh69TZyNr766N2a5OtRF6gK+uhKgkAA78blDHXhFvob1gZ0pbhc7ZJ
	 psYMknlzRESOe8XHedppTqp/TwH0NQvYqX1C0IcjKKpzVg2P4tXc5wc6IHXCpHCxZW
	 ztvqsjJnkQcOTY6t9TdYanP+c6A+QMvBiwI/CCE45UibN5oD+Rkf1H4oRvCvW2OJdU
	 BxrEjOc8MeBktTm6SsPWOTbMZECll/C876od0b8jC4ng2kcKEQ3qM/PNkhsxCa3EpV
	 AnsSltcAE7PGUAJLOUAXS/0YALi4qaGQOHzqtaaKDV/wZR0U2uPbPKjgx1DWYaWG37
	 YmDSnAYQj/rmw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, 
 Jaroslav Kysela <perex@perex.cz>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, Shunli Wang <shunli.wang@mediatek.com>, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 notify@kernel.org, stable@vger.kernel.org
In-Reply-To: <20260527-asoc-mt8183-probe-cleanup-v1-0-4f4f5593c8d1@gmail.com>
References: <20260527-asoc-mt8183-probe-cleanup-v1-0-4f4f5593c8d1@gmail.com>
Subject: Re: [PATCH 0/2] ASoC: mediatek: mt8183: Fix probe resource cleanup
Message-Id: <178041307167.93058.8280968694103073134.b4-ty@b4>
Date: Tue, 02 Jun 2026 16:11:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eJuv17eLJZHSwOzwJZ0aqFGo6sAVK3Q/bWt1bbGlGf8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqH9IClZGO7bSnhuRJdTwfqiPVGBv1f7+UdJSuL
 6seECFgrcSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCah/SAgAKCRAk1otyXVSH
 0H2YCACBk8TC/Qq4VLNuBxjSwYqK8FPlGzzfq0uknvbQ+NhJuuocnTfTUXEDtPWJFSwPd+dwiCS
 DRVhecgclYTY6DhRFWPxVNp8qsKnQw9lF2oDJJtofi7CYc6tLNFy5jT0XmJv4ecjUPY8e+/STPq
 0hOXBUyYu4VvPPTPd/fQa/hX/AnRoAYNBpd+qW4st1Yceyml9yy/uuJ4Tm5BimdrVZJWwdcopR5
 X0q/2AoCJiqdEGLWBQAk//E43MzyCG49UBbkQLK2ZzFmrMmIQ1S5TVLrS4cFJBQHY9E02Q5yYri
 QGPRON907c1QK9wxAtJ8K3aQB6vkX9lpBVKED1pCwa6Z0ft4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lgirdwood@gmail.com,m:tiwai@suse.com,m:perex@perex.cz,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:wenst@chromium.org,m:shunli.wang@mediatek.com,m:cassiogabrielcontato@gmail.com,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:notify@kernel.org,m:stable@vger.kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,suse.com,perex.cz,collabora.com,chromium.org,mediatek.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-259984-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 132D96350EA

On Wed, 27 May 2026 10:41:47 -0300, Cássio Gabriel wrote:
> ASoC: mediatek: mt8183: Fix probe resource cleanup
> 
> The MT8183 AFE probe has two cleanup gaps that match issues
> recently fixed in newer MediaTek AFE drivers.
> 
> First, reserved memory assigned with of_reserved_mem_device_init()
> is never released on driver removal or later probe failures.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/2] ASoC: mediatek: mt8183: Release reserved memory on cleanup
      https://git.kernel.org/broonie/sound/c/bee65e00c092
[2/2] ASoC: mediatek: mt8183: Check runtime resume during probe
      https://git.kernel.org/broonie/sound/c/f0334fbfd107

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


