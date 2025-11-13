Return-Path: <stable+bounces-194734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DF3C59BCC
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 20:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8CDD4EBF79
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 19:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888CC31A550;
	Thu, 13 Nov 2025 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsV5BefY"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B032C31A7F7
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061319; cv=none; b=IaNGn3aUq3Ceqbw3kW1o7eWgwaGIDfXMZawSBm9nyLrIyuNlIpdMC6m+w7lm/J6ODzZOfhAbPQrNPMwbV94aMBnP4U9wKQSSTn2z4rjBeFqQ4oJ5uPexUKaBknpff73mP6iI04Yn+6OcZk09ZHA+9Yx0XnPaZgxMHBpsj9bou08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061319; c=relaxed/simple;
	bh=+SiMYDKsDvlA1CxS/OuFN83dN3dzT9LFeE0MGxzCj/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDcPeyYL8fVKLafDFqBohKY7HvspdUxGcJUfk7m1EArgvY5VG0algem4wkx/MAIg5nv0RTxY3j8NXv3RRzd46vJUH814gQhFkSO6smzT6tf0M/xrcPW16tpIea79zHAHc5e2kcFn6mFqrwKYYvR8iZzvR1r5MMiLSFcuOyUKmfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YsV5BefY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763061316;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=gl27TkeJ+Jv6g4GKZo2+2m98f7KqJOB45HrVyAgyPyI=;
	b=YsV5BefYSMryRlqwQctgE7JILPBSfjLpeLCzC4VUaxrUrhdljaPQLfljSn9yZNNyl+DA8H
	wuM33FCtUyFAIncasqscpZdoIraFhhYhNzvrhSAPgw0eZv04DybrgvlZCuwcE25vbAtMFH
	2Dnt+smi2yAraDoIFsfZRTQ1bpsPsHQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-7r6I4KwEPb6N1P1gAYpl5w-1; Thu,
 13 Nov 2025 14:15:13 -0500
X-MC-Unique: 7r6I4KwEPb6N1P1gAYpl5w-1
X-Mimecast-MFC-AGG-ID: 7r6I4KwEPb6N1P1gAYpl5w_1763061311
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2ED7018AB40A;
	Thu, 13 Nov 2025 19:15:11 +0000 (UTC)
Received: from localhost (unknown [10.22.80.169])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D6B71800949;
	Thu, 13 Nov 2025 19:15:10 +0000 (UTC)
Date: Thu, 13 Nov 2025 14:15:09 -0500
From: Derek Barbosa <debarbos@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Sherry Sun <sherry.sun@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Jon Hunter <jonathanh@nvidia.com>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH printk v2 2/2] printk: Avoid scheduling irq_work on
 suspend
Message-ID: <jm64hv26zmnlyl6lu2zoodkaz5mxcykwo5kdbvv34kyyvc6ov7@vdtslu4slrux>
Reply-To: debarbos@redhat.com
References: <20251113160351.113031-1-john.ogness@linutronix.de>
 <20251113160351.113031-3-john.ogness@linutronix.de>
 <jvn24vsnd2utypz33k33n3ol3ihh44tcyhcbtjhfxnepuvb7hn@qhcikbtwioyk>
 <874iqxlv4e.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874iqxlv4e.fsf@jogness.linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi John,

On Thu, Nov 13, 2025 at 06:12:57PM +0106, John Ogness wrote:
> 
> I assume the problem you are seeing is with the PREEMPT_RT patches
> applied (i.e. with the 8250-NBCON included). If that is the case, note
> that recent versions of the 8250 driver introduce its own irq_work that
> is also problematic. I am currently reworking the 8250-NBCON series so
> that it does not introduce irq_work.
> 

IIRC the aforementioned scenario was just recently tested with an rc5 kernel
from Torvalds' tree. Sorry for any confusion

> Since you probably are not doing anything related to modem control,
> maybe you could test with the following hack (assuming you are using a
> v6.14 or later PREEMPT_RT patched kernel).

I'll give this a shot as a follow up, thanks for the suggestion

> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 96d32db9f8872..2ad0f91ad467a 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3459,7 +3459,7 @@ void serial8250_console_write(struct uart_8250_port *up,
>  		 * may be a context that does not permit waking up tasks.
>  		 */
>  		if (is_atomic)
> -			irq_work_queue(&up->modem_status_work);
> +			;//irq_work_queue(&up->modem_status_work);
>  		else
>  			serial8250_modem_status(up);
>  	}
> 
> > [0] https://github.com/Linutronix/linux/commit/ae173249d9028ef159fba040bdab260d80dda43f
> 
> John
> 

-- 
Derek <debarbos@redhat.com>


