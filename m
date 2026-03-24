Return-Path: <stable+bounces-230111-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHEpOIhrwmlScwQAu9opvQ
	(envelope-from <stable+bounces-230111-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:46:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD80306A9D
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81CFC305B261
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 10:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB873F0751;
	Tue, 24 Mar 2026 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0IIL6Yy1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3223E3DB5;
	Tue, 24 Mar 2026 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348936; cv=none; b=Bi74QiHM/gHf04t6tfakRr+tLGzdQNdIJQ0f/YMNAq671UdmPCAp/yWJxHAx/D7UKNaJZpifE+2NMmbWyiuW1Fw/mI6RB3pQO7wtMROycyErSwPkCvxLk20SVwFKroHnvWBxW0Jv8x0S8krh0AQjymDA1a/OqHxfmUkIDburhdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348936; c=relaxed/simple;
	bh=DqzbtwvvTaay8bANg1X3zYxfekLToIa0hhDkrZdYOJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lj1f08wwurMNQPOFfPaqa2a62BkXX0iAVWBQoHh9Yu44aiykN+rVXdVxqlcba5ENu6SvuPk/sb50o8o0hCAHDCRdt2DA5J8U2yHenewRZ8XEZqPpQKr/0gyOSZCAiVWLt+Pxh0mmsgfyRMy30jwn75FvBG1IbvVcbFfChGVaevg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0IIL6Yy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6962DC2BCB1;
	Tue, 24 Mar 2026 10:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774348935;
	bh=DqzbtwvvTaay8bANg1X3zYxfekLToIa0hhDkrZdYOJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0IIL6Yy182E2Y2AKeZLaw0NV5a7fQjGEcb2e6YPcjWfoQER2Uu84z+sBBArPsfGFU
	 e9QDgEGKCsxKAetdxAuAgCPhH+63tiO9J5pi2Gytmw9BWhb+2puxOegaOoY2ou4J1h
	 nJBK+pFZspTFkfFDnEnoGX/RIW48LvokTk/0HLtk=
Date: Tue, 24 Mar 2026 11:32:33 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, edumazet@google.com,
	kuniyu@google.com, kuba@kernel.org, dsahern@kernel.org,
	netdev@vger.kernel.org, Ruohan Lan <ruohanlan@aliyun.com>
Subject: Re: [PATCH 6.6 438/567] net: use dst_dev_rcu() in sk_setup_caps()
Message-ID: <2026032419-unzip-twirl-b3e0@gregkh>
References: <20260323134533.749096647@linuxfoundation.org>
 <20260323134544.788448840@linuxfoundation.org>
 <be03a2f9-f5ef-4431-818c-f0424366556d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be03a2f9-f5ef-4431-818c-f0424366556d@kernel.org>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230111-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,google.com,kernel.org,aliyun.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AD80306A9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 11:00:54AM +0100, Matthieu Baerts wrote:
> @Greg: Is it possible to drop this patch for the moment?
> (This patch was probably coming with dependences.)

All now dropped, thanks for testing and letting me know.

greg k-h

