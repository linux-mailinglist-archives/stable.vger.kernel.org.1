Return-Path: <stable+bounces-240387-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJMKDaMo6WljVAIAu9opvQ
	(envelope-from <stable+bounces-240387-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 21:59:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B918844A5A7
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 21:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A88F53074F7F
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E133F2110;
	Wed, 22 Apr 2026 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8DJE3+f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477443F166F;
	Wed, 22 Apr 2026 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776887883; cv=none; b=jvmKYwyoLC2CPhoVesLeuHj1gKIS2qFpPZ/EmRvvml/5tUW4FYzECU+dxUtQ10rL4MCUBdLdEReUPdOlx9cP6ISmQcmkUpPsz2uhPLj43bytPVU87vOl28vyZn5k6EyCeyG9lcQOkzWay8fjs7gyyf4Int+aEtd+WvhIxjIUw2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776887883; c=relaxed/simple;
	bh=qE9Tlx8MC+zwl5VejlE9OLQJ7rKqT9HwZRcKuaZm1dM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZMoVfCxLNYJzAgyyAqf1147obK4x02oyG8GwRYXyMI+m7kdChbH0vKJYGxfKRalfSCCv3mp/M00+iGwv2IqupUbkZC5GRxj+vLYNHaZEYtA2V9UnjoESoXL35F8mE+8NudCGMOIAx3u3tjA94fdLA+fmfq5iLnwC81+lJWFkeck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8DJE3+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB5EC19425;
	Wed, 22 Apr 2026 19:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776887882;
	bh=qE9Tlx8MC+zwl5VejlE9OLQJ7rKqT9HwZRcKuaZm1dM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=m8DJE3+fBuWrq6Emm2Dlpmf6j/5nmfXaTxmH3gP7JoYVj1mV5/Z33bQIdSiuKEgiH
	 +Ydq0B7kRGIGhAfgbikBnh9oCauZD0YFV3j0nP2X9yfSyFkFSOSsIbKqp4gDjoKpod
	 JSSjaYK29SQ+kuvT0yJmxT/4rEyYbYvgCXw1YGbkXO0jO1UlJHNrl88L9T/w7+Iese
	 1nC3N30VesUGuKDZTfjSbwLfKfamQdcYHnMtwRFPYxRkFRrZT6iLi5r+czCbCjQYls
	 U8ALxh/jREhf0L9zeZNri73p8/+Z83VYigukq+eOkws/f9X40afCvkA/htbD/MJoBC
	 EV0rjocwMzfrw==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260421125632.1537235-1-johan@kernel.org>
References: <20260421125632.1537235-1-johan@kernel.org>
Subject: Re: [PATCH] spi: imx: fix runtime pm leak on probe deferral
Message-Id: <177686186865.36226.7596459545113208031.b4-ty@b4>
Date: Wed, 22 Apr 2026 13:44:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qE9Tlx8MC+zwl5VejlE9OLQJ7rKqT9HwZRcKuaZm1dM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp6ShILd7oHSFT3up9wbwkQCWSymhOcdl0Ol8UH
 BDyHyIcXlOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaekoSAAKCRAk1otyXVSH
 0IFHB/9NeKC4DcoTAo4BAq0Gfpf7lKd16HBOHmZGkgM6+7eMKOvjRfvW+tnaOMhkURibHKPUBMY
 k0HynZwvDK89zty36Ryp+QuzZZ08SchSoH+sQzW3i7CUW2hmmAfACyPDKvkdkOW+7jKT7mDh1mF
 +yugP90/USvTmderY9qMrahUbQrZmNWRl9mRojj3yMmnKnG190AkvgwcM7lBEDmVD3z7UbauAib
 SG2GibMyAX1PcnL0yJ4BaS0lBeCRcoK+wXZIq0Z9uVZs3XFL9tIXBTbh/nuOBW/VE1Fz7MzyWqT
 GWUAGwSisgbZe2UXr8wL40hfzXtWkkcUZSlSmP5DcE77Yi8w
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240387-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B918844A5A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 14:56:32 +0200, Johan Hovold wrote:
> spi: imx: fix runtime pm leak on probe deferral

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: imx: fix runtime pm leak on probe deferral
      https://git.kernel.org/broonie/spi/c/a1d50a37d3b1

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


