Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE50E7A7062
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 04:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjITC2I (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 22:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjITC17 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 22:27:59 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D80E67
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 19:27:37 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690d2441b95so313142b3a.1
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 19:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695176857; x=1695781657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HT804eSL06/A7KQwEEa2UXskPZ9lMoS9i1A0V3pQd3w=;
        b=GP1OamegrzovHqgkQkjrli3plbB0r2cF5VmY6Jy6wXEY6eelC43MtIChaRyapUm/BC
         CxIK3bJuYVpQI401L/+K9f2LQIITTyh3tCCs8/cAuawBzXwnseHqve5WdPF/UEjQ2oQT
         +HNCmQVC3092RtXrU/wASlrcrv662ThQr/vh9OQfwzgmj42G1/DgTUgorLvRB5duyUfo
         phboH1tbUP+hsyUD4NRXdW92O+fzlZM8vHLFVda/Mrj2fUutrpdwX712rzS20XNYa8OP
         qE6RP3cjO2Mgq6Kut//ypoItIP2/mYtSZGpn9ZltfDGFhvn4XZ+X0WVtiAQEozgnLyHB
         wiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695176857; x=1695781657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HT804eSL06/A7KQwEEa2UXskPZ9lMoS9i1A0V3pQd3w=;
        b=lvmVJDl9TUXwrqL9THlrpDgujkE+wVdmB3A+rHEzT8tXjX4/ivEw2VWIvNY15mTXMn
         +fo/KNPFpDhe2OSMeYPDtwAAyBcLstdEn565NZKvMyUIQmHkgjIK7yv9fVajCzPtsUQR
         YFONEwkQwk3BOUjfymMPfXDISPfGCGz8NeJt2jw6iuqqvCvbr3A1ss00J/URNIBqS7dL
         bDDxuYkF1wrXvlGdCO+chqEOO+YvvYvgpfrWmNxArzqqasmx+dDI5Hjtzhf9AZZx9Za3
         W7VnTlHz7m18T/+nDdBck7mVeHkEmtflx+qSyIqLndQ/i5rXaG92hKlyPgNxPupqOi+o
         HM0Q==
X-Gm-Message-State: AOJu0Yz5p9QsUD1F2kB2PYdgYshiVOsJFIbmpG0VXhYFhpdba3CdfNKH
        FiK8XseOPivunkSxmtl7wTqCPlLd1JM4khEM
X-Google-Smtp-Source: AGHT+IH8qcIYi+gYiJOAPbQMYcSNga/ZNwqsl8EdhahJspXA7ZiahL5QIsS/wKpSRA8JQNa/UuB+/Q==
X-Received: by 2002:a05:6a21:6da0:b0:159:d4f5:d59 with SMTP id wl32-20020a056a216da000b00159d4f50d59mr1739513pzb.12.1695176856804;
        Tue, 19 Sep 2023 19:27:36 -0700 (PDT)
Received: from westworld (209-147-138-147.nat.asu.edu. [209.147.138.147])
        by smtp.gmail.com with ESMTPSA id v17-20020aa78091000000b00687fcb1e609sm9153279pff.116.2023.09.19.19.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 19:27:36 -0700 (PDT)
Date:   Tue, 19 Sep 2023 19:27:34 -0700
From:   Kyle Zeng <zengyhkyle@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org
Subject: Re: wild pointer access in rsvp classifer in the Linux kernel <= v6.2
Message-ID: <ZQpYloCDyc8+4Iwp@westworld>
References: <CADW8OBtkAf+nGokhD9zCFcmiebL1SM8bJp_oo=pE02BknG9qnQ@mail.gmail.com>
 <2023090826-rabid-cabdriver-37d8@gregkh>
 <ZP/SOqa0M3RvrVEF@westworld>
 <2023091320-chemist-dragonish-6874@gregkh>
 <ZQJOAAu0QvKGjDXC@westworld>
 <2023091612-fretful-premium-b38d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023091612-fretful-premium-b38d@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Sep 16, 2023 at 01:41:33PM +0200, Greg KH wrote:
> On Wed, Sep 13, 2023 at 05:04:16PM -0700, Kyle Zeng wrote:
> > On Wed, Sep 13, 2023 at 10:12:55AM +0200, Greg KH wrote:
> > > On Mon, Sep 11, 2023 at 07:51:38PM -0700, Kyle Zeng wrote:
> > > > On Fri, Sep 08, 2023 at 07:17:12AM +0100, Greg KH wrote:
> > > > > Great, can you use 'git bisect' to track down the commit that fiexes
> > > > > this so we can add it to the stable trees?
> > > > Sorry for the late reply. I think the fix was to completely retire the
> > > > rsvp classifier and the commit is:
> > > > 
> > > > 265b4da82dbf5df04bee5a5d46b7474b1aaf326a (net/sched: Retire rsvp classifier)
> > > 
> > > Great, so if we apply this change, all will work properly again?  How
> > > far back should this be backported to?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > > Great, so if we apply this change, all will work properly again?
> > Yes, after applying the patch (which is to retire the rsvp classifier),
> > it is no longer possible to trigger the crash.
> > However, you might want to decide whether it is OK to retire the
> > classifier in stable releases.
> > 
> > > How far back should this be backported to?
> > I tested all the stable releases today, namely, v6.1.y, v5.15.y,
> > v5.10.y, v5.4.y, v4.19.y, and v4.14.y. They are all affected by this
> > bug. I think the best approach is to apply the patch to all the stable
> > trees.
> 
> Great, can you provide backported patches to those trees so that we can
> queue this up for them?
> 
> thanks,
> 
> greg k-h

I backported the patch to all the mentioned affected versions and I used
my poc code to make sure that the crash is no longer triggerable after
applying the patch.

The patches are sent separately with [PATCH <version>] tags.

Thanks,
Kyle Zeng
