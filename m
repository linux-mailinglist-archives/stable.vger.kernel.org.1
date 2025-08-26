Return-Path: <stable+bounces-176401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DA6B37141
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 19:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9BA681C1D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 17:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A912E3705;
	Tue, 26 Aug 2025 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="102IUmBb";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="oE9ZWqIT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59472E1EF2;
	Tue, 26 Aug 2025 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228922; cv=none; b=IuqakYU1Xh9ylxk697FO4TRgldvhE562NlyyaFM2binY4KEyk44VFHw/2SRBb1uPq8dlTFEUPMtJu7UmJ+5DrUDTs0sdqxYMySUvZjxebOgega9bB0iDDuMYVM9wTKfJzSbFzaQI6mzn5ofcY5pMKtwds+3nAv+Px3L2jqgaxfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228922; c=relaxed/simple;
	bh=SjBOXldlVtyTO1rVvTQT4inDDhNHA6OlzRlvyaHWM5w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BSgFT5GhBhXqJaUfyNMpGiBMGA1izaoCIYlAYm8bWm6TOBUyFfh3SIJe2KQGrPbUfwrwGI0hX+tPx6FyxK38mWMSXLp3dW2LOJ/rJTDu8oSFHVNvsIuAXCnV/NnQ3g4UJyHqji+NN0wLr6pp25B5tyZeqiWq3jCEPPGWQYfUHF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=102IUmBb; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=oE9ZWqIT; arc=none smtp.client-ip=160.80.4.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 57QHLUUg014664;
	Tue, 26 Aug 2025 19:21:36 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 8B3161203EC;
	Tue, 26 Aug 2025 19:21:24 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1756228886; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nRPnemMRjIqS8FLYYPeKQSBIW++wmsT0i3d527WY1QQ=;
	b=102IUmBbew/idnRZVrXRcJobmTaRbZf3e7ywGOS3DVJKsjYUXYLjlCEVVIhxGOVXWX3WB4
	aqZk76di7uZr7GBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1756228886; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nRPnemMRjIqS8FLYYPeKQSBIW++wmsT0i3d527WY1QQ=;
	b=oE9ZWqITK6kmNw6wJvBabqgVC9BdeSk27UpSMn0CUew/4dj770o89XUX3FeHN8S9CveZXb
	/gmBma5fSVGu7OtAoq3sLBxdHVIsJL9A/tQAQQGPuiG5KYzSducGmGBuzzSS3LsmUBzpeB
	I8VvfJTJfs5N59w+yViL9Rn5id2q9vF87wCSSd7HvSS/gZnP4wxlEUbBlVJc320gsuhw3c
	encQz+b5TT0JyJ+jIytiH7W8kK/m3AWwn5bcuFhuFyGM2+fWoOlHP8eixoQV0Z9qYFxH07
	AqYpiY2+V/s4CDEiwWSah8g+t3sePrIL+z4KwC6gHcpaMgGSgNXlYxQhKi647A==
Date: Tue, 26 Aug 2025 19:21:23 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>,
        Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Eric Biggers
 <ebiggers@kernel.org>,
        David Lebrun <dlebrun@google.com>,
        Stefano Salsano
 <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni
 <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>, stable@vger.kernel.org,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net] ipv6: sr: fix destroy of seg6_hmac_info to prevent
 HMAC data leak
Message-Id: <20250826192123.612cd0eabbbb57795a0bbdbc@uniroma2.it>
In-Reply-To: <CANn89i+UTv8nJ=cc67iKky=MLXOnzF5XyVRsV-TMXz7wUQ6Yvw@mail.gmail.com>
References: <20250825190715.1690-1-andrea.mayer@uniroma2.it>
	<CANn89i+UTv8nJ=cc67iKky=MLXOnzF5XyVRsV-TMXz7wUQ6Yvw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Mon, 25 Aug 2025 12:33:26 -0700
Eric Dumazet <edumazet@google.com> wrote:

> On Mon, Aug 25, 2025 at 12:08 PM Andrea Mayer <andrea.mayer@uniroma2.it> wrote:
> >
> > The seg6_hmac_info structure stores information related to SRv6 HMAC
> > configurations, including the secret key, HMAC ID, and hashing algorithm
> > used to authenticate and secure SRv6 packets.
> >
> > When a seg6_hmac_info object is no longer needed, it is destroyed via
> > seg6_hmac_info_del(), which eventually calls seg6_hinfo_release(). This
> > function uses kfree_rcu() to safely deallocate memory after an RCU grace
> > period has elapsed.
> > The kfree_rcu() releases memory without sanitization (e.g., zeroing out
> > the memory). Consequently, sensitive information such as the HMAC secret
> > and its length may remain in freed memory, potentially leading to data
> > leaks.
> >
> > To address this risk, we replaced kfree_rcu() with a custom RCU
> > callback, seg6_hinfo_free_callback_rcu(). Within this callback, we
> > explicitly sanitize the seg6_hmac_info object before deallocating it
> > safely using kfree_sensitive(). This approach ensures the memory is
> > securely freed and prevents potential HMAC info leaks.
> > Additionally, in the control path, we ensure proper cleanup of
> > seg6_hmac_info objects when seg6_hmac_info_add() fails: such objects are
> > freed using kfree_sensitive() instead of kfree().
> >
> > Fixes: 4f4853dc1c9c ("ipv6: sr: implement API to control SR HMAC structure")
> > Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
> 
> Not sure if you are fixing a bug worth backports.
> 

I believe failing to delete sensitive data, such as HMAC keys, from memory
before releasing it could pose security risks.
Therefore, I considered this a bug to be fixed in the stable versions.

> > Cc: stable@vger.kernel.org
> > Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> > ---
> >  net/ipv6/seg6.c      |  2 +-
> >  net/ipv6/seg6_hmac.c | 10 +++++++++-
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
> > index 180da19c148c..88782bdab843 100644
> > --- a/net/ipv6/seg6.c
> > +++ b/net/ipv6/seg6.c
> > @@ -215,7 +215,7 @@ static int seg6_genl_sethmac(struct sk_buff *skb, struct genl_info *info)
> >
> >         err = seg6_hmac_info_add(net, hmackeyid, hinfo);
> >         if (err)
> > -               kfree(hinfo);
> > +               kfree_sensitive(hinfo);
> >
> >  out_unlock:
> >         mutex_unlock(&sdata->lock);
> > diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
> > index fd58426f222b..19cdf3791ebf 100644
> > --- a/net/ipv6/seg6_hmac.c
> > +++ b/net/ipv6/seg6_hmac.c
> > @@ -57,9 +57,17 @@ static int seg6_hmac_cmpfn(struct rhashtable_compare_arg *arg, const void *obj)
> >         return (hinfo->hmackeyid != *(__u32 *)arg->key);
> >  }
> >
> > +static void seg6_hinfo_free_callback_rcu(struct rcu_head *head)
> > +{
> > +       struct seg6_hmac_info *hinfo;
> > +
> > +       hinfo = container_of(head, struct seg6_hmac_info, rcu);
> > +       kfree_sensitive(hinfo);
> > +}
> > +
> >  static inline void seg6_hinfo_release(struct seg6_hmac_info *hinfo)
> >  {
> > -       kfree_rcu(hinfo, rcu);
> > +       call_rcu(&hinfo->rcu, seg6_hinfo_free_callback_rcu);
> >  }
> 
> If we worry a lot about sensitive data waiting too much in RCU land,
> perhaps use call_rcu_hurry() here ?

My concern is not so much about how long the sensitive data remains in RCU
land. Instead, I would like to ensure that the memory associated with the
seg6_hmac_info object is properly zeroed out before it is freed. I believe that
using call_rcu() (with seg6_hinfo_free_callback_rcu()) would be sufficient to
achieve this goal.

---

Aside from improving the commit message (thanks to Eric Bigger), what other
changes should we consider implementing for version 2?
Should we classify this patch as an enhancement rather than a bug fix?

Thank you all for your time,
Andrea

