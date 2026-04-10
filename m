Return-Path: <stable+bounces-235674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD0kCQx62WkzqAgAu9opvQ
	(envelope-from <stable+bounces-235674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 00:30:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E70A3DD3AF
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 00:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED19E30297A2
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 22:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D602A360751;
	Fri, 10 Apr 2026 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uC5Z6E0a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9708C3D994;
	Fri, 10 Apr 2026 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860231; cv=none; b=AOhLgwPXXfyPR3A+2rvnCkHPEVM/JQxJh+V4Xa8Gde2auZ1YZyuj3X5r+Fcvgq9I4B+MZfvF2jwkTgDVZCilF+ADm4r6c9F8/cL7TnLNFWH2tZsK2BW36w4v5q0/1FfrubLe9sDp28VDJv4zg/SAkAIMeGevNtZxEQBJipVLmAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860231; c=relaxed/simple;
	bh=YrKqoK6qqCE/JLOpjMngxrETrj2UNduX3S3PTQO3KmA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SnUAZU7BlE6hwVSSlWFIoKQyIh3i7YcTrNdShPQ0rTLen5zy/n8dyxwpK5Li6eSJd68tW5k41E3564MNWAu9BcsaGli4i4KqnqgurU7IPbg+D43mFBL2uPDgLlAiAaueBEu+5J2WYtAR0MnL8ocmnBvQgeK7W8DfDXN5wEPacJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uC5Z6E0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F04C19421;
	Fri, 10 Apr 2026 22:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775860231;
	bh=YrKqoK6qqCE/JLOpjMngxrETrj2UNduX3S3PTQO3KmA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uC5Z6E0aqMuirsB39dRyDzsxQjpuySv+25dLDr3jXZ5TFK9R9aWHPjWEhK+LNRMnd
	 zN/b18kNWsgHSBCF77kXnaI3uy/7iA55ZmhToziAjYCHtKXpAs2fDg0njeQOAcOCBJ
	 bBGZUAmXtcRuTSbFcDDCtoMn1hWmkAZxyMQfpM2/mfgQHchx/mVsewGdeFVxkOEdqp
	 Uw8BIECZzMJZQyJRnxsiV+O5wF9uOrxFyxSIp9vp4kxi5IHMBBAXn1sOn3hkNXo2Vi
	 zM0ka0RYn83Kpr+f8gmMgUCWut1cg5Ro4wy59DYEH7XDetHZ4pjcKfdG1TKGq3yufK
	 lp06rrPZBMT0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EF53809A88;
	Fri, 10 Apr 2026 22:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: hamradio: 6pack: fix uninit-value in
 sixpack_receive_buf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177586020555.2666311.14018722379357062077.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 22:30:05 +0000
References: <20260407173101.107352-1-mashiro.chen@mailbox.org>
In-Reply-To: <20260407173101.107352-1-mashiro.chen@mailbox.org>
To: Mashiro Chen <mashiro.chen@mailbox.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-hams@vger.kernel.org, stable@vger.kernel.org,
 syzbot+ecdb8c9878a81eb21e54@syzkaller.appspotmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-235674-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,ecdb8c9878a81eb21e54];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6E70A3DD3AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Apr 2026 01:31:01 +0800 you wrote:
> sixpack_receive_buf() does not properly skip bytes with TTY error flags.
> The while loop iterates through the flags buffer but never advances the
> data pointer (cp), and passes the original count (including error bytes)
> to sixpack_decode(). This causes sixpack_decode() to process bytes that
> should have been skipped due to TTY errors.  The TTY layer does not
> guarantee that cp[i] holds a meaningful value when fp[i] is set, so
> passing those positions to sixpack_decode() results in KMSAN reporting
> an uninit-value read.
> 
> [...]

Here is the summary with links:
  - [v2] net: hamradio: 6pack: fix uninit-value in sixpack_receive_buf
    https://git.kernel.org/netdev/net/c/bf9a38803b26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



