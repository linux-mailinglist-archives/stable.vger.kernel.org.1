Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8231E79F5CB
	for <lists+stable@lfdr.de>; Thu, 14 Sep 2023 02:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjINAEY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 20:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjINAEX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 20:04:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B94FE6A
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 17:04:19 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c3887039d4so3032525ad.1
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 17:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694649859; x=1695254659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m6l7G+lF7HB2RVIW0ImjgW/SITxGPWQ/tkWPGE2PniM=;
        b=KFYJRoDMKshuosIMA9LZkHBeCPAg2MnVYYZ3wLVi5hm6SzZktOIeLB1lv+bkoOLcR3
         4jDLbgdDWqqPXf1wGnDFVLEeGwJ5/I64VP9YBKUuQQ+p7Dup6UFwQeMyrtxJtIiA6BCy
         O+yjy1AX94gqaNfTDTFl1qEpgsCSyl5miZcl0esCnCTTAJqSvC+oMnzUku1oeJ03fDoQ
         WCgnsSOh8amlMfLKD80DWHIJGs/Wtuk3T0owg6QuTmgNr5hSM2BDKAnGwsZBJ0lBtjZH
         gohg3R+BL1XSHe0YxPPPJ8nGaEZ2+/YAzqBLigBobKklm8HVv0frSNAD+BwYkGsuFczt
         2kyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694649859; x=1695254659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6l7G+lF7HB2RVIW0ImjgW/SITxGPWQ/tkWPGE2PniM=;
        b=M/7rRxMcGfmc+TwJPHkMf1DlBNGQic+ysjY1tQrnK8a/NlZ0NO6igWHz2mugVCQadu
         8lDCTqDHU7jQkS7gA76ugwzHvSjounCeywyfT5K8MBb77cNy+1sYeoG+39nQldho3sFC
         C3Pw18p+iWYuQoZkcB5lmzoUmQ6jKqxRDX5FATllxt5Zyqq3jUl776zf+vSVXQR94BH6
         Q6PmuLJnl9iQNb9o8ST5G2C6McfvgpU0W5mRFzE+oFnx29tLPTICF3VGjU9d8jlvxwkX
         e68YlQWcv6Zf4SmkhYWhsZe3VDMrOq+UYX9P21n+40mi+tJmPG0biV7cZmRPpnfSLyjl
         hDoQ==
X-Gm-Message-State: AOJu0YyU+ols1w8KDDn0ewmFNmJJzTWqRpJveLF0UjsrMv+8LumCLS5t
        9EAGaOSTlPqsDgGHw9jmiPlMrhxhq77wrhTg
X-Google-Smtp-Source: AGHT+IFNqWFceLmoyK2DlaeIiLmDF9uYSyVb++1i/Bnzm4N2ftmF0fY3G/YWQhNx96ojll/J6WRIGg==
X-Received: by 2002:a17:903:110d:b0:1bb:25bd:d091 with SMTP id n13-20020a170903110d00b001bb25bdd091mr4790059plh.30.1694649859000;
        Wed, 13 Sep 2023 17:04:19 -0700 (PDT)
Received: from westworld (209-147-138-147.nat.asu.edu. [209.147.138.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001b8062c1db3sm193599pld.82.2023.09.13.17.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 17:04:18 -0700 (PDT)
Date:   Wed, 13 Sep 2023 17:04:16 -0700
From:   Kyle Zeng <zengyhkyle@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org
Subject: Re: wild pointer access in rsvp classifer in the Linux kernel <= v6.2
Message-ID: <ZQJOAAu0QvKGjDXC@westworld>
References: <CADW8OBtkAf+nGokhD9zCFcmiebL1SM8bJp_oo=pE02BknG9qnQ@mail.gmail.com>
 <2023090826-rabid-cabdriver-37d8@gregkh>
 <ZP/SOqa0M3RvrVEF@westworld>
 <2023091320-chemist-dragonish-6874@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023091320-chemist-dragonish-6874@gregkh>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 13, 2023 at 10:12:55AM +0200, Greg KH wrote:
> On Mon, Sep 11, 2023 at 07:51:38PM -0700, Kyle Zeng wrote:
> > On Fri, Sep 08, 2023 at 07:17:12AM +0100, Greg KH wrote:
> > > Great, can you use 'git bisect' to track down the commit that fiexes
> > > this so we can add it to the stable trees?
> > Sorry for the late reply. I think the fix was to completely retire the
> > rsvp classifier and the commit is:
> > 
> > 265b4da82dbf5df04bee5a5d46b7474b1aaf326a (net/sched: Retire rsvp classifier)
> 
> Great, so if we apply this change, all will work properly again?  How
> far back should this be backported to?
> 
> thanks,
> 
> greg k-h

> Great, so if we apply this change, all will work properly again?
Yes, after applying the patch (which is to retire the rsvp classifier),
it is no longer possible to trigger the crash.
However, you might want to decide whether it is OK to retire the
classifier in stable releases.

> How far back should this be backported to?
I tested all the stable releases today, namely, v6.1.y, v5.15.y,
v5.10.y, v5.4.y, v4.19.y, and v4.14.y. They are all affected by this
bug. I think the best approach is to apply the patch to all the stable
trees.

Thanks,
Kyle Zeng
