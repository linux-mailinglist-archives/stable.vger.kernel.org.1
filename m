Return-Path: <stable+bounces-256644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IHqIvOoGWodyQgAu9opvQ
	(envelope-from <stable+bounces-256644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:55:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F00536040BA
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4078431518F3
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B933EC2E1;
	Fri, 29 May 2026 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwcqhCA6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DD83DD537;
	Fri, 29 May 2026 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065742; cv=none; b=ZkgHUSllkuYA7aUWZ3shimoJpwApDDWeLyM1X/HKYb2padwW0BpRwG2YTNuUwb0j6D+ur0nNqqh7l7UQIhqKG7v1zJGCyt3xNW5uneh7L0eJ/WZJVJPVLmgcHshy8qwcTblK78z3oATlQdwPcddOFW+dGKKNFxcQIffkc2Jrn8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065742; c=relaxed/simple;
	bh=YJELtHZu87vb/JGY7az47HbyhbFoiG8PFtbOtYbd6wg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aJVyQC4hwmvgKqA7Qfkb01lpho76yqHlsf1QAVT4YqqM6GNQT7cGJSEaIlhdwfro/hpzS90jhalSRsfvXPye9WgMerXU8TtZJQX6pFL30iiAOLs06WwG4pzZbCIfUgOruQvi5/5WwBekc6wE8+jyLyR9wQew0364P2TT9RJRNac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwcqhCA6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150351F00899;
	Fri, 29 May 2026 14:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780065741;
	bh=diBYaP1voGgRsPTQVxb07/iO3BPm0d5FuySaaTDXB9E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lwcqhCA67MJdiJDZUpGOT/BgMIxFmBad/L2Iw2lMY8QufQ15r3DMRSvbJzr+OV4II
	 aBj2z4WONNDk/dNZyhcCmMNP6soxS+6idXvyLXHhMEe0Gb1tpSy43UHyeuR7nNaC2T
	 KbCCuJUSNtt1QIrju05QcElUpiXGnRe7fhDbFmp3OA6abba+csSbOEzjMdYqotNqni
	 NMGfFgaLtsf31Nd3qPdt26KMccF5DxtjLRBjiry94RLR67eE8THd6mP1qh/lT0rR7u
	 dOGzPto20OCtCOsjJFfbPNbZr9orEQmg3KVgEb/ihAxxwTADcz+nTkp4+E3QbbZ9gd
	 EhcM710iAgiBw==
From: Mark Brown <broonie@kernel.org>
To: miquel.raynal@bootlin.com, xtydtc@gmail.com, vigneshr@ti.com, 
 Santhosh Kumar K <s-k6@ti.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260527173736.2243004-1-s-k6@ti.com>
References: <20260527173736.2243004-1-s-k6@ti.com>
Subject: Re: [PATCH] spi: spi-mem: avoid mutating op template in
 spi_mem_supports_op()
Message-Id: <177997260688.8579.8774356498581032462.b4-ty@b4>
Date: Thu, 28 May 2026 13:50:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=broonie@kernel.org;
 h=from:subject:message-id; bh=YJELtHZu87vb/JGY7az47HbyhbFoiG8PFtbOtYbd6wg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqGaXL3wQ+mzdR/7ta/c4v8BAd7fLX4IFTVeaE9
 gFBD41GNE2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCahmlywAKCRAk1otyXVSH
 0AngB/9DfbR8mS50GXSXZ081NQc75HOQAVtf1146HtLltF8FR1iHF9SgnHWhd9v+KBvwtEpHOVU
 89BHx1or+PjmNx8ClVYVoO4ksuq1HxDu2LlAczIGt2/iuGsPsJTBVWjqABdcY95f2J87/IKB8h6
 45TxldnWS5qg/rMC6gqFtLcKq/Ot3cb9Eo4Po+mvP23Cmx7o4UFjATWVD9HAYP92Tw+uIadSviK
 eEPVB39o7HNCXseGR7Urs2NGLnLBU4poXQIQnfsYGb0ZI9RNN/sakcD44N6sgSFminZm4sGYKGP
 rsj5WA0Dfq4Xv6vLnX3BGi71RZrEC4DM0P2T7cR0M0d8Qein
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spamd-Result: default: False [-0.66 / 15.00];
	DATE_IN_PAST(1.00)[26];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256644-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com,ti.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F00536040BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 23:07:36 +0530, Santhosh Kumar K wrote:
> spi: spi-mem: avoid mutating op template in spi_mem_supports_op()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: spi-mem: avoid mutating op template in spi_mem_supports_op()
      https://git.kernel.org/broonie/spi/c/79378db6a86c

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


