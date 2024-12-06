Return-Path: <stable+bounces-98958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0961C9E6A15
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 10:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD00188478C
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 09:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8B11EE010;
	Fri,  6 Dec 2024 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="avQBwUmq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6451EC01B
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477370; cv=none; b=PvbeCwt64h4VJmF3Nek0UUQIa3icgEFEWnyH218LsvbI/PFNKJdGa00wyQ/J1Yngi+sH3jNsJTUaZWUlol9dfMMOZgtl2Ov+TWZCRB4BMdu8fkpG8kkbFhyEO0/qklLjfx68hedqpzXlDyfwEnjzj8Y4IyUnQwRNmjulMQOTWmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477370; c=relaxed/simple;
	bh=70vuK5PlueTU194jqNy5Lz3PRt/EpsZq69LtPiduwz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlKTX7/JVf3tbKQ4R/F5Iw7gavtb35cAN16RUsKrrasXuKO7SvgQTErKMKJGtkjjjYHuXG1I2MmQaBYzvB85auvChQS4ARxpc67EQcv1bK8L0DlgQW2meX7hH07tBpVUF8+l5NLrWhjKPbN2entGRQMUbnDLXpVovjENnB/jWm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=avQBwUmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0C5C4CEDD;
	Fri,  6 Dec 2024 09:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733477370;
	bh=70vuK5PlueTU194jqNy5Lz3PRt/EpsZq69LtPiduwz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=avQBwUmq+cbJVNKd0aSsMhuGfX78fsCZ9D/tieQlv9rUkEp0mN+TY2HKLlppX6+Ef
	 6quBYhp+RgQvrLlQZCRKc2xeN1Rk4TIwgZ6S8eVsc534EFoIH4oAvfM0m5VONvMvLT
	 UqBe6CMeow8iXL/jzpK69QaZSQpeLN8IoR1qr/HA=
Date: Fri, 6 Dec 2024 10:29:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jing Zhang <jingzhangos@google.com>
Cc: stable@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Kunkun Jiang <jiangkunkun@huawei.com>
Subject: Re: [PATCH 4.19.y 1/3] KVM: arm64: vgic-its: Add a data length check
 in vgic_its_save_*
Message-ID: <2024120616-starved-unmasking-a0fc@gregkh>
References: <20241204202038.2714140-1-jingzhangos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204202038.2714140-1-jingzhangos@google.com>

On Wed, Dec 04, 2024 at 12:20:36PM -0800, Jing Zhang wrote:
> commit 7fe28d7e68f92cc3d0668b8f2fbdf5c303ac3022 upstream.
> 
> In all the vgic_its_save_*() functinos, they do not check whether
> the data length is 8 bytes before calling vgic_write_guest_lock.
> This patch adds the check. To prevent the kernel from being blown up
> when the fault occurs, KVM_BUG_ON() is used. And the other BUG_ON()s
> are replaced together.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
> [Jing: Update with the new entry read/write helpers]
> Signed-off-by: Jing Zhang <jingzhangos@google.com>
> Link: https://lore.kernel.org/r/20241107214137.428439-4-jingzhangos@google.com
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---
>  virt/kvm/arm/vgic/vgic-its.c | 20 ++++++++------------
>  virt/kvm/arm/vgic/vgic.h     | 24 ++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 12 deletions(-)
> 

Sorry, but 4.19.y is now end-of-life.

