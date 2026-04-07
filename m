Return-Path: <stable+bounces-233491-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIA9HhOW1GknvgcAu9opvQ
	(envelope-from <stable+bounces-233491-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 07:28:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 930F93A9F48
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 07:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D33813032075
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 05:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114833783B1;
	Tue,  7 Apr 2026 05:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="tweCx11O"
X-Original-To: stable@vger.kernel.org
Received: from va-2-20.ptr.blmpb.com (va-2-20.ptr.blmpb.com [209.127.231.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502CC37701C
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 05:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775539724; cv=none; b=Qwey/qWXImb30PhApEMcBlmPCLtq67PVW35sbLPRShr0OONShKJStrUxtY7VUTanAWfUpYbZMcOVzVdPyeZZ/xUdMuZwMbPZCU90xzxLw2dw83FaDXlP/KxIMfXtMbA+Kdq26h/NSkZ1k3GKACxxYBWrrsmBAbrwUmgSHLDmIvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775539724; c=relaxed/simple;
	bh=l7YJT4DXiaBKIEsSRPMpDRf9FozgUYDtwg9T+4g/OM4=;
	h=From:Message-Id:References:Cc:Date:Mime-Version:In-Reply-To:
	 Content-Type:To:Subject; b=C+pUYAtADox0LKih4sKjJuhOKsAWWreFH2d6M5LRZn4uG7S+Wc3o0nrWRbeCuv6vvTVkukvTmRd+cPvONyLgMHKjk9vxGeBWThg9FEPA+kWEnxhois61FZw3Yz4u6JhFjUJZzBvABgsfUzyxNZAam8RUsCDaZRF7jyVSRWR9DVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=tweCx11O; arc=none smtp.client-ip=209.127.231.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1775539710;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Ry6YbbBi1KZu7bk7Ejs3jV/ttzlMY0yHesmy0HZhKTs=;
 b=tweCx11OxyDkz+T7TVRd7RNAp8R6Y+RgmcNUZHT9BaW+4zroXsvZiQfc3iTgmhZkTFT18o
 S9Kp+PCjNahf2Dao2O4e/G/dcPn/5/KVJYgFN+eAHXVj7YtdCU3ViZqLCohraLs8/AKC/t
 KrQQzqDWoEphEGCmFCdv/w2HDEwf/2lqCKddCRi58jB2TKKxOEQJLicDEhK+UjtSDZqrH0
 YyXNUXD7i+H4c0CkGzPpRLV2NMb+mggBFEnq8bkIUkYdruL1dfX9ipD72Am96WrRSu7AZC
 DFqLljumbsZtbjLuwTXBLryeqfSnx5v6nut+Zz2GbQJEHSdf06541VPpAvKtwg==
From: "Yu Kuai" <yukuai@fnnas.com>
Message-Id: <558d1df2-7a02-47b7-b1dd-cab4cddd23f4@fnnas.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
References: <SYBPR01MB78815E78D829BB86CD7C8015AF5FA@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Cc: "Song Liu" <songliubraving@fb.com>, <linux-raid@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Yuhao Jiang" <danisjiang@gmail.com>, 
	<stable@vger.kernel.org>, <yukuai@fnnas.com>
Date: Tue, 7 Apr 2026 13:28:25 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <SYBPR01MB78815E78D829BB86CD7C8015AF5FA@SYBPR01MB7881.ausprd01.prod.outlook.com>
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@fnnas.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.1.104] ([39.182.0.129]) by smtp.feishu.cn with ESMTPS; Tue, 07 Apr 2026 13:28:28 +0800
To: "Junrui Luo" <moonafterrain@outlook.com>, "Song Liu" <song@kernel.org>, 
	"Li Nan" <linan122@huawei.com>, "Shaohua Li" <shli@fb.com>
Subject: Re: [PATCH] md/raid5: validate payload size before accessing journal metadata
X-Lms-Return-Path: <lba+269d495fc+8cc503+vger.kernel.org+yukuai@fnnas.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[fnnas-com.20200927.dkim.feishu.cn:s=s1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233491-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com,kernel.org,huawei.com,fb.com];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,gmail.com,fnnas.com];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[fnnas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fnnas.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[fnnas-com.20200927.dkim.feishu.cn:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	HAS_REPLYTO(0.00)[yukuai@fnnas.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fnnas-com.20200927.dkim.feishu.cn:dkim,fnnas.com:replyto,fnnas.com:mid,outlook.com:email]
X-Rspamd-Queue-Id: 930F93A9F48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

=E5=9C=A8 2026/4/4 15:44, Junrui Luo =E5=86=99=E9=81=93:
> r5c_recovery_analyze_meta_block() and
> r5l_recovery_verify_data_checksum_for_mb() iterate over payloads in a
> journal metadata block using on-disk payload size fields without
> validating them against the remaining space in the metadata block.
>
> A corrupted journal contains payload sizes extending beyond the PAGE_SIZE
> boundary can cause out-of-bounds reads when accessing payload fields or
> computing offsets.
>
> Add bounds validation for each payload type to ensure the full payload
> fits within meta_size before processing.
>
> Fixes: b4c625c67362 ("md/r5cache: r5cache recovery: part 1")
> Reported-by: Yuhao Jiang<danisjiang@gmail.com>

I didn't found a report mail from patchwork, so I remove this tag

> Cc:stable@vger.kernel.org
> Signed-off-by: Junrui Luo<moonafterrain@outlook.com>
> ---
>   drivers/md/raid5-cache.c | 48 +++++++++++++++++++++++++++++++++--------=
-------
>   1 file changed, 33 insertions(+), 15 deletions(-)
Applied to md-7.1

--=20
Thansk,
Kuai

