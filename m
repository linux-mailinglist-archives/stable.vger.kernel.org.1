Return-Path: <stable+bounces-219767-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBaRDNj2n2nkfAQAu9opvQ
	(envelope-from <stable+bounces-219767-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 08:31:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F811A1DC5
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 08:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 216D6301CDB0
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 07:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADAE3195F0;
	Thu, 26 Feb 2026 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kls4wg+L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67CB1DF74F;
	Thu, 26 Feb 2026 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772091093; cv=none; b=XCB4Mb0W+PkG4RHV7hVcGtmsy3SpnmNznxwLtgj8SWxd7JwmpwnBcsp3vJsAGIQtejAQJHn8bRJOnGEKYhuU0n4M4XLbHWKV/P7zajRKjJ90IveYljZLt10CfkoFwvhX1C1Ib66AULGV3YDVpn70Kj0E/IQ+V3X2k1O18TOrcyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772091093; c=relaxed/simple;
	bh=mQA+Qh9+1pZmdXOAWbzNNMho9Mer/jQIxqGFENnnDiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkHfwaRoTs9NB3vRrdJ4T/nVlCdlIoZpPwIvtEId4DSf+zipOwwiAkj26EFxngpMZjw3Try2Nug7oM95egEJgsv8r6E+EzdB+pTKQxEG5wpP4CKh8yZfXftprawdrw2trNUlSAF6ZcaVdQcab0OVWG+q+BCC1swtX+Yo1bXP3Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kls4wg+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367CAC19424;
	Thu, 26 Feb 2026 07:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772091092;
	bh=mQA+Qh9+1pZmdXOAWbzNNMho9Mer/jQIxqGFENnnDiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kls4wg+L0sBNVM9cAaVmIdKiQAJT4kT55056/pvAgodCzPzKLwB/y+9SBDZLXKUKh
	 nk+Cs8uDXayzuzgmzt5VWSdBRBTc8SyX1wQW0L8nYgDlXtHC56NrDETaf2XBcb53gj
	 5eORw3Z3ApF68/Rx3RCbHUXd+bPOvD7ejpstI7M5/ZCqy8lLkh2ueEb/W2b8ZCEiEd
	 WZarzXgA/CQjZ1O+Qxe+HxGzzq/+uoA9ej8oxBovb5amt+qCYyYGypaJJmcrTUbgp9
	 x1woIoBNHDkuc9RgrKuNMoEGB+M4mvyI9e67j8YPHEYO520mSm9gNjWfZ9WGopsFG3
	 cHzryMKjYs1YA==
Date: Thu, 26 Feb 2026 13:01:21 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: liziyao@uniontech.com, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, niecheng1@uniontech.com, zhanjun@uniontech.com, 
	guanwentao@uniontech.com, Kexy Biscuit <kexybiscuit@aosc.io>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, kernel@uniontech.com, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Lain Fearyncess Yang <fsf@live.com>, 
	Ayden Meng <aydenmeng@yeah.net>, Mingcong Bai <jeffbai@aosc.io>, stable@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH v7] PCI: loongson: Override PCIe bridge supported speeds
 for Loongson-3C6000 series
Message-ID: <mkvt7qwpuy2rnhnpamjca3tsoipfdzjweymfuxwfzadelxyqgs@bw755m4cpj5g>
References: <20260121-loongson-pci1-v7-1-fc79c85a574d@uniontech.com>
 <taoupjxwaewzvolh2n6bciji36j4dx6jtvjf7k6tt5hdt54hjw@rrgbu47umz4v>
 <1d86afeeb6f9e7aa4ab1310d6339ad8dfb349a00.camel@xry111.site>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d86afeeb6f9e7aa4ab1310d6339ad8dfb349a00.camel@xry111.site>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219767-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[uniontech.com,kernel.org,google.com,aosc.io,vger.kernel.org,lists.linux.dev,linux.intel.com,live.com,yeah.net];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93F811A1DC5
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 03:09:34PM +0800, Xi Ruoyao wrote:
> On Thu, 2026-02-26 at 12:01 +0530, Manivannan Sadhasivam wrote:
> > > Cc: stable@vger.kernel.org
> > 
> > Since this is a bug fix which needs to be backported, what is the commit SHA for
> > the Fixes tag? The one which added Loongson-3C6000 support to this driver.
> 
> The PCI controller driver didn't have any change specifically for
> Loongson-3C6000 before this one, but the kernel will only boot on
> Loongson-3C6000 if the AVECINTC support (commit ae16f05c928a, i.e. Linux
> 6.12+) is available.
> 

So can you share the commit that introduced the Loongson-3C6000 platform?
ae16f05c928a just added the AVEC support. Though this might be necessary for
booting, this is not the actual commit that introduced the buggy platform
support.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

