Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24517E97D0
	for <lists+stable@lfdr.de>; Mon, 13 Nov 2023 09:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjKMIe6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 13 Nov 2023 03:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjKMIe6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 13 Nov 2023 03:34:58 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3343510EC
        for <stable@vger.kernel.org>; Mon, 13 Nov 2023 00:34:55 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507bd19eac8so5506115e87.0
        for <stable@vger.kernel.org>; Mon, 13 Nov 2023 00:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliahub.com; s=google; t=1699864493; x=1700469293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nSmZOQp3NDYoYQRoOZeW69Lq5ePPtNZcj13zDtILkTQ=;
        b=Un/eWOrSRIpXkOWzJEXL7+SF8dcbycBGpIfz/SXHD5MmBgL1lQF80BdGbdyTV0qnvT
         vH732lZc/yrP6+vdk86TvaaXzTaceZZ84ZmjXEEnQ1GqMk5ZReKoAhY3eUVqweff3SrT
         Ym0C92gdgR0BNtTTAXWnu3TA3kYrZHOSzSCGXZ5C+VPYVy2zWAS8itF6WoMHY2kg7pj7
         4voEY2IsO0l2bLntPoh0gLg9BNs28/s/ZRJWHpQm72d745RJUTytjysqEpXc3CS09Q3J
         RO2Q9y1QhAwoK2zqIC8FB7650SwGUKNu496NxyWA+GwxJDx/g8/XpEgUZk26fNMZ0XFG
         tO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699864493; x=1700469293;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nSmZOQp3NDYoYQRoOZeW69Lq5ePPtNZcj13zDtILkTQ=;
        b=PFO6+Rtb/sgAaz0IaYvkVwILEe0mmCsKWty0Ex9/sVOIJY+3j4Kbhexv+XiVtBZER/
         +7HIeKp+j4TreGWFXm2sKsHippcYxi5e7q5YJcA9MsmhTe31/fzEfV/myFlwF32Dc24c
         cDK/1CGTQ64508cEBfdWvrIpELnfe8uhbVCAH5R0WpViuhb/LdJhJFe8kfilvT+ibzbx
         HVclG1FF8wqXiAi0NadhgKk6IT83Ctjm6DxukxIKSmhtuGeQcHUWF9K3QVy3G4tFWUhc
         JzKbsi8ZuT7/LIDFMgArP+MFtt3qw40Gvgb3c+rhC7PVUm5nstuLo+LqWm9w+9iOU9n3
         /4xA==
X-Gm-Message-State: AOJu0YwA05/MsD/D7He+hxcFzyXiMLbhDjg+jb1ZX4SwDey1JoGErked
        ovEl9R37e8kKONcJpgmwnHlsGJt8d7v3F+bma8y0rlBIPLlGZ461
X-Google-Smtp-Source: AGHT+IFgq88MRaTHmaB9J8NNC+BSZ2b2vgGjklcYDBiGTryencLrXHqw3v0z2CHQw9bfeLiZxgYwLYjzwO05rQCXNX8=
X-Received: by 2002:a05:6512:3904:b0:503:258f:fd1b with SMTP id
 a4-20020a056512390400b00503258ffd1bmr3749298lfu.18.1699864492911; Mon, 13 Nov
 2023 00:34:52 -0800 (PST)
MIME-Version: 1.0
From:   Keno Fischer <keno@juliahub.com>
Date:   Mon, 13 Nov 2023 03:34:16 -0500
Message-ID: <CABV8kRwx=92ntPW155ef=72z6gtS_NPQ9bRD=R1q_hx1p7wy=g@mail.gmail.com>
Subject: Incomplete stable drm/ast backport - screen freeze on boot
To:     stable@vger.kernel.org
Cc:     regressions@lists.linux.dev, sashal@kernel.org,
        tzimmermann@suse.de, jfalempe@redhat.com, airlied@redhat.com,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Greetings,

When connected to a remote machine via the BMC KVM functionality,
I am experiencing screen freezes on boot when using 6.5 stable,
but not master.

The BMC on the machine in question is an ASpeed AST2600.
A quick bisect shows the problematic commit to be 2fb9667
("drm/ast: report connection status on Display Port.").
This is commit f81bb0ac upstream.

I believe the problem is that the previous commit in the series
e329cb5 ("drm/ast: Add BMC virtual connector")
was not backported to the stable branch.
As a consequence, it appears that the more accurate DP state detection
is causing the kernel to believe that no display is connected,
even when the BMC's virtual display is in fact in use.
A cherry-pick of e329cb5 onto the stable branch resolves the issue.

Cheers,
Keno
