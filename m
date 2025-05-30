Return-Path: <stable+bounces-148315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CDDAC93D6
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 18:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00129A43249
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 16:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E42C1A2643;
	Fri, 30 May 2025 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bD1tjqej"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B91C1DFE26
	for <stable@vger.kernel.org>; Fri, 30 May 2025 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748623508; cv=none; b=in15G8HUWnrRcsqAuR9X1eGVpMUaUDgvd62u3QT8fn23tj8HP4Rvq28EiZlxIdohTQlN7qlgRzdAMNqs+9CRsiRdGlIf/9NfJ0jx69INQRJa9kzWdModyEIHTRM8eTcKznm8zk6dz6HE7mQsVUMeafk27e822sIjdgDvnfiJoV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748623508; c=relaxed/simple;
	bh=UKEpceSp1AdCJrTKG4/wDs3+PUHkmw4/OcqerA3gUMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwlF9vpkM1lMHwRbGMO2xj+WjcgLERB+6fcZN2FKE458h5sEJwGls2HLDJ8bnRZVn8xlQGARVwwqMYeI4u4JwftrNWQvyHoC0HR0narPwBd5trp2uKlRjVYiIZWoHYyuXPoYmph6TPMpFAFOWNvu7VBGJbrvdIrninkZH9hw1II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bD1tjqej; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748623504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sE03iNOBKodbG+yUa8w4eDdllwosn3xeMgEa1GhZb9I=;
	b=bD1tjqejc1vfsQEn/MXjHSFUkNWAqQhzs3wypjqjfw1R+avn3gwTN+/YkoGaB3jxLIe00O
	YXMKnR1Ffr2jINqsm2rXmq0Vy+KhF0K0IV2Yn/OleyIGzne+6QAUzce1VcSIWz9qMwB8Ov
	I71Fus0Mny/nEe3LKu4mLuymsh74CrY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-HIWAqgUIMFSaTG3M_w51aQ-1; Fri,
 30 May 2025 12:45:02 -0400
X-MC-Unique: HIWAqgUIMFSaTG3M_w51aQ-1
X-Mimecast-MFC-AGG-ID: HIWAqgUIMFSaTG3M_w51aQ_1748623500
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C3B619560B1;
	Fri, 30 May 2025 16:44:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.37])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6ECAC30001B7;
	Fri, 30 May 2025 16:44:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 30 May 2025 18:44:18 +0200 (CEST)
Date: Fri, 30 May 2025 18:44:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Pu Lehui <pulehui@huaweicloud.com>, mhiramat@kernel.org,
	peterz@infradead.org, akpm@linux-foundation.org,
	Liam.Howlett@oracle.com, vbabka@suse.cz, jannh@google.com,
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, pulehui@huawei.com
Subject: Re: [PATCH v1 2/4] mm: Expose abnormal new_pte during move_ptes
Message-ID: <20250530164411.GB25160@redhat.com>
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
 <20250529155650.4017699-3-pulehui@huaweicloud.com>
 <ed72c0c8-a511-483a-be44-edf7432a4782@lucifer.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed72c0c8-a511-483a-be44-edf7432a4782@lucifer.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 05/30, Lorenzo Stoakes wrote:
>
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -237,6 +237,8 @@ static int move_ptes(struct pagetable_move_control *pmc,
> >
> >  	for (; old_addr < old_end; old_pte++, old_addr += PAGE_SIZE,
> >  				   new_pte++, new_addr += PAGE_SIZE) {
> > +		WARN_ON_ONCE(!pte_none(*new_pte));
> > +
>
> I mean, we really really should not ever be seeing a mapped PTE here, so I think
> a WARN_ON_ONCE() is fine.
>
> We unmap anything ahead of time, and only I think this uprobe breakpoint
> installation would ever cause this to be the case.
>
> We can make this a VM_WARN_ON_ONCE() too I suppose, just in case there's
> something we're not thinking of, but I'd say at some point we'd want to change
> it to a WARN_ON_ONCE().

Note also that move_normal_pmd/move_normal_pud use WARN_ON_ONCE(!xxx_none(...)),
not VM_WARN_ON_ONCE().

Oleg.


