Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702227227FB
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 15:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjFEN4m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 09:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbjFEN4k (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 09:56:40 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053A6B1
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 06:56:39 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f3ba703b67so5979160e87.1
        for <stable@vger.kernel.org>; Mon, 05 Jun 2023 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685973396; x=1688565396;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fdzdV/lTZ9m7Ml+DPTleYye/0RYSqZN1Fw5rlIucMm4=;
        b=g7oJyKR39U2PwB5KhvOsCS2xauzG9qa5LbxsKsMyORv+sj4iu54tuBaXfRkbvgUhgA
         QX74bs7/xqdVHVsgMlA8Tkfwg9I6SglSaDKc1dpz8E32bU4ZJRv4w6LL1k/tQJ8Lmqnh
         7dc8dkgYHrrdd2NWW+m1VSekaDlsyjRHkzc61xhWxS1XSd4j3U6jzWCzUwmmrAfnPI5f
         qJjI5KT8326MysDH8pB0ioyvsZQu5t3JmKkh/zoR0/8HftsWTIPMGXQYBKsVwVeAyUtP
         jqAA/I/UHByN2YBOaZD6z1XTlP2QBuXKAOxacrVJRmihAtQyWCLAyvucIMeo8n0ZWRUV
         XN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685973396; x=1688565396;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fdzdV/lTZ9m7Ml+DPTleYye/0RYSqZN1Fw5rlIucMm4=;
        b=RiuMtMkQv8vXi0Dohz9h1EW9cTtJy4XxyLO9q5J7HMUGBGNjeWWymCxUIQlaJ3liCe
         sIujvsyQQ/Ip1sSoJ5LMSyyA81wTNcnkbJeCo+2pHNC3W9VIjRCos3u7am8CjFMlg0ll
         frg28kYtFxzWBmMl7ULTujCWQbW7ByeVO5MWcWmJXbSfcIY9fGrt29ZMMm3lhJKTEQ6V
         0smazDeZJwWfPaJNGoZfeIpp6DYyUtVrqqu7Y2T66D6EmJmYmrbyie+StGpGNzc5I5NS
         E6csFdZ5jvxrxy43XtQOwnIj9tdD/gfgF6j44j/Edz/xaOvbheNyQpcr+1ozFhQj2KQi
         qCKg==
X-Gm-Message-State: AC+VfDwyJh9Zwz6ijZJw04RQM0lof5Eg6rNqkHfUdNuECytoZrve28Xs
        zXmY32HAVrPsvZcB9PZmiaiBx2VDp+LxjvjWjIuY3wfgB9w=
X-Google-Smtp-Source: ACHHUZ7XJhAPmZKZqtwdvVDrkwnqWRFvtA+LHKgJ3/IRiBIx+Q9nalZ+KPtryu2TKG91jiw4qH+RY5TmuA3kNmKlS9w=
X-Received: by 2002:a19:ae0f:0:b0:4f6:171e:496 with SMTP id
 f15-20020a19ae0f000000b004f6171e0496mr3525356lfc.21.1685973395926; Mon, 05
 Jun 2023 06:56:35 -0700 (PDT)
MIME-Version: 1.0
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Mon, 5 Jun 2023 09:56:24 -0400
Message-ID: <CAKf6xptzGSq5xUhbFDVB-vR0WfhDWnqXRY3UYYG4DvUakNR1AQ@mail.gmail.com>
Subject: Request: x86/mtrr: Revert 90b926e68f50 ("x86/pat: Fix
 pat_x_mtrr_type() for MTRR disabled case")
To:     stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Borislav Petkov <bp@alien8.de>,
        Christian Kujau <lists@nerdbynature.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

x86/mtrr: Revert 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for
MTRR disabled case")

commit f9f57da2c2d119dbf109e3f6e1ceab7659294046 upstream

The requested patch fixes ioremap for certain devices when running as
a Xen Dom0.  Without the patch, one example is TPM device probing
failing with:
tpm_tis IFX:00: ioremap failed for resource

The requested patch did not include a Fixes tag, but it was intended
as a fix to upstream 90b926e68f500844dff16b5bcea178dc55cf580a, which
was subsequently backported to 6.1 as
c1c59538337ab6d45700cb4a1c9725e67f59bc6e.  The requested patch being a
fix can be seen in the thread here:
https://lore.kernel.org/lkml/167636735608.4906.4788207020350311572.tip-bot2@tip-bot2/

I think it's only applicable to 6.1

Thanks,
Jason
