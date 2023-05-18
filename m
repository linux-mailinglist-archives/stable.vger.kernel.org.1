Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8314E7087C8
	for <lists+stable@lfdr.de>; Thu, 18 May 2023 20:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjERS3h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 18 May 2023 14:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjERS3g (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 18 May 2023 14:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3048AE4A
        for <stable@vger.kernel.org>; Thu, 18 May 2023 11:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684434528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZoOCyUhfshjqiWx1RRGNm+zxB7amhG6MwKVi2N7UXyc=;
        b=UI/PjRfEAKrFiWKjf8fISTg6AEyXPzMiCsFhglIv+hvqLWQqNU373i70pzSrJteHYzEVZj
        JYdiLTdoVvVqcHn7sTgEesR+d8qObsXVIyr6cqYjCO3MnQK9nlauo58lV4IUUKWUQc0LPi
        oIaKpQFU34PN2YoqKlmwtSxBcoF/3WE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-QSYFDS-XNdepz1-7eL6ImQ-1; Thu, 18 May 2023 14:28:46 -0400
X-MC-Unique: QSYFDS-XNdepz1-7eL6ImQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f52eb10869so34876971cf.3
        for <stable@vger.kernel.org>; Thu, 18 May 2023 11:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684434526; x=1687026526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoOCyUhfshjqiWx1RRGNm+zxB7amhG6MwKVi2N7UXyc=;
        b=M6MM7a5VwLpyxkKI13jSBmJR7W7pC4S2yzDXrj87vq7mW+wtw5NxZkWXbE0IpwMGtS
         ilCv1acNek6jk5mxtmtCvrDBNx4mPSyoPwJQVFGXmHitRSGqu6qjnXN4WOTBiEIQWP/n
         lKlepwy0uE2P0LuDNLFTgoluLE470V2gVz3HenBFNT3f7k4uSpYTiErVUjfsQDoGhExF
         F668zk7JM1nsri8KRsrzumbtuvUVqgrx14POPGAQdl5qPcHgjvLPWV9OTWDQxjRglU7A
         z5XMcr2wYlxoQShOAn2/Ml01BbM8PbJP/U6S4tMeu2+05wSL0mNBTEzUwWHS/cNzgGve
         5lWQ==
X-Gm-Message-State: AC+VfDyKH80YDizj290BS41N2Ge4xEsNV9h6NjxDhxrgeD8ctK0OBvdz
        RUCLP5L0njI3tT0Tavd49fDeoEwN7FOMEfW5zdfcPkW9QGClfRP92o+qTnbJNuvQ93dmKwZ99hj
        UdA+H0wK/S1FRZmDT
X-Received: by 2002:a05:622a:152:b0:3f5:41d9:fddb with SMTP id v18-20020a05622a015200b003f541d9fddbmr1163443qtw.47.1684434526268;
        Thu, 18 May 2023 11:28:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ78W2zAGWvSvDR1brUGAqTFQs3yXE6GKD14ttBdpFaqUXpLV7M9B6iNBpNGztxVS1Q6I6uXdw==
X-Received: by 2002:a05:622a:152:b0:3f5:41d9:fddb with SMTP id v18-20020a05622a015200b003f541d9fddbmr1163415qtw.47.1684434526063;
        Thu, 18 May 2023 11:28:46 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id x5-20020a05620a01e500b0074fb15e2319sm557599qkn.122.2023.05.18.11.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 11:28:45 -0700 (PDT)
Date:   Thu, 18 May 2023 11:28:43 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts for more Lenovo devices
Message-ID: <h7pelzgnae6kgrydhbp2ffoj4xctux3vx3s5yhiexskaykhcha@stxphc5cc3gy>
References: <20230511005403.24689-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511005403.24689-1-jsnitsel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, May 10, 2023 at 05:54:03PM -0700, Jerry Snitselaar wrote:
> The P360 Tiny suffers from an irq storm issue like the T490s, so add
> an entry for it to tpm_tis_dmi_table, and force polling. There also
> previously was a report from the previous attempt to enable interrupts
> that involved a ThinkPad L490. So an entry is added for it as well.
> 
> Reported-by: Peter Zijlstra <peterz@infradead.org> # P360 Tiny
> Closes: https://lore.kernel.org/linux-integrity/20230505130731.GO83892@hirez.programming.kicks-ass.net/
> Cc: stable@vger.kernel.org # 6.2

For the stable folks this can be ignored though it won't hurt anything if someone does
backport it. The code enabling interrupts went into 6.4-rc1, not 6.2.

Regards,
Jerry

