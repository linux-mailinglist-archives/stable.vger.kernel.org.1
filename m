Return-Path: <stable+bounces-164404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C69B0EE4F
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 11:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69791C25B92
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 09:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63481285CAE;
	Wed, 23 Jul 2025 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bbaa.fun header.i=@bbaa.fun header.b="QuCgU9bt"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79640205AB6;
	Wed, 23 Jul 2025 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753262601; cv=none; b=mPILNrbqlSbWQfnLmGT085tnB32jFWr1W+PngegWdigafmG0apPLpyYyFYGaY5lsQ6GcpybkEZQAcqciAE4xAUAXnvmdKq77SQmuXGUeRrLuDfdoh6Z7AYIFNBZI2LSirhtyMqvv1/CCGVVihhrAQgyKojAjF18ZSSkfq/Ywrwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753262601; c=relaxed/simple;
	bh=PqMa2BEVE7wQ0K/vfeG8Y6spFAjToSN0XGW+Rgg6xyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+3HlvmpKffZu0Y9zDXp4qsau1MdupyA4qOLumvgDHqFiA9pFooGjDlEoRpJ8/X+LRL/0Xa6Jj7vtWB9TzEGWgZP3VdS+XaTjRuuSK6+MZL5SbqrFDOfnYsSQAxpablVdO1QKhE6Fp1Xux9/QR3E2RalROu9A3vhrdxcO8eZ28k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bbaa.fun; spf=none smtp.mailfrom=bbaa.fun; dkim=pass (1024-bit key) header.d=bbaa.fun header.i=@bbaa.fun header.b=QuCgU9bt; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bbaa.fun
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bbaa.fun
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bbaa.fun;
	s=goar2402; t=1753262572;
	bh=LikyKGyB3YGEkIKnSdbROfiE8TrXQ04tMlgxQEJDcrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=QuCgU9btr8TP+BTBecH5CvK5M4ToJ4JGkCrr4uDWv2Lc2gq1uQGw67n/s+HFFVzvg
	 U8svozHgx73RUIrf5p0CEadVu+SnbVYZqUPL/pGyCY60/Fwau7or/WVomCYK9VNeUI
	 Kds9r1jgYoeWCUJ/dj4BRslnyVioSwaKMiG9IEFQ=
X-QQ-mid: zesmtpsz1t1753262565t69c8ef38
X-QQ-Originating-IP: cUtGMLI8Xp3WKyNLwJn/Q/+436e/pOfxYujX/Wlu16w=
Received: from [198.18.0.1] ( [171.38.232.134])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Jul 2025 17:22:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9425942593230243899
Message-ID: <82255DF0A021BC1D+513c6ded-088b-4799-8605-b7118c7713ef@bbaa.fun>
Date: Wed, 23 Jul 2025 17:22:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BREGRESSION=5D=5BBISECTED=5D_PCI_Passthrough_/_SR?=
 =?UTF-8?Q?-IOV_Failure_on_Stable_Kernel_=E2=89=A5_v6=2E12=2E35?=
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <721D44AF820A4FEB+722679cb-2226-4287-8835-9251ad69a1ac@bbaa.fun>
 <6294f64a-d92d-4619-aef1-a142f5e8e4a5@linux.intel.com>
 <5F974FF84FAB6BD8+4a13da11-7f32-4f58-987a-9b7e1eaeb4aa@bbaa.fun>
 <2025072222-dose-lifting-e325@gregkh>
Content-Language: en-US
From: Ban ZuoXiang <bbaa@bbaa.fun>
In-Reply-To: <2025072222-dose-lifting-e325@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bbaa.fun:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mw3/skGyA4U54Jf7Ge9Lg8V1sKSFxZNKTh4GtlHXiVNDWBbT3umKr0mn
	MTliynDA00SuA0co9W1xzJpY24rjNHEgF54n8CB1S+P4UZJUZXquhwHTXMyIRH1GVTcyKKw
	2kSkeze8iq1ZTpBYIj2qoad0XlK4f5nBCja/veTSnGhNhqQuEayiib15U176MZ4unEq6T2I
	xPUo18I99tTSOtGPJX/AJCBHz6kVBHZAawY5Xm7DfHvIt5s88IRBIcOug9ZmkhaZ2fIQPFW
	qcuNeo/NhuWP8oaiStQkMdmoZ7/KWyz3LxpT+xU/6ovYe29xQClkQzfH4kgI/vfIDR5ru5H
	nKpk4B+/u3zHifKFhtt0ye+Ka0O/5VPx7pH18Dar3TF9dd+dy4byadhSUjYaoFhOcNsFt46
	U50KBcagx9SqRARJrYuiETZeA1VmxXILA6jzcMWb2yy/U3s13yzd5OfRAXofda9uyQyxW7F
	NDnhGElafvaVyiPeTPaih/V+5OGuQsFT8Df0IgShY4osdnXjUSnQ/5M7CBCiUYNKXeDx6iH
	w2QMtHJX0XRsPsbiNohJ05lrDwdFagA72TCfLLFAdlly479Eo708CJau3gaYVpMIxz65Pit
	B5Cmzj4zB8GL/CaDGdUCclGXIOqQpjFtQ+HzlNLHQJIVhBEUA7ZUwEyLuWiQ6v+WRcz7/+F
	rgqfPnzypM2RYPhRrj4MwTxT5IxiOP/n2bSY/7KCDwHlvQiN668YLHC1SyBMzRlElOc4FLl
	maGMjQt3SHlFoZg9+WbnHAAQ0ub0v2F+Od5G8ayqqUqk6VCAKWt+XWnzUdLLr0ic9wEyefu
	fMRoflQxmQvWFA7TzgR22JM0p2PIRDFV/kenanXitZ568COxFh9CWN/RzsJEumPhYa8H2vB
	KvlK54uPl2873A2y3yXKiTBjL7E4moQh2EJZ8n/S2qCZOA+F3+B5/CY2VSIao+fvwZqQ+Sd
	5eL2LTMOHCyglpGaHeNMZtSK0RYJXzYmq69CmKFKJF7kf1y6qLKtN3UgFosF/KpLwT8HdJQ
	BLlsmT/5kk/unIYglyBX9wJvwf9ROOgJKmS2tnYA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

> Nope!  We need your help as you are the one that can reproduce it :)
>
> Are we missing a backport?  Did we get the backport incorrect?  Should
> we just revert it?
>
> thanks,
> greg k-h

Hi, greg k-h

Original patch:

> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index bb871674d8acba..226e174577fff1 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4298,6 +4306,9 @@ static int identity_domain_attach_dev(struct
> iommu_domain *domain, struct device
>      else
>          ret = device_setup_pass_through(dev);
>  
> +    if (!ret)
> +        info->domain_attached = true;
> +
>      return ret;
>  }
Backport patch:
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 157542c07aaafa..56e9f125cda9a0 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4406,6 +4414,9 @@ static int device_set_dirty_tracking(struct
> list_head *devices, bool enable)
>              break;
>      }
>  
> +    if (!ret)
> +        info->domain_attached = true;
> +
>      return ret;
>  }

The last hunk of the original patch [1] was applied to the
|identity_domain_attach_dev| function, 
but the last hunk of the backport patch [2] appears to have been
mistakenly applied to the |device_set_dirty_tracking| function.
I can confirm that correctly placing the patch from
device_set_dirty_tracking into identity_domain_attach_dev resolves the
issue.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=320302baed05c6456164652541f23d2a96522c06
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=fb5873b779dd5858123c19bbd6959566771e2e83

thanks,
Ban ZuoXiang






