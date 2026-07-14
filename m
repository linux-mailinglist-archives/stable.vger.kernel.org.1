Return-Path: <stable+bounces-274126-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0bMlLjTGVWrPsgAAu9opvQ
	(envelope-from <stable+bounces-274126-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 07:16:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F097510FA
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 07:16:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ufuW9pbH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274126-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274126-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7362630BBFF1
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 05:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C7B2F39B9;
	Tue, 14 Jul 2026 05:12:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EF12F5A0E;
	Tue, 14 Jul 2026 05:12:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005941; cv=none; b=rDXxC3mb/8ku2jw6cYZTVFfI4BpFj8FHCqmoMwDSaHCxG60B2m2/EhNhcXF4hpu6COgRPDBKj/Pqew5JWb+lPM8QR2ZmnkO3hScd4RYpzBksJeq8esV/h0ZT5jTeQa88VWJzcPec45kwx8XVgLexvaopvSUslFgBtxnGLdbGpec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005941; c=relaxed/simple;
	bh=QKLHpYC9cD10hDiGlFe4/QTrEv2pYoWptLgAsLjXIE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtWHCTnzkKdRq2peF921RuAtrk7a4F+RT7BvD1y8EuQ6Lm+a0UcH0sLjrAOaeqgjSOM88fkB1AstIKSFjByU9rmTCAP3jZCmtc9OrTVclZdnJSypsGCIzBat5v4aytOfQFLoIkNBpj724osso/YRjrPIOyrv2r6Xo04cfLfTByk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ufuW9pbH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DE51F000E9;
	Tue, 14 Jul 2026 05:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784005939;
	bh=TMXzA4wrYATAkRbd0MtGWCT8lsBcidpH7evOMPd0N8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ufuW9pbH7t+BO068AtApQMfa4+R7cKxsBYRakma1PEbq7EB76XZ69ffufKfWQMuem
	 f85rZKZBc6EuYiVdHJSbXn1izuXBuR+2eXapNX2n9Og9RT1CeamIHN7/upL3odkuGa
	 MVa20/aJOfYrBOAFuzn5EHWR0Oi5pGxxGx0gd9zA=
Date: Tue, 14 Jul 2026 07:11:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Qi Xi <xiqi2@huawei.com>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, sunnanyong@huawei.com,
	wangkefeng.wang@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH stable/linux-6.6.y] mm/memory-failure: fix missing
 ->mf_stats count when hugetlb folio already poisoned
Message-ID: <2026071451-geologic-handprint-89d1@gregkh>
References: <20260706084118.1284271-1-xiqi2@huawei.com>
 <6a756801-f4a5-44a5-abfd-e9ae57432c56@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a756801-f4a5-44a5-abfd-e9ae57432c56@huawei.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274126-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:xiqi2@huawei.com,m:naoya.horiguchi@nec.com,m:akpm@linux-foundation.org,m:sashal@kernel.org,m:linmiaohe@huawei.com,m:jane.chu@oracle.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:sunnanyong@huawei.com,m:wangkefeng.wang@huawei.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32F097510FA

On Tue, Jul 14, 2026 at 09:45:03AM +0800, Qi Xi wrote:
> Add stable@ to Cc.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

