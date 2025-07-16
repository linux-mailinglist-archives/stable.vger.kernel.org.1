Return-Path: <stable+bounces-163207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B09B08099
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 00:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7A63B1A45
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 22:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920842C1798;
	Wed, 16 Jul 2025 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wtd610Ub"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD9623643E;
	Wed, 16 Jul 2025 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752705736; cv=none; b=mjLsrLZzTea7ZHQs3LjnxGlbFwsuooZPk+5sw5F5pNT0EPxI5+SYTJB1ANMcHqrL00FOxx1GNexqaEbGP5NP8AdZXajXSe0WNq8pKA4BqjMQezAJDxlkiVe5xps3szJi+rt7yVleY/ABupyRvdikCSlIsh47QV1yXpw9+NGWnnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752705736; c=relaxed/simple;
	bh=BDU0QwTkYYYml9+wrEWCNYH/PF64qV4ohna/oUUOVPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ir1oPX3HcAtFPmLN05ISxSsyz3uRmiQh6kKvHMSFdWE/F4Rn1EfO/nkVXkJdyvQEWHxFRaMWtJZvGeozETBRW+ehxs5jJCIYVsNvPgXBmoGdvqhlNA16+hqdfz/P/XoZgfWjQpOpOuqlGmGow8ysP0tNjjOZXOjxM7GHsE3gRlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wtd610Ub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDF8C4CEE7;
	Wed, 16 Jul 2025 22:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752705735;
	bh=BDU0QwTkYYYml9+wrEWCNYH/PF64qV4ohna/oUUOVPw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wtd610Ub7xDxqlPgIABnXwl8AZ/X7mBkpugWp9h0NbAETlokzYYM07xSKyg0ss/F5
	 uB+KAfi/wTOFiJqS9ZAHkL0uyKZzZV+DJ1ihkv0BF8AANuyNexf71HmJ+jImZ53hKs
	 TqYi9ebap+ZnZMi4yf3vmAoNhtEeBl0e3FwjsYtk8+9YC1XqACY8CTIosupZihv42g
	 n9UIQ83DIT1h+JGz+I/MjhPlEVF6OTXeO09pNBI4ERBlVle6Kw/XLqnTpjQ88FOnKG
	 mBtC5CNWk2htlR1nBCD5rZPU0MKYydpkpTcMyTyD/xHR+fmimq6fmc+m29SMlFsKqa
	 aQ+7Qy4y1/Xng==
Message-ID: <fee4f767-301b-4650-8607-28fce17924ad@kernel.org>
Date: Thu, 17 Jul 2025 07:42:12 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] nvmet: pci-epf: Do not complete commands twice if
 nvmet_req_init() fails
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: "rick.wertenbroek@heig-vd.ch" <rick.wertenbroek@heig-vd.ch>,
 "alberto.dassatti@heig-vd.ch" <alberto.dassatti@heig-vd.ch>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20250716111503.26054-1-rick.wertenbroek@gmail.com>
 <20250716111503.26054-2-rick.wertenbroek@gmail.com>
 <ba009e79-e82a-478d-bf2b-52b964141c11@nvidia.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ba009e79-e82a-478d-bf2b-52b964141c11@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/25 06:56, Chaitanya Kulkarni wrote:
> Good catch, looks good, I wish we have tests for this part of target
> to it will get tested on regular basis, not the requirement, just
> a thought.

qemu does not have a PCI endpoint capable controller device and you cannot link
2 VMs to communicate over PCIe (one VM as host the other as endpoint). So unless
you get a PCIe-endpoint capable board, you cannot run this driver easily.

We can add a blktest case for sending an unsupported command though. That is
easy to do. But FYI, right now, running blktest/nvme group against a pci-epf
device, we get a hang... Shin'ichiro is looking into that.

-- 
Damien Le Moal
Western Digital Research

