Return-Path: <stable+bounces-249408-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICg7EyucC2oWKAUAu9opvQ
	(envelope-from <stable+bounces-249408-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 01:09:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E72DF574E6B
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 01:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A92B30117D5
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 23:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AE1317148;
	Mon, 18 May 2026 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B08LyvlP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E4C2F8EBA;
	Mon, 18 May 2026 23:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779145767; cv=none; b=P7uNPWJjSCYAT6sdTyaS/sMMxFA6FVYbfHvhi8dPeESNdyjSghGtvXH69BXlLvdv/wtgj/Zz63+NRK7xg4LiRrVQgtLwotxvco/MPoUl1RxdcuytKPp6sUAvbj9e3tLGuBVUEjktb3MB65UUSXd5s5J1oGMDwwY3HK6INElWwE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779145767; c=relaxed/simple;
	bh=3KiSMFOH3HMwtKNyFsd9/qwQR4mxxUvWD2vMw5ReAHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2+1L4nKdqMcaMcTGAyn9jUufz4VCyZGRexYQdwj6ZMpw8IskqFwKNlPx3jgI8JAX9Pa7eCpHf7P+RUL3xySyvIeQKFqgFST7wQV1z2MRE29Apzj8rJqmB4fNOlaJhDTXmqvuzVS6hzmFHdlZeGYj2KGhOmFGnHpGGm/uUDYQK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B08LyvlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A297C2BCB7;
	Mon, 18 May 2026 23:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779145766;
	bh=3KiSMFOH3HMwtKNyFsd9/qwQR4mxxUvWD2vMw5ReAHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B08LyvlPz1JZJX+jFgq1TwFJNTp4k0gzz8rUMUgl59GbMGhbO74usM3LHoiXD5x2D
	 i/HLz6DttqIefwGWwT/C55CIUCabNkiFmQnz2MPjju24aVbE9rR9JmzU7z9KCmQWZ7
	 XWgtmGQ1WAKeQHmAZhvifpjllSgHWNrfjIILjRf7V+Z46tmRaR6clCRGd56rbqGgqe
	 0Fs4gfGdVeKBfKlSzCI7fXUgqvLdDlXHUo57U+whTLix+HTJJaakuoru8UIa25GymH
	 iknJmBIgjxx29T0c/yoEECkGLjF6t0wG6T+zNHmAKV6YHcCb0QPO9Keo+mo+lK/05l
	 Fi3As/9wlGhxw==
Date: Mon, 18 May 2026 16:09:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Samiullah Khawaja
 <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>, Krishna Kumar
 <krikku@gmail.com>, Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, Xuewei
 Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu
 <xuke@tsinghua.edu.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v3 net] net: core: dev: add reprocess depth limit for
 another_round in __netif_receive_skb_core
Message-ID: <20260518160925.0b061c1f@kernel.org>
In-Reply-To: <20260514122444.48184-1-zhaoyz24@mails.tsinghua.edu.cn>
References: <20260514122444.48184-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249408-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,mails.tsinghua.edu.cn,126.com,tsinghua.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E72DF574E6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 14 May 2026 20:24:41 +0800 Yizhou Zhao wrote:
> In __netif_receive_skb_core(), the another_round label can be reached 
> via a TC ingress redirect (bpf_redirect_peer returning -EAGAIN).

Does not apply to netdev/net, please rebase+repost.
-- 
pw-bot: cr

