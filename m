Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD2778A3CB
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 03:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjH1BGx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 21:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjH1BGq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 21:06:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69406131
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 18:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693184754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/V5zkCsRDA+Gue7miMjMHK0pSH94dkxubU/DgbGWqtQ=;
        b=OG17NI0NCwLl9Iiv+XsDQYI43X8EKu+39lgxnqdIcLUn1xv6M5n4vT1Ce4UFiEICOpsaKd
        khdt0AihIQS9N/maPohx9jcwR1Al5Oibt9cfHzL9pO4pCKaCVlaZehjCKoyfjSVE3SFQnL
        S37dPVrtjmdUdMgyPGaucPaXfbgK1A4=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-BnWQSxiYO02zzrixbyVKKw-1; Sun, 27 Aug 2023 21:05:53 -0400
X-MC-Unique: BnWQSxiYO02zzrixbyVKKw-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-34bbcb7e17eso18029225ab.0
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 18:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693184752; x=1693789552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/V5zkCsRDA+Gue7miMjMHK0pSH94dkxubU/DgbGWqtQ=;
        b=P5iu8uqxeyq+NUFVnuCeRlW7I7kEFvubv0fnNwCv0C1ZN3ELPjttZuVZnNWo1hWB4h
         k9v7wbpA02ec9Z6t3rUBIAOSn9mNl66FhhAyBHJ77m7ICbph3sFbi+oCpuuaHyapFJqc
         pRsHyXZhjvzHrRHE6MVV1fVtXQUlIJm/DnyDuq5tpg5IQtqq1Kjk6TUepwTec/YcaZ5Q
         FZ1jQcNmOwhpFq1QXQuaxAW9meAvaYx2Ce159/yNgcj4uey5rlufk93aBjM/lzqfjwE4
         je7aO/45x3ku9mUuHkxYHGEqx/Hly1igIAz4rkqFrELoXm5uqB9Ehfuwj8ZVLalenAvM
         9VGQ==
X-Gm-Message-State: AOJu0YzlvF+YDuKxEcKlQ2DXbY+/6DjMf6SFhJeql63Fn5BWBbCQudiw
        S7/Kaet77QzfAs6QZug7iuHkxQye7to2MRFB2jqLPeDp9VnvAvodFNyIxqCDO4e53d/lN6TA06G
        bK+5fLeIqpgoFN8rC
X-Received: by 2002:a05:6e02:1bc3:b0:34c:cb72:32f7 with SMTP id x3-20020a056e021bc300b0034ccb7232f7mr15200949ilv.24.1693184752416;
        Sun, 27 Aug 2023 18:05:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBwlyJHli2Qu2Xz6/MKDcSTs2JPHM2rQb6JlupZKv5Ip5Isapx4Lhs3tCaLXGumwwptHqDEQ==
X-Received: by 2002:a05:6e02:1bc3:b0:34c:cb72:32f7 with SMTP id x3-20020a056e021bc300b0034ccb7232f7mr15200932ilv.24.1693184752204;
        Sun, 27 Aug 2023 18:05:52 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id t16-20020a639550000000b0056f8b44058csm5927641pgn.12.2023.08.27.18.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 18:05:51 -0700 (PDT)
Date:   Sun, 27 Aug 2023 18:05:50 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, stable@vger.kernel.org,
        Todd Brandt <todd.e.brandt@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tpm: Enable hwrng only for Pluton on AMD CPUs
Message-ID: <ct256e7tloa3th4muxmhgvysvod35c4vp2aczuybud3q6747ts@hglky2egrg7y>
References: <20230822231510.2263255-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822231510.2263255-1-jarkko@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 23, 2023 at 02:15:10AM +0300, Jarkko Sakkinen wrote:
> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG for
> all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On the
> reported systems the TPM doesn't reply at bootup and returns back the
> command code. This makes the TPM fail probe.
> 
> Since only Microsoft Pluton is the only known combination of AMD CPU and
> fTPM from other vendor, disable hwrng otherwise. In order to make sysadmin
> aware of this, print also info message to the klog.
> 
> Cc: stable@vger.kernel.org
> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217804
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v3:
> * Forgot to amend config flags.
> v2:
> * CONFIG_X86
> * Removed "Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>"
> * Removed "Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>"
> ---
>  drivers/char/tpm/tpm_crb.c | 33 ++++++++-------------------------
>  1 file changed, 8 insertions(+), 25 deletions(-)
> 

It looks like stable should be pinged as well. I saw a report yesterday for Fedora
where someone is seeing issue where the tpm device no longer shows up with
a 6.4.11 kernel. That kernel pulled in commit 554b841d4703. It pulled in a couple
other tpm commits, and there is practically no info in the bug at this point,
but I'm guessing the probe is failing due to 554b841d4703.


> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 65ff4d2fbe8d..ea085b14ab7c 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -463,28 +463,6 @@ static bool crb_req_canceled(struct tpm_chip *chip, u8 status)
>  	return (cancel & CRB_CANCEL_INVOKE) == CRB_CANCEL_INVOKE;
>  }
>  
> -static int crb_check_flags(struct tpm_chip *chip)
> -{
> -	u32 val;
> -	int ret;
> -
> -	ret = crb_request_locality(chip, 0);
> -	if (ret)
> -		return ret;
> -
> -	ret = tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL);
> -	if (ret)
> -		goto release;
> -
> -	if (val == 0x414D4400U /* AMD */)
> -		chip->flags |= TPM_CHIP_FLAG_HWRNG_DISABLED;
> -
> -release:
> -	crb_relinquish_locality(chip, 0);
> -
> -	return ret;
> -}
> -
>  static const struct tpm_class_ops tpm_crb = {
>  	.flags = TPM_OPS_AUTO_STARTUP,
>  	.status = crb_status,
> @@ -827,9 +805,14 @@ static int crb_acpi_add(struct acpi_device *device)
>  	if (rc)
>  		goto out;
>  
> -	rc = crb_check_flags(chip);
> -	if (rc)
> -		goto out;
> +#ifdef CONFIG_X86
> +	/* A quirk for https://www.amd.com/en/support/kb/faq/pa-410 */
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
> +	    priv->sm != ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
> +		dev_info(dev, "Disabling hwrng\n");
> +		chip->flags |= TPM_CHIP_FLAG_HWRNG_DISABLED;
> +	}
> +#endif /* CONFIG_X86 */
>  
>  	rc = tpm_chip_register(chip);
>  
> -- 
> 2.39.2
> 

