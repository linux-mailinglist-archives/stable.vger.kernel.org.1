Return-Path: <stable+bounces-242970-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCx6CgJu+GnPuQIAu9opvQ
	(envelope-from <stable+bounces-242970-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 11:59:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ED04BB52C
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 11:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20A7B302260C
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 09:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E78388E70;
	Mon,  4 May 2026 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Y1Ij7GvS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RdvU7JoJ"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F55E388E4A
	for <stable@vger.kernel.org>; Mon,  4 May 2026 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888484; cv=none; b=LVam3Y5MschbfKQz/PRme8J+o77EUyRtPAgQuPdguKKz+VBxC2zcEAAj/tpJlYYD8/E8EWaSMY3lLLlFF0lF62hkg9lGrCRPEFZL0LveNrG5urGGzOn3HEyGl2CJ8BsNFNP552JqBi61F6QtwghrPnEPQIGvHxII1JQv1e6o3v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888484; c=relaxed/simple;
	bh=Z22DT8n8MvJ+UPfFoNO0tu3snN85dvGlrEPSpAPQA5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2pHvGMYo1+1MRtdU80c2Q4/sbyexy1dMvj77oGio1/0x7yRr9T7lbaSWIbrp8KgAkSEZVbIvvhcQ0XV4uJz0tD++FmWIGADwewHH9F87U4ILAABiianlFgD+6AyTm6iESFcp5V5IJnHTlj0wbQM/7hKplL6qCb011LG04pxJUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Y1Ij7GvS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RdvU7JoJ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E6A337A005B;
	Mon,  4 May 2026 05:54:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 04 May 2026 05:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1777888480;
	 x=1777974880; bh=T1NAWSvxgGuWwDd9/DoWOPbdHZ5PBRB7hvq9xzf30U4=; b=
	Y1Ij7GvSVAmQM0+Zudyx2NeuHnGdlMI/k4jVgp67P9FCndrQGfKMi3wlYJ/NKsRX
	tCnPuzeYlqiQohu+xB8RhbAs2PVL4jWU0ui0xBKDrjb09NFYYEe5obFHWY20U8t9
	LeQk483AiUrQG0dB565I06hsRdLHe1uk+raYjSAXT4EI7aYcFDiClnfg9o0gd01m
	jlj81xEjS+jCzjXS6QpKpjI1VFSDQWn+e9MZDvjlaiigxp68GsnQMehRAb2yGNbe
	6n6V7AcCkjhMoGxRUNVp/KkTIkyOVOJKYF6pENw3ecV3IoTQVay9sjhFaZMmJVq8
	xNX55UMs9TUmk2VeG6kt0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777888480; x=
	1777974880; bh=T1NAWSvxgGuWwDd9/DoWOPbdHZ5PBRB7hvq9xzf30U4=; b=R
	dvU7JoJtWHKGADQ8HMtbkVu29uhAhmMTzPe6K2pdHZDjG4tTTzQr+j6lwDkBXVl2
	mjrM8cDOFTvuTO38pXo3brYfHLspIEe/RWoSAJNDeZ/E4uHYcWNqksRXxnvvTOFK
	j8qDAwLB4PJS0T9OUAP83g0VzJn6mlNrw9SC/heihQ4lAnd44cT4+riv4kCBIQxR
	5Tiz7Qh2darjr3g1YKWg1f30NKXEMKGbhZ+H51WZvJy2VNJUXqllRQ582TGVqHKK
	K0CHP/3DF8pJ0MMZef7lCoqInfjJrpxJdCCk5IUBZozWaJ2pfGem91nCkwoGEeup
	pAHCGN6NTd2+pnmE67ULw==
X-ME-Sender: <xms:4Gz4aa161Nb-KfKojcvmizYLBI4fw4VWvzXyDlUP5_nyczO8sf_JeQ>
    <xme:4Gz4aQKroKxa5ZQi3xD4eRixyqzXVnb3Lh6rjfR5rfkVV6tGwA7xS6Z8CfZ_iCsS5
    u4SD-Y-7twwiiyr-XDMTMQ46DtqdIf6v4dT5PtLK9lCQkIwWg>
X-ME-Received: <xmr:4Gz4adhzApgCluZ0_Dc1SYDxDau7CuTNtMpoRnfCEKNmyIg1q-gTdXWCOt75MEykTRb596yaIPfHm5Kiuo-voLD2jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelkeehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeevveetgf
    evjeffffevleeuhfejfeegueevfeetudejudefudetjedttdehueffnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepuddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghshhgrlheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhnohgrtghkfedttddtsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:4Gz4aYDaQeErv4VA5mnuBmO0rjg2hAqO0aIUyRytHdAx0AqBwQ_D8Q>
    <xmx:4Gz4aX5xGRUfP8iCzz71WLnew7jyxZ3cF47mYYyClfBPJO1rzRrsAg>
    <xmx:4Gz4aVGXZn6_oN1Zh0mZLpguPnV652n0956iFkvM5km37WQqd0KMNA>
    <xmx:4Gz4aaD1x0Nd4eJt1Ha40LiWv9oqRZaTJDsMN1UdtybovcTYQvUwpg>
    <xmx:4Gz4aeE_cT0SIRcpkOVFNA6q4HR_2NgMCvoFnSKTVMvXR-pkJk5Azty8>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 May 2026 05:54:39 -0400 (EDT)
Date: Mon, 4 May 2026 11:54:38 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
Subject: Re: [PATCH 7.0.y] selftests/landlock: Fix socket file descriptor
 leaks in audit helpers
Message-ID: <2026050430-shimmer-evoke-f87c@gregkh>
References: <2026050112-flakily-uncaring-f2c8@gregkh>
 <20260502122702.517486-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260502122702.517486-1-sashal@kernel.org>
X-Rspamd-Queue-Id: 82ED04BB52C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242970-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,digikod.net,google.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,digikod.net:email,messagingengine.com:dkim]

On Sat, May 02, 2026 at 08:27:02AM -0400, Sasha Levin wrote:
> From: Mickaël Salaün <mic@digikod.net>
> 
> [ Upstream commit 9143d790337a0d066c2d632c802f69b981e6c23a ]
> 
> audit_init() opens a netlink socket and configures it, but leaks the
> file descriptor if audit_set_status() or setsockopt() fails.  Fix this
> by jumping to an error path that closes the socket before returning.
> 
> Apply the same fix to audit_init_with_exe_filter(), which leaks the file
> descriptor from audit_init() if audit_init_filter_exe() or
> audit_filter_exe() fails, and to audit_cleanup(), which leaks it if
> audit_init_filter_exe() fails in FIXTURE_TEARDOWN_PARENT().
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: stable@vger.kernel.org
> Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
> Reviewed-by: Günther Noack <gnoack3000@gmail.com>
> Link: https://lore.kernel.org/r/20260402192608.1458252-3-mic@digikod.net
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  tools/testing/selftests/landlock/audit.h | 26 +++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
> index 44eb433e96661..0007c247cd335 100644
> --- a/tools/testing/selftests/landlock/audit.h
> +++ b/tools/testing/selftests/landlock/audit.h
> @@ -379,19 +379,25 @@ static int audit_init(void)
>  
>  	err = audit_set_status(fd, AUDIT_STATUS_ENABLED, 1);
>  	if (err)
> -		return err;
> +		goto err_close;
>  
>  	err = audit_set_status(fd, AUDIT_STATUS_PID, getpid());
>  	if (err)
> -		return err;
> +		goto err_close;
>  
>  	/* Sets a timeout for negative tests. */
>  	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
>  			 sizeof(audit_tv_default));
> -	if (err)
> -		return -errno;
> +	if (err) {
> +		err = -errno;
> +		goto err_close;
> +	}
>  
>  	return fd;
> +
> +err_close:
> +	close(fd);
> +	return err;
>  }
>  
>  static int audit_init_filter_exe(struct audit_filter *filter, const char *path)
> @@ -441,8 +447,10 @@ static int audit_cleanup(int audit_fd, struct audit_filter *filter)
>  
>  		filter = &new_filter;
>  		err = audit_init_filter_exe(filter, NULL);
> -		if (err)
> +		if (err) {
> +			close(audit_fd);
>  			return err;
> +		}
>  	}
>  
>  	/* Filters might not be in place. */
> @@ -468,11 +476,15 @@ static int audit_init_with_exe_filter(struct audit_filter *filter)
>  
>  	err = audit_init_filter_exe(filter, NULL);
>  	if (err)
> -		return err;
> +		goto err_close;
>  
>  	err = audit_filter_exe(fd, filter, AUDIT_ADD_RULE);
>  	if (err)
> -		return err;
> +		goto err_close;
>  
>  	return fd;
> +
> +err_close:
> +	close(fd);
> +	return err;
>  }
> -- 
> 2.53.0
> 
> 

Does not apply to the tree :(


