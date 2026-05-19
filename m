Return-Path: <stable+bounces-249621-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Oo/OId8DGoSiQUAu9opvQ
	(envelope-from <stable+bounces-249621-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:06:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85340581195
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDD72306019C
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E8432FA2E;
	Tue, 19 May 2026 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOX/d4xO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9B531E844;
	Tue, 19 May 2026 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202794; cv=none; b=ulhFSrXC3FEeLHWun7d8eysmU8ptRgWawELAGHVUaL9zzIPxftD9tL5PhUHJGyhDb8S9e73EV6+fWPyj8t8X/eGpsVIO7Aim3X53p6cdOD6gtwJWu70J/Psc74WFcEae0cvDDdMOgXIeNfWKyAvEUJ3KMbCBRc/Kl45maJba7qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202794; c=relaxed/simple;
	bh=fn8wRJXsxyp+AFFoxptH8Hr8ZrQjWahBapcDZYp1W7k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BtsZ0SLTpGNotVkJJRYiTWWmL1d5MWRf5b1uw0UU+vCpMkb7+4NiN3zAJwoA+H1ETFfMHRemUboVWBG5x+V7zzuwBikoLbQPfMImaed05YQ8bJeyAQSXUgLMWgy8ppQmMMU1zZ8sfNxxHlOpD/vJw+KdDf/My6Uc8A68qR6b868=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOX/d4xO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A49BC2BCB3;
	Tue, 19 May 2026 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779202794;
	bh=fn8wRJXsxyp+AFFoxptH8Hr8ZrQjWahBapcDZYp1W7k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qOX/d4xOPNd8ELT3mAggvcsQ+1JdlTECwgHDN7KgourR36ZGka0mQoMME3MnS9XDu
	 bo7A0ACyv2G7pE6OpXD8y5SVh8vVr7QyGAhr+Z25jMbj4jMj0kkIfM2iPAU63J2Zp0
	 /lFjWuz8KVzglsN1xKcgZyehmNaO7mPU9fyf8d1mwJpUFt0PgFWAapKVKWGsH1Zkjk
	 uKIq+2D9NZ7IxCHCbplGXBmXZH2G2XagXBQ5ZAY2Ff5cu5c5k0t3mraqN1q4kCaeSF
	 m9UYibeGnhHob3GX3rxRH9NdV0oM/bDW/fzSm1KE84u4SK3u58dYOwlOsX02xiBsaV
	 gQtUwPlJmkQ3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569143930E24;
	Tue, 19 May 2026 15:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9] Bluetooth: hci_uart: fix UAFs and race conditions in
 close
 and init paths
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177920280488.2756414.8251481561878776667.git-patchwork-notify@kernel.org>
Date: Tue, 19 May 2026 15:00:04 +0000
References: <20260518024949.439299-1-w15303746062@163.com>
In-Reply-To: <20260518024949.439299-1-w15303746062@163.com>
To: w15303746062 <w15303746062@163.com>
Cc: luiz.dentz@gmail.com, pmenzel@molgen.mpg.de, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, greg@kroah.com, stable@vger.kernel.org,
 25181214217@stu.xidian.edu.cn
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249621-lists,stable=lfdr.de,bluetooth];
	FREEMAIL_CC(0.00)[gmail.com,molgen.mpg.de,holtmann.org,vger.kernel.org,kroah.com,stu.xidian.edu.cn];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[163.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,xidian.edu.cn:email]
X-Rspamd-Queue-Id: 85340581195
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 18 May 2026 10:49:49 +0800 you wrote:
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> 
> Vulnerabilities leading to Use-After-Free (UAF) and Null Pointer
> Dereference (NPD) conditions were observed in the lifecycle management
> of hci_uart.
> 
> The primary issue arises because the workqueues (init_ready and
> write_work) are only flushed/cancelled if the HCI_UART_PROTO_READY
> flag is set during TTY close. If a hangup occurs before setup completes,
> hci_uart_tty_close() skips the teardown of these workqueues and
> proceeds to free the `hu` struct. When the scheduled work executes
> later, it blindly dereferences the freed `hu` struct.
> 
> [...]

Here is the summary with links:
  - [v9] Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths
    https://git.kernel.org/bluetooth/bluetooth-next/c/7db62a762f61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



