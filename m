Return-Path: <stable+bounces-78608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E81BA98D0AD
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B2F1C218EA
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 10:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68361198E6C;
	Wed,  2 Oct 2024 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gG7+xgpj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27536194A67
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863287; cv=none; b=o9ZhRhS0L96V2CRXiTQ1vqreZVEy5abqrhTbq5OQ+3AAl+MJoet/LFh200i1Cm07qxtfLRhCtNcqyYWd/9hNqEZVYFBl0VLC1Rw5kDFezeY5hjMSoIkX/GhpxS61B+YXJqCeafyOPu2gwwiXh1MFzCG81qbUH4Jd7ummUFqO62E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863287; c=relaxed/simple;
	bh=4NQcXe+tEakzJaL8hwYlSyRRMWtnn5M5qzHlSvp6kWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+DT1DZwnmVmzabAP/PRrrOG6QVRSa2fT/pH++3WQoOes7wCjVEnPXdaX4ISdNvz7F2zczKytadfliHmHaNuXq5ln7qpDlic1hTJwju1TkMy8U+rgs9pG34x6yGOWRVawjgOFPqRvTnM2mMlOPtvsExuXWShgQ++XvWHNoYFGUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gG7+xgpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1E9C4CEC5;
	Wed,  2 Oct 2024 10:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727863286;
	bh=4NQcXe+tEakzJaL8hwYlSyRRMWtnn5M5qzHlSvp6kWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gG7+xgpj4DQ1Kut4f+iffOxsuEBKu/avujxKvF6i/4cuOMlbU5wYxuRowmHDVoynN
	 xK1g+SDX/MveJ7usctSslyIy+EGTCBYbQAqC3Bq0RWVdNX4vSBkcaDh5CKdAW6BM7c
	 28XXUNfvD7jXtZ4/QrVXSATDEKCcQ5xyu4+chqik=
Date: Wed, 2 Oct 2024 12:01:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: felix.moessbauer@siemens.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/sqpoll: do not allow pinning
 outside of cpuset" failed to apply to 5.15-stable tree
Message-ID: <2024100216-spray-underhand-ef1b@gregkh>
References: <2024100131-number-deface-36a6@gregkh>
 <32ef9660-2e25-4a5c-a019-4aa642543106@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32ef9660-2e25-4a5c-a019-4aa642543106@kernel.dk>

On Tue, Oct 01, 2024 at 07:50:15AM -0600, Jens Axboe wrote:
> On 10/1/24 1:19 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x f011c9cf04c06f16b24f583d313d3c012e589e50
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100131-number-deface-36a6@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Here's one for 5.15-stable AND 5.10-stable, remember that any stable
> io_uring backport for 5.15-stable also applies to 5.10-stable as they
> use the same codebase.

Both now queued up, thanks.

greg k-h

