Return-Path: <stable+bounces-235483-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MFoGhTx12n6UwgAu9opvQ
	(envelope-from <stable+bounces-235483-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:33:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFC43CEB76
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 696E23024791
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 18:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FEE37472D;
	Thu,  9 Apr 2026 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SPxcErhr"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A832E6116;
	Thu,  9 Apr 2026 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759627; cv=none; b=qAZxHD9jGtjrp5+kOUqbYX862565YIWbqjVfsIKbjIBgRc/UC3GwFWz0Rsbx1HCQDvkp/HQsF4AvZGfbMjM/SslsiQxMeFPRwLjpATEr11IvA7RbsCE4oqXU+Q7cAOlynGzOG/wwztC+cbSSJMgcQIZKW5Jm1f/vHJ9rACsBbYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759627; c=relaxed/simple;
	bh=2Mke9B5xsH/9FIs5H7tLC+6ccGXXOxuntv3Vt8y46q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptVCL+jmkeHYivADLT9zlE2/BMWpyXAwkEZP18rAl9sYqMH2HWjXCHJTMm70eszASOlZ+CaxieWiSTJyBULqX/dzgSzJ9brzqWfcQJrpwU8eC7/ZJ3YhTA7US66MPxWY0vTV3q++cDlgCgE68jU5sDUCYI39pnZVfOXFeT4GzBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SPxcErhr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E40262008;
	Thu,  9 Apr 2026 11:33:32 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E1043FAF5;
	Thu,  9 Apr 2026 11:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775759618; bh=2Mke9B5xsH/9FIs5H7tLC+6ccGXXOxuntv3Vt8y46q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPxcErhrEGrfcTD6Otef5JEhCmD9tgWrdUbCZtE/ZbHXWQKao0p7SVr2LaWwhDwnT
	 7Ad8rEg/X0nOWekqlpbOWRk3NwrmYCbm2aXm94fmBuPxceaIbJ36ndpYcz2EfDBu+a
	 CIInQmS/s+86kndcxnpn3wZnaGnmfQcNGIlb8s0U=
Date: Thu, 9 Apr 2026 19:33:34 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Jinjiang Tu <tujinjiang@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64: mm: Fix rodata=full block mapping support
 for realm guests
Message-ID: <adfw_hNDsIWwSAIv@arm.com>
References: <20260330161705.3349825-2-ryan.roberts@arm.com>
 <ac7VD4Z85nS30GCp@arm.com>
 <ac-W9oNM_O5RTtaf@arm.com>
 <beacee23-c177-47a1-b8b5-743844b617a8@arm.com>
 <adTPFrlVCEt-hioX@arm.com>
 <bc4a0246-33bb-443e-a885-a31b24d4a022@arm.com>
 <adTh8d9k3y5ybemL@arm.com>
 <567dff89-9f0f-40a0-ab10-22e061b4faaf@arm.com>
 <adfDoatH8hj6zN7_@arm.com>
 <07054475-6b07-4b19-a393-cbe037adef8b@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07054475-6b07-4b19-a393-cbe037adef8b@os.amperecomputing.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235483-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:dkim,arm.com:mid]
X-Rspamd-Queue-Id: 0EFC43CEB76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 09:48:58AM -0700, Yang Shi wrote:
> On 4/9/26 8:20 AM, Catalin Marinas wrote:
> > On Thu, Apr 09, 2026 at 11:53:41AM +0200, Kevin Brodsky wrote:
> > > What would make more sense to me is to enable the use of BBML2-noabort
> > > unconditionally if !force_pte_mapping(). We can then have
> > > can_set_direct_map() return true if we have BBML2-noabort, and we no
> > > longer need to check it in map_mem().
> > 
> > Indeed.
> 
> I'm trying to wrap up my head for this discussion. IIUC, if none of the
> features is enabled, it means we don't need do anything because the direct
> map is not changed. For example, if vmalloc doesn't change direct map
> permission when rodata != full, there is no need to call
> set_direct_map_*_noflush(). So unconditionally checking BBML2_NOABORT will
> change the behavior unnecessarily. Did I miss something?
> 
> I think the only exception is secretmem if I don't miss something.
> Currently, secretmem is actually not supported if none of the features is
> enabled. But BBML2_NOABORT allows to lift the restriction.

Yes, it's secretmem only AFAICT. I think execmem will only change the
linear map if rodata_full anyway.

-- 
Catalin

