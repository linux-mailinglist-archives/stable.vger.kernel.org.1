Return-Path: <stable+bounces-242615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOIWATEs9mlTSwIAu9opvQ
	(envelope-from <stable+bounces-242615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 18:54:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC454B2EC7
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 18:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63685300EF97
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 16:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9408F382F2E;
	Sat,  2 May 2026 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Utq7eS2I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573591E633C;
	Sat,  2 May 2026 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777740841; cv=none; b=k2hAHIbw9s8cOJ5sOwzjgF29M+gag4JPY8qvUrduIEdYA3eCcH1af2OB0Fm+kSK5pmx7/aVgxvlRm43IDGRLbUtQBNp/SXyn0X4FqIBVbJbtyDzT3xUSADSpUp1DeMcLUznX0mjE52RqRyAVFNjXiF+RmLbzvbab3Q9qTI+dQCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777740841; c=relaxed/simple;
	bh=aFCb0SFrXTu8ySOYi/1DqtiWnyV3QZoy6i4pgJE+qrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFOcX4KUHfm2e/FDhgr1uwjcv4lb45Gnh7waYBP6EoO4dtHKcPnJFlNbkMYVeolPiKkwDCR7TmPWYI71zWBeGPRDkxe1kD8lZaMIgyshVcYruI+eACm1I4mGvNKV1LCyuEM9PO0wq+l4maxtxgO3w/ITZ8CtUbfQJi7K7VWRORI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Utq7eS2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81277C19425;
	Sat,  2 May 2026 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777740841;
	bh=aFCb0SFrXTu8ySOYi/1DqtiWnyV3QZoy6i4pgJE+qrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Utq7eS2IqS7BtRh5UEBYc63TQ3O6Ghas0oRYzouNbuinsmC8UDeOuHpca54UMnlic
	 bvDuh/bY4R0OYbOnnym4+lFK5qety6cR/3kR0hj5iVKpkpQQSjWOTpoaugSC4uy2j6
	 SKBI/Z7XpLgwMRiuKT+G/Yr1maAqYEYGTsL9JH04EE51XR/fe52oP8NwLpwSiofUb1
	 XD0iTKFGmWWhJ/JZEoizKlT56Pq/7s6O+IIo2aeChJvvsVpzuIj1kwR2glJ8qXrPb+
	 8WqwSKxzWUayOi3ebaTwMOCRbBemqY9IFG579HjCL9SMOt0drDu7ELg2XA+zCYMF9d
	 Sl8nPxHigd4HQ==
Date: Sat, 2 May 2026 09:53:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 dsahern@kernel.org, kuznet@ms2.inr.ac.ru, willemb@google.com,
 willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v6] ipv6: flowlabel: enforce per-netns limit for
 unprivileged callers
Message-ID: <20260502095359.496aae9f@kernel.org>
In-Reply-To: <20260502150918.4171847-1-maoyi.xie@ntu.edu.sg>
References: <20260502150918.4171847-1-maoyi.xie@ntu.edu.sg>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8DC454B2EC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,google.com,kernel.org,ms2.inr.ac.ru,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-242615-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sat,  2 May 2026 23:09:18 +0800 Maoyi Xie wrote:
> fl_size, fl_ht and ip6_fl_lock in net/ipv6/ip6_flowlabel.c are file
> scope and shared across netns. mem_check() reads fl_size to decide
> whether to deny non-CAP_NET_ADMIN callers; capable() runs against
> init_user_ns, so an unprivileged user in any non-init userns can
> push fl_size past FL_MAX_SIZE - FL_MAX_SIZE/4 and starve every
> other unprivileged userns on the host.

You're getting emailed over and over by the bot telling you not to send
new version of your patches before 24h passed. Do you not understand
that message? If you keep violating the rules your patches will get
automatically discarded.

