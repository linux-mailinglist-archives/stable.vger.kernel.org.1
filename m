Return-Path: <stable+bounces-240215-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YILCKAC452mu/wEAu9opvQ
	(envelope-from <stable+bounces-240215-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 19:46:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0351143E26F
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 19:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 465C030B8B04
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 17:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D623264E9;
	Tue, 21 Apr 2026 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzygYIIS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A8C32548B;
	Tue, 21 Apr 2026 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793244; cv=none; b=ZHLpInzm8eLZbqI2slKuCuPTiBvqVrKLxvKRKfmT8Tc1j/5H5qUeQGfK1zlfAMpxvwQ+fh4HjV7TTCGmTAiYh4d1uY6l8Uvr0ZecvNQHOL31S5boyxmQDiBCY5RS7lahQxL2i/fzJurDo4f9Ns/9v/bftW6KK6h6kqgcZoOEXxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793244; c=relaxed/simple;
	bh=9fNB/J0Q/DfdEmhtekKZrAUhlEBm1e4+GeehOrO87RA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ksyEmDkrQE6hEmZD4tyJ5pHN58Hb3Iv4Mq86jM7oo5mn+ODTbZU0enYbJWWILQGMbevj4DlAQRM829HG3n8wkAu4/YkJdRnoE4rZY177dwFGj1XoGBhOST9TMeGWArq7bQNasC4Xqiia/hcbO2/zBbh91f9S3qdWgrxHxwhfuKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzygYIIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA17C2BCB0;
	Tue, 21 Apr 2026 17:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776793244;
	bh=9fNB/J0Q/DfdEmhtekKZrAUhlEBm1e4+GeehOrO87RA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AzygYIIS8Nbn3H5iNbPSOEa2LWEOkd4Rxykv7RB52e81y8qX0XWMcSw1tnUPgWlGz
	 A89c3kz1tvlvWBynl2+CJLXQJqLX9u1K4C7GlNBvUkQjOQHVhaDRaQg8UHKv9OaONk
	 ZDBY7FME1CoNcvOCNq4fCSk/fc27uUD/wYrpKCflnG1pNbQdBIioEOVwTZhBvpXaEr
	 iVtOU7n70zmpZKfFFwmX4FUL/SwOmjHo0UWuMpq0DoKpeXZJKR7hezQ3yf0i6MBPTW
	 rKmuMNWO3LMBgZudGJAfFmI7F70rRuq7g2HYI4EltIZAWyDWvYhbuEODaZ1X38f9We
	 qEca8hz/yQK9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DF539301B9;
	Tue, 21 Apr 2026 17:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: btmtk: validate WMT event SKB length before
 struct access
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177679320754.2928707.14796411684619815619.git-patchwork-notify@kernel.org>
Date: Tue, 21 Apr 2026 17:40:07 +0000
References: <20260421111454.3403059-1-tristmd@gmail.com>
In-Reply-To: <20260421111454.3403059-1-tristmd@gmail.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, sean.wang@mediatek.com,
 mark-yw.chen@mediatek.com, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 tristan@talencesecurity.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,holtmann.org,mediatek.com,lists.infradead.org,vger.kernel.org,talencesecurity.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240215-lists,stable=lfdr.de,bluetooth];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0351143E26F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 Apr 2026 11:14:54 +0000 you wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> btmtk_usb_hci_wmt_sync() casts the WMT event response SKB data to
> struct btmtk_hci_wmt_evt (7 bytes) and struct btmtk_hci_wmt_evt_funcc
> (9 bytes) without first checking that the SKB contains enough data.
> A short firmware response causes out-of-bounds reads from SKB tailroom.
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: btmtk: validate WMT event SKB length before struct access
    https://git.kernel.org/bluetooth/bluetooth-next/c/006b9943b982

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



