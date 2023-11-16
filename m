Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BB87EE1BB
	for <lists+stable@lfdr.de>; Thu, 16 Nov 2023 14:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345175AbjKPNnM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 16 Nov 2023 08:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345125AbjKPNnM (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 16 Nov 2023 08:43:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC70A0
        for <stable@vger.kernel.org>; Thu, 16 Nov 2023 05:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700142188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKySi+nTZnvhuJkFIal8zoJxCKY65UchF53uvgGL9d4=;
        b=QKgnNtiNN1WxxYF/wjzvfzyjlFivow17mZlXMhTRG7gm+J6R6x/phHi+niO/XzNqcI15s6
        gKv9cN8310OFN6qGT+z4OnEshmM3ZlrqhSp+7p+AHQbfoFK8/i/b+dVMppIK1dP9hTmcib
        o5r48VFjlUjGeKpqP2VxTnUPrGw72o0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-16wfSwY_ORabBxmwEMtXlg-1; Thu, 16 Nov 2023 08:43:06 -0500
X-MC-Unique: 16wfSwY_ORabBxmwEMtXlg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50a73178b1aso837639e87.0
        for <stable@vger.kernel.org>; Thu, 16 Nov 2023 05:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700142185; x=1700746985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKySi+nTZnvhuJkFIal8zoJxCKY65UchF53uvgGL9d4=;
        b=dBgXY7KSQmFC4d4XLcvACuBMBfqOdMSUr8VD1+8joT3pXtB513b48mzf/ItefYHVZB
         eSCcYx1NKNSbRP/3c2SgYxHygq8IwC66ELI7krRGsWXNeka9C3KDXtHCTCfHr1+3Y4UL
         3Rk+9oIlbXzdQqQ6Gur4f0/EkUVBOw0HSPg4WT9DMv8+mNJr/z+d9+K83S+4j9bDk3Ah
         JQEey2DiyGZWPKPq+ke/8FYEs23cYklteg3OPF840v40S41RsJSPBYh2SkMK6KKC4/gm
         x/tuv/jsoAt1psJOESfBXG+YKtLK6PP8/q/EUa1V0PogdQeRoqdT/V5rZ6BuwlO7ekst
         y7rA==
X-Gm-Message-State: AOJu0YyqgPm8zdtwiwW+vSakJMVaCzGVvLyahYwLLxI8Hd7hv3MCJwRR
        CavBmXqJL3cn36cir4keqKnc1hxewuNe+wbmBBqtmvSyDbLafwpTwqL6nvLVTRArXwNPps1dY9h
        regAvzx5QvpgAWXmd
X-Received: by 2002:ac2:504d:0:b0:509:455c:9e3d with SMTP id a13-20020ac2504d000000b00509455c9e3dmr1630656lfm.18.1700142185238;
        Thu, 16 Nov 2023 05:43:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgwYDce6+ONyQc/rFN0SurC2BdO7q/zyBZwu8nGypsPiTmuW5s5HnzjQ3t8EEOx2OUC8bWDA==
X-Received: by 2002:ac2:504d:0:b0:509:455c:9e3d with SMTP id a13-20020ac2504d000000b00509455c9e3dmr1630644lfm.18.1700142184931;
        Thu, 16 Nov 2023 05:43:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id b15-20020adff90f000000b0031fd849e797sm13679166wrr.105.2023.11.16.05.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 05:43:04 -0800 (PST)
Message-ID: <f5780fd6-ebfd-4fa9-afa0-412775c820c7@redhat.com>
Date:   Thu, 16 Nov 2023 14:43:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ast: Disconnect BMC if physical connector is
 connected
To:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20231116130217.22931-1-tzimmermann@suse.de>
Content-Language: en-US
From:   Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20231116130217.22931-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 16/11/2023 14:02, Thomas Zimmermann wrote:
> Many user-space compositors fail with mode setting if a CRTC has
> more than one connected connector. This is the case with the BMC
> on Aspeed systems. Work around this problem by setting the BMC's
> connector status to disconnected when the physical connector has
> a display attached. This way compositors will only see one connected
> connector at a time; either the physical one or the BMC.


Thanks for the patch.
I can't test it because I don't have physical access to a machine with 
aspeed GPU, but it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

-- 

Jocelyn

