Return-Path: <stable+bounces-98860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7479E604E
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 23:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7640A167BED
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 22:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54291B4156;
	Thu,  5 Dec 2024 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtwVcCOb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0964282FB
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733436182; cv=none; b=Fam2VtkDNLC2pTUhLOJJFinycl0wPnTX49cQFheSicjXo0I5L2XuP2G5CGVw+FzxkjecwNKFIdjZGggtKZM0xm5qPisGUzQaV3Ig09rmsgGjUlOzNoJEUg31M09nmhCCuf9py7T2ZFglbULXBuvk7WPzCY6RSWvRIWlbPl92twk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733436182; c=relaxed/simple;
	bh=d+UCtLSa+055hfySG3GTEQEi131xlIBPoVRMayMtx1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSw72o8JC+uMD5J+0oqInq2BCRxErg8D9HIF4HwHAIdRYVYzewS/AC5iik+h0wsfOJ6dSoZDZi/zU/OAZCKonFJunyMc8CsS2JJHigVzo1cE09AHNn5ULd+Hu5pD3yrKExs1KZxn3kz1Dn0xTJ+JGSMTuKnZYg2izz/HVQ5e17k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtwVcCOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54F8C4CED1;
	Thu,  5 Dec 2024 22:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733436182;
	bh=d+UCtLSa+055hfySG3GTEQEi131xlIBPoVRMayMtx1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KtwVcCObFQlNFLPp0O7igo0/oPO5GrCfFs8mYuVLIA5lzaFxxgMBEZrxIxCSefqm0
	 rn2iu1VpJd9I4dEJ9HX+6o2psGoFIV21fwKNf0F/7l4EewXFq69NXRzwx2gDU4lUMV
	 brbhXjZbqauDCKM7s5LoTDrBuNNkKmNSty+zFYRb3G2rHI8n+emelxbcy6a5AlSoOh
	 ClBtGj3B6K2awFT55HgxG7Nbz1Bdqn+5QNp0aHAEnnXF/vHSZIOV1UQ5rRc2LYxNnN
	 n5G5Cl/2mH6Lzs2FhUONXNEnJLKNd6XJ1bz+9J0UdYV8v3xz0sKsT9n5em1mBSvf5v
	 Z81PsrALbz3+Q==
Date: Thu, 5 Dec 2024 14:03:00 -0800
From: Keith Busch <kbusch@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: Robert Beckett <bob.beckett@collabora.com>,
	Christoph Hellwig <hch@lst.de>, kbusch <kbusch@meta.com>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	sagi <sagi@grimberg.me>, stable <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: Remove O2 Queue Depth quirk
Message-ID: <Z1IjFDWwAonRI30D@kbusch-mbp.dhcp.thefacebook.com>
References: <191e7126880.114951a532011899.3321332904343010318@collabora.com>
 <20241029024236.2702721-1-gwendal@chromium.org>
 <20241029074117.GB22316@lst.de>
 <CAPUE2uvUs5dGGmovvHVPdsthKT37tJCK5jDXPMgP18VKhm5qTA@mail.gmail.com>
 <192d9b75f76.106d874861279652.1491635971113271140@collabora.com>
 <CAPUE2utp0qOiMRNPwtn_gF45f2awa9UyNJ91zmpRbtu6zR5p9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPUE2utp0qOiMRNPwtn_gF45f2awa9UyNJ91zmpRbtu6zR5p9w@mail.gmail.com>

On Thu, Dec 05, 2024 at 01:53:29PM -0800, Gwendal Grignou wrote:
> Since limiting the queue depth to 2 is only needed for a small subset
> of eMMC memory modules that can be connected behind the bridge, would
> it make sense to apply this patch, but add the kernel module parameter
> mentioned earlier for impacted devices?

I don't think qd2 is needed for anyone, though. The problem sounds like
it was root caused to a boundary condition, which is addressed in a
different patch. But I am not 100% sure, as the thread was left hanging
for some external confirmation:

  https://lore.kernel.org/linux-nvme/Z0DdU9K9QMFxBIL8@kbusch-mbp.dhcp.thefacebook.com/

