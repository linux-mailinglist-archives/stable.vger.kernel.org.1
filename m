Return-Path: <stable+bounces-215875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKk2GlXbjGm3uAAAu9opvQ
	(envelope-from <stable+bounces-215875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 20:41:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4A9127387
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 20:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5B63303C4F3
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 19:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152413542F5;
	Wed, 11 Feb 2026 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQyk5deY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61253542E7;
	Wed, 11 Feb 2026 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770838813; cv=none; b=U8rCfFsSP3OoLobsJASkvm/jX1c/w4twPBLFCK9t2IAUTyU1CwntVuI4Y1EgSG3TbQGmEiswenmjCJGXXGvjGQWuF6z+80DSt7jZW7W3G2szcW8PlH53bc0QJvjtMXsKJS4hty6zpgj6GuLMIdNtyASmxq1KI+skPmMM6Xq055I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770838813; c=relaxed/simple;
	bh=HvQ4cnixqUKyg+SllepuEvhBcD2/ieez5yuQtifif60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H/RfG/CKKNh0Hg//icO/v2ZBR9HCtzFjlPH18pQy6QouKbhz5FtHNX1SjkzfodP2UiMcJzUqzbFU8nXqs+nTY+GImSzg/h8uctsW+24UI2IHW/QY4+brkpNgqP+ln9fyx/2i+iIdwemd1Gp+hx7nkWVU0rdu+qvbQQt7xp3uyRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQyk5deY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED80C4CEF7;
	Wed, 11 Feb 2026 19:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770838813;
	bh=HvQ4cnixqUKyg+SllepuEvhBcD2/ieez5yuQtifif60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tQyk5deYFw6bFD/1N5vIBOtHcCldMaHOkaF+CxtZMEfaGgKmutSNz1ql6tRroZ8bs
	 Hp7vXKI4pyk3q35mr3OANxMIjdTyGobpiZ1k+avYVUUlYVyRLcnVai4OHGkLjrX+Bb
	 EhMmoM4QzB5YOCrMODWI1YWdhkhOnUGFPaV2W8w++jLZFTXR7gWYG+g4Hbvv2fgwZa
	 z6/pkBbA/c+FwjNJdFOd7pOHZ49Gj5dkPFxjylOwZefsR0/yZ8dylAAc5Hjz+VmLvh
	 l/U4WET0/eGzTKGTbn2QC9qAamhg82/AArdSDzkxmXIblapKcVjM4ww8EskanP2NF+
	 IccRpZSEMEkIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 851CD39EF964;
	Wed, 11 Feb 2026 19:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: purge error queues in socket destructors
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177083880807.688115.2802433045954977794.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 19:40:08 +0000
References: <20260211-bt-purge-error-queue-v1-1-42159dd7bb28@igalia.com>
In-Reply-To: <20260211-bt-purge-error-queue-v1-1-42159dd7bb28@igalia.com>
To: Heitor Alves de Siqueira <halves@igalia.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 willemb@google.com, pav@iki.fi, luiz.von.dentz@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, syzbot+7ff4013eabad1407b70a@syzkaller.appspotmail.com,
 stable@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,google.com,iki.fi,intel.com,vger.kernel.org,igalia.com,syzkaller.appspotmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215875-lists,stable=lfdr.de,bluetooth];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,7ff4013eabad1407b70a];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BF4A9127387
X-Rspamd-Action: no action

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Feb 2026 15:03:35 -0300 you wrote:
> When TX timestamping is enabled via SO_TIMESTAMPING, SKBs may be queued
> into sk_error_queue and will stay there until consumed. If userspace never
> gets to read the timestamps, or if the controller is removed unexpectedly,
> these SKBs will leak.
> 
> Fix by adding skb_queue_purge() calls for sk_error_queue in affected
> bluetooth destructors. RFCOMM does not currently use sk_error_queue.
> 
> [...]

Here is the summary with links:
  - Bluetooth: purge error queues in socket destructors
    https://git.kernel.org/bluetooth/bluetooth-next/c/d5e3243e55d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



