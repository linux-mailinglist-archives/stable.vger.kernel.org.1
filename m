Return-Path: <stable+bounces-231238-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACR7KfuKymn09gUAu9opvQ
	(envelope-from <stable+bounces-231238-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:38:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB0F35D01A
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57ABA314DD40
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA883D9DC8;
	Mon, 30 Mar 2026 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvLNOsa5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543E93A4F2F;
	Mon, 30 Mar 2026 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880763; cv=none; b=F/hVZ8VJvn4tHDw/9iVFABMUtKeKJTWMvcrsyjkjYpiHQP/SSYtJtqCYeUGR7FXo+IZNlZDMoIZSTn3HbHLXTXLXcgafhcx4x4jrWrlNGYA1VMvD41OQip6WL2G/pBKPj73P9uwVpWWzlJySBEWq2f6n6c4xFZBj+DkFJS6HXG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880763; c=relaxed/simple;
	bh=6Enu+qeykIJnVKTzv2YVl8Y1MDo2hvWsbeaPp6jo55A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JQJIZ2nPhWFB1nml/vfPQkLxxXpJosGasqTcybK6c0cBC4/o3p2ENNs2cUGRIKQUdVS59eMEkIOajp9IjHeUfGU+zyfZTqIoVIJdM58AOMcNsecFM+yo6J7yVRZfYuVr9HQfF3k8yrIRxS0PIOXx3CB/HLaCAb0kkUFnn5cBE3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvLNOsa5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC73CC4CEF7;
	Mon, 30 Mar 2026 14:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774880763;
	bh=6Enu+qeykIJnVKTzv2YVl8Y1MDo2hvWsbeaPp6jo55A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CvLNOsa5vjF6ZXL9hoG1CSdRLnMfeROo+B9C9qkIacBTwuBTT+P71v8eK4A0QJ8co
	 bEJpc0rE35tcgHiU1YApoUY4XAYgWFntswjrmzoGZ958BFAKBexE/d4TuIZo3slMCH
	 9B+JJ9oPEjc/TRf7Znd84TGmzgiYVNPcBXlD19YXPkUiycArf9WpX01n/uDSHMYd/p
	 OzwAIHLH0jOisTl0RcU8YfGDfuSVeSamRLaMMKuILp0fSSdKYE4+V5dXW7pjJYJfnF
	 aUifZsNjDF7GzfWGI2Y5QxoIpu/E8bszKL961IByS+12+TBPPrjz73ardIxRusmnlL
	 Wavuz7jnfQndA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Sanjaikumar V S <sanjaikumarvs@gmail.com>
Cc: mwalle@kernel.org,  pratyush@kernel.org,  hd@os-cillation.de,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org,
  miquel.raynal@bootlin.com,  richard@nod.at,
  sanjaikumar.vs@dicortech.com,  stable@vger.kernel.org,
  tudor.ambarus@linaro.org,  vigneshr@ti.com
Subject: Re: [PATCH v4 0/2] mtd: spi-nor: Fix SST AAI write mode
In-Reply-To: <20260330073129.24-1-sanjaikumarvs@gmail.com> (Sanjaikumar V.
	S.'s message of "Mon, 30 Mar 2026 07:31:29 +0000")
References: <20260311103057.29-1-sanjaikumarvs@gmail.com>
	<20260330073129.24-1-sanjaikumarvs@gmail.com>
Date: Mon, 30 Mar 2026 14:25:58 +0000
Message-ID: <2vxzwlytz955.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231238-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pratyush@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1EB0F35D01A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30 2026, Sanjaikumar V S wrote:

> Hi,
>
> I wanted to follow up on this patch series fixing SST AAI write mode
> issues. It has received Tested-by and Reviewed-by tags from Hendrik
> Donner.
>
> Could you please let me know if any further changes or actions are
> required for these patches to be considered for inclusion?

Applied patch 1 to spi-nor/next. Thanks!

For patch 2, I left a comment. I am not sure if it takes the right
approach.

-- 
Regards,
Pratyush Yadav

