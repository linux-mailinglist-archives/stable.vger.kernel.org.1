Return-Path: <stable+bounces-240105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FmaJ4VJ52lW6QEAu9opvQ
	(envelope-from <stable+bounces-240105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 11:55:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9594392E2
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 11:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FA0630497BC
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0743AF66F;
	Tue, 21 Apr 2026 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="p2CwlWz8"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51994414;
	Tue, 21 Apr 2026 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765123; cv=none; b=iSbJ7Bu9sdrOTY+zKUJyD2jLn62J99abEKSLK7zdT2LWm/XgHTWK7dXM0wHInvTrmbxFJTVxl/av1XW5r+mwkLeKgPTy3cPV0yeOiTshbD6mNMc3grExwPqK0cnB7dkrJxEp6CjSn1zEniqjjaacaXyj+V0xxmp9ggcQO3oczgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765123; c=relaxed/simple;
	bh=09YPZAKY7rOpxPUVTsTAmxP+32o1aRIEB6eOcqRhE9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYTf0Z9AwRWH3+KYEzd9CQTnS5jN5FDQAOyVgVN7NyvEPLp6FBO/vgFl2rUsc/ZNFomkDS637LV5dRoCG4luMJQYMODe/xLp2fglQYpnkBTLgFJ5iDczwBc2+duLr+4ScyDALFJdsslkVV8xZ6+C6ZVsW9vzD+WZfAE65DqxMxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=p2CwlWz8; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=83aVEK9f9SufcwCkUntBBw2eItisKLS4TV7VwcFpGhQ=; b=p2CwlWz8heTBsicOtaS2dH9rBt
	Kr4Td/2WmHq18jsZCKQDBg+pO7qQBnsluvlLuZkKpBNRyCr07yRuJMh0U3YcVpMTX6TqmB0/XDT7j
	Jpyttg3XmIA+/oVluiKg+WX0jEB4BAfgJcYOJSCHyyMvtrwoAHg9kpJVrSA7ZPQ08IsYKt1/EuKSi
	d9pvrqYPTApN5+eYn/4kGTcHeTz/KLCe/5NlZZ/9OB4gqj+qoiPZE5xx6056yfvcs4Sivix9RU52p
	LbT5mT65YUAtTEjy4OPDHHSiz+zYjo8M7QzF9svrO1RI8A2pZh3RkXmV1mq86aZM1yRKogYzo8SWy
	KX9JieMQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wF7lj-000lhS-10;
	Tue, 21 Apr 2026 09:51:47 +0000
Date: Tue, 21 Apr 2026 02:51:42 -0700
From: Breno Leitao <leitao@debian.org>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Hanjun Guo <guohanjun@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Huisong Li <lihuisong@huawei.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, pjaroszynski@nvidia.com, rmikey@meta.com, kernel-team@meta.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] ACPI: arm64: cpuidle: Tolerate platforms with no deep
 PSCI idle states
Message-ID: <aedGoi-Fk5HPK0OO@gmail.com>
References: <20260420-ffh-v1-1-6b4c10fec442@debian.org>
 <20260420-sturdy-unique-shark-c4ca8c@sudeepholla>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260420-sturdy-unique-shark-c4ca8c@sudeepholla>
X-Debian-User: leitao
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-240105-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+]
X-Rspamd-Queue-Id: ED9594392E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 04:12:38PM +0100, Sudeep Holla wrote:
> On Mon, Apr 20, 2026 at 02:27:13AM -0700, Breno Leitao wrote:
> > -	count = pr->power.count - 1;
> > -	if (count <= 0)
> > -		return -ENODEV;
> > -
>
> Does it make sense to retain this check like
>   if (pr->power.count < 1)
>   	return -EINVAL;
>
> Though I see the assignment to pr->power.count in drivers/acpi/processor_idle.c
> is through unsigned int. So I am fine even without the above check.

I don't think the check is necessary. When count is 0 or 1, the loop
for (i = 1; i < pr->power.count; i++) body won't execute, and the
function will return 0.

This seems like the correct behavior — if there are no FFH PSCI states
to validate, there's nothing that should fail.

Additionally, returning -ENODEV would trigger the "Invalid FFH LPI data"
error message, which would be misleading since the LPI data isn't
invalid, it's just not present.

That said, please take this with a grain of salt since I'm not deeply
familiar with _LPI states and their expected behavior.

Thanks for the review,
--breno

