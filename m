Return-Path: <stable+bounces-271749-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rrXoCkimR2qscwAAu9opvQ
	(envelope-from <stable+bounces-271749-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 14:08:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2282E702327
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 14:08:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TrN7YCcS;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271749-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271749-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7ED97305D6BB
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 11:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04E73CF97F;
	Fri,  3 Jul 2026 11:57:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FFD3CF21A;
	Fri,  3 Jul 2026 11:57:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079847; cv=none; b=TV+MlfISics5TCLcc3XpZ27NnS+RSRPQ2w9TQTdApUnmMi9hpAjXt3KMZoOt4zvs1CnqtiNUjvU0U+qEExbrxu443T57Jhc7wMwyg5tDfVbhThuTz3ZgyxRg/Zz1+5JUcOIzzSrGuMBtSSt0tLFk0GGIfs2ve+B02mvltPWJmtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079847; c=relaxed/simple;
	bh=mjhiZ9vBbTTiylqj5boTzLy0FJak0YGzhXp4JcMwe0I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gfmgyJWH6k0PD61pZwlPmrQsVG2uJCB6gqC9xx+berCjQHwfgaFYlWW+m6aA/7HTXMe6kzjbx0+iStPO9JcZxkspLPqgwVO5gdqk+8cIQEGDPDoXhqtcJ7JZit8w6pm0gjUd+AD+9X5VYVffJhin52HR0duyDu2zuElQKnJG4PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrN7YCcS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F295D1F00A3A;
	Fri,  3 Jul 2026 11:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783079846;
	bh=VUzWpEIvVN3vzln3ZJKFLP88HgPmFtAHMwv8Tpk38G8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TrN7YCcSB42TXNtZ6N5NRiGL548hrVac3XDJX7kjz3jT9sxudKRzYcyxJ73CRPoXC
	 V/vnbWiuYEF5wgcJINzgeIxRiB8vpateLErBJ9OHsFLJFshA6q64JGAwtWbx5TSoZU
	 LJD5Krx5w3h9BCIbNRmKmMzHPrmrbllHRv0RkbyWYUEok9Wz2QCgCHsbCxEF1eIO26
	 Uqhr2JgZTJTn4QvR5DZYaMJziO7ftTzip3bfw+GwHae+vumt1/Zg6s0FstA5q2MrQh
	 11/S+M/AUAHKPW+Qf0ju+Thiju6faFVCf519EmO4f2Sm2b9eUJy+j78EqaBPhcSk2f
	 vDzXk68yPO0KQ==
From: Mark Brown <broonie@kernel.org>
To: s.nawrocki@samsung.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, WenTao Liang <vulab@iscas.ac.cn>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260627035251.60172-1-vulab@iscas.ac.cn>
References: <20260627035251.60172-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] fix: sound/soc/samsung: aries_audio_probe: double
 of_node_put due to direct assignment without of_node_get
Message-Id: <178292410864.38925.7549836942770345369.b4-ty@b4>
Date: Wed, 01 Jul 2026 17:41:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1230; i=broonie@kernel.org;
 h=from:subject:message-id; bh=mjhiZ9vBbTTiylqj5boTzLy0FJak0YGzhXp4JcMwe0I=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqR6Ojd4JVrzFrQUxKOQhFE/u8/H0FJK/XuUrjs
 pTRvL0VHOmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakejowAKCRAk1otyXVSH
 0EM4B/9y1THQslVzPossxAkEEXRlaFTGlFoRSn1pMYZmBkiBn6FnnK9kUEAMwCzOv4GNUV/j8U8
 dUt0o925XjpbqUU7AgMmx8/rKMV69sR0jo2zCtd+STtFv1wfyjSL+nOCRxSuzZJ7FpAkoU2o/Of
 XRXMB6soOWn3qtJQEvKSHUvhWEcOKL+1vHuQ9NxcBg7eHGPWBFm9PkYXYrO3woGnVNucNqHgh8T
 MtRcYVGkMvLiHFoRjC++48AkBPzGVzex3igAxjr0rd/Xi/fp6OYPSwoxMrrKuVouKlHtP78dAu9
 vqZOl3t3hVenRA2rMl/gdIP46RKX8kMgOYf7zcdunKE9zKbp
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[43];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[samsung.com,gmail.com,perex.cz,suse.com,iscas.ac.cn];
	FORGED_SENDER(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:s.nawrocki@samsung.com,m:lgirdwood@gmail.com,m:perex@perex.cz,m:tiwai@suse.com,m:vulab@iscas.ac.cn,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271749-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2282E702327

On Sat, 27 Jun 2026 11:52:51 +0800, WenTao Liang wrote:
> fix: sound/soc/samsung: aries_audio_probe: double of_node_put due to direct assignment without of_node_get

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] fix: sound/soc/samsung: aries_audio_probe: double of_node_put due to direct assignment without of_node_get
      https://git.kernel.org/broonie/sound/c/fb5d1b1c5f8a

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


