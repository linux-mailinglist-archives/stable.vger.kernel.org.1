Return-Path: <stable+bounces-36400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0083289BE24
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D361F22108
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 11:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDD7657C4;
	Mon,  8 Apr 2024 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p2WEcpTI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74D853AC;
	Mon,  8 Apr 2024 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575878; cv=none; b=A7MfI8EuFzrBNNLqnnLSBdpaTMFzjuYfOhnMNMxjJoza3YXLMljIYLYC7X0eWp+39wffSq1DPZRIyb8fOgrF+nJkDw5nIWTVf1ZAFRK9MmAVJ8JtQnO51MlLIx3xKhWV7+ot0uDYlMHc8w/BeZl8L2myNbheFaYMyvatEHUCL1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575878; c=relaxed/simple;
	bh=rZgjKxMazEN8BXUaLfWU68GdlKeyxYPsbC1cLkqBHKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEYB8V0fFc5jpgNtpDheJuOZDxlLTuKJpvD0jTg++uc0fX4LNhpDnn4ayB7i86G7UQgWwYCjpre+aRMtfEt2dFRqJW0xpUwjEZ6R/xq92ctU1CM2MGpbcY8jLNw98Hin6SdKWEu9zHHRVCvSkYr5ZTmDRKXxo8kf/3TyaXr1pNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p2WEcpTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01C4C433C7;
	Mon,  8 Apr 2024 11:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712575877;
	bh=rZgjKxMazEN8BXUaLfWU68GdlKeyxYPsbC1cLkqBHKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p2WEcpTIQ7amMW3NjhdovTQSi3O03nl4b51WtAtJ9RuQC64gGDG6ubzXDUxwhfr54
	 m3KYRSxZrNLi+r56FGSsowmJlrFowtlZJ0Dj87Ii1yQXSc2p9ajyx1kq2a1iu4uhs3
	 T/qRIqno+a1XMj7Vwuay0Ek94s2/a//JBB8JIiKY=
Date: Mon, 8 Apr 2024 13:31:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.6.y 3/5] selftests: mptcp: use += operator to append
 strings
Message-ID: <2024040801-undaunted-boastful-5a01@gregkh>
References: <2024040520-unselect-antitrust-a41b@gregkh>
 <20240405153636.958019-10-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405153636.958019-10-matttbe@kernel.org>

On Fri, Apr 05, 2024 at 05:36:40PM +0200, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch uses addition assignment operator (+=) to append strings
> instead of duplicating the variable name in mptcp_connect.sh and
> mptcp_join.sh.
> 
> This can make the statements shorter.
> 
> Note: in mptcp_connect.sh, add a local variable extra in do_transfer to
> save the various extra warning logs, using += to append it. And add a
> new variable tc_info to save various tc info, also using += to append it.
> This can make the code more readable and prepare for the next commit.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Link: https://lore.kernel.org/r/20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-8-4f42c347b653@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> (cherry picked from commit e7c42bf4d320affe37337aa83ae0347832b3f568)
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  .../selftests/net/mptcp/mptcp_connect.sh      | 53 ++++++++++---------
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++------
>  2 files changed, 43 insertions(+), 40 deletions(-)

Odd, this one did not apply.

All others did, thanks!

greg k-h

