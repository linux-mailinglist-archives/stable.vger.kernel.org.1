Return-Path: <stable+bounces-85825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDB699EA46
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921BD2895F9
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38DD1C07DE;
	Tue, 15 Oct 2024 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d6dF/Fay"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6591C07CC;
	Tue, 15 Oct 2024 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996516; cv=none; b=MSt8pvaqdFMJYA1OA/vn4jX5GMqDgptGDLo0ZM5XiF2tIBvW/v0GkDZV5CyZT1rC5fe9mVTGqxJVPJr0RoRAOvFi0gpbUU3BOt6rbzH8Rj24lKT+m7JeZOkb2RY0TboN3CmI/HYP/W50eAJ+ma+efBZMbClTsoLdQdm7+F2PN60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996516; c=relaxed/simple;
	bh=Zu8HA9GF8oYNqN0gW9DTJjGKn9j2ms4IdAX9py1eejc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEv4KVFdU8ci/VHiWHuBvU2j7QmY681GRMhawP8L2UetSboxM1ie4oQEmr/U6XvIjGm39ODHpIVIuDXSnD7uSUpN9blY7ol7lYDrvgtc/c0nrU6P4RneFcuy5ueTC/7I8NviKyu4hOCcQkT7nL4kmYNPbHBbDSQ46Wk9obl0cfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d6dF/Fay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BF0C4CECE;
	Tue, 15 Oct 2024 12:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728996516;
	bh=Zu8HA9GF8oYNqN0gW9DTJjGKn9j2ms4IdAX9py1eejc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d6dF/Fay5IPYBh4ZUm/+Nq0Tvl5UbsDrvpZea0UuHJ1gNZwjYKtEySb7wK2uPadR5
	 gv8jOLMSW+CoS0uAW4aFdsBxtfmWUyHI7mO0c262M5z5pyrvXlvXOzriBw2lsrTVJK
	 9XvWtdi+/Dum6eQwjyhp3VmNgt9WnTYZXNGMKhok=
Date: Tue, 15 Oct 2024 14:48:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Oren Weil <oren.jer.weil@intel.com>, Tomas Winkler <tomasw@gmail.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Rohit Agarwal <rohiagar@chromium.org>,
	Brian Geffon <bgeffon@google.com>
Subject: Re: [char-misc-next v3] mei: use kvmalloc for read buffer
Message-ID: <2024101509-refined-posh-c50d@gregkh>
References: <20241015123157.2337026-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015123157.2337026-1-alexander.usyskin@intel.com>

On Tue, Oct 15, 2024 at 03:31:57PM +0300, Alexander Usyskin wrote:
> Read buffer is allocated according to max message size, reported by
> the firmware and may reach 64K in systems with pxp client.
> Contiguous 64k allocation may fail under memory pressure.
> Read buffer is used as in-driver message storage and not required
> to be contiguous.
> Use kvmalloc to allow kernel to allocate non-contiguous memory.
> 
> Fixes: 3030dc056459 ("mei: add wrapper for queuing control commands.")
> Reported-by: Rohit Agarwal <rohiagar@chromium.org>
> Closes: https://lore.kernel.org/all/20240813084542.2921300-1-rohiagar@chromium.org/
> Tested-by: Brian Geffon <bgeffon@google.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---

Why is this on the -next branch?  You want this merged now, right?

Again, I asked "why hasn't this been reviewed by others at Intel", and
so I'm just going to delete this series until it has followed the
correct Intel-internal review process.

greg k-h

