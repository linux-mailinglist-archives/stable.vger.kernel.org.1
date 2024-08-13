Return-Path: <stable+bounces-67467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB61950310
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 12:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5471C22548
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 10:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157D519ADB6;
	Tue, 13 Aug 2024 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JK4aDaMr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEBD76025;
	Tue, 13 Aug 2024 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546547; cv=none; b=sbs6xSfQvYvum6VuKYJQKorV5Fz93bZ9oUaxMKqhLMJi6OOfbve2JdyU+GfNnDA5SPjFUqiR0u5XwiOm2CIO9scDNh91Rux3CihBZRx+wu0QizVwCW9FYdX5JsQAugSFxjyYS3tncMd9Y6V5ZzIaRQ7IK47LXaNKFA3tNNL5xCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546547; c=relaxed/simple;
	bh=TygILqStMFbqo7N5dGU4tGf4JOrPwnNO6bj+bLsD50Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSSTIFJ9fuq1PdkTOE8F6XYywLDUAZrLesdcd5xE5ElalyxFR7Q82V2v/crVTSIvy2N7gilyXrg57uZyLvVG5mD8zIQrPjh4kBavWFMvylI94dJpfTYv0Z59OqsBET1AXVrhxiNWEBLAwfSXacHjVKCuF9XNkisUTPxL3+hI1TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JK4aDaMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0851C4AF09;
	Tue, 13 Aug 2024 10:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723546547;
	bh=TygILqStMFbqo7N5dGU4tGf4JOrPwnNO6bj+bLsD50Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JK4aDaMrrGakKDW8SF02QAC3T2BVUw4pPqkOPRfVUdMGsBD5XLNCObY7TWwG4cZ4h
	 zu4L80pJv/Wg5jV2aX9YPewb1RiJ0NWuZwdHKu8WbzFcpMNzc/VRr6hNvC9YTnxjmP
	 ePuo6fk2EQZPcTzwF6oM2IKN9bx6T6PZAxwHJmxc=
Date: Tue, 13 Aug 2024 12:55:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5.15.y] mptcp: fully established after ADD_ADDR echo on
 MPJ
Message-ID: <2024081337-device-cesspool-071d@gregkh>
References: <2024081209-wrongly-zen-35f3@gregkh>
 <20240813104642.1210553-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813104642.1210553-2-matttbe@kernel.org>

On Tue, Aug 13, 2024 at 12:46:43PM +0200, Matthieu Baerts (NGI0) wrote:
> commit d67c5649c1541dc93f202eeffc6f49220a4ed71d upstream.
> 
> Before this patch, receiving an ADD_ADDR echo on the just connected
> MP_JOIN subflow -- initiator side, after the MP_JOIN 3WHS -- was
> resulting in an MP_RESET. That's because only ACKs with a DSS or
> ADD_ADDRs without the echo bit were allowed.
> 
> Not allowing the ADD_ADDR echo after an MP_CAPABLE 3WHS makes sense, as
> we are not supposed to send an ADD_ADDR before because it requires to be
> in full established mode first. For the MP_JOIN 3WHS, that's different:
> the ADD_ADDR can be sent on a previous subflow, and the ADD_ADDR echo
> can be received on the recently created one. The other peer will already
> be in fully established, so it is allowed to send that.
> 
> We can then relax the conditions here to accept the ADD_ADDR echo for
> MPJ subflows.
> 
> Fixes: 67b12f792d5e ("mptcp: full fully established support after ADD_ADDR")
> Cc: stable@vger.kernel.org
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-1-c8a9b036493b@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ Conflicts in options.c, because the context has changed in commit
>   b3ea6b272d79 ("mptcp: consolidate initial ack seq generation"), which
>   is not in this version. This commit is unrelated to this
>   modification. ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/options.c | 3 ++-

Now queued up, thanks.

greg k-h

