Return-Path: <stable+bounces-274505-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FDAlHCt/Vmrh7QAAu9opvQ
	(envelope-from <stable+bounces-274505-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 20:25:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADE4757D3B
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 20:25:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=AyDctlib;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274505-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274505-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 264703041BFC
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EB9412C07;
	Tue, 14 Jul 2026 18:25:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1D84156D2
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 18:25:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053535; cv=none; b=cN4ki8unQvn0gETOZwlQVrq8rWq44GkFlJaBzV8Ti/4R2EwzkL7FwAxM4M9njyaqBMBhiaGg1pTfVquvqg4HaVBWVEinVYU4nlG38uALTgWmt6eT4tV/a21GgMcq8b+fNjhp2FUqd3aekZsZ0RcX1dOrvJD3AkmDWDCfniKvMXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053535; c=relaxed/simple;
	bh=GUQiZVnvyblyYmPUnGk7w9kozmaRu3795r/F+XDtpdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlMCY9gdEQZ8NGpTLT+mb7hzEkbyw6K7SZpnOV0Nn6/FoqBeHlqN94TVWTRwRpm4lI4v/fIjafvmQs4148rOBeTx+F3gbMYRZzHksCJB6ICkRr1fCeN4FyLTfUkGTnO7k6R+8q+mSCFvSnqAPTneTq7TUcVynuhQZ9KbjR5+f9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AyDctlib; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so10416795e9.2
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 11:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784053528; x=1784658328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2cRBijGnW1MWHAmm7rN0D7TcOhmMrBvTuTtZRZ3u9v0=;
        b=AyDctlibyhMErq4akXpL9kUEhmumtBLkMnmt4QMS58Vi6NHTiaSkabLcPy6CDk33AQ
         GAqaAohXBsakbpNHX3BBOe+RUaOeXkppTXGFy8XCROjn9I8yFYZ3JpmJEdo3XvkBxOtZ
         htmFgdN0IqfzYBWx6N01a8oSJdw7/xQt8E7nq0swcsD3FEb0q6Beu0bGGlKMzA2diiW5
         KGQolyd+mWxpxaSFZttV648hQbAw2QpD0OVaflIQE9NpQ/4SVK4GxY58fe3VuFpnnK+P
         Lm1jOBeUEPcMqEdBNhf/47aJKoXboyODoKl1I4Mx85fFoDpUt1rAeJs5cOECny+cpyww
         gIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053528; x=1784658328;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2cRBijGnW1MWHAmm7rN0D7TcOhmMrBvTuTtZRZ3u9v0=;
        b=FeUYYCl8r1minvuNLoewGXhNRe3Ay0VGoyhh0Z5496BSkXqur8CI8Lxjcigmfxllev
         +/D/uvS5LuMYOsfjTcBWpVoaqQzHi05Tg+28Vvh506e81Gn1IQd42GH4lsSmX3CcPKay
         lxrMbAkK5NudfEdtrgZ9ziXdt+dD7WnpquAgDliSWIYY7DsuFggEvLsO+fKVNAtxfucM
         TZWqrUJbo+U37TWTJD/Yc2ArlSg+sHBkRqB8aWhecjM4H8bMDHNF9Fyn6RZ56D2wLfkw
         Upl5i6c9fepvNk1SJpE2TRtBBASSMLbN+S8P51Ap6n4RFIG6jD7sxzfamwWytGumYfjb
         gV1A==
X-Forwarded-Encrypted: i=1; AHgh+RrBKw8Yl7PquONyiMatKq7QL8/I4913mJYdcVjTBj2S88PJDHhg4ypYrI5VhSGYA2Dgxs2vQTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Aba5mKRNITxizMcMCR9C+Tq9Ovv/Oi60OZwCSnQxDg08LA+R
	p8WOgKkjMFZtbOAZgueBOB8Ts+iggBPqWcq2G2ewqk9g5y9h/O+tWaZOlS41y1n3wt0=
X-Gm-Gg: AfdE7clX7bFTVF1pIfJSsIv8Ps/p661N5R+NKj3qoMnlWrk9D9Wy9z4ytLHxgXPVLZe
	+jRDSSu4vEfs83nXtWgWf+7HwatTha7X3RAqwqkoQE8W9GJjIuHNE9VfxzBrit0argjE2rC7tpY
	azQvkd7ihH1JEtxbn+P7i0yU/f0p6+7b6bvS3WhCn9OKHnZQ+5iI+gddMFpZzuLLwOhcRyYywU5
	PN5oVJ4DhEDc40Y2ew50iZF4Qiv7y4K0HLIrFVePFfVHvcvqRXtvQ5jRTSWAfzF7awlt3nGtn8s
	f5CiJYqacccAZsldo+BKgHvZYV/yl0uUgX+DjzQJs2cPizuJZOJQiZwui2KYKswF4XBQyxMq52t
	ucoLQXamFA74Lw8SjU5PAlrbPq0POJBf9HT7wx0WuZXf/swSCIM2GXg6Wgmx3Li5tqvMTNscphy
	nkLKTipCr7l1z7CKXuOmBtTxj1ObMda/s9r4jVJEVXuy7H67OPPl4UOvavP0EoEiRzYA==
X-Received: by 2002:a05:600c:c4a2:b0:493:a438:7f98 with SMTP id 5b1f17b1804b1-493fd45f96bmr130187945e9.18.1784053528076;
        Tue, 14 Jul 2026 11:25:28 -0700 (PDT)
Received: from ?IPV6:2001:a61:13c3:1c01:3157:c849:4aaa:fa65? ([2001:a61:13c3:1c01:3157:c849:4aaa:fa65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950871d1bdsm92527485e9.1.2026.07.14.11.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 11:25:27 -0700 (PDT)
Message-ID: <4e7abb00-f0ab-4008-a0bf-5ccd90102aca@suse.com>
Date: Tue, 14 Jul 2026 20:25:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: serial: sierra: fix slab out-of-bounds read in
 sierra_instat_callback
To: Jay Vadayath <jkrshnmenon@gmail.com>, gregkh@linuxfoundation.org,
 johan@kernel.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Lukas Dresel <lukas@artiphishell.com>
References: <https://lore.kernel.org/all/2026071453-reminder-ageless-dcea@gregkh/>
 <20260714181142.10976-1-jkrshnmenon@gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20260714181142.10976-1-jkrshnmenon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274505-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jkrshnmenon@gmail.com,m:gregkh@linuxfoundation.org,m:johan@kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:lukas@artiphishell.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[oneukum@suse.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:from_mime,suse.com:mid,suse.com:email,suse.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0ADE4757D3B

On 14.07.26 20:11, Jay Vadayath wrote:
> The interrupt-in URB buffer is allocated based on the endpoint's
> wMaxPacketSize. A device declaring wMaxPacketSize == 8 gets an 8-byte
> buffer from kmalloc-8. When such a device delivers a short packet,
> sierra_instat_callback() still dereferences transfer_buffer as struct
> usb_ctrlrequest and reads a further byte at data[sizeof(*req_pkt)], one
> byte past the end of the allocation.
> 
> Reject the URB when fewer than sizeof(struct usb_ctrlrequest) + 1 bytes
> were received.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Jay Vadayath <jkrshnmenon@gmail.com>
> Reported-by: Lukas Dresel <lukas@artiphishell.com>
> Signed-off-by: Jay Vadayath <jkrshnmenon@gmail.com>

Nacked-by: Oliver Neukum <oneukum@suse.com>

> +
> +		if (urb->actual_length < sizeof(struct usb_ctrlrequest) + 1) {
> +			dev_dbg(&port->dev, "%s: short interrupt transfer: %d bytes\n",
> +				__func__, urb->actual_length);
> +			return;
> +		}

I am sorry, but you cannot do this. Not here.

> +
>   		if ((req_pkt->bRequestType == 0xA1) &&
>   				(req_pkt->bRequest == 0x20)) {

This is the test you need to check how long the reply needs to be.

If we look at the full evaluation of the package from the driver we have:

                 }
                 if ((req_pkt->bRequestType == 0xA1) &&
                                 (req_pkt->bRequest == 0x20)) {
                         int old_dcd_state;
                         unsigned char signals = *((unsigned char *)
                                         urb->transfer_buffer +
                                         sizeof(struct usb_ctrlrequest));

                         dev_dbg(&port->dev, "%s: signal x%x\n", __func__,
                                 signals);

                         old_dcd_state = portdata->dcd_state;
                         portdata->cts_state = 1;
                         portdata->dcd_state = ((signals & 0x01) ? 1 : 0);
                         portdata->dsr_state = ((signals & 0x02) ? 1 : 0);
                         portdata->ri_state = ((signals & 0x08) ? 1 : 0);

                         if (old_dcd_state && !portdata->dcd_state)
                                 tty_port_tty_hangup(&port->port, true);
                 } else {
                         dev_dbg(&port->dev, "%s: type %x req %x\n",
                                 __func__, req_pkt->bRequestType,
                                 req_pkt->bRequest);
                 }

In this branch:

                 if ((req_pkt->bRequestType == 0xA1) &&
                                 (req_pkt->bRequest == 0x20)) {

replies must be at least sizeof(struct usb_ctrlrequest) + 1 long.
But in the else branch a length of sizeof(struct usb_ctrlrequest) will do,
because they do not evaluate the signal.

In other words, you stop processing messages if a message the driver does not
care about, but is valid under the specification arrives. That breaks the driver.

	Regards
		Oliver


