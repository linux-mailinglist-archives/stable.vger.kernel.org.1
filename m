Return-Path: <stable+bounces-108456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1FDA0BB9C
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 16:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 171FE7A5558
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 15:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C61124024B;
	Mon, 13 Jan 2025 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="xJtlKj+C"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10021201.me.com (pv50p00im-ztdg10021201.me.com [17.58.6.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AAB240252
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736781337; cv=none; b=b8kiw0ifMpynUb3+Wh7cfk+7WdPnveS8dqDQAANUA5lQwloIrx2YpzoBXAdO71RmxX5AMTUETUYbLmnLw2Cgc9pu0f87vCuyGu7Oym5rAkdZEpQG62X3m/99s6I8jm3NAakic9sJEvL6TW+gSCVqEufMBJA81UqRMPKnuutPbJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736781337; c=relaxed/simple;
	bh=MrIXePv+PltB2pqQMlGKJDMwQVhUguxK/ZXfvC255kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MwGqlxzQhGIIG4tCNu8OPorDvSI8JeiOrHC3jLrY+FaeMk+DYbsiJhwH/fFk13XHNcCn92S4djQBzuejQgkbiKhnObUF45RK7/rogAmrdboXDieQMG+eL5HArKkcsACzx8Z0cI/PhyDfUdfh4WNAgRZct3woaAR13DH8wGfoLvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=xJtlKj+C; arc=none smtp.client-ip=17.58.6.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736781335;
	bh=2V6tFmBi8NvcRm4JpWLiNsx86CvlStNDM8wUbIBGTos=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=xJtlKj+CgfV77qkFa5fyTaa9Iq6D9fGb4Fdk+3yZf8tCpAfvTzcOYspKAiQ7spFJx
	 1DmI2rr3E9GMdPEQTyoFaqrU54eUpNpl+5WBsA4RoLIPQNs1xQUlxGBHKXiUBhZNIG
	 4w4PDN8FklXeVEFzXg7Q7HF+z9YqNv9/2/aGhHi9NfqHmdf2A8Dy75C3wswxnMAlHf
	 L+9B7VJ5eSn8WXX71t8/9dhYVaXiTyGToiC2Nmdm5KDWcE4DFEjVI4yVwGNazjulbq
	 7xKifFU0Sbw5wf8aBFw01EWvyVXwUgH1qAOgJbhrSmYNIl+KccFjrDi1bKPs+7KDkL
	 bJjd50cQbRuJg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPSA id 2EA5B3118D88;
	Mon, 13 Jan 2025 15:15:28 +0000 (UTC)
Message-ID: <dcc54536-87c0-49d4-ad6f-c47abf102136@icloud.com>
Date: Mon, 13 Jan 2025 23:15:13 +0800
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
X-Proofpoint-ORIG-GUID: YRWF4Q3e8gFAsu7A4M8NcPMML3dS59SC
X-Proofpoint-GUID: YRWF4Q3e8gFAsu7A4M8NcPMML3dS59SC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_05,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=767
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501130128

On 2025/1/13 23:04, Johan Hovold wrote:
>>  		case QCA_WCN6855:
>> -			snprintf(config.fwname, sizeof(config.fwname),
>> -				 "qca/hpnv%02x.bin", rom_ver);
>> +			qca_read_fw_board_id(hdev, &boardid);
> For consistency, this should probably have been handled by amending the
> conditional above the switch:
> 
> 	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850)
> 		qca_read_fw_board_id(hdev, &boardid);
> 
sorry for that not notice this comments.

qca_read_fw_board_id() may be invoked twice if adding reading board ID here

see below branch:

	config.type = TLV_TYPE_NVM;
	if (firmware_name) {
		/* The firmware name has an extension, use it directly */
		if (qca_filename_has_extension(firmware_name)) {
			snprintf(config.fwname, sizeof(config.fwname), "qca/%s", firmware_name);
		} else {
			*qca_read_fw_board_id(hdev, &boardid);*
			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
				 firmware_name, soc_type, ver, 0, boardid);
		}

> but long term that should probably be moved into
> qca_get_nvm_name_by_board() to avoid sprinkling conditionals all over
> the driver.
> 
> I'm fine with this as a stop gap unless you want to move the call to the
> QCA2066/WCN7850 conditional:
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>


