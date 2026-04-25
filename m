Return-Path: <stable+bounces-241150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HGt0GElV7Wl9iAAAu9opvQ
	(envelope-from <stable+bounces-241150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 01:59:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DEA468611
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 01:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA2BC3011110
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 23:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3212A397689;
	Sat, 25 Apr 2026 23:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="F0IUGd2u"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6014C389118
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 23:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777161538; cv=none; b=K6OkQ1FsUSUFw+3eQEihrq36MvRO74Fz9JT4U1OM2rNEcj7ssvA15OJ4eHUYh8NbdpTv7q+JtRIYk2qA5gifPP0xi2CqC6b6SJcjGUA7a/Gmyk6mMWxlr3f7uxiG6HSyrOqAkNBavE6ieUudErPlFl036Jq2ovdKapHOuFIODJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777161538; c=relaxed/simple;
	bh=TmFIqwea7P1/3JG6bQ8FE5XxmSvpiyrmnBPxG9ZPJk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ch1OxXWPacO7tqobcinS4J3KlNX2EH84GrnHUzuPIhxo51ZcT+xB/6kfafRdGIZmwoKDazhTsTyXqigtotBOuE11O7DEVvmZ1e4+skhCrhKPaN0eSs2owKyKbeu0bkWHSF18OTDapV0OfSmF6TJKbmaJFT19tRXsHw3mWb1MTQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=F0IUGd2u; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-479fc1fc048so3245601b6e.1
        for <stable@vger.kernel.org>; Sat, 25 Apr 2026 16:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1777161535; x=1777766335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKKJCH+5uQ5Lecx+O6GjrzJ1UpPIHJaSU1gVtB7eY38=;
        b=F0IUGd2uvg+qYP3c3V5Rdv8KDRKnjKd8IvnwJvXjDn2Viw777lX3a1HFEGgEXKxpSl
         tfm6B5r+m41i5wPGkJ2PgE1FCrxFgXqQkKhLZ25SfZQIqTHOAdopSMAM5++f2yGV01Dk
         2B1YPQJWooSSMMQtebjdXdU0iCUrVmm/C4lSb8B57MUWi1In2QP19DjOuMvwjTT4bUyY
         NITlu2XT/e9CT4+dSHeTbQ2eoP+UN2SayAj6MHIV7huF7J7CyNg+QxeulD1eiefnSdnx
         +jqsrJrevgNCIpmKXurt89G1WpknAe8VnmJoNExQgR5vaLAXMrfm24X548z84u+JbTX7
         yEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777161535; x=1777766335;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SKKJCH+5uQ5Lecx+O6GjrzJ1UpPIHJaSU1gVtB7eY38=;
        b=GgMK8fCiJWDX0MqZSLbEP72UMGBb9BtJSnNTfETkMo6LR9NIOnR56ip2UPrVOXJ5Nw
         tXjAAE7Cfqb+mayqS7z9F0fpjl45JLOgiB+pwdrDsk/pBJc3MGIRukb5OVfRJZ3doo+P
         iv5J/RlZmXdrGn+I+HgtDpmXO/ZONKvoSViOgZAjW/mgrEuGFjVyQovwND4onk8Et87Z
         5KLZtaDz3SXE7lbhgkjMM6CZKZ31/GjxQspfgdY9tD+f8CrgNontwQkfjgSe0aaLtXGz
         8umq8syy84ki27VAUo2gPLJ3jQCGfpDJvUgkZV7/SIDMe3bj4YsfltSXw2vrIW4L9ZMB
         PyJg==
X-Forwarded-Encrypted: i=1; AFNElJ9WXE8iOeW0H9ydJbwOc2NlsULhhvdYBdniyF76F8vqDjeQ63DNpgifxQedvnAImNblNrxZRnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyafeSrKpzbwxbaC1X9zDdrLXPflOxf/bnIHrOIXA8gIxOAKGzc
	8adkl+N7lnf4Xs6T73ZDDrLF5jXuoc/lVhP75XtKE1hUTazBgedlnIVpYrs7CLswcvc=
X-Gm-Gg: AeBDieuVh1F3bVvGR2cvV2gkOCQ6L+paXoX3Ms3wCDTOUCJjY045y+G/VUcst92cT41
	LNZEHdU3Bi2sayKYZqJqxlr8bbAHFIZUJX7B1MoWLjItX9IN6HYkLVjRPoxqh+Px9D9n/ykf88A
	WzZW+nl8mad/XM/c6ys4hSijNJxrCb49eXRwUaMkKmK+DBfxykXswQWR32b1Dq1rKYQvZAbwQ5n
	kCRR1TafJDMCpUIfSwI8iYOZwpUKJGLVrcfJe5PxmGXueGDKN16wTGVKA/YbYY7v2Y37Yupvq92
	DKhUsFReMU+CDUGMzxNZXGDJK6n3kPk0D32ShduuueCZF8qqjQvdy+r5RsNpZbbGkB5HUun04Cy
	evu/2jexUB7Sq959Rfta7EIKjrFZ0SarTFncZf/cDAiYCg3RbwmYeU4AysSmHGRO5NrVfaTGEtJ
	qyjPhvXIX7v7egVFFSI3JySmI+kC9cU3fGWFBRYzaQb0/h00GUck39abbJJW/kHDv+mJPBHv1gA
	BLZ8WWHXeYKjO9c2rVqbvCUbw==
X-Received: by 2002:a05:6808:4fec:b0:467:112e:4590 with SMTP id 5614622812f47-4799cb31b57mr20806105b6e.46.1777161535251;
        Sat, 25 Apr 2026 16:58:55 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:6f78:34bd:5e93:9329])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479a028cab5sm18097578b6e.16.2026.04.25.16.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 16:58:53 -0700 (PDT)
Date: Sat, 25 Apr 2026 18:58:48 -0500
From: Corey Minyard <corey@minyard.net>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Matt Fleming <mfleming@cloudflare.com>,
	openipmi-developer@lists.sourceforge.net,
	Tony Camuso <tcamuso@redhat.com>, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ipmi: Add limits to event and receive message
 requests
Message-ID: <ae1VOEhdR0H0rf0a@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20260421132544.2666174-1-corey@minyard.net>
 <20260421132544.2666174-3-corey@minyard.net>
 <aeyJ0fClAWI2lBwL@matt-Precision-5490>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeyJ0fClAWI2lBwL@matt-Precision-5490>
X-Rspamd-Queue-Id: A6DEA468611
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241150-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[corey@minyard.net];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,minyard.net:email,minyard.net:dkim,minyard.net:replyto,cloudflare.com:email,mail.minyard.net:mid]

On Sat, Apr 25, 2026 at 10:36:05AM +0100, Matt Fleming wrote:
> On Tue, Apr 21, 2026 at 07:42:44AM -0500, Corey Minyard wrote:
> > The driver would just fetch events and receive messages until the
> > BMC said it was done.  To avoid issues with BMCs that never say they are
> > done, add a limit of 10 fetches at a time.
> > 
> > This is a more general fix than the previous fix for the specific bad
> > BMC, but should fix the more general issue of a BMC that won't stop
> > saying it has data.
> > 
> > This has been there from the beginning of the driver.
> > 
> > Reported-by: Matt Fleming <mfleming@cloudflare.com>
> > Closes: https://lore.kernel.org/lkml/20260415115930.3428942-1-matt@readmodwrite.com/
> > Fixes: <1da177e4c3f4> ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Corey Minyard <corey@minyard.net>
> > ---
> >  drivers/char/ipmi/ipmi_si_intf.c | 15 +++++++++++++++
> >  drivers/char/ipmi/ipmi_ssif.c    | 15 +++++++++++++++
> >  2 files changed, 30 insertions(+)
>  
> [...]
> 
> > @@ -410,6 +413,7 @@ static void start_getting_msg_queue(struct smi_info *smi_info)
> >  
> >  	start_new_msg(smi_info, smi_info->curr_msg->data,
> >  		      smi_info->curr_msg->data_size);
> > +	smi_info->num_requests_in_a_row = 0;
> >  	smi_info->si_state = SI_GETTING_MESSAGES;
> >  }
> >  
> > @@ -421,6 +425,7 @@ static void start_getting_events(struct smi_info *smi_info)
> >  
> >  	start_new_msg(smi_info, smi_info->curr_msg->data,
> >  		      smi_info->curr_msg->data_size);
> > +	smi_info->num_requests_in_a_row = 0;
> >  	smi_info->si_state = SI_GETTING_EVENTS;
> >  }
> >  
> 
> Would it be better to move this zeroing to handle_transaction_done()?
> Otherwise we reset the counter in handle_flags() ->
> start_getting_events() and the threshold is never reached.

Oh, yeah.

Moving it to handle_transaction_done() is not ideal, though.  If
something was spewing receive messages, it would never get to events,
which is why I did it like I did.

The following should fix this.  You could also have different limits for
receive messages and events, but I think the following is more clear.

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 2a739123270c..e46f4150ceb5 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -413,8 +413,10 @@ static void start_getting_msg_queue(struct smi_info *smi_info)

 	start_new_msg(smi_info, smi_info->curr_msg->data,
 		      smi_info->curr_msg->data_size);
-	smi_info->num_requests_in_a_row = 0;
-	smi_info->si_state = SI_GETTING_MESSAGES;
+	if (smi_info->si_state != SI_GETTING_MESSAGES) {
+	    smi_info->num_requests_in_a_row = 0;
+	    smi_info->si_state = SI_GETTING_MESSAGES;
+	}
 }

 static void start_getting_events(struct smi_info *smi_info)
@@ -425,8 +427,10 @@ static void start_getting_events(struct smi_info *smi_info)

 	start_new_msg(smi_info, smi_info->curr_msg->data,
 		      smi_info->curr_msg->data_size);
-	smi_info->num_requests_in_a_row = 0;
-	smi_info->si_state = SI_GETTING_EVENTS;
+	if (smi_info->si_state != SI_GETTING_EVENTS) {
+	    smi_info->num_requests_in_a_row = 0;
+	    smi_info->si_state = SI_GETTING_EVENTS;
+	}
 }

 /*


> 
> Thanks,
> Matt

