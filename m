Return-Path: <stable+bounces-231434-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJNkCJTay2k2MAYAu9opvQ
	(envelope-from <stable+bounces-231434-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:30:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D9D36AFC3
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71F7F3023F38
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2603FB7CB;
	Tue, 31 Mar 2026 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHSyjxsh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D0D3E929F;
	Tue, 31 Mar 2026 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967424; cv=none; b=Y9ydr3gCtySqBmEnyx8I+QYhKRYA1OBekV4mkVVR56M6gaCk4h+RZvEMDn8Kd98CbOop1DKeJ18F/UH8r66ygqoeByNglVilnftWUqrzrVNqG+/GO8eMxlMGMgOqIWq7GE/7oZvIDfzz7xK+ZywlTu0rgRoYa4HI5aDQ+m99ASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967424; c=relaxed/simple;
	bh=1M+GkuX6cJUtVL9hB/WZX06T52hMAYbAlmVBD3+KHU0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SKY9kNDkv8xDq3VzWXedxS3VdTBh7RbSDO78b8ypPlr/ZSC02RJ1ZbRzU2ESWOT73qJWUezeJC7fZiN4hwWoiKODINYyGUg3CLw0PaqdWIiZb0nVeBuCpMnOyak+wXSpPJKPAbOkqcc/eoZ0CrRgF9INYroxnJesBZv6UrX0gAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHSyjxsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FF7C19423;
	Tue, 31 Mar 2026 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774967424;
	bh=1M+GkuX6cJUtVL9hB/WZX06T52hMAYbAlmVBD3+KHU0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QHSyjxshnY0XUZYqbU6YqoYn4aLUcj7ESnrWiSmJq/I7Ys87DbFxbuLOXyJofc8d+
	 XaqfmXK98Rjnb/p0k6AM7lfqXXCg6iWidF9T7Vdvnwkn+eLTbTxE2xZZ1X/lKkQ9y/
	 GvHfVrPAADhiSUZrD0/d6C5MvBdcnUMxYdfKFWPdG9GdnGbYwgdQg1tFprpwqBJzYX
	 UHJpolbPggySSWQ5vk5sn7JyCOJjYOM5mV3omxH8FQoR3f6emG2nDkse0hNcfMU6cr
	 u+WswTncPwYepfYHM2BfGnfg8tQbPCOK1ztodK9Od4rqb6MyUn4VOlstqJ90kHPZbj
	 gUbklZkXfVvSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD893809A05;
	Tue, 31 Mar 2026 14:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: fix stack buffer overflow in
 hci_le_big_create_sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177496740803.2731558.9193242747633062811.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 14:30:08 +0000
References: <20260331053916.1856760-1-hkbinbinbin@gmail.com>
In-Reply-To: <20260331053916.1856760-1-hkbinbinbin@gmail.com>
To: hkbinbin <hkbinbinbin@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-231434-lists,stable=lfdr.de,bluetooth];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3D9D36AFC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 31 Mar 2026 05:39:16 +0000 you wrote:
> hci_le_big_create_sync() uses DEFINE_FLEX to allocate a
> struct hci_cp_le_big_create_sync on the stack with room for 0x11 (17)
> BIS entries.  However, conn->num_bis can hold up to HCI_MAX_ISO_BIS (31)
> entries — validated against ISO_MAX_NUM_BIS (0x1f) in the caller
> hci_conn_big_create_sync().  When conn->num_bis is between 18 and 31,
> the memcpy that copies conn->bis into cp->bis writes up to 14 bytes
> past the stack buffer, corrupting adjacent stack memory.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: fix stack buffer overflow in hci_le_big_create_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/4797dfba1aa5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



