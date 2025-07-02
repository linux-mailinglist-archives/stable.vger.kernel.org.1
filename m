Return-Path: <stable+bounces-159215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C779AAF10FF
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 12:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E370116F725
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 10:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0E1242D74;
	Wed,  2 Jul 2025 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1QQGCDSG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4E623D2B8
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450453; cv=none; b=B/f/iDjZ1R+OBfPIr0aMsn3tQayrCHw8UIXizKkPA+xXgVlVis/6NSQ/uhL70/RF667oZMRsJLpntLD2e65eAnuWpnoDFRYuU0HqQEIUyQ3O6KoS13xibYEpsMg0FmhZn1szfqu7r6NfAWwkBljWVc9TsQmPP7v9KmvFK5c4dZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450453; c=relaxed/simple;
	bh=XLDfwlRfxCpf35ZQqa05oBQVyGbrXmpdJHG36djuhs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLRwBz6/ZlSNPCsUJ/zaKNpKkVYOr2zSwykAeGCRYJ+RID5uSNvUEa9pPZzHpSCivj8j9xrnUq93Rl2BAijLql2AdImDGUSrogWRhpQHlCnU442Tg3QnUO6MTapxsw4NQXDw1q50yh/vQcVVAOgyjvh6seFxbHV2eVkd48yw9+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1QQGCDSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B25C4CEED;
	Wed,  2 Jul 2025 10:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751450453;
	bh=XLDfwlRfxCpf35ZQqa05oBQVyGbrXmpdJHG36djuhs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1QQGCDSG0olG9CxC+6MaIsPoKFuq4Xx1ABT69EJbK0B1ghD/rOCBfmufKQsUAOO0k
	 8zbj24kA1enu6qcJbbG3WmbLdu/8DDs+0x2PMi886qrKR/u4LlNHuQ8GjxvNPze6oO
	 5Vb9hSt9+CRV1OXhZmZsXrEbgJ9n4xmYQFeijFXg=
Date: Wed, 2 Jul 2025 12:00:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: asml.silence@gmail.com, david@redhat.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/rsrc: fix folio unpinning"
 failed to apply to 6.12-stable tree
Message-ID: <2025070242-revolt-mardi-23f7@gregkh>
References: <2025062950-football-lifting-1443@gregkh>
 <14c7b39a-d489-4265-8165-892ffcb81af9@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14c7b39a-d489-4265-8165-892ffcb81af9@kernel.dk>

On Sun, Jun 29, 2025 at 10:41:57AM -0600, Jens Axboe wrote:
> On 6/29/25 6:41 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 5afb4bf9fc62d828647647ec31745083637132e4
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062950-football-lifting-1443@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> 
> Set for 6.12-stable, thanks.

All now queued up, thanks.

greg k-h

