Return-Path: <stable+bounces-176858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC48FB3E5A9
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 15:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06EF442F8F
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 13:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315B13375C1;
	Mon,  1 Sep 2025 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gw6u70C7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB643375D5
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734014; cv=none; b=R+1HOP5ypaumAjWlmLLITFbJoH06pKfTC7UHRAV6tgO3gFd6PXXSVUOp/OD30w76cHjqjxxaJb2K8JlL3A5JAeTdYUUASkvAYyphPRzg4pZQWDJeQcuHuhL2ZKg6UNnTWFFbGgIF2Tnx/lZF8NlfaGNlKYcL29R3ASqzbe0cJOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734014; c=relaxed/simple;
	bh=iGS440OeV0B9Ya2NfgA+NV1hSQOCbh5FyKfJ5TKkajc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUkZ7InDniQa4GWCip4LVHNwPGOmJelPBUz9WhUOgHrImHgPvz5dL6UgvdY0P4g1iT+YPZHxR7RoGoA8jAKchbYUe5Q82SERP5eqYp4umq/5v4NsVx6e0CSmuVBA7TgDZpCfoSpuCXpA1FN1ot+VuMAnlb5aslBI/dzFxfcKA4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gw6u70C7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02348C4CEF1;
	Mon,  1 Sep 2025 13:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756734012;
	bh=iGS440OeV0B9Ya2NfgA+NV1hSQOCbh5FyKfJ5TKkajc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gw6u70C7/fgxqgHAuVI3RZyA1mbH6fGxkCl7P6IZpvkXkhm836F9RIfpxWivLTFLW
	 ZTszZp0G41ZqJgsW5wOk3hicFSxGDkSOsryhoN6JgqCGRtmZsqvve8pBNs5aZcJwWe
	 PldlOKOBmY/+AvFFr1isYinUhdiU24SDCH3bhea0=
Date: Mon, 1 Sep 2025 15:40:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: stable@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH 1/2] PCI: Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to
 PCIE_RESET_CONFIG_WAIT_MS
Message-ID: <2025090152-dance-malformed-653f@gregkh>
References: <20250831202100.443607-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831202100.443607-1-marek.vasut+renesas@mailbox.org>

On Sun, Aug 31, 2025 at 10:20:48PM +0200, Marek Vasut wrote:
> From: Niklas Cassel <cassel@kernel.org>
> 
> [ Upstream commit 817f989700fddefa56e5e443e7d138018ca6709d ]
> 
> Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAIT_MS.
> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> Cc: <stable@vger.kernel.org> # 6.12.x
> ---

You did not sign off on these patches :(


