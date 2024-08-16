Return-Path: <stable+bounces-69319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B11439547F9
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 13:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4C41C223E2
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 11:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6BB1ABEC1;
	Fri, 16 Aug 2024 11:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="mWR+/P3h"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C181A01BF;
	Fri, 16 Aug 2024 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723807332; cv=none; b=QrRNwFU6thUJTpaXqGfF93VdOn1eLqxA5Fe3+DO1HIMvUD/OE99LAUoqCrDDVtr52tejEWBcXG1NcdPsgLgjRXvLSi8gpxb+w80WEZ0F9y+2YqvaRkTlHIxiSXCUfvpU2St822krGrIyPVKUtR5FEBOVJUvBr4e7whOzjLUGdX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723807332; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=XlTT1P+yXwPSPhfqeJ/cjsM7hZuGsLRpVFKjlr+kfoHwiRigPZc6P+g7vPsAVWc4PpgW6o3NOsB7/0yAKsnXyBSfL1veJJFVg2DwdQtUllu5Spfq+So07cxxQ6WLPkmp/ECRudp2n/rohcM74V07ktxiysu5vc7eIhboCZRWqmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=mWR+/P3h; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1723807327; x=1724412127; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mWR+/P3h3KkQWC0tsRz+duZbupZ+kGciu0Ljaf39rsBj1mJal7cY3fg6J4BIfn4Q
	 rbhHoDPeOif7p/iz7N7VvBs1PH7jKN3ak9w7ecwjr0/Ov6VbY5ydlCxZUSFDKffst
	 RfCBFNGoVs4XfU4Q3zBfn/1pNWa5tnpMB5+kYodUUJT7Kvf2V85rR1Lay2pDqr7Ml
	 OCSNjSGe0CQENjM7SEQB18DRIOynK3afHan5lnXETWkkfmj6DwYgS1u/jvLc3t4Aq
	 f8J/Tanhik/3FSsx6ymoFfP69RyDxv6qD9Z73SU+nVPkd73yBUbVbRCcLz22RX1/X
	 oUMopOaACssARu1mIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAOJP-1sT4Gi1rMB-00EsoO; Fri, 16
 Aug 2024 13:22:07 +0200
Message-ID: <d31fd9b7-a6f7-4f5f-b027-18c579338e8a@gmx.de>
Date: Fri, 16 Aug 2024 13:22:07 +0200
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
Subject: Re: [PATCH 6.10 00/25] 6.10.6-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JSzKh2vc6pvp5mCzQVdIjmBELdAlOg86oePh08pYg6qYtKr9VXd
 vkFydTjF7Yo8RLViGyZrgq/QO3V80OU6fZV8i3gRgEs35NWGoi4HXwyccGvNadii8HHrf58
 lnpV9UmQr7LA2Nl9RsjvBwaxPOuTpz3barFEQzVTI1Oyg4E95nq2saSn0+B1cG1GF6wOzD3
 ZzCPchVHDj0Tq70i8+ikQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IknEuiCgyps=;+shoyq5JfnDq0Qd78b515MO78oU
 iqXRQIj499u9VZh6IE3+4AIDtoyKs4DZZ2WJRWzxxpB0+uReNPfRKAIYJ32WGiEfu7CBwtK4x
 vIsUgzDqBMCSD6NfnzB8C79P8yL44FB/9xH8y6Ck/i/6Boi+myX4ykn/2Ig6Wcbb+3Mfk4uKB
 PdIxNWgqQ9KUH1iwqefQVKihF8FnmElMhOT7x3kDa2SzeQ/5zqCRPn0pfCY/HbwNilo75o1Km
 2ZQx0n7Qs33u9QwOwIm7AycFQhsN+PcKKatjioT8Ydttwm9l3JlmitiT3OwQpzb7ut6sFPWiC
 sj5SH2WOjsAozZWkti89Q3g5MYnfOzTMRsI13d1gRCOMG8l28n88R5m0onEUEBXKTKRI8kEl/
 55zzSn3De2WtfjQ2/8UWInqVe3uWrfwzmsXBNvWHWvvU5K2MtZdZC8BP7rUO/MW2jpxmVN5IA
 K5TjG/QaYyU8TyL9RMf4W8v9hnLgOea0ey43qqOJfLRxur/Iyp29nOfjIEJ/dXctaByC8TnzG
 baWTHkgs4Mguqu/cBSZEEbNnsOiRfYVMNPIVhIfT7rrLpiJ/EuA3dsDeZvtmTPoGr+xFQaTci
 CfMWak4g0fIgilWIuIJq4St2Q9CS5wKb8jXIOAhs2sqe54eA4VjvMjuBm953tw8TlOFQBWqNz
 Z43yuHAePC7rgr8S7KbD/6wBoeFZG6dfjaEGwsh0uK1VrjfOjHYfbcCrvrhyK/zdq8oHzGwRc
 hOUqdCGIX7vqs8vgHP7L1OFbKwOMZ2t5TnrkS6wJso+aojsmWXJ96v+y5z9bX2E/BF9dcBvFn
 oYGx8hBGgxdn0zvlzNCNOq/w==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

