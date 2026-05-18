Return-Path: <stable+bounces-249502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOWtGgExDGpuZAUAu9opvQ
	(envelope-from <stable+bounces-249502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:44:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9486357B854
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60788309BD1F
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56C63F8704;
	Tue, 19 May 2026 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bylgjxsY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC83F5BFA;
	Tue, 19 May 2026 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182726; cv=none; b=T7a0NqY69ydtlRvKal1setpaBeRjB1tIA/DU1XcU1PN4DA1sTV1zJwVz8dcji0/ZBsbZYEUZtYBs8dQwx8M7exZSfZGKeGafBIZBGJCKUyc6JfclX+ORSIAMQEMZ4S67JPbIGa2GyBV8DPHMjGJM64jehM3Jy7gT9QOaTJGxiJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182726; c=relaxed/simple;
	bh=ig0DgqQs4rtVlrNqLiSo/BOrzHGvaqkO04T/wjTiiYE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Zyk0iPoB3hfqVmJPSyXJl3YfJHxs9NWy3T4g+Vrw36so+A0pIXjOjQ/0UPiOjTtQ9XMllQQekQvz+Y1+ocZrzHuTH5g8zRjNOjcntafTVkzWks+z/n4EPGOIZ9FHm1VTTDRO21xHu5TBCgZBfiLoSOQOumEhhRu0AgnGGMDMuOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bylgjxsY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C34C2BCC9;
	Tue, 19 May 2026 09:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779182726;
	bh=ig0DgqQs4rtVlrNqLiSo/BOrzHGvaqkO04T/wjTiiYE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bylgjxsYnrwQIdwSQeQQW1SLBmr2xRFAo2WIwtVIqwHQUUYx1ST8IIrvehJtQC1b1
	 M3ZG7n4gjXEddbjFQd2LhxM1aXMNKSgLmpSS4lW9OIvN9FOvlIrrmVNpBAJqTYD6ed
	 xEpmt02BLuQ/GI+rHA+kPcEbK9Wh51M+cNo11DIZY6VAbFDGn+19MOC4ZsI1Kviuoo
	 uFtupjXv6KRI71JEvkvX8ETBV1pW9Ob2GbDkQI0QYyAxmIFO+G+b738fGSO8vc6m3s
	 ibdulc0JhyvdGqk1jbkrCalxu5kAKT/Bw6x7CuxAx0vJ2DEB2PaRXUf/VTlP4w3Cya
	 jJsTmlc4GXjpA==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260512074334.914735-1-johan@kernel.org>
References: <20260512074334.914735-1-johan@kernel.org>
Subject: Re: [PATCH] spi: qup: fix error pointer deref after DMA setup
 failure
Message-Id: <177912221068.352391.12309236153164739170.b4-ty@b4>
Date: Mon, 18 May 2026 17:36:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ig0DgqQs4rtVlrNqLiSo/BOrzHGvaqkO04T/wjTiiYE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqDCyESyvQBdUriIQhZoi/eO3A0TglHeqD/dWvp
 51CAT+NDK+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCagwshAAKCRAk1otyXVSH
 0AUMB/9qIPE4c2cYDqLaJ0NrHMFKAKFaP3EDMJiB1oJEHrYXOB5xLTKMchDCgb+Nd/OY+ntCDft
 7L6UQzwNlvezNBuzkZEoAuO9N5CM4AOncuCW6TRxlVijxjjeWeF6vsBOiUmG3QCnX5h1z6vKQNx
 TctNJrWzHfn4x3gWjl0U73JGHa2GifpNc/xP8dTbbtCUM2b/FbrVzikq6/bcIvBVktCgNiCuGY6
 vE24Q30C4eL08lf08au9TbiRUwlmH3IszX6ezqkIGFBOJCGMMWAd2j0b+r2YS3Rk5bcSTDJpT1X
 xjnjeDV36A5uBpbJsv/Fn5zErlVFKlULN0z60ced7wM+6AXx
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249502-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9486357B854
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 12 May 2026 09:43:34 +0200, Johan Hovold wrote:
> spi: qup: fix error pointer deref after DMA setup failure

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: qup: fix error pointer deref after DMA setup failure
      https://git.kernel.org/broonie/spi/c/a7e8f3efd50a

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


