Return-Path: <stable+bounces-116566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E89A38184
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 12:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D171891297
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 11:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA837217730;
	Mon, 17 Feb 2025 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPcCOTMW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AF3212B3E
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791124; cv=none; b=RTmVlHk0VcvVkEe/GrpyIrkZvQSLP3oV3mZETtxrY5w83+9XAwMVYJP3ytRNaaAnhRs/acsNhqOxKtP3+lO7hEicarrh5AU26m000XVrJ6K03IXcZX2VeLq9Ss4iupW6ZlYED+TW/0ye4R8J/TNVi7czRokkKaCrTMwXvacgTnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791124; c=relaxed/simple;
	bh=i4xLGFB10YVGPJ6Seil/3cMEWi5jhohglwWahQcNhrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMv7Hv2LOJCauxWH3D6mrIwsmPvu8zfandgcca8gIJSSt5z4ziECiNhd4X2fHpW/dEUJlHZSqsulHe7g9NfDCFUq1qIsLUgy66jr0lZZeQ6hDL3W7B+q53y3QcmauOH3xLXfSvQtHfvOBTN3JfjkBCUEuskj2HJV2ucTWDMjDJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPcCOTMW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739791121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+HBHBAwSNG1EGDeYThg6qH98uMDPF9VyqqyLje9RWbQ=;
	b=CPcCOTMW3/qvgnRcZNjSO7kASU6hWySnegIFir4gbytlhve2LWM6gcBIQh2MdQToBkasi4
	9BOzzTYlvs2k8msRerHBWF7yfKIJTuWqzQwPILTBygOZYhyRHYfQqIFUNCHDSiqg0b0D1K
	mT7RZoFtRbi4rQr7ppVcFKmzfgwpueU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-nnhAjE0XPjer_a6aOuk_dg-1; Mon, 17 Feb 2025 06:18:40 -0500
X-MC-Unique: nnhAjE0XPjer_a6aOuk_dg-1
X-Mimecast-MFC-AGG-ID: nnhAjE0XPjer_a6aOuk_dg_1739791119
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43935bcec74so22674775e9.3
        for <stable@vger.kernel.org>; Mon, 17 Feb 2025 03:18:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739791119; x=1740395919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HBHBAwSNG1EGDeYThg6qH98uMDPF9VyqqyLje9RWbQ=;
        b=khyqaym5tFWhLjQg2z3AgvJO317r3Hppec7t16mBeZDbvBs2JV4Vo6yItp9QnYbqSI
         S6ywXHjk6MMAhMy4YHRLpnaT0nerQL3r/YPxA4YYr5LOixk2lQqJVCjSXWJqyiSBMzTJ
         rRzrQPe73RG2IvEAWqV3dsQsXNpBZMEk9WhMMVwaKeEnkndfPKtHwgME875p8QhLiLBT
         DIbWaMyChoOb+AHH+G1Z5dx/y4MWdmxxO6cSkTgeE9cJ4cZ1oySFTdpieqJsO/aCnnKj
         1giizyAd0Lc+Cgkxyi/FLAthEr3M0P35X966vhWv4cVdMjJMor2O/erU3v0RcMVNbJXd
         MRqA==
X-Forwarded-Encrypted: i=1; AJvYcCWUh7Cgt3j7y1qf8iT1KvhyVqFGAuKFZxtAUob5F7ss/DbfhavjUoMessKy5l23kgo+iL7VxAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymyJeS0rKyhOYgHFX2AwYeapKZ+/s5H13iKYHnmRkPqWeBOVyl
	hJg2NQJ/NI8zEC4ZoU/Qx8i4m7nbrrqURWiVAqWYPaYLUUQ2zoN76fhqcFDxukkZQZb5o1kIzbF
	XzM0uhCfw3FWAxoeHvEw1xOykFK7+ZKYxs0GekaqtywmZh3MSD1ceZQ==
X-Gm-Gg: ASbGncv5pqkuksw8rT50dhA7TgcDrzgDOLf11YoLkpspjU9mHOAseunuirgpxR+FOhH
	z9+lg97zpTUxjKVK3Y9QI1hR0JDFcP8kMaYYooq3lOv2SECdYTtQuLkKl4jBuA+EmP34NTI2Y2B
	xgWAqTD6Tm9yeS2uyuH8uBDn8NyK0OJWdNNlKO2Qfx3eoShOg4slnapdyg07hBw53s7+pap2Kcl
	7u+dYW6hSDkkkdX4n2UttBDJAgtw0upeLZ3FhV/ihb+w0XMNUbD91DuZWVu0glwCqVQBA8QQz6o
	nSCMbkB6
X-Received: by 2002:a05:600c:458b:b0:434:a529:3b87 with SMTP id 5b1f17b1804b1-4396e6cf89amr91222385e9.10.1739791118664;
        Mon, 17 Feb 2025 03:18:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwKRKcJRkTustJlSMmRXn78FkErtDz42UNyAoLQwR8KizSstvM3Qpo4Q4wo5/bbpYoEE4eZg==
X-Received: by 2002:a05:600c:458b:b0:434:a529:3b87 with SMTP id 5b1f17b1804b1-4396e6cf89amr91222205e9.10.1739791118294;
        Mon, 17 Feb 2025 03:18:38 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43985c50397sm22596385e9.0.2025.02.17.03.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 03:18:37 -0800 (PST)
Date: Mon, 17 Feb 2025 12:18:35 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>, 
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, 
	syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/2] vsock: fix use-after free and null-ptr-deref
Message-ID: <f7lr3ftzo66sl6phlcygh4xx4spga4b6je37fhawjrsjtexzne@xhhwaqrjznlp>
References: <20250214-linux-rolling-stable-v1-0-d39dc6251d2f@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250214-linux-rolling-stable-v1-0-d39dc6251d2f@redhat.com>

On Fri, Feb 14, 2025 at 06:53:54PM +0100, Luigi Leonardi wrote:
>Hi all,
>
>This series contains two patches that are already available upstream:
>
>- The first commit fixes a use-after-free[1], but introduced a
>null-ptr-deref[2].
>- The second commit fixes it. [3]
>
>I suggested waiting for both of them to be merged upstream and then
>applying them togheter to stable[4].
>
>It should be applied to:
>- 6.13.y
>- 6.12.y
>- 6.6.y
>
>I will send another series for
>- 6.1.y
>- 5.15.y
>- 5.10.y
>
>because of conflicts.
>
>[1]https://lore.kernel.org/all/20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co/
>[2]https://lore.kernel.org/all/67a09300.050a0220.d7c5a.008b.GAE@google.com/
>[3]https://lore.kernel.org/all/20250210-vsock-linger-nullderef-v3-0-ef6244d02b54@rbox.co/
>[4]https://lore.kernel.org/all/2025020644-unwitting-scary-3c0d@gregkh/
>
>Thanks,
>Luigi
>
>---
>Michal Luczaj (2):
>      vsock: Keep the binding until socket destruction
>      vsock: Orphan socket after transport release
>
> net/vmw_vsock/af_vsock.c | 12 +++++++++++-
> 1 file changed, 11 insertions(+), 1 deletion(-)
>---
>base-commit: a1856aaa2ca74c88751f7d255dfa0c8c50fcc1ca
>change-id: 20250214-linux-rolling-stable-d73f0bed815d
>
>Best regards,
>-- Luigi Leonardi <leonardi@redhat.com>
>

Looks like I forgot to add my SoB to the commits, my bad.

For all the other stable trees (6.1, 5.15 and 5.10), there are some 
conflicts due to some indentation changes introduced by 135ffc7 ("bpf, 
vsock: Invoke proto::close on close()"). Should I backport this commit 
too?  There is no real dependency on the commit in the Fixes tag 
("vsock: support sockmap"). IMHO, this would help future backports, 
because of indentation conficts! Otherwise I can simply fix the patches.  
WDYT?

Cheers,
Luigi


