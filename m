Return-Path: <stable+bounces-58738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B625492B8FD
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 14:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3610EB243BA
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 12:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310811586C6;
	Tue,  9 Jul 2024 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dx2Sttrk"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5159312DDAE
	for <stable@vger.kernel.org>; Tue,  9 Jul 2024 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720526684; cv=none; b=IGG99Ba4XhKo8mkYvmue/5o5k27vR0hDH11qjtu0TV3WonwAoZq7504WecQ80xWcFFc/T75OL1I38O3hsLHayiTy1BymvEor9OBGAw9Kx48S+3VTk5dBXdfVU+jO0YKcRHfMUERcCqxIdd5MRr9wbCizJPDeDvUMk8Sg0jj7G7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720526684; c=relaxed/simple;
	bh=F4b/xXoVHmS9zHI00DVj29hueHrWrCB++xVJJiexFro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5PyTEkOcMK7XotGK5G2G3PaYq6ljefcjLCEnSLFhk8T6ABX1ecygHK0hOKRNvwi62zI6ROItTQ+G7tp+WR2T61/KibpYYAmL9xzg5O6Ffn+szx0U0a6Fr9YbpfTHRBz8ZO+iKPjBvUbSZtIOoCGCxvvOBkJlaNTIIIqg9AfK6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dx2Sttrk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720526681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NOxbh2TI9zDvIROekQ++sRRqY9mHp5Z2TlmWTZOvmsY=;
	b=Dx2SttrkDrmaUn81KIM5F4sQVoEzOK3WTNhP+0C6z5tTq+LNQ+cQGPpNCaiVoCambZHwyu
	ft8ydO8zVlCM6e4xz0o5/OYwn6lPTtddpBiMGjrAZTG7wi4P0DBO98ghxqUrpcwPyzY4k7
	z+Erc1CCRUnyAfBgkNIvqhHpBf8bUO0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-U1u2o2TROMuuVJIECQiE9g-1; Tue,
 09 Jul 2024 08:04:38 -0400
X-MC-Unique: U1u2o2TROMuuVJIECQiE9g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6E641944D08;
	Tue,  9 Jul 2024 12:04:36 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.192.86])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFF6F3000181;
	Tue,  9 Jul 2024 12:04:35 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D95B7A807CC; Tue,  9 Jul 2024 14:04:33 +0200 (CEST)
Date: Tue, 9 Jul 2024 14:04:33 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: Patch "igc: fix a log entry using uninitialized netdev" has been
 added to the 6.9-stable tree
Message-ID: <Zo0nUY96HPBgkuOC@calimero.vinschen.de>
References: <20240705192937.3519731-1-sashal@kernel.org>
 <ZouY6i1Oz77wGC77@calimero.vinschen.de>
 <2024070852-spoils-detached-2c2b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024070852-spoils-detached-2c2b@gregkh>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Jul  8 13:50, Greg KH wrote:
> On Mon, Jul 08, 2024 at 09:44:42AM +0200, Corinna Vinschen wrote:
> > Hi Sasha,
> > 
> > my patch should not go into the stable branches.  Under certain
> > circumstances it triggered kernel crashes.
> > 
> > Consequentially this patch has been reverted in the main
> > development branch:
> > 
> >   8eef5c3cea65 Revert "igc: fix a log entry using uninitialized netdev"
> > 
> > So I suggest to remove my patch 86167183a17e from the stable branches or
> > apply 8eef5c3cea65 as well.
> 
> I've queued that up as well now.

:+1:

Thanks,
Corinna


> 
> thanks,
> 
> greg k-h



