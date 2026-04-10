Return-Path: <stable+bounces-235641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJCwEcUj2WlrmggAu9opvQ
	(envelope-from <stable+bounces-235641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:22:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F16F3DA567
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B1FC30293D1
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 16:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF0E3D9DCD;
	Fri, 10 Apr 2026 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC5tPOFn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED193DA7E4;
	Fri, 10 Apr 2026 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837617; cv=none; b=Yxz867zB2LdT6BghJgSFzq6GujjDuXxY67DOoASgxDoEnHUuKixnq3OB8oLtsD8KbKNZmIgp0ChcazUaTNF72EbPWCkQlY37e4zTPy09rc6DbMxmxo5hFsYuAnYssVV5jddbT8hACjqq8r5ECGaGNixN3KcRrMsfBlftcxCmEVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837617; c=relaxed/simple;
	bh=G066Zd37ZHLXE4+Ls2TGlCqc1nfjgj0+SEVr6tbwsPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmtSBmv5pRnPtExqaa88ab5ZCwedB0rR6RCJWtY6IugNKqvn36r9UHCGI8pYfWvlXcyrJMFkm2ra2+xIIs+IuBV2MyB9adSpSBjhVyMYxbaW1s3Q7Qm30SFzaid47HiMh8EG9Yk1iLIL1WYv8IowkKl8wcpBG4irFeLS3mZyLZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PC5tPOFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22362C19421;
	Fri, 10 Apr 2026 16:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775837617;
	bh=G066Zd37ZHLXE4+Ls2TGlCqc1nfjgj0+SEVr6tbwsPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PC5tPOFnt+Zc+ZkK7NppQwMzWnkSkGZNvyM4rryZdBiMaYVyhKVEJwhFSoQqe/2io
	 jJcZzTg2KwuOAmwycd1IwfaRlwpvvQCpwJa347S1CgnKbCJwoar4KdwjRoL1/y6T8v
	 nEUyZqWlY6TY1merv3Usbo7Mjg80ZaruL7yw43mzmXaJo9fmG7raXOcGkiiHHeEHK1
	 HxmUAoNjrj6sDV6leCHfyahnYOQpUrGUKWtz0ObqRe2HKRwV2bZ0sOw9t+UBf9oi3Z
	 wfXYLSLxJ7TAReGPLexCYymN9pdN49S5DI/eoeX0Q+d3dVmBLCjzZPH5oCiTa5glcN
	 6o4Br6NuOrJvw==
Date: Fri, 10 Apr 2026 17:13:32 +0100
From: Simon Horman <horms@kernel.org>
To: Mashiro Chen <mashiro.chen@mailbox.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-hams@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+ecdb8c9878a81eb21e54@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] net: hamradio: 6pack: fix uninit-value in
 sixpack_receive_buf
Message-ID: <20260410161332.GA469338@kernel.org>
References: <20260407165007.GB469338@kernel.org>
 <20260407173101.107352-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407173101.107352-1-mashiro.chen@mailbox.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235641-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,ecdb8c9878a81eb21e54];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,mailbox.org:email]
X-Rspamd-Queue-Id: 9F16F3DA567
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 01:31:01AM +0800, Mashiro Chen wrote:
> sixpack_receive_buf() does not properly skip bytes with TTY error flags.
> The while loop iterates through the flags buffer but never advances the
> data pointer (cp), and passes the original count (including error bytes)
> to sixpack_decode(). This causes sixpack_decode() to process bytes that
> should have been skipped due to TTY errors.  The TTY layer does not
> guarantee that cp[i] holds a meaningful value when fp[i] is set, so
> passing those positions to sixpack_decode() results in KMSAN reporting
> an uninit-value read.
> 
> Fix this by processing bytes one at a time, advancing cp on each
> iteration, and only passing valid (non-error) bytes to sixpack_decode().
> This matches the pattern used by slip_receive_buf() and
> mkiss_receive_buf() for the same purpose.
> 
> Reported-by: syzbot+ecdb8c9878a81eb21e54@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ecdb8c9878a81eb21e54
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

