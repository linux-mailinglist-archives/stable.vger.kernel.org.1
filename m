Return-Path: <stable+bounces-61213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBB893A7D4
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 21:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECFB9B22EC2
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 19:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5281422CA;
	Tue, 23 Jul 2024 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="AIOK8SgF"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602C11419A9;
	Tue, 23 Jul 2024 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721764504; cv=none; b=iKI/QQhzbSqrJKcRf7ml5e+iFy575upsXXmzgWtiFDC1Sc337pMWD66/EGwOpY2MJF1nK+ZFeVB8kGxk+UOjDTfoqClLnNXxp9GuJmF4udBzS6kT+bXST0toLJlV6GyHnTLGJsJuLINkRN8GoYoHkNolr6arof480EIGfq0zLAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721764504; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=MfdnIaOWjZbtwyg73Ms1Bt8sqr1mRvwyKG3rhoxB2oUg9qfXWDLWZpzjgSpgg3AaCm+AbTPugVrceXKUBrHpQTUjASb7uT75Qi/BKwzEt8Pw8O2Falq6O7mqZUz4KMmoHf/DxtXRVnOV3d7ihGbNYMrPC74ym9zX/yAQ3Qe9Luo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=AIOK8SgF; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721764498; x=1722369298; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AIOK8SgFk9loJcfLA7HSlKoJPTdGwZ1FfQsSmno2BqIzV6tNH1Lf8k1PaP2pFeXq
	 vOznWp0cp5NfKWGdbHd9WctGH/HqRLM0JpMjI8c4/h9SYaoA0+1jY6tyNfs/lTeGm
	 tTVc2t81G/KNskZgyL18C0jxZJ6H9uIv5oRGU36uniwDwkDl6yC1Xo0ZKMe/06a/x
	 tXwC7SzGa5ZVngehNPb/HqO3yO8kCzO63zg7+W+lmF0aOi3JRQzH5GIduYSVV+KAv
	 qKg+zwFgmNW3CTt/V4Xwwhec9gQKSonX/B1NcaIrNQRPEi9iH+tyWRdGI9vbVDhmi
	 pImmHHFJpbpkqTASKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.104]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MysVs-1sJv2u1PlK-00uWCD; Tue, 23
 Jul 2024 21:54:58 +0200
Message-ID: <15b4b25e-e952-4757-8b65-4a085b5b061f@gmx.de>
Date: Tue, 23 Jul 2024 21:54:57 +0200
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
Subject: Re: [PATCH 6.9 000/163] 6.9.11-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0DPSdAaPyNYDGZBN9MRUNU035Rl5TIEDoxaSPaCMEY5274ZDurH
 KykQ6YNvGDLMI3M7JfwH2nsp7U94NgFxNSANMefPm+rDCqYRzI1RQpG7hXOQKHHGebNIurb
 vHmHY5gGae1buVkcoJAAew+0jxIhlQ1eZ2XD5vh7wRNFdhMrSi6gR5cNphw/SPDWvlWQeZU
 AhI0DAOiiTOztIDPktDsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9WZZ/NSvjyg=;6iTAzxuprrdMT6H/kuVtMTUl79q
 32nY5cFjrKeBOAoDp4LE6kGAyjafwsQiAzK0NO1ZQ7uCNceqxqS8ZNOGqnW6iRWDaEqx0ZPC+
 fzFARNp+08J8eigfF/oQ8ZavoN6+c58o9uWVfaTgqnx73iReRYaOIrzW1hsKQtU6OAWA9Hcpj
 o/4pDbi9YZ8Lb4Dkk+MXduOW5ZDKtMgIDdK86STxV4AUftwr1TZlNAR9AkIR7SJ3dE9AwVlFv
 52YauWKn9P8rdRMKgnQ+7aAHH2SXFAUJsj2stfGgJu1yuuyf8roUQrCmCvPBOUdDS+0IEZzuO
 SnMT2ikzApWemyl+qdwzSMvGvCeO+6jtcGgXEY6Zn3IpAGxveCnWXAXLESxY/hYJWtDl6XeuU
 x8YzLwdHQRKy87AUrpzFjYv/RQJcFmduajVRGPpRnRyTSBejS4W4y53h97fq+/G315INHQs5+
 J3kOVC024kcJY6S0WwJxbNzpKk0MpC03xQNwHLH9NYT/xMNY9e86T/nz/WjWczhTNC5fDyMmu
 1apJ60A6i1rfqUVSx7TVJcRJggDDPgyjBiNUc40yyJ/LsswdCxcr9G0ywXd3xn83TNnEe/lCu
 tp2HqeqwPUIZATqSet6j5yIWXtIMT7CGhUcUbfcRJEBdHdsc1RXoc4cUrAou3YQXSLeW4fqWZ
 mwTOGFqj0XTdn1PcTuVJUKZDwkQkhR9yHDK/sxUaTdaZr/OxNPfhUDcZmfbebRzl0rrW6DhCS
 GuIiCYglxrv/e3CQEx/YqHkDVrUc7Ne2rnvEsicdQSZf4bojvdnq5Ib8rOIYvVmQcGbmefFHF
 Ay5bF3rMW2TGjbrCNFoB5KsQ==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


