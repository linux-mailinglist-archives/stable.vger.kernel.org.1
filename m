Return-Path: <stable+bounces-132020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2CDA83591
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 03:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E27C173384
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 01:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374FB185B72;
	Thu, 10 Apr 2025 01:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="v09QVbDC"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-hyfv10021501.me.com (pv50p00im-hyfv10021501.me.com [17.58.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DA959B71
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 01:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247889; cv=none; b=e9aWtvlrFc3NtUsBTLSlPqeXzkCyFJUn8LPQagd7yXfxhnp1cG8B44n7wuM6/X7hv9wLKuCPK8ZowrQbU7x5kqY5kgMH0YSsIqDoa+DEIQKofPNAl/uZYxQuClcYr0foMEQVwYx/0GVLxgCLs5hO4myP6PqVObbqz47aSaHQ0C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247889; c=relaxed/simple;
	bh=L0sLWjj/luVXtpTiBCBVPxJ1t4EFPXdlyg8sQAf/k0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BFrqAoAI7yvsMPT0qk7f1HPvdW/pcHQMSqtj42v1zJoqD4f91clGeQsUOFctCMUwHA7sT4HeYlYVN518upFUqh1hnfFI9qq7oJcl8a8NdMZIDYY5usAeBMGDPQ/GLaRYtwMGanag30jPzK5P5TiQyh4UM/cPhKpmf00KphXHZMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=v09QVbDC; arc=none smtp.client-ip=17.58.6.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=kBEyT3qDEPt8tYTpXkrYGSKfX4WjFrjtoXeB5/GCzVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=v09QVbDCLtVWFhV2mlOSkTWwOjHCbc9U+wux4BLXxw05nbsRVazQyqSp3hH2aMdCI
	 +GmIcyVcnj9eEhsd85mLjQbtCqvjWzHKkxBtLKSlxdAlhtCuEUYxmzJ6/ZNlZx5fBb
	 9Fd4ye2XAIrLUMjmyVlnpGGTLGubBE6Of5P1DV4UhcRo3JBU7svlIA/lMLc8vpWqqG
	 HeFdtA28xVQBy7uESmmNnXPA4du/BN0F3s4xHTguOYfP4wPnHXuUsJBrbubG0uClP4
	 xMRbyHSLddSf7OP0PGQ4sbQMN19cig81F/9GWhbRil6wKu+WM/VjpmJynx8YmeqOqa
	 Eph22GTTvSuVw==
Received: from pv50p00im-hyfv10021501.me.com (pv50p00im-hyfv10021501.me.com [17.58.6.48])
	by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPS id 666042C02D7;
	Thu, 10 Apr 2025 01:18:02 +0000 (UTC)
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id DB1E82C0304;
	Thu, 10 Apr 2025 01:18:00 +0000 (UTC)
Message-ID: <79206e66-f683-4733-894d-36e197cdde9a@icloud.com>
Date: Thu, 10 Apr 2025 09:17:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] configfs: Correct condition for returning -EEXIST in
 configfs_symlink()
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
References: <20250408-fix_configfs-v1-0-5a4c88805df7@quicinc.com>
 <20250408-fix_configfs-v1-4-5a4c88805df7@quicinc.com>
 <Z_Wn978o-kwscN29@google.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <Z_Wn978o-kwscN29@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: P540-XJaRz2ioCjGwMVRgiiLj6QpVStw
X-Proofpoint-GUID: P540-XJaRz2ioCjGwMVRgiiLj6QpVStw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=954 mlxscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504100008

On 2025/4/9 06:49, Joel Becker wrote:
>> configfs_symlink() returns -EEXIST under condition d_unhashed(), but the
>> condition often means the dentry does not exist.
>>
>> Fix by changing the condition to !d_unhashed().
> I don't think this is quite right.
> 

agree.

> viro put this together in 351e5d869e5ac, which was a while ago.  Read
> his comment on 351e5d869e5ac.  Because I unlock the parent directory to
> look up the target, we can't trust our symlink dentry hasn't been
> changed underneath us.
> 
> * If there is now dentry->d_inode, some other inode has been put here.
>   -EEXIST.
> * If the dentry was unhashed, somehow the dentry we are creating was
>   removed from the dcache, and adding things to our dentry will at best
>   go nowhere, and at worst dangle in space.  I'm pretty sure viro
>   returns -EEXIST because if this dentry is unhashed, some *other*
>   dentry has entered the dcache in its place (another file type,
>   perhaps).
> 
> If you instead check for !d_unhashed(), you're discovering our candidate
> dentry is still live in the dcache, which is what we expect and want.
> 
> How did you identify this as a problem?  Perhaps we need a more nuanced

for current condition to return -EEXIST, if hit d_unhashed(dentry), that
means that "if ((dentry->d_inode == NULL) && d_unhashed(dentry)) return
-EEXIST" which looks weird and not right as well.

> check than d_unhashed() these days (for example, d_is_positive/negative
> didn't exist back then).
> 

any suggestions about how to correct the condition to return -EEXIST ?

> Thanks,
> Joel
> 
> PS: I enjoyed the trip down memory lane to Al reaming me quite
>     thoroughly for this API.


