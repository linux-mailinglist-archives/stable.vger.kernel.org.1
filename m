Return-Path: <stable+bounces-53813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D566690E87F
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EB36B23D27
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E138E12F392;
	Wed, 19 Jun 2024 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SwJRaCTT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C22175817;
	Wed, 19 Jun 2024 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793685; cv=none; b=hIz+FyXUdin/b2D0ge9FcSpJ61O3SD3VQWWw41VEfu6JnF46XJe4Juh2jtKaa/lAvfXi2wc3zKi8v+7YlLAba/igHYhRf8W66Vv5mR5IRdO0VTg+1JhkmidDXnoCeuOyRmI9jJVs3ozns84CsV9waDycx1XBXfB/vAMKDzJRJ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793685; c=relaxed/simple;
	bh=gq9oSwl/z0sw4OPuFdIkjNagT73NLMbEXOef+BxVRKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZv9V2rwRMAyJL55fGOHiX608jm7RNWusH22bt+my2/BP5f9zQM2xq/5vmrQ8cuSUQCKVBhIICQR7uu8cyLuYl4XAC2CUiIa6S7hr3bpEIpjkTDflE/fuW4+yGiZ9KO9x5wsvzMlS6WBiSnwcVp9BTwXNkLX2AWc7oO4PdTQU8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SwJRaCTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD39C2BBFC;
	Wed, 19 Jun 2024 10:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718793685;
	bh=gq9oSwl/z0sw4OPuFdIkjNagT73NLMbEXOef+BxVRKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SwJRaCTT05IaAJyJWaClozBQ6ovLScLJKsHnnKwYqtYj9CyMA300VGNK/az65cjK0
	 mzDVjorgjhvOR3veBByZOXF9wHg7053VGx8TirPjnHht3WwvpQEC6CrS1QxE3bt/1A
	 utakMXojgOMzPZrHsao0W0NcMMvPrJFEjRFBpSNY=
Date: Wed, 19 Jun 2024 12:41:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Christoph Paasch <cpaasch@apple.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5.10.y] mptcp: ensure snd_una is properly initialized on
 connect
Message-ID: <2024061902-stable-skimpily-ce79@gregkh>
References: <2024061719-prewashed-wimp-a695@gregkh>
 <20240618122444.640369-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618122444.640369-2-matttbe@kernel.org>

On Tue, Jun 18, 2024 at 02:24:45PM +0200, Matthieu Baerts (NGI0) wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> commit 8031b58c3a9b1db3ef68b3bd749fbee2e1e1aaa3 upstream.
> 
> This is strictly related to commit fb7a0d334894 ("mptcp: ensure snd_nxt
> is properly initialized on connect"). It turns out that syzkaller can
> trigger the retransmit after fallback and before processing any other
> incoming packet - so that snd_una is still left uninitialized.
> 
> Address the issue explicitly initializing snd_una together with snd_nxt
> and write_seq.
> 
> Suggested-by: Mat Martineau <martineau@kernel.org>
> Fixes: 8fd738049ac3 ("mptcp: fallback in case of simultaneous connect")
> Cc: stable@vger.kernel.org
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/485
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Link: https://lore.kernel.org/r/20240607-upstream-net-20240607-misc-fixes-v1-1-1ab9ddfa3d00@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ Conflicts in protocol.c, similar to the ones from commit 99951b62bf20
>   ("mptcp: ensure snd_nxt is properly initialized on connect"), with the
>   same resolution. Note that in this version, 'snd_una' is an atomic64
>   type, so use atomic64_set() instead, as it is done everywhere else. ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/protocol.c | 1 +
>  1 file changed, 1 insertion(+)

All backports now queued up, thanks.

greg k-h

