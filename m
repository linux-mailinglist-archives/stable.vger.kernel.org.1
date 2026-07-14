Return-Path: <stable+bounces-274910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A1YIH5RwV2oqOAEAu9opvQ
	(envelope-from <stable+bounces-274910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 13:35:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC09B75D987
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 13:35:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="DU7gCO/h";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274910-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274910-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 827A9302E324
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 11:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1367D448D02;
	Wed, 15 Jul 2026 11:35:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0884483BE;
	Wed, 15 Jul 2026 11:35:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115335; cv=none; b=MxWDRW90l3z+QzJwY+8O2r1hI/NLwasJM4YzQPAor6IoOr3V8KmIKNZbG0fYwK+4QSw5UC2Dk7f4N7dVqV9Dn7qdLLc7sJXQ5XTHG/L1rfjxZO/OMElsXKtTrGOVmjZfa1m5kroOm64KC1zTaz7faKsYXNXv7Cij6E/n2o/V008=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115335; c=relaxed/simple;
	bh=sNEXueWVdWEvfYKYwZZOPFDO+l6YsE+OW3Ra6F4e6zw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TNjTWbYLAS4YVCJX/YjnrvmMYK+SznEY+th5Z4WZ3Ori7jGDw/1AkhkPCtumC8HGiOpgTnbh9qYP1uf/sZXYhyomGWr8oD/T/y5WYYgScNed1jRUsaPc2YvWF1TOKJ27HjdCYHhkGJYX8Osy9kYaZsfsoFQFOVb+6Pkk2nvvOfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DU7gCO/h; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711331F000E9;
	Wed, 15 Jul 2026 11:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784115333;
	bh=jesZuPeWaeL9z/PHoWJHtu6Qq+AFb40j5P16AfqJxyA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DU7gCO/hsLqTwwk7TrDDgi6SxLThPZZUBTDgrO/vIreh//foqleLzkS3qXzkElWtB
	 CQKaJF8wR03T1QTKHvCbSFm/OO8G6JR8351ZvqQ+kJLjx6xlt3W4hgFzvdQti/56z8
	 AdAl7uEqWLmVf0QiQAuxA4DZzP2OppKvovPu4dVvbzk60+2W591kBra8i7MQarcQhV
	 4WlAiIpr83zDimSizShclQeutXvBhvTeOXE0a+il4DdprKWBqwrQT7lW/+ViVJty6H
	 W36kWw2XuxnRh12PUqcjsBdUtsNN6cg06zSSPMCEBMj3vuMZE4NIWePo6cy6a9P3o7
	 FucInxpg9bLog==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Frank.Li@nxp.com, Chancel Liu <chancel.liu@oss.nxp.com>
Cc: kernel@pengutronix.de, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260710031333.3491445-1-chancel.liu@oss.nxp.com>
References: <20260710031333.3491445-1-chancel.liu@oss.nxp.com>
Subject: Re: [PATCH] ASoC: fsl: imx-card: Skip sysclk reset for active DAIs
 in shutdown
Message-Id: <178406418862.7661.7096078031628027721.b4-ty@b4>
Date: Tue, 14 Jul 2026 22:23:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sNEXueWVdWEvfYKYwZZOPFDO+l6YsE+OW3Ra6F4e6zw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqV3CBctjQmNjrs8DaxHnHGNriWx0pEgtvGK67Z
 99Q7E7K7dSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaldwgQAKCRAk1otyXVSH
 0Lv2B/9iwsllDW7+fFWuMbcXDu+pjbFkmouDD7PciHiUfac0zJWqUb8SwEPVm7oGXMOibcDq2Kq
 YYouaK3iixM869F51GmvpQGgKWcu5tKldP5a1KGcQLcD5SfJvvsd4oYraV7jkS2zWaKToBwYBjM
 mhXSdzMOSNTZyFo1oH7Dt2gv7gI9vW9Q4UHyxpFoY6/Lz0VPCcAzVfNRPImPqiCWBNUZ5irG833
 J69er+PQAizp+0z8ltrK5Coa9q3+igR48mHEgGulXvStCD73JTM2MYHoao8/eJFV9ueYHpT27sO
 IO1bOopuY7+1+mIo9ncpEwxUoLEhRN4sVHiQpy6KO7RHgqTe
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:shengjiu.wang@gmail.com,m:Xiubo.Lee@gmail.com,m:festevam@gmail.com,m:nicoleotsuka@gmail.com,m:lgirdwood@gmail.com,m:perex@perex.cz,m:tiwai@suse.com,m:Frank.Li@nxp.com,m:chancel.liu@oss.nxp.com,m:kernel@pengutronix.de,m:linuxppc-dev@lists.ozlabs.org,m:linux-sound@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:shengjiuwang@gmail.com,m:XiuboLee@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,perex.cz,suse.com,nxp.com,oss.nxp.com];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-274910-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC09B75D987

On Fri, 10 Jul 2026 12:13:33 +0900, Chancel Liu wrote:
> ASoC: fsl: imx-card: Skip sysclk reset for active DAIs in shutdown

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: fsl: imx-card: Skip sysclk reset for active DAIs in shutdown
      https://git.kernel.org/broonie/sound/c/9f86aea99256

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


