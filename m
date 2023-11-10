Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90207E7E40
	for <lists+stable@lfdr.de>; Fri, 10 Nov 2023 18:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344979AbjKJRmW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 10 Nov 2023 12:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjKJRlx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 10 Nov 2023 12:41:53 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E87431C1
        for <stable@vger.kernel.org>; Fri, 10 Nov 2023 09:05:31 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-280351c32afso1928497a91.1
        for <stable@vger.kernel.org>; Fri, 10 Nov 2023 09:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699635931; x=1700240731; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GQ5lIOUPGLS9ZiEkArXbwzyFjisJU45Rrr//Xbfc9c0=;
        b=azzMH5GnV6j8QTVR9Bq5Z+UfuC8NAvDPyBzxFKB96FE+E1Z41wvZCNWlZ45aYLg/Gt
         8NxEEJou1z02SzNc7WpMGs2Z/K+v69Qw2q+2ccdPubbf5LCdNn3ABfn2Fu4jEcWjnMyb
         HWpx1IbMSl0ezO15FDTpR+63kK3xn++0Oqokjgt4gEZSR88WiVRcWItOKAjUeNTJ2g/N
         pZoSdRrf+OR3/rdsytOgpSmAnhK3tKYDi1gMW4N7W159ddDNbWEK04pHI2uewO6+qaFH
         IuMSO990JrQhAFT56HWc1WQrwyagW/a4Ia87nSIw5uTMX+v0zy4K38kBBFwoFKQ0UfQQ
         tHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699635931; x=1700240731;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQ5lIOUPGLS9ZiEkArXbwzyFjisJU45Rrr//Xbfc9c0=;
        b=f9qCgdQ71phdGpvbF+C8MlfHLBaALkZKQHQevLOKBiULdsD2DhzyldGhI+lWDcfeiL
         asl7EwwmVdZmd4GB7D6Oo4a1DEfiGX8Up8d97Btgcxt6wP4DD6Sbonhwev/BqrfGmk3V
         3imXPQQv8OuRKntufiYjL9pLlVgdROrKaBn+uaWmGn3q4kHjkib6vGqroMxwp6Bgq1a/
         c6RrlEdRA28h1Ly9Ofg4JfNmJc6DuiQk3Jq0cqxbSY8nWH55JCD8Qudo2E+yzaTr1Xps
         Nw/VaeARlg1HcqLkGfmFMBUGPM0b3Wb4gLBgzkCzT8YoP55MkTAUxy9FqSQgXi+JK9Bm
         QKcA==
X-Gm-Message-State: AOJu0Yyx3vPP78NJFmenJFPBUqRIa6rXS7jC4mi6d7Ntu58ITzRZvtCE
        F4vMVK6g0NzmrUt+9z75GOm0aftbPjH361V91v6tM5Ra4d6a4pMAQR/OeA==
X-Google-Smtp-Source: AGHT+IGY7OHbJRB9ESLYJMz/3s7LVO+bFMO2m04QJ9Jq72WniWN2WyvIkl+Ohm4uzJpVT1n3rvOhUo+76FDYY5boRKg=
X-Received: by 2002:a17:90b:1809:b0:281:3a4:2220 with SMTP id
 lw9-20020a17090b180900b0028103a42220mr5071683pjb.36.1699635930739; Fri, 10
 Nov 2023 09:05:30 -0800 (PST)
MIME-Version: 1.0
From:   Adam Dunlap <acdunlap@google.com>
Date:   Fri, 10 Nov 2023 09:05:19 -0800
Message-ID: <CAMBK9=YqXa11BUPBLnitvHRFYGdEX=J3S1ssq=iBWRYpGCynBA@mail.gmail.com>
Subject: Backport f79936545fb12 ("x86/sev-es: Allow copy_from_kernel_nofault()
 in earlier boot")
To:     stable@vger.kernel.org, Peter Gonda <pgonda@google.com>,
        Jacob Xu <jacobhxu@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit f79936545fb122856bd78b189d3c7ee59928c751 upstream.

This patch fixes a boot failure that happens with VMs running with
SEV-ES or SEV-SNP when the guest kernel is compiled with a gcc version
past 12.3 (or possibly earlier) due to undefined behavior. As far as I
know, the UB has existed ever since SEV-ES guest support was merged in
(I believe 5.9), but only started causing boot failures with the
updated compiler. Thus, I propose backporting this patch to stable
branches since 5.9.
