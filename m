Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25C27DA7B4
	for <lists+stable@lfdr.de>; Sat, 28 Oct 2023 17:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjJ1PPO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 28 Oct 2023 11:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1PPN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 28 Oct 2023 11:15:13 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674CB93
        for <stable@vger.kernel.org>; Sat, 28 Oct 2023 08:14:25 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-777719639adso220589885a.3
        for <stable@vger.kernel.org>; Sat, 28 Oct 2023 08:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698506064; x=1699110864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edrT3wG/vlC5yAs6mr/X68CLECTGUmsWaJYhfyzukiY=;
        b=NAnTp4K3+mOHEGLkbC6vrolo48RvMrlJsjfEf3tAMKP9oD1XNclUwHwpfmlCYYbPfl
         BfhMxE4suTA90DjfWe6pAVczs+ACbuk5kjjOseFtMvZbzsqoaw6tZPo1mlz7dUX1YBNy
         3SbIFloBDAlsC/cug2p161UUt9IXCoJPNVkEzx34GuUrmCszooy4Dhu1N6pfPlvhHAyu
         KVW01nsWmFlVQ90wmk5m30wYF9Tphjxaox3F1WoZFIKNXhGz5ETbB0EFLOh2hJEpZTIo
         50Acaem6dU5HKgW9ZsKuG54PSO/S2h5wMZbvrLzXPC9rYH3dg12XquxOGRaH5FBFnCzb
         ouoQ==
X-Gm-Message-State: AOJu0YymbUgsbLZ5PH71SAQEMgu4BpeJrxKdr0BKzPX1/YFfNr2RzD7Q
        ddjtj2ECQl31SRAu1YyZm2uD
X-Google-Smtp-Source: AGHT+IFz3FFwOBGqOtVkA6xb2pksB7Wfy6+96bwsBbKM6DOuPkOrQvrErGnF7d2hQ1ocgDx6K+nVWA==
X-Received: by 2002:a05:620a:45a3:b0:774:3235:4e6d with SMTP id bp35-20020a05620a45a300b0077432354e6dmr6608509qkb.21.1698506064506;
        Sat, 28 Oct 2023 08:14:24 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a14a400b00775bb02893esm1617261qkj.96.2023.10.28.08.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 08:14:24 -0700 (PDT)
Date:   Sat, 28 Oct 2023 11:14:22 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>, stable@vger.kernel.org,
        regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
        dm-devel@lists.linux.dev, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
Message-ID: <ZT0lTposMdp/++IS@redhat.com>
References: <ZTNH0qtmint/zLJZ@mail-itl>
 <e427823c-e869-86a2-3549-61b3fdf29537@redhat.com>
 <ZTiHQDY54E7WAld+@mail-itl>
 <ZTiJ3CO8w0jauOzW@mail-itl>
 <a413efbf-7194-95ff-562b-f2eb766ca5c1@redhat.com>
 <34f6678e-6460-f77-73f4-fc8d3652a8e5@redhat.com>
 <ZTzTBUdaX1h8ivZZ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTzTBUdaX1h8ivZZ@casper.infradead.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Oct 28 2023 at  5:23P -0400,
Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Oct 27, 2023 at 07:32:54PM +0200, Mikulas Patocka wrote:
> > So, we got no reponse from the MM maintainers. Marek - please try this 
> 
> yes, how dare i go on holiday.  i'll look at this when i'm back.
> probably.

There was no malice or disrespect until you emerged from holiday.
Hopefully you're at the start, if not you should extend it. Probably.

I've staged this workaround until you or others can look closer:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.7&id=b3d87b87017d50cab1ea49fc6810c74584e00027
