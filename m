Return-Path: <stable+bounces-217201-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IihNjsVlWnBKwIAu9opvQ
	(envelope-from <stable+bounces-217201-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 02:26:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A6415284A
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 02:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FA4B30238DD
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 01:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219FE284890;
	Wed, 18 Feb 2026 01:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRntqxQQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E1A1E3DE5;
	Wed, 18 Feb 2026 01:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771377971; cv=none; b=RNcBGB4SEAM0h05He0DgXlA3DZk47Ra0khSxy0c3YFZ1cfAyJKbww4ut7muAacA/wERemeQ7QPkyiSDH+ZRXR+T3gAwQj98nIISyGu1aT68D9Kp+RyUN+d+ZJP34PCgBnIpxcC+AjVosl9cvzBvq5IDU62Dn9isYODQl2QBOGnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771377971; c=relaxed/simple;
	bh=OZNURT9nj0eHL8ZiQkdVSQMg3xYrnevJpqbmwVzZ080=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ivpCghUPJ4kdIikMGMlLAgsFuN/6QyY4VBu8gXZlM7Hev3zSSgpa/YT/QRAAZ1aKQyuwnkvrdvMXzOpWEUXVVA4TPoidGt6DafANrcLod0bp07mHZz6FdyYMMHHzG9f/3cORxOjlLqDOuk6UsPjZd45RjEAGcFARaP02qybpnfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRntqxQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F31C4CEF7;
	Wed, 18 Feb 2026 01:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771377971;
	bh=OZNURT9nj0eHL8ZiQkdVSQMg3xYrnevJpqbmwVzZ080=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NRntqxQQpgJTdFpGPI6iTf+maAe44yBxEx4B6p+UUubZgbSyh77jQXO9JbIhrqRVr
	 /Y/kV9ykcLJVYNsEgkSQlfso+/WbdEBkzNSQCm+LkZy9zQr9nlDDyIsc5W0uI3mKOy
	 DP6l3iCZpNTMJZ2W0eEkM+1i5ToK7iDX57Bev3zUwdfP+jUy9sRvPHt8urwaMfUhyM
	 EtlofsfSeD7cex4+qTDqFeSan0DCJOBT/d61pErPeY0Ok4EGfvsCj2lAlCFdr+2KPZ
	 RWXALGLVSxp8G27Q4CpuNMvkXLKLLjEi6XHwVdMKNKKbN5PxJMGjV0YLqoHo7VZ3Nc
	 UbqDQXHknYAyA==
Date: Tue, 17 Feb 2026 17:26:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Rushil Gupta <rushilg@google.com>,
 Bailey Forrest <bcf@google.com>, linux-kernel@vger.kernel.org, Ankit Garg
 <nktgrg@google.com>, stable@vger.kernel.org, Jordan Rhee
 <jordanrhee@google.com>
Subject: Re: [PATCH net] gve: fix incorrect buffer cleanup in
 gve_tx_clean_pending_packets for QPL
Message-ID: <20260217172609.4c6ee746@kernel.org>
In-Reply-To: <20260214001226.744193-1-joshwash@google.com>
References: <20260214001226.744193-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217201-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43A6415284A
X-Rspamd-Action: no action

On Fri, 13 Feb 2026 16:12:26 -0800 Joshua Washington wrote:
>  }
>  
> +static void gve_unmap_packet(struct device *dev,
> +			     struct gve_tx_pending_packet_dqo *pkt);
> +
>  /* gve_tx_free_desc - Cleans up all pending tx requests and buffers.

Per kernel coding style forward declarations should be avoided.
Please move the functions instead.
-- 
pw-bot: cr

