Return-Path: <stable+bounces-86993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AB79A5A29
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 08:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 637DEB20FA0
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 06:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C5C192D98;
	Mon, 21 Oct 2024 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qmxsljzf"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4F31EEF9;
	Mon, 21 Oct 2024 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729490876; cv=none; b=flYJT479WlrQW1jTLxS6wHjdQimNFD7q5QZn3UekZ2HWaVt0K1dorwADPqUEpjZ78xPgpywbeCrywwRH2y90HD6jyr5wp/6AdU0yWvFfb8aC8+rYoVDErMTA3rRg+tjDmzO9203JJATLyTXyt3M5/L9yoGCBnMhQHNOSu0G6gEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729490876; c=relaxed/simple;
	bh=qXsYb9SX8s/L/zEPUt4/xo8MTk2kBkfL88O19nPRdm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVQHzquT8t6fepvI3yFXm8SNZzs63s/YHF7e5b3y+kjd6H/2nXUxNXs/Lzr0krTDTEQTbmQIc5uTTnWvldw/svo8zNAVFF1sj3xOFnElibe6ahqSqUuVs4M4bYaHjbuZykEsUvD+V2rG/1PZI836387WYXJN4+EUwCOJ88A/A7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qmxsljzf; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-288d4da7221so1927891fac.1;
        Sun, 20 Oct 2024 23:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729490873; x=1730095673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FsHV1DeqWJoj2ZcYbTpaphYAWXw5LJS8G2+p8MKU1jM=;
        b=QmxsljzfKBpfeDxzxFV7x/IG+vAWTFTIfk0z3ZA+cLb5+TKVppQXp9r9mBkagKSeFL
         QbfUozXIwVDY682y/04YZwUS79uvRoYT0IkWyA1fwqCRKl9GQ++AkitnFCpSsXz9ZGRi
         gRnnZKIwYkCoKwaKoTz3cDjxmxpfxFtgRosU+cHJbl5IThmPlTUaYeK5ia+KBeL+msK0
         MQzKe/mCTTJ3QKZEXMHPCKkTXobBhQOVy8UL/myPtm7IkKQz9Dr3I+wK7gUZq8CcmbHa
         qDZ4WB+9gda6Cx7CjWcit9JKEpP2FXZ32/4CimN1QL/tdVseF1JtqQ7EknmhaT0s4htL
         v4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729490873; x=1730095673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsHV1DeqWJoj2ZcYbTpaphYAWXw5LJS8G2+p8MKU1jM=;
        b=svsDG3lvm6aE3wpXCBVK2mMlAXMmTWouPiU+On1dymUq+oVY5Bvk0dAbCayK0R82JY
         dK8xlRQXtYtnC03OzbiHvuQfwszca0KIClhgWsEGieKoiO3DYuy30EHNy/rfRzKREoi7
         QT021keblA9c4Y5SsEVXqh0d0JIbOcCj9EpxryZRz180XZSAspPABV3/SAMQDMUwtWBm
         8Q/pZUgRZ9PYinlBM65vqQU9+K0Dkhpb3nyIiOo4Tmgu0vNvFFkZWj/d9PSNw3kC8VnU
         pNCCYY3DzZk3KI10fX8v6qbK8j7AOFFHyk2rGRTnxsDg4v74OyhaDwUIBQkuZotGKxFW
         hwKw==
X-Forwarded-Encrypted: i=1; AJvYcCVuKAiRL/NG/3nfEYdNOIlyMQOh9zhsFLyn8JwHOZk8adJq9gTNViKon/n7kPkjSWddU4xo3YAJ@vger.kernel.org, AJvYcCXgWwTdmQPjS6Eah9mBPmyI8+h0FaMG2wP4lH0ZZvTrpLpv8ykZNPcTm1IXEmZOJPkI8s8Ni4AxHVAM@vger.kernel.org, AJvYcCXqaw6i8vNC8ohKsWdbm9+hpYPTDRqP8qJskAPkEnlCFvFhW1C2YiyCWvNvQqI7yDw2n3n6JeC8tF7N2U8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo6JmeacN/zth57b1eeEC/cJeUtYp8Jkdq6hFlF+I+ZcG9aW1d
	aMKLXULrmBEmqWBvi3cYacWaBlQth5X8cM1FTjuAg3UC83LuPe7iNr/kUyyn25W+tf5a+vEBScF
	vaiXj1OLdZ4bscGzhPHMBUH31Yc3F0A==
X-Google-Smtp-Source: AGHT+IHpPFqsJuCvsJFqshBiSlkp52VkseK6tb4r+rc6MrPKp4rcWkL3ThHr5jpGe6dSRrP2Uk6AQnrmJjxXvN8NsHg=
X-Received: by 2002:a05:6870:6394:b0:270:1b79:ccbc with SMTP id
 586e51a60fabf-2892c24db1bmr7442706fac.5.1729490872798; Sun, 20 Oct 2024
 23:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020142931.138277-1-aurelien@aurel32.net>
In-Reply-To: <20241020142931.138277-1-aurelien@aurel32.net>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 21 Oct 2024 11:37:37 +0530
Message-ID: <CANAwSgR1ks_L94QPSCOsL4ATX=3HA59LHK1GdJTctUsM_f_DuQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: take SWIOTLB memory size limitation into account
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: William Qiu <william.qiu@starfivetech.com>, 
	"open list:RISC-V MISC SOC SUPPORT" <linux-riscv@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
	"open list:SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER" <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Ron Economos <re@w6rz.net>, Jing Luo <jing@jing.rocks>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Aurelien,

On Sun, 20 Oct 2024 at 20:01, Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> The Synopsys DesignWare mmc controller on the JH7110 SoC
> (dw_mmc-starfive.c driver) is using a 32-bit IDMAC address bus width,
> and thus requires the use of SWIOTLB.
>
> The commit 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages
> bigger than 4K") increased the max_seq_size, even for 4K pages, causing
> "swiotlb buffer is full" to happen because swiotlb can only handle a
> memory size up to 256kB only.
>
> Fix the issue, by making sure the dw_mmc driver doesn't use segments
> bigger than what SWIOTLB can handle.
>
> Reported-by: Ron Economos <re@w6rz.net>
> Reported-by: Jing Luo <jing@jing.rocks>
> Fixes: 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
Please add my

Tested-by: Anand Moon <linux.amoon@gmail.com>

Thanks for fixing the warning below.

[  511.837216][  T148] dwmmc_starfive 16020000.mmc: swiotlb buffer is
full (sz: 290816 bytes), total 65536 (slots), used 246 (slots)
[  511.837423][    C0] dwmmc_starfive 16020000.mmc: swiotlb buffer is
full (sz: 278528 bytes), total 65536 (slots), used 222 (slots)
[  511.916951][    C0] dwmmc_starfive 16020000.mmc: swiotlb buffer is
full (sz: 290816 bytes), total 65536 (slots), used 24 (slots)
[  516.803916][  T575] dwmmc_starfive 16020000.mmc: swiotlb buffer is
full (sz: 507904 bytes), total 65536 (slots), used 122 (slots)
[  516.805450][    C0] dwmmc_starfive 16020000.mmc: swiotlb buffer is
full (sz: 507904 bytes), total 65536 (slots), used 364 (slots)

Thanks
-Anand

>  drivers/mmc/host/dw_mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 41e451235f637..dc0d6201f7b73 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2958,7 +2958,8 @@ static int dw_mci_init_slot(struct dw_mci *host)
>                 mmc->max_segs = host->ring_size;
>                 mmc->max_blk_size = 65535;
>                 mmc->max_req_size = DW_MCI_DESC_DATA_LENGTH * host->ring_size;
> -               mmc->max_seg_size = mmc->max_req_size;
> +               mmc->max_seg_size =
> +                   min_t(size_t, mmc->max_req_size, dma_max_mapping_size(host->dev));
>                 mmc->max_blk_count = mmc->max_req_size / 512;
>         } else if (host->use_dma == TRANS_MODE_EDMAC) {
>                 mmc->max_segs = 64;
> --
> 2.45.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

