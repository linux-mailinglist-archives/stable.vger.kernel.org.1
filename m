Return-Path: <stable+bounces-59010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAF292D243
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 15:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270822848CB
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668EB192460;
	Wed, 10 Jul 2024 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="jI+Bwb6E"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495F319246B
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616789; cv=none; b=FlS8dXuDxtDeRmwHNb0Ca4hncm29yD5IlweKlA/DgpD6rjgRACeXn2B/1HXKgd7vAqJspcOoc3q+D4sWtlScSnDueG7RaMIcSyGh7KxEdQyeIzVILrVpI6A7cyQO6LuWejWFO2EkLUcEiNMPObVmGmovz+DYm6n1Vz6lGA8Zlvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616789; c=relaxed/simple;
	bh=cnr4r9LciJZYdRBWiSWNwRQcV8Njo3jA3n7WtVMyLro=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=JMLl9efi1M/6ldekJSW1J9ju++APR1EGm5gOWSkTzkmxKttBzBUioCG5pS7zGPbKWZ6vyHnzFPv2QohIwPMnmSwG0o4NRmHrE8IET8qk2GErS/cSDRBbzwVmaZVjY66W+xVZuXWySHRciCMjF0W1IkGkKC9bdc6oiz/sMsTjgrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=jI+Bwb6E; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id QunRs5LD2JXoqRX1csIrJ4; Wed, 10 Jul 2024 13:06:24 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id RX1bs3B6ol8JhRX1cs6KR4; Wed, 10 Jul 2024 13:06:24 +0000
X-Authority-Analysis: v=2.4 cv=EZ7OQumC c=1 sm=1 tr=0 ts=668e8750
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pdZDpnt4p51YYHdFvqRoQXdleqkuAHHgphSpMovPt7I=; b=jI+Bwb6EVnK5iF8/VTDVCdXjsH
	j3udSui/CTnsfaaXdGCdLXkHGOG1lx0dH/vdbp9e5ojAVxml6Wxof5840X/gV6Uhx5XaFmoE2PeI3
	6pnBmcUUu11S48zCJ4n6qmQtBoFnzo300heigsb4AgimVyybwsh2RGg1E5RwCy5y78M3A1t7LeOJh
	RrxrlyKKDAKoiZpYwUS1vxAI30jSGLpeofDD6KwbEgJzu7XA9YhGrivQn/lZMAvTMdcf4CuwH7K/W
	zS/pOkpQdvGiEqEIkdWDilGArly7q+R0hin9VjG3eKe5/pNTQodbugfMJo7Z7n9HnhJVRhdbNPe3t
	VXmeFZRA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:47994 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sRX1Z-001goi-1v;
	Wed, 10 Jul 2024 07:06:21 -0600
Subject: Re: [PATCH 6.1 000/102] 6.1.98-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240709110651.353707001@linuxfoundation.org>
In-Reply-To: <20240709110651.353707001@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <f9d3a91a-114e-0a1f-8b03-e36c6e037e30@w6rz.net>
Date: Wed, 10 Jul 2024 06:06:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1sRX1Z-001goi-1v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:47994
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJEOFQeaI4X8r512EA68ringheQGcybp3UrQmrSH8KA6uWePTYQbHfzri5UiTRoopLirST4AUy1LHyiCvGHFHotUdzylvL6wzc+HgyvR388etUgOutoB
 0pOcLycqEq0qcop8VxmS+nxs94eQFqVVyuSjnptZ/kAP3FWXLH2s2YdYiVCsLv3yhJ9b+ewyHSJLUg==

On 7/9/24 4:09 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.98 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Jul 2024 11:06:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.98-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


