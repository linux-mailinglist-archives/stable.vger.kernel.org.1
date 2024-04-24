Return-Path: <stable+bounces-41314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8292E8AFD8E
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 03:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF871C21AAD
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 01:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6421C46BF;
	Wed, 24 Apr 2024 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vm0b2Bm4"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ECC4C61
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713920780; cv=none; b=PztSxhwIxd03dHsY5O9DijqU2iKo1b+BlOa4+z4vr01Ohuvm+nrwnY8PdfgxvyCsjlMg+7WA6lPKKI4RFWs0KhEp9oGfWRYdJYROtd1iZ7g2Vk2R2pHdT4PikdYGWk6pUb55mXlnmI0ovuDz+uEJn7fxUISI+3c3rMquVqXRVFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713920780; c=relaxed/simple;
	bh=kFv+HJSO2yGdVIZatcr61rx2DHaiUl3tQIdh4PAolZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJttge1p3hKiC+7Aj4eA64lqAuaDz6E+krQdCxxMAn5wK2Wh56DpDM2TgRqbO1Wk5z7rN61jtu20V4WQarwkZCyif7strYTdNTibqPu4SPmLOyVzZSEP2tfb5G7grEvj4REDsgGyeVO5mrIu7MTnheA3iMHaUwDZn/5BmkUNs8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vm0b2Bm4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713920777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CV9SCuJQp/Hz566gNwu9CruqvVl2UnfmICkykwGjH9I=;
	b=Vm0b2Bm4ZU8M9NIMu+v1Q0iXu03uQ44jqolVSl2FJyKPW+oD5pAcf18AaWdJutp3jpEYvI
	cTNllT0e6o0nIuQkIKKZBeNUh0t49E0H0eRIko0IvvfNsYhKc33O3yH+KiT4nw3y/Cw4Il
	R4oIR1LKO/iqDLqBGae0NQYMjoQTEc8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-ec3klDsEOpOze9zmKrqY0g-1; Tue, 23 Apr 2024 21:06:13 -0400
X-MC-Unique: ec3klDsEOpOze9zmKrqY0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 667701011351;
	Wed, 24 Apr 2024 01:06:13 +0000 (UTC)
Received: from localhost (unknown [10.72.116.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B4ADD2166B31;
	Wed, 24 Apr 2024 01:06:11 +0000 (UTC)
Date: Wed, 24 Apr 2024 09:06:09 +0800
From: Baoquan He <bhe@redhat.com>
To: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	Chen Jiahao <chenjiahao16@huawei.com>
Subject: Re: [PATCH] Revert "riscv: kdump: fix crashkernel reserving problem
 on RISC-V"
Message-ID: <ZihbAYMOI4ylazpt@MiWiFi-R3L-srv>
References: <20240416085647.14376-1-xingmingzheng@iscas.ac.cn>
 <2024041927-remedial-choking-c548@gregkh>
 <3d6784be-f6ba-48eb-ae0e-b8a20fe90f58@iscas.ac.cn>
 <2024041939-isotope-client-3d75@gregkh>
 <a5493f44-2aac-4005-992b-f2ac90cd1835@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5493f44-2aac-4005-992b-f2ac90cd1835@iscas.ac.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 04/19/24 at 10:55pm, Mingzheng Xing wrote:
> On 4/19/24 21:58, Greg Kroah-Hartman wrote:
> > On Fri, Apr 19, 2024 at 08:26:07PM +0800, Mingzheng Xing wrote:
> >> On 4/19/24 18:44, Greg Kroah-Hartman wrote:
> >>> On Tue, Apr 16, 2024 at 04:56:47PM +0800, Mingzheng Xing wrote:
> >>>> This reverts commit 1d6cd2146c2b58bc91266db1d5d6a5f9632e14c0 which has been
> >>>> merged into the mainline commit 39365395046f ("riscv: kdump: use generic
> >>>> interface to simplify crashkernel reservation"), but the latter's series of
> >>>> patches are not included in the 6.6 branch.
> >>>>
> >>>> This will result in the loss of Crash kernel data in /proc/iomem, and kdump
> >>>> loading the kernel will also cause an error:
> >>>>
> >>>> ```
> >>>> Memory for crashkernel is not reserved
> >>>> Please reserve memory by passing"crashkernel=Y@X" parameter to kernel
> >>>> Then try to loading kdump kernel
> >>>> ```
> >>>>
> >>>> After revert this patch, verify that it works properly on QEMU riscv.
> >>>>
> >>>> Link: https://lore.kernel.org/linux-riscv/ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv
> >>>> Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
> >>>> ---
> >>>
> >>> I do not understand, what branch is this for?  Why have you not cc:ed
> >>> any of the original developers here?  Why does Linus's tree not have the
> >>> same problem?  And the first sentence above does not make much sense as
> >>> a 6.6 change is merged into 6.7?
> >>
> >> Sorry, I'll try to explain it more clearly.
> >>
> >> This commit 1d6cd2146c2b ("riscv: kdump: fix crashkernel reserving problem
> >> on RISC-V") should not have existed because this patch has been merged into
> >> another larger patch [1]. Here is that complete series:
> > 
> > What "larger patch"?  It is in Linus's tree, so it's not part of
> > something different, right?  I'm confused.
> > 
> 
> Hi, Greg
> 
> The email Cc:ed to author Chen Jiahao was bounced by the system, so maybe
> we can wait for Baoquan He to confirm.
> 
> This is indeed a bit confusing. The Fixes: tag in 1d6cd2146c2b58 is a false
> reference. If I understand correctly, this is similar to the following
> scenario:
> 
> A Fixes B, B doesn't go into linus mainline. C contains A, C goes into linus
> mainline 6.7, and C has more reconstruction code. but A goes into 6.6, so
> it doesn't make sense for A to be in the mainline, and there's no C in 6.6
> but there's an A, thus resulting in an incomplete code that creates an error.

Do you mean commit 1d6cd2146c2b58 ("iscv: kdump: fix crashkernel reserving
problem on RISC-V") was mistakenly added into v6.6, but the commit which
it fixed is not existing in v6.6?

I checked code, it does look like what you said, and it's truly
confusing. If so, we should revert commit 1d6cd2146c2b58 ("iscv: kdump: fix
crashkernel reserving problem on RISC-V") in v6.6.y to make kdump work
on risc-v.


