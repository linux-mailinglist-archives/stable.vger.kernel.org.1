Return-Path: <stable+bounces-55783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3119C916DB6
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 18:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A801DB26D77
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 16:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6E316FF33;
	Tue, 25 Jun 2024 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="TfIgoFAP"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C7E14C59C;
	Tue, 25 Jun 2024 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331529; cv=none; b=eCXhvjU7ZAGLFeBxiaBe92UUb9+79T1b32RsW+9vr4YlYs2a8dHEPFK/GoZXsaf9R7BUcd1Ozmvnge+JMD1SenonWd76DAMuqGZSYPDeyP+4yr/pJ2XoNef5CpN3pxtDdv9uV6igXkGzvhNNap/g8ONVl3FMScQhKXlbvMnOCMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331529; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=WdpjYsnNFDeLFaEUEro6Kyu5lw4n+fjX3Bv7i58h/uYT3IzOhOMi+oIJVH9xutnCk79QPeoQ9FFg/mi/8t1oiomeVb28W+QruaeMEbSYcS/AXN214ujpBncNV8bpsvsoQ+1BVMZEv6SBFBVlAe8SBuTtu+hkfCrWZ7vmVHw4k8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=TfIgoFAP; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719331524; x=1719936324; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TfIgoFAPs8t2VTjC+po1H+CkZzIOChEA2SSTo7JAykY/0PWRv2gmaD+tHlsnD/A/
	 JSXgzU+hWcvIdLvNNyrhwZuCPBAxWcPt77mC6g524r2T5ofpSx/CYZlZz6hVFxJ/e
	 RqZdyJ5z917KEvsLdjNtAX7OV2jVemRP3izyUDWEWJ1iQa4Mw7CZACCA3FGZ1zzJz
	 MKGclIICOrcLdXMMEd1xHbgFpqtf3Is0VNVQNNG7WmiTU/SxYplOnB3Kgrc8NxgUt
	 eFan1R8jN9C6Ti4Ln4zlZwxN6+EriQEE5JLIemnLCELgEYiFMyAYPD9+yt5SSLZAn
	 XOB6edqrH9b/s5eu0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.34]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZktZ-1rs5Ct3PTb-00VEHR; Tue, 25
 Jun 2024 18:05:24 +0200
Message-ID: <39ad29ec-6660-4c33-bd4f-78dbf339106a@gmx.de>
Date: Tue, 25 Jun 2024 18:05:24 +0200
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
Subject: Re: [PATCH 6.9 000/250] 6.9.7-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OwEVJlYwa9Gk9YEeFhS5PtCalyvivip8x9VWhVQ+ABN32UK52Ta
 BoTZ6KJA43rwtWGv44SFNrqe8LpV9XE+9Ay+fGLNuXmXUV/wg8ud1VwJ6zAyLJWxAkiZtxo
 5s7SWN2EhnGPDLFl8ZF5AR5TxFif9/nFYjSkW4oZxKRN7pfPlCHHdIzalDZpPd578FxMKPn
 d7fzd/FB+NtGMJ7Q6dLyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wGWV8iSwoug=;tu1ItKfwC9o7Tx/RbvIclCh67m3
 t+pDougS/iFsqA+68SWhQDebalk8BRJM2y/i+XSQVrXPQdyNGmqhu4txt4CEhwrPUikLlovzH
 o/xN1ysDW4GwRM1HDaoXnL3rkTcd+vI6h7JbO0LO0sLyh6nZf6uQF7QZSRI+Wd9AY6U9wDA5N
 KQJKF0o+exe7XSwmy1oHNQ58/448ZCWbqismbQGFtIU4bgynIyuk9yoKs67KAGknXYKcybOy7
 cRlUgi71SgU4m1Z9XQ0DY/WIL17bxMCH62noW4OabDv2NToDCIBy9DoTETkH6GpP553kIQGa3
 IxMVeW19dvCyWaoVdwDJI3YT7xRQ6NXXQmdMMHUIzUMyvGZ4IWkjGRcT/z6+Vs0MPsKDOtAyg
 mGlBs3WCx7QvweS83xisA3a1RZ0hEo3MBkudZIHJqzIBe8Yh0QDB8fhBSyBnTqGb0kWK7FYZY
 bqzUe8R59XcXnJT2hIaQnZLRwueNG4Bv8D1itwFJJunBk/1i8X0TuDGI2NlMxO2nKWUPoNjWN
 zGqLp/2Zbz79qu7cWKPj1TcyMAoB7VFB4ttEt7raYtpJeipSF3vBPUG7fXV+g8XCyxmxMSpeb
 4TnCaz5m6wT6gFEOckOko0q4Faru+KrAvV1d6q04ovd+RX7NznXBhvxt8kny2xOOhF/5MNQMQ
 9sgvTDCL+uFl9sXbxxtjN3sc2GOPGN0NQXD0WC98hBMB8WSCiNZnLZP27oVw6ePzX4xpneABR
 b8i3v4fyqasEzeiEMTp1uOEe1YLmH15T1xvXc+9YB2uD1BWmPIERHZ95et88a0mjni/9pX44W
 vlWV6G/9UYc6fKL4aehmgxgTs2KwgC0LYzxephONk7A7c=

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


