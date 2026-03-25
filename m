Return-Path: <stable+bounces-230283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMzGKGGjw2lssQQAu9opvQ
	(envelope-from <stable+bounces-230283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 09:57:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDEF321BA7
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 09:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 190ED300AEF8
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 08:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6414239B48F;
	Wed, 25 Mar 2026 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T2UrqIJA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E6330EF8F;
	Wed, 25 Mar 2026 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774429023; cv=none; b=W/xNhq1rBRQ43LuYABqg3slyAduPugu8feBZYsDLIU+/1vAHV7brj+DnVg1465v2pdRec75hDp7oAzs3Mz66VJi1/JYD6h+IWGppf25Ewbr9U3e/IF46I34b6EPEYme5rpdQtgSUTTb3DfO1b7TxWUIP5LKX0mUw9paL8feNA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774429023; c=relaxed/simple;
	bh=ASb4qupdpo3t59cNNXSuFHQ4PhJqBhPSPN6ncoCGWmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEz4oU6WOytNn3ACq56pX52Wm8zPSL6oH4UtIdV9ZagUltbYorOgTQSelAcDYDyA9lGIY57MjZUTMMEeovSKVPyHuX44hFG6tfxjPtHiTz0LMu6+ZvJnZGx2aH5Qvxy8UZvYLvgP6MVuNUywL5q974NdGuwQOwh0vW6opuehzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T2UrqIJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420D5C2BC9E;
	Wed, 25 Mar 2026 08:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774429022;
	bh=ASb4qupdpo3t59cNNXSuFHQ4PhJqBhPSPN6ncoCGWmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T2UrqIJA2QgOqgRocCqFH673n3qNaRK+AJfMcBJUeuS5VcICnRIwHRfd8JcmnJV2G
	 xQkaHOfK4JGZii/BuDw1zggIGljycgxpwFHo3D+5uenSI5X9mPWyQdt8SIexLZzvlt
	 ulhQNfd2rSEo5XJuH/vulAICmKVQklbANMHaO680=
Date: Wed, 25 Mar 2026 09:56:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Keith Busch <kbusch@kernel.org>, stable@vger.kernel.org,
	patches@lists.linux.dev,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 6.19 378/378] cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig
 tristate mismatch
Message-ID: <2026032511-construct-blurt-07cf@gregkh>
References: <20260317163006.959177102@linuxfoundation.org>
 <20260317163020.886316423@linuxfoundation.org>
 <acK_mxmLlvD5vQog@kbusch-mbp>
 <551037c4-665e-4701-9689-a75bdabe4211@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <551037c4-665e-4701-9689-a75bdabe4211@intel.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230283-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FDEF321BA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 09:49:43AM -0700, Dave Jiang wrote:
> 
> 
> On 3/24/26 9:45 AM, Keith Busch wrote:
> > On Tue, Mar 17, 2026 at 05:35:35PM +0100, Greg Kroah-Hartman wrote:
> >> 6.19-stable review patch.  If anyone has any objections, please let me know.
> > 
> > No objection, but a little confused how this got to stable before
> > landing in Linus' tree. Does stable pull directly from downstream
> > subsystems now?
> > 
> > Speaking of upstream, will the CXL maintainers be submitting a pull
> > request for the staged fixes soon? I'm just getting new bug reports from
> > people testing 7.0-rc, so wanted to check in on that.
> 
> I can send it today. Looks like I got enough days in linux-next soaking for the PR.
> 

I took it as it was "obviously" correct, fixed reported regressions, and
it was in linux-next and going to Linus "soon".

thanks,

greg k-h

