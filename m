Return-Path: <stable+bounces-159454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8E7AF78CB
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 16:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5501CA0682
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B172E7BD6;
	Thu,  3 Jul 2025 14:51:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC53C126BFF
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554284; cv=none; b=tvTmGV+afqh0v4fwfq0jTiv/oM8CgLlhNC58N37FcI3j62FoP9wZI7tdjxARtWxxAFHM72bAWn7+SNExw65jO9et5CXyQ7wg9fu7f5wMUyqJ7EPEp+5FxjFp0xiHmx3QjyXMNslmdHiDp5es3X1tEfYrVbXido3GROUm4yxf9j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554284; c=relaxed/simple;
	bh=kye+yW/PGf4a1wyFawF/Y4gnEDEx7bXSNkEIwJYshNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwDeIsZ+Lop8ZGamUAoUhrjVP3+4oGO5ttjNjEf9Wb2x0w7DRxzmNDk9US9adpYSbUeIfDCU76xJYJoN5EpMJZvcCi5GdOoCbjh2JKy1jFdqPX28pVuQuMgJmiz0XqthlQRUxgDL7EbfiABi29onmZsozgsQCByx1L5rjZL2WfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 8EFB42C0665E;
	Thu,  3 Jul 2025 16:51:13 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8824C404CCF; Thu,  3 Jul 2025 16:51:13 +0200 (CEST)
Date: Thu, 3 Jul 2025 16:51:13 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>,
	Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 020/218] Revert "iommu/amd: Prevent binding other
 PCI drivers to IOMMU PCI devices"
Message-ID: <aGaY4Y9trrnMlxO-@wunner.de>
References: <20250703143955.956569535@linuxfoundation.org>
 <20250703143956.766086832@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703143956.766086832@linuxfoundation.org>

On Thu, Jul 03, 2025 at 04:39:28PM +0200, Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me know.
> 
> [ Upstream commit 3be5fa236649da6404f1bca1491bf02d4b0d5cce ]

This should not be backported to stable kernels.  It does not fix
any known issues, but conversely it is known to cause an error
message on boot, for which there's a fix pending here:

https://lore.kernel.org/r/b29e7fbfc6d146f947603d0ebaef44cbd2f0d754.1751468802.git.lukas@wunner.de/

Long story short, please unqueue this one. :)

Thanks!

Lukas

