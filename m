Return-Path: <stable+bounces-269493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k8FnM7DSQGq9iQkAu9opvQ
	(envelope-from <stable+bounces-269493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 09:52:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E39E6D360C
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 09:52:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=chenxiaosong.com header.s=key1 header.b=RNXENx1N;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269493-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269493-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=chenxiaosong.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBA9C300FB46
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 07:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2309730DEBA;
	Sun, 28 Jun 2026 07:52:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD03B19067C
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 07:52:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782633130; cv=none; b=Hw2KqFbOlq+AMe76LGU0RZRUVPETrGgPrhrL/dh73fIzdT+NvZTIO2twVm6B2o+U8bwFhsRNu54CX/mJwuMktC+jknjva53xrPTu/2RhmigwYuh1r2cLFClj+Qdf0Luw0Ug5Mf6qgixNEffSp4H7LTKkdeqXCZwaF8c3DKhhXm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782633130; c=relaxed/simple;
	bh=h1soUnYGY+dQolL6Z3UpjNthIWytuu5ZftFJIykzq+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGreETkl2TtqrksQFyUQQee/OHq9RRxQIuCPQfCZ3m3ZgpEY8zdrh4+r7M12ZYBBDPhWMbuE8fNDSHcLrGc+T1jaLz9etIVof/iG653CzPUkfKTjllXG4WH0gso8uwHZq1S3O9QDhkwn5EFtWD+ar/L8rOxoul97aEqToIU0X4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=RNXENx1N; arc=none smtp.client-ip=95.215.58.180
Message-ID: <9526a947-446d-4db9-8901-6e730ff440d7@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1782633126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxGuATbpxyoep/ZktiVqqFVsgckLjpydoO3YMno0AYQ=;
	b=RNXENx1NTw6NFHpxcxL/SyagqRCOaFGL1AmSSXyQZzzel/BBXcVLRJkZBqSSlVbsZL6j8f
	kMQ0GOJjWHknlImrv2iAbCsL7qOxu6jMQQPRqZgi0WB/zBEonOEwOn4z8cov5OtI9I/UpJ
	ztMBiGSCTgTzYH/YwMvPAcC/G/Rbvc8speKgQQFT9Xk8+1uH+2Ayrs9z3jx4h7BcihiuyP
	dpw3OJ7b1/oAD5+D1S7RKunJAJjSXdNIE4N9TgxYH4d5t4AKiVyjVqolKEdpKBrVDGS+ef
	agMYN3pqnnOFhxpAomDp+wMO0quaRonCXcc/wWvFr2XT7DtcQN0QUuOmtX9cXw==
Date: Sun, 28 Jun 2026 15:51:56 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] smb/server: do not require delete access for
 non-replacing links
To: ChenXiaoSong <chenxiaosong@chenxiaosong.com>, smfrench@gmail.com,
 linkinjeon@kernel.org, pc@manguebit.org, ronniesahlberg@gmail.com,
 sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com,
 senozhatsky@chromium.org, dhowells@redhat.com, metze@samba.org
Cc: linux-cifs@vger.kernel.org, stable@vger.kernel.org
References: <20260628074243.629589-1-chenxiaosong@chenxiaosong.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <20260628074243.629589-1-chenxiaosong@chenxiaosong.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chenxiaosong.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[chenxiaosong.com:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:chenxiaosong@chenxiaosong.com,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:pc@manguebit.org,m:ronniesahlberg@gmail.com,m:sprasad@microsoft.com,m:tom@talpey.com,m:bharathsm@microsoft.com,m:senozhatsky@chromium.org,m:dhowells@redhat.com,m:metze@samba.org,m:linux-cifs@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[chenxiaosong@chenxiaosong.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269493-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[chenxiaosong.com,gmail.com,kernel.org,manguebit.org,microsoft.com,talpey.com,chromium.org,redhat.com,samba.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong@chenxiaosong.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[chenxiaosong.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,chenxiaosong.com:url,chenxiaosong.com:from_mime,chenxiaosong.com:dkim,chenxiaosong.com:email,chenxiaosong.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E39E6D360C

Reported-by: Steve French <stfrench@microsoft.com>

在 2026/6/28 15:42, ChenXiaoSong 写道:
> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
> 
> Reproducer:
> 
>    1. server: systemctl start ksmbd
>    2. client: mount -t cifs //${server_ip}/export /mnt
>    3. client: touch /mnt/file; ln /mnt/file /mnt/hardlink
>    4. client err log: ln: failed to create hard link 'hardlink' => 'file': Permission denied
>    5. server err log: ksmbd: no right to delete : 0x80
> 
> Fixes: 13f3942f2bf4 ("ksmbd: add per-handle permission check to FILE_LINK_INFORMATION")
> Cc: stable@vger.kernel.org
> Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>

-- 
ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Chinese Homepage: https://chenxiaosong.com
English Homepage: https://chenxiaosong.com/en


