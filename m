Return-Path: <stable+bounces-238238-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAqmC2BA4Gn0dwAAu9opvQ
	(envelope-from <stable+bounces-238238-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 03:50:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD3A409961
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 03:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F19630AF013
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 01:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADF22BD11;
	Thu, 16 Apr 2026 01:50:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C711643B
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776304217; cv=none; b=JKW1IryYCkTpgRFJU145iuiy0cRfQzWx2i1n5lbNUsHYBDJBjOuIYCek3q+Vdyg1xoEBpUZd766ZJ/SzEqxdpSNaVWchJc2KIyHizsgD/BC+KFLMgimgXUBwanc/ym7K1Ji0wCK5Cus2XN2O2SITEL76a+ya0+6oI4FI/x6jRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776304217; c=relaxed/simple;
	bh=UocuhRPYBrOhfwEn8vYdZdNxEnzLgnAq82M7DEyRCMc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=CZRy3fayoEr5VNFYKjsPifOyxEdnFM/cMUooeXL5boUEI7zoK9JzXyIdQxsDYU2w3lBpzzvcMMs16Li34CrizRC05YpDiji7tl8XTGAfhRI11i38+4wSJnDcR7J3VIw+cw0EAWQB4dVKF9FM0Qrb1QUVxV60NyZpg8MEmcj1E9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9411cf96393611f1aa26b74ffac11d73-20260416
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:2a9493e1-43fc-475e-b158-383c86ddeae1,IP:10,
	URL:0,TC:0,Content:5,EDM:25,RT:0,SF:9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:49
X-CID-INFO: VERSION:1.3.12,REQID:2a9493e1-43fc-475e-b158-383c86ddeae1,IP:10,UR
	L:0,TC:0,Content:5,EDM:25,RT:0,SF:9,FILE:0,BULK:0,RULE:Release_HamU,ACTION
	:release,TS:49
X-CID-META: VersionHash:e7bac3a,CLOUDID:8b03f2bd8bc92530b92bf6043d12a01e,BulkI
	D:260416095002CSVPFOEW,BulkQuantity:0,Recheck:0,SF:16|19|66|78|81|82|83|10
	1|102|127|898,TC:nil,Content:4|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bul
	k:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_USA,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9411cf96393611f1aa26b74ffac11d73-20260416
X-User: zhaomengmeng@kylinos.cn
Received: from [198.18.0.1] [(1.193.37.198)] by mailgw.kylinos.cn
	(envelope-from <zhaomengmeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1740711839; Thu, 16 Apr 2026 09:50:00 +0800
Message-ID: <7ad57375-c651-4fb0-8279-bc3423157255@kylinos.cn>
Date: Thu, 16 Apr 2026 09:49:56 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: yphbchou0911@gmail.com
Cc: arighi@nvidia.com, changwoo@igalia.com, chia7712@gmail.com,
 jserv@ccns.ncku.edu.tw, sched-ext@lists.linux.dev, stable@vger.kernel.org,
 tj@kernel.org, void@manifault.com
References: <20260415193459.933175-1-yphbchou0911@gmail.com>
Subject: Re: [PATCH] sched_ext: Prevent RB-tree corruption in
 scx_bpf_task_set_dsq_vtime()
From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
In-Reply-To: <20260415193459.933175-1-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,igalia.com,gmail.com,ccns.ncku.edu.tw,lists.linux.dev,vger.kernel.org,kernel.org,manifault.com];
	TAGGED_FROM(0.00)[bounces-238238-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaomengmeng@kylinos.cn,stable@vger.kernel.org];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:mid]
X-Rspamd-Queue-Id: 0BD3A409961
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Just discuss, if is better to use WARN_ON_ONCE instead of failing the
scheduler, just like the check in the beginning of dispatch_enqueue().

