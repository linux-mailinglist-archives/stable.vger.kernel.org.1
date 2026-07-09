Return-Path: <stable+bounces-272881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9V8LJiaGT2oRiwIAu9opvQ
	(envelope-from <stable+bounces-272881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 13:29:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F3973056F
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 13:29:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=E+uxAvFa;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272881-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272881-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50F9E302DF97
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 11:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98563F927E;
	Thu,  9 Jul 2026 11:04:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC4931ED83
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 11:04:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595095; cv=none; b=AIDKRWknjYIcNyo1HdReXfDr6pmZbcapYAX+V9a/i6/D5MTe9nRvEx7VQtwDXtBOkek/rDqbMI/5ay8F75BZ9K8CqmFdA86DA8gfg3924Fa/TIWDdVl5MyGiDmu28Hzr93k1uLJseqcw6uJrBeCaRl47+DqsHHQfeGLJj7vDRo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595095; c=relaxed/simple;
	bh=JTDecRpwrYAS6GptqK6+EPctzrsq8DcXNhTT/K+21yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L70y7XPdz/IRjxtBKvIx4ZkYiBJYll061GijN/oqI87QREv+xeehZRz7h6CpO1o9DiZ9GiwB5UpbW4GVNiKEb+VSR7GZlDQYI6ryOBP03xRrdjF2SxpiduHD57xPDyYTlZ0zE5LD/YMjOZxQMD0v2Mkm0IXnh+93CMRrbbPbQDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E+uxAvFa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F021F000E9;
	Thu,  9 Jul 2026 11:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783595094;
	bh=5ylhwXeOPpfc7u6cPcoTXBBg2b7DLONZ3BXF8VdjG8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E+uxAvFaQu7j9nNdYj/hF4EUVZGbahCKCwNK3Zo157OIrKUDCyh4B+uS6ooy3hqXa
	 cZN7fbhbubKP16jsGA7qLTRIu3hUR/9XriOpCtTt/YnrvLMeRDW+cKaljfGd7+qape
	 H7OQcxDM+LVt3BxMPd2TufXtl+peb19mTqcZNdLg=
Date: Thu, 9 Jul 2026 13:04:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: jiucheng.xu@amlogic.com
Cc: stable@vger.kernel.org, jianxin.pan@amlogic.com, tuan.zhang@amlogic.com,
	JY <JY.Ho@mediatek.com>, Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix UAF issue in f2fs_merge_page_bio()
Message-ID: <2026070937-unveiling-atlantic-b798@gregkh>
References: <20260709-origin-5-15-y-v1-1-5ac64636d2e8@amlogic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-origin-5-15-y-v1-1-5ac64636d2e8@amlogic.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272881-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jiucheng.xu@amlogic.com,m:stable@vger.kernel.org,m:jianxin.pan@amlogic.com,m:tuan.zhang@amlogic.com,m:JY.Ho@mediatek.com,m:chao@kernel.org,m:jaegeuk@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gregkh:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amlogic.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23F3973056F

On Thu, Jul 09, 2026 at 05:35:40PM +0800, Jiucheng Xu via B4 Relay wrote:
> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
> 
> commit edf7e9040fc52c922db947f9c6c36f07377c52ea upstream.
> 
> As JY reported in bugzilla [1],

What kernel(s) is this for?

thanks,

greg k-h

