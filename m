Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580B07E8096
	for <lists+stable@lfdr.de>; Fri, 10 Nov 2023 19:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345088AbjKJSP2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 10 Nov 2023 13:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235795AbjKJSOl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 10 Nov 2023 13:14:41 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B72E6E9D;
        Thu,  9 Nov 2023 22:22:29 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4SRQ2S0zBvz9scN;
        Fri, 10 Nov 2023 04:55:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owenh.net; s=MBO0001;
        t=1699588512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+mYWcVAli9GCc4vPf2eDB3X2wHHEc2PFC+6KilCNEcA=;
        b=qoHS2aXxsUcpqJPKJdC4SI2fQWD6CvHKZd8rgtalJQ45BHmCBDsStfHNnHSu8PLqXeZKPX
        3Wj+RmMzerw3iIO1vcSWmri07ckQ8LlA2IsEPbkkFSS4j4yyREWIxIyNfM5owqOUvmw8wJ
        ycE8DKReVnsEcY/xBRqXHcDXOhshiUQJ3TGfWyzO8ihjGhcDpqLspeX5r53oHdDnjuzj7T
        /kxYjemXrPEERerMX25HLj/Ck8uBBcRsq6f6cHz0vCCWsqVaHEcw/ZImjw+VKs1ENVMoAq
        ykVk2v699lp4qBjo/vfan+boUAgxQO/dtXDSjnYlq2jYjZ3UxYlckAVe2HMM9Q==
Message-ID: <9f36fb06-64c4-4264-aaeb-4e1289e764c4@owenh.net>
Date:   Thu, 9 Nov 2023 21:55:01 -0600
MIME-Version: 1.0
Content-Language: en-US
To:     stable@vger.kernel.org
Cc:     regressions@lists.linux.dev,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Danilo Krummrich <dakr@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
From:   "Owen T. Heisler" <writer@owenh.net>
Subject: [REGRESSION]: acpi/nouveau: Hardware unavailable upon resume or
 suspend fails
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4SRQ2S0zBvz9scN
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

#regzbot introduced: 89c290ea758911e660878e26270e084d862c03b0
#regzbot link: https://gitlab.freedesktop.org/drm/nouveau/-/issues/273
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=218124

## Reproducing

1. Boot system to framebuffer console.
2. Run `systemctl suspend`. If undocked without secondary display, 
suspend fails. If docked with secondary display, suspend succeeds.
3. Resume from suspend if applicable.
4. System is now in a broken state.

## Testing

- culprit commit is 89c290ea758911e660878e26270e084d862c03b0
- v6.6 fails
- v6.6 with culprit commit reverted does not fail
- Compiled with 
<https://gitlab.freedesktop.org/drm/nouveau/uploads/788d7faf22ba2884dcc09d7be931e813/v6.6-config1>

## Hardware

- ThinkPad W530 2438-52U
- Dock with Nvidia-connected DVI ports
- Secondary display connected via DVI
- Nvidia Optimus GPU switching system

```console
$ lspci | grep -i vga
00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core 
processor Graphics Controller (rev 09)
01:00.0 VGA compatible controller: NVIDIA Corporation GK107GLM [Quadro 
K2000M] (rev a1)
```

## Decoded logs from v6.6

- System is not docked and fails to suspend: 
<https://gitlab.freedesktop.org/drm/nouveau/uploads/fb8fdf5a6bed1b1491d2544ab67fa257/undocked.log>
- System is docked and fails after resume: 
<https://gitlab.freedesktop.org/drm/nouveau/uploads/cb3d5ac55c01f663cd80fa000cd6a3b5/docked.log>
