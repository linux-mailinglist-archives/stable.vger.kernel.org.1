Return-Path: <stable+bounces-23871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C686868C14
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 10:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5ED1C216C1
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B04C136648;
	Tue, 27 Feb 2024 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N3Yg6tEb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4590136646
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025768; cv=none; b=b85Y6pQi025vre6Tsbn890WylRF3xOSePa2+guamSMEr8XNBrthzhdWDHNN2iF+AHjmD1yCY4EKbm95sWpVE9IK300Bpe7G7i2iFOeNWh4dfKQzthesmupRBEiGhBaMC719ncgF53qQcNtLDmd5lAVupSA1JeWqc9eoDeeu1jQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025768; c=relaxed/simple;
	bh=Fkn/FJ1UI9oRN0vMWnhCPL5bEKBvPzI42Uqi2EbXxP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heNDjSlVcA7+hgywq9pP7yEFQyaPUtip9bXvNtJ8S/Bj0nVZZfXSDbTTr6LJv/i2ZYZyryuvwcQ2YQsZ5hOiL00uKgLO1aeWc/B96d+fn9i/oVcuZgXECNOoYF01uuX0OiIg9lhyNHBsn6jyC1eUyWbcvSyMuR/M0hQMj3FhQsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N3Yg6tEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AA8C433F1;
	Tue, 27 Feb 2024 09:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709025767;
	bh=Fkn/FJ1UI9oRN0vMWnhCPL5bEKBvPzI42Uqi2EbXxP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N3Yg6tEbWbDwE2LX0WNXP3QuXI9L1vkg0TcG4e8rbeb+eiOuTQFk2j0c8+2MfuIxa
	 WZEBWFAOppCA48lHhRoiBtIRf/YFwM29DO24fb7tZ8mr4bkL5gifh13EN5q1VUb5Pf
	 D+sOXjkqGtWQ0afwAby+S/qPvWDXrX2/YqfptQZU=
Date: Tue, 27 Feb 2024 10:22:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 4.19.y] fs/aio: Restrict kiocb_set_cancel_fn() to I/O
 submitted via libaio
Message-ID: <2024022735-overstay-greedy-91c6@gregkh>
References: <2024022602-unwrapped-haggler-daae@gregkh>
 <20240226193726.93631-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226193726.93631-1-bvanassche@acm.org>

On Mon, Feb 26, 2024 at 11:37:26AM -0800, Bart Van Assche wrote:
> If kiocb_set_cancel_fn() is called for I/O submitted via io_uring, the
> following kernel warning appears:
> 
> WARNING: CPU: 3 PID: 368 at fs/aio.c:598 kiocb_set_cancel_fn+0x9c/0xa8
> Call trace:
>  kiocb_set_cancel_fn+0x9c/0xa8
>  ffs_epfile_read_iter+0x144/0x1d0
>  io_read+0x19c/0x498
>  io_issue_sqe+0x118/0x27c
>  io_submit_sqes+0x25c/0x5fc
>  __arm64_sys_io_uring_enter+0x104/0xab0
>  invoke_syscall+0x58/0x11c
>  el0_svc_common+0xb4/0xf4
>  do_el0_svc+0x2c/0xb0
>  el0_svc+0x2c/0xa4
>  el0t_64_sync_handler+0x68/0xb4
>  el0t_64_sync+0x1a4/0x1a8
> 
> Fix this by setting the IOCB_AIO_RW flag for read and write I/O that is
> submitted by libaio.
> 
> Suggested-by: Jens Axboe <axboe@kernel.dk>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Avi Kivity <avi@scylladb.com>
> Cc: Sandeep Dhavale <dhavale@google.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: stable@vger.kernel.org
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Link: https://lore.kernel.org/r/20240215204739.2677806-2-bvanassche@acm.org
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> (cherry picked from commit b820de741ae48ccf50dd95e297889c286ff4f760)
> [ bvanassche: resolved merge conflicts ]
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

All backports now queued up, thanks!

greg k-h

