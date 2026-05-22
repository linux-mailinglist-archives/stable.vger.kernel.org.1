Return-Path: <stable+bounces-253807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qS46BydrEGoTXQYAu9opvQ
	(envelope-from <stable+bounces-253807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 16:41:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F255B65A4
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 16:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73CF3303D167
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 14:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4A4466B7D;
	Fri, 22 May 2026 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDT5wZfc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23AC466B79;
	Fri, 22 May 2026 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779460138; cv=none; b=lRgsP7IedNwAI0BcZs+0qi2FsdgksDbBVuQFJlCv0mpl+ivJwiy9P0PGyb/q7rPsk9fD74XD7/FrX58pzL2E9u1uILi7SGGnNVW5hQ/AI3A+iAmkZrgU8eB6Bm4xm02hoWLfIc6dJLB5D87OgTC7IbSV9ytwo6/QmyPuWDqQRKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779460138; c=relaxed/simple;
	bh=zpSKTJxm0NxhcKxlHV85cD94sU56IQs9PLDMXtQBFBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhMc1KsApRCBSV0GpQfoSNhBIO9FPTLH5mZ+B7WEzB4qjqunFHTK6O1TI7ypunspB+9TaATsgGkoewLlA7v9PMarjmOsCQBu+acCFlWI3sjxGNuDH1GRmpLfkqZzMbbysqBgOBb8i4aoVxWzFmKb5V/0XlqkghjVSOjtJ1JoyVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDT5wZfc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920CE1F00A3D;
	Fri, 22 May 2026 14:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779460132;
	bh=oMRLdiweyomYJf4l43aIcs7znHQoZRmqYCz1TIA44x8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eDT5wZfcvw8SmLggNp7AJCX9SCjyt60JUuHNx2V4A6L4WjvDIPZ7TkPwk2TTwnjQb
	 JmKr3s5M95qpYxn1sCSZAWOFXmYnWEycN7jG80gcsGPfJMCHTfVdJYoSm3ySaiBMEW
	 6DZvU0pG7O3loxSaZE2KLiszW3cKUBTIxzikmxru7rFgNGyonK9KM0xznFd9rxsrnJ
	 gwelbQyES1tCsdSwmA/RPGe9gOSPq/BjsPrYNSemT379jJAa9W/lrbUB6rjmBFdeLo
	 1lqAD5JcSqCk32fETSUH/+3XqwqVMg9FIXq3ypzwUrd/69ODvMkWBSneKX9fE1/Ufv
	 e0MmbB0oYzcNA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wQQrq-00000003ydS-1VkW;
	Fri, 22 May 2026 16:28:50 +0200
Date: Fri, 22 May 2026 16:28:50 +0200
From: Johan Hovold <johan@kernel.org>
To: Cen Zhang <rollkingzzc@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: cypress_m8: fix memory corruption with
 small endpoint
Message-ID: <ahBoIngkuYZ-__QA@hovoldconsulting.com>
References: <20260522101621.927034-1-johan@kernel.org>
 <CAB7XQsFYZcNssaxjYYoBm4ROgFAAYHYOKXWzFs2YK4cLiYF0Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB7XQsFYZcNssaxjYYoBm4ROgFAAYHYOKXWzFs2YK4cLiYF0Qg@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253807-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,hovoldconsulting.com:mid]
X-Rspamd-Queue-Id: 76F255B65A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 10:16:07PM +0800, Cen Zhang wrote:

> I took a closer look at your patch and tested it on top of commit
> 917719c412c4 with KASAN enabled.  I applied your patch, rebuilt the
> kernel, and reran the same reproducer I used for the report.
> 
> The original reproducer still triggers:
> 
>   BUG: KASAN: slab-out-of-bounds in cypress_read_int_callback+0x240/0x7f0
>   Read of size 1

> I think the reason is that your patch rejects small interrupt-out
> endpoint sizes, but this reproducer has interrupt_out_size = 16, so the
> new check is not hit.  The remaining issue is on the read side:
> packet_format_1 reads data[1] before checking that urb->actual_length
> contains the two-byte header.
 
Sorry if it wasn't clear but my patch isn't meant to replace yours as it
fixes a separate issue (introduced by the same commit).

> I also tested a variant with interrupt-out wMaxPacketSize = 1.  Your
> patch rejects that device during port probe with -EINVAL before ttyUSB0
> is exposed, so the new check works for that endpoint-size case.

Thanks for testing it.

> Please let me know if I missed anything in the test setup or in the
> analysis above.  I am happy to help test another version, or send a
> follow-up patch for cypress_read_int_callback() using your earlier
> comments if that would be useful.

I'm hoping you can send me a v2 of your fix.

Johan

