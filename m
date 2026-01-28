Return-Path: <stable+bounces-211963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BvMB6AEemlE1gEAu9opvQ
	(envelope-from <stable+bounces-211963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 13:44:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C90A169A
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 13:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2957F3007E10
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 12:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E46B3502B1;
	Wed, 28 Jan 2026 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YczMVpYw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EEA3502A3;
	Wed, 28 Jan 2026 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769604235; cv=none; b=OtqV4lm/eB/CqCmI2tPz98urlgNFGI/Hh/6jtbh27TcjpGxsSt/ZcldUWJVs7Yf1VNb+zYuSUIaVdmrZaQxqQCGpV0C7fQxKXSzgjOzP4cZG37I9yTIs+hPDr86zvuRIZ2xre2DsVHeNFsytunUm+fLeM7J+LohztgMyABZ55Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769604235; c=relaxed/simple;
	bh=oMHuOisfzFZa/SspMgzHSAJ7KCfQNx6FWbCb53V78Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZK+FvM+4mFCSlj0RbdaICR3wVh0IKIYVsuFc1CsPBQ7yyMe1nahBOm0FXuMtaaCb5R6mPUso1hKVpxXa2jZQ3fazz+4fy3nI92qsM7EjULv0ApV/gXvKdzv5BINgUdUkSdmpgXHK89pmLBknqJz3h9hII1Qhj2vHxFNzo8AgzwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YczMVpYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78FDC4CEF1;
	Wed, 28 Jan 2026 12:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769604234;
	bh=oMHuOisfzFZa/SspMgzHSAJ7KCfQNx6FWbCb53V78Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YczMVpYwGeQR/JzANd0TTmXgJOgr2gVaF/lmwtcANf+m2u8mZcQUL+SRNgcTWC3xu
	 sJdf1nvdsAlouwdM861jTs9hkHdDoI9kAEi35kTHN8yfhZY4ltzT5lOKvrN90UPOBW
	 JlJbsi0un1KaFOczXEmFQFWXYd2/HuThck/kV91xcHw2ULUnrjUMYPS0vjad29vUor
	 uzVwA04GqRfCTna0yHdLTWzBFCdec+pArFM8mRqjmnjd8w4qmcxK36x6Piyi3hd9Vv
	 BebmzG/Bzel3keuqlAkOxwgzxqLPHASewoFUoHnGMMK2gJNnjVJPvEeE/e/fsyoYUM
	 B7INYod04iPjQ==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: ioana.ciornei@nxp.com,
	stuart.yoder@freescale.com,
	agraf@suse.de,
	German.Rivera@freescale.com,
	gregkh@linuxfoundation.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Su Hui <suhui@nfschina.com>
Subject: Re: [PATCH v3] bus: fsl-mc: fix an error handling in fsl_mc_device_add()
Date: Wed, 28 Jan 2026 13:43:32 +0100
Message-ID: <176960420088.2084129.13365764643328327479.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260124102054.1613093-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20260124102054.1613093-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=564; i=chleroy@kernel.org; h=from:subject:message-id; bh=lWZnn2tJcaNFkDUvVsOHuReTjNx23lTBLXZ5Xxh0drE=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRWsZTxpuy6qqC+ZUGFmPFpb9W/kYlW+c8P+djzmb+6P e/R9kkvO0pZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBEOmQY/gdaMj0LCS/9kTGf UfXDEwUfhQNrf71vqtjYp7bdy3dq3C5GhoN2BTr9i19rTZi30rl5knjk4jsvUuZwnrgapvOUVXn 1Hg4A
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211963-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76C90A169A
X-Rspamd-Action: no action


On Sat, 24 Jan 2026 18:20:54 +0800, Haoxiang Li wrote:
> In fsl_mc_device_add(), device_initialize() is called first.
> put_device() should be called to drop the reference if error
> occurs. And other resources would be released via put_device
> -> fsl_mc_device_release. So remove redundant kfree() in
> error handling path.
> 
> 
> [...]

Applied, thanks!

[1/1] bus: fsl-mc: fix an error handling in fsl_mc_device_add()
      commit: 52f527d0916bcdd7621a0c9e7e599b133294d495

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

