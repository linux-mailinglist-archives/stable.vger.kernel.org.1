Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9A57D94C0
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 12:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345629AbjJ0KI1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 06:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345675AbjJ0KI0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 06:08:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208581B5
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 03:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1698401299;
        bh=0tSupoaXw3PNm+1ssTFm6jQxgNKdnFhV/B2IybUSobA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jQzILde5pelxgGYr760bO3cfAdt+bZ7Ta907VVMaUe4oT5X9nX+HJlckc9Y0OzbzP
         YnO2eH/U1i4M9q5jcX9ha4A6bY3JZdaLKhf5tBrNK1g1Yv8eCXDVT4iGkoURtoM/IC
         KIFs/XBpb7HmmKEDYZtcA1oi4Jypgh2qiaFCjtZh5SkpEa1ABy2Ul+Nx8N8yNpq5iB
         tpThaHfnLs7N9Jhh+R/Pc6lfYN+ek3YKlmuF8r2fWKYfNfeQV8s1QaDptFeKNhLtDf
         8EKSSqN9VAMzsPiETBkpfbWXnQcC0P23vgLs8xDqZj/pgcBpmOIvA3W1hZTGFXDXhZ
         tDBLeYbijpsJQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGyzR0XgGz4xWf;
        Fri, 27 Oct 2023 21:08:19 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Gaurav Batra <gbatra@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, brking@linux.vnet.ibm.com,
        gjoyce@linux.vnet.ibm.com, stable@vger.kernel.org
In-Reply-To: <20231003030802.47914-1-gbatra@linux.vnet.ibm.com>
References: <20231003030802.47914-1-gbatra@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc/pseries/iommu: enable_ddw incorrectly returns direct mapping for SR-IOV device
Message-Id: <169840079678.2701453.14213017318168478377.b4-ty@ellerman.id.au>
Date:   Fri, 27 Oct 2023 20:59:56 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 02 Oct 2023 22:08:02 -0500, Gaurav Batra wrote:
> When a device is initialized, the driver invokes dma_supported() twice -
> first for streaming mappings followed by coherent mappings. For an
> SR-IOV device, default window is deleted and DDW created. With vPMEM
> enabled, TCE mappings are dynamically created for both vPMEM and SR-IOV
> device.  There are no direct mappings.
> 
> First time when dma_supported() is called with 64 bit mask, DDW is created
> and marked as dynamic window. The second time dma_supported() is called,
> enable_ddw() finds existing window for the device and incorrectly returns
> it as "direct mapping".
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries/iommu: enable_ddw incorrectly returns direct mapping for SR-IOV device
      https://git.kernel.org/powerpc/c/3bf983e4e93ce8e6d69e9d63f52a66ec0856672e

cheers
