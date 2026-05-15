Return-Path: <stable+bounces-247639-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHzjEC/5BmpoqAIAu9opvQ
	(envelope-from <stable+bounces-247639-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:45:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2F954D9C0
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08AAC3064722
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADB03D348B;
	Fri, 15 May 2026 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n4edfcrj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A96330D24;
	Fri, 15 May 2026 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778839927; cv=none; b=sASQgVMN6R4oD5U1fDZRcw8iMaGPuRcJVi/MiVUTiXko7MIaOhHhvLivAwBFKYGCHfki7G6B0EmVIOaxhvdvlMEB8daQDwO5g3wP/9OPBYy8B3jxwVMTWI4TBfGdyKBfQ3+6Pl/WMrtD29CucyeQ20k2e9Uyc0JwqAjVtLTgxss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778839927; c=relaxed/simple;
	bh=5a9rQy2fx66ID1NvQa43SYTCasp5uNQwN9IwfRDHL34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDSh3GHHFlQyfMjOBR7HOWi0H5yc3gKUsuPvE6wqA+UEt/sZrIqCGfg6ttA9qJFyzXuWFSk5RYyrDeauRH2ddYJhhqH4zPfbCL6STnEtauhZFdcUfHghprya225+OeNdtLXaPGDq/x3nWHLZ0MnQOCw10JFGZdgLxrjGOHI3qL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n4edfcrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B18C2BCB0;
	Fri, 15 May 2026 10:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778839926;
	bh=5a9rQy2fx66ID1NvQa43SYTCasp5uNQwN9IwfRDHL34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n4edfcrjIDqXEkDPoTP0t9m70vjESL47nwGlgAjqoQU7x1R1mOKFtCzfRUUfcBdJE
	 lH2hl0keanRi+FaQR9l4pHdxMFoNXmsYEmItvtJXQiqRxJrjaBt4ffqsrClG49yDkP
	 u5iYELMJQYOFS94Jimp7ufWFEwcQAubl/qEhPSRE=
Date: Fri, 15 May 2026 12:12:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ferry Meng <mengferry@linux.alibaba.com>
Cc: stable@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH v2 6.12.y,6.6.y] ksmbd: make ksmbd thread names distinct
 by client IP
Message-ID: <2026051551-chlorine-credible-86a7@gregkh>
References: <20260512023427.90371-1-mengferry@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512023427.90371-1-mengferry@linux.alibaba.com>
X-Rspamd-Queue-Id: 3E2F954D9C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247639-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 10:34:27AM +0800, Ferry Meng wrote:
> From: Namjae Jeon <linkinjeon@kernel.org>
> 
> commit 5da92a251e41f824d7e6b4d54d65dcdcfd69fda3 upstream.
> 
> This patch makes ksmbd thread names distinct by client IP address.
> 
> 100943 ?        S      0:00 [ksmbd:::ffff:10.177.110.57]
>  or
> 101752 ?        S      0:00 [ksmbd:10.177.110.57]
> 
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> Stable-dep-of: 77ffbcac4e56 ("smb: server: fix leak of active_num_conn in ksmbd_tcp_new_connection()")
> Stable-dep-of: 97f8d2648ef4 ("smb: server: fix active_num_conn leak on transport allocation failure")
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
> ---
> v2: Replace verbose [backport ...] description with standard
>     Stable-dep-of: tags per stable tree convention.

Why is this needed?

Is this part of a series?  If so, what is that series?

confused,

greg k-h

