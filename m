Return-Path: <stable+bounces-183442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC74BBE6A0
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 16:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48EFF4EEE31
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6835F2D641F;
	Mon,  6 Oct 2025 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMz6WpbJ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE5B2874FC
	for <stable@vger.kernel.org>; Mon,  6 Oct 2025 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759762638; cv=none; b=Og4RIthcvjGvN0HEj01DQaIC9v1L8C5qHeT1XexxZfWq3I5efFTC3pPfOTqU8wIm6jSUc9+bi1e4bQmVVbbt1RD/qp8sqkExIjTLou01TJGmlhRyY/f34GZlmDtm2BiTh5wRGDOxDXBMSIHnWXV+kESSLSOQDdMh7G26nFw2gtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759762638; c=relaxed/simple;
	bh=jhanX6T0C/CgFwpJufY1Z11zs77Vwb4iEfdm4wPkXWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f60VZXZBkswMDd1fc2yOutH0usjY9xK9j3ZNNsVtVOwZD1d1SXhXnnPRWBidNX7HAAUa0IM6JJq5AIfi39vnSoLna+tpj3/vVPna1i1nfutsYRqDD2GHP5yFo7h5C9z34Z3xPJ+fyw9KE9nIy8R4fMbueKpV0jC67xde0p3pB0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMz6WpbJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759762635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sp5ApOjH4RCi6YxBNf6Q9TZoHxlt3LqlFYkBMPytEDg=;
	b=DMz6WpbJf4MNkqU4FJ1POT8iYq8mDjNxH/ZRaJC+gmCxsAWXd6KstxJVtVk/REiceSp1Jf
	pCbgfesgtgJcusksk/8vmKSsoGpp7ldFmeAcK5/P2irBMyzJ51lzzxUar+iQ9weYnpgv28
	up3rjQ56fLb+OD0L85cL/jWD1SVBmdA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-ZpMYa0W0NmOtD8dGB5bTqQ-1; Mon, 06 Oct 2025 10:57:14 -0400
X-MC-Unique: ZpMYa0W0NmOtD8dGB5bTqQ-1
X-Mimecast-MFC-AGG-ID: ZpMYa0W0NmOtD8dGB5bTqQ_1759762633
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4256fae4b46so1375897f8f.0
        for <stable@vger.kernel.org>; Mon, 06 Oct 2025 07:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759762633; x=1760367433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sp5ApOjH4RCi6YxBNf6Q9TZoHxlt3LqlFYkBMPytEDg=;
        b=WyF0AxAy8PyiMAcXp51aSQkVp3RNyZ4Lx53SIbv2ErgNgWA0OLNg6w7qt8IWC+DGbB
         o/xpDuvb2Kwr2g5je1Ioq5fAd4J1pqH1qYKNy9z0pKObZg0RSPPjbsGYiTZZvcaQrcui
         9ZASWfG9Foa0faes4lNIDHR0QZ9YT+qXgDyx5l8AmhqTLko0ObNiV3N3Z+KGEgxwxUOF
         FnJQBlMn/vqAolNJ7MxTFJvEMQanlHvWny8laFHSUguyPQ6UyIB/X6TvLH7RtiuJhgvR
         fe0g9wsPvi6ugseb4WNOChlYlQShJpJtnmJNasFu40bh/rSwUU9EB2KJ+UWK6sY1Cpe9
         us5w==
X-Gm-Message-State: AOJu0YxDARmuhHrvGFZ/WIHZkMU9YQTSmJxS86m5f8RkNnFA7h3HcRS9
	YM5DUsoHqYpD4i1sIkW7sxkO9q7jB342cod/7g9S+gtuUY3FcNIJc6gQxveS4dCvzsoHQxO+1ip
	KlyPvDjkuS9b5OEVl81jOOXmm+iGRFG2PQhf2V38YVyOCNZW8ETL0aryRUg==
X-Gm-Gg: ASbGncuYbGw/9TIIr+rZWusvLe/vxrmIlp7Sbl7TLbvMLUSzejAyovpLuc2VAMS+TLw
	6KpTasT+1RycP1O6n9by0JSR2/bljnjdMmGSws3PyjnfQ6R/7SpYoiOO3/UhJgbsMCFjP9zsW8x
	PK+Q1ClLMMy89ly3fvuaWGyW1n5sPdKI9VfRP8xxA7mSYTXftHoKu5nnGCC4pFiaBV5KBavlA5D
	1t+1z8z2MucwhntRQ0rK2r9GHIt2vB9J43glf4SWHno13NFByEL5XG0QEQ02mOBuCmwgqssbC+j
	Xa9sRjUeUfKwRj4rcDyG2oZMzTdEgWk+aqCZxk0=
X-Received: by 2002:a05:6000:2c0b:b0:3ea:c893:95c6 with SMTP id ffacd0b85a97d-4256714d54cmr7467169f8f.18.1759762632887;
        Mon, 06 Oct 2025 07:57:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhCh+WQlE03GS/5i0teFXU29iwxX265IzFV+HGIBnzz3VE2lFdRIe6xVdZDphPiu/L9OdYuA==
X-Received: by 2002:a05:6000:2c0b:b0:3ea:c893:95c6 with SMTP id ffacd0b85a97d-4256714d54cmr7467149f8f.18.1759762632376;
        Mon, 06 Oct 2025 07:57:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f02a8sm21594716f8f.39.2025.10.06.07.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 07:57:11 -0700 (PDT)
Date: Mon, 6 Oct 2025 10:57:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: stable@vger.kernel.org,
	Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
	Daniel Verkamp <dverkamp@chromium.org>, Amit Shah <amit@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev
Subject: Re: Backport request for commit 5326ab737a47 ("virtio_console: fix
 order of fields cols and rows")
Message-ID: <20251006105608-mutt-send-email-mst@kernel.org>
References: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
 <20251006062851-mutt-send-email-mst@kernel.org>
 <a4e912547211eed865bdf769647936c1e3034e4e.camel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e912547211eed865bdf769647936c1e3034e4e.camel@gmail.com>

On Mon, Oct 06, 2025 at 04:15:10PM +0200, Filip Hejsek wrote:
> On Mon, 2025-10-06 at 06:29 -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 18, 2025 at 01:13:24AM +0200, Filip Hejsek wrote:
> > > Hi,
> > > 
> > > I would like to request backporting 5326ab737a47 ("virtio_console: fix
> > > order of fields cols and rows") to all LTS kernels.
> > > 
> > > I'm working on QEMU patches that add virtio console size support.
> > > Without the fix, rows and columns will be swapped.
> > > 
> > > As far as I know, there are no device implementations that use the
> > > wrong order and would by broken by the fix.
> > > 
> > > Note: A previous version [1] of the patch contained "Cc: stable" and
> > > "Fixes:" tags, but they seem to have been accidentally left out from
> > > the final version.
> > > 
> > > [1]: https://lore.kernel.org/all/20250320172654.624657-1-maxbr@linux.ibm.com/
> > > 
> > > Thanks,
> > > Filip Hejsek
> > 
> > But I thought we are reverting it?
> 
> I'm kinda confused by this question, because I thought you already
> understood the situation.

Yes - I just noticed this backport request stood unanswered and
I thought it's a good idea to make stable maintainers know it's
not yet the time to do the backport.

Sorry if I did it in a confusing way.


> I sent this backport request after a discussion with Max in the revert
> thread, from which I got the impression that the virtio spec
> maintainers were unwilling to change the spec to match the Linux
> implementation. That impression might have been wrong though.
> 
> When you sent Linus a pull request containing the revert, I realized
> that there was no consensus about which side should be fixed (spec or
> Linux) and told you that I think it should be reverted only if the spec
> is also changed. You then sent a spec change patch [1] to the virtio
> mailing list.
> 
> I'm not familiar with how decisions about the virtio spec are made, so
> I don't know if that change is going to be accepted or not.
> 
> [1]: https://lore.kernel.org/virtio-comment/7b939d85ec0b532bae4c16bb927edddcf663bb48.1758212319.git.mst@redhat.com/t/
> 
> Best regards,
> Filip Hejsek


