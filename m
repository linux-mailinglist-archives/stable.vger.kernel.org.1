Return-Path: <stable+bounces-222782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nla6CiJspmnMPgAAu9opvQ
	(envelope-from <stable+bounces-222782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 06:05:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAFB1E9197
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 06:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3ED3530405F2
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 05:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCF12D4B68;
	Tue,  3 Mar 2026 05:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIPi4zKk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F128C1990A7;
	Tue,  3 Mar 2026 05:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772514335; cv=none; b=GLQhzQyfvDD4I7zKGl4hBEGhBBSzIOPgyw8rXI5oQTS7Dj+XTVvF+xfChta6D4yV9CvfFA360e/nDBphDLJyxo4inBkZO+KCHiTZrCpDbLVQ9zGPEynzfJvPUkwi5w+QICGk8lD9avIYK97oAlkhiqLKIgtpjIJekp+7nXSC/2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772514335; c=relaxed/simple;
	bh=pVNsw8FbQdsCS9MidUuH13rClfK4hay55esSvGYmbc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gv2fPYJ3e7/opRH9x7gpWY4Ncjhqh9PUEZIqgU7FI+GVIVwUmSXgYI0dkScv3C7uWMSRcqTfStYOQayQ1b7UpSpkEkvswOApebjOGjmpaujIZG/MO0INbdIFGKQXIs6tRTApLIt2yeQVaibODp+253Wti8vIYKC55ngjMmH6Sfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIPi4zKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472A3C116C6;
	Tue,  3 Mar 2026 05:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772514334;
	bh=pVNsw8FbQdsCS9MidUuH13rClfK4hay55esSvGYmbc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cIPi4zKkoJBDg1OdyRZOdiyXq7bRp5ch+rtA9HWR+50RVJ5n18yqsHmxF1YAVwUNH
	 tvrHGg2ckLHHqhNWWNkIwIuIpjiEmHmp4if0geuAu59i+PF4Ajw3elu418oUub18+f
	 eEvHJ9xaKmm2SdDudYX5fWXrBGqgJzk/73BqSP5vz2drAbz7zo7i4CZWnIbPudKOnY
	 Cr6GaRkWMQ+zNzz/1joHauzswpojvFCxZZ7g5FwzxaX5+zkp+ZZn07k3ajwDhI502Z
	 IyeRjwJlQdBRTlHGkC8T471eZf1Q6Quy96co1yFykKW3DTZWLrRWMPv+3m2i7Ytxb3
	 lk0G3FB86xrJg==
Date: Mon, 2 Mar 2026 21:04:39 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org, linux-crypto@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCH] smb: client: Compare MACs in constant time
Message-ID: <20260303050439.GB5238@sol>
References: <20260218042702.67907-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218042702.67907-1-ebiggers@kernel.org>
X-Rspamd-Queue-Id: 7AAFB1E9197
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.samba.org,vger.kernel.org,manguebit.org,gmail.com,microsoft.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-222782-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 08:27:02PM -0800, Eric Biggers wrote:
> To prevent timing attacks, MAC comparisons need to be constant-time.
> Replace the memcmp() with the correct function, crypto_memneq().
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  fs/smb/client/smb1encrypt.c   | 3 ++-
>  fs/smb/client/smb2transport.c | 4 +++-
>  2 files changed, 5 insertions(+), 2 deletions(-)

Any feedback on this?  Just to clarify, this is intended to be taken
through the smb tree.

- Eric

