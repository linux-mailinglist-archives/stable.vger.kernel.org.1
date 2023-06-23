Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0E573B3DC
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 11:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjFWJnd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 05:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjFWJna (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 05:43:30 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13661FFD
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 02:43:27 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-311183ef595so468126f8f.0
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 02:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1687513406; x=1690105406;
        h=content-transfer-encoding:to:organization:subject:from
         :content-language:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XjZAhEtpirppmTFiyTb5VtGp1QtZ5M30vX9Q7LxJcmU=;
        b=FovACiPHOBJPgZ/esqnUliEIyVK7C9GyX2TZ8wmru+ImKhFO0bRyidDlsO4ybuyEqs
         LDSp4DmRMBViAMEDCdmL6/Um4SWDrhA8OoittolJfdDd2qi5SiDdaaCzogiyBdH5FOBb
         9WaloKTwDFk7UhWNAH63j3ybtd+zTTC36DPalamOCDNZD3hLHD2VpN6A65zJ09P3FRZO
         axYW3NMPx0dMdlwaTQ23jdHON78cftIl2bluapaDi/IG9xjERbgKYXF76EdQBEvNLG+u
         tAOX8u+Jl0nf49vrg/WtFXs4BAGkg6vL5PR8Hf4QfZIvYoZTtRRVF+DnDbQBNB/1OQaZ
         CJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687513406; x=1690105406;
        h=content-transfer-encoding:to:organization:subject:from
         :content-language:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjZAhEtpirppmTFiyTb5VtGp1QtZ5M30vX9Q7LxJcmU=;
        b=AAr0C5j13lgMybPwiIOgKm+1akrc+4k39ZMJJSc2VLD3ZIcEqeyS0QRg42P85Zbs5q
         cjwjO2IlvWq6bbmuvxP+qxtf21vR9r6KeqlLTepmtD7mTOPWboDlPE0pA40wi7zQXzW7
         0v89oDSHlKo8glUL+ZjP0ZQke9mN0dWKVCGZtazLu6qN+JCaSQIMbH5ml3ADU0kynX5R
         oEsN5uz0RJkUhPzo73qW9WW7vGTMUkIncErlMeetjkZtG8KziBKLNrVrT6r6oxc4r2x1
         4YswzEYYMUDPN1YbWfYg3HiWl0uUyQQxXl054KgfUieFTWJ4WRkh5uS+4zW/aiSY8jBj
         OAYw==
X-Gm-Message-State: AC+VfDygsPj8MmLPRfVxMn0+8J1rSdgGB4TLiOpYtCqC2rgVxlQeZhYE
        h1jBlYgqUCUhdYt/IOnYrkLwp8IYRVU0pomdxtU=
X-Google-Smtp-Source: ACHHUZ4iMVHZznwPFCuAC3RowG6FjDpkNVgtzQSPPykJy05vxE2riRWmPUC5l1G1K5e1ZBaBJk14VQ==
X-Received: by 2002:adf:ef50:0:b0:30e:45a5:9476 with SMTP id c16-20020adfef50000000b0030e45a59476mr17177911wrp.1.1687513406330;
        Fri, 23 Jun 2023 02:43:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:cf7c:7555:e0c8:46cd? ([2a01:e0a:b41:c160:cf7c:7555:e0c8:46cd])
        by smtp.gmail.com with ESMTPSA id f14-20020adfe90e000000b003111a9a8dbfsm9089503wrm.44.2023.06.23.02.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 02:43:25 -0700 (PDT)
Message-ID: <f220c0e0-446c-58bd-eabb-0dee9819dd53@6wind.com>
Date:   Fri, 23 Jun 2023 11:43:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: nicolas.dichtel@6wind.com
Content-Language: en-US
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Request for "ip_tunnels: allow VXLAN/GENEVE to inherit TOS/TTL from
 VLAN" in v5.4 / v5.15
Organization: 6WIND
To:     stable <stable@vger.kernel.org>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

I would like to request for cherry-picking commit 7074732c8fae ("ip_tunnels:
allow VXLAN/GENEVE to inherit TOS/TTL from VLAN") in linux-5.15.y and
linux-5.4.y branches.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7074732c8fae

This commit has lived since a long time in upstream (11 months), the potential
regressions seems low. The cherry-pick is straightforward.
It fixes the vxlan tos inherit option when vlan frames are encapsulated in vxlan.

The kernel 5.4 and 5.15 are used by a lot of vendors, having this patch will fix
this bug.

Regards,
Nicolas
