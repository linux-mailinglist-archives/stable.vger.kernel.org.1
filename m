Return-Path: <stable+bounces-80700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA4798FA56
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 01:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E422827ED
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 23:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184621CB536;
	Thu,  3 Oct 2024 23:17:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out28-60.mail.aliyun.com (out28-60.mail.aliyun.com [115.124.28.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637D314F124;
	Thu,  3 Oct 2024 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727997452; cv=none; b=O9G3w/LXt8K+LGx7v4XCuV58i7w8EE+r7cJ+a01WtccqRZ8JQW5oVv7SiQoRD9V76Lr1KXiD5MyVFjwKW+0yCwCb5Aorr8TWPQl6BbYGLwL2X9V0Trk3CYQrjshRD+2Q5c1iUrhRORS16tebH8FimHIHfkOhPq4N0bb9nFKXrzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727997452; c=relaxed/simple;
	bh=RwLY74sC5RdaY6GgDi2FqtfjJxp8v3vkGtL37IuU3hQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=eusUj184nfNs/qDQdj9BzEKNmNJ4T0mr12gp0UQ2jnku9hMJhPf+DdFzh/eEwa6+xOmm6xUVhjwMuQ6G1c4nceY2mAkMgxacQJBkjn3znzSjtP4qYc9WgR5JeGxNoYL9zn5nWS3+IReg9PHBtFkwQcX9YqUpGInlyXMLz0rROAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.ZYfSjLp_1727997442)
          by smtp.aliyun-inc.com;
          Fri, 04 Oct 2024 07:17:23 +0800
Date: Fri, 04 Oct 2024 07:17:24 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.6 000/533] 6.6.54-rc2 review
Cc: stable@vger.kernel.org,
 patches@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org,
 akpm@linux-foundation.org,
 linux@roeck-us.net,
 shuah@kernel.org,
 patches@kernelci.org,
 lkft-triage@lists.linaro.org,
 pavel@denx.de,
 jonathanh@nvidia.com,
 f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net,
 rwarsow@gmx.de,
 conor@kernel.org,
 allen.lkml@gmail.com,
 broonie@kernel.org
In-Reply-To: <20241003103209.857606770@linuxfoundation.org>
References: <20241003103209.857606770@linuxfoundation.org>
Message-Id: <20241004071723.69AD.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.07 [en]

Hi,

> This is the start of the stable review cycle for the 6.6.54 release.
> There are 533 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Oct 2024 10:30:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.54-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.

A new waring is report by 'make bzImage' in 6.6.54-rc2, 
but that is not reported in 6.6.53 and 6.12-rc1.

arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
arch/x86/tools/insn_decoder_test: warning: ffffffff8103c4d5:    c4 03 81 48 cf e9       vpermil2ps $0x9,%xmm15,%xmm14,%xmm15,%xmm9
arch/x86/tools/insn_decoder_test: warning: objdump says 6 bytes, but insn_get_length() says 0
arch/x86/tools/insn_decoder_test: warning: Decoded and checked 6968668 instructions with 1 failures

the root cause is yet not clear.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/10/04



