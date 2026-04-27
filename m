Return-Path: <stable+bounces-241210-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FFo8F5D07mn+1wAAu9opvQ
	(envelope-from <stable+bounces-241210-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 07:30:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E0446D39A
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 07:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E8B8300A748
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 05:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6B227AC4D;
	Mon, 27 Apr 2026 05:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlfMk/yd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB1040DFA5;
	Mon, 27 Apr 2026 05:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777267850; cv=none; b=L8df+jZF2DwXWpDKUxtmvRkebyhdogYmqI7vY8QhFtmHxuSPhfR5psW+E+3yyl6UcEreZrRQ4fWCNmhbAwjQa5Cp6pkXbpMa/un0vu0YTQlfUxBGp/lh0G3l2TqaaNYMN7DDKio6dttxWDWpc1IHV0RgHBPNM3Rl4hrhbPoflbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777267850; c=relaxed/simple;
	bh=zM0v6VqgoySR2CiA5H4Q5YFlHnUVTM7lRp0ZIity4dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hdwdINx5bBCIJUaiAQrfMNo6g6pjJ97qL4fYzx9qZ8pAXOdkB2LGKGAnAazay8oqp+r9mA/FsFqFHPEkXAT1NNRdJsvHB/XlEdYpg5LyRXTaKcMmsMesVz1Eoop+U8YL6bGBaTNzpSIPLj4eY1rrDJVkXl4YTYYTL3GvjPqMk4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlfMk/yd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C1EC19425;
	Mon, 27 Apr 2026 05:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777267850;
	bh=zM0v6VqgoySR2CiA5H4Q5YFlHnUVTM7lRp0ZIity4dk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nlfMk/ydTPFXH4hipfvRCq07Sd/q/03iwqrmejTabIg6DGEe1Gbu+a+A7LWLkv4hr
	 3GlA6H4Fvn+jPNziqcI4GEUxQpLJq1GgPkr0/uTAWcBE9MnJc8lKfppm24bqrsMi+h
	 +nJsUevGln5dgNVX8JRwYwnMUC4bHsWWX46Sr4Bb0943HkWgNmJDOXlyV5FvZ9v5pN
	 vvmez8V7ihWv0vtewIBXUetSLOt+BhWjhnpZRVJ3UXrDbCxtIOTbS/SajgFypDRKCO
	 WjEvUNBZsDuycW303XIEajJnxyoeuu/OexNiIavN/W2sFv0yN0aPSSZwaoZu4U8pRl
	 uoJbBKGGN/AcA==
Message-ID: <f3005356-c9d8-4bc4-af72-ad02866bc8bc@kernel.org>
Date: Mon, 27 Apr 2026 14:30:40 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: pci-epf: fix heap overflow for invalid I/O
 SQES/CQES from the host
To: Junrui Luo <moonafterrain@outlook.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
References: <SYBPR01MB7881878B234CD11D13DCAFCCAF2B2@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <SYBPR01MB7881878B234CD11D13DCAFCCAF2B2@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C5E0446D39A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241210-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[outlook.com,lst.de,grimberg.me,nvidia.com,kernel.org];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email]

On 4/24/26 11:24 PM, Junrui Luo wrote:
> nvmet_pci_epf_enable_ctrl() computes ctrl->io_sqes and ctrl->io_cqes
> from the host-controlled CC.IOSQES/CC.IOCQES fields and only rejects
> values below sizeof(struct nvme_command) / sizeof(struct nvme_completion).
> The resulting sizes are used as DMA transfer lengths against the
> fixed-size iod->cmd (64B) and iod->cqe (16B) buffers.
> 
> An oversized IOSQES causes nvmet_pci_epf_transfer() to overflow
> iod->cmd with host-controlled data, and an oversized IOCQES causes
> memcpy_toio() to leak adjacent slab memory back to the host.
> 
> Change both checks from '<' to '!='.
> 
> Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

