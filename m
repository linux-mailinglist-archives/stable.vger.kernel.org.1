Return-Path: <stable+bounces-268898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CkDsBSV6PmoeGwkAu9opvQ
	(envelope-from <stable+bounces-268898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:09:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7B36CD4DE
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:09:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AkPWPq3e;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268898-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268898-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF75730265AF
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371E23DB335;
	Fri, 26 Jun 2026 13:09:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D95F30D3FA;
	Fri, 26 Jun 2026 13:09:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479390; cv=none; b=UxFm6N8ldZeapbq0jIsLvsPV5p/1Jek3UEZ82xEQZ0ohnEw3pmopul6ciaPJs5FxQ3eUKs3JqB+NmtTM04CRmf1s3NQPwCJW9fDUQWA4AcJiFUDYcafRaWdGxRsQju32sjQttBEffHQ+InvJJjNQrCBoNtTlDzh/DWsq+MInorE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479390; c=relaxed/simple;
	bh=+7AwrWVVzoVkvnv9P5vBhSQOWP/QHJ2Ebp6LBHG4hw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfhJ3LArrPSyzd+z5HRL2oUeMZVN/no8luDHxxJvK+PQNgtyYJDayhmH1FJVnwK4JJ3ax+nZP8mc4q7mRS8QSjOFUaupHuDTTI0knzICBIESZUCHwd4RKSv2VdKpsQaE7Pwu4F1CicjLiTA6ziUqni2K5CZvN12AoeEF5XRAKNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkPWPq3e; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB941F000E9;
	Fri, 26 Jun 2026 13:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782479388;
	bh=TTQHpmFLOxYjNbqLTyYlQveQHPZ7fEn2hUfjMLOJy6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AkPWPq3eupktwRWln5gvYhnuQoNW35/2Th/h195dqesXzlDp1qTlyKYdeBGlmmn5X
	 NF7ED+wlRwXF1v8ifd9Kk2M+QbrZ1/IHn0K42EzWkA/5rakO2VOxByorIQcyBVUvSA
	 9eTte6NNf4h0C+kaSbRIa03zs3+Nr6bCP/ejzNKNPUgNJ5g9YGKu+q/gn7IzHRr7XN
	 EVx4ZkHcjk2FTe9BqzEHnul4xfZuCtnsVFlBO44HNvKPu58TX2GAk464jtcIxkO6HD
	 NMShw67cZo6Tkn0JsPzjh/diWQnAE3W/x5+mINcnVsAW309brRA/4+mIKn6wq2eCbi
	 vlHq3AhUjVyrA==
Date: Fri, 26 Jun 2026 14:09:43 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: Make kvm_io_bus_get_dev() filter devices by ops
Message-ID: <aj56F3qIsYZ1_xlR@willie-the-truck>
References: <20260626111344.802555-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626111344.802555-1-maz@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:maz@kernel.org,m:kvm@vger.kernel.org,m:kvmarm@lists.linux.dev,m:seiden@linux.ibm.com,m:joey.gouly@arm.com,m:suzuki.poulose@arm.com,m:oupton@kernel.org,m:yuzenghui@huawei.com,m:pbonzini@redhat.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[will@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268898-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[willie-the-truck:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F7B36CD4DE

On Fri, Jun 26, 2026 at 12:13:44PM +0100, Marc Zyngier wrote:
> kvm_io_bus_get_dev() returns a device that is only matched by the
> address, and nothing else. This can cause a lifetime issue if
> the matched device is not the expected type, as by the time
> the caller can introspect the object, it might be gone (the srcu
> lock having been dropped).
> 
> Add an kvm_io_device_ops pointer to the list of things that this
> helper must check before dropping the lock and returning the pointer,
> and update the sole user to pass its own ops.
> 
> Reported-by: Will Deacon <will@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Fixes: 8a39d00670f07 ("KVM: kvm_io_bus: Add kvm_io_bus_get_dev() call")
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/kvm/vgic/vgic-its.c | 5 +----
>  include/linux/kvm_host.h       | 1 +
>  virt/kvm/kvm_main.c            | 5 ++++-
>  3 files changed, 6 insertions(+), 5 deletions(-)

Thanks, Marc, this makes sense to me:

Acked-by: Will Deacon <will@kernel.org>

Will

