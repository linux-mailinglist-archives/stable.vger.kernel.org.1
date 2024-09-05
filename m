Return-Path: <stable+bounces-73645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC1396E157
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 19:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD03D1F24CA9
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 17:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A5C143759;
	Thu,  5 Sep 2024 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="EJBqV/h5"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3767013D638;
	Thu,  5 Sep 2024 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725558395; cv=none; b=Xj3CdZSkMV5kGDjPR8xxg+h+nGF1LGJzV5pdZFLnRFPUB4T7SR2GAN/Ux3GbeW8gjOegMg1YWG27B5VrWpbaF0NYv8yP8yKye7fHkWeafmRQ4jlr9pFxebvBqq097VyQOfndePJnAKoc6rnaOGbOALykX2qNpVfAEZ5RiVzO91k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725558395; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=Y7CDZLVQ0AQR+Ae2Q2+yA6tw31e3wFyVeFAB664g0UbQq4n9SDSyEOKystydg6DvjImq+/CKikxvkH8QhU2MI2o5Vac1wr8Aln+ex+Z3qPrpDNbSVTUNJ506wOh7VzhwTJ9r+uCkMvEAYkFXtvMAzGyoD4u+931khpOPuaHHD1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=EJBqV/h5; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1725558389; x=1726163189; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EJBqV/h5JDK5maQ8pKvzwQ/yNtuLeV6dYMAdKQe8R1vaqWkpTl1cxdh6ut++80zP
	 i4Gh8ij7Ew6PpcA/yAGGZah5l2oKGok3iooH8BV0pRcU+r230+I7yoUUHb9uTd85h
	 o8e58wtmXw/T5QDHctHHhktWn4WA3yh/8E7ZZ/wf9/07qvZK+xmhs6y8m0Tz20Hdj
	 VEbduEP7L7SsyI3ZyK0i4jIAibPWvKDTNnPfumw4y4HKKcGTwj6+3c2de1/EYptxD
	 8kz9d1+0+tf3u8/MkRMNHnlWHO3mL4ksSKDw8QfDBhYRK8A++4UPqf4a4zKy4e3tw
	 0W75p7YPV71iplNo4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.85]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGhuU-1srCER24HK-00DsiI; Thu, 05
 Sep 2024 19:46:29 +0200
Message-ID: <ea65f763-16e1-465e-9692-2d6b9d195325@gmx.de>
Date: Thu, 5 Sep 2024 19:46:29 +0200
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
Subject: Re: [PATCH 6.10 000/183] 6.10.9-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7NPajUflbv86u/txGC8CM4hD4lZbKcd6HObp47fvrUuraxSJ1zV
 VPB2k35hQ119XyesZxj83g7MssqnqZ+zBTxe7yydtIgbqBdt9oxR8KkuXP1uqsqprm7PBPH
 LZxbpif5TC8JGQGDDwe3Oz2pSI9rIVF80cvYOV6SQIuIWaME5XthEqumdLVNpl8jCMjsCsX
 MPlEOMlcO9I5HPmFT3grw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FM4D2h8Ftk0=;9//25tw7OP73Lxzx2KMBD4m76Vt
 2kY+qSL/GktuO0fajB07iIyZ8mshgqoefvAgb/GNigb+Twl+mY5m2MUL6F/mAMaZ28YcBz4q+
 IK4/IcKzaL6YSWx4uHUyejShAuDP5nbBEFbktjnBm2wnEBmhpSRURBum7YKwvleIuNyBRwuyo
 yVur+F6kviRCQIcvvPkbjQfOkSR9hdIp2i/BzSKGc4DKEgsEpFSfMN80UTnOmhOItjjOkeCBw
 a5rXHp6x72alQ1z9VOeikHA56PcvkOxzziltLX3XVHQtQstHRK5ojmte5cAinMq5Fkl8RyyZz
 F/AtvX4jZlj6GW+PVv+JIXKKD9zR+z4XEZiIpsoncEaIAmQ8zGr7nQXZc3vnw4/Vln2e+xbBt
 eAxYhx7z9BvoJ8ztmGC2qMzBfYXWTJ1EukzwKe9+wv9cT3yqv0gCBmQMOhMcZuF1A1WfTHW4g
 QAIF/9xDNAn2yG2X3YCllNoWdRLpL/ihJ6GtK6RPCQqjSrRwGB01LTmBXfLqz7sIEMd6Huw0/
 Xi6sMVIs9jk152z4REp9lBAzdRl/oSIBbXZVoKzgGXCFyPKO5eKfsXUOjbMZAtgc9rqBcxMZt
 UGjvMOyP1HtccTiGbn/XBXjDwo2Oon5/FMRxTJzb6PopJgT6EC4C1aXnT/aeg79p0PFU+23jZ
 JVTLrt13dt7gEbrpR/XJDluAUeFEE8szQ6WIsmnu1noAsSads+6chKsKWaDPhINSmA1efL9DX
 IH3Qqq/QK5eq0lo0vSluZEbASAbnPtYe7K82Q0S7NnuerKHlzn04Q7Ct31ukZRSzpyKL0DW8C
 cR8QNRShQLpvftAFmMEsx+QQ==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

