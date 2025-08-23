Return-Path: <stable+bounces-172570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 835D9B327B1
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 10:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0945EA0802C
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 08:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EE123BCE7;
	Sat, 23 Aug 2025 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YIddvGQa"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC51225A59
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755938607; cv=none; b=DhrCK1QuGztPrqfGpw37nkqN1/b/lVvu1+Mob//lNCUiqaeTOQYpNsOmJCkpvleIEByDfZYIpykVkFRoXNVQBVrU5BWy8EluXgSLmQ2e4Cxf/PVRkDv6I5+b4jojNN6xxJ5/orpCyTAO+EQNP49vi8z1LUKOre4T72kpDUi/noU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755938607; c=relaxed/simple;
	bh=Sh7NYksVOg0+cEwI/9mvebfdXkAMbtmN9W/uuKG/FSA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJTC/zT8dksKtIXDRnOHMhW7Wo20LYTIk0w+1O8X+oZ546UzRtycDE1nQXMO+zB2sLPwoelv8tu3J3Qvv3XbuuLoWbrJZ4XvFD+x9bY9U76hQppF9DkGEXQ/aIrP+GWKES9VT3DxZ6zdLa6iRHTUSmLDHMR8Vdkz19HGSYnMHCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YIddvGQa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755938601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XBBXwHuqYsE3hHAIcEi+8debmVMKYcuEtsvPds49qLE=;
	b=YIddvGQa6dvWfcbCgh+B4k1pCpRrEZRCliYbx0VQRwvUuXiz2VN4EWjggHFVJ5GKEW6j28
	K4tk16QqXqd6gIoye7J2/JLzfvrhvcLiob+rGyAUXq0N2If4LfCNJRmr1sn4GzoaVf2BY5
	RKUNZhXWDMAUr1cWYwmuZ2lcO6H73+s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-UXKazmw1PNWzYyOHAeK80w-1; Sat, 23 Aug 2025 04:43:19 -0400
X-MC-Unique: UXKazmw1PNWzYyOHAeK80w-1
X-Mimecast-MFC-AGG-ID: UXKazmw1PNWzYyOHAeK80w_1755938598
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b51411839so9940265e9.0
        for <stable@vger.kernel.org>; Sat, 23 Aug 2025 01:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755938598; x=1756543398;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBBXwHuqYsE3hHAIcEi+8debmVMKYcuEtsvPds49qLE=;
        b=juRea/8OT1ekEBgBcLgaByu4IqN85K82oV7ojODA+7So46SlLBQc/3P/L6kzsV7Em6
         Dip5Ij54F6CLSoZgFQ5vTFaiGfojDODiySjUa3KTx/KrfqDB/dVaqZI7BcHBetgFtzTE
         1ud2wFL0Otxs/1dymhJYBga7/vAlJiJbeFT+wYF/gx6mHMcjnuCw0NdzL3duzB0yqIUe
         l6PkZFgBxwRLPXahyXnHOpXcld0w8nTlfLkmdFCN99l1BP7Kg67s8jBTgd94UIdyryGf
         wzLzZvhADTnEIaOfjGV3EOjSRCDqOhOuv3o1cjBIo377wGzV0VvfcjMoLfSQoB8zULvb
         bV/A==
X-Forwarded-Encrypted: i=1; AJvYcCWA5yNnNeozdjZR608wwN2Qnr7sIaV7DL7TyQYsF1smcJYrDcuf5OQQgzukHjqBP3zr/HuPmpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYodrJgAfXYHoavrnPKKssbFXOoDUCdsY6T1YN8FXl3f5XBfAS
	+mGIBQQZt0EGiT0lvzunsJGmkgblWrjszK1ndJFVtxq5XinWZCvQOJURZbo434Hxa3vfg50Vh4T
	4c7NVc2Z/Z4Vku+hwi3ZWQAolOL+jPo+cbw18T4Nqx0eU2KWLv6baU5PFmg==
X-Gm-Gg: ASbGncvlFsAHjikfDUw18gnXUXllOzf13T6O4M+2k9wrqBqiHv6VcSEn+il5xu0ZX2W
	LE9X1uUPudyBai/U45Ws5O+hklKdrw2fLtNRVapsrE/PKRZwHitGFny9Gj0xEhKdG8um6/IaMsD
	HCXV7B+whaf0gdVt4iJEceWh0y74vZCfY8IqxKmbCABHEVkyG9H4OS7QT4OG51NxQFCrpAzTim4
	V2pLgFek4oaPDWqGdeA1hqlQNlKbWyTr1KOtjcWg4+sa/9UfMMaSX2dFMpoPQh+8VZWn0+9Ol4E
	YobeAzgamXBEvCaufrnIdLuG4DtQ2Sc/P1f8VxTADH5zRS+sgdE=
X-Received: by 2002:a05:600c:1d20:b0:459:dc99:51bf with SMTP id 5b1f17b1804b1-45b56382171mr35465765e9.25.1755938598061;
        Sat, 23 Aug 2025 01:43:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv+xyL1SrPU7/mPMky3/ADZJvuSN9B2wqb3s8vqHaurmc9XXiMDXRKUUTdrtSIewx9stHI2Q==
X-Received: by 2002:a05:600c:1d20:b0:459:dc99:51bf with SMTP id 5b1f17b1804b1-45b56382171mr35465645e9.25.1755938597690;
        Sat, 23 Aug 2025 01:43:17 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57499143sm27193895e9.26.2025.08.23.01.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 01:43:17 -0700 (PDT)
Date: Sat, 23 Aug 2025 10:43:15 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: wangzijie <wangzijie1@honor.com>
Cc: <akpm@linux-foundation.org>, <brauner@kernel.org>,
 <viro@zeniv.linux.org.uk>, <adobriyan@gmail.com>,
 <rick.p.edgecombe@intel.com>, <ast@kernel.org>, <k.shutemov@gmail.com>,
 <jirislaby@kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <polynomial-c@gmx.de>, <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>, <regressions@lists.linux.dev>
Subject: Re: [PATCH v3] proc: fix missing pde_set_flags() for net proc files
Message-ID: <20250823104315.26060eba@elisabeth>
In-Reply-To: <20250821105806.1453833-1-wangzijie1@honor.com>
References: <20250821105806.1453833-1-wangzijie1@honor.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 18:58:06 +0800
wangzijie <wangzijie1@honor.com> wrote:

> To avoid potential UAF issues during module removal races, we use pde_set_flags()
> to save proc_ops flags in PDE itself before proc_register(), and then use
> pde_has_proc_*() helpers instead of directly dereferencing pde->proc_ops->*.
> 
> However, the pde_set_flags() call was missing when creating net related proc files.
> This omission caused incorrect behavior which FMODE_LSEEK was being cleared
> inappropriately in proc_reg_open() for net proc files. Lars reported it in this link[1].
> 
> Fix this by ensuring pde_set_flags() is called when register proc entry, and add
> NULL check for proc_ops in pde_set_flags().
> 
> [1]: https://lore.kernel.org/all/20250815195616.64497967@chagall.paradoxon.rec/
> 
> Fixes: ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al")
> Cc: stable@vger.kernel.org
> Reported-by: Lars Wendler <polynomial-c@gmx.de>
> Signed-off-by: wangzijie <wangzijie1@honor.com>

Tested-by: Stefano Brivio <sbrivio@redhat.com>

For the records, see also my report and obsolete patch at:

  https://lore.kernel.org/linux-fsdevel/20250822172335.3187858-1-sbrivio@redhat.com/

-- 
Stefano


