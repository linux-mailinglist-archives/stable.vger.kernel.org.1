Return-Path: <stable+bounces-87672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD449A9A4E
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 08:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B351F22731
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 06:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFF41465B1;
	Tue, 22 Oct 2024 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="inVCuFHN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DDA811F1
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580158; cv=none; b=rI7/xEJk1uRvnjlR9s+vGSTJ8M4PeezwIWQtLQ7P5L2ISAldIYwXzPemkgjoIJcDz+BRFv3UHKhgZXWBS9oXYdPe4eYLONRjP4TF1UTlfC3LilbwErRUvF9IOuw5mNsEC1RFNmbZsiWD91rmCvba7sR/cX6uwSzM5HgPQHSLShY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580158; c=relaxed/simple;
	bh=j0WDiSMAt0OBP1560Fq/J/DaX/CPam1jWAvIqZPaN0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXJOSrXIIUhJrjfqoAceVw3n7ohnZwZBY3JAA9pjXMnGVznHBB3iOsIn1h/yMbG5768ZU7MIFcUemo8zUMBVsC3Lf/esRWXkwxUT4NmzA6agxo2LgHJzd4PrR6n1hUNPmc8r3TZGxZopOiLGhuQxwCQf5of0wGX/lEtZqWs8lLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=inVCuFHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC748C4CEC3;
	Tue, 22 Oct 2024 06:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729580158;
	bh=j0WDiSMAt0OBP1560Fq/J/DaX/CPam1jWAvIqZPaN0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=inVCuFHNL57zQQt/aZOnsaQ1wYW8K591u+I/xp5uETSnc4bZzpFlA8d8z+t8HKxml
	 9MjR2PkCOdG8mjeqWevPtKRp7Fmx0+rOQF6F/JdHsCL3Ka+8gN+IZI1U7Mq5zKGlMA
	 Wv6Fawa1+JKF2sWL96whV+uQP8Bry9JZJuyaG5as=
Date: Tue, 22 Oct 2024 08:55:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Thinh.Nguyen@synopsys.com, d-gole@ti.com, msp@baylibre.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] usb: dwc3: core: Fix system suspend on TI
 AM62 platforms" failed to apply to 5.10-stable tree
Message-ID: <2024102201-pushup-unmoral-aed0@gregkh>
References: <2024102152-salvage-pursuable-3b7c@gregkh>
 <c8c33676-d05b-4cbb-974e-398784cb8b8a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8c33676-d05b-4cbb-974e-398784cb8b8a@kernel.org>

On Tue, Oct 22, 2024 at 09:37:30AM +0300, Roger Quadros wrote:
> Hi Greg,
> 
> Patch was marked for 6.9+ but I added a 'v' in the tag and that's probably why it
> was attempted for earlier trees.
> 
> > Cc: stable@vger.kernel.org # v6.9+

No, it was attempted for earlier trees because:

> > Fixes: 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init")

That commit is in the following kernel releases:
	5.10.217 5.15.159 6.1.91 6.6.31 6.8.10 6.9

So if a backport is needed, that would be great.

thanks,

greg k-h

