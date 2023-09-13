Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36CD79F3B1
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 23:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjIMVUe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 17:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjIMVUd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 17:20:33 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D547A8
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 14:20:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401bdff4cb4so2755825e9.3
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 14:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1694640027; x=1695244827; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqyokU/ELbzkGchdc7Nev12TWOkqVmhXhkHJ0kc6H6E=;
        b=UK9LHAGTp5LKJ3TFK9MTDVyddCCodGqvW4xOSPMw4rlPxI5YLQUtQoUwa874nmptFF
         cQNTevFzNL+G96VuJhrgM16anQ7sAiWCfwsOZRsL3V7ThjiDu+4lDsDpfinXAd2/aL6A
         PdgphFvZkx260kVTGqWkKReYS2m+354RJP7D0tjqi+M7Ermdl+doMXwamjxvhvZLCIRJ
         CPFVonPxFh6npQ0LMaQufw3JuBhOGmmkm5EOtvXNVYuxr0T7mZ5FpUFLYl1mZ79Mo5sj
         rRFFp6CYC5kLYOFBH2k4RPfFycefXqHlxnpknt3+TlhNzxSwTsZJb/nQoFv9F0mHjFRo
         OUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694640027; x=1695244827;
        h=content-transfer-encoding:organization:subject:from:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iqyokU/ELbzkGchdc7Nev12TWOkqVmhXhkHJ0kc6H6E=;
        b=L9d8x+m+yNUp0k9qAYwa6fhrAMSUdrjko3OxJ1b3z7+DKsJOUHiEBs5o+otX3dR9/N
         sEi9Dfd3rkTndHfJLRWrB2y0Gp2232KB6K1M8hINB5g6SlGcsgw3OiRoxDzhMA2cRR18
         lLhvx/Q7gbSMz1rPB7H26eTfzJBYWj53bzTw1rWDZIe4qfzCyVe62fFjqH7mi372nlBI
         jXTJ/78HVyDfsgFYXOGVW9nEW3ORZEJ3+BmeMnKfk5Z1LbqoO7KRts9lJws+ZAOC5n+b
         AGAL4ppZrQa+QzQJ7J8uQhVlESo2rYnEDxoHcPyOslJCTOqiVdyVqQinj3WOHiNgP3iO
         DGDw==
X-Gm-Message-State: AOJu0YwIHMclMVWBQGWrqu9GHyA4X+3hu0FxuA+jzR52YUjmWE8BQP0n
        6Xvu22y92tL0WDwwHnorPO9yrKczUcTrMWkwXP4=
X-Google-Smtp-Source: AGHT+IHOczezLMYMOuaa0/Mnj/SIoU2xzYDWctAmy8EOiVdKYs0Pn378UPN/cp+eWa979+75/mjagw==
X-Received: by 2002:a05:600c:2152:b0:400:c0e8:18c6 with SMTP id v18-20020a05600c215200b00400c0e818c6mr3113347wml.18.1694640026939;
        Wed, 13 Sep 2023 14:20:26 -0700 (PDT)
Received: from [192.168.0.21] ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c024c00b003fc06169ab3sm3020495wmj.20.2023.09.13.14.20.26
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 14:20:26 -0700 (PDT)
Message-ID: <4cddacd0-37bc-ec7b-1ba2-bb41a9d3eb8d@smile.fr>
Date:   Wed, 13 Sep 2023 23:20:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     stable@vger.kernel.org
From:   Yoann Congal <yoann.congal@smile.fr>
Subject: Please apply "watchdog: advantech_ec_wdt: fix Kconfig dependencies"
 to 6.5.y
Organization: Smile ECS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Can you please apply "watchdog: advantech_ec_wdt: fix Kconfig dependencies" to the 6.5.y branch?
commit 6eb28a38f6478a650c7e76b2d6910669615d8a62 upstream.

This patch fixes a configuration bug in the advantech_ec_wdt (Advantech Embedded Controller Watchdog) driver where it can be compiled into a noop driver.
I come at the Debian kernel maintainer suggestion following my attempt at adding this driver to their kernel [0].

Thanks!

Regards,

[0]: https://salsa.debian.org/kernel-team/linux/-/merge_requests/841#note_427523
-- 
Yoann Congal
Smile ECS - Tech Expert
