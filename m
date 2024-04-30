Return-Path: <stable+bounces-41772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF9A8B66AF
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 02:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322941C213BD
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 00:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D668938C;
	Tue, 30 Apr 2024 00:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPWmrphM"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4E8161
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 00:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714435368; cv=none; b=NeiRiEq4cMqSOIYOXfwKj2BGh9N9iWmnr0+Se9vIfbHvPMfxXgpcRCjDS+T6ms03QHmgPPv3rPUfws/u3Ysydgo/QFwVYCUdBOCKpNkZpv+r8Md7NZS4xJVQmyVeQEwaaJ/wci5YSgZLJDJw2FZIgyBbrCvtASQZUSxRpULggA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714435368; c=relaxed/simple;
	bh=J/bn0PDKjY7OLk7uvCmeNUbuo3DX2c5Ogzce4zs/bP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YklgmrojV+kJVH4LwBfEGFUjarfsWoLJQf5WClNwyyO6N2mA1JYtwFfD7PbSiSQCW/vBY/tQ5Ykj+QE36GXwNVW2sr5fCCIEKFmAyqFwaNVMQ1TDHeQcAq9dPL066QtzrTWbpJg2kF8+YEL1/eGi5LzBYQHAZhfMgy1ynKpATqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bPWmrphM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714435365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lWZkiX6zsf6w2HczntfinTak8uCIlY7jOU3B2wGIYng=;
	b=bPWmrphMCB/wAgqDsDQ9gch3kfcqi+aEixhKMdaNHNAkdHCSpY46UA+JI5IcrUIW1WyxAf
	0MjwtJavH6q1iby2ftTytI+BnjXqP3TG8qxWlmoeua5FmY2r3qWiqzbVf9Xa4LBhUKG8HI
	6OvC7qTZUTgTT0g0o7LJKMWTJ/4hA/I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-mTijwM27N-6Yt7PBHQTwog-1; Mon, 29 Apr 2024 20:02:43 -0400
X-MC-Unique: mTijwM27N-6Yt7PBHQTwog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7463F834FB4;
	Tue, 30 Apr 2024 00:02:43 +0000 (UTC)
Received: from localhost (unknown [10.72.116.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D32940C6CC1;
	Tue, 30 Apr 2024 00:02:40 +0000 (UTC)
Date: Tue, 30 Apr 2024 08:02:37 +0800
From: Baoquan He <bhe@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Cc: stable@vger.kernel.org, Chen Jiahao <chenjiahao16@huawei.com>,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] Revert "riscv: kdump: fix crashkernel reserving problem
 on RISC-V"
Message-ID: <ZjA1Hbik7NiTkZOw@MiWiFi-R3L-srv>
References: <20240416085647.14376-1-xingmingzheng@iscas.ac.cn>
 <2024041927-remedial-choking-c548@gregkh>
 <3d6784be-f6ba-48eb-ae0e-b8a20fe90f58@iscas.ac.cn>
 <2024041939-isotope-client-3d75@gregkh>
 <a5493f44-2aac-4005-992b-f2ac90cd1835@iscas.ac.cn>
 <2024042318-muppet-snippet-617c@gregkh>
 <5d49f626-a66f-4969-a03f-fcf83e2d2bab@iscas.ac.cn>
 <2024042944-wriggle-countable-627c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024042944-wriggle-countable-627c@gregkh>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 04/29/24 at 12:52pm, Greg Kroah-Hartman wrote:
> On Wed, Apr 24, 2024 at 11:40:16AM +0800, Mingzheng Xing wrote:
> > On 4/23/24 21:12, Greg Kroah-Hartman wrote:
> > > On Fri, Apr 19, 2024 at 10:55:44PM +0800, Mingzheng Xing wrote:
> > >> On 4/19/24 21:58, Greg Kroah-Hartman wrote:
> > >>> On Fri, Apr 19, 2024 at 08:26:07PM +0800, Mingzheng Xing wrote:
> > >>>> On 4/19/24 18:44, Greg Kroah-Hartman wrote:
> > >>>>> On Tue, Apr 16, 2024 at 04:56:47PM +0800, Mingzheng Xing wrote:
> > >>>>>> This reverts commit 1d6cd2146c2b58bc91266db1d5d6a5f9632e14c0 which has been
> > >>>>>> merged into the mainline commit 39365395046f ("riscv: kdump: use generic
> > >>>>>> interface to simplify crashkernel reservation"), but the latter's series of
> > >>>>>> patches are not included in the 6.6 branch.
> > >>>>>>
> > >>>>>> This will result in the loss of Crash kernel data in /proc/iomem, and kdump
> > >>>>>> loading the kernel will also cause an error:
> > >>>>>>
> > >>>>>> ```
> > >>>>>> Memory for crashkernel is not reserved
> > >>>>>> Please reserve memory by passing"crashkernel=Y@X" parameter to kernel
> > >>>>>> Then try to loading kdump kernel
> > >>>>>> ```
> > >>>>>>
> > >>>>>> After revert this patch, verify that it works properly on QEMU riscv.
> > >>>>>>
> > >>>>>> Link: https://lore.kernel.org/linux-riscv/ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv
> > >>>>>> Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
> > >>>>>> ---
> > >>>>>
> > >>>>> I do not understand, what branch is this for?  Why have you not cc:ed
> > >>>>> any of the original developers here?  Why does Linus's tree not have the
> > >>>>> same problem?  And the first sentence above does not make much sense as
> > >>>>> a 6.6 change is merged into 6.7?
> > >>>>
> > >>>> Sorry, I'll try to explain it more clearly.
> > >>>>
> > >>>> This commit 1d6cd2146c2b ("riscv: kdump: fix crashkernel reserving problem
> > >>>> on RISC-V") should not have existed because this patch has been merged into
> > >>>> another larger patch [1]. Here is that complete series:
> > >>>
> > >>> What "larger patch"?  It is in Linus's tree, so it's not part of
> > >>> something different, right?  I'm confused.
> > >>>
> > >>
> > >> Hi, Greg
> > >>
> > >> The email Cc:ed to author Chen Jiahao was bounced by the system, so maybe
> > >> we can wait for Baoquan He to confirm.
> > >>
> > >> This is indeed a bit confusing. The Fixes: tag in 1d6cd2146c2b58 is a false
> > >> reference. If I understand correctly, this is similar to the following
> > >> scenario:
> > >>
> > >> A Fixes B, B doesn't go into linus mainline. C contains A, C goes into linus
> > >> mainline 6.7, and C has more reconstruction code. but A goes into 6.6, so
> > >> it doesn't make sense for A to be in the mainline, and there's no C in 6.6
> > >> but there's an A, thus resulting in an incomplete code that creates an error.
> > >>
> > >> The link I quoted [1] shows that Baoquan had expressed an opinion on this
> > >> at the time.
> > >>
> > >> Link: https://lore.kernel.org/linux-riscv/ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv [1]
> > > 
> > > I'm sorry, but I still do not understand what I need to do here for a
> > > stable branch.  Do I need to apply something?  Revert something?
> > > Something else?
> > 
> > Hi, Greg
> > 
> > I saw Baoquan's reply in thread[1], thanks Baoquan for confirming.
> > 
> > So I think the right thing to do would be just to REVERT the commit
> > 1d6cd2146c2b ("riscv: kdump: fix crashkernel reserving problem on RISC-V")
> > in the 6.6.y branch, which is exactly the patch I submitted. If I need to
> > make changes to my commit message, feel free to let me know and I'll post
> > the second version.
> > 
> > Link: https://lore.kernel.org/stable/ZihbAYMOI4ylazpt@MiWiFi-R3L-srv [1]
> 
> Can someone just send me a patch series showing EXACTLY what needs to be
> done here, as I am _still_ confused.

I think Mingzheng's patch is good to apply in the 6.6.y stable branch.

Hi Mingzheng,

Can you resend this patch to Greg and stable@vger.kernel.org and CC me?
I would like to Ack your patch, but can't find the original patch since
you didn't cc me.

Thanks
Baoquan


