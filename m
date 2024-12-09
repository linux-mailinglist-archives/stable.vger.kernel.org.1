Return-Path: <stable+bounces-100180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5E79E96ED
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4AB1283133
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 13:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A734B23313F;
	Mon,  9 Dec 2024 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="waLb87vr"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24426233159
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751113; cv=none; b=kgUI4KTpg314BP59P/rzOOuKZqRIpw2hBtW5AzZSlHpaGLYQsOpnj4SOKA/KB+vrINH9yDx/wI9rLDQAJul3dYUjSngO10QZbTNikAHHzuyX7Cpf0tCuYXo4iwE2svA2bbA8daOYPuVjD8Z2CJBxRoMWFgx0EbEDYHg8BrrXLFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751113; c=relaxed/simple;
	bh=El/wr9Ta3ApQw+PvEw7H3w6sJeAN0lSE1EQ+VbMkzqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NiL6hgLsWhQLTpr72ysP880HrAvxIAm+xR5H0qt6ATOP5KkbUcTZbVHv6HUfDGo0d4LYIYxEZg+QzTqhuJmrjwmSf3oC/JkPnyAgbADGi3pPz/WjjS7RLv50hJlY6dzs6mkroFWm2MkpexrSoh7BumFo6MYLL6k6Fw0rkxcDM5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=waLb87vr; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733751111;
	bh=tUv/yFFQ6zZdPdRgc4vW/Me53Bsusj+0dw280df3j9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=waLb87vrYBWTOA7QhavjaZBhJ6KykKoDkVygv1FZwPztRi8fV0uyItDRUloCgOTJ1
	 4OUrP3TjaPcgYCgSLDHboTA0TpS9gogTKNNrPlIPxMisWGsyhqC+67Afj/uTCNkHB9
	 dxpmgEFvQassyZCBCd0CNcqyz506a1B1m7AW5lV7OgomAoSgHNkToymwRphpW4Z/uU
	 WiYnl2rJKEMvLnpzB/5EHb4fo+VTrNnHP2Un7HO/RzNGQ8+P8H3BB0030lZNzhj96K
	 NUp+4sjOTx/uhsAihbsLcbPazxKQmSjJjX/0YuhMjbPBwNhyZTo2fQGghEmkwdnzn8
	 jAJ1rNO2gkN3Q==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id 5BC912010195;
	Mon,  9 Dec 2024 13:31:44 +0000 (UTC)
Message-ID: <8e96f2d7-8ad1-47c9-ba12-49761edb8600@icloud.com>
Date: Mon, 9 Dec 2024 21:31:37 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] of: Fix alias name length calculating error in API
 of_find_node_opts_by_path()
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Stephen Boyd <stephen.boyd@linaro.org>, Maxime Ripard <mripard@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Grant Likely
 <grant.likely@secretlab.ca>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
 stable@vger.kernel.org
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
 <20241206-of_core_fix-v1-1-dc28ed56bec3@quicinc.com>
 <CAL_JsqK1gsVeCG29RzWMFycbASAGAsds34Utuoq+Egw3-Afi7g@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <CAL_JsqK1gsVeCG29RzWMFycbASAGAsds34Utuoq+Egw3-Afi7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Ffe_gFMUaHt6leimceiHP24n7MdknpME
X-Proofpoint-GUID: Ffe_gFMUaHt6leimceiHP24n7MdknpME
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_10,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 bulkscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412090106

On 2024/12/9 21:24, Rob Herring wrote:
> On Thu, Dec 5, 2024 at 6:53 PM Zijun Hu <zijun_hu@icloud.com> wrote:
>>
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> Alias name length calculated by of_find_node_opts_by_path() is wrong as
>> explained below:
>>
>> Take "alias/serial@llc500:115200n8" as its @patch argument for an example
>>       ^    ^             ^
>>       0    5             19
>>
>> The right length of alias 'alias' is 5, but the API results in 19 which is
>> obvious wrong.
>>
>> The wrong length will cause finding device node failure for such paths.
>> Fix by using index of either '/' or ':' as the length who comes earlier.
> 
> Can you add a test case in the unittest for this.

sure. let me try to do it.

> 
>>
>> Fixes: 106937e8ccdc ("of: fix handling of '/' in options for of_find_node_by_path()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/of/base.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 7dc394255a0a14cd1aed02ec79c2f787a222b44c..9a9313183d1f1b61918fe7e6fa80c2726b099a1c 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -893,10 +893,10 @@ struct device_node *of_find_node_opts_by_path(const char *path, const char **opt
>>         /* The path could begin with an alias */
>>         if (*path != '/') {
>>                 int len;
>> -               const char *p = separator;
>> +               const char *p = strchrnul(path, '/');
>>
>> -               if (!p)
>> -                       p = strchrnul(path, '/');
>> +               if (separator && separator < p)
>> +                       p = separator;
>>                 len = p - path;
>>
>>                 /* of_aliases must not be NULL */
>>
>> --
>> 2.34.1
>>


