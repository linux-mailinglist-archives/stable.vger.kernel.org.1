Return-Path: <stable+bounces-241287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GXuMBc572mD+gAAu9opvQ
	(envelope-from <stable+bounces-241287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 12:23:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF6B470E93
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 12:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF0473030312
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2521305E3B;
	Mon, 27 Apr 2026 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9Xg2PY9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF8630AD05;
	Mon, 27 Apr 2026 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777285253; cv=none; b=IsH3rlAe9GqnlDu8/0C6lQsEYfgE+FDYMyZtvYoBv/WI48swt3wyBmvNaHZs8Dv8/4y8CqGH7XZJ7rhTySUdwVpBNF33BRWExDuf1YIyPsbnsAIxHm5E6V3M80W/18XtFem8dBRR30B6LLv4+7NjlUt5TrK+O4/lKbE5tnEiHCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777285253; c=relaxed/simple;
	bh=qIq9a7y2HB+AIJXm05tCUyKUl06Y44EASdDXzgfv7ik=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ceXoKM8yqNwl2+JDX6+0CQLbe3xo9iMGuqc4GWsJJsXQma9euFBMGfP3xp/P7ovgzl2rG9I4sc/tU/OwWDtHP16N5DdYdD0E7ksHS7Zi2HUwzFpK6H4qFEpbEkGf6yTDAXk0pOd1bNEnm+n+m91L87mrKntkgUUw3o7ekoF8Trw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9Xg2PY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCD6C19425;
	Mon, 27 Apr 2026 10:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777285253;
	bh=qIq9a7y2HB+AIJXm05tCUyKUl06Y44EASdDXzgfv7ik=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O9Xg2PY994COHuO6QSmoEENizIGm9RgVRcpkPr1A4+5zGzhi/JVkCTBEUfcpZ4AOL
	 YznCcrzJNiN12wHK1F4+nC4GzMeQF+Jl7t1I1QtTN4W9nGR2vOP5Wiv6B2BqQ1L7Jq
	 Ag7HIXMNF632JOlQt9IP6vol2J6C46xKRa/BToTo3gX9Fergw7Y4c7qQkSqKlF3PLn
	 sJ9vRp4B90c9uJnspSo+Z/tknVzqBSVsUWOsF22fsTFsA8ecmpFTy51FBKxbJvYtqZ
	 f5lqnTnjgrgiMimKSbyQixzlNQD1kTOnaHY5dxCqbQhRh7oAruGeqFntTaT8GB/gux
	 l861m4ydUrOFg==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Li Jian <lazycat-xiao@foxmail.com>
Cc: lgirdwood@gmail.com, loongarch@vger.kernel.org, zhoubinbin@loongson.cn, 
 jeffbai@aosc.io, stable@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Zhang Yi <zhangyi@everest-semi.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Alexandru Ardelean <aardelean@deviqon.com>, Stephen Boyd <sboyd@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 linux-sound@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>
In-Reply-To: <tencent_7C78374FB9F4B3A37101E5C719715D8BC40A@qq.com>
References: <tencent_7C78374FB9F4B3A37101E5C719715D8BC40A@qq.com>
Subject: Re: [PATCH] ASoC: ES8389: convert to devm_clk_get_optional() to
 get clock
Message-Id: <177724622731.266775.3161558352144649934.b4-ty@b4>
Date: Mon, 27 Apr 2026 08:30:27 +0900
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
 h=from:subject:message-id; bh=qIq9a7y2HB+AIJXm05tCUyKUl06Y44EASdDXzgfv7ik=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp7ziAqg+YwEGgqucVEamTegt1j8wZ+Klu0PRbQ
 Xx3L0KvcoOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCae84gAAKCRAk1otyXVSH
 0G3wB/0aC6iydm3hf/x/950UQznmdZXfLvRHVbKcsG6BZXshcAdfbuZ3+F6EyZWjq5LSojqVx8u
 CUWdBLYJJlACTxKi3lfJVaCA3s7bZgkdLfFi1yrgwuozuKatYBs0QOxgi1RqvC1tX13XMVty9Zl
 iTNl9T09ub8Rimi8sWxU+jWaVx2SfMkDc+aGJDtg5B14Q249qZy5ncZmEuurcfBr4k9KsBigYEd
 kNUAD9lNaFZ06fsyC6C1/u3ZcPJz4Tt1NJwgk7lBOp4s7YVIAwz2rDuvz9j+dZkhY4qdUFhSd+n
 aE0bM83xEZUF6eI/Vy9CrYEF3oLXI55NCx+2Tt6FLhxpyvQS
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Rspamd-Queue-Id: 7CF6B470E93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,foxmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241287-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,loongson.cn,aosc.io,perex.cz,suse.com,everest-semi.com,opensource.cirrus.com,renesas.com,deviqon.com,kernel.org,pengutronix.de];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Fri, 17 Apr 2026 18:53:14 +0800, Li Jian wrote:
> ASoC: ES8389: convert to devm_clk_get_optional() to get clock

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/1] ASoC: ES8389: convert to devm_clk_get_optional() to get clock
      https://git.kernel.org/broonie/sound/c/8ed331113107

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


