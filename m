Return-Path: <stable+bounces-109285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB77A13D8F
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 16:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36943164960
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 15:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021F122B8B4;
	Thu, 16 Jan 2025 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NH8912f1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0011122A80B
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041003; cv=none; b=cH3PJt12ELDEZjOKoi1t19TDstKoAn9nXgbaSIZ+p2ql5cgyzIAuMUEPO7VTKB0XvhFQ9Mlc9vuC0g1QZLPaMcg6wactr75gLsOaN+A3se5t/KBxHPpE7cN0+bL0h5dCMHEA9jNKnbprpYcUUB3Bsdshf1TTauHUyqrdM2oa9hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041003; c=relaxed/simple;
	bh=wOYJydZ05zexni5iCmfbSnSKDO8udCBwJm1DUOZXF3o=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=nIr8mzibg4HsOFUPKk/0YBC1zpiKEipOE6BbMcTeTPeC7+cahTU2ek/85xNgc4OksTTNwU2MG5QF7LQRq9CbSQL/YURgXXbC3gMoIf0V/471qUC6P/SrDOGE1iAIrmLVLtQE9aNI9V0RpoW+dMJpfZuTv9gbDI9W6J56paKl7cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NH8912f1; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaecf50578eso238757566b.2
        for <stable@vger.kernel.org>; Thu, 16 Jan 2025 07:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737040999; x=1737645799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3t6OHZijaEdtQho17KfYpalcxu3KfEafC4rmSzrPeQ4=;
        b=NH8912f1Pi3udf+12n0TL4K/vPDE2DttHNlZDb0kkXlpZJag+sP/yx5zRFsSdRKY15
         hH+mC7vK0mX7hW2VRwIq11Aoyl5PXrmJSMqOGSAEBslEbRfr0QXas5QyhS00DfZQR3oM
         fsfl+v+pRz19hMJ9JmXFvgXhHdoHwe0GgBk0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737040999; x=1737645799;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3t6OHZijaEdtQho17KfYpalcxu3KfEafC4rmSzrPeQ4=;
        b=nD9Aa2VKLwo49ZtFF0MZQckQFJGWSTp7/vcDVO1Po/vxltlLqiRkmizMyL+ijFQZk/
         NB2SiK/LpKPraj0qWSWPEkStWzorTVYxd+NX/dwOdlFZUdzQWxz6K/xOTJJ54H3GPGwd
         7unCF6WvUlSNO79ZnzxaGx61Lt+AFXxLST9FWaZa47YyhtRf6DRzXybJVMO/bzPdrW6f
         kKuF3T3BaSal6O6srQvQCxMRuQcQDawEZJK1Thr2lECm8U7r23e8jTm75CfHeDZZ28Nx
         WReGZk3y15ItR59Nltv3cZIUem644qT1XzL5Qp8EnF7Rr+HSrlmaH9/uZmwbhqajuacK
         JbJw==
X-Forwarded-Encrypted: i=1; AJvYcCWZuUcyH8Tgjzljq68W/xlvTADM8wrKWbmO1EZ1T7yFXnruZTKiC2Al1E/PKLIPZILyp22092g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4SWLSh136/p4NDvESuyjHOKQYXkLlgcDGMRRymFQuoLyrWuMk
	TwLDxHmmmntJpP1k5W3TeNafgvx9Ho+xwPdm9Mb3WrRO6K2jNGTROd6/EhPf6w==
X-Gm-Gg: ASbGncvAjwu24rGZgTAUTclq27l3Loi1NN2UoQZSox8jTbbDaMqcK2wiaN/diwWEPvc
	ML7crRRqRdjVGxG/ah/Ddi2g2oMV6ajDrCCgn093digyjCKvOf04YJVXezz920sdS6+LwzLDcSD
	YMMLLCStqpc3q35HkQaTI1NO7ZrZO2zqIewuelVKgNPe7DmQBkmK7gSPAXP5xMNKE+GnBrTVtc+
	4JywkeXlO0pxK5stQWJT5zTuB3fixp4d7beKflq10e/ybilvoSlBCXV2PZ+veLfyxooVfLbE2DA
	plQgEiPR8cjY38LIyKc=
X-Google-Smtp-Source: AGHT+IESZHCMVm/ihlphauAy9omKbUvnYD/SIOp2AGMrCDzz4cC6qEyYek2Bns5dZEV3bLMLeDlScg==
X-Received: by 2002:a17:907:2cc4:b0:aae:ec01:2de4 with SMTP id a640c23a62f3a-ab2ab5f52efmr3024980066b.30.1737040999293;
        Thu, 16 Jan 2025 07:23:19 -0800 (PST)
Received: from [192.168.178.74] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce1914sm10348766b.57.2025.01.16.07.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 07:23:18 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Marcel Hamer <marcel.hamer@windriver.com>
CC: Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>, <stable@vger.kernel.org>
Date: Thu, 16 Jan 2025 16:23:18 +0100
Message-ID: <1946fb62e70.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20250116132240.731039-1-marcel.hamer@windriver.com>
References: <20250116132240.731039-1-marcel.hamer@windriver.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH v3] wifi: brcmfmac: fix NULL pointer dereference in brcmf_txfinalize()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On January 16, 2025 2:22:55 PM Marcel Hamer <marcel.hamer@windriver.com> wrote:

> On removal of the device or unloading of the kernel module a potential NULL
> pointer dereference occurs.
>
> The following sequence deletes the interface:
>
>  brcmf_detach()
>    brcmf_remove_interface()
>      brcmf_del_if()
>
> Inside the brcmf_del_if() function the drvr->if2bss[ifidx] is updated to
> BRCMF_BSSIDX_INVALID (-1) if the bsscfgidx matches.
>
> After brcmf_remove_interface() call the brcmf_proto_detach() function is
> called providing the following sequence:
>
>  brcmf_detach()
>    brcmf_proto_detach()
>      brcmf_proto_msgbuf_detach()
>        brcmf_flowring_detach()
>          brcmf_msgbuf_delete_flowring()
>            brcmf_msgbuf_remove_flowring()
>              brcmf_flowring_delete()
>                brcmf_get_ifp()
>                brcmf_txfinalize()
>
> Since brcmf_get_ip() can and actually will return NULL in this case the
> call to brcmf_txfinalize() will result in a NULL pointer dereference inside
> brcmf_txfinalize() when trying to update ifp->ndev->stats.tx_errors.
>
> This will only happen if a flowring still has an skb.
>
> Although the NULL pointer dereference has only been seen when trying to
> update the tx statistic, all other uses of the ifp pointer have been
> guarded as well with an early return if ifp is NULL.
>
> Cc: stable@vger.kernel.org

Acked-by: Arend van Spriel  <arend.vanspriel@broadcom.com>

> Signed-off-by: Marcel Hamer <marcel.hamer@windriver.com>
> Link: 
> https://lore.kernel.org/all/b519e746-ddfd-421f-d897-7620d229e4b2@gmail.com/



