Return-Path: <stable+bounces-235332-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGvJBP5V12kFMggAu9opvQ
	(envelope-from <stable+bounces-235332-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 09:32:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 730703C70EA
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 09:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCEA63004F6B
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 07:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957C8379EEF;
	Thu,  9 Apr 2026 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TtjjEYWU"
X-Original-To: stable@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D3334AB1D;
	Thu,  9 Apr 2026 07:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719714; cv=none; b=K83cEQDj67ZegtT0ZL02gh+8r2/7tGaA3JwNnWieAqBGb5xR2J/GsnDW72MZHG36CYOHXhjFg/pPoQKgSi3D+tDgBH4eXQgrkW+WS5uPu2uYeR1Mr61a9a4QTsiqobXJxoKZEAxmOxVPKCjsYj88NNQTTaPolBFxYlv+zhJsOik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719714; c=relaxed/simple;
	bh=T+NBLdVh9E+C14UHYRM9W0fnw2PgPYNp7mcnmntw9c8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9ZkLEihO3PBl2rTn/nHVJ4odExZhKI/4Ziw9sUKwUWUzRtZ4Bj9zGU8mscTiCzXxlAjpUi7a6aiUvDD/wW2VVmpRF8fxrPFOhnOUZSc4kNvJ7H4f7EF+p5vN8SGshH+6x7DqRG6aIBGCBoXHPxIaWGZs5x1fLenkohRPSQLLRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TtjjEYWU; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775719703; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kJ7vJ+oFAlZFw8EfHMuaHDk+cVLH8+ocGz5ZHIMeP74=;
	b=TtjjEYWUnRJHP1hL4/OSPMQrPdzL1ELG6UAANkF6FrjgyrigiaE23AAUkiPdbgeFmTi8mO5wpZcoZT49I8OsdDashO3dflCXDsekuzfhZm/cIbvj5i+9Huj4cvnNg5svQsk/DitOgzjeeCGFAIGSzOUaj4RAmDxupKXUWLNrrt8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X0hg9id_1775719701;
Received: from 30.221.132.163(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0hg9id_1775719701 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Apr 2026 15:28:22 +0800
Message-ID: <31b4e893-44f4-49b4-935f-9cf37b5a0790@linux.alibaba.com>
Date: Thu, 9 Apr 2026 15:28:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix unsigned underflow in
 z_erofs_lz4_handle_overlap()
To: Junrui Luo <moonafterrain@outlook.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
References: <SYBPR01MB78811E3B3E935EFCD5D63334AF582@SYBPR01MB7881.ausprd01.prod.outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <SYBPR01MB78811E3B3E935EFCD5D63334AF582@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235332-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 730703C70EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/9 14:57, Junrui Luo wrote:
> In z_erofs_lz4_handle_overlap(), the index expression
> "rq->outpages - rq->inpages + i" is computed in unsigned arithmetic.
> If outpages < inpages, the subtraction wraps to a large value and
> the subsequent rq->out[] access reads past the decompressed_pages
> array.
> 
> z_erofs_map_sanity_check() does not enforce m_plen <= m_llen, so a
> crafted image declaring m_plen > m_llen can produce outpages < inpages.

For this kind of stuff, do you have a reproducer?

`m_plen > m_llen` can happen on partial decoding only.

> 
> The in-place branch is currently unreachable: it requires both
> partial_decoding == false and omargin > 0, but these are mutually
> exclusive. partial_decoding == false requires pcl->length == m_llen,
> which in turn requires (offset + end == m_la + m_llen) where
> offset + end is page-aligned from folio boundaries. This forces

I'm not sure what you're saying, but I don't think
you really understand the entire logic.

> m_la + m_llen to be page-aligned, making oend page-aligned and
> omargin zero.

`m_la + m_llen` should not be page-aligned for typical
erofs images, you can just mkfs.erofs -zlz4hc with some
file and check it yourself.

BTW, I just check upstream, and the inplace branch
works prefectly.

Thanks,
Gao Xiang


