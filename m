Return-Path: <stable+bounces-80570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBA198DEF5
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF6B1B21205
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30B41D041C;
	Wed,  2 Oct 2024 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ET+uEi/+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80370748F;
	Wed,  2 Oct 2024 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882549; cv=none; b=HSjinkB6B9GfHX1nJMohegESU/TquKpQ3TbFXBvsn1r6XfL5AwwK3NCfxfTMgYzneNPm4yrh+IOt5s1tdq0iXXQAuF0GUkuy232g9yan8lHWZT5meQQA1EGt0LNsqXCYtlXNfENK4ZcJogHH/Ahk4UIhyRLx7+oPk5q1wp+dizg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882549; c=relaxed/simple;
	bh=iNTmnnov982hQMcmNS7d77dCqNenqlcR5dclcXwSK7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMlavynPpUjx3jcDywWTHWCLzClu7gls63JhgThrpHScRDJ9q8x8q2BX9IRwp/xLxTBSgmppTfNzmK+GrDUlI1sk/Jqwb3ClBH15tHp80p8D9p4lLPEmuHSSlbK+6Ry2+Y00AujC1i6X77iyD43lrQmNSckJQiypfbG84n7waWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ET+uEi/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B878C4CECD;
	Wed,  2 Oct 2024 15:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727882549;
	bh=iNTmnnov982hQMcmNS7d77dCqNenqlcR5dclcXwSK7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ET+uEi/+65ZVja/TcAbPlyG5bczJ2MQRjDDnBdxds970NA5IrqBp6Tw8U4Y0Jihst
	 x5RntHaQMj5b/wctYlzMpB9YgKMSAk3l2AET2JHO5sHUdbdOjxuaDm9yK25ikg1Lvv
	 WsIel0wuFGhT9A29pyaB2p51K1oVkiASsvncqlsB5dpOzU8mDApsCAPcJkmd5LdczR
	 19oX9JAZLK5T5i5+ovQoxo2QFycZZZnCyH2jhfwzJGfeCyECqXGM4LPX8k8MGtu2jQ
	 70noPNQYqNlK0grE/6eUCufW0yp0Doo2Dgr3EV9/6/wM/KnvG0LJ8t6tcE79UtjvGf
	 Gu7taUJp6/4OA==
Date: Wed, 2 Oct 2024 08:22:27 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andrej Shadura <andrew.shadura@collabora.co.uk>
Cc: linux-bluetooth@vger.kernel.org, Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev, kernel@collabora.com,
	George Burgess <gbiv@chromium.org>, stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix type of len in
 rfcomm_sock_{bind,getsockopt_old}()
Message-ID: <20241002152227.GA3292493@thelio-3990X>
References: <20241002141217.663070-1-andrew.shadura@collabora.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002141217.663070-1-andrew.shadura@collabora.co.uk>

Hi Andrej,

On Wed, Oct 02, 2024 at 04:12:17PM +0200, Andrej Shadura wrote:
> Commit 9bf4e919ccad worked around an issue introduced after an innocuous
> optimisation change in LLVM main:
> 
> > len is defined as an 'int' because it is assigned from
> > '__user int *optlen'. However, it is clamped against the result of
> > sizeof(), which has a type of 'size_t' ('unsigned long' for 64-bit
> > platforms). This is done with min_t() because min() requires compatible
> > types, which results in both len and the result of sizeof() being casted
> > to 'unsigned int', meaning len changes signs and the result of sizeof()
> > is truncated. From there, len is passed to copy_to_user(), which has a
> > third parameter type of 'unsigned long', so it is widened and changes
> > signs again. This excessive casting in combination with the KCSAN
> > instrumentation causes LLVM to fail to eliminate the __bad_copy_from()
> > call, failing the build.
> 
> The same issue occurs in rfcomm in functions rfcomm_sock_bind and
> rfcomm_sock_getsockopt_old.

Was this found by inspection or is there an actual instance of the same
warning? For what it's worth, I haven't seen a warning from this file in
any of my build tests.

> Change the type of len to size_t in both rfcomm_sock_bind and
> rfcomm_sock_getsockopt_old and replace min_t() with min().
> 
> Cc: stable@vger.kernel.org
> Fixes: 9bf4e919ccad ("Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_old()")

I am not sure that I totally agree with this Fixes tag since I did not
have a warning to fix but I guess it makes sense to help with
backporting.

> Link: https://github.com/ClangBuiltLinux/linux/issues/2007
> Link: https://github.com/llvm/llvm-project/issues/85647
> Signed-off-by: Andrej Shadura <andrew.shadura@collabora.co.uk>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  net/bluetooth/rfcomm/sock.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index 37d63d768afb..c0fe96673b3c 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -328,14 +328,15 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
>  {
>  	struct sockaddr_rc sa;
>  	struct sock *sk = sock->sk;
> -	int len, err = 0;
> +	int err = 0;
> +	size_t len;
>  
>  	if (!addr || addr_len < offsetofend(struct sockaddr, sa_family) ||
>  	    addr->sa_family != AF_BLUETOOTH)
>  		return -EINVAL;
>  
>  	memset(&sa, 0, sizeof(sa));
> -	len = min_t(unsigned int, sizeof(sa), addr_len);
> +	len = min(sizeof(sa), addr_len);
>  	memcpy(&sa, addr, len);
>  
>  	BT_DBG("sk %p %pMR", sk, &sa.rc_bdaddr);
> @@ -729,7 +730,8 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
>  	struct sock *l2cap_sk;
>  	struct l2cap_conn *conn;
>  	struct rfcomm_conninfo cinfo;
> -	int len, err = 0;
> +	int err = 0;
> +	size_t len;
>  	u32 opt;
>  
>  	BT_DBG("sk %p", sk);
> @@ -783,7 +785,7 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
>  		cinfo.hci_handle = conn->hcon->handle;
>  		memcpy(cinfo.dev_class, conn->hcon->dev_class, 3);
>  
> -		len = min_t(unsigned int, len, sizeof(cinfo));
> +		len = min(len, sizeof(cinfo));
>  		if (copy_to_user(optval, (char *) &cinfo, len))
>  			err = -EFAULT;
>  
> -- 
> 2.43.0
> 

