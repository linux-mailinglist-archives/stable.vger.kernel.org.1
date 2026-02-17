Return-Path: <stable+bounces-216890-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMbYNXe4lGlmHQIAu9opvQ
	(envelope-from <stable+bounces-216890-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:50:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D4614F59B
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51390303E3B7
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 18:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A87374726;
	Tue, 17 Feb 2026 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnRTNirK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1286B372B49;
	Tue, 17 Feb 2026 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771354220; cv=none; b=IvEv1JVNQ3ZkWaeXV8YhgbQMWDVy0IrDw4Mcr/Sd9y+E/zM8gIJA2wUblLO+1WNlXu0uDXq7NiEkq3bPVvczwVzOEcPpYMlMHolu2JzOFk8cbAsx+KEfTOJ+qjopPVI798z0FN5JX3rF/2D+Ak9eXamyzoQwXW/N7CnMsRuuFkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771354220; c=relaxed/simple;
	bh=h6Y5DVA9NR4IMdCCV4WgryNHjhqftZp+49NwJewYS8g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DsJx5YnurbhketAHIDK7NHWFKIcvNsg/+6s+3WAoz88hzfz+T9Y/fP+l4zorT9zFueOvbuvUNM55vag01NVmQPd+Ejhrp1D9iGel9F5QVMHB4uq+zDN2ZSkkpIotazlK48XoKbUS1SFGJua7sHjDXQ2qAD5SWOSZ333ECqP0gRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnRTNirK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DF9C4CEF7;
	Tue, 17 Feb 2026 18:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771354219;
	bh=h6Y5DVA9NR4IMdCCV4WgryNHjhqftZp+49NwJewYS8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SnRTNirKxgdakGAKVmhPrNUJETKXQFhc7B9LhjwC0OHN3vAXKEp5XwO9LiDSR2dME
	 2Ksw4TXHt8bKSVsUoetOu2z/Vuplsr86MFtqazUIXTRT1tUs/zYKOb7O9XjHtE28by
	 QPW21GSmzO7JEFrrfV9SKrD0Io+SQSso4bX66xvY/1EA7KofCwPQ6ck+0W3cpKQc50
	 fohKfsN5q/5ByAAvoz7W5i6cKutJ1Y8B6rsNvkDQ5DFDvD245M8wF/1D3x9nzMI2OE
	 HXc6pwoJi0g+n9ioFpuflm6aJJsHPkRb/EQm07kOr4v6X3d4Z+5+EqHUjKL+fGB/1k
	 yurGkD/6hMgIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C25E03806667;
	Tue, 17 Feb 2026 18:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9] Bluetooth: mgmt: Fix race condition in mesh handling
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177135421132.600961.11662077069092767066.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 18:50:11 +0000
References: <20260214130610.68236-1-maiquelpaiva@gmail.com>
In-Reply-To: <20260214130610.68236-1-maiquelpaiva@gmail.com>
To: Maiquel Paiva <maiquelpaiva@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 gregkh@linuxfoundation.org, marcel@holtmann.org, stable@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216890-lists,stable=lfdr.de,bluetooth];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linuxfoundation.org,holtmann.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92D4614F59B
X-Rspamd-Action: no action

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 14 Feb 2026 13:06:10 +0000 you wrote:
> This patch addresses race conditions in mesh handling within mgmt_util.c.
> 
> The functions mgmt_mesh_add and mgmt_mesh_find modify or traverse the
> mesh_pending list without locking. This patch uses guard(mutex) with
> the existing mgmt_pending_lock to protect the critical sections, as
> suggested by maintainers in previous reviews.
> 
> [...]

Here is the summary with links:
  - [v9] Bluetooth: mgmt: Fix race condition in mesh handling
    https://git.kernel.org/bluetooth/bluetooth-next/c/003ca042a386

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



