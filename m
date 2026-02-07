Return-Path: <stable+bounces-214798-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIqOOvlYh2lnXAQAu9opvQ
	(envelope-from <stable+bounces-214798-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 16:23:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 896851065B9
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 16:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20DF13019808
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 15:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183EB3542E5;
	Sat,  7 Feb 2026 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WN8M8Irn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F792BB13;
	Sat,  7 Feb 2026 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770477810; cv=none; b=mw8KM/S0F0qdseKSWtRuKUlTjX80E17wUdKY0Xi6f3NPQj1uwQYa5WPoRZ7UjpptA4j9l+3eEXhExSZ/0PN4fNdwD0UXoH5dNtw8TKG9NCY1+/0gfSQyFo2O27Z8mm7Zvbz4HWkcMhwW0sAUCdaHRcPvsxmQYO3ThB+DlUtTWVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770477810; c=relaxed/simple;
	bh=yb0vu3inmeFuOijnyY/2ABRIYBMbEedwtQP0k/x11NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVUHrE56CkhmYZtRBdMTbRT3OCq3g5W7mLmEoLpajpJlNrSa4gLdxGIakFTp4NQTzKXqZa/ckq7rzLeiMexSylZiWxGC8QRgLbaeqMPXtrvX2jck/xBQHoKbGbia0UzgL/c85lWq9gfc2lb9xkhotPNPX7uZmL6m5UQ0aRjbgkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WN8M8Irn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B740C116D0;
	Sat,  7 Feb 2026 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770477810;
	bh=yb0vu3inmeFuOijnyY/2ABRIYBMbEedwtQP0k/x11NM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WN8M8IrnsS+GXNtOXULaKpy2m5v2nEI4Dugpo+HU0dmrOo+BA0iHNmvKEHMjgiJMC
	 f+6wi0Mm7iGqKL0CgA1nH1IC92srH/UNYAVmg7WmDhqOfHQZTKbk4G70FKHCCiHLqh
	 qbg/6MSLeN014ASA6lq6asNHxyvKFvYT0OjWEjys=
Date: Sat, 7 Feb 2026 16:23:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Cc: stable@vger.kernel.org, davem@davemloft.net, yoshfuji@linux-ipv6.org,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kafai@fb.com, weiwan@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com, yin.ding@broadcom.com,
	tapas.kundu@broadcom.com, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1-v6.12 ] ipv6: use RCU in ip6_xmit()
Message-ID: <2026020719-gone-renewably-f94b@gregkh>
References: <20260205074722.2091297-1-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205074722.2091297-1-keerthana.kalyanasundaram@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214798-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 896851065B9
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 07:47:22AM +0000, Keerthana K wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> [ Upstream commit 9085e56501d93af9f2d7bd16f7fcfacdde47b99c ]
> 
> Use RCU in ip6_xmit() in order to use dst_dev_rcu() to prevent
> possible UAF.
> 
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Link: https://patch.msgid.link/20250828195823.3958522-4-edumazet@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
> ---
>  net/ipv6/ip6_output.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)

Does not apply to 6.12.y :(

