Return-Path: <stable+bounces-95874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DAB9DF1DA
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 16:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446AC1621CB
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 15:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F56A19C575;
	Sat, 30 Nov 2024 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="onbNBJdk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECB4156F39
	for <stable@vger.kernel.org>; Sat, 30 Nov 2024 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732981665; cv=none; b=NXvXcqGnHVte+001jiFDP30MaezWXtkaMmyFC7IP4nFdpYsYwvSoMz/22Fx9Bt67h6W6yjv6LfOSWXKCjphAqeZqOWANabEOgw/BOmeHScgetsajlIewo08eCnJEJ2D+AWH9NGz7FSMCplGchtzQfzsEfZWSbwjXeVwp6v2t5hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732981665; c=relaxed/simple;
	bh=gvsgkRpV5gtRvX7h43nQgO570L21lodn18gpEOP83Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fp3kq0wZqs1XWh4YGxxp80GOLEfiW+quq/cy7ySDdQueoLngYzHR2Dyr8/8i3XyUfhlPquQ07Om60WrEn3hF2dJIioGj6/45DRavUcKHgk5j6DUtqmV82dMVrgLBci9NmrqJQV07CMVH78ykfSwVW+fwcxEfDjhBQdP+YAnPfBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=onbNBJdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311D6C4CECC;
	Sat, 30 Nov 2024 15:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732981664;
	bh=gvsgkRpV5gtRvX7h43nQgO570L21lodn18gpEOP83Lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=onbNBJdk7+JpKUaxfZhcz682ElSQIx6eSGVzU9Awe9GknV3YaENQpQwcadRu/OohB
	 vTdlw5oF2dV+9tzqIDIqWRxt9QL7xStDeZGv9ylQmWUQReTl/tXf88Jm0QwJnRTpNo
	 TxSoWzk2eFAlybTnzXf/f3PY3/fJZ5DMOoQLy06U=
Date: Sat, 30 Nov 2024 16:47:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc: stable@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
	Sasha Levin <sashal@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 5.15] kernfs: switch global kernfs_rwsem lock to per-fs
 lock
Message-ID: <2024113006-tarot-justice-aa34@gregkh>
References: <20241129113236.209845-1-jpiotrowski@linux.microsoft.com>
 <2024112923-constrict-respect-a0a6@gregkh>
 <95cf11dc-6771-4a53-9c34-20ee27bfeaa2@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95cf11dc-6771-4a53-9c34-20ee27bfeaa2@linux.microsoft.com>

On Fri, Nov 29, 2024 at 10:20:48PM +0100, Jeremi Piotrowski wrote:
> > And why not just switch them to 6.1.y kernels or newer?
> 
> I wish we could just do that. Right now all our users are on 5.15 and a lot of their
> workloads are sensitive to changes to any part of the container stack including kernel
> version. So they will gradually migrate to kernel 6.1.y and newer as part of upgrading
> their clusters to a new kubernetes release after they validate their workloads on it.
> This is a slow process and in the meantime they are hitting the issue that the patch
> addresses. I'm sure there are other similar users of 5.15 out there.

If they are "hitting this issue" then that is the perfect reason for
them to migrate off of that kernel version.  Don't think that modifying
a core kernel functionality like this is somehow any more "safe" than
moving to a newer kernel (especially given all of the unfixed issues in
the 5.15.y branch compared to 6.1.y).

Saying "your workload is causing problems on this kernel version, please
move to a newer one to resolve the issue." is a valid thing to tell
customers.

Try that first please.

thanks,

greg k-h

