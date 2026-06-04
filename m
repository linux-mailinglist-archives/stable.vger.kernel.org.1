Return-Path: <stable+bounces-260492-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +NOyC4N8IWogHQEAu9opvQ
	(envelope-from <stable+bounces-260492-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 15:24:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9EC6404A0
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 15:24:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=n0WGt6dt;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260492-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-260492-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DF633077039
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 13:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B0645BD6F;
	Thu,  4 Jun 2026 13:17:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6AE2749DC;
	Thu,  4 Jun 2026 13:17:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579073; cv=none; b=rpGOSu6dKpGT3lHegbmT3KMHqcnNLRfzeBv6R4KWk3GvyZ+vTGLFdTlOYdajSSncZREZzMRa2dhd+36G4jEY0C8GU7qZFWmQwarGMAr/Hh3wPI8x90bIL7NzXnv2GaezOip+/Rfs7G1oCFDVhWTNt+G7mUwcZD0jXrSwN/3HBxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579073; c=relaxed/simple;
	bh=OxNdjiclvt3XWr9lGJv8pywSMILXl1KuxQxrcQ/M3s4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rBG6ATyt9Cm6VnZNWISnwFiellPzfRrDbUHnlqDBfQ/EaJJG/adt4GbibJJN9laC5FEzNT83aL9xR+g61SeR+UM1Ei4Y/OVY7Wut8ZLHzrTkPo3WSPGcEwsF9f4aZ2HTKZWWjmlVM2NzdZfVXcNyio4TL45n0TjVMewGXhyt+Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0WGt6dt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18A41F00893;
	Thu,  4 Jun 2026 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780579071;
	bh=/5uXpRyUrLn5meNm86Lfod8o8MpRd+piC/cq/gzPePY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=n0WGt6dt1Aqe35I11bb8enolwaDGwbGLDhIumRd3Lo0Z1MO2t/DbqRW5rOMh9nEbo
	 Hc6eUodQYJQ9ooe5XOpwKJJufujPBahJkw2grthcQ7KtHADU2pyPuXzyi7gNKmCk+O
	 CfFTDq+3n4rcfkDma77nRJpm/2fKj/9fmZcZegwaRw1vuJU3OGgZo6eVcvSVmx/x+8
	 7aytA9dEjUNr8EG9fn63hz+0tlK4vE0bRGREnB839IKOHGwh2WG/WKQ5RTn2GbqRoI
	 fX7jLNEE059aLHHEIHs0xWBnK/Zr4pa75eIjBTfy/oiGaUhQ9pH0B3ap7bpHfgK78i
	 vqAJHEDTgqnlA==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 chancel.liu@oss.nxp.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260601083327.1535185-1-chancel.liu@oss.nxp.com>
References: <20260601083327.1535185-1-chancel.liu@oss.nxp.com>
Subject: Re: [PATCH v3] ASoC: fsl_sai: Fix 32 slots TDM broken by integer
 shift UB in xMR write
Message-Id: <178056822812.53724.11372449372244956668.b4-ty@b4>
Date: Thu, 04 Jun 2026 11:17:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OxNdjiclvt3XWr9lGJv8pywSMILXl1KuxQxrcQ/M3s4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqIXr8KlHbpsbVkedXxSZs+2KCwbVlZw6puS5EM
 BwWP/BGFayJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaiF6/AAKCRAk1otyXVSH
 0L9zB/4/n0blZE1Z6+elV9oWF+udM4vqfGkMnWJ6r7KgA0pJQPK/xU0RuvGhc1HYtvCCLOWA5MB
 AyyPQV9u21xbPrmhusis2cGWvbNNU82MbW0cTYzeKGKVUG1a7kc2/3uP676Jxf/F91WR4+W6LnA
 W//1xv7sGbhK8AUYGsi8ZKuDhnfxSBl0U/R/cyonOkX/16sUvPoiwMdX3SPa9tJStkeDuOQB1zh
 Q3SGed42moVgdD4NH5sRQbrtDB+7HqsQcz3NXnX9EMFEBNJQ8rXZWSl7d+F3++zVHMHGwg8HEn1
 1OaWzdR6UbDB5ukkqiDb4EpgKakSvtIWAlnYnZD6RLVxtgkP
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260492-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,perex.cz,suse.com,oss.nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:shengjiu.wang@gmail.com,m:Xiubo.Lee@gmail.com,m:festevam@gmail.com,m:nicoleotsuka@gmail.com,m:lgirdwood@gmail.com,m:perex@perex.cz,m:tiwai@suse.com,m:chancel.liu@oss.nxp.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-sound@vger.kernel.org,m:stable@vger.kernel.org,m:shengjiuwang@gmail.com,m:XiuboLee@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B9EC6404A0

On Mon, 01 Jun 2026 17:33:27 +0900, chancel.liu@oss.nxp.com wrote:
> ASoC: fsl_sai: Fix 32 slots TDM broken by integer shift UB in xMR write

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/1] ASoC: fsl_sai: Fix 32 slots TDM broken by integer shift UB in xMR write
      https://git.kernel.org/broonie/sound/c/4790af1cc2e8

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


