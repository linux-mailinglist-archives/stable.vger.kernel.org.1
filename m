Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3285E7B3301
	for <lists+stable@lfdr.de>; Fri, 29 Sep 2023 15:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjI2NAv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 29 Sep 2023 09:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjI2NAt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 29 Sep 2023 09:00:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643471A4
        for <stable@vger.kernel.org>; Fri, 29 Sep 2023 06:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695992401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fkolkQYQP8wA78QWjAn3k7nmXFE7e3GBg0yVcUVtpGY=;
        b=Ut4STMkt5ezKKN/Zzch8H2QnJRN6vEBVYvu0Xwnup7aFTW9BnOkYJoChDXPbWP2PVrcj4H
        fdFHWjw7HL2gdPFjO3ILxxNBE7E01sCALLoVUpnUCiEa1rXWZVYCF+j8s0FUsWMqt9MjJG
        mzW4efvnZ+JSxciKs/Rfk926EfRGcO8=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-vzJponn-NSy6qH_rf_f9qw-1; Fri, 29 Sep 2023 09:00:00 -0400
X-MC-Unique: vzJponn-NSy6qH_rf_f9qw-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6c0d445555eso28922222a34.0
        for <stable@vger.kernel.org>; Fri, 29 Sep 2023 05:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695992399; x=1696597199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkolkQYQP8wA78QWjAn3k7nmXFE7e3GBg0yVcUVtpGY=;
        b=VlFtRcxiT06gnLzpksPGwrNaWyFrlQHYTJ12ZD+hNJ28Ot890lXk+OSSEeGaZCY9yg
         TxgWrBYdgRvTOnQ5gSmogVuKQVanK/W7TgWdGJIqrk5jQeCRe6PG7NH/4gXHvXGI00Er
         o/QEIM8G0DifJUuSEG0QRvI3Fls+H5L4No1IZpE9FtpUPQ7kmyB8VO9IaPKKXyOvQJXt
         mEQgL2HQOVNIenaaiRE5YlIlEAM/OBC8Pvkdcd6ECFnAfnNxSZFBrp6SDCFE83nKPTa4
         uAUmB96cMwEMG+MsWTAkVMZReJYSfoxIv7SX/hHvF/egC/hxhSbztIIn/yfSE3yWBEaO
         +yZQ==
X-Gm-Message-State: AOJu0YyIMFy2TuVBkOAAlUmCgsoQ60A43w7Sf3OxlMLmfV5C4+Z4hk6M
        OP3uONdrzmErNbNGuoWjDstv4/ksE9jIrT6siuhrbJ2IVpbaYycflcOI0d9J5cxwvzizqw57Tkl
        viZTS86t5PbRVdCkz
X-Received: by 2002:a9d:74d9:0:b0:6c4:897a:31d0 with SMTP id a25-20020a9d74d9000000b006c4897a31d0mr4253074otl.24.1695992399387;
        Fri, 29 Sep 2023 05:59:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLY5DCnpt7G3mwAyMbr7IKILwUmspq5W5zRmjj7YDnrzd1R0IGknP2GqFr/Hqk98SQpW2BwA==
X-Received: by 2002:a9d:74d9:0:b0:6c4:897a:31d0 with SMTP id a25-20020a9d74d9000000b006c4897a31d0mr4253053otl.24.1695992399064;
        Fri, 29 Sep 2023 05:59:59 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::42])
        by smtp.gmail.com with ESMTPSA id d1-20020a9d5e01000000b006b90b5626desm2996566oti.62.2023.09.29.05.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 05:59:58 -0700 (PDT)
Date:   Fri, 29 Sep 2023 07:59:56 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] power: supply: qcom_battmgr: fix enable request
 endianness
Message-ID: <20230929125956.hpcze2brit3ew3et@halaney-x13s>
References: <20230929101649.20206-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929101649.20206-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 29, 2023 at 12:16:49PM +0200, Johan Hovold wrote:
> Add the missing endianness conversion when sending the enable request so
> that the driver will work also on a hypothetical big-endian machine.
> 
> This issue was reported by sparse.
> 
> Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
> Cc: stable@vger.kernel.org      # 6.3
> Cc: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

