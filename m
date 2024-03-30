Return-Path: <stable+bounces-33795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BD38929D4
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 09:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21BA282737
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 08:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB5B3C2C;
	Sat, 30 Mar 2024 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rWLwZ/ar"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D62179
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711788901; cv=none; b=qXFlRzew6O7Tnu4HEXx7LC41Ta/9tRUQ+VQDhGw5HM/grO6YNp+XxEXCY9KX+tSgyW2ri4uNAFoGtQMxKOFRpbwW5UcNX4yUcZe7OXQMhwh7Mqcb5WuiCeXRqi2aU1njAhy3juQfB/PkjPaTVMq/8rI/UW78g6vAtYzTWTP/xGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711788901; c=relaxed/simple;
	bh=xE7r88x7za+vQ983UKSpWHLbvrBWe1cEhKVbeHbw36A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGT1Ij/IUmvJuMKfYipMiOf7A0VJ+uO21uWZ6nUZH6IhksEwJJY9AuIScnit6Iz1ixmU5Zrz1yF5ue9BZ/ipWIxhzD7WkoKtdBwRh1iDqeNFmVRWU8/jTflktztr8PD1rcB7Ci/Y65aAMKwgj5PSb1Lf3NE8RiYUYVkIP/7AfE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rWLwZ/ar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476EBC433F1;
	Sat, 30 Mar 2024 08:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711788900;
	bh=xE7r88x7za+vQ983UKSpWHLbvrBWe1cEhKVbeHbw36A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rWLwZ/ar0OPthX4s6AF9O2ME+853CELKlrTBVGSlXODhWmizvieuGJIdSKh30v7jO
	 V0iJcsgexYmCvtdIJPsDqDBIB3XXy+/g8t+AqaVNL6q8kpCKsunnljKjOf2rpKFJ1+
	 H/zGLJz0HlmoHQ7HgikYlw0I93Cm+VViUPIe8W5w=
Date: Sat, 30 Mar 2024 09:54:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, eric.auger@redhat.com
Subject: Re: [PATCH 6.1.y 0/7] vfio: Interrupt eventfd hardening for 6.6.y
Message-ID: <2024033041-unleash-wrinkle-4b2a@gregkh>
References: <20240329213856.2550762-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329213856.2550762-1-alex.williamson@redhat.com>

On Fri, Mar 29, 2024 at 03:38:47PM -0600, Alex Williamson wrote:
> This corrects the backport of commit fe9a7082684e ("vfio/pci: Disable
> auto-enable of exclusive INTx IRQ"), choosing to adapt the fix to the
> current tree which uses an array of eventfd contexts rather than
> include a base patch for the conversion to xarray, which is found to
> be faulty in isolation.
> 
> I include the reverts here for completeness, but if the associated
> commits are otherwise already dropped due to previous report[1], the
> remainder of this series is still valid.

Remainder of the series is now queued up, thanks!

greg k-h

