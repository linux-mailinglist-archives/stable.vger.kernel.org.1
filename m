Return-Path: <stable+bounces-231292-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKg3LF39ymk2CgYAu9opvQ
	(envelope-from <stable+bounces-231292-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 00:46:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA52D362168
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 00:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9283A3006036
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 22:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472C83E317E;
	Mon, 30 Mar 2026 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRUKVJPT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960DE398905;
	Mon, 30 Mar 2026 22:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910530; cv=none; b=Sif8FsggQS5tR/65Yf0KAZow5Hjl+vZD6vRo3b8ma0+V4Zs2/B/+aqXFUZZ1vcq5UiTNs33aIAR5RkM245D09fMnLatEXGVTC0WoLQO+A1w1oVIngpmglBJzaOb2CWVV6Ox5P/yZa5Zd46RDZ+BVD7Pe8sowG2uxVDNuvS/0vdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910530; c=relaxed/simple;
	bh=0j1oRhYFEwysKKA3JjX4/RxKWluLsdCA4LtKs+rrb/o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G/13uSv16fh7tuloUuXfNTsUrxoHHJlZE0lZ6m6Jd9CFp4clP+5sZL5UzXLBPKTkKZhXb/cdetPGK5LxtUKwAFgzH2H0OcHsgwRHjqRFiU5zb4NIWnd4GkY7aEC3Dt5q8en2DGj0mZnzjLzs0U6clfqMjMotgl6PpMKrzsqKixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRUKVJPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB96C4CEF7;
	Mon, 30 Mar 2026 22:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774910529;
	bh=0j1oRhYFEwysKKA3JjX4/RxKWluLsdCA4LtKs+rrb/o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aRUKVJPTm1f3/chp0Az9eO8zN3hbOQSHXyaikKhDIPaRtQs5RgfUv0pSmMqkJOLdH
	 ACaCYEKNEnp8QReCBtPFymOgH5aADg5rSoUyq0aGHIDzV9mLdmbGxKt1zlD5fJv3xO
	 fAkHVwKGVIGRLdBDY7tu+5x0wK4xRyM8rAQTzaL8p+JcJaZc7bU63LLFbTbud8j0KL
	 Easn2pc83nqqLHzaI6CasNxQ8a6B5upYFRMaxSSXVBl5uK2oj7PH8cRFTbq+GQkkqQ
	 ZjxZyAbgHjMr/VNaTRjURZ/f+X/AJiHWPYU8AS/j5NXhjC1qlrpCsAMJH7oMW0J2u/
	 6KSaoQtGtHZEA==
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
Message-Id: <177490289913.241608.13244384692142220199.b4-ty@b4>
Date: Mon, 30 Mar 2026 21:34:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-3ac6c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0j1oRhYFEwysKKA3JjX4/RxKWluLsdCA4LtKs+rrb/o=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpyvw+5dImr2b92mP+OnA+v+7P60dXsi4hEcf8j
 f9sNmYThH+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCacr8PgAKCRAk1otyXVSH
 0EvVB/9hCV1RHY7F3Gd90MeQuefJmN9gyKodKLsHb0QzHIKgFls9h/ow3ulf79Vt2l7YE0ib+HT
 2aq5RKocO2QuxQwOlyIeV3tIMA1s/dxK3UfIWSIdDAqYmGLk3JXp7zAGvP/4AJlxbXnfm6tQPNt
 Iqq6bLg1++TRkWcTICu/nCnGfMeKUmo6c/AOD8BJTzL6tFwPx35gASapvXFHcszbFNqE0nf6oaV
 YolYQA2SeDEhhOVqas5mo5pHSTDZP+YsLYZvcTwdDOIROIhLKU5IdaqatG0hS4vSAbJ/hgdpjJu
 aJmqUbBMFiSgYXJP97jfjyeapTV/88HeYVXP7vXdP5KvT9RL
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231292-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EA52D362168
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 14:52:31 +0100, Emanuele Ghidoli wrote:
> spi: cadence-qspi: Fix exec_mem_op error handling

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.0

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


