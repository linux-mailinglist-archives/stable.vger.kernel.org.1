Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01EA76A9EA
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 09:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjHAHYe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 03:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjHAHYb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 03:24:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D10127
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 00:24:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D7B2614AC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 07:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D2DC433C8;
        Tue,  1 Aug 2023 07:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690874668;
        bh=d9Y5aNvwEMaddR1ZJ4jWT11MIGKB8TQJVKeOAl0ilMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oH3WIoF9AuF6PsUEjzZx3O02PbcKvjQSVcJOkhPv85U42CXJaf+/8pLN2au10IhUS
         jM3OGT7HMFNiyf1OrWDIlr5ZoTSggWh/oK3ULKEOKZoFSnP/pnDnfP/YaS9XMsdAzu
         vk3AEiAJB7DH/eEwP332KBrbzXvPxrRPwCQo6sbc=
Date:   Tue, 1 Aug 2023 09:24:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Hemdan, Hagar Gamal Halim" <hagarhem@amazon.de>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Yadav, Pratyush" <ptyadav@amazon.de>
Subject: Re: Backport request
Message-ID: <2023080112-sandbank-surrogate-846c@gregkh>
References: <88AC5AF1-276D-42AD-AD41-37FE9A874616@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88AC5AF1-276D-42AD-AD41-37FE9A874616@amazon.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 01, 2023 at 07:17:04AM +0000, Hemdan, Hagar Gamal Halim wrote:
> Hi,
> 
> Please backport commits:
> 
> c02d5feb6e2f ("ACPI: processor: perflib: Use the "no limit" frequency QoS")
> 99387b016022 ("ACPI: processor: perflib: Avoid updating frequency QoS unnecessarily")
> e8a0e30b742f ("cpufreq: intel_pstate: Drop ACPI _PSS states table patching")
> 
> To stable trees 5.4.y, 5.10.y, 5.15.y, 6.1.y. These commits fix Intel Turbo enabling when
> bringing CPUs offline and online again. I've tested this on the mentioned stable trees.
> Feel free to add
> 
> Tested-by: Hagar Hemdan <hagarhem@amazon.de>

All now queued up, thanks.

greg k-h
