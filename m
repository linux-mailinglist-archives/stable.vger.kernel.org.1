Return-Path: <stable+bounces-226018-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EF/HM1XuWnYAgIAu9opvQ
	(envelope-from <stable+bounces-226018-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:31:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D88542AAE70
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5F91306FE13
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A91B3CCFA3;
	Tue, 17 Mar 2026 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RvDMt60X"
X-Original-To: stable@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4B43CCA0E;
	Tue, 17 Mar 2026 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754185; cv=none; b=cX+gnGu9U5ncA9bCs3Uph8L1UJ/g/cPCAYs0LrVGUK6MJoo4zqUQHd/8pzSql2my+LLJCm6DS/Jv1/odkltEsaLe5XhjoJp1tz9+1fwqs27qvL3JuvJDuO9OjafEbVevosnj/25FavI669eodgdE9t6GZQq5LgrXYpsxrfxpXMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754185; c=relaxed/simple;
	bh=k2fln6WHEFb2hd+ZDL3tV+EuLNFC1N3n1qeZ1Av0mH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OS27ph4XAszBYcDwjqmCyZZ1atUUcMNOa5vmMzGcem2qGHbmf53b4mYTW43tVjBCcGjnocV67N2j/zUSu3MjVsX8dJDYlUAhC+yGNrpYOsZ5c7NHp6yxug09txAG8fsv3jmeBdTotnIPhY2RmVXoA4vHFIAR7ElDHdgOkLxTCtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RvDMt60X; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773754173; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GoOgYZBq/1s/gphq/ANh1jp5J4i5RkrikJ/DqZVUdIU=;
	b=RvDMt60XLdavs1ILLtSMpQMlRcGeLDb/9sum6l4i2zFr2ZhUthd4jZSm3SJiGWvrDyyuQPBGb5FbCJ3Haj7j3TIvjS6YJYbhL+/FBp8m0XXnNiq1/kSHR3UQju0bXBVyab6eQV4csdqZnJcYu3fpipR7kCHgzaaumRA5IBjjcUk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X.B94b3_1773754172;
Received: from 30.170.14.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.B94b3_1773754172 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 21:29:33 +0800
Message-ID: <b57c6213-fad4-41bb-991d-ccb80c842e34@linux.alibaba.com>
Date: Tue, 17 Mar 2026 21:29:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: harden h_shared_count in erofs_init_inode_xattrs()
To: Utkal Singh <singhutkal015@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, yifan.yfzhao@gmail.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260317132356.15341-1-singhutkal015@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260317132356.15341-1-singhutkal015@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226018-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: D88542AAE70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/17 21:23, Utkal Singh wrote:
> `u8 h_shared_count` indicates the shared xattr count of an inode. It is
> read from the on-disk xattr ibody header, which should be corrupted if
> the size of the shared xattr array exceeds the space available in
> `xattr_isize`.
> 
> It does not cause harmful consequence (e.g. crashes), since the image is
> already considered corrupted, it indeed results in the silent processing
> of garbage metadata.
> 
> Let's harden it to report -EFSCORRUPTED earlier.
> 
> Fixes: 47e4937a4a7c ("erofs: move erofs out of staging")
> Cc: stable@vger.kernel.org

No, please drop the Fixes and Cc since it should not be a bugfix.

Thanks,
Gao Xiang

