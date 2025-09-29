Return-Path: <stable+bounces-181926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1363CBA9977
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 16:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5BC016C3B4
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 14:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366092FBDE7;
	Mon, 29 Sep 2025 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FLdPaPBz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EE02AD16
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759156367; cv=none; b=A8sfB5rW4R7zjv5GG2Cfmk7KkkFp2detq7MpStBDmI5Lz75TTfnb/WEbpGc+j/pijRt8xm3eVL/FkJjDXLvjthpOwAR2kqBZ7KVAXMIC+HQBcnhTIpaF05mBq+4W3qlnGJ+DZKn8HP/sjj2nPyCm6QJhGSYpnUz1y2+/H+vVggI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759156367; c=relaxed/simple;
	bh=dV1EdRRCIZafS6f81qCqFuEjgr1l3rz4SNrn96Ti2iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqkCMlGqYRKkihnQO030eQsP+PefpffthjJZ+fd3L+VsQz0BRu+HM+3KSlFU6sbm9+HTifJCGfUqthVXblhIxF39RbxjxXYB2JFeBax4mke4e0UWCIcY1lsGgDDrSuQ2u4JbE6HxL6OrDpC8jmW0Qn3t1NWtuBfdKXo7YC2j/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FLdPaPBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1A2C4CEF4;
	Mon, 29 Sep 2025 14:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759156366;
	bh=dV1EdRRCIZafS6f81qCqFuEjgr1l3rz4SNrn96Ti2iQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FLdPaPBzWVuJQ/OdmhmJIo/jUEQNWNOxUo4bk22ZkbQ5zZoDxjrdOmhiWiaU9KGvH
	 wl6PvgztCJIjlEhNSpgFE+QT/c8bKKIu4u9E7imkqOEaF7MVNhKTEuE7yPndPx3OmJ
	 r5SaaZhmGet2nT/Y0xtR1s+wv+Q1D8P7O41+FgbA=
Date: Mon, 29 Sep 2025 16:32:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: changwoo@igalia.com, tj@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] sched_ext: idle: Handle
 migration-disabled tasks in BPF code" failed to apply to 6.16-stable tree
Message-ID: <2025092936-bronco-curtsy-981c@gregkh>
References: <2025092952-wooing-result-72e9@gregkh>
 <aNqVoQaJzYWReVvn@gpd4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNqVoQaJzYWReVvn@gpd4>

On Mon, Sep 29, 2025 at 04:20:17PM +0200, Andrea Righi wrote:
> Hi Greg,
> 
> On Mon, Sep 29, 2025 at 01:40:52PM +0200, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.16-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 55ed11b181c43d81ce03b50209e4e7c4a14ba099
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092952-wooing-result-72e9@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..
> > 
> > Possible dependencies:
> 
> This patch depends on upstream commit 353656eb84fe ("sched_ext: Make
> scx_idle_cpu() and related helpers static").
> 
> To resolve the conflict I think the best would be to apply commit
> 353656eb84fef ("sched_ext: idle: Make local functions static in
> ext_idle.c") to 6.16-stable as well.
> 
> This commit only makes some functions static (no functional changes), so it
> should be safe for stable and it'd keep the code more aligned with
> upstream.

Thanks, that worked.

greg k-h

