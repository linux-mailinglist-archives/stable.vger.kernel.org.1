Return-Path: <stable+bounces-225751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJKSOe34uGkumgEAu9opvQ
	(envelope-from <stable+bounces-225751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 07:47:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 535612A46CA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 07:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 114EB302BDCA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 06:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5002933F378;
	Tue, 17 Mar 2026 06:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="QYsuZetB"
X-Original-To: stable@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5224433EB01
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 06:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773729856; cv=none; b=bUQj6DCBnzCtZ3JBK8R7sMdD3T7cWRhfEXQHPdIgzXx7AL+XJoXqUXf+J1EiZWTYDB2vatjuWVH46Deis9s7wmId6nE1HVOCfMCBcE7f2IzFfkdMzBNvKdZyXMW6my44syfKLTLb9TrXLcq5BVDZHr/jE4jUq5MM6QjSwLQnf7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773729856; c=relaxed/simple;
	bh=0PnczQPsAzp+2qKiXxduJtqJzsZh4nAVKpPNeXxzLxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eep7pQjLMEWYAVRe7RFwZDZ3oA4AWgzJnlHR645tt5mpKMpBHMDfQyCeXFE3iVSxZ0IF+5cdVSqOmxCU0LCo5s/TxRz3aGSfX3dThGfBaJhRuKcsIQOq1ejOX2JpvEWLPZpf6wMRM4yU09hiwwo2sRrPQAmWSB1VcfaX+9H/KA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=QYsuZetB; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Message-ID: <1e0882ea-4e59-4b70-b1ae-90fde86c252b@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1773729842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8Q+eLbEhLpsxmANAK27dLrmscb8tjCtN8GADEvXHMI=;
	b=QYsuZetB/OSIl8yjBzEQD/Mub2vP1Yb+n4lgn61g7UXoiUMXnSs1fwHGl7OysbYCbQoU9E
	Y0lZSK2iQ0rBcA1oHbyJGNvRZS3CLofAn7XKRkuHPFBMW2YG2nbqN/UT1NuM1STtVZFDuR
	sICp+geljkcASZB4oaTUfEatlr75HtZ1+9P5GC+BqrD+4sied1HdXJRP/JOAvxsG07cF3r
	iOuW5w5QK9XMOKN6QLQIf7dkRpgkTdzxKJDMEc8aTzQz2SdeAWYPa7CmCCaRV8CSeSmVlQ
	pJ/ewqNSF184wzWdgW2PGW5XAC//yPEXjZRArWeJcfb1lzE4SV9MlGL6BJOCcA==
Date: Tue, 17 Mar 2026 14:43:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ksmbd: fix use-after-free and NULL deref in
 smb_grant_oplock()
To: Werner Kasselman <werner@verivus.com>,
 ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
 "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
Cc: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
 "smfrench@gmail.com" <smfrench@gmail.com>,
 "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260317021757.962692-1-werner@verivus.com>
 <6b98c261-b17b-45a8-ab09-efdb0d658f4e@chenxiaosong.com>
 <ME0P300MB0853F9FCE2F9C416FE3820B0BD41A@ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <ME0P300MB0853F9FCE2F9C416FE3820B0BD41A@ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chenxiaosong.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chenxiaosong.com:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225751-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,chromium.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chenxiaosong.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong@chenxiaosong.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chenxiaosong.com:dkim,chenxiaosong.com:email,chenxiaosong.com:mid]
X-Rspamd-Queue-Id: 535612A46CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I just saw your v2 patch, and it seems to be the same as v1: 
https://lore.kernel.org/linux-cifs/20260317063456.1696853-1-werner@verivus.com/

Thanks,
ChenXiaoSong <chenxiaosong@chenxiaosong.com>

在 2026/3/17 14:36, Werner Kasselman 写道:
> I sent an earlier version of the patch by mistake. The version with the complete changes (including alloc_lease_table() split and add_lease_global_list() signature change) was committed locally but the email went out before the final amend. I apologise for the confusion.
> 
> I will resend the correct patch as v2. The full diff is +45/-27 lines and includes:
>   - New alloc_lease_table() helper (extracted from add_lease_global_list)
>   - add_lease_global_list() changed to take preallocated lease_table, return type changed from int to void
>   - smb_grant_oplock() restructured: set o_fp, preallocate, then publish
>   - Error path uses opinfo_put() instead of __free_opinfo()


