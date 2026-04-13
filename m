Return-Path: <stable+bounces-235986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8K2vEXzJ3GmcWQkAu9opvQ
	(envelope-from <stable+bounces-235986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:46:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7BF3EAC87
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 879933044A40
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44073806DE;
	Mon, 13 Apr 2026 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o3ci55vA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2894A0C;
	Mon, 13 Apr 2026 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776076826; cv=none; b=U5PfT76D0WLQxl2K0hPJYDoleEuCAq8x4CMyi91kiIv4Dcxt09yAoOtYBftyjRS10l2VLBx3Sco/HL7tTyHcFp7PK3aLxU2UaKahaQSsqCQQ9Bgr0o7+2UzvXUFYD7n9oev8I/HYk8gWL4s5/xyyqhP0IYgvW1uylrl5e8wZBTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776076826; c=relaxed/simple;
	bh=30gb6BbiHDDcRBmzTwvcKQcIicCYNVaUp+xkMGTEQuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yp5qWutysNr6uhTaAdAzLfrlwdW64svw+q/HSN9TN9WO/8XShLBWES68VH6MzkNKcQbhrdswkseHSUHTDQjdqkYr9UWfF07BFWFOa6MgF7F6I+CP1WzNGI9rZyBQwm0w0ivXJR/+VagUG4VitKCOovG+hboLN8lpTxO6tCXo5Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o3ci55vA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63E4C116C6;
	Mon, 13 Apr 2026 10:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776076826;
	bh=30gb6BbiHDDcRBmzTwvcKQcIicCYNVaUp+xkMGTEQuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o3ci55vA7y9akicILMtoPVHxzZ06cQr6KXiNSCiNq2rGqIU/42lRLn34/FgULJPHn
	 SgYYyAMUe8vJmjsSsSNVYQjYTxQtzODvGrIgpMchfm+9FLF/MSqduh1BT5ZeieneLh
	 s0y+bvZSjRNq6Znzra5tzJgb/D9tYKNtP2bDawhM=
Date: Mon, 13 Apr 2026 12:40:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Marco Crivellari <marco.crivellari@suse.com>,
	Johan Hovold <johan@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	William Wu <william.wu@rock-chips.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	Ben Hoff <hoff.benjamin.k@gmail.com>,
	Terry Junge <linuxhid@cosmicgizmosystems.com>,
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	John Keeping <john@keeping.me.uk>, Lee Jones <lee@kernel.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_hid: fix device reference leak in
 hidg_alloc()
Message-ID: <2026041352-morally-campfire-c4cf@gregkh>
References: <20260413081237.2677048-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413081237.2677048-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235986-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,rock-chips.com,gmail.com,cosmicgizmosystems.com,collabora.com,keeping.me.uk,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E7BF3EAC87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 04:12:37PM +0800, Guangshuo Li wrote:
> hidg_alloc() initializes hidg->dev with device_initialize() before
> calling dev_set_name(). If dev_set_name() fails, the function currently
> jumps to err_unlock and returns without calling put_device().
> 
> This leaves the device reference unbalanced and prevents hidg_release()
> from being called. Calling put_device() here is also safe, since
> hidg_release() only frees resources owned by hidg.
> 
> Route the dev_set_name() failure path through err_put_device so the
> device reference is dropped properly.
> 
> Fixes: 89ff3dfac604 ("usb: gadget: f_hid: fix f_hidg lifetime vs cdev")
> Cc: stable@vger.kernel.org
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>   - correct Fixes tag to 89ff3dfac604
>   - add Reviewed-by from Johan Hovold

As you are using a tool to find/fix these things, you HAVE to mention
that as per our documentation.  Please go and read that and then
resubmit all of thes patches that need that attribution added.

thanks,

greg k-h

