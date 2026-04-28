Return-Path: <stable+bounces-241814-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wA57Bl+H8WmchgEAu9opvQ
	(envelope-from <stable+bounces-241814-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 06:21:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A02E148F1C7
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 06:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B4C53098B12
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 04:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97EE3890FF;
	Wed, 29 Apr 2026 04:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X//TiDp6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B257388E60;
	Wed, 29 Apr 2026 04:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777436403; cv=none; b=k0GR8caPzeQksNZ9cZH1SrLidN/d3bq+LgrdlsRD+qxl+E79fAskgv1K1fOWrG19kXEEZYFjwkUEHSTLXc+QjsoWOv05UI7d8tWVGmMZgxmJ0Wx6Sp6ccaCDcQ9AbCVQ3pZ6sJ7ZfMdhkXR0Ewq1M0nxNYqKYSkP8m3k9QTcE3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777436403; c=relaxed/simple;
	bh=ghgjIDBtVeNlErdghN+AGA8IQkj4MB957ucFn2678gE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cuDYsmKqCURQFXBUpnsLp8AO7NNXPDIy3SGyadpLzG33Sqer/1KYwOLJC3eoCR/ma48LvnlRU/SI+2PDhdEqa9kZ4gbN4Gol0wS3tXteFllLwdkyTnXnFCQMmYWmQ+Q2TPGexkHIA96j8bgx0VkTyOnHghAGl+xdZDzA5iEQUJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X//TiDp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC0AC19425;
	Wed, 29 Apr 2026 04:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777436403;
	bh=ghgjIDBtVeNlErdghN+AGA8IQkj4MB957ucFn2678gE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=X//TiDp6TvYz4CyaKoUpdfwhu18vpXFhKyULmz9k0yvW1j4Fx031AmqxvU7t8NhHz
	 DlcvFMOmD3N3szsnS7pGZG7fQM0UdzEAhWnNlYcdpNUbIIWlu5TtVskadBEwRPdya1
	 i7kzsb3zVVD/6A7rWDStcA2Eu1S80IN+PWcggGq1ujWds7g86TE3ZEMzxVy8RfyC5X
	 iP4wLZvvlHQx/uNKboNjT1p8xskSF61zkNKzvVwoOyDQNKc3ZHpiGQ6CQ/ZMSCouBN
	 ZvmyxcN1NNJLYBL6xd+xptM+uGaOnC8XMyyTlK/QL79Mgtf+Ty6Odqvi6CREkGLjib
	 pLOkiXKFReCoA==
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>, 
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260427-bytcr-wm5102-mclk-leak-v1-1-02b96d08e99c@gmail.com>
References: <20260427-bytcr-wm5102-mclk-leak-v1-1-02b96d08e99c@gmail.com>
Subject: Re: [PATCH] ASoC: Intel: bytcr_wm5102: Fix MCLK leak on
 platform_clock_control error
Message-Id: <177736621216.363516.6152802951852112106.b4-ty@b4>
Date: Tue, 28 Apr 2026 17:50:12 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ghgjIDBtVeNlErdghN+AGA8IQkj4MB957ucFn2678gE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp8YbuLMQs0SWOf1y+OKCg+nZnieSHRQKGeXeLQ
 0AAIr1aeKGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCafGG7gAKCRAk1otyXVSH
 0NXFB/9EQCi8CuFDsBYdAOMiAVzHgNwP/6qNItxrOU2mDYmCs5d8b7XT4OXsGEEP6A89+PX7RB8
 MYpIg0Iv5BnbDxZ9APl/FporFpIXQ22f2S/BLvfJDreE9GvaRxPUO77TpovhT5yFAkuY2LX9PP1
 4F2yPDyOITu3rMsXOwmsgWOrtSVLptEYDSpV5KhEmSrNP5nzgz1BarDiaNK+zQCSiHwf8cdI9A+
 fyahupYgfjDvxnbITdkA1IH8Y23mwwC0HDZ35F3QpqMdqduxiI/SxWDNZ9Yn5+Z51zLQzASRjkY
 cTP8tnjIxn38prRlTfkaee2Kr1zfE1Sgi2xpfOxdmtVAddr5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Rspamd-Queue-Id: A02E148F1C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,linux.intel.com,linux.dev,perex.cz,suse.com,kernel.org,gmail.com,opensource.cirrus.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241814-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, 27 Apr 2026 23:38:41 -0300, Cássio Gabriel wrote:
> ASoC: Intel: bytcr_wm5102: Fix MCLK leak on platform_clock_control error

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/1] ASoC: Intel: bytcr_wm5102: Fix MCLK leak on platform_clock_control error
      https://git.kernel.org/broonie/sound/c/13d30682e8de

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


