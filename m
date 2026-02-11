Return-Path: <stable+bounces-215838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMwIFC17jGkcpgAAu9opvQ
	(envelope-from <stable+bounces-215838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 13:50:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4D612488A
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 13:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FDE63026ABB
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E47367F39;
	Wed, 11 Feb 2026 12:50:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out198-150.us.a.mail.aliyun.com (out198-150.us.a.mail.aliyun.com [47.90.198.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2815C36655A;
	Wed, 11 Feb 2026 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770814224; cv=none; b=UL8RWRG9V5AfzwfoxKaLHjwLKAFOXAFN7RAvQFNBUy0CKusnStHA4CMIPmmNd2odb0qw488ajItDhiijThEfpV9Oopod4BbOG/MuLLFvefZyJIg7d9Y2G8XdKFO9bJRRufsr1xZhQamrP5B7H72adIAQd7McLBje09UrPC1/9V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770814224; c=relaxed/simple;
	bh=pOJ3Wgx3pd20bpr8Jr7w57FQUKYeSkPJ0/17h4Ye52k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=fsn52FNT+vDEK652XcRfLrTi18OPkfXiXtqH/TUBgYiLTlj0L1MI5/Ya0QKL9ojFYnPwTJL5YIo/GQYf0qpC4g4CETTN8ZQ4+ccGfA4OuEPTUp0RiWjkmlT/dlu6j1oDCWXUrEX2VdLEKb/ZtPKNugHJHK0bKctE10TZGLEic7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=47.90.198.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.gUush8._1770814206 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 11 Feb 2026 20:50:07 +0800
Date: Wed, 11 Feb 2026 20:50:08 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 6.6 00/86] 6.6.124-rc1 review
Cc: stable@vger.kernel.org,
 patches@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org,
 akpm@linux-foundation.org,
 linux@roeck-us.net,
 shuah@kernel.org,
 patches@kernelci.org,
 lkft-triage@lists.linaro.org,
 pavel@nabladev.com,
 jonathanh@nvidia.com,
 f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de,
 conor@kernel.org,
 hargar@microsoft.com,
 broonie@kernel.org,
 achill@achill.org,
 sr@sladewatkins.com
In-Reply-To: <2026021127-posh-anchor-1e47@gregkh>
References: <20260211110620.0A4D.409509F4@e16-tech.com> <2026021127-posh-anchor-1e47@gregkh>
Message-Id: <20260211205007.5D99.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.83.01 [en]
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[e16-tech.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215838-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangyugui@e16-tech.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,citrix.com:email]
X-Rspamd-Queue-Id: BF4D612488A
X-Rspamd-Action: no action

Hi,

# add Andrew Cooper <andrew.cooper3@citrix.com>

> On Wed, Feb 11, 2026 at 11:06:21AM +0800, Wang Yugui wrote:
> > Hi,
> > 
> > > Hi,
> > > 
> > > > This is the start of the stable review cycle for the 6.6.124 release.
> > > > There are 86 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Wed, 11 Feb 2026 14:22:44 +0000.
> > > > Anything received after that time might be too late.
> > > > 
> > > > The whole patch series can be found in one patch at:
> > > > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.124-rc1.gz
> > > > or in the git tree and branch at:
> > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > > > and the diffstat can be found below.
> > > 
> > > 6.6.123 boot well, but 6.6.124-rc1 failed to boot here.
> > > 
> > > error message:
> > > dracut: fatal: iscsiroot requested but kernel/initrd does not support iscsi.
> > > 
> > > 'git bisect' yet not done, and report this problem firstly.
> > 
> > 6.6.124-rc1 without 'x86-kfence-fix-booting-on-32bit-non-pae-systems.patch' (revert), 
> > boot well here.
> > 
> > but 6.1.163-rc1 with 'x86-kfence-fix-booting-on-32bit-non-pae-systems.patch'
> > boot well.
> 
> Does 6.19 work properly on this hardware too?

both
6.12.70-rc1 with 'x86-kfence-fix-booting-on-32bit-non-pae-systems.patch'
and
6.18.10-rc1with 'x86-kfence-fix-booting-on-32bit-non-pae-systems.patch'
works well on this hardware too.

And CONFIG_KFENCE=y is defined for this test of 6.1/6.6/6.12/6.18.

There is no test result of 6.19.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2026/02/11


