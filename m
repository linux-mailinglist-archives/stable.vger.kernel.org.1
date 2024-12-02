Return-Path: <stable+bounces-96112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7309E0856
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 17:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D351640A3
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15664EB50;
	Mon,  2 Dec 2024 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Hc6KYnbg"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD07D3D96D
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154870; cv=none; b=KSvSoV+MYITtL/5PFXttwpHwHXSssImKaShmtEJD3w4f7zkEopZ7ES8cRkBmBna9Zv6+FQpxQ39cuxWvx+cd4nIbCLNuoE2fqFmuJVdv37711DbJ53QCe9PA7FjwKAjtiI+NRnAFlLo9cHfYEwfpVp6PECs3+L+COpNxVRR2RFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154870; c=relaxed/simple;
	bh=Gn04xgzWmyYazGkpEXsn3YtRYZxU244QcdCW7cIEDAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ff4SwTZkECDqAPlFL5GCdooxtvnv06tGreKF4jY2ZcA6mbl6MB9x3s+RhlFVvPVCp6faOdHomcnfZxLqIgy7hxtMkmOMESYDWUrTBKX3pMyXjv5Ux/bV2WNKEPib8NJdZEEyaMVqQQUSgPn1dVNyoV2BmdhwiJkgbJksmxzvgic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Hc6KYnbg; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 5FB2FA0365;
	Mon,  2 Dec 2024 16:54:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=9i3OHHNU6Mu57gDL97RO
	UoDZgWszh2jJBseiglMK1wg=; b=Hc6KYnbgb8gofzlAsTUMzmcacefg475coBkQ
	XHk/e+pqycqNaNX0fymaq2dZFs88gYsGVt4w3EN2KJQ/Hp/0oAUEx60GPh1q8Lnz
	uWfAi14uS2EFSQf31q82C3yC50Wj7LtHM1RpcTt9qXTxIluNCrXc3GyPqppDcwQd
	eXpieGiQzrOoRfxUJWk83j1gblmn1dtW8VqaJhW4INqHQ22YQVqMqZEdQUmUbBa9
	yeHnDspPxMKKR3kzcw7tW+5U8G8Fnmjlvr/6WMm2QGxI5DBeOgLybq5XnLYRUU9w
	MgK639VITpDekOL7EON6GeefDeV8pqA6MUub5uBhddp7p2U2bcuQfAK5plrjnJNW
	q5b/yWRgxyZwib5WgZLXwoIZJA0w5aPgZuwR5ncCx4p7xN8xQ/wZ3Wob6a80gPPv
	t8loNrLm0Zy7V5sjp1BdOnZnfpvZ5/mRnlHciNhzusD6cBgh0WJ9iSpqNaSuVc2U
	rcSjmapUVJvAnMvcoT3eowO2aq3IxeuRV+LoJEu7vk1yvKsMFgAaYbRkxTLb9ofT
	cocNj35NLKWw+6IGef/+NOnu43LYByI0X4TbN84BXwYxcJYuqL+nuC4OgcgHTBK1
	82MwJ3SXpD1Ejb+wUhD0r93A07RJvwKY82hJU7Kw4EFJjeFIK6fHpc0ezbvUkqtc
	3khL5ZE=
Message-ID: <8c2cb40f-c856-4446-9ab3-5bff35845563@prolan.hu>
Date: Mon, 2 Dec 2024 16:54:22 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 v2 1/3] dt-bindings: net: fec: add pps channel
 property
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>
CC: <stable@vger.kernel.org>, Francesco Dolcini
	<francesco.dolcini@toradex.com>, Conor Dooley <conor.dooley@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>
References: <20241202130733.3464870-1-csokas.bence@prolan.hu>
 <20241202130733.3464870-2-csokas.bence@prolan.hu>
 <2024120215-oblong-patient-779d@gregkh>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <2024120215-oblong-patient-779d@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855637261

Hi,

On 2024. 12. 02. 15:21, Greg Kroah-Hartman wrote:
> On Mon, Dec 02, 2024 at 02:07:33PM +0100, Csókás, Bence wrote:
>> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>>
>> Add fsl,pps-channel property to select where to connect the PPS signal.
>> This depends on the internal SoC routing and on the board, for example
>> on the i.MX8 SoC it can be connected to an external pin (using channel 1)
>> or to internal eDMA as DMA request (channel 0).
>>
>> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>
>> (cherry picked from commit 1aa772be0444a2bd06957f6d31865e80e6ae4244)
>> ---
>>   Documentation/devicetree/bindings/net/fsl,fec.yaml | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
> 
> You can't forward patches on without signing off on them :(
> 
> Please read the kernel documentation for what signed-off-by means and
> then redo these patch series.
> 
> thanks,
> 
> greg k-h
> 

I did that for the 6.6 series and Sasha's bot complained that there was 
an author mismatch... I'll re-send it yet again, but the bot should 
probably squelch that if it is the desired operation...

Bence


