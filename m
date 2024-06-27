Return-Path: <stable+bounces-55974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CC491AAEA
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 17:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47FD1C21550
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 15:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A75A1991A0;
	Thu, 27 Jun 2024 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bg1sfPer"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FBD198A34;
	Thu, 27 Jun 2024 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501336; cv=none; b=tjdwDbuJEVY6zx6r23iOIr6I/QxAjUxy7e5XFEI2xdSygykBXrmZjOUclbVGMxVruTOmFFUocjV0HFIpbNFkT3rcbygpBW45K2UdKxkBdT4Izzhuf8+tE5nhn++vXo7KQZ+WNFkuR2DRYtfWG/Hpgl8XGTeIz1DN4u9ADGE4gWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501336; c=relaxed/simple;
	bh=q0A8hCYy5uZVhZ/NmrOR19SojhuSXvXU+Cvj3LoyMI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtrToyfrfzPcPWhmQDsT9UBBuIamC7tkWQe4d/uxIKYeyWpjehCeMc5nE1bt2502geOT1NVrS/iQK0k9aAzuTLVqZOqcuhD8yM4BX9gLDHmW9yKRX2HovzoKsiG8ZCW6nGpa9uMEP5fW2IP+cwtKjjiTSda3dyU3VYIVEde1Ewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bg1sfPer; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0DAC32786;
	Thu, 27 Jun 2024 15:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719501335;
	bh=q0A8hCYy5uZVhZ/NmrOR19SojhuSXvXU+Cvj3LoyMI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bg1sfPerj2O75O7uXP6rq1G5VguVbZ8WxMjSRnAftOVV+MeIkSZq+VBh20TnGQ0aK
	 hWxDQkJjRjVrXSjbyVEXGcHTRWDd7Bzk7DktVL587k8IPuupbtofcid+AHy3oK08js
	 EREJt1uEyCuxU7IBr7hnl3x+pIUttcHJTRS50y9ajs/k9sKNwysEibKGhQ9TN80/2u
	 cZ9IsKP3S/QO/nDF1pb/vnLbKMrLGFG/vQXL3bMXGq1gVX+Lz9zd6X3iRb+i0TyX8j
	 zh+GOUG1YF7jyODghtEvW4yfVk00WC/1k0/T8RvJ6WR70Y7LK3CI1JQRRWX6jeJX6b
	 ZwPfQ13KLuYjQ==
Date: Thu, 27 Jun 2024 17:15:31 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/6] ata: libata-scsi: Do not overwrite valid sense
 data when CK_COND=1
Message-ID: <Zn2CE-aFGj2x8qi2@ryzen.lan>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-3-ipylypiv@google.com>
 <Zn1zsaTLE3hYbSsK@ryzen.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn1zsaTLE3hYbSsK@ryzen.lan>

On Thu, Jun 27, 2024 at 04:14:09PM +0200, Niklas Cassel wrote:
> 
> The only tricky case is if we should set CHECK_CONDITION in case c) or not.
> All other cases seems quite clear by looking at the SAT spec.

I think we should set CHECK_CONDITION in case c),
even if SK+ASCQ+ASC is not "ATA PASS-THROUGH INFORMATION AVAILABLE".

That way we at least align CK_COND with CHECK_CONDITION, which is
most likely what the user (and spec writers) expect.


Kind regards,
Niklas

