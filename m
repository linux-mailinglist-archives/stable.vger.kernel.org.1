Return-Path: <stable+bounces-243005-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZWqJD62L+Gn1wQIAu9opvQ
	(envelope-from <stable+bounces-243005-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:06:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDAF4BCBC2
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 532653013496
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 12:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3909E3CE4B2;
	Mon,  4 May 2026 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZUXMedxH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16DA3CCFDC
	for <stable@vger.kernel.org>; Mon,  4 May 2026 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896362; cv=none; b=KjUiqQjLJG74VPI6YNgO83VsMUrvUTwcaKMf1vS/YSEIIZwLYsQFezuuQl/AWPRiQz99np7IBfmkuIJvtHOZPrDwNCBKjezlOV5GZXgGfzg/5I+BUGJDTWi8SW+vNNbk+gxOK9jeO+aCJ05wMRQMFz4rEGZfA28vdFUQgo15BYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896362; c=relaxed/simple;
	bh=v5fSA41ImL+JfTJAFSIPXFHR3gXWBwiQaGvK/94/XJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjqFg/fQN0i5kqMeoJ1eipdRkcOLHXZf7Ls8FYGuSfSySK+f2zR9Z+6qy53jtpprwJutVe0pwEfX9330c7ThWJekkAmm+MBaBbvW5p+4DwZUW6I9KWUXRFSAO8jSUtEDXDTTPGRoZORK9FZ98hvhn2QVD57HtcnTGlO4vt+Hchg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZUXMedxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E91C2BCB8;
	Mon,  4 May 2026 12:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777896361;
	bh=v5fSA41ImL+JfTJAFSIPXFHR3gXWBwiQaGvK/94/XJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZUXMedxH/+tS8V0BLpTxTXi8OFBzQURfFvnUrYOodvJjiB+SK4n8s1/voa6DgEgvP
	 tGlpuQkvybR++FMOchw6str/3cRvKl5Ny3/zvXYDL/PfMxtsrwothHMAkJHwKiloui
	 APw+ZcqBqxgYmO1NY9NTTFzkHyi9UvRHJLtGIT6g=
Date: Mon, 4 May 2026 14:05:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yunseong Kim <yunseong.kim@est.tech>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Chen Zhen <chenzhen126@huawei.com>, Jussi Maki <joamaki@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Malin Jonsson <malin.jonsson@est.tech>,
	David =?iso-8859-1?Q?Nystr=F6m?= <david.nystrom@est.tech>,
	Roland =?iso-8859-1?Q?Kov=E1cs?= <roland.kovacs@est.tech>,
	ysk@kzalloc.com, 42.4.sejin@gmail.com
Subject: Re: [PATCH 6.12.y] bonding: fix use-after-free due to enslave fail
 after slave array update
Message-ID: <2026050435-glider-undrafted-71d7@gregkh>
References: <20260426201205.465809-1-yunseong.kim@est.tech>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426201205.465809-1-yunseong.kim@est.tech>
X-Rspamd-Queue-Id: ACDAF4BCBC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243005-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,blackwall.org,huawei.com,gmail.com,iogearbox.net,redhat.com,est.tech,kzalloc.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email]

On Sun, Apr 26, 2026 at 10:12:05PM +0200, Yunseong Kim wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I did NOT write this commit.

> [ Upstream commit e9acda5 ]

Please use the full commit id.  And get the authorship right :)

thanks,

greg k-h

