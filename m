Return-Path: <stable+bounces-231359-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFgRFHWHy2kuIwYAu9opvQ
	(envelope-from <stable+bounces-231359-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:36:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BCC3663D2
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BC213025C66
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 08:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CC93630AD;
	Tue, 31 Mar 2026 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="HHjDoJEd"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [185.244.194.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B844298CA3;
	Tue, 31 Mar 2026 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.244.194.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774945944; cv=none; b=lnE7dj/Afa/WjFZTY7QlEr2GgwQVFTZD0MN7zb7Hi+BFpPEEhIdRZBZ9eiyz+AvysIfXXIDdArxWTEfPMKV2g+ztuXY1gCrc+PomBEz/vhZwtmmtSAtZBFzYWpqHQSRQn3DADt8e3GWu5UvnQydRxJgp2q8GRd1g9RFTh0MLdAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774945944; c=relaxed/simple;
	bh=7IpDhYtokFqYLVQDcX7rImeQMvBoK4UVJ7DW/xKkzo0=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:To:
	 In-Reply-To:Content-Type; b=cCmdocmNNGeWbPx4CIAl9XKGi9mO8MtZe3uJTel8ySEi8uyjmyRevqnnNiWJNeDWtlBbWxiDPaPjdesVCRZU6grbeYHY0cXHhjiVMMnERA09EYlJyKV242WyYLzQL2VThucOwOd0WMfIqShd4ZpGHwXrqkwCtTuiUDvly45nH1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=HHjDoJEd; arc=none smtp.client-ip=185.244.194.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4flLjX00M9z94Mf;
	Tue, 31 Mar 2026 10:23:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1774945408;
	bh=7IpDhYtokFqYLVQDcX7rImeQMvBoK4UVJ7DW/xKkzo0=;
	h=Date:Subject:Cc:References:From:To:In-Reply-To:From;
	b=HHjDoJEdph0AOjNAJz6dRmcPp7j73Yw/SygLwr3KxeMnVxwLc9VsCQh0w4LcWCCWi
	 VsgvlWu3XrVLSFjNzTfYiiJKm2onnZvMyFhsbq3OzU2FkXvB22yNPp7IX6//ZcEp1Z
	 mW3HYHKdaPdSi+jnGq98nc3Z4DNdgGbZsSnWgps+HVoviJp13FenAEe7XO4/dB2oeN
	 bHV4jgQn6Ovd9RLt6VdvQglzD7bDz3qAdJaZDCKeKhUpCzKjQ9xoOD82mD/zBgvWFZ
	 sBnI4M/fvKCAEL18quf+WqzkE3DmYJWvjEYKokw2P31yQewY6Mp6ifpWcUdXDT/qRr
	 PETy68xPencCQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4flLjW6PLWz7xN0;
	Tue, 31 Mar 2026 10:23:27 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4flLjV6RNSz8svf;
	Tue, 31 Mar 2026 10:23:26 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 3520C635FD;
	Tue, 31 Mar 2026 10:23:26 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <99426bd8-32e5-4246-9d3b-772e136bc078@leemhuis.info>
Date: Tue, 31 Mar 2026 10:23:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] PCI: Revert "Enable ACS after configuring IOMMU for
 OF platforms"
Cc: John Hancock <john@kernel.doghat.io>, stable@vger.kernel.org,
 bhelgaas@google.com, manivannan.sadhasivam@oss.qualcomm.com,
 joro@8bytes.org, linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 Manivannan Sadhasivam <mani@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20260320172335.29778-1-john@kernel.doghat.io>
 <o7nnlvtkmatzafs44um6h5wnqo755msiukfn6kbu2zxdhe45ws@mde5lt2ufusz>
 <fad11c37-5bfb-44fd-b0bf-2a2d15b3382c@arm.com>
 <ovfco6pqzw734flu7navat36avt6yfosruouduhmbti7umunus@ijmu6nhz56l5>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
In-Reply-To: <ovfco6pqzw734flu7navat36avt6yfosruouduhmbti7umunus@ijmu6nhz56l5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177494540663.2020972.9530421463839943276@mxe9fb.netcup.net>
X-NC-CID: 3xzz847nKWelt8aC5ygN7tpAEHCa5Hi/PfXCYrf6D4kpXqVsB7M=
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	TAGGED_FROM(0.00)[bounces-231359-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DMARC_NA(0.00)[leemhuis.info];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B9BCC3663D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 16:13, Manivannan Sadhasivam wrote:
> On Mon, Mar 23, 2026 at 03:06:16PM +0000, Robin Murphy wrote:
>> On 23/03/2026 1:54 pm, Manivannan Sadhasivam wrote:
>>> On Fri, Mar 20, 2026 at 01:23:35PM -0400, John Hancock wrote:
>>>> Commit 7a126c1b6cfa ("PCI: Enable ACS after configuring IOMMU for OF
>>>> platforms") introduced a regression affecting AMD IOMMU group isolation
>>>> on x86 systems, making PCIe passthrough non-functional.
>>> [...]
>>> Ouch! Sorry for the breakage.
>>> [...]
>>> I still haven't investigated this failure deeply, but it is also worth noting
>>> that this regression only happens with v6.12 and earlier stable kernels as
>>> mentioned in [1].
>> Oops, indeed, relying on pci_dma_configure() to be called prior to group
>> assignment in iommu_init_device() only works since bcb81ac6ae3c ("iommu: Get
>> DT/ACPI parsing into the proper probe path") added that call path in 6.15 -
>> thus the backport probably doesn't actually work for OF platforms either.
> 
> Ah, that makes sense. Thanks for finding the root cause. It might be very
> obvious to you, but still... ;)
> 
>> Dropping this from 6.12.y and earlier stable branches seems like the correct
>> action to me (but not a mainline revert, obviously). ACS had essentially
>> *never* worked properly on OF platforms prior to 6.15, but that was more
>> down to fundamental design flaws in the OF-based IOMMU probe path (dating
>> back to 4.12) rather than any easily-fixable bug as such, so realistically I
>> think we just leave it that way.
> 
> That's my opinion as well. I guess I need to send reverts for rest of the older
> stable kernels as well.

Mani, did you send those reverts? I could not find any on lore. And the
one at the start of the thread likely won't work, as it doesn't state
that c41e2fb67e26b0 ("PCI: Enable ACS after configuring IOMMU for OF
platforms") needs to be reverted for 6.12.y and all earlier series. So
to speed things up:

Greg, Sasha, could you maybe simply revert that backported commit
directly in 6.12.y and all earlier series?

Ciao, Thorsten

