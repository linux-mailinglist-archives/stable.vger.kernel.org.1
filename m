Return-Path: <stable+bounces-224668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFhiMlBIsWlCtAIAu9opvQ
	(envelope-from <stable+bounces-224668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 11:47:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7FF262816
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 11:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1E8D300F5B6
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 10:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6453D410A;
	Wed, 11 Mar 2026 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHRSyIrK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09273C9437;
	Wed, 11 Mar 2026 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226045; cv=none; b=HX9nUlv6yINuGam3UtrlWMAoo7+Btyb3J86OH+vriURmzyfBLbDkzYEQ3FB2MI67drR5Vs5y9delPd9Imir3l47v5RHbIFgHB6EIVVcrD43D3YfqG/6gTKFrNMG0Q98ccXVJFnHRZGBeeEyGh8vQl7M+oHQeDHNpt4ZRPkmN/I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226045; c=relaxed/simple;
	bh=n9wPWZGAQYnQDnwF08QYmJs5BjYlEzISLcv9Wk5+HzM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Saj4VqpDBUQjLT86jleYfvuNM20d14bLyX/DPA6Io7d4nQbCh8iL2t/KBrSMr/s38C7B7TTd61k2px31m+QLmnpL/p9TYnk2eKqyTkeGmLXED23lt2BZx5NDOV1zvYYtzzzAEB5GU8wbho2ttoC0Lod29itUe+IclbvoChBoaHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHRSyIrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0E9C4CEF7;
	Wed, 11 Mar 2026 10:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773226045;
	bh=n9wPWZGAQYnQDnwF08QYmJs5BjYlEzISLcv9Wk5+HzM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tHRSyIrK9A/Hiblb0q8RZIpjXoRq6H+Fl23t/p+3ALR/CI8m/2VHVV2HOLgirdxxw
	 YXo3zT9ci50szqLXSpMqdWqGaf869Y6Kw5WS9Bsyy1pjYVkQrCZNStWYIEza0q+H5c
	 cbojjGVETBT3XIZTDog5roOX9C6/N1NY14U+lGD2axSRBmgj9kZvSXj9vsXUiNUkA7
	 HsZZLJeLowy/ffz2H9Bz4QFt/WhMKKdO82avh4uY/nKxi9lfUopOcdh9gUeYXx6qgP
	 G5SDPxm8+XzleO2f9GwXHSHoPjtNTkVsgKka0zrDmYSZqnZVkH6CDID0H29K1qnTDx
	 ABFQ8vYgqnXYw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, ckeepax@opensource.cirrus.com, 
 stable@vger.kernel.org
In-Reply-To: <20260310065350.18921-1-peter.ujfalusi@linux.intel.com>
References: <20260310065350.18921-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: codecs: rt1011: Use component to get the dapm
 context in spk_mode_put
Message-Id: <177322604419.10345.5914120660838901314.b4-ty@kernel.org>
Date: Wed, 11 Mar 2026 10:47:24 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-68380
X-Rspamd-Queue-Id: 7D7FF262816
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,renesas.com,linux.intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224668-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 10 Mar 2026 08:53:50 +0200, Peter Ujfalusi wrote:
> The correct helper to use in rt1011_recv_spk_mode_put() to retrieve the
> DAPM context is snd_soc_component_to_dapm(), from kcontrol we will
> receive NULL pointer.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: rt1011: Use component to get the dapm context in spk_mode_put
      commit: 30e4b2290cc2a8d1b9ddb9dcb9c981df1f2a7399

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


