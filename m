Return-Path: <stable+bounces-230345-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CcSIafnw2lvugQAu9opvQ
	(envelope-from <stable+bounces-230345-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:48:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1340B326174
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDBA931CE270
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 13:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFEA244660;
	Wed, 25 Mar 2026 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zBflX+cE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC56238C3B;
	Wed, 25 Mar 2026 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774445512; cv=none; b=dAzJJ5s8mbqINTHJq7ooGBuP7IAnqE3CaPlZXt9QMXCnts0azBblHS0yeg7+EcmdX3GvVToIWQu9YzZqJ9PNUA7DLwsgzRQmepI7lQNoNyibBEaEQlLN/Uj9MBgFIuFkSFvkGmli/tAOJT/31ft1+/Ig7nZoH17jMksJVYhzR88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774445512; c=relaxed/simple;
	bh=uTUQBOCC/KBJgpZSREu4yYx7YWRXCtbxquPPa2PpGkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AS+NBOLWQZp9YrYxrZRt+2H054W8F0ZIehFZe3H+unvwdf+XbbnhHSL4xtERIE/1JEr8hZkr/MFuLPh+zuoNguEILkoJgf93PXWp3TKa/qmryq8sjjlHCia9luoz8tn6mqJb8V3h5Z3pdSppkEpDcHo5rd9bleAY7OoAav93+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zBflX+cE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B05C2BCB0;
	Wed, 25 Mar 2026 13:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774445511;
	bh=uTUQBOCC/KBJgpZSREu4yYx7YWRXCtbxquPPa2PpGkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zBflX+cE3+whyEdjBCgadMGWY/POxqdurO7EcmERS6ZjO3Ssf2kCu2xM4qnMbU68B
	 wS0KDa6Tx38kyr+lIQs3K2ZWRJZ2oUHM2crw7bsjWFx4lvGlC08+iu53q0Hk7czU3S
	 mlIIElH5e8Zylyqnje57eSQ4qBdI8nL8E/4n7yfw=
Date: Wed, 25 Mar 2026 14:31:28 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Mark Brown <broonie@kernel.org>, Jan Kara <jack@suse.cz>,
	Francesco Dolcini <francesco@dolcini.it>,
	Brian Foster <bfoster@redhat.com>,
	Yongjian Sun <sunyongjian1@huawei.com>,
	Matthew Wilcox <willy@infradead.org>,
	Gou Hao <gouhao@uniontech.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Zhang Yi <yi.zhang@huawei.com>, Baokun Li <libaokun1@huawei.com>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.1 000/481] 6.1.167-rc1 review
Message-ID: <2026032547-spleen-mortify-1cf9@gregkh>
References: <20260323134525.256603107@linuxfoundation.org>
 <20260324073447.GA5062@francesco-nb>
 <mhqesgj3u7dr33zit6iwjhykw2zpuallru4qvoloyyqzdqgvki@bpwwmihh357r>
 <d8080343-20cd-4a4a-b726-b9e3c6a5c5eb@sirena.org.uk>
 <20260325035931.GC61656@mac.lan>
 <2026032535-casino-cable-e039@gregkh>
 <20260325131110.GC2107@macsyma.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325131110.GC2107@macsyma.local>
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
	TAGGED_FROM(0.00)[bounces-230345-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,dolcini.it,redhat.com,huawei.com,infradead.org,uniontech.com,huaweicloud.com,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1340B326174
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 08:11:10AM -0500, Theodore Tso wrote:
> On Wed, Mar 25, 2026 at 10:49:43AM +0100, Greg Kroah-Hartman wrote:
> > > I don't have time to investigate further, but Greg, if you could drop
> > > these three patches, that should address this issue.
> > 
> > All now dropped, thanks!
> 
> Thanks!  Just as another heads up, I decided to run a full regression
> test suite on 6.1.167-rc1 with those three reverts, and there ar still
> some crashes with generic/051 and ext4/039:
> 
> ext4/4k: 711 tests, 1 errors, 83 skipped, 4645 seconds
>   Errors: generic/051
> ext4/1k: 636 tests, 7 failures, 1 errors, 78 skipped, 5612 seconds
>   Errors: ext4/039
> ext4/encrypt: 679 tests, 1 errors, 215 skipped, 3343 seconds
>   Errors: generic/051
> ext4/ext3conv: 706 tests, 1 errors, 85 skipped, 5282 seconds
>   Errors: generic/051
> ext4/adv: 713 tests, 13 failures, 1 errors, 91 skipped, 4944 seconds
>   Errors: generic/051
> ext4/dioread_nolock: 711 tests, 1 failures, 1 errors, 83 skipped, 5518 seconds
>   Errors: generic/051
> ext4/data_journal: 635 tests, 6 failures, 1 errors, 151 skipped, 4105 seconds
>   Errors: ext4/039
> ext4/bigalloc_4k: 604 tests, 1 errors, 79 skipped, 4876 seconds
>   Errors: ext4/039
> ext4/bigalloc_1k: 682 tests, 6 failures, 1 errors, 106 skipped, 5454 seconds
>   Errors: generic/051
> ext4/dax: 705 tests, 10 failures, 1 errors, 207 skipped, 3249 seconds
>   Errors: generic/051
> 
> I'll start trying to bisect this as I have time today.  Are you going
> to put out another rc and restart the 48 hour testing clock?

No, I've already done a release, I dropped more than just those 3, I
dropped all the dependent ext4 patches.

If you could test the last release and if I should do any reverts there,
please let me know.

thanks,

greg k-h

