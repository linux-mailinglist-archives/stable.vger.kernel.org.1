Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7487CA53C
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 12:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjJPKXM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 06:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbjJPKXJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 06:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1DDDC
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 03:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697451739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gp85qeDzi8U6mzQo/nR8ijZYIV2Eq5Pjoam1JtOSHss=;
        b=g3noSIbf4LV9xTzlxYysJTe7Ng6pxcSOv3jZlJ3pdtDgOg37V/51W6b2AxLKDENPSadiQs
        VVRHlJtCqKPDB21yk5mqJAHJ9+MFhbx4BILyvUPGBU362LH0wQXTUtuya96/IbCaAKxnCd
        9cQQ0PS7q8hUM6SDd43KkFum9bFbBh0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-h-W3vzpeMdKFPh6URwBJYw-1; Mon, 16 Oct 2023 06:22:18 -0400
X-MC-Unique: h-W3vzpeMdKFPh6URwBJYw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6936a25f49bso3915041b3a.1
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 03:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697451737; x=1698056537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gp85qeDzi8U6mzQo/nR8ijZYIV2Eq5Pjoam1JtOSHss=;
        b=hHxIhkTOpj438UM2CkQlv5xS87JU0dQzeiE2Y9f8kqv1zFXLiPseqA13vDxeKJcnrj
         zrfrinQrBWw+6m7szAHFVBvuKlkE26+8pxUBfQaGwxp6t+JapwP68H4JR5dFil0uIwYL
         mOF/b3DfBa1hsVdw1r60joGsSmj20fi0womkAweDNNrWQiZbWROJi8ZMgaLCSw5UjyPC
         I2aOu3vYsXDCQx0qcOLlJPa5aT8N6HvW42WxfnAljrlLYqFWgPgX+S/3UGUi6Q1+JagK
         hD5+UX7sho7IZVlH2O7H9phjbgLKfSVV3+NsNvexvZYoHOGJQN76m/JNUW14RO828ygM
         tAiw==
X-Gm-Message-State: AOJu0YyPrQKB8qg1GCdATCf5a0huW2DHY29P/IipalQ8khMYWIqeBbGj
        0D64ZOJigLfiqLNXntxa7XY7hGi+qKa86dpFurc6dPrA2duCfEw4/bOSNxsprT/oTI8kQ3lDheI
        DDKdUZtna+TKvi75z93vJ7qs84GTHLgrn
X-Received: by 2002:a05:6a21:819c:b0:169:535f:2687 with SMTP id pd28-20020a056a21819c00b00169535f2687mr29186289pzb.49.1697451737404;
        Mon, 16 Oct 2023 03:22:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6NFZbUqAnxzUeRwXsjJ2wD+9lzj4oz8AbfJAYlMT5H+FPNWTMEdzeJdUlW0ZcPPLf3ZC6bpKJ5qo+m110tjE=
X-Received: by 2002:a05:6a21:819c:b0:169:535f:2687 with SMTP id
 pd28-20020a056a21819c00b00169535f2687mr29186286pzb.49.1697451737127; Mon, 16
 Oct 2023 03:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231016-bt-bcm4377-quirk-broken-le-coded-v1-1-52ea69d3c979@jannau.net>
In-Reply-To: <20231016-bt-bcm4377-quirk-broken-le-coded-v1-1-52ea69d3c979@jannau.net>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Mon, 16 Oct 2023 11:21:41 +0100
Message-ID: <CAOgh=Fxn7Ga7p-FaP-ef=+F1MTFWs-5OOna9piJa-nFcCwe=NA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm4377: Mark bcm4378/bcm4387 as BROKEN_LE_CODED
To:     j@jannau.net
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 16 Oct 2023 at 08:21, Janne Grunau via B4 Relay
<devnull+j.jannau.net@kernel.org> wrote:
>
> From: Janne Grunau <j@jannau.net>
>
> bcm4378 and bcm4387 claim to support LE Coded PHY but fail to pair
> (reliably) with BLE devices if it is enabled.
> On bcm4378 pairing usually succeeds after 2-3 tries. On bcm4387
> pairing appears to be completely broken.
>
> Cc: stable@vger.kernel.org # 6.4.y+
> Link: https://discussion.fedoraproject.org/t/mx-master-3-bluetooth-mouse-doesnt-connect/87072/33
> Link: https://github.com/AsahiLinux/linux/issues/177
> Fixes: 288c90224eec ("Bluetooth: Enable all supported LE PHY by default")
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

>  drivers/bluetooth/hci_bcm4377.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
> index 19ad0e788646..a61757835695 100644
> --- a/drivers/bluetooth/hci_bcm4377.c
> +++ b/drivers/bluetooth/hci_bcm4377.c
> @@ -512,6 +512,7 @@ struct bcm4377_hw {
>         unsigned long disable_aspm : 1;
>         unsigned long broken_ext_scan : 1;
>         unsigned long broken_mws_transport_config : 1;
> +       unsigned long broken_le_coded : 1;
>
>         int (*send_calibration)(struct bcm4377_data *bcm4377);
>         int (*send_ptb)(struct bcm4377_data *bcm4377,
> @@ -2372,6 +2373,8 @@ static int bcm4377_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>                 set_bit(HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG, &hdev->quirks);
>         if (bcm4377->hw->broken_ext_scan)
>                 set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
> +       if (bcm4377->hw->broken_le_coded)
> +               set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
>
>         pci_set_drvdata(pdev, bcm4377);
>         hci_set_drvdata(hdev, bcm4377);
> @@ -2461,6 +2464,7 @@ static const struct bcm4377_hw bcm4377_hw_variants[] = {
>                 .bar0_core2_window2 = 0x18107000,
>                 .has_bar0_core2_window2 = true,
>                 .broken_mws_transport_config = true,
> +               .broken_le_coded = true,
>                 .send_calibration = bcm4378_send_calibration,
>                 .send_ptb = bcm4378_send_ptb,
>         },
> @@ -2474,6 +2478,7 @@ static const struct bcm4377_hw bcm4377_hw_variants[] = {
>                 .has_bar0_core2_window2 = true,
>                 .clear_pciecfg_subsystem_ctrl_bit19 = true,
>                 .broken_mws_transport_config = true,
> +               .broken_le_coded = true,
>                 .send_calibration = bcm4387_send_calibration,
>                 .send_ptb = bcm4378_send_ptb,
>         },
>
> ---
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> change-id: 20231016-bt-bcm4377-quirk-broken-le-coded-599688e3c4a0
>
> Best regards,
> --
> Janne Grunau <j@jannau.net>
>
>

