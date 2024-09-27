Return-Path: <stable+bounces-78117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1139886C2
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 16:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730B1281C3F
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7502313E41D;
	Fri, 27 Sep 2024 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwqcONzS"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7CB13AD1C
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446499; cv=none; b=EEc2xFdt983AWwLKfgq1xJG3ucF+5YCM5PCqO1MYofUDmz3pgnjRD4Nk//p3VUNUeqyFxmwBYHl6+yONXIA0ALZiL8RFsAymVZVc66795dOSgKjtv+skiO3FBH0zo+0+TTbziBNaMXbNMt/7wMMYXfZWS44Ugw5NVcEyCvq/kLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446499; c=relaxed/simple;
	bh=z6l6UqJVlIxyrSLPMV0t2YGZ65osw5mRdjxCX5dDdgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPvJmDJerhs0RvO01Sdvmj2sNqlSOQs0hnVrkWoil9V6Nr/1WnPyX+K9eX1PcUNvVqvPdXU6MEDouVZom6mWYeUv1wB1/pw0/hfKhUX6ac3pzuCAKvnYDXGBFPWGHQXN5XuvCs+I2I2vyS+GxSyIV7nAQOg2VS0Mg3J8K4tu2q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwqcONzS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727446496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuxftadAjWerGEbrKESG5hKgBBRqoRGlsTRV5Tuc8Mw=;
	b=iwqcONzSe0vI8+IzjTZeGvZhLa42S+7fx087I8QrMOIETWT1wBi9Ki1FIMad1+E7FilC5Z
	q7nTGcHliJDIv/crR7M4Wba9xVIke65lxfl1xz74zzbmtSZbJOGEVpgV5AL0q/Jyp+WwV0
	sjfrSOoNH/Spw84YEdl/IwyyQ3qq81U=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-zkUp_FpyNxq4Eak1yQ-QCw-1; Fri, 27 Sep 2024 10:14:55 -0400
X-MC-Unique: zkUp_FpyNxq4Eak1yQ-QCw-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82d40afd0ddso234305639f.0
        for <stable@vger.kernel.org>; Fri, 27 Sep 2024 07:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727446495; x=1728051295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuxftadAjWerGEbrKESG5hKgBBRqoRGlsTRV5Tuc8Mw=;
        b=wcIqPTelRTlpGEsxWqopyi5GrpQ6AUf0b6U/Q0p7V1bqk2xQx5jYbTGNMPNGzaLhdr
         5yDJfrYEQwcPz6IH+GjF05b0dd/Sovq0e4omDqVvQ1TjW0cJWOpy9rTEaJCyLFdMD8NZ
         3GzNPNEtROmD4V7tPv1mF79B1/Pxnjus87FNSlH409UbaW/C82XuvtSLRuLkku9XkqtQ
         8gyqazgsUd0oTS1+sr2bBrpt2uB3oTlyU0n+L+n8z+JRCyqDFqzOUNZ0CGUN+0D47Qa2
         YJM4xfhGFKZr13VbqSA48nyYa4DY9PXr7sp/PyOxkbgoTGlwwytTo7dB/u3gzYg4Ndvp
         cb5A==
X-Forwarded-Encrypted: i=1; AJvYcCVVdMXQyOBvHrOH3DZmElvryyIPQVph8H23hQUPVzAvzufz8Opt8PHAMC/MfQRx63/IYuI5EuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3yyvnCrk/oBAgw2shPtKA7aG0s+L+PBBGZkcMWW7HheI9tL1l
	5qcoNALrARPwxzYt71Fce3/oDxEse54/vpYMgNoaPOSDraqcLHrJolRcRfMoXYKlffawQh3k13u
	flX436DNR2hnyEsVAZwLcjdyhkzGZzAgrjv6a5oTvEmGGZfZ6cxy8Uw==
X-Received: by 2002:a05:6e02:12c8:b0:3a0:979d:843 with SMTP id e9e14a558f8ab-3a345169b59mr26012505ab.9.1727446494849;
        Fri, 27 Sep 2024 07:14:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9L1s5XILx2Fi8g1dF/McVkrc/4jfVxHJ46gx4GxhnzEkRstMhOJ+Xc6ay0/qaRv9g/z1i8g==
X-Received: by 2002:a05:6e02:12c8:b0:3a0:979d:843 with SMTP id e9e14a558f8ab-3a345169b59mr26012205ab.9.1727446494513;
        Fri, 27 Sep 2024 07:14:54 -0700 (PDT)
Received: from [10.0.0.71] (67-4-202-127.mpls.qwest.net. [67.4.202.127])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344d60530sm6043725ab.18.2024.09.27.07.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 07:14:54 -0700 (PDT)
Message-ID: <fbe9ed47-b3cc-4c51-8d25-f44838327f89@redhat.com>
Date: Fri, 27 Sep 2024 09:14:52 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ext4: fix off by one issue in alloc_flex_gd()
To: libaokun@huaweicloud.com, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 Baokun Li <libaokun1@huawei.com>,
 Wesley Hershberger <wesley.hershberger@canonical.com>,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
 stable@vger.kernel.org
References: <20240927133329.1015041-1-libaokun@huaweicloud.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20240927133329.1015041-1-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/27/24 8:33 AM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 

...

> Delete the problematic plus 1 to fix the issue, and add a WARN_ON_ONCE()
> to prevent the issue from happening again.
> 
> Reported-by: Wesley Hershberger <wesley.hershberger@canonical.com>
> Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2081231
> Reported-by: Stéphane Graber <stgraber@stgraber.org>
> Closes: https://lore.kernel.org/all/20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com/
> Tested-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Tested-by: Eric Sandeen <sandeen@redhat.com>

The patch has changed a little since I tested, but it still passes my testcase
(as expected, no WARN ON etc) so looks good from that POV, thanks!
-Eric


