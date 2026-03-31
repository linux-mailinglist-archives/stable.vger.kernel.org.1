Return-Path: <stable+bounces-231396-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II+MFDiqy2kpKAYAu9opvQ
	(envelope-from <stable+bounces-231396-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:04:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1033687B0
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42D7C300CA0E
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5BD3B19AE;
	Tue, 31 Mar 2026 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VyGtxGJE"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1D73AA4E8
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774955059; cv=pass; b=aM8RqHyTdrlsHgc3oB46pwJ2RGJGUUp2b4VqpkeIGDrLV5sOOjmqXsjS8qqaQU5rip0vfoe1jE6jS17CYa88gJqH4eS7s0ILKP0RWWQZcrRgnKd/LEZRaK/n1HeNH0kP0Q5GtbFohXi6wvdppwEURovMZlvkEIVWbexuc6ckUQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774955059; c=relaxed/simple;
	bh=+q0hBdBFS9L+ZjH5fY/IXXzHbz9h9o01OcmnbZ0EUCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENpSDN+VfgdcNQLXfCbLoDl1tX9ZyZwO4+yGA5Utn7o1dYYgD3Iz/Ui22O12UQtNfa7VyyYRzU3lKAvMCC92ukboZipTsBnYiwEaX5dJvj55AcjcUIfeuLvonUqGCxzAYh/H4ZYQJRteYL1Mpjns6s5nr0kxem9RACZyBZzLU5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VyGtxGJE; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a2967e5de4so7485086e87.3
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 04:04:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774955055; cv=none;
        d=google.com; s=arc-20240605;
        b=CaLUZ7n3ae1mkTI3xC8MuAPN4LVpBdGrCKLorX6/65+d0pnevxRpU7pXrCcflOxNb6
         ndXgw6xwWUqFWVHgyj/Fv3XeII6UF2PpXU96d89a5UeeGvd1dPdKP1i+nl+r5cB0aaC5
         9HfbYt8lLEq03ERNaOxZ7Iycc3wgaV38WHqhfrJvt2SqBBK9zY/cbvEYern5xH7ZGIXP
         yuAngfMjPtkSBlQg3Sa2yGq5O4KXXw+Bas/yi9fw+vyY2xASkJE0i3A2yKibckAv70ba
         sDuYIQ7o/PoiHPHQo9+pyvtuKmIYtdNwix5lXKKkLdoDkzXlESw++21+qB+TXjK8AMeS
         gHtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vYyC5Bmz8Oh01Vq9Hljyc6MoUHIUJ6A6aUIDWO1eZxI=;
        fh=UAxHKwerkAWW8fFff9p5j7oxQyJVyoB2BamASEbfnUY=;
        b=YHVzvQR29Vir6gW/jqQaY4o9HxkC+GIIP4MXMPkhsCsGR+Oq3Mwd74Va1aiDVk6n8q
         QPWpizTOjUGXXoGmz2TGP3MQc7bYstZ7u1Go2I33LKPNzFbxk8xCq2asHGklDyxDsHHP
         9WLxMrImmU4aA0DcH37FXSP2cNtDlHnyd1v3H6z/iFiknBY8hDYy4Tx363pb4Jixog3D
         m1YU3DnmnXxb/s2zHDZ0wWU9HvmFvOOZXdtz+NcpjaA2A7TZIUYbUTwaqFBNGvrLNbN8
         J08eGZT1ySy3RdjuP8oYX+wuKD8eAi8K20vhOG44NH/A1g6GvFW9y6/gUwJ/Snox5SOy
         T4vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774955055; x=1775559855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vYyC5Bmz8Oh01Vq9Hljyc6MoUHIUJ6A6aUIDWO1eZxI=;
        b=VyGtxGJE62HiYHuY7u5eNhF/MSGRhy2cuMIpz+sSVNMhgf+4W0XIDAIqOxwMLV5jl9
         ZxKEC9yq6bVp9mBtsvZ1CMbkfFLbuPSU9CwEtitZuAl2dS0E5mdlXmdWH74pX7PGKxEa
         IFBvith4UoEHepcHbJlja7jkJbnemI/umoWeQnlb7+ma6OaZW65JyPa3uVYX8LGSrG77
         200rNJvn0hp6KufARQw9XBeKFxGzSI3GqYZ7NNB8OM28Jt1iENge6qG/dRncIE5wgWxt
         zqOKXzFhclbYZPM0/LMEOdEmx+rObGq6KBSmr30fzOQvTxxVa2H2GRM7/quwVVzp41fX
         ZJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774955055; x=1775559855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYyC5Bmz8Oh01Vq9Hljyc6MoUHIUJ6A6aUIDWO1eZxI=;
        b=W+JXpBq2AwW5iOxIeDcEnj+/Qx7wJuiAQ3ZWzBpqmaW6I6261lRTfG/i51pk3B9NTs
         iUlwDfQoc3S96qwLYA7/BDoXZzqEIHscczqFFY0KqjWp/CJn2Yx39Gyf85mOFviUGOJH
         7pBRyJFdTZLEEI0jH6MjTqp7PZCwN2mMA4kisjnTNSQYAue2dSuvLWRUjaiq7aU/6HfH
         v+mK3v5gZNwd5q8dLaSTSsyWgOcUSjQoB9mcdRjWmG1R62Kr+1KEgLfgHE2bvIl7X8X3
         oVCNu+hvFmRH+H0tJzL8COeFUdYdUW1cpPUVDB29xxYSRHn5HQx8T4l1SVA9Rw8Pbo9G
         4t8A==
X-Forwarded-Encrypted: i=1; AJvYcCVLMu0Pd/+uU1VBcV2xZtV6Wtd8Qan4A5Ej9a0hre0DtSfSjtUUPpZzkFp/kIW3nMo7k2kLPXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzepjkL4NGmO4tOHSJHna65pCIjSp9qD/BS9/ZWa809c/ZDGndM
	bwQe/TT9y6NnAcSuTceR2rz4VDUaNnxfpwHLdWOI642hiW/Mweu2ZnH3yeBfmf0HjnoJOvJo10X
	96ktQIDILZ+uussdm6OKvPxWbRUS9ih3+EvW8TT3kCw==
X-Gm-Gg: ATEYQzxeZi6RJK9fca+ZkPef+R8qX/aVUlmXh8oLzjhOVNfiXV6sm6lfhkvfmV0fx9H
	dEvbS/0m9G53cyV8nB6sC5taVLYOfS1+u+/ob2YjW1/yCm6BqMUYtk+EPmu1116wvfndaBNMIZ/
	NMaQEmSAPU6ClVSpjk+CdtF185JLyhYHBt8Wdh6157RYitLQQPoIP3x7emCfAhvI5/ohwlNCvuU
	HCQ7aP0amqzuIOEgKK5KNR7eTBpFvqqKcIynmSoDHciVvEMkx9z4K/DZgtcoCaTM8gfoG+d1+X5
	6bnuzq83sDDAvKSSSZ8=
X-Received: by 2002:a05:6512:3d9f:b0:5a1:1d29:e749 with SMTP id
 2adb3069b0e04-5a2ab7eba2bmr7270864e87.12.1774955054900; Tue, 31 Mar 2026
 04:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327105208.1310739-1-johan@kernel.org> <20260327105208.1310739-2-johan@kernel.org>
 <CAPDyKFp1DbRufpro86fXi9xXnJGbWW=NrD3Q0NFQ+aHxhxogLg@mail.gmail.com> <acuiz2y0pIdEwlB4@hovoldconsulting.com>
In-Reply-To: <acuiz2y0pIdEwlB4@hovoldconsulting.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 31 Mar 2026 13:03:39 +0200
X-Gm-Features: AQROBzDA3rOKmAK4zrEQAayE6915y47sO72Sc-zBqp7MVFgwop6L7ntgv2j6BvY
Message-ID: <CAPDyKFpbcn3SJrZP1SE5VPw4nxk7ct=B80=nD9k2gBdEo6EBCw@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: vub300: fix NULL-deref on disconnect
To: Johan Hovold <johan@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Tony Olech <tony.olech@elandigitalsystems.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231396-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,linaro.org:dkim,elandigitalsystems.com:email]
X-Rspamd-Queue-Id: DE1033687B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 at 12:32, Johan Hovold <johan@kernel.org> wrote:
>
> On Tue, Mar 31, 2026 at 12:13:41PM +0200, Ulf Hansson wrote:
> > On Fri, 27 Mar 2026 at 11:52, Johan Hovold <johan@kernel.org> wrote:
> > >
> > > Make sure to deregister the controller before dropping the reference to
> > > the driver data on disconnect to avoid NULL-pointer dereferences or
> > > use-after-free.
> > >
> > > Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
> > > Cc: stable@vger.kernel.org      # 3.0
> > > Cc: Tony Olech <tony.olech@elandigitalsystems.com>
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > ---
> > >  drivers/mmc/host/vub300.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> > > index ff49d0770506..f173c7cf4e1a 100644
> > > --- a/drivers/mmc/host/vub300.c
> > > +++ b/drivers/mmc/host/vub300.c
> > > @@ -2365,8 +2365,8 @@ static void vub300_disconnect(struct usb_interface *interface)
> > >                         usb_set_intfdata(interface, NULL);
> > >                         /* prevent more I/O from starting */
> > >                         vub300->interface = NULL;
> > > -                       kref_put(&vub300->kref, vub300_delete);
> > >                         mmc_remove_host(mmc);
> > > +                       kref_put(&vub300->kref, vub300_delete);
> >
> > While this seems like a step in the right direction, I don't see why
> > calling usb_set_intfdata(interface, NULL)
>
> The interface data is only used in the USB bus callbacks and is not
> needed after disconnect().
>
> > and assigning
> > vub300->interface = NULL is safe.
> >
> > For example, some of the workqueues might be running a work that uses
> > the vub300->interface, isn't that a problem too?
>
> The driver uses this pointer to indicate that the device has been
> disconnected. That doesn't mean that the implementation is correct (e.g.
> the check in vub300_pollwork_thread() should use some locking) but that
> would be pre-existing issues.

Right, that was my thinking as well.

Out of curiosity, are you planning on fixing these issues too or is
that left for later?

Kind regards
Uffe

