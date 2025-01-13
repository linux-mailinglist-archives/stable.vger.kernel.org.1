Return-Path: <stable+bounces-108455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941BAA0BBA3
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 16:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90EAA3AD0FC
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 15:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2638624024A;
	Mon, 13 Jan 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="WputRv7T"
X-Original-To: stable@vger.kernel.org
Received: from st43p00im-zteg10062001.me.com (st43p00im-zteg10062001.me.com [17.58.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93169240241
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736781074; cv=none; b=jrCIbgspI5becPkU7FKu6e11UJPEMV82uqIUzVXHj9P0d4t/VLZ1KnYxlbBQLI0b/mibRd0pdO+87PmeWZ+ZGhPzSV64Uy8/nzJcwsEjzuDynWMSEA9Mt/bFk9g8Lta82VBUNM5jijG/ha5N+b4RkvySrNMfulao7EhCHlclbFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736781074; c=relaxed/simple;
	bh=yYzrh5wCDXxfjt+1CKLpQnIzD/XZVkY6CwxJPFXmtn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snub6bbc2xZ+CpUPiJnNn7GxHjRGOsjtCfAxaZ4opb8BtYaxV8dukEBJl0OTiR/c+cajHInmHgFcjKzE+DNQBX1iNbWAl+H/1rknfR+dGJ8VY/c7kmPsx0Wl02Dc7xAyhjIIwpuETdKgsqvGlEXsHRnExyGQQKphzbWqwNllkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=WputRv7T; arc=none smtp.client-ip=17.58.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736781072;
	bh=3Zh1zMMmj4RITk7hWjVu604ZyUylQIpg+gvEOXzfuvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=WputRv7TcD40E/SXrrZxUWGWVfbWmGvug09UxE1wjro82MJzcYIqXQpsuA0L1mvwl
	 iWw2IQG5hnbOzWBtleN+BaTmzkt3TUcjgq1AikY+sHO/qm9oTSf6l6E68dKIm1K70J
	 DNwKacfFDeey/X7CK0Mityj3zBkJNU7iVgBqN1DK8tekEBrV3yPdprBKDoi1EEQDCt
	 DfJky5sbwJKMMAiLdsIFVhImSolDIWFENDpWvV2mhfxGwa/ESPyhpqgxv2V5gtxIzU
	 LfkeoIIecm1OD1NJmdikxnBaX3IEymaz4/kEpNOiFhlsHFYGVwW1oBZJea9ZBW+PDE
	 Jgimaf3ObBUMw==
Received: from [192.168.1.26] (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-zteg10062001.me.com (Postfix) with ESMTPSA id 5AA3EC8048B;
	Mon, 13 Jan 2025 15:11:06 +0000 (UTC)
Message-ID: <63830aad-161b-4b9a-81ce-1437f66f70a7@icloud.com>
Date: Mon, 13 Jan 2025 23:11:00 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: qca: Fix poor RF performance for WCN6855
To: Johan Hovold <johan@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Steev Klimaszewski <steev@kali.org>, Bjorn Andersson <bjorande@quicinc.com>,
 "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
 Cheng Jiang <quic_chejiang@quicinc.com>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
References: <20250113-wcn6855_fix-v3-1-eeb8b0e19ef4@quicinc.com>
 <Z4UrYZgYqlTfFc7M@hovoldconsulting.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <Z4UrYZgYqlTfFc7M@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qxS9jix90f4UEulPCUcoNPf73XM99Fef
X-Proofpoint-GUID: qxS9jix90f4UEulPCUcoNPf73XM99Fef
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_05,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501130127

On 2025/1/13 23:04, Johan Hovold wrote:
>> ---
>> Changes in v3:
>> - Rework over tip of bluetooth-next tree.
>> - Remove both Reviewed-by and Tested-by tags.
>> - Link to v2: https://lore.kernel.org/r/20241116-x13s_wcn6855_fix-v2-1-c08c298d5fbf@quicinc.com
> Thanks for the quick update.
> 
> I'm fine with dropping the fallback logic, but you should have mentioned
> that here.
> 

the fallback logic is still reserved.

look at drivers/bluetooth/btqca.c:qca_download_firmware() changes
introduce by:
Commit: ad3f4635a796 ("Bluetooth: qca: Update firmware-name to support
board specific nvm")

> This still works fine on X13s and sc8280xp crd (hpnv21g.b8c and
> hpnv20.b8c):
> 
> Tested-by: Johan Hovold <johan+linaro@kernel.org>


