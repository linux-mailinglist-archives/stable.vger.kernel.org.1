Return-Path: <stable+bounces-233290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCtgEMMn0WkXGAcAu9opvQ
	(envelope-from <stable+bounces-233290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 17:01:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF85539B6FC
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 17:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F91F300FECF
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD3829C327;
	Sat,  4 Apr 2026 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="NE8NvrbW"
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CEE2820AC
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775314855; cv=none; b=sgLXvWC1g9BVb5NZtiGqNc2+Vf0emJpz4wfvhXm9KS/wv8usAkKmiiFO1VVMpmgDo0F8Ri13IW0Jwb5jDtYsJzHqAGoaO47p1ZL/w5GPVmGEmYbVQZbtMEcb5iUMSwxrOi0nDSy4bbt68EeQeizx5bIQlycqFKe99ysZSCGj2gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775314855; c=relaxed/simple;
	bh=V4XnIePq7Gn9DlSSDTyJyCYOunjXqVD0zDyhcNI7n3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdeCPx0MAokR4XTFp/rE7CALwWLV9uG3SjJIjkKKyIHTilqBXa5nM3qdayWqJgtdYyboyn0J0mgfhxx2+fniHOvL5w8Ea57ivfcHVGbVZxTi8yBLHfJyr/qaNUdy3qyn5185ne2/izKryxzgxTJjeU1Xf1gMIpfduzcsL0bWGM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=NE8NvrbW; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Message-ID: <0c6e5209-fd66-45d1-b018-a38b09f5ed80@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1775314841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wgl30kh7l87lJQQB+ZSLWWPZAIAZEq8WmNjcBcYCYB8=;
	b=NE8NvrbWAGJM/W/NVmMhMk9pGBlRXWSFkj4IEkKhbxVzhSdJtHiD+fwHJ7CRXJjnFYyocM
	yskZI4uqTvtiKdVI+y4EV0fFEneClDQnUdxyFBscOl9Fb+13It6sS4eSWZhgTL4O28jtEr
	s8D9sM7HsCXhKGZWgDNWC4zK5nF3tcIT12IsCfkt2zaClvBR2ZHcAyJ24HUJmFJo2hjIF6
	RU1rr3Hsdl7EoRq+V3S2PEMmQs2UcTXc2bM5+cP7Vk/a6+2k+woesYRP0mQh8f1mQ9y56e
	VJ5MHkLERzwnDXVAkVh8nOb2rpwFKocu097jd35Y/exBduj3i/kOoBWBvaPmLQ==
Date: Sat, 4 Apr 2026 22:59:48 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ksmbd: fix use-after-free in __ksmbd_close_fd() lock
 cleanup
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: munan Huang <munanevil@gmail.com>, smfrench@gmail.com,
 senozhatsky@chromium.org, tom@talpey.com, linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260402083912.457676-1-munanevil@gmail.com>
 <CAKYAXd9Qnq6YgTfbS-59YATBvnbtKrX3w+D+WNk=izZVvQOoVQ@mail.gmail.com>
 <904cb9a8-2ff5-4725-8ce2-f70c4f98791e@chenxiaosong.com>
 <CAKYAXd-izPxXKFuzEPYPknwUFG_jQ37yW90D1zCpO_zWxCNJQg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <CAKYAXd-izPxXKFuzEPYPknwUFG_jQ37yW90D1zCpO_zWxCNJQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	URIBL_RED(0.50)[kylinos.cn:email];
	MAILLIST(-0.15)[generic];
	HAS_ANON_DOMAIN(0.10)[];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[chenxiaosong.com,quarantine];
	FREEMAIL_CC(0.00)[gmail.com,chromium.org,talpey.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-233290-lists,stable=lfdr.de];
	R_DKIM_ALLOW(0.00)[chenxiaosong.com:s=key1];
	DKIM_TRACE(0.00)[chenxiaosong.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong@chenxiaosong.com,stable@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.941];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,chenxiaosong.com:dkim,chenxiaosong.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF85539B6FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Looks good to me. Feel free to add:
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>

On 2026/4/4 22:28, Namjae Jeon wrote:
> I have updated the patch. Please check it.
> https://github.com/smfrench/smb3-kernel/commit/38bf2f4ac44b0848677fd4d539404b8c0de15b98
> 
> Thanks for the review!

