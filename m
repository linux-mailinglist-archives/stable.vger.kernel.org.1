Return-Path: <stable+bounces-246710-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLBRJ0HTA2ol/AEAu9opvQ
	(envelope-from <stable+bounces-246710-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 03:26:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4538D52BDC5
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 03:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2431300D770
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 01:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E74E3793D4;
	Wed, 13 May 2026 01:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnxcYDaG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE4236680E;
	Wed, 13 May 2026 01:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778635575; cv=none; b=n58BBwUR91tBaBbRmfvohC3PWvC7e9xRKiVorZlc0vbetnwIlbnrYA9CcOXFOm5qDw9hrMrVJhvy1HPazQdHkLzb/Ulk5Y4VW6l2OIAP4KFVilYhfqKBKZPn6AwXLL4kal7c5KqZNBLJP1vMb4R+k+H0KD+6UBR3hN9L4gGflLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778635575; c=relaxed/simple;
	bh=5cWGC6S0g0BVu5TEwZlQ38c7H9TYD9ltkZngNlCPAkY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFZNlrXd1MqEZKzrGNCi5CBWc/1N2Y5lBn8RMicsg//ocN78lJg6+RxRGyLXw6i+h8JmmTUn/HzpWkzIoS89BflUcjQE5rBIsQ3LwQJAEk09BjiZM3xIoOOKZRpGw642ss0AB7VSEAveJJEmn8H5LZ6rVO1OET9141/9XxauWA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnxcYDaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E0DC2BCB0;
	Wed, 13 May 2026 01:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778635572;
	bh=5cWGC6S0g0BVu5TEwZlQ38c7H9TYD9ltkZngNlCPAkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jnxcYDaG+iNm7dGHMDs28nW71+sQKhKFZHet2BXih/Ipl00pNhYU0e7ECPlurERg/
	 EHYVSZK8tyTVnDnfRBz6O80XWDPlumyDCF4D8bzGYGC2Lx6DVitze1G4RFekahh5Zj
	 VyOYw4XTUqcqB606UsNfk3OHGQgII9da5oMAXHk4n2RF/GAO6r0AGeswyTclRRpU8A
	 pvooJ1Rqmbul6iNZC508XXotmBhr6GMV3iImbifR8sVJHFJVC5QTOz4G8/Cxr3kYGY
	 GX/J1BDu9lUxF5avKKdzjpY59z46EVCJ2WPRC4NFr7hA+X6V6PZWfbLxgt6vS3XTTr
	 0A3yKAa+Ef9jw==
Date: Tue, 12 May 2026 18:26:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, Gang Yan <yangang@kylinos.cn>,
 stable@vger.kernel.org
Subject: Re: [PATCH net 5/5] mptcp: update window_clamp on subflows when
 SO_RCVBUF is set
Message-ID: <20260512182611.7bfbebe5@kernel.org>
In-Reply-To: <03ad4927-6bde-45c4-a90c-92ecfa0a680f@kernel.org>
References: <20260511-net-mptcp-misc-fixes-7-1-rc4-v1-0-5ee57cb2b7eb@kernel.org>
	<20260511-net-mptcp-misc-fixes-7-1-rc4-v1-5-5ee57cb2b7eb@kernel.org>
	<03ad4927-6bde-45c4-a90c-92ecfa0a680f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4538D52BDC5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246710-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 12 May 2026 15:02:20 +0200 Matthieu Baerts wrote:
> Arf, I missed that when reviewing this patch: the 'inline' keyword
> should be dropped here.

I'll drop when applying

