Return-Path: <stable+bounces-224869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EqyAh3OsmmPPwAAu9opvQ
	(envelope-from <stable+bounces-224869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 15:30:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9078227360D
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 15:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B12703042976
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 14:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E44367F5D;
	Thu, 12 Mar 2026 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgmsn9M6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D798D356A0D;
	Thu, 12 Mar 2026 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325506; cv=none; b=bpDTpo/SZFrKxWt2swMAUtvQVLtuWSxXk2ljpXXS+rgr4eKHvXw2Q689A0wtwsi209lQxzMUA5mDasfBjbrf6W0qTbew9MASxHUtkueuxcsaQco6B8AieYs5dzeXod0xz8a4uO1w6jszq639nGsTWk3r+vNc/n3uNHRmZAX7SOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325506; c=relaxed/simple;
	bh=4xUb1S4GC6UeZ+cW4Nk+qMPOWGA/s/Ap+f4ofUkWaZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0IbeRteb5kXws4KHtqG3enioJyJwBtBwfoFF0bwp/g5XbccWvIssZEI5dr+MCLTnx18DO/yRHbui/02GYtJKXs3m+7STY9fQ8JwL1FGMgHxe1oS6j7H4i5w4yq4W3RnrpKZY3773P6Eb9nLQHEApMZyVaANw6Zouwqqxx6iBVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgmsn9M6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24E9C4CEF7;
	Thu, 12 Mar 2026 14:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773325506;
	bh=4xUb1S4GC6UeZ+cW4Nk+qMPOWGA/s/Ap+f4ofUkWaZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kgmsn9M6fNwzG0HxLKlCDzAwh4hVOk/IDexMY1B6t4bRgnBcWJRktgqeRzQrb8+/Q
	 O7XaFPzaFh0WOHblobJN+mfEFhitSOH9t0CEEddo/cSJmxTuqvnL1vaVrXXj4NfvaU
	 8vN56HxFtoiZb0nYQLM1lscXjMR+/roXFbMlmXLGqDaLAHpVYRl4UdImGcwmX/e7m8
	 V+JCANoM0cJj6WP/R7fPAlmMU96lr9RQ7dx47vXpFrrSTxset82U8Y1uzEL8G5bnjX
	 Y/Bpf/ErU/AjAk560JqLxOTcVfdUErQZFJCrw3dzTkGivOU6DKSHo/BH78cYI5BC6Z
	 7c6zdRR+iClqA==
Date: Thu, 12 Mar 2026 07:25:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Moses <p@1g4.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net-shapers: clear hierarchy pointer and defer
 flush frees with RCU
Message-ID: <20260312072505.3d041823@kernel.org>
In-Reply-To: <HsPWaZkAZhVlbA7H6W6OtjDWVtryYVaPhSvE1jztmcWN02uRKeG3Gnvh5x0WjwdmDvowQge_ZUmD8Dmm3g5tGVyT5PjgmFcgGIRy2_B4bwQ=@1g4.org>
References: <20260309173450.538026-1-p@1g4.org>
	<20260310192842.3c3b2070@kernel.org>
	<cjiUUrQ73CJYWcTmlHQVSJPUJlxVg4kSZAnqkHKnU1SKeWoyy4F2qtIw7wuFRP9qz6Ra9ax0v2EQKsgdiRRUQnnuMweGbv-n08lgvXSTTG4=@1g4.org>
	<20260311171802.2d8a4d45@kernel.org>
	<HsPWaZkAZhVlbA7H6W6OtjDWVtryYVaPhSvE1jztmcWN02uRKeG3Gnvh5x0WjwdmDvowQge_ZUmD8Dmm3g5tGVyT5PjgmFcgGIRy2_B4bwQ=@1g4.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-224869-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9078227360D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 06:05:45 +0000 Paul Moses wrote:
> I'm sorry, I'm not seeing it that way.

;-D

How very post modern of you.

