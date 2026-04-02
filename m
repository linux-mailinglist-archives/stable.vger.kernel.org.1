Return-Path: <stable+bounces-233009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFkcGK9pzmmpngYAu9opvQ
	(envelope-from <stable+bounces-233009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 15:05:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D7F389653
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 15:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3249309C9B5
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 12:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7A23E1D14;
	Thu,  2 Apr 2026 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJ8QKaYk"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD6D39C015
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775134687; cv=none; b=qsSFPsquHLIEnAYOUvCBidsQN4Pf+XH/Wy2cZ7LqVg4Qn5gw0jUn9LYLNwUn7EvTec5NrHWabQB/gWFVKCLtKVtNQvJ22VBzkhHaEd7xRTSte7cEIhp2wjaSzmhhwOozs7WkQYW9DSG54atHy9b75luHfg72SZ2oA8WYz3tDkDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775134687; c=relaxed/simple;
	bh=6FnZYlwyMDNLBNq27zxxOGZMwlAGDhGk7FWZ0NbrvLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNStBidyf0GOB8jG9/Bprz8vP58MgDzz4WZWLGlly5Xn/DWA5i9QtfPZbkBICiYVAzI4jd2TFkMDSuZKJYw6KfU4taC0NiEl7Sd3o1gniD2Rg2OhePHxmglsrtI5f+gEmCDYSwNjn6sO1nggs4BN6JiJ8/PgFSKLiGdjBRKCScA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJ8QKaYk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775134680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eoOVeXGUHJIPyXgQfDU061gQQk/lbF5NXSd6xI6h5OM=;
	b=NJ8QKaYkH+Hcb6IzaSym+P2NUFzs+npgCzceB54vJjCoZ+vvyUFqj/ymbHHhQjAse91bIw
	JJGBwOPFDlrcG00oX5u9TWQQvMI0+1cvxupkLwLrUw02V+eVLRWHOvLIdSSJjDJLP29xyi
	SssilN56iM/Qs0pthy0X/s8kfHmG9AQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-HW5H98b1M_uiPAQjctu9Jg-1; Thu,
 02 Apr 2026 08:57:56 -0400
X-MC-Unique: HW5H98b1M_uiPAQjctu9Jg-1
X-Mimecast-MFC-AGG-ID: HW5H98b1M_uiPAQjctu9Jg_1775134675
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D5F21800283;
	Thu,  2 Apr 2026 12:57:55 +0000 (UTC)
Received: from fedora (unknown [10.44.36.60])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9086030002D2;
	Thu,  2 Apr 2026 12:57:52 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  2 Apr 2026 14:57:54 +0200 (CEST)
Date: Thu, 2 Apr 2026 14:57:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Qi Tang <tpluszz77@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Cyrill Gorcunov <gorcunov@openvz.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] prctl: require checkpoint_restore_ns_capable for
 PR_SET_MM_MAP
Message-ID: <ac5nzyCMJSkwuhRh@redhat.com>
References: <20260402111332.55957-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402111332.55957-1-tpluszz77@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233009-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvz.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 48D7F389653
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/02, Qi Tang wrote:
>
> The original commit f606b77f1a9e ("prctl: PR_SET_MM -- introduce
> PR_SET_MM_MAP operation") states "we require the caller to be at least
> user-namespace root user", but this was never enforced in the code.
>
> Add a checkpoint_restore_ns_capable() check at the top of
> prctl_set_mm_map(), after the PR_SET_MM_MAP_SIZE early return.  This
> requires CAP_CHECKPOINT_RESTORE or CAP_SYS_ADMIN in the caller's
> user namespace, matching the stated design intent and the existing
> check for exe_fd changes.

Can't really comment... but if you add this check at the start, then you
should also remove the same checkpoint_restore_ns_capable() check below?
In the "if (prctl_map.exe_fd != (u32)-1)" block.

Oleg.


> Fixes: f606b77f1a9e ("prctl: PR_SET_MM -- introduce PR_SET_MM_MAP operation")
> Cc: stable@vger.kernel.org
> Cc: Cyrill Gorcunov <gorcunov@openvz.org>
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---
>  kernel/sys.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index c86eba9aa7e9..2b8c57f23a35 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2071,6 +2071,9 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>  		return put_user((unsigned int)sizeof(prctl_map),
>  				(unsigned int __user *)addr);
>  
> +	if (!checkpoint_restore_ns_capable(current_user_ns()))
> +		return -EPERM;
> +
>  	if (data_size != sizeof(prctl_map))
>  		return -EINVAL;
>  
> -- 
> 2.43.0
> 


