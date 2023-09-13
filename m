Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BE479E107
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 09:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238608AbjIMHmf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 03:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238611AbjIMHme (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 03:42:34 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C17198B
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 00:42:30 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bf78950354so66384101fa.1
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 00:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1694590949; x=1695195749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uDUXH0O3AIb1OxTjDi5wo6mK5XhaEZuHf0OE3SoZAc=;
        b=nOEL591VVboWJwP/lyqXlamL88IxBLgQP+YIcSRgWYK1+XzZz8g/ztYPfMgoIRYeZZ
         byHCpXMtSokHPNkC6lcD1frXoGZyJfHRoL5mrAijuB3YGEPmdbCQpqW+7YhektXHk2E5
         aFwhrauQi3ipe2iliol+F7yO28rTVxXgT217knr542pBOX9at2H8ReVZIVIO5QVU3ex/
         IOLg4lkcopEKp7ECToh5ImjgvYUp+Ue+5KvB8FGjVd0yq3E/juKSCbRwHU4zZDRjca4H
         8pajuZyCNpqDx4h/0Jpf/sBlvZY34KAPrP4rbFfwUeFOo4/kAiJi3/ATZ7o1OJitKf51
         WovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694590949; x=1695195749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uDUXH0O3AIb1OxTjDi5wo6mK5XhaEZuHf0OE3SoZAc=;
        b=KemRnZOyEYE+lV1S1sEcrNZYQd8tSK5a9qmhb4aKqjJl7YL/z9yTKSPLuoVdYUVygl
         Et5eCqDAGqH+fCPpwIz91h/rQguEHqKm464WXeGyrm3DTewBSXD+2Z8C8tLwtnbMHHw4
         gVgayp0tfDh8Q4sTodjxJkHkNvrQ76s4pn6r5wp4fI50JzQdjJx7woOSa94TumMGT8Yi
         qFzb6j42Ox/jyn5yNjh8vfKMILzXOeQ68QRmdV2nFLnf01rtON6ZcookrOztXRB+dJmc
         Hfg8ACoruGRzXY9LT2W/jOGl7RmxtQkiGsgNlGEZPtT7MbXaqyIEySE1yDlRu7RMe9S4
         szXg==
X-Gm-Message-State: AOJu0YwpOrn8zksXhZudIYHpxK0Jie1UqCcEOTV1M3+IRRYup1KZiWpA
        3jv/BzFy6XafKzT7yHeTcUONClYg+jsP6IBp69PYTQ==
X-Google-Smtp-Source: AGHT+IHnvQh3XH7L3vRxz8HVVFiulQUlE/W22VDzAZxb3JEsdX8CqhZWOXHsgD57t2LXzIWJIj86pw==
X-Received: by 2002:a2e:9e14:0:b0:2bd:16e6:e34a with SMTP id e20-20020a2e9e14000000b002bd16e6e34amr1511093ljk.19.1694590948655;
        Wed, 13 Sep 2023 00:42:28 -0700 (PDT)
Received: from fedora ([79.140.208.123])
        by smtp.gmail.com with ESMTPSA id mq22-20020a170907831600b009ad778a68c5sm2573755ejc.60.2023.09.13.00.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:42:28 -0700 (PDT)
Date:   Wed, 13 Sep 2023 00:42:25 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Donald Buczek <buczek@molgen.mpg.de>, stable@vger.kernel.org,
        David Ahern <dsahern@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH 5.15 052/107] Remove DECnet support from kernelail
Message-ID: <20230913004225.23ff874a@fedora>
In-Reply-To: <2023091210-irritably-bottle-84cd@gregkh>
References: <20230619102141.541044823@linuxfoundation.org>
        <20230619102143.987013167@linuxfoundation.org>
        <6084b5fc-577c-468a-a28e-e0ccc530ed9e@molgen.mpg.de>
        <2023091117-unripe-ceremony-c29a@gregkh>
        <1be4b005-edfe-5faa-4907-f1e9738cc43a@molgen.mpg.de>
        <2023091210-irritably-bottle-84cd@gregkh>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 12 Sep 2023 10:15:18 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> > 
> > It's just _if_ stable really gradually opens up to anything (like
> > code removals, backports of new features, heuristically or AI
> > selected patches, performance patches) it IMO loses its function
> > and we could as well follow mainline, which, I think, is what you
> > are recommending anyway.  
> 
> When code is removed from stable kernel versions, it is usually for
> very good reasons, like what happened here.  Sorry I can't go into
> details, but you really wanted this out of your kernel, this was a
> bugfix :)

I don't remember the details, but look at netdev mailing archives for
the discussion. It was something along the lines of the zero day
bot found some pre-existing old bug in DECnet, and the consensus
was the fixing a corpse was not worth doing.
