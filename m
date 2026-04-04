Return-Path: <stable+bounces-233259-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDPZOpmb0Gkd9wYAu9opvQ
	(envelope-from <stable+bounces-233259-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 07:03:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B09399F45
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 07:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A71703031E99
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 05:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DDB36D51E;
	Sat,  4 Apr 2026 05:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="nCBdwPR3"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063FD3246EF
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 05:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775278991; cv=none; b=PN/8bBF06BEBTlZKWkCAKmRTcfzmfuduec0iLr3m3gku0Bl389dI5bKCtx92N4JSDTYYZWUvuS41siQMMRTCZBIC5gEEWVfwcN5cGsQBh6g9KC4F4iPn9GTCfrOAQcPCXaUeDKMuQSH8vvLM9Ba9L0dGC/7MDKBxQAIc8QZZr7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775278991; c=relaxed/simple;
	bh=ljLqHN4/YU54zGex0W8bOwmzab78gDAvWCE9IC2QNmc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=scPg+T5FKM/SKpiYyYe/uwXqw0Zqwd99+Ovr7Ludppo0iamafi4/EEkHZ6EfUp6wPLABwIvhgsPx2AJLUYIb20b+zxjGaFmtep1jZ6PqlA9lhbriKwIXRb/h874iPPlokCPX8tdAWSTSHlEPNjOMHNmxyvwaT+Mz7wHMgvPgmtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=nCBdwPR3; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Message-ID: <904cb9a8-2ff5-4725-8ce2-f70c4f98791e@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1775278977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1U6dk8yrKlB+wf4qSWlG//ZdhnWAEAWP8rEKm7hKPZo=;
	b=nCBdwPR379jAGtjbyJXkAU75EJIIo5aFPgZMv4MModTb9rEN7HGKo5+c9qgZvSFEN0059b
	6X7VG63byGYf9Kmf6LEtZ9x76KeVT3frDZaTxcl/7t/b2923QqTTq/nFRHvTQgaPtxwdyQ
	K9pU2z81l/wwOR1opkyRmG4S+gQMUmJbrSMKPTERf4YG99rmjGlvPNnMUJZPwAkfZlF7jB
	nRdb1HjH7fmeQ4lpJFOnx8IxQ6l8FvKZnj7kBBBMPKYu51RGYRniX81jrUVriy2Bz26fN+
	5Qqqxc8qnzHSA1B6y69Ay+N0jHzUVv/UATYOPWGsXbDFmE3N4qu+c6cQNOxqBg==
Date: Sat, 4 Apr 2026 13:02:07 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Subject: Re: [PATCH] ksmbd: fix use-after-free in __ksmbd_close_fd() lock
 cleanup
To: Namjae Jeon <linkinjeon@kernel.org>, munan Huang <munanevil@gmail.com>
Cc: smfrench@gmail.com, senozhatsky@chromium.org, tom@talpey.com,
 linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260402083912.457676-1-munanevil@gmail.com>
 <CAKYAXd9Qnq6YgTfbS-59YATBvnbtKrX3w+D+WNk=izZVvQOoVQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAKYAXd9Qnq6YgTfbS-59YATBvnbtKrX3w+D+WNk=izZVvQOoVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chenxiaosong.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chenxiaosong.com:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233259-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,chromium.org,talpey.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chenxiaosong.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong@chenxiaosong.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,chenxiaosong.com:dkim,chenxiaosong.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53B09399F45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Namjae and munan,

In `ksmbd_reopen_durable_fd()`, when -EBADF is returned, should 
`list_del(&smb_lock->clist)` be called?

If my understanding is incorrect, please let me know.

> 
> int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
> {
> 	...
> 	fp->conn = conn;
> 	...
> 
> 	list_for_each_entry(smb_lock, &fp->lock_list, flist) {
> 		spin_lock(&conn->llist_lock);
> 		list_add_tail(&smb_lock->clist, &conn->lock_list);
> 		spin_unlock(&conn->llist_lock);
> 	}
> 	...
> 	__open_id(&work->sess->file_table, fp, OPEN_ID_TYPE_VOLATILE_ID);
> 	if (!has_file_id(fp->volatile_id)) {
> 		fp->conn = NULL;
> 		fp->tcon = NULL;
> 		return -EBADF;
> 	}
> 	return 0;
> }

Thanks,
ChenXiaoSong <chenxiaosong@kylinos.cn>

On 4/4/26 10:28, Namjae Jeon wrote:
> I will apply the following patch instead of your patch. Let me know if
> I am missing something.
> https://github.com/smfrench/smb3-kernel/ 
> commit/319ca5432460b0749e420f7cff637dfbc7e16be3
> Thanks.


