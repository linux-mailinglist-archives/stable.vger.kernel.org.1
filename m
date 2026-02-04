Return-Path: <stable+bounces-213372-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLWXOi8tg2kwjAMAu9opvQ
	(envelope-from <stable+bounces-213372-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 12:27:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3D2E51BC
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 12:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFD34301F853
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 11:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEC321770A;
	Wed,  4 Feb 2026 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjyQptC+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B7389459;
	Wed,  4 Feb 2026 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204372; cv=none; b=n9zzxZFV/3s2b2e00U49AEldNpmCDbAAiwsVzZTpOOUC+93Rjw+3kowulU+1Optd3k79ca9SSjzN2k1w9DfPsnFjr4Aru0nNxW+XCwlAyrgpwVc2oUD+AI6apXLw1WDXWhq4siUps5OBT4PC5ge3IG3NFwnA3QluQok6vT0BzCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204372; c=relaxed/simple;
	bh=n533qauwA+XzKB1OGpIjsCk3VSjX/XOY+phhWUQLwCw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EzgLFtME1gwEP3tFrqxAcXmoabfR7afP1is2mV2PYl/gXdEzsXS76/yQuQ8Hhqc1YSq+5lkuY8cZHH6ilUluuGtbGI3ln4R+TvIL02y/okHwvP8JLsTs+Zezyyk1cJ4ixV7v6XBCV6lvUWMcFRLe0CHp2mHsvDAYAPl8hYyAXYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjyQptC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65408C4CEF7;
	Wed,  4 Feb 2026 11:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770204371;
	bh=n533qauwA+XzKB1OGpIjsCk3VSjX/XOY+phhWUQLwCw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sjyQptC+egp2M5NTpAMspHb2Ao7mcMQJ+hYWV1CU67OHZgdgMdFfefzmviQBTQoGo
	 Gsi7zMvsviImWQFZhL4HQR3Aamt4PAfluv6ed1JLg8lrnJaVpZlb4wFzWzdx13CcDo
	 XKKKDCdhqoDNfhe9BWYcn2vxp31+k6DN99Vm92VF5vXpk/3Cr9UQsXXEY9k1yf2F6i
	 pXbJ+Q2R6LzIH6K7IFuGIAT4jLsOwWbervuYvjoziRwMW6eDQwTdp4ypYccGuZt2ov
	 ZN/4UkuOe8gKkzKeZkYWZ2ygrcfmIdcBUhwM1Kocd2ejZrZsCC6Jtf8WwU8DOq6i/U
	 k4u8sYMkv8bgA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, 
 Tejun Heo <tj@kernel.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Linus Walleij <linusw@kernel.org>
Cc: linux-ide@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260203-gemini-pata-fix-v1-1-67e1c182b45e@kernel.org>
References: <20260203-gemini-pata-fix-v1-1-67e1c182b45e@kernel.org>
Subject: Re: [PATCH] ata: pata_ftide010: Fix some DMA timings
Message-Id: <177020437014.2807081.12413031521504015903.b4-ty@kernel.org>
Date: Wed, 04 Feb 2026 12:26:10 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213372-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,googlemail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA3D2E51BC
X-Rspamd-Action: no action

On Tue, 03 Feb 2026 11:23:01 +0100, Linus Walleij wrote:
> The FTIDE010 has been missing some timing settings since its
> inception, since the upstream OpenWrt patch was missing these.
> 
> The community has since come up with the appropriate timings.
> 
> 

Applied to libata/linux.git (for-6.20), thanks!

[1/1] ata: pata_ftide010: Fix some DMA timings
      https://git.kernel.org/libata/linux/c/ff4a46c2

Kind regards,
Niklas


