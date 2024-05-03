Return-Path: <stable+bounces-43037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EB18BB414
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 21:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0DA284112
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 19:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4176315887D;
	Fri,  3 May 2024 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FAIxbpGs"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823BA339A1
	for <stable@vger.kernel.org>; Fri,  3 May 2024 19:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764770; cv=none; b=ZkzAgo5Hm/M4pzhaXOWjrJoidKHCaEe8nLPGRNjDlDhs+yOIFS/V6BWSFDn388dowct9izzCGaWvaaLKP+hX8pDAAaQpCP1WoqYC4mYuZz2r8xSoM8GguBRRsIqzbLQA5KljzirVnzztu9wFCbRWXGN/xp9uIMjTOGuUACB977U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764770; c=relaxed/simple;
	bh=pQZGSI3aJEy2zlBw78TT0e8lBxySC7j1UGKGotHcUoQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lg0IkuosQfUyMR2lqzWjPxgHgEJ+Mzy8K7H6Oa6U3Gby7DlS+2EOe4t1F3tSkkBmM++4gXiQl/2fLnQps9iAq2zGXEooX2hyXYaikdBYdpQRR/nFG5f5LztSuGCJtlwbrWdda+XA2YckW6K86Qt08/zk9QnZPdnD9pg5FDAoBm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FAIxbpGs; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <334617fa-71c2-40a9-9c6f-d5f56c11448c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714764766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1oIMl8WbrPn3vhHIGpaNgf49/6UPOvNrGm1EXjpmcc=;
	b=FAIxbpGsFB8+hDiycUmcDDDpjn0XWNq06ICBKUiW6G642mFuP0IM1nOSmXSzNK+f4Nn7Uq
	eqqQwVvgHphCpn+hPyMfBudvHw3aLtkUd5YnPZ2lcddwK8C0z+a10lbUcLYJuCK/YkIJQH
	GH8ub1+fMRUXrATuQbyJ9r2+hv12w10=
Date: Fri, 3 May 2024 15:32:41 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] nvme-pci: Add quirk for broken MSIs
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240422162822.3539156-1-sean.anderson@linux.dev>
 <ZiaVEfdUXO97eWzV@kbusch-mbp.dhcp.thefacebook.com>
 <dfa3124d-f2e0-4a57-ae1b-618552711b8d@linux.dev>
Content-Language: en-US
In-Reply-To: <dfa3124d-f2e0-4a57-ae1b-618552711b8d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/22/24 13:15, Sean Anderson wrote:
> On 4/22/24 12:49, Keith Busch wrote:
>> On Mon, Apr 22, 2024 at 12:28:23PM -0400, Sean Anderson wrote:
>>> Sandisk SN530 NVMe drives have broken MSIs. On systems without MSI-X
>>> support, all commands time out resulting in the following message:
>>> 
>>> nvme nvme0: I/O tag 12 (100c) QID 0 timeout, completion polled
>>> 
>>> These timeouts cause the boot to take an excessively-long time (over 20
>>> minutes) while the initial command queue is flushed.
>>> 
>>> Address this by adding a quirk for drives with buggy MSIs. The lspci
>>> output for this device (recorded on a system with MSI-X support) is:
>> 
>> Based on your description, the patch looks good. This will fallback to
>> legacy emulated pin interrupts, and that's better than timeout polling,
>> but will still appear sluggish compared to MSI's. Is there an errata
>> from the vendor on this? I'm just curious if the bug is at the Device ID
>> level, and not something we could constrain to a particular model or
>> firmware revision. 
> 
> I wasn't able to find any errata for this drive. I wasn't able to
> determine if there are any firmware updates for this drive (FWIW I have
> version "21160001"). I'll contact WD and see if they know about this
> issue.

Well, the response from WD support was "we don't support Linux, and if
we did there aren't any bugs in the drive anyway".

--Sean

