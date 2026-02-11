Return-Path: <stable+bounces-215739-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEDmGPX1i2l4eAAAu9opvQ
	(envelope-from <stable+bounces-215739-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 04:22:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7C9120E5A
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 04:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 051AA3056161
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 03:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D90344039;
	Wed, 11 Feb 2026 03:22:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out198-174.us.a.mail.aliyun.com (out198-174.us.a.mail.aliyun.com [47.90.198.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDE82046BA;
	Wed, 11 Feb 2026 03:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780134; cv=none; b=PmFtz5VN1JdqfAikmeSqIk3N110AjyAVx6q8/4X+CiN+vuZVyOAjrI82s50z9QvL49re+Kaquk5/1ry04YemBEReNLIblwjtYx9BMl+z0Dw0zQKwJqsh4k7T+yajHKt+440KEn2jLsmCjiaUaMLG3MyDe3fOGlwyMoIOJDiqY4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780134; c=relaxed/simple;
	bh=C6jVpQUWsOpuX91E+e2BfVX3sRY/x0L1hc0vcXUciWI=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=rBoJRYQq++g9xA5RiIwAIW6PVk1i2okQLQOlQ5L0DJEM5/gdYAHcJt40UjEUIPq+64BiCqT+ucQvw++Stw2KrZXFolHTa9q8BZjyq6HnYljeESTR4hqoTPwr7u4Eal/XZDsUpIXYypU8DlnQ6E8DeFnQbdmj8/7CFdjPE9A856c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=47.90.198.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.gUTIyKs_1770779179 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 11 Feb 2026 11:06:21 +0800
Date: Wed, 11 Feb 2026 11:06:21 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable@vger.kernel.org,
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
Subject: Re: [PATCH 6.6 00/86] 6.6.124-rc1 review
In-Reply-To: <20260211085248.EAEE.409509F4@e16-tech.com>
References: <20260209142304.770150175@linuxfoundation.org> <20260211085248.EAEE.409509F4@e16-tech.com>
Message-Id: <20260211110620.0A4D.409509F4@e16-tech.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[e16-tech.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-215739-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangyugui@e16-tech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[e16-tech.com:mid,e16-tech.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF7C9120E5A
X-Rspamd-Action: no action

Hi,

> Hi,
> 
> > This is the start of the stable review cycle for the 6.6.124 release.
> > There are 86 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 11 Feb 2026 14:22:44 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.124-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > and the diffstat can be found below.
> 
> 6.6.123 boot well, but 6.6.124-rc1 failed to boot here.
> 
> error message:
> dracut: fatal: iscsiroot requested but kernel/initrd does not support iscsi.
> 
> 'git bisect' yet not done, and report this problem firstly.

6.6.124-rc1 without 'x86-kfence-fix-booting-on-32bit-non-pae-systems.patch' (revert), 
boot well here.

but 6.1.163-rc1 with 'x86-kfence-fix-booting-on-32bit-non-pae-systems.patch'
boot well.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2026/02/11




