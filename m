Return-Path: <stable+bounces-238353-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBSUJ1Ey4WlGqQAAu9opvQ
	(envelope-from <stable+bounces-238353-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 21:02:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F02413F3D
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 21:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F518309638E
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 18:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7792D1F92E;
	Thu, 16 Apr 2026 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ehuk.net header.i=@ehuk.net header.b="Ss9IB/nK"
X-Original-To: stable@vger.kernel.org
Received: from james.steelbluetech.co.uk (james.steelbluetech.co.uk [78.40.151.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00B03101D8;
	Thu, 16 Apr 2026 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.151.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365911; cv=none; b=sr04rWMV8Om/G4IiGqm3KKuwCOwONlQ0eOz3I2gUz8VRNX7pDDidjRdywzP5P3lyw2r8oeZ4tUSmzexPgHFNxaWWowrNlBw9l5yrGRkdqQv34vv9Z+HqUztwwPjbI2tl96w5hzyq3xyCpMqlmxNyubW0ow4IElIxvKXPGDG52Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365911; c=relaxed/simple;
	bh=pKAfoM3iQd4d3Pvz0ihfInuTbvgYkVlBfNrHPtW1rew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b04kN0Qx7wl2tLrmftkHZm33CEGTJoDTH6rpV7s1TEZPEOpdhhEUTP6RJM2bEh179Q34OZ8OMRtaaiQIsBcTOKehTJaLF+ThS9PTqkcjlyWJYSRzN1eJxBPrk6h6jobxe1KPdWHO7jlficniT/6rr9SnLJSHIT+phXfujiVUT4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ehuk.net; spf=pass smtp.mailfrom=ehuk.net; dkim=pass (2048-bit key) header.d=ehuk.net header.i=@ehuk.net header.b=Ss9IB/nK; arc=none smtp.client-ip=78.40.151.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ehuk.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ehuk.net
Received: from [10.0.5.25] (tv.ehuk.net [10.0.5.25])
	by james.steelbluetech.co.uk (Postfix) with ESMTP id 7DF9BBFC14;
	Thu, 16 Apr 2026 19:55:19 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.10.3 james.steelbluetech.co.uk 7DF9BBFC14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ehuk.net; s=default;
	t=1776365719; bh=je7F5uCIXmm6y2OPbC+xbMc7O/fNY4uLAiFmFqlSZTA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ss9IB/nKtnW/SoTDDVlZhLomH6koCN7bh+eAq/9DZcqw0Yn4119fgDvgts7zIXkxi
	 n473TsOXdnczpgUQ8erPOqwA4eMLMRc0ebhshrgYUe0B/+eyTVraJRNBLswQUiJ1BD
	 evViADwQtxL1o8caL20v3iTiWqTolvcM9a2yPVk3PSL2QLS/fHusoKehtvg/4NG/PE
	 tFkhWqrg0Rx3juE6q/C1ByYwJLcd+vYCqfnK/BiBCNbOjLVb2zPg70SMCgorCxBPy3
	 it/fFLp6Vtjsf8e6Zg45ovcaVNs8MWHPUOmgopwsRKEZX2Y9JtAtMAvGLjq/vCWZzB
	 DXNKETZ4EDIuw==
Message-ID: <172f1405-0094-4957-9758-e700ec76516f@ehuk.net>
Date: Thu, 16 Apr 2026 19:55:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/70] 6.12.82-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260413155728.181580293@linuxfoundation.org>
Content-Language: en-GB
From: Eddie Chapman <eddie@ehuk.net>
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ehuk.net,none];
	R_DKIM_ALLOW(-0.20)[ehuk.net:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238353-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddie@ehuk.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ehuk.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5F02413F3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 13/04/2026 16:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.82 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.82-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
I just wanted to point out that the revert of "PCI: Enable ACS after 
configuring IOMMU for OF platforms" is missing here despite being queued 
in the 6.1 & 6.6 rcs (it is meant to be reverted from 6.12 as well). I 
noticed when updating to 6.12.82-rc1 today as I was bit by the 
regression (all my IOMMU groups messed up).

The revert for 6.12 is in fact here:
https://lore.kernel.org/stable/20260320172335.29778-1-john@kernel.doghat.io/

but unfortunately easily missed as shown by the confusion here (same 
thread):
https://lore.kernel.org/stable/99426bd8-32e5-4246-9d3b-772e136bc078@leemhuis.info/

subsequently clarified by the patch author here (also same thread):
https://lore.kernel.org/stable/5hng5r6q525scbclramuv2h2hphljbcsscwohvrs7teuedgfvl@ncr7tqhr4l4z/

Other than that 6.12.82-rc1 boots and runs fine for me on the one AMD 
Ryzen system I've tried it on.

Thanks,
Eddie

