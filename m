Return-Path: <stable+bounces-100872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 079A49EE325
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 10:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE83F188758F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8CF20E30D;
	Thu, 12 Dec 2024 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hHx2qL0s"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B2C20E30C
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733996114; cv=none; b=DJ7ZZDfNQxsiSXDwHDf+4bIoTTNbmNXpLpxSemgm8WXMBWibDbyedmyWuee6ogd1+Zy8PSHPA5OTHmGAQyjXGPD52GwaG7UXsppSjb/Lii036NvIkJNDVJtU2B4Vu8/eNwPTAyTmW4Kpa0ibu0CJKJyeY2IFraLdBcMDmId/Ch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733996114; c=relaxed/simple;
	bh=Va7Rbm4URrvIDt/DyH6qR9FjFuQwl7M8B+lnkEdmojI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQN25ukvZr3zRvvqoWPT7ul2xEgnWxnixa+Pew70+m7Ze4YBcp2/NxGc/qxXYeo6VewMJSm4VVWSa8cofMeD7IOPchlOOEc75kA0sXIDAaVzGKO5gkXezybTAUrioL+TRnC/YU9pxhNenUhiL/zgcVei97XkrBbTYyr4I5PN4Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hHx2qL0s; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361d5dcf5bso3979275e9.3
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 01:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733996111; x=1734600911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8c4l7lRS2bRhcX4yC4do8L3ZZ1P+9nyFTMOBopT/2GQ=;
        b=hHx2qL0suimF4/i617UkBK/fOS+3VIjXHioNBPzo2FTACMU0te/AISNnmEBiYSvhTi
         W1Lt/ZM4DNHJ7nMKmsRXmY2gaeHSnOe9Y2PqMulfcUUPUAtWNK8yidCZ6GcTq0h9jM/C
         IdboEt/kEufShJmTCrLPpNNF0vYtui6LabZjeiqKbJ3kshEpWosjhV3tSVKs3W0sagMU
         r/8DJKX5/ebUtPBFMikYwyFs8iGC+nP9DVpkiHdUnKVqpdeV7s+Rnyv2zbmQMU9d9wF0
         nQKmjGCC/d4ixSCqab8FwrUC+zlKOWuWAWlaLlkoE3+K63E1NrmzROV1cVxcaRNn0l/Y
         uhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733996111; x=1734600911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8c4l7lRS2bRhcX4yC4do8L3ZZ1P+9nyFTMOBopT/2GQ=;
        b=h+uOzMUXkQTCJ6JFd5k5jQESsQCX1o3X0fJvDOc0j/p+R54wUuWxGT9EHCoNvOch4L
         WXpEAyJ1C0le6r2S9KlxRW5favSb/G3whKa1ssQYVccPIGi8tVQyNufspj27rwmUJyWC
         uGpWCStr6tVXVYD2LPctBAsuXe8PpP/blkT4eTI1Ub05X7o2uWSEeW3Zup5yQsvMxQhy
         olY4ef+sNJqKvslitbUdFRyhrEfDEiD6siX324cGXNrhIRh/jVPSEgWUrQMY87kbPa8o
         hFKxxswM7l0SLaY0stcKC5CEsLLmNnIeQHdHHFPl3zOydbrJQdyInvYpjl+JkAs88IiN
         hIEA==
X-Forwarded-Encrypted: i=1; AJvYcCVQmSmQg7nCRAPZgWZ2l1fe1I4UzbmTByqlssE0YTZgxIMcUQaUVHNrm87eFrJdzzyZUc8vfpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLtHi/pfEa+aI5nZkJU1pf9IeletmKC7oLs9Zl7JjrkTZK13lQ
	T6aylhppBx3xLcg33+agqdYWgt8S0N1xaPA/xGSGC+1hrq1NXCRDIlcnqtiuCmU=
X-Gm-Gg: ASbGncuaQ+f+p/2+NVhCtK0jOKTDlOES6RNzagxorSEe6T8j8xnJjzCdZ+rLuXiss/M
	fLM3Rbye08hgdXUy6TXIEGgzXjmCwrEh2ocYUtk7iCVzAicw9Amh25OdlFHbCNhrJNoZCIDNGAV
	GVn83Ka+5Nsm900SfTnLYvbNEbblKx8ckbt4k+biYKY1PcmJIUZECAoZpxe+hdb3glHlNCaQLSI
	fNZ8HRdybn0hXk959/eXMMcNnM8GgJNKBxaejZwGLIVl30qYunhSauPHEHMHw==
X-Google-Smtp-Source: AGHT+IGized2vRZ+5/jSNeWf5x91CH3k8LiPPRqNJnZVzhvP9p1wXolywFcegCjc1TiC1IePEY+Hsw==
X-Received: by 2002:a05:600c:3548:b0:435:40be:3949 with SMTP id 5b1f17b1804b1-43622844ab5mr24401495e9.16.1733996111444;
        Thu, 12 Dec 2024 01:35:11 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559eedcsm10990545e9.23.2024.12.12.01.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 01:35:10 -0800 (PST)
Date: Thu, 12 Dec 2024 12:35:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Wei Yongjun <weiyongjun1@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
	stable@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH v3 0/3] PCI: endpoint: fix bug for 2 APIs and simplify 1
 API
Message-ID: <1fac71d8-dcfe-4924-ab01-dc85a822b740@stanley.mountain>
References: <20241210-pci-epc-core_fix-v3-0-4d86dd573e4b@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-pci-epc-core_fix-v3-0-4d86dd573e4b@quicinc.com>

On Tue, Dec 10, 2024 at 10:00:17PM +0800, Zijun Hu wrote:
> This patch series is to fix bug for APIs
> - devm_pci_epc_destroy().
> - pci_epf_remove_vepf().
> 
> and simplify APIs below:
> - pci_epc_get().
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---

This is very good.  This is Config FS.  Is there a kself test for configfs
or did you create your own test?

regards,
dan carpenter



