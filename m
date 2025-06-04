Return-Path: <stable+bounces-151409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013FFACDEE0
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 15:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD5B167DEF
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 13:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A6F28F933;
	Wed,  4 Jun 2025 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ID1CtwJQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B4128EA55
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749043276; cv=none; b=IxuDZ4cH+HUNmqMK0hlQ6kFWpMnuFeii9pvWXZngRiJzDRUBMrBcAIUjaTLUNAnjuf37E47UpQ9npg2MJEhFfY4VHqa6im7T6qGBsQugX9pF1wUyiX5X1ZcK7DVMnbR1eFzCDNLemZ5jcIdowkBuyATOTkSYQ2QKukfws2y909w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749043276; c=relaxed/simple;
	bh=HVb/4RUyWX8cZuF+hqEB7wxiQBhMSTgAbvQhBDlFx8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTJ8iQMb7GwIQp3Sh5j9vtbRmx1DRhIVVtvb6Os421NScrA0HDFwRfZLBa0uh74fyYLwxBgpOenXVVZgqEu6T8bGtjwIGJOOHkAqy7LoR0b8GeAtLzB/+ISjL07nYDI7Eaj4RZSdiSW1lY/e5KtIirc2iJwWuUOSg17Qco+7r00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ID1CtwJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12309C4CEE7;
	Wed,  4 Jun 2025 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749043276;
	bh=HVb/4RUyWX8cZuF+hqEB7wxiQBhMSTgAbvQhBDlFx8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ID1CtwJQ58h5rjNCrNX3I0vAown6HujFYK/iLRZ54W5cm+KZa1AhsP4Y+E77OgyRu
	 ytQ5O4YnyhRY3q4LrNmhMm1Gzk0KG+FpzLosU21cR80/EHAbjrc2nBGsRhNRqgsTd6
	 OyeiPgJNS2RjYrZW7WL41eQudz8irt98HiugPaqA=
Date: Wed, 4 Jun 2025 15:21:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: stable@vger.kernel.org
Subject: Re: Request for backporting accel/ivpu PTL patches to 6.12
Message-ID: <2025060411-tableful-outage-4006@gregkh>
References: <fe7c8681-83de-4f3e-8dab-04185f0f9416@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe7c8681-83de-4f3e-8dab-04185f0f9416@linux.intel.com>

On Tue, Jun 03, 2025 at 12:42:09PM +0200, Jacek Lawrynowicz wrote:
> Hi,
> 
> Please cherry-pick following 9 patches to 6.12:
> 525a3858aad73 accel/ivpu: Set 500 ns delay between power island TRICKLE and ENABLE
> 08eb99ce911d3 accel/ivpu: Do not fail on cmdq if failed to allocate preemption buffers
> 755fb86789165 accel/ivpu: Use whole user and shave ranges for preemption buffers
> 98110eb5924bd accel/ivpu: Increase MS info buffer size
> c140244f0cfb9 accel/ivpu: Add initial Panther Lake support
> 88bdd1644ca28 accel/ivpu: Update power island delays
> ce68f86c44513 accel/ivpu: Do not fail when more than 1 tile is fused
> 83b6fa5844b53 accel/ivpu: Increase DMA address range
> e91191efe75a9 accel/ivpu: Move secondary preemption buffer allocation to DMA range
> 
> These add support for new Panther Lake HW.
> They should apply without conflicts.

That's way larger than the normal "add a new quirk or device id" patch
for new device support, right?  Why do you feel this is needed and
relevant for 6.12.y and meets the requirements that we have for stable
kernel patches?

thanks,

greg k-h

