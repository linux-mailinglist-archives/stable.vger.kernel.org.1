Return-Path: <stable+bounces-240388-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mImIN7wo6WljVAIAu9opvQ
	(envelope-from <stable+bounces-240388-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 21:59:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5281A44A5CB
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 21:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D092630CD5EB
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2BC3F23AE;
	Wed, 22 Apr 2026 19:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mugctKCS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D82D3F20FE;
	Wed, 22 Apr 2026 19:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776887887; cv=none; b=azpR75q2zo3UXkuv0BD7jELFkaJKL6rAhqJ7vZzPoRp9rxf/LrXQEhvjGEHVM+o1weo/4lal6npC914fKZ9p6z98QRuWMyt/vmwcW82+JKNJ69rU8UFXs1zSR9AUvNUdFFI5oos+UaShNsKLQXS5Y7jP7CiYpwIdN4NKbpYWkrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776887887; c=relaxed/simple;
	bh=g9n2RgQXS8Q2QvweeXyi7Enkagygf++uiZgF6NwM1hY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JTF4db4KVxeyWKCs4YY1Mg1ImL9C/RlSsuS6EaSC7s8htRn7hJFM2XDRsNQRR3eLz1JZo5aqC2/8d3sVjo3dDOgoAyyekiqkgzFZhxxsm33D1urreuyUyN7FAy4bNtrMRyReYRYGH4YudIQrWavA1n5u8UAk9vwqu5WG2DCmWrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mugctKCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A35C2BCB3;
	Wed, 22 Apr 2026 19:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776887886;
	bh=g9n2RgQXS8Q2QvweeXyi7Enkagygf++uiZgF6NwM1hY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mugctKCSW5iprpD1vaeJgMDmTqyRRTpxKuHDzjjhgpp3KUkkVgFZtizpco1IKH8rW
	 kSfY4Y0srMk2YDNZuae6WbQnsFdvui803MKSCanobuaJwhXKTyjua43BvLr9CU2RQY
	 OAuK1Eif7bSv73O8wNHl+QT9hneu3ZeZ2IO6QzoiRgHuJTZeJdrToezIZFj21SnE/p
	 m7JSPXgCUSVrEF+jneC8ed9f4ObWr10x0EEYO1fYfLfFh/HFh6d7s3qepVxyfle6f6
	 ZXp3wdSmxsqI/GcRJvRDfinCVkbFkTOpb/KdNzsOaPSrt6DD++Rc31SogQxpNIkArF
	 3jXMjOxVb0yjw==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20260421125800.1537361-1-johan@kernel.org>
References: <20260421125800.1537361-1-johan@kernel.org>
Subject: Re: [PATCH] spi: mpc52xx: fix use-after-free on registration
 failure
Message-Id: <177686180674.36226.15735198170058850286.b4-ty@b4>
Date: Wed, 22 Apr 2026 13:43:26 +0100
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
 h=from:subject:message-id; bh=g9n2RgQXS8Q2QvweeXyi7Enkagygf++uiZgF6NwM1hY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp6ShMt81gU62ZZAuks/z6jd5BLvkZqre03IA/r
 vlnkdzGHhCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaekoTAAKCRAk1otyXVSH
 0E5eB/0dAtMMxxs/3bDTMhXJlfCimKYYRoCo41TWTk5JrBrDC5atfFHN4QfcYO4WQzHdGQcNaRp
 xusimteI+7/uefNx0PvdPjOfAbSpj7qE8wceVrns2HDbZZaNN5/65NwKnYqWY7PnM2DQpauwHyR
 dXSbg9MDMp1UpXh1ebzl1HBdxO7GQI+o4ip1Xo1cT2OnngFxDBjPtquqDIn0SlZD96f2YsJsSdk
 danghdGhhYaqe0WW38ZbOeT2a5D/YgZgwPgDTayVDFT6Yd69E7wG/+Ia1vY1luytJnl01bGgX41
 oHgt8hWlQW54ALfIsY+sJwYkqxJ8QmSdrFwfrThuEL4npocG
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240388-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5281A44A5CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 14:58:00 +0200, Johan Hovold wrote:
> spi: mpc52xx: fix use-after-free on registration failure

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: mpc52xx: fix use-after-free on registration failure
      https://git.kernel.org/broonie/spi/c/f62c060272b9

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


