Return-Path: <stable+bounces-225748-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EhVMgH2uGk5mQEAu9opvQ
	(envelope-from <stable+bounces-225748-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 07:34:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EBD2A4530
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 07:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEF463020A58
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 06:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1882530B520;
	Tue, 17 Mar 2026 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="XrnY/N/+"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C741A8F97
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 06:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773729242; cv=none; b=ctZDihiN169dyjplyUQIasvHEO//glvR9ndpNGy8JN+oE7pbNQH2Pfm2O9ifPG3y5/l1U0hZzO1IQvBziDXkvB244EI5gmF69O6UoKhwU1Ja68/54ZEjecy9fmFkxm8il0A7HFjUYd/CmYQFYHFXc3F3oGBg+rgQxHP+JfoVwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773729242; c=relaxed/simple;
	bh=DrdarfVGbQxXBQPdqeKiK//5hw237bElJAzqzmM2czM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Js5qJ6km0VLnGHRUWT9zxysH0eQsR7h+IdazZiMqEqsayQ8W8NaKJSK9H9QASfIOmlOlhp+Xs5wPTKcA787vJLk6jPyErNP90hU7vPFnSKK1SEmyYzQpisGrSG1GxKgSkDsL3F2B/fVbCrjDRqrcuH5Rf6HDoUU4r0K94c9hDuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=XrnY/N/+; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Message-ID: <6b98c261-b17b-45a8-ab09-efdb0d658f4e@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1773729228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5J4BPcjXWE79P5QWR0kb3daUGe7Wy+vHtLm9w9OY5ro=;
	b=XrnY/N/+WhYkkSbDwW+PeMjmIR99IJXIqqSzvTPqaTanFz0zRDpqHa1KGKKkro25LyQBPa
	L2UBTzjBqerdJFCpI1BT2QEMdaN4nRWX8lwdEtqHwFY0qESMAlh1f3b3PcKsycsvypbwuf
	NyJl2GbbfNF+e54T4hArP02pwyyAuRdWlL18dBmkPivRjHV7wwRBLNGA1gVUbGZ1QX3ajj
	GXTh1CP5hGYo9i/jKPDlIyiiEo86Pvo4Nh8KgL7vVs0R/4wGSxMrEOHKQB6eYW6fNt03qH
	hEsMSuiXtDj4xlG8R2+8z6UvCfnXU3uh3sVO6+NIItiqvhCeY3h/jOfBtF30RA==
Date: Tue, 17 Mar 2026 14:32:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ksmbd: fix use-after-free and NULL deref in
 smb_grant_oplock()
To: Werner Kasselman <werner@verivus.ai>,
 "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
Cc: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
 "smfrench@gmail.com" <smfrench@gmail.com>,
 "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260317021757.962692-1-werner@verivus.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <20260317021757.962692-1-werner@verivus.com>
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
	TAGGED_FROM(0.00)[bounces-225748-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chenxiaosong.com:dkim,chenxiaosong.com:email,chenxiaosong.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60EBD2A4530
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Werner,

Thanks for your patch. It seems the changes below are not included. Do 
you have any follow-up patches that haven't been submitted yet?

Thanks,
ChenXiaoSong <chenxiaosong@chenxiaosong.com>

在 2026/3/17 10:18, Werner Kasselman 写道:
> - Preallocate lease_table via alloc_lease_table() before opinfo_add()
>    so add_lease_global_list() becomes infallible after publication.
> - Keep the original m_op_list publication order (opinfo_add before
>    lease list) so concurrent opens via same_client_has_lease() and
>    opinfo_get_list() still see the in-flight grant.
> - Use opinfo_put() instead of __free_opinfo() on err_out so that
>    the RCU-deferred free path is used.
> 
> This also requires splitting add_lease_global_list() to take a
> preallocated lease_table and changing its return type from int to void,
> since it can no longer fail.


