Return-Path: <stable+bounces-3114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F2E7FCD61
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 04:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10FC22833F6
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 03:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8535363A3;
	Wed, 29 Nov 2023 03:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D88C1A3;
	Tue, 28 Nov 2023 19:21:32 -0800 (PST)
X-QQ-mid:Yeas6t1701228047t219t56462
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.128.129.197])
X-QQ-SSF:00400000000000F0FSF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 7162815512428122592
To: <netdev@vger.kernel.org>,
	<edumazet@google.com>,
	<davem@davemloft.net>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>
Cc: <mengyuanlou@net-swift.com>,
	<stable@vger.kernel.org>
References: <20231128095928.1083292-1-jiawenwu@trustnetic.com>
In-Reply-To: <20231128095928.1083292-1-jiawenwu@trustnetic.com>
Subject: RE: [PATCH net] net: libwx: fix memory leak on msix entry
Date: Wed, 29 Nov 2023 11:20:46 +0800
Message-ID: <021601da2273$0b2fb3f0$218f1bd0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQH5aDw+1SXoC4hvnhNOqLFHdiN9PrBSFUvw
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1

Cc: stable@vger.kernel.org

> -----Original Message-----
> From: Jiawen Wu <jiawenwu@trustnetic.com>
> Sent: Tuesday, November 28, 2023 5:59 PM
> To: netdev@vger.kernel.org; edumazet@google.com; davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com
> Cc: mengyuanlou@net-swift.com; Jiawen Wu <jiawenwu@trustnetic.com>
> Subject: [PATCH net] net: libwx: fix memory leak on msix entry
> 
> Since pci_free_irq_vectors() set pdev->msix_enabled as 0 in the
> calling of pci_msix_shutdown(), wx->msix_entries is never freed.
> Reordering the lines to fix the memory leak.
> 
> Fixes: 3f703186113f ("net: libwx: Add irq flow functions")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 2823861e5a92..a5a50b5a8816 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -1972,11 +1972,11 @@ void wx_reset_interrupt_capability(struct wx *wx)
>  	if (!pdev->msi_enabled && !pdev->msix_enabled)
>  		return;
> 
> -	pci_free_irq_vectors(wx->pdev);
>  	if (pdev->msix_enabled) {
>  		kfree(wx->msix_entries);
>  		wx->msix_entries = NULL;
>  	}
> +	pci_free_irq_vectors(wx->pdev);
>  }
>  EXPORT_SYMBOL(wx_reset_interrupt_capability);
> 
> --
> 2.27.0
> 


