Return-Path: <stable+bounces-25458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6E086BF63
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 04:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB15B23085
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 03:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27707374EF;
	Thu, 29 Feb 2024 03:20:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7878C36AE5
	for <stable@vger.kernel.org>; Thu, 29 Feb 2024 03:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709176808; cv=none; b=b//c7Z3vlbTd01zmc+0YiCafxzXtQvjEzIAPXdUm+nx8LxNnSUfznO4yU5iEOd74qlIt7BHOZIuoBJ6ukUqw8FWmHzT0D58f+ujWjKYEQVFePKlmFNP3BkQFlncGV+gUqWTGwUUSj5/fot/FN0GkHapmXYWurK6ZcEghbchISTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709176808; c=relaxed/simple;
	bh=nWI0xfyfsyOczyWzPno9G0ANgOD4EpWps6XT4tWG26c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JY9feEQz0r6uqYiPnqfCffjSQcS4V1ej9Z3fzWvHdUk0CNNRGOiUsJ8/7is+E4DMJbbg/pPNQmMK6qvVxHqKcE3Oga6fzT2rx8ma+NSh8XlPdmoPxZpp5Dazw60ABiA6EyyJZ8Sntxea5YuEoUwABtwEW8vj6VnGyFAViwVVZn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1709176794-086e2316ed02390001-OJig3u
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id 1NWDjwmQUgYZ1sxI (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 29 Feb 2024 11:19:54 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 29 Feb
 2024 11:19:54 +0800
Received: from [10.29.8.21] (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 29 Feb
 2024 11:19:52 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <0b0eefa5-71b6-dc08-d103-72b9aebd9237@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.8.21
Date: Thu, 29 Feb 2024 19:19:49 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] USB:UAS:return ENODEV when submit urbs fail with
 device not attached.
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH v2] USB:UAS:return ENODEV when submit urbs fail with
 device not attached.
To: Oliver Neukum <oneukum@suse.com>, <stern@rowland.harvard.edu>,
	<gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<usb-storage@lists.one-eyed-alien.net>
CC: <WeitaoWang@zhaoxin.com>, <stable@vger.kernel.org>
References: <20240228111521.3864-1-WeitaoWang-oc@zhaoxin.com>
 <e8c4e8a3-bfc3-463f-afce-b9f600b588b2@suse.com>
 <07e80d55-d766-1781-ffc9-fab9ddcd33e3@zhaoxin.com>
 <49a365a7-199a-42cd-b8d3-86d72fe5bca6@suse.com>
From: "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <49a365a7-199a-42cd-b8d3-86d72fe5bca6@suse.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1709176794
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1699
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: 1.09
X-Barracuda-Spam-Status: No, SCORE=1.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.121467
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 DATE_IN_FUTURE_06_12   Date: is 6 to 12 hours after Received: date
	3.10 DATE_IN_FUTURE_06_12_2 DATE_IN_FUTURE_06_12_2

On 2024/2/28 22:47, Oliver Neukum wrote:

>> I'm not sure I fully understand what your mean.
>> Whether the above code is more reasonable? If not,could you give me some
>> suggestion? Thanks for your help!
> 
> You want to change uas_submit_urbs() to return the reason for
> errors, because -ENODEV needs to be handled differently. That
> is good.
> But why don't you just do
> 
> return err;
> 
> unconditionally? There is no point in using SCSI_MLQUEUE_DEVICE_BUSY

I got it, Thanks. New patch would like this sample:

@@ -562,9 +561,9 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,

  	lockdep_assert_held(&devinfo->lock);
  	if (cmdinfo->state & SUBMIT_STATUS_URB) {
-		urb = uas_submit_sense_urb(cmnd, GFP_ATOMIC);
-		if (!urb)
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+		err = uas_submit_sense_urb(cmnd, GFP_ATOMIC);
+		if (err)
+			return err;
  		cmdinfo->state &= ~SUBMIT_STATUS_URB;
  	}
@@ -582,7 +581,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
  		if (err) {
  			usb_unanchor_urb(cmdinfo->data_in_urb);
  			uas_log_cmd_state(cmnd, "data in submit err", err);
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return err;
  		}

When alloc urb fail in the same function uas_submit_urbs,
whether we should replace SCSI_MLQUEUE_DEVICE_BUSY with generic
error code -ENOMEM? Such like this:

@@ -572,7 +571,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
  		cmdinfo->data_in_urb = uas_alloc_data_urb(devinfo, GFP_ATOMIC,
  							cmnd, DMA_FROM_DEVICE);
  		if (!cmdinfo->data_in_urb)
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return -ENOMEM;
  		cmdinfo->state &= ~ALLOC_DATA_IN_URB;
  	}

Thanks and Best regards,
Weitao

