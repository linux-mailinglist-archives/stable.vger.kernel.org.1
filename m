Return-Path: <stable+bounces-25850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FA386FBCF
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 09:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CED52828F3
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 08:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698D71756B;
	Mon,  4 Mar 2024 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YMxS7Wep"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2650F1754E;
	Mon,  4 Mar 2024 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540804; cv=none; b=VHOApffjNQI2P/KTnMXq6CLFKUR4rxKLqOhuo+av8EL8AqwtHYHAifEW5hMPRwhSQpMTs9dEyVB2LoPZ/XJRMcgrPsMZxovcRQ7rAZoE/9bCLyjO2XrHnDBSCk5eguJxKbPYuCbhYCAbtrx9z0yVWMrFPKGmPtIjq+vO/mFnxdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540804; c=relaxed/simple;
	bh=a5FOUA+3Iz+D6QvEUOf9bL/62idJcjsCjBYYu5lvdJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Alp9QWabBJwJGNidiW4iYay7nhoSxc3F/q+Dr8XtjCY7tcoefJcKlgcjqFs/WSrP/ohEd1iq8XQk7V1YL5uKze3NKbmF/iEm3aGZ6kkmn3DQ03c7T6VG2V4mPgir1GxKC3zuLCOzKRL1OWpauvxhkr0LsOgdjK3wB8KhdjvidDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YMxS7Wep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C2AC433C7;
	Mon,  4 Mar 2024 08:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709540803;
	bh=a5FOUA+3Iz+D6QvEUOf9bL/62idJcjsCjBYYu5lvdJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YMxS7WephUxtaoj12NdZbe65dh1FLSx/qtImiqKQr3qJ7gVi9Q3WjVQSwBHk4Aa6W
	 pLEAmUmFell06anhfYWiDd4Uz3mqjEDl7BIcHYXE8dL8DvaFIN4w/KuTdAupwiogW/
	 MbkD5+bTQGecWKun6MovVvW56S30dPobUdAr6O5s=
Date: Mon, 4 Mar 2024 09:26:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 5.15.y] mptcp: move __mptcp_error_report in protocol.c
Message-ID: <2024030409-cement-caretaker-9151@gregkh>
References: <2023100421-divisible-bacterium-18b5@gregkh>
 <20240228173157.255719-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228173157.255719-2-matttbe@kernel.org>

On Wed, Feb 28, 2024 at 06:31:58PM +0100, Matthieu Baerts (NGI0) wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> This will simplify the next patch ("mptcp: process pending subflow error
> on close").
> 
> No functional change intended.
> 
> Cc: stable@vger.kernel.org # v5.12+
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> (cherry picked from commit d5fbeff1ab812b6c473b6924bee8748469462e2c)
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - A simple conflict because in v5.15, we don't have 9ae8e5ad99b8
>    ("mptcp: annotate lockless accesses to sk->sk_err"), and one line
>    from __mptcp_error_report() is different.
>  - Note that the version of __mptcp_error_report() from after
>    9ae8e5ad99b8 ("mptcp: annotate lockless accesses to sk->sk_err") has
>    been taken -- with the WRITE_ONCE(sk->sk_err, -err); -- to ease the
>    future backports.

All 5.15 backports now queued up, thanks!

greg k-h

