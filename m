Return-Path: <stable+bounces-274669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Us9bAWPpVmpkCwEAu9opvQ
	(envelope-from <stable+bounces-274669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 03:58:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6DA759FEC
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 03:58:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=chenxiaosong.com header.s=key1 header.b=gtiv0YRi;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274669-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274669-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=chenxiaosong.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09D003015238
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 01:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D139238F25A;
	Wed, 15 Jul 2026 01:58:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9660386C36
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 01:58:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784080735; cv=none; b=PqiCNfHCeQsmhF/wpq5AAs3m2tLs5+ID9JvOpr5LcCFELyRZBnV+Lno+Kyy66TPFT/48kUxHucTk3CkbO4WDURTmSxv7UtquIXvs/1yL75sKLkKZOR8I58jaeqoyAAYsVso4ezfjCFMWieSkrE38ejNeQ1/gNi1zKIyaOpK10Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784080735; c=relaxed/simple;
	bh=v6UEsQTUeCdKptbJxuHtunkSXd/logF0yqy/qJBt/D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhgO7dmN4LsagaUPsHNtfIiNiHpngWQRkt6RWggWygXupfY6jRjY67OwEu74DpEy9BamdgsGd149tyfQLSFadHcBhSOR2EbRavAFWW5h8W39YEuZMivhV/GWl0X/ygUVrg+Z3+ezDGCsxwrD3akQCdix492j0ZAmcjtmX8glpq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=gtiv0YRi; arc=none smtp.client-ip=95.215.58.170
Message-ID: <b5901dc2-0d5c-45ac-a817-81e2a3934131@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1784080728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cb2hcIFH1acyVBewhIhQNw1fbffn3Z4mXJA9sWKRQ+Q=;
	b=gtiv0YRiYJjunMqowMWo4lC+hKwIlWhLxg47wT0NwN7rnDi0sJ0P47GjylmxIcF9TdOpo8
	vkXMDj9V/0gRwZ/vJGbmBKBS41jISzc/ignSi2uzf9Oi83OpHKK543Gs//wrs+W7ky0Nt+
	RBEGvL0pynpN0dhT8NphhowQmlqkfQ9P+opGkGaxgzLD0HrDyDlRsLYQf4yJIm38hGvIR+
	bdE5oVYLkxPg3afLO6fmrY80jRCExDjxiACFTFb32dGva7kSytEtoNU8aHdjZrnQarxbEl
	4P3iUw2+nG1q9pUXEFtNzHe0nCNTsfyl9s9QfOUTPBYpWp72SsINbgZfEJhHZg==
Date: Wed, 15 Jul 2026 09:58:10 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: FAILED: patch "[PATCH] smb/server: do not require delete access
 for non-replacing" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org, linkinjeon@kernel.org, stfrench@microsoft.com
Cc: stable@vger.kernel.org
References: <2026071409-clamp-reminder-aacc@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <2026071409-clamp-reminder-aacc@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chenxiaosong.com,quarantine];
	R_DKIM_ALLOW(-0.20)[chenxiaosong.com:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274669-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:linkinjeon@kernel.org,m:stfrench@microsoft.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[chenxiaosong@chenxiaosong.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[chenxiaosong.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong@chenxiaosong.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,chenxiaosong.com:email,chenxiaosong.com:dkim,chenxiaosong.com:url,chenxiaosong.com:from_mime,chenxiaosong.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE6DA759FEC

linux-6.1.y linux-6.6.y linux-6.12.y linux-6.18.y does not include the 
bug-introducing patch: 13f3942f2bf4 ("ksmbd: add per-handle permission 
check to FILE_LINK_INFORMATION").

On 7/14/26 22:47, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to<stable@vger.kernel.org>.

-- 
ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Chinese Homepage: https://chenxiaosong.com
English Homepage: https://chenxiaosong.com/en


