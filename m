Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD96A6F5B64
	for <lists+stable@lfdr.de>; Wed,  3 May 2023 17:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjECPjw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 3 May 2023 11:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjECPjv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 3 May 2023 11:39:51 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767766EB7
        for <stable@vger.kernel.org>; Wed,  3 May 2023 08:39:50 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-33110a36153so693545ab.0
        for <stable@vger.kernel.org>; Wed, 03 May 2023 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683128390; x=1685720390;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVVLdXvIfrw5/3NYijIBIn8HUk/59pymTlkCnyX4gZk=;
        b=hhwOQ1IRNoMXnJdreafhurd7FFlfWlG7ggNpHvGfTwl86HQaxurUdjbTsPCn5g21J1
         WZJUWtptO9CY6OjNiJxnwf2pAtUpeg45ezOSpKhFaDLQj/DAo03745KRyQ2F+QyJoIC9
         4naFiUVk5u0JT3Ssp6HMtEKLywdZYoB54T3elj56qZ3er+ZZv4fyn9T/mJBkQ/dPt/tY
         tE/fUiEnL/YH6Y0TeFqQkPJI5ZEUkgUzquCEMsLcJOOtiES45axH7nEo7sWfo1YQQFRC
         eYhAld8YCZZzXDAqT3Q+RvaF8Lp4Cojc9jUdaquf4cvNbFV7wjzl8SMIGxY1Gjl7gFWK
         3YmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683128390; x=1685720390;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVVLdXvIfrw5/3NYijIBIn8HUk/59pymTlkCnyX4gZk=;
        b=KTkSWU7ODJdGUHZEScMQZYoY9BpiYMU8Ekt8ZkeQtWonums+2kAx7oiMGAejeQVWvu
         uTCeTHUTiKnbQeCcSVtMm4V4ucAF3/cShxehG9kNhpXN7GYIqSpUrHCzZ6WyfKKEZG9b
         TXkdxk8PPqyISx9IgOeHsSzzLs2NpbvJEfZrAk37sYAnzbiTF6xBv7IO9y7JJzXpVSRQ
         YlN7MEr9XHkfkLdi7OQqchCGKYz7H19RONiF9FpCCJJRp8zwvcb1gULCnO+2x3J6MbPr
         zSSVvkplbluLiU4bRqriDisugJQhUcM4KvltEjhowTP9Pn6NDb2+npOSweiuJ4AaIDL1
         NQhQ==
X-Gm-Message-State: AC+VfDwDOdFfwzf0ZBuH9bSJ1DcwVaAytsSHEFqPJ5srV9w/QGgA5mRd
        3ArrH29o7K6/fDpXxAUvBYWnjA==
X-Google-Smtp-Source: ACHHUZ5d4YwH96Tpn6LfKIxiZcp69KtZgmoa3BJZVXRNO88gwL/jKwNV6SF+0qAXwiCYWhzG65q3sg==
X-Received: by 2002:a92:7402:0:b0:330:a1eb:c5a4 with SMTP id p2-20020a927402000000b00330a1ebc5a4mr4047857ilc.1.1683128389782;
        Wed, 03 May 2023 08:39:49 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id cd23-20020a0566381a1700b00406147dad72sm10232284jab.104.2023.05.03.08.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:39:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     =?utf-8?q?Christoph_B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        stable@vger.kernel.org, Thomas Voegtle <tv@lio96.de>
In-Reply-To: <20230503121937.17232-1-christoph.boehmwalder@linbit.com>
References: <20230503121937.17232-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: correctly submit flush bio on barrier
Message-Id: <168312838868.941317.975898202413701616.b4-ty@kernel.dk>
Date:   Wed, 03 May 2023 09:39:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On Wed, 03 May 2023 14:19:37 +0200, Christoph Böhmwalder wrote:
> When we receive a flush command (or "barrier" in DRBD), we currently use
> a REQ_OP_FLUSH with the REQ_PREFLUSH flag set.
> 
> The correct way to submit a flush bio is by using a REQ_OP_WRITE without
> any data, and set the REQ_PREFLUSH flag.
> 
> Since commit b4a6bb3a67aa ("block: add a sanity check for non-write
> flush/fua bios"), this triggers a warning in the block layer, but this
> has been broken for quite some time before that.
> 
> [...]

Applied, thanks!

[1/1] drbd: correctly submit flush bio on barrier
      commit: 3899d94e3831ee07ea6821c032dc297aec80586a

Best regards,
-- 
Jens Axboe



