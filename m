Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42417741778
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 19:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjF1Rvh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 13:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjF1Rvg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 13:51:36 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928E42123
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 10:51:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8303cd32aso1505495ad.2
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 10:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687974695; x=1690566695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Na6wbo2C6aZoJR9rArIrRD0H3fmD8LNX5u5EBRrSJvE=;
        b=G2QAokd6dY2PkUi0fC/2DH4ukUqdVpFiSHyylIErz3gCFT0crmjp97kh25QtX6+s/K
         MuDZqV4Hnfw3KTp0bTlR9Q1r+lsC5KlyDY6S4AAjpD14iV/pFM5niWN4wb3N3bssDfH+
         Pcl0yjndBA+V2yrpVGiONXHAwPfdCUF9hgu2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687974695; x=1690566695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Na6wbo2C6aZoJR9rArIrRD0H3fmD8LNX5u5EBRrSJvE=;
        b=GU/uC6fBnzDmCzi/gUVFR7AxzErm5yfiWxPyeHOL0woN2/8FfvNttpkBhf+6QKUcq5
         y80/ReeQ+Tg3Ks8sXMTqINhfcOQMnipIOIlPXS6Uq7C/6iUzp/LZfQ/Cj2CjrAUUii29
         +c5tk0ljUfpfkWnfA6o+MJkuWKIA0I7hl8RSkhJDXKpH82gF9WLQbxxls4zHw0TZdeKG
         U14x3h3RWpAbCFw2/wkA02pEz5GJ2qop3DsebBw0a7v1JbFVUS0oIHk4kkCU5lUrnJNs
         JcVuQlVkgNItDXDCIuzdvQYlShnngNZAiO3sSgIvTaZ9n1t1B0XhKXvt2DM0VLnW/nwL
         pdaw==
X-Gm-Message-State: AC+VfDwBNT2XdKrXSWVi6EWiCo8TL5i6tQSwRaQszc2Z7j3qb7RR5s3q
        VYbmtLIrT6RypqfXZlazTzhFEw==
X-Google-Smtp-Source: ACHHUZ63L9QbPfTdUQ6qSD2HU+s2JHZnlPcbunw6wounkGXlQH24tFhd3uE8uPfzqtWHgRWnVYh8wA==
X-Received: by 2002:a17:903:24d:b0:1b6:9b38:6004 with SMTP id j13-20020a170903024d00b001b69b386004mr16700746plh.22.1687974695060;
        Wed, 28 Jun 2023 10:51:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001b843593e48sm1326552plg.228.2023.06.28.10.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 10:51:33 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dm: verity-loadpin: Add NULL pointer check for 'bdev' parameter
Date:   Wed, 28 Jun 2023 10:51:29 -0700
Message-Id: <168797468756.1160226.11804940754677813929.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230627202800.1.Id63f7f59536d20f1ab83e1abdc1fda1471c7d031@changeid>
References: <20230627202800.1.Id63f7f59536d20f1ab83e1abdc1fda1471c7d031@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On Tue, 27 Jun 2023 20:28:01 +0000, Matthias Kaehlcke wrote:
> Add a NULL check for the 'bdev' parameter of
> dm_verity_loadpin_is_bdev_trusted(). The function is called
> by loadpin_check(), which passes the block device that
> corresponds to the super block of the file system from which
> a file is being loaded. Generally a super_block structure has
> an associated block device, however that is not always the
> case (e.g. tmpfs).
> 
> [...]

Applied, thanks!

[1/1] dm: verity-loadpin: Add NULL pointer check for 'bdev' parameter
      https://git.kernel.org/kees/c/47f04616f2c9

Best regards,
-- 
Kees Cook

