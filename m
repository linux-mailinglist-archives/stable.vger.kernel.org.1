Return-Path: <stable+bounces-192666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D877CC3E29F
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 02:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A95C14E4073
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 01:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F012F99A6;
	Fri,  7 Nov 2025 01:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRqfkIPB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6649F25DD1E
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 01:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480279; cv=none; b=Gvryi4Hz1UxvQlovl62Y7VRr9t5S1dV0I4noeEpMO1XQQBqt63/HVFfpQGPuBLrAs3jbUbI184y1+lN2jaGzUbWDyabh0pzAw0D6DLXrEEoBvlGCs/emUwTepBk4HfBLJCm8Ra+Qn/erC7Ei26mSPbD7NLFP4ANc0KSbyFMetmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480279; c=relaxed/simple;
	bh=/XhvkqcfSrI8xxCWAmjwnsjk18iUp94t6qVbkIk1hFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A054fimZX0Nk0Bp0kRiGU3ELwn8Q0rX4buBtyveYYsxTN/0cUPhi4nra6Tj1IK8R7xw3HzYZuP6uXiiCv6lO4VYUukkHepRT3VsdBS01dy/0t6d0GZEDHpOFwB3oz8v7yciBU5pTsp+iJE4vZ2p5AAT0rOetpZM+GSyiGaDABHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRqfkIPB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762480276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dOE3+WNCmO2l7emNZOVxTGcMy/4xRS0btLplCRQG9Sg=;
	b=eRqfkIPBEmsv+hDDlvx9uwGmkIHI7PNIRDLSUW6pix3aRoQNglq8NmmRcDctxVeftPxQXA
	uTAs8ZfOY0nebQMrVS8trQfkblg6ojc9sXW3/HQvG77XdavZKwfsuvNw+d2l530t5dQC9n
	V5bba0cBIYXr+wlgDFvg+pDijo0IXT4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-CZ1givntP2GQytu_CEziNw-1; Thu,
 06 Nov 2025 20:51:13 -0500
X-MC-Unique: CZ1givntP2GQytu_CEziNw-1
X-Mimecast-MFC-AGG-ID: CZ1givntP2GQytu_CEziNw_1762480271
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80CD81800358;
	Fri,  7 Nov 2025 01:51:11 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DC881945110;
	Fri,  7 Nov 2025 01:51:08 +0000 (UTC)
Date: Fri, 7 Nov 2025 09:51:04 +0800
From: Baoquan He <bhe@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2 2/2] kernel/kexec: Fix IMA when allocation happens in
 CMA area
Message-ID: <aQ1QiLGXWRsZbiYo@MiWiFi-R3L-srv>
References: <20251106065904.10772-1-piliu@redhat.com>
 <20251106065904.10772-2-piliu@redhat.com>
 <aQxV2ULFzG/xrl7/@MiWiFi-R3L-srv>
 <CAF+s44TyM7sBVmGn7kn5Cw+Ygm02F93hchiSBN0Q_qR=oA+DLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF+s44TyM7sBVmGn7kn5Cw+Ygm02F93hchiSBN0Q_qR=oA+DLg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 11/06/25 at 06:01pm, Pingfan Liu wrote:
> On Thu, Nov 6, 2025 at 4:01 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 11/06/25 at 02:59pm, Pingfan Liu wrote:
> > > When I tested kexec with the latest kernel, I ran into the following warning:
> > >
> > > [   40.712410] ------------[ cut here ]------------
> > > [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 kimage_map_segment+0x144/0x198
> > > [...]
> > > [   40.816047] Call trace:
> > > [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> > > [   40.823221]  ima_kexec_post_load+0x58/0xc0
> > > [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> > > [...]
> > > [   40.855423] ---[ end trace 0000000000000000 ]---
> > >
> > > This is caused by the fact that kexec allocates the destination directly
> > > in the CMA area. In that case, the CMA kernel address should be exported
> > > directly to the IMA component, instead of using the vmalloc'd address.
> >
> > Well, you didn't update the log accordingly.
> >
> 
> I am not sure what you mean. Do you mean the earlier content which I
> replied to you?

No. In v1, you return cma directly. But in v2, you return its direct
mapping address, isnt' it?

> 
> > Do you know why cma area can't be mapped into vmalloc?
> >
> Should not the kernel direct mapping be used?

When image->segment_cma[i] has value, image->ima_buffer_addr also
contains the physical address of the cma area, why cma physical address
can't be mapped into vmalloc and cause the failure and call trace?


