Return-Path: <stable+bounces-273314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R0tzEMVRUWovCQMAu9opvQ
	(envelope-from <stable+bounces-273314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 22:10:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D30473E056
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 22:10:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZBPeHGWo;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273314-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273314-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 576BE30103A6
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 20:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177653932C2;
	Fri, 10 Jul 2026 20:10:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8004392C4F;
	Fri, 10 Jul 2026 20:10:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714230; cv=none; b=qkoo7VvDuBFmSKvtXdEBO6V/jYcxtvVmPpiuoy7sgxRknIWvcZF0SlZZtosTRYGO9ycpsJ1NOzcnZHFNQFvFEUBezmhRFsKQYYUFrz9PkWMGjBA4pcLfyKG3g/CIgTK09swGFYwE483BFugdYqDaz19wSBKlbaEXEdUB8OISzRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714230; c=relaxed/simple;
	bh=jZIAEm0LzIEcZBtKbcx+mOG90RASyx5ppq/tnH0pX34=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ApzFXI4FFzoKFxy72JCbEbwvT0I45Bku9u4aekyQHkEqc6OMSqQXM4Zu+7YUinUb7CduWwpx6auhUS/YjN7/hinI3otbYejNQa++LHoZQcxO3JOUQVvaS3PvQSzDIPMPJKwNL6hUTS75NRN5t02+NkCTtxSd4T6J96yn0phgvSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBPeHGWo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7936E1F000E9;
	Fri, 10 Jul 2026 20:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783714229;
	bh=xlDN542xXEMw45sKcUigc30whE2e9cufU6/XheKlFKc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZBPeHGWo47lz6QwGmdCK9KO2WaHHmtYw7FVaORoziGPZmJpYnQnkLYx9BfAXLLT9z
	 kVNGIdZnorvyHBCK2FBtpFfp4+d7OmNpOCdRqscJ7ufx0IWrvDzyEwYUxgvoKteQoQ
	 I6SiznyMmmOYxuTpqYEfYXYjD5f1zeyThdCLMGGaGugKwu7J1MAcAPw06wFCpiCcBa
	 trLDQIAygMhmV5ydyRPrce5i6GD3qVYm510b4sZJN8GgwZccaIMODeCHZBR7/JzG3h
	 uXsbvo0Pld9EaFY6SY/MbUCCirshxL8AjSrm3SXNPe9mFGE6u9TBS56W17Aw1/srD5
	 HPLDDdGg5r5GQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569CE3924700;
	Fri, 10 Jul 2026 20:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btrtl: validate firmware patch bounds
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178371420689.843459.7488755213090569844.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 20:10:06 +0000
References: <20260710172503.64964-1-acharyalaxman8848@gmail.com>
In-Reply-To: <20260710172503.64964-1-acharyalaxman8848@gmail.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273314-lists,stable=lfdr.de,bluetooth];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:acharyalaxman8848@gmail.com,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:linux-bluetooth@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D30473E056

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 10 Jul 2026 23:10:03 +0545 you wrote:
> rtlbt_parse_firmware() copies patch_length - 4 bytes before appending the
> firmware version. A malformed firmware patch shorter than the version field
> can make this subtraction underflow and turn the copy into an oversized
> read and write during Bluetooth setup.
> 
> The existing patch_offset + patch_length check can also wrap on 32-bit
> architectures. Validate the patch length and range without arithmetic
> overflow before allocating or copying the patch.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btrtl: validate firmware patch bounds
    https://git.kernel.org/bluetooth/bluetooth-next/c/d09cff8f7ecf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



