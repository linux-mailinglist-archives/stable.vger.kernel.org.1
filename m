Return-Path: <stable+bounces-73027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE9496BA88
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A17C281383
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB1C1D588F;
	Wed,  4 Sep 2024 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="RyraMryO"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10012101.me.com (pv50p00im-ztdg10012101.me.com [17.58.6.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1921D04AF
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449017; cv=none; b=cb+vCB4HXYZd83Ot/hzZw1zK4RwLJE5TgXGYERFiSk55Ws8KkWuxE5Iwj7Sh9pJQ2yXTWd1OTh6J9wtyHgaVzW3sdrHDm5CWNpAycF1BJYxyV3Ai93EMRtZIIDNfX0TKXeaRxzBTbDBYtETHKKnqcRh8UFR3LOWDaN/XZ9rb8xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449017; c=relaxed/simple;
	bh=hfiJmse3dy7/RukxHr3TKj57lOw+URgRbGy5V4q1aDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6OMLX7LGIr3YqDeoXG76btdtJvRJghKvClkMHYfb7vcFZnK9G/vlmldSMwaMk8EQulSHEBjsz7LO87Mh6ebgsR5WntVo33o/PXbnlu/+kv47ChcgEmjSViSUUpVi5lNf2l1rM/ZfhHXo1EsyHu55qLhuA25Tfkk/HRIS7QGxXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=RyraMryO; arc=none smtp.client-ip=17.58.6.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725449015;
	bh=FBGnX7lkEFVsmCkqd26xnasYVdZEstE51WAqZGUTDIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=RyraMryOLk8mJUIizeL4TJGcpIxk5BnP4T9EiSJoRoZrrcUrJiSxZg97F8gKFXGex
	 f4TMT+UwveyHgu0p2P3UrnqjFwhkPFlUzqx4NRkXJsqR9z+J1IryTkimuWvDBizMjo
	 5YAThoze4MzrTHlncmuNTc+DwhfLJL4ta2ZW7alXeKA7614mJKBS6JLAY08oVKnfqg
	 NVSuouh64BN3mRzZk9upU4qj6XDSltB2AZQUNflbqcz0x2qB5C/oEQ5AE4C54Yuq2K
	 rVTjs2cIJ47GgJg22YwFxpqBbgCJG6f3N149yaN82xx5fcmsvaKoEyqRLTp/uVN8Lo
	 L+Ycltb4cfc5A==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012101.me.com (Postfix) with ESMTPSA id 9B397740330;
	Wed,  4 Sep 2024 11:23:30 +0000 (UTC)
Message-ID: <023af837-e58d-4b12-ae9a-1bb7823b09c8@icloud.com>
Date: Wed, 4 Sep 2024 19:23:16 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] driver core: bus: Correct return value for storing
 bus attribute drivers_probe
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
References: <20240826-fix_drivers_probe-v1-1-be511b0d54c5@quicinc.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20240826-fix_drivers_probe-v1-1-be511b0d54c5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: RO9et5Jya6sEglU93wPBjutM8c7ULmhy
X-Proofpoint-ORIG-GUID: RO9et5Jya6sEglU93wPBjutM8c7ULmhy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_09,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2409040086

On 2024/8/26 20:23, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> drivers_probe_store() regards bus_rescan_devices_helper()'s returned
> value 0 as success when find driver for a single device user specify
> that is wrong since the following 3 failed cases also return 0:
> 
> (1) the device is dead
> (2) bus fails to match() the device with any its driver
> (3) bus fails to probe() the device with any its driver
> 
> Fixed by only regarding successfully attaching the device to a driver
> as success.
> 
> Fixes: b8c5cec23d5c ("Driver core: udev triggered device-<>driver binding")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/base/bus.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index abf090ace833..0a994e63785c 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -40,6 +40,20 @@ static struct kset *bus_kset;
>  	struct driver_attribute driver_attr_##_name =		\
>  		__ATTR_IGNORE_LOCKDEP(_name, _mode, _show, _store)
>  
> +/* Bus rescans drivers for a single device */
> +static int __must_check bus_rescan_single_device(struct device *dev)
> +{
> +	int ret;
> +
> +	if (dev->parent && dev->bus->need_parent_lock)
> +		device_lock(dev->parent);
> +	ret = device_attach(dev);
> +	if (dev->parent && dev->bus->need_parent_lock)
> +		device_unlock(dev->parent);
> +
> +	return ret;
> +}
> +
>  static int __must_check bus_rescan_devices_helper(struct device *dev,
>  						void *data);
>  
> @@ -311,12 +325,19 @@ static ssize_t drivers_probe_store(const struct bus_type *bus,
>  {
>  	struct device *dev;
>  	int err = -EINVAL;
> +	int res;
>  
>  	dev = bus_find_device_by_name(bus, NULL, buf);
>  	if (!dev)
>  		return -ENODEV;
> -	if (bus_rescan_devices_helper(dev, NULL) == 0)
> +
> +	res = bus_rescan_single_device(dev);
> +	/* Propagate error code upwards as far as possible */
> +	if (res < 0)
> +		err = res;
> +	else if (res == 1)
>  		err = count;
> +
>  	put_device(dev);
>  	return err;
>  }
> 

please ignore RFC for this patch, will push it within a patch
series.

thanks
> ---
> base-commit: 888f67e621dda5c2804a696524e28d0ca4cf0a80
> change-id: 20240826-fix_drivers_probe-88c6a2cc1899
> 
> Best regards,


