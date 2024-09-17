Return-Path: <stable+bounces-76576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D25D97AEF5
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 12:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A10280FA1
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 10:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374BC166F17;
	Tue, 17 Sep 2024 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="hdnNHGiJ"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537A1662F4
	for <stable@vger.kernel.org>; Tue, 17 Sep 2024 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569415; cv=none; b=CZi0Qx4y2ZwVgSS+BS/XTyPeAzblY3042BF4nwv8pwBmstS/3p1PL92aIZADKWSPO0hDLINXclWTRPC8mIEJIcV0XlwQ8Ms/HxYP2fYdPpwN5enUA6hPYI3IaQtBmP3ixIFeLqIFXTyYUZ+/GiAM8Z+Pbxz6aB6I6bg2ajSIqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569415; c=relaxed/simple;
	bh=qCfkST9/ft5SsImYPRZVlh+vnAIaaTcFSbz5op8XtxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPpoa3Wj/pnqAMP4rX5fjmu7VXlCbdnou4kIYns8LEd/qKEYTUoy7MpzF2mUZcKL6U9LDl5Ikr8oh1AHFBvXPYDfyNhNhDTCP9G0YrdaUIDh3Xs5u7KlgVUoSDlrUJvPcw7Ec9a4stn6AqK9NjIuHk3I/ObsKMZ2j8tgwXh/XWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=hdnNHGiJ; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726569413;
	bh=gfI6XH1BgBt2Bw02rFX0q5DP7pqI5n4xQBeIPuY+IQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=hdnNHGiJRHBGI+2lhD9EyyXJb6sX5vHhy0/8JN0wmBD+h4o5Eq3nIts2P4uYMG5ZY
	 5I7W7AAroNv3pti3yZg4iDb+eReA+l6lk9J3PxwaM6x0emYaj98lIYqE/9pFYSCCAw
	 /ZSBAE3U7Da3p380d0bOC5URYd9GDsh578myO1Ux8uiur30RZ+f/HnebQSZfhU2BwT
	 17ItAl3AigXHJfF7ZfF9LwAmt7nmfyE9GEVjQbii7yBbRLA8JkR+nMkFknkXTsaLN1
	 lVdpYT/jikWmyNg0u7v2OQqHAa1VdXntOe3w/mHsr9W4co8rXDrsFXcL+lSran7qMC
	 K3dELRJwMHvFA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id 2B254201049B;
	Tue, 17 Sep 2024 10:36:48 +0000 (UTC)
Message-ID: <7478478c-14e0-4760-b018-6bcf282db1b9@icloud.com>
Date: Tue, 17 Sep 2024 18:36:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] list: Remove duplicated and unused macro
 list_for_each_reverse
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
References: <20240917-fix_list-v1-1-8fb8beb41e5d@quicinc.com>
 <2024091752-passivism-donut-ccca@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024091752-passivism-donut-ccca@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Q0VPYEKiAdwPevmrLx0_59b1hg7mo5q_
X-Proofpoint-ORIG-GUID: Q0VPYEKiAdwPevmrLx0_59b1hg7mo5q_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_02,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=815 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409170076

On 2024/9/17 15:49, Greg Kroah-Hartman wrote:
> On Tue, Sep 17, 2024 at 03:28:18PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> Remove macro list_for_each_reverse due to below reasons:
>>
>> - it is same as list_for_each_prev.
>> - it is not used by current kernel tree.
>>
>> Fixes: 8bf0cdfac7f8 ("<linux/list.h>: Introduce the list_for_each_reverse() method")
> 
> Why is this a "Fix:"?
> 

thank you for code review.
Will remove fix tag for next revision and manually loop author of fixes
tag commit.

>> Cc: stable@vger.kernel.org
> 

will remove Cc tag for next revision as well. (^^)

> Why is this for stable?  What does this fix?  Just removing code that no
> one uses doesn't need to be backported, it's just dead, delete it.
> 
> thanks,
> 
> greg k-h


