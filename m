Return-Path: <stable+bounces-118424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFBDA3D913
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 12:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8AC42118F
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927801F3FC1;
	Thu, 20 Feb 2025 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="FKFxTpAn"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8A41F1908;
	Thu, 20 Feb 2025 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051699; cv=none; b=S47brgd9+G7TxI5SgIH+E2u83co6OJ4bbycrIDJaikYsqnjOZNX15IQcccVxzowPt3pPyHt3+Uz2DuAV9k/NEqI8fF5l0uwUwIVedIYo7t0vsIA2AyWZyaiMPR6S77/JHEgAWOKkOIE2/6A/dBBSOP8IEriMFriAj0c8veMIm4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051699; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=CX5dn4WYriPc1hGRExcBL3URGwDGHw+IvCPhatVsMS7tP5bZUANLOOaCHuFcgrudhtNf2SkRCmF4pF78THx183LF2d4WtpJZNz52LsboYNCFXJLLbViO5ad0q+s+EZOKedg7A7CiEY4AI+PaY1YI4BgMEg/LBSirb8jVshuJZzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=FKFxTpAn; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1740051694; x=1740656494; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FKFxTpAnukRQyEk+GC8zx2+Rd/pFU0KUxBJw2dlgcVnWiUYm/lKdosZMKhHdBgjC
	 bwX4Uwaod0vLjJjtb7S7NsYdriDhmOuv+u6QlnjWDwIeHD/2ar+o19ZrT18HZVxmw
	 3ZvQI4/XvbU0ra9eNerBkXo58hWvZB7iHmf/tNl1PUS6s/CAMsjI3xvmzh2nmvohs
	 85D1rqfc4xAeHtAuwOYcmrrYu5Gzsk4GA4M9iLdj8yqMw2WqYmxB7/dR+9buR7o2+
	 x+U3Pf9ao+9oiddwFlEorBmt7plodFG9+oWJcRkqdIzvMAZazef7SqZtBjamJUkAt
	 WB7JI2NWNo6tRyFU8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.33.75]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2O2Q-1tldQW1mgg-00B1Tt; Thu, 20
 Feb 2025 12:41:34 +0100
Message-ID: <a5c4d183-8daf-475e-b66b-7e101e7ac4aa@gmx.de>
Date: Thu, 20 Feb 2025 12:41:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.13 000/258] 6.13.4-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ihtNfLb5I1SGXnn+F0AqGtNh2p5hO/YNMQvYt3b9N1M0rZkJKei
 tW8Ip2vhuaHWApJfiHBLOonYOTZDAfKsapz1xCFuJ18DGfwGfsFl3e4O0bLe6b8CpuoaDZf
 tvYr4WqQXNBe6Wjkx6xluzwxk/+8pgthfgI55TFBoDToVM8m+etwyxIK03ugN9t2s64bGtI
 to/QouyOcDNAc66G+Ns6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HF8JqxsqmuQ=;nZ8DHURBp8HVqy7+p2g/z0DxnQC
 jsM8bdcOhQ22LzTSmNKy98pbTh9G/iqA7725ztmoSwlDqCK3TkcCC0FA1S9L2tTLvE3vJknLd
 7LxtxY1iRcs9X0pCmmKC06MIClgDo2g/K65GqLDWgfY/EhZ68VYVJ11TQdsqvMv/bgih8G5l8
 FghdhclfHmHip7/Wrocry8YGdX07GiVR3SpHXu7EyUQ8z7hY9OK+eHL5igU249XE8+rxEF8rg
 D6u40bmBz0PEkPYxN9p42w9A3apHLDeLDYTAfhjmrMP565hMyA45BKosn+iHBgiC6FnkjTI+5
 bsvZpM+P/YQe34RR1FesicWtXTQ00C9AKgZEuA9Yrdb46lWXtXeZLWHOehW3FwR/KgO7m3MVl
 J4G/lYzR8QhRvhTWbQiZfcpIooqhiqDTujrpQZn+IY2nABGwkrhSMnFR5j2esJ4BxMagYCcsm
 UflbxPRBvFXpZlhJ5rI5R6zt7rgj1YNhevh9PdR8S2xqq2TMZoQ+T3tMTU8RO9L4jzZjlMq+5
 5OBUHcX9I6WT7Bfk0R5QIFpdlJfZ/vxGR1Abv+2Le8Sc+mHZCUU4fBV7OWm/3+7vv3Nfoncwy
 xmtsNwRr36WyVnTMTNPq/oNjWoXULdhW/OW0B/zgjjOUg4oBH5mw3nZH5kr5jyOqXgY9UvVWQ
 a4QW6HlkfyP9LsGyCstPjo5PTHdgvOmm042mpKtlT3XxE831yJdSSwntdz4VIXDCQt4lvBNGY
 XCzhplJjexhR7BJf30D5AroHHASZH4xb3TQvFmFGGFr4IwCGWrGSYR2iIW5WrIGDvSVRGYwBx
 yisIZ1hiRajle5b+qXD9GRsab62l8kYHl3wWT1dVukm3iYNv42349LrnLFBDMbdPl16p0bNAJ
 tYFfqKHC50od/5pMHE0vBXACOpy06Mlux1lypLnQys97jNJUttiP4m0ftaJoJZxunBqjNJfz0
 6ayPWeIsLpFPr0sTiudlYcUetzNAR8yh9fAvVJ439M9s2GWS45rEEo8D/f6niYwhWbv72+9mX
 NgbQbnBfv/h2U1mZqhDHWukSjY/rKvVyH8VpSMNuJrQj3nr7nHHgllhiCzc7m/qtWQDzwJTqm
 YtOZ3ly1j8hm+bGPfYrLCc1HR6h48hpjA+5M4UVgOOXv9Nb6bDLisb6Tl03ATAY5LtxseIwyM
 0BLaE5T/tXuRE0Xaoy/Fqeh/ysxUhE5nX3PEQrUdLkz6N/X/CHSC2DYupqCOYV3X0pTyAnXiU
 rvAl6IKGBqHiIpiLyZ0D0Yi9aqXBrK2pLdiNDdOn58UZ710e2xCUrHGxdw1siaJ9DYBauCVhU
 ObKVpwiTmY4f2Kv2xdVCTYrdzLTujoTJKwYirTQhAZ1gvI1bkMIYVViD5fCLNJXOHSxwavQlm
 VABDMhK2qftMQH05Z/21tXGe+OUTGkDYjLIFPnsbZmFw319yn1iCnXKzcF

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

