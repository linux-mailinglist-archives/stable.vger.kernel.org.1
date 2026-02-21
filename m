Return-Path: <stable+bounces-217614-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI32IP4MmWmxPQMAu9opvQ
	(envelope-from <stable+bounces-217614-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 02:40:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AD116BC44
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 02:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B64B53021715
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 01:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6078831CA50;
	Sat, 21 Feb 2026 01:40:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out28-42.mail.aliyun.com (out28-42.mail.aliyun.com [115.124.28.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0732E31B122;
	Sat, 21 Feb 2026 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771638009; cv=none; b=fLwfu7GE2VP66lKIaye34Ts1lsizt9CewD123aFNTQYcZLV3YKAjUyZ235dtvUyHnOW9X3A9YRUfQKagNAbOrlmgM8n3kMKfYJj8C52aOjyq6Hh6uGvN+bEziZXMFyLr1/lL+g/In85FUSWUcViglxPaK6BliHyIr3PkG8geiog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771638009; c=relaxed/simple;
	bh=fJ5N5OivNGfNs17IocW1hf5cle81k0MQ9EhIy0aRN/A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=fhBJYsVYvsr7bUOCiGnF1zka/7ivPpgyISvfPPtQZzZmbdvbcrYwC2k944y+eo2aPYosiSa8SJRHFnGLxaQ7hTS6RtOZS6qgOpqzXWEGf7lbY67pdYLS3xsc/BegF8j9rnfgXUXXJUxDOx5hxl4kCorQRd5p607CYjxjDwBqfsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.gbWoX.z_1771637683 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 21 Feb 2026 09:34:44 +0800
Date: Sat, 21 Feb 2026 09:34:45 +0800
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
Message-Id: <20260221093444.DED8.409509F4@e16-tech.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-217614-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[e16-tech.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangyugui@e16-tech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B5AD116BC44
X-Rspamd-Action: no action

Hi,

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
> 

6.6.127 boot well on this hardware again.
so this regression is fixed at least in 6.6.127.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2026/02/21


