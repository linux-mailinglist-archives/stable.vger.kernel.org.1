Return-Path: <stable+bounces-93989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 410329D2651
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34A51F21924
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159EE1CCB25;
	Tue, 19 Nov 2024 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zVVfH8Rg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C587D1CC880;
	Tue, 19 Nov 2024 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021394; cv=none; b=A1sEKfDohtQf6KalfQnV6Okajl/VAxa8XYoquglaYp19C1E4PVasALKJ0O3+LGTP7nHjRQJPk2cOxEQxlOYiT4GCJ1iVjpKC0XeSWGrZ7X60CecEG33BLdBxXqQSuW4YIRrI1KaVG9KknqOyvMyP7yfP1v+66R6iuO77STI5WdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021394; c=relaxed/simple;
	bh=NkgMxLWkB76nyDziJ9ln4cGXIPWuX54H1RDU9Y/QFN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usCpY6jpThhVqirCnmVqr/cXmoJATx1qQ1TD5Ko5VYMm89TlX63bBdA4+uMGhf0tyvsm2FhMU6hHlqrTd1rP8kCcKH/xpGV1pqxyqmrsIu/Ios0TddLn+XREoJa0UV5AEzTtU0rxAV0aYKuG7NIO2AWEWEtOSiitiv2OxAOqjj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zVVfH8Rg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2EAC4CECF;
	Tue, 19 Nov 2024 13:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732021394;
	bh=NkgMxLWkB76nyDziJ9ln4cGXIPWuX54H1RDU9Y/QFN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zVVfH8RgLc0xLhp71kaJlB6z7m7l/2I828/qb/sX+4VbW06/rbwyu/alDdyGD8oxB
	 1u8TudzFt17QYVL6jaMCrkG+SHJV/X7EQKUWIvfIp7KfChL1fx3aTIbZ90k8AP1NJh
	 YKwAqHS1NnQ8dnESno4F3UyMpIhoHAFji2/yVooY=
Date: Tue, 19 Nov 2024 14:02:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH 6.6.y 0/6] mptcp: fix recent failed backports
Message-ID: <2024111938-agenda-vertebrae-d9ce@gregkh>
References: <20241118182718.3011097-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118182718.3011097-8-matttbe@kernel.org>

On Mon, Nov 18, 2024 at 07:27:18PM +0100, Matthieu Baerts (NGI0) wrote:
> Greg recently reported 3 patches that could not be applied without
> conflict in v6.6:
> 
>  - e0266319413d ("mptcp: update local address flags when setting it")
>  - f642c5c4d528 ("mptcp: hold pm lock when deleting entry")
>  - db3eab8110bc ("mptcp: pm: use _rcu variant under rcu_read_lock")
> 
> Conflicts, if any, have been resolved, and documented in each patch.
> 
> Note that there are 3 extra patches added to avoid some conflicts:
> 
>  - 14cb0e0bf39b ("mptcp: define more local variables sk")
>  - 06afe09091ee ("mptcp: add userspace_pm_lookup_addr_by_id helper")
>  - af250c27ea1c ("mptcp: drop lookup_by_id in lookup_addr")
> 
> The Stable-dep-of tags have been added to these patches.

Now queued up, thanks!

greg k-h

