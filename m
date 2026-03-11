Return-Path: <stable+bounces-224634-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDc0BIbTsGmLnQIAu9opvQ
	(envelope-from <stable+bounces-224634-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 03:29:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A62E425AF76
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 03:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57F283077E57
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F97431619C;
	Wed, 11 Mar 2026 02:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qc9p90vr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320DAEEC0;
	Wed, 11 Mar 2026 02:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773196124; cv=none; b=Lpk1NznNJJPma7/9fl22/CSLsKf2Jf6gJZtohqXZx6J9HmpnPrTPKmWxSYjRQf+UxTBa/HPj0jw+8QZStkYNrLjUtfK6wP4jp4qnQVQv88IEQVpfIhErrH37KqZ/MCz7tAFaoZzqH2YwR9hw9xu2hQjYCXlj5cTYvy1I1e8eJgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773196124; c=relaxed/simple;
	bh=kHUhOKfm6EhYoR1ZSmXpxs6iSlwDqVibrXnaqUm+ZyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsRj9hDXKjEYIoqq7fnxwk10kAWqXeMOalONiZ5Pjf2LkmHLabOqLCx4QlKEUD9wHbhvdYKLIK6WqZDyFRIG7AwAhvK6KPSx5/24q+xhlP7ADzGpotOFZIE7IDHhxdPBPSjXAR8bTwu+R3gG77zR7YihryyO3MEAemkCnkQ6Scs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qc9p90vr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CE3C2BC87;
	Wed, 11 Mar 2026 02:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773196123;
	bh=kHUhOKfm6EhYoR1ZSmXpxs6iSlwDqVibrXnaqUm+ZyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qc9p90vrsxl2S2oOvzVknpXAtSV9SDR2xko1hMCnji/mxbS7k5EHWuejElmAT4PFH
	 2iIR4laFcFzzNGjPqZcNd9G0OEf+eoHbCUpA3Ekh3O26MqJqlEVHEn6p/57oukFLjq
	 K/fkVt81U84hfgM8qLpf/xb7NTuUEK8I+VTH+DmxEpr2Q0+eoLzefqFK/SNNp9xZ2j
	 2Yh6WGbyrfnMEb722cNDVmYh8JlUMs4AnR1k7AsfvTv7HUpdusl5Pep35rd5nDWjt2
	 fAg/t8nisHq08xsBQoJK4/QXE5rGnSMKVDitlIO5k4/vXJYOFwM/KcYPKQdGaKTLKU
	 8tWix0Wrm75UQ==
Date: Tue, 10 Mar 2026 19:28:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Moses <p@1g4.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net-shapers: clear hierarchy pointer and defer
 flush frees with RCU
Message-ID: <20260310192842.3c3b2070@kernel.org>
In-Reply-To: <20260309173450.538026-1-p@1g4.org>
References: <20260309173450.538026-1-p@1g4.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A62E425AF76
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-224634-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 09 Mar 2026 17:35:06 +0000 Paul Moses wrote:
> net_shaper_lookup() and the GET dump path traverse shaper state
> under rcu_read_lock() without taking the shaper lock. During
> teardown, net_shaper_flush() freed both the shapers and the
> hierarchy with kfree(), but netdev->net_shaper_hierarchy still
> pointed at the freed hierarchy.
> 
> This lets GET readers race netdevice teardown and walk freed
> xarray state or freed shaper objects.
> 
> Detach the hierarchy pointer from the netdevice under the
> shaper lock before teardown and switch the shaper and hierarchy
> frees in flush to kfree_rcu().

This is not the right fix. The shaper hierarchy as a while is not under
RCU. The problem is that we take a ref on netdev and then lock it,
assuming that it's still alive. But it may have gotten unregistered in
the meantime. The correct fix is to check that the netdev is still
alive after we lock the binding or take RCU from the Netlink side.

I'll take patch 2 it looks obviously correct.

