Return-Path: <stable+bounces-74317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DF6972EAA
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6162F1C2447B
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E94C18DF99;
	Tue, 10 Sep 2024 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="cxYTCWj5"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327B018B49E
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961455; cv=none; b=Xm/38O6A+dEJtRGvU7Hpq22LgmA2QSJy7zDB3rjwHWx/4IRSzkbLLY9dcm2QyqrC/AFdxIwt0esvwTEowAXlrjDk3AIxcmHRn6VnGqGYi6yzxBOPrmdpjwo8wQsgdL8XIOvJqhcTKHXhO9gtKYTqc0JicJgj0ncKxZ3cFdAZKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961455; c=relaxed/simple;
	bh=5Mnw3axJAIwpwRX3D7vDfAt8dGOxLqafot8dnaWq2OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AmMWEAXTJy27HKdbxANoIRtRXyTFxyrAS+hL0N76Y/jJDMgD4KkkA/Z3p81bCLnbCpqCfZDZpD8vPPV3Mf/bIB3g2s4kSJ188kFYnafL5VmTQ7mitvLBSnDL4CNffelaXAgGYjI+T2crgahHJuxBdqxUHh/Ju/OpMaxFNnYD4MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=cxYTCWj5; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1725961419;
	bh=UovoYRmdBX8rwdbB8DvCLFmn2/3FebltkFIJ6+n0WSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=cxYTCWj5MsGdigGDMLrdmfjvYoIVoalWPVGT09IXShVvY+ApNR1KkgtNsN4W9VGKm
	 u8+Wfy18R/wmy7tG0SL3tPTV2agRnl8aKs5zxl9HgxLH6zzgN3ZfmTp+sRTdLELGoZ
	 6doZsc2nz4QPx1MsGv3amXXTU4DzkuM3dD0Ef+Sc=
X-QQ-mid: bizesmtpsz10t1725961410teqnfo
X-QQ-Originating-IP: OFziPhhF4B39nEzGKEEYzSv4NwTeqycvIaR52ke/M/c=
Received: from [10.4.11.213] ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Sep 2024 17:43:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8814383505997166564
Message-ID: <0D03D3D118FBAF5F+abf1276e-4c7d-4c9a-8d6f-278b69022680@uniontech.com>
Date: Tue, 10 Sep 2024 17:43:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y 2/2] iio: adc: ad7124: fix DT configuration parsing
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Dumitru Ceclan <dumitru.ceclan@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <2024090914-province-underdone-1eea@gregkh>
 <20240910090757.649865-1-helugang@uniontech.com>
 <0ACF46DADA3C2900+20240910090757.649865-2-helugang@uniontech.com>
 <2024091053-boundless-blob-20bd@gregkh>
From: HeLuang <helugang@uniontech.com>
In-Reply-To: <2024091053-boundless-blob-20bd@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0



在 2024/9/10 17:23, Greg KH 写道:
> On Tue, Sep 10, 2024 at 05:07:57PM +0800, He Lugang wrote:
>> From: Dumitru Ceclan <mitrutzceclan@gmail.com>
>>
>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> 
> Why is this 2 different addresses?
> 
> And why was this sent twice?
> 
> confused,
> 
> greg k-h
> 

Hi,greg

About the two email addresses because the email address mismatch message 
from the checkpatch.pl,so I just and the signed-off-by one,should we 
just ignore it?

Also pls just pass over the first patch mail because of lack of dependency.

----
Regards,
Lugang

