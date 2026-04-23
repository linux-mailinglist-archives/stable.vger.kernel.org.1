Return-Path: <stable+bounces-240520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HG0C3xN6mkhxgIAu9opvQ
	(envelope-from <stable+bounces-240520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 18:49:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA6D455192
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 18:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48456328607F
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B653822BB;
	Thu, 23 Apr 2026 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwO+A49b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E7B32142B;
	Thu, 23 Apr 2026 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962341; cv=none; b=V5FkPCi3VcInXCjT6OHaG5ViFr4OPLUTYSN2VE7wYtomFLnc6S+GZftb9shK1XGK6Z0p1z13weUoyITTOsS8eE07yIKEXgpYHwkcKL6AsS5VAU3eS6a4+qWtdk/wu9jDJMeKCZeY5CrNm6bc/OxfHClEKGPLcQ304YnEvJXAzwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962341; c=relaxed/simple;
	bh=kX7pLScbuR1BMQ6cyntXkY/4oiaKg/6C0QQKGD8dxYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9F1pBdjGZTvqCjB+sBSKsVtPF8I6DK3sZ2ppXAP4nwiDkfhXrke0+EIAnY81ssZOl2j6RBcInkI7td58yDR8Bg/WJ/dEgEJFgdufGyAETbqQ8Bc1RsXwHVA05lBm2coKnbFrISr6eCxJXVCt4f8tKRclShyVrKYS75HCM5kIks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwO+A49b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A192CC2BCAF;
	Thu, 23 Apr 2026 16:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776962341;
	bh=kX7pLScbuR1BMQ6cyntXkY/4oiaKg/6C0QQKGD8dxYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwO+A49bwE2MsJ7xV6/BsjCM3Wxnx8UYUgghMEM9eyxNa8NKgfiWD2+u8waB24W4c
	 3sReF8vwvRm2JeGL5g9msoCkyHvJ+jJm1SfbxQ/H9DDSXxBMHe1lGce++QHmhqquc/
	 mbpw/dlDCSTlJgWH3ksGHSDRKjN1x1umaLumAJYnOm1Urv5LbFTtOlBSY0kDk1ad7/
	 O6MOuVEXHwtL9qmUVP+cmL0p2E1IdgPghQpzvc413XYcyapByymwcHu0La6UnDkBv1
	 0Tg0lEy0znq11eYibfW2KPyZENNTwVG+hz2lgulkjUmEb2RtfKRFwYoZo+vtU7wL2A
	 fNSHjQ3A++Qtg==
From: Simon Horman <horms@kernel.org>
To: boolli@google.com
Cc: 'Simon Horman' <horms@kernel.org>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	decot@google.com,
	anjali.singhai@intel.com,
	sridhar.samudrala@intel.com,
	brianvv@google.com,
	emil.s.tantilov@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH iwl-net v2] idpf: do not perform flow ops when netdev is detached
Date: Thu, 23 Apr 2026 17:33:09 +0100
Message-ID: <20260423163307.989421-3-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421051641.370436-1-boolli@google.com>
References: <20260421051641.370436-1-boolli@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240520-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 9FA6D455192
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
idpf: do not perform flow ops when netdev is detached

This commit adds checks to prevent crashes when out-of-tree modules bypass
ethtool core locks and call flow operations on detached netdevs during a
hardware reset. It introduces netdev and netif_device_present checks in
idpf_get_rxnfc and idpf_set_rxnfc.

> Even though commit 2e281e1155fc ("idpf: detach and close netdevs while
> handling a reset") prevents ethtool -N/-n operations to operate on
> detached netdevs, we found that out-of-tree workflows like OpenOnload
> can bypass ethtool core locks and call idpf_set_rxnfc directly during
> an idpf HW reset.

Is it acceptable to add defensive checks upstream solely to accommodate
out-of-tree modules that bypass core kernel locking?

The core ethtool infrastructure manages locks like rtnl_lock for in-tree
callers to guarantee safety. Modifying the upstream driver to paper over
locking violations in out-of-tree modules might contradict upstream policies.

Simon says: If this is to address OOT module behaviour then I am concerned.
            And I would suggest that the correct approach is to fix
	    the OOT kernel module.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> index bb99d9e7c65d5..8368a7e6a7544 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> @@ -43,6 +43,9 @@ static int idpf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
>  	unsigned int cnt = 0;
>  	int err = 0;
>  
> +	if (!netdev || !netif_device_present(netdev))
> +		return -ENODEV;
> +

Could this result in undefined behavior if netdev is NULL? Before this check,
np is initialized using netdev_priv(netdev), which does pointer arithmetic.
If netdev can genuinely be NULL from out-of-tree callers, should the
initialization of np be moved after the validation?

Simon says: I think the actual problem here is that netdev is never NULL.
            And thus the !netdev check should not be added.

	    Likewise for idpf_set_rxnfc()

Also, is there a time-of-check to time-of-use race here?

The netif_device_present() check is performed outside the vport_ctrl_lock
critical section.

If a concurrent hardware reset detaches the device and clears the present bit
before acquiring the vport_ctrl_lock to set np->vport = NULL, this thread
might pass the present check, block on idpf_vport_ctrl_lock(netdev), and
then dereference the newly set NULL vport once the lock is acquired.

Should the device presence check be moved inside the vport_ctrl_lock
critical section to prevent the NULL pointer dereference?

Simon says: This seems to be a legitimate concern.
            Which seems to further suggest that the problem
	    should be addressed by the caller.

>  	idpf_vport_ctrl_lock(netdev);

[ ... ]

> @@ -349,6 +352,9 @@ static int idpf_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
>  {
>  	int ret = -EOPNOTSUPP;
>  
> +	if (!netdev || !netif_device_present(netdev))
> +		return -ENODEV;
> +
>  	idpf_vport_ctrl_lock(netdev);

Would this be vulnerable to the same time-of-check to time-of-use race
mentioned above, since the present check is outside the lock?

