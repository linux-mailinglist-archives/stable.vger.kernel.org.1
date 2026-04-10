Return-Path: <stable+bounces-235646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIBhDxkn2WkPmwgAu9opvQ
	(envelope-from <stable+bounces-235646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:36:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDAF3DA742
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A513330027D3
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 16:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F5B3DC4D0;
	Fri, 10 Apr 2026 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qizN/l+L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66F223EA92;
	Fri, 10 Apr 2026 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838571; cv=none; b=QzzSdbO5FrcpnX62OS8PluWeOBzTSKgypdxDhhFNCIIGZDvvn+PCNjKGCoWJy6hO1dAOSe9cCo5czczxnM7mNsz3BlsrK3I6r8blFsXv5mStMmL05P7A3Etgv1lWnNw1XrWG7KICyiGHXl1JV4RFYth3TEC593W6gYQQQKvsdNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838571; c=relaxed/simple;
	bh=T0RLv7FrgArBb+6V4fHTcq1bWYMiINMiGnQEs3W6zy0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q1svFxxMwapMj7lD0dC+S/XzLiVpG5zPcc5bEevjY+mVuKlp816w20Vl/E1CoSWiA55rHUzZkYoWahBNbwgRVVoKxZg+tfdYEHztnQVs97+SLstfV1b2+NOjGUFhToHADmB0Co13R5Jm8KsZQFBDnTTQwZ3rLbb1YSHrV2G42R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qizN/l+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C76C19421;
	Fri, 10 Apr 2026 16:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775838570;
	bh=T0RLv7FrgArBb+6V4fHTcq1bWYMiINMiGnQEs3W6zy0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qizN/l+L5xyF7mPFjzh+ICvYzVkpYorxbtRMC4aDe3RvZED8Cbex5fI7eOJsRETE9
	 EJ/QDQ9Twbw2qkniQsGMywB18xbMxtlaXtpaCJVKUUVWbvqDVRRtYiQuyn3r2iD54p
	 aDJqbRC4Ay7HirtkPBKxvI6yFeX/qEJlm1de+yq1r0aWFvdGKfrxRGbzmF32Hra8xz
	 pJdVC0UwgiGBwwbnuMtr41OzWNdUp84TKooK6VieodAKdS2oFIlPd147bcW0YdxAFy
	 e2AkwNUjk4LKitWZvzW8oyeh/5W0TwqtTJaOk29D3TAJmQicbciDItoSjZgpLOi7Fu
	 KhcVHlF5kYrYA==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Adithya K V <adithya.kv@samsung.com>
In-Reply-To: <20260410094925.518343-1-johan@kernel.org>
References: <20260410094925.518343-1-johan@kernel.org>
Subject: Re: [PATCH] spi: s3c64xx: fix NULL-deref on driver unbind
Message-Id: <177582514788.1175120.7593576580255112081.b4-ty@b4>
Date: Fri, 10 Apr 2026 13:45:47 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104; i=broonie@kernel.org;
 h=from:subject:message-id; bh=T0RLv7FrgArBb+6V4fHTcq1bWYMiINMiGnQEs3W6zy0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp2SVofo7RUmXxzPpbxO1v/3dDxHoC6BCd+3I+v
 MDWSUQ3c9aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCadklaAAKCRAk1otyXVSH
 0APJB/4sKoo5Pm/H+Hu4kREm3oK/o0cjF8Wv3hB2rZ+A5751KVRw69g1Gj3p8GB/YNwW4mM+6Wz
 sO3TaFlkR5NCi4HfK5hQGLKHGo6dvYR20xrGPurFPInOn+Zal+B6HqYfrfah8qvfu9ZZ2i09tHh
 imaztKZDrfd8f51CQtPJWRZJSYCP9G14omoBcLHciA/AiVb7NaQ+4NjnBaErbRXE1XgHJHSbPq0
 /zR4LuKORmY0SLJoAvZMDrsdVCstQT7plTAfqCuqcGArw4l2kpGW/1iXrwYAtGHOnz3dt0vn0AB
 VnucSuFVb12ealEHJ0hroJqcD1poiqiSA2CsFu84dgGUL5/+
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
	TAGGED_FROM(0.00)[bounces-235646-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AFDAF3DA742
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 11:49:25 +0200, Johan Hovold wrote:
> spi: s3c64xx: fix NULL-deref on driver unbind

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: s3c64xx: fix NULL-deref on driver unbind
      https://git.kernel.org/broonie/spi/c/45daacbead8a

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


