Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4F87C5E3E
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 22:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbjJKUUu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 16:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbjJKUUt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 16:20:49 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40B9B6
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 13:20:47 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-355fbb84257so222015ab.1
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 13:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697055647; x=1697660447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lB/j2LtNeMz/W1YQQ732duppdg4xiLJo45Q+RSgVAQo=;
        b=xtMLL3AujsI8XG2mXYhKUB/spGXSmJKab1wO/UvQS/pPVYZARPmE+q8H5VdoRMh/IG
         2/ie0e4WfoJrxn7MwIUU1jey8Kz0OCtZ6Gx8F5yZ3p+Cql8E56xlX9sAnutWbqSzV7Kq
         Ml+SaWHjAa0ntgCwGDvYPs9VgVRqAlZxhKrgkyoCR/TmVHC41Waj0OVMNozcOCKhkZMi
         JkfvejHYT6yyKfAPLzUKORCZDE3qQxLDY+k0S0EbX2kS7B1G8gOsiw85/hYi4hp//0Al
         v8FQb1gOjr0mablPKIPxrSRweSLmtdr3J5joUQZASyPdGibvXxtduZF+i5hnEySIM4Ol
         v+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697055647; x=1697660447;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lB/j2LtNeMz/W1YQQ732duppdg4xiLJo45Q+RSgVAQo=;
        b=t0J5x+zPZNDT8O2Vx9lmp4O4+fyOFwTPpvfTNsuBasce/X7y8fjIiqmTDuB18fw1wj
         5lLVnjOgFbbUYzPfcB8YSzwgy2MiYV4ZrsHfD9/q1bHjomNCnw72pgAFzRYCDjvC1yjn
         WTx+uoS/D3wlcslDlILi5jq66+XmWIxE4M+z+BuaoIvtWVLtfHWxutu0agtmYyvEcAdM
         wwdg/053tN6+9qALUxkMpIUuEGorY05b7d1FlgTLF0zi+yW+EOHAEQMrwdC0/L2vb00h
         ehWrV5f1//foG8P9QrcGBJatzTEsXFrakLoofqilMzhwJ+ad6v8TIAko3kIkDnZihaV6
         6Zgw==
X-Gm-Message-State: AOJu0YykS6r/aWyxusLJ+bH33bsvdYj7lX1xpSeVAbLhWZxPVTljJZrE
        Ro9gsqJtWYj+SrlGpcQA0S7UDA==
X-Google-Smtp-Source: AGHT+IEruZKhD7bxlTjyy47l5LeM/sL4l3VP9Zm6qvwYHSSSMgVJNz0+ACbD8gaUX5jTiNivN3JKDQ==
X-Received: by 2002:a92:db4f:0:b0:350:f353:4017 with SMTP id w15-20020a92db4f000000b00350f3534017mr20611565ilq.0.1697055647337;
        Wed, 11 Oct 2023 13:20:47 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r13-20020a92ce8d000000b003513de0eae9sm177591ilo.24.2023.10.11.13.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 13:20:46 -0700 (PDT)
Message-ID: <b068c2ef-5de3-44fb-a55d-2cbe5a7f1158@kernel.dk>
Date:   Wed, 11 Oct 2023 14:20:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Don't invalidate pagecache for invalid falloc
 modes
Content-Language: en-US
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        stable@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>
References: <20231011201230.750105-1-sarthakkukreti@chromium.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231011201230.750105-1-sarthakkukreti@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/11/23 2:12 PM, Sarthak Kukreti wrote:
> Only call truncate_bdev_range() if the fallocate mode is
> supported. This fixes a bug where data in the pagecache
> could be invalidated if the fallocate() was called on the
> block device with an invalid mode.

Fix looks fine, but would be nicer if we didn't have to duplicate the
truncate_bdev_range() in each switch clause. Can we check this upfront
instead?

Also, please wrap commit messages at 72-74 chars.

-- 
Jens Axboe

