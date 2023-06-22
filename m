Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D0C73A2A0
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 16:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjFVOD7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 10:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjFVOD6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 10:03:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF99E2
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 07:03:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98862e7e3e6so695559766b.0
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 07:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687442631; x=1690034631;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mWPShC2zoljyVAkeLX8/lNz5+sycSFP90giREGvo+b4=;
        b=2UBULlqSuqCeS7kFO1fPJeekqWHZLVzzmuTr2a6PR1Xc2j4zNQev6WSh4qp7T0fRFP
         e1bDiO0YSaPcTTKTfSzbghmDTOeIq20OpsX4zRIvp5uHRdz3TjnR0txzIRuGZ2fnf588
         6t+NSzy/wmlW9AHzqet1Nm/+3iD1uOsuwrsIXsDv2JAX17D8EPAqBMO2oubyeTLuuZhx
         kZ84YjK2eN/PF0cz/EDRBBcywjL7MZi5p9IU+zoiLUTdM01tw+Cc+6pBGphkrlXDWAR2
         qtY+lEvto9KbrpjGDhGoDMn3150rPF+iOETZZCrRNxC+GyZnAxnTnzrnSiuERUqySpCZ
         B+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687442631; x=1690034631;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mWPShC2zoljyVAkeLX8/lNz5+sycSFP90giREGvo+b4=;
        b=bdh/+yqD2qVEIPIf/C/rcLdBUvmW/dbIiOJadPn9s8k8Xdank2tEtaKQiP8Tz2+QQU
         yW2zYtHAE8Hk5Ri0LyXlA9jwIq0cjvLPyfT+Nnl0LPh57xtyA7WI7ynojtlP4NQo89rB
         O9w8vZ04oNk5LVQtKyOuO5USDoParz3N0d0WKSWQREQXITKDJMP1S1Hr0/0X5zEZwNIz
         VplwCH/EsQSe2c5GGpm5KmQ4Yr45Th7uHVmsD6UN1r4HAaPgBGoZyfTB2M0G+bYB8GF7
         pc311UMLdOm6xpuv/uwW+7NSwyNed/641wMT2QZpjaDW/0hKjZh1MpELWgp9OI0pifOR
         BpbA==
X-Gm-Message-State: AC+VfDz4XgB5+QD6nWkb1xq/aQ2jfEg9bd18L852qlcknnaM00AXJ2gc
        u+TibdkADhum6HmDh8WtNFoMpgZ8DWhLVF4I0i935g==
X-Google-Smtp-Source: ACHHUZ4Ek/+LoL6ss/bhakrp91d3Q7O5717S8Xs5gR8R6TA5ugvMeIefD64pgO58zoJ6FJGzNX9Qsg==
X-Received: by 2002:a17:907:3f18:b0:978:6e73:e837 with SMTP id hq24-20020a1709073f1800b009786e73e837mr18812511ejc.4.1687442630668;
        Thu, 22 Jun 2023 07:03:50 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c154:8b90:b6a7:cb1d? ([2a02:578:8593:1200:c154:8b90:b6a7:cb1d])
        by smtp.gmail.com with ESMTPSA id q5-20020a1709060f8500b009888b71c368sm4721533ejj.152.2023.06.22.07.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 07:03:50 -0700 (PDT)
Message-ID: <d6273da7-40dc-7ca2-e201-d7a2124d9473@tessares.net>
Date:   Thu, 22 Jun 2023 16:03:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5.10.y 2/2] selftests: mptcp: join: skip check if MIB
 counter not supported
Content-Language: en-GB
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Jakub Kicinski <kuba@kernel.org>
References: <2023062217-never-sedan-c4bd@gregkh>
 <20230622135948.3245451-1-matthieu.baerts@tessares.net>
 <20230622135948.3245451-2-matthieu.baerts@tessares.net>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230622135948.3245451-2-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

On 22/06/2023 15:59, Matthieu Baerts wrote:
> commit 47867f0a7e831e24e5eab3330667ce9682d50fb1 upstream.

Sorry, I accidentally sent this last patch for v5.10 twice. This email
was in replied to the wrong one. Please ignore this 2/2 patch (or the
other one, the patch is the same anyway).

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
