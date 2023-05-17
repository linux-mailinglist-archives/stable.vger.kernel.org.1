Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11C67070F9
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 20:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjEQSkk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 14:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjEQSkk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 14:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156FC61A9
        for <stable@vger.kernel.org>; Wed, 17 May 2023 11:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684348790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wDwTEAQnINvjnEbZP5xDG/iVDh3xkCCQxQmpV/hFkq8=;
        b=jImmAf3GYQv+fl/iXHu6pXWTvUV4BMnDNSy+OXfHvzkzYQJafAo8RoIFa3fozpYPN+W3mr
        JDGlpmrv27DXVRtMSoB5L6c9JLdq2A0aCplu+eyJvi9qMnd7pShT+ML47zKeJ7PujMWcj/
        cyFKlOZuMKNn6NKqir9u1Pq+eCg9tTM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-kHqHY0DNP4CRsx5sxn_5eg-1; Wed, 17 May 2023 14:39:48 -0400
X-MC-Unique: kHqHY0DNP4CRsx5sxn_5eg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7576864caf7so9604385a.1
        for <stable@vger.kernel.org>; Wed, 17 May 2023 11:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684348781; x=1686940781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDwTEAQnINvjnEbZP5xDG/iVDh3xkCCQxQmpV/hFkq8=;
        b=DtQx7QeCWZ446GBo+szRLdl8DxwzdiUH4VvS2SHkxg+GUEL+t0l3SS44xRuLOX8I50
         vzSvzvG4OSDM4cw/XlS6idPdhMUQ4Q8lfIykrocALLIXv3vGCRX2Q+wghBKtnMZ/XGYv
         iQA3oOwRgg+/9+IQQkYd5ts6gOH43rnGIO81IAl2MHuXTow+/Vixrf1xBioGBizVCm3X
         +71N8t5ZAvEhWODthuEPvjR7USFBL+EszGhVhbTmVLiX3K33aEomGYn+8MIJgBs9WgEn
         VaiDlF8D9DpVXsO4sHsWNdlWVheTCo/Y6qOqLtJjxN772H0M6W49OVJiaAxunrBvd5Ar
         p+Xg==
X-Gm-Message-State: AC+VfDxrh8gqKrDbto/HMb72awgn7cmbapH2zFS11aSCOiNQhNQF+Fqj
        VpAGI90YywaE6KZEuOZ0qJWzpDiiwszuCKhorQxlqb+Xb9nNPJUneY//eLVJ9xASKMOY1DBwe8q
        EoohY1XIbyBJOefuW
X-Received: by 2002:a05:622a:189e:b0:3f5:99e:d7d4 with SMTP id v30-20020a05622a189e00b003f5099ed7d4mr6386656qtc.1.1684348781420;
        Wed, 17 May 2023 11:39:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7npnxMYaFPMdez4XnpRaMmAS6FkMcdldYw8nV0EQ28btS8JdEbLrqbrGm2Y5o1ja5g9B0pJQ==
X-Received: by 2002:a05:622a:189e:b0:3f5:99e:d7d4 with SMTP id v30-20020a05622a189e00b003f5099ed7d4mr6386634qtc.1.1684348781213;
        Wed, 17 May 2023 11:39:41 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id k21-20020a05620a143500b0075954005b46sm814944qkj.48.2023.05.17.11.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 11:39:40 -0700 (PDT)
Date:   Wed, 17 May 2023 14:39:39 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm/uffd: Allow vma to merge as much as possible
Message-ID: <ZGUfa+E+LNZWmJGi@x1n>
References: <20230517150408.3411044-1-peterx@redhat.com>
 <20230517150408.3411044-3-peterx@redhat.com>
 <a23dc138-a7b3-40c7-adf9-68b2c8185e08@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a23dc138-a7b3-40c7-adf9-68b2c8185e08@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, May 17, 2023 at 06:23:18PM +0100, Lorenzo Stoakes wrote:
> Maybe a Reported-by me since I discovered the fragmentation was already
> happening via the repro? :)

Sure!  I'll add it when/if there's a repost.  Thanks.

-- 
Peter Xu

