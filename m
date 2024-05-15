Return-Path: <stable+bounces-45224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89088C6C93
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 21:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC10D1C21483
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 19:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1653E3BBF6;
	Wed, 15 May 2024 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="wMLtMQpm"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE014158DD5
	for <stable@vger.kernel.org>; Wed, 15 May 2024 19:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715799772; cv=none; b=li8D3vmxlvSmTFo9cgb45Ht8ptmagzW7iiWcwgbkyRNyDLN/+0w5P3tavG9vUKQ+iWVFZ3gki6YTDgOctJ7WNwbrO3dTc69JT9BYqVXychafRXjX0CiAlgfOnfDChCUklPH6XxQ8GP0MI8uGQY2bfWLVMRRJUdyyq47EHF4fctw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715799772; c=relaxed/simple;
	bh=mikBtoW97YbCBwyvNRnJ38Sg2mM7CDdV4ls2mCBZsd0=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=ufqzDG4oJ2c4wbSFHbBl3D0y81k2C1pMwEkorLsgqiQzC8Rw3YSspzdHov9E2IKoimitd8PAeJiZIo0nma+cx7j4ggiGnlvCU4NAaz2J9624dz6UsnE12kd+OaLaE2lOmmJzHWuj6gxDcnoxJwBqS1DURKqtB3/y3ZIy1IEzB3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=wMLtMQpm; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id 6vbCs1rSzjfBA7JtpsGOGU; Wed, 15 May 2024 19:02:50 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 7Jtosbutk3A6F7JtpslBqG; Wed, 15 May 2024 19:02:49 +0000
X-Authority-Analysis: v=2.4 cv=f5pOBvyM c=1 sm=1 tr=0 ts=664506d9
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sKG1F6rhpqV48qN/JCq4XUf3fNgKXT99hRxa+V7xlp0=; b=wMLtMQpmdIzGIU5G+C3YKuWjIE
	UeRUetp3RdkJ7HylqiM2r0dBGEeJWuqnpgzdtcFQPJyoPh2kd/EISbLkqa090dWphocT6puzEV1z9
	I8tlTPnwHvaT0VSadIHbxAkbp9RSJlCoZYASJQrIrZ+vQ5ezNLCXaWkiO0z+FpXSpYJxJLlZz1kqI
	qeBkz3urzZlah1pkn/pX+8c7LdRv1w/MhysJfGLKJzaOOLN5BA4TVErO52EiJmOgSCSLSa2mnfbb9
	hbKy/qpMDQGSkFu9R4Zc7ANaWX8echZPcaJ7Cj/+tf4PBBTHEYP03UDD3IzXll8xla7sFaYAm2ewr
	/edVhRHA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:35798 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1s7Jtm-002QwV-0X;
	Wed, 15 May 2024 13:02:46 -0600
Subject: Re: [PATCH 6.1 000/243] 6.1.91-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240515082456.986812732@linuxfoundation.org>
In-Reply-To: <20240515082456.986812732@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <d96667d0-f15b-ead0-5451-00471bbefd6e@w6rz.net>
Date: Wed, 15 May 2024 12:02:43 -0700
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
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1s7Jtm-002QwV-0X
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:35798
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLpfifFDiwU/HOtwdSBvPF2jMGUCIiFR0IvhlJRRci8MBORn52S3ajIS1GXlK/X/mL4BH3yUH1l9B38Myhpyz8B71GPVpxUj93WmE7YOD9y58YuyhaXZ
 PfEYopNWYOL441fDFrjMe7A0DQxWZjiHjzZXnneDoKuK6BWDCwJb6VhMsFctR3e0+mVoz+wzLlUwbw==

On 5/15/24 1:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.91 release.
> There are 243 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.91-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


