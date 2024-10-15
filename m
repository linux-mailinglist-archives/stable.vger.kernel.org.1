Return-Path: <stable+bounces-85095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F5699DE98
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 08:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A473F1F21C6F
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 06:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECC718A6CC;
	Tue, 15 Oct 2024 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="gqCoRWnB"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB9189BBF
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 06:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728974486; cv=none; b=XnB2nhopH6VEdyx6Y9ibYLoZq3AheClOVG1+allLeViyB16o0XFPOodadbt839c7G8ridn1GLPaDSaBqyqBX1f9FfPqMoEmCqE4nx1KTUV1uHA/fAUFumQ2rP50lIURvNuDTjcC343/k7bbMX/UWrjO4T72WdRAckftgJprs78U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728974486; c=relaxed/simple;
	bh=aRjq5JD6dVfYh9IBLDvsSL0I1KRfWiU/aP2xCr6Z56w=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=cDXA95WM26dYQcU01B6ju4PhcNYk9fDbTcirnd5+d3KM+4g7WMA604J8lE4blzRPM9qJH+TI5aC8Y9reLrLnZinnr3+oJxDrGa/eBOrLJz+r6XtwTG/2h1xwfQYZDWMv/CYDXmDCh1Y1HParDptw7o6vzf/7diP61EYUdiR6iR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=gqCoRWnB; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 31363A051F;
	Tue, 15 Oct 2024 08:41:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=p8e+8ab+baPymbmXz7QVRVtyy9vyn1yJUtoQkx2g4Zk=; b=
	gqCoRWnBt6tTK779wpt7OzHf0ssorfkDRehUz3yCCWpBieH6a8QatI2dDRvh5PHz
	qrmdUgeRD230WavD6yVGxL7wbqJZd8VKxPyNKLcE61aydghONMAHDx5aTH3OZWRA
	M9083nJkewEjjmx67t3eSsZ48P44RNV4tjSpzqE8HefWZi3+S2I9YMKONMAxiV20
	zoLX7ztFStElHDZIDARNVZagUBrCgNHe3jsa160q7ZJigRpKsqU60DBWYQ2CMkin
	BGyy3suujdYHcvzfd69chYI24AqJ7G0r2PFLBSpSrC3D+p4bNVjL3zvCL7GcVg/4
	qXPBw1c8FqAK8BtS3bMwu/A98avQC9Q5QPtz50JA6gNIYuFW464Pyo/kw4Kor0K9
	IQTIDBJnNgEDlZSgsTouf2cQkxmbVLnSp//xtyvPku6l9pXMWiRChRPAAJQDPHE8
	/0umpOPASii3jXsMvnf6U4GITvq6g+2aO9w4UyUQktQAeHme156CO6++uPb5C+Ns
	cAirb7Qc4lC4U/7i2YZqkdRjv6j21m7PbaF3A3DQxXS1ZTXlegSZgTV4BMGe9KDF
	gJh1of1yGZZXLfQ1KRi6RTlMxdqkFYtY8JwCMeqZIFskYAPji+o7ckPoCX/wm5bk
	TFsRDo5hRfqsYsTrqqyxGUD9cjhWD1Nb4JAc3EPxNf8=
Message-ID: <e437a6ba-292d-4a0e-8e81-074c84045b26@prolan.hu>
Date: Tue, 15 Oct 2024 08:41:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <stable@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
Subject: [REQUEST] net: fec: Not yet ported PTP patches
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855647065

Hi!

The following upstream commits have not been queued for stable due to 
missing `Fixes:` tags, but are strongly recommended for correct PTP 
operation on the i.MX 6 SoC family, please pick them. Our first priority 
would be 6.6, the last LTS, but obviously all stable versions would benefit.

* 4374a1fe580a ("net: fec: Move `fec_ptp_read()` to the top of the file")
* 713ebaed68d8 ("net: fec: Remove duplicated code")
* bf8ca67e2167 [tree: net-next] ("net: fec: refactor PPS channel 
configuration")

Bence


