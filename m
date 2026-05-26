Return-Path: <stable+bounces-254306-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHrDGGh8FWpEVwcAu9opvQ
	(envelope-from <stable+bounces-254306-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:56:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6688D5D4793
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 005193012C65
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04833DFC72;
	Tue, 26 May 2026 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQhSbiEt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97348397B12;
	Tue, 26 May 2026 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792925; cv=none; b=ALwZLogEcwtMnI+OiN3o1XjuYOpGEO7WdMEorcV406XdVUVoUIeQu6Wk1sF7ArPiAdUM7m8E90Jjc3ux/g7zhcIcEBw6NgbZpC2suCX31ET6h+dYKSJShO7txNm+0gqyLqGqVu4/TWueMwSDUdkMdE4fl84JPiLq8j28qjCNQmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792925; c=relaxed/simple;
	bh=Z70oHizJ7ex+aoYqfaGSxeSyab+OaN4r8N3FuWXDzXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6yDGmBLXkb4LzMhJVhJ6T6cPspAQBEoV+jrhbn4A2ty0pzpKQRExHHDByCjUvDaXKGON9O4QEG71jU2+8elqS7Vf8+Ia39JVbYagWHXyVT1uJ4ytasO5bZDKAyggXOauhe9G+BJ5fDP3OaI0xTAzIBlrQP/tdCdcDWxjpxa8tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQhSbiEt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B711F000E9;
	Tue, 26 May 2026 10:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779792922;
	bh=Z70oHizJ7ex+aoYqfaGSxeSyab+OaN4r8N3FuWXDzXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JQhSbiEtF2zHTc1FZ80/xc+K7/7ibZfKZyzTqPpP0cYRY/+Az00NKJrPI33131rao
	 cvSbgR7G4c78S0IFTAMbA3i5bHC/x70mWJjqnuN1p2+Z8xwUZdkPqavgap6yAh4iop
	 auhqjCGeazJ4Y2VWXTuneZawIX5KzE+hk/Oj6RPBIAhSrFqPtjdQpmOMiHZCj6V1S/
	 3akAO5YV3v5h4AGSdn+o3aAOJXtjlo3/JiyXbl++XNWRwke+ZE5DdbN3b5OcFFvdMz
	 mQ/N4Mua2XqtDRapzIxdZQwUig2cLj/WZ5hLZbrlXNCu/T+2/SUJrUIEgjeA5XB6IO
	 AVAaW0kElJe2w==
Date: Tue, 26 May 2026 11:55:14 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Yin Tirui <yintirui@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <liam@infradead.org>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Dan Williams <djbw@kernel.org>, Alistair Popple <apopple@nvidia.com>, wangkefeng.wang@huawei.com, 
	chenjun102@huawei.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: update file PUD counter before
 folio_put()
Message-ID: <ahV7tJ2dq4wt2H_W@lucifer>
References: <20260526101355.1984244-1-yintirui@huawei.com>
 <ahV1WCxlXhOKfO_S@lucifer>
 <65570a39-9738-44db-bd05-837b9e54faf7@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65570a39-9738-44db-bd05-837b9e54faf7@huawei.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254306-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Queue-Id: 6688D5D4793
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 06:53:05PM +0800, Yin Tirui wrote:
>
> On 5/26/2026 6:47 PM, Lorenzo Stoakes wrote:
> > You sent this twice :)

Yeah oops you didn't, that was just the PMD part!

(Also my mail client may now, ironically, duplicate a reply...)

> >
> > On Tue, May 26, 2026 at 06:13:55PM +0800, Yin Tirui wrote:
> > > __split_huge_pud_locked() updates the file/shmem RSS counter after
> > > dropping the PUD mapping's folio reference. If folio_put() drops the
> > > last reference, mm_counter_file() can later read freed folio state via
> > > folio_test_swapbacked().
> > >
> > > Move the counter update before folio_put().
> > >
> > > Fixes: dbe54153296d ("mm/huge_memory: add vmf_insert_folio_pud()")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Yin Tirui <yintirui@huawei.com>
> > Patch looks sane to me, so:
> >
> > Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
> >
> > There seems to be an identical problem in __split_huge_pmd_locked() - could you
> > do the same fix there?
>
> I have already sent it as another separate patch.
>
> https://lore.kernel.org/linux-mm/20260526101337.1984081-1-yintirui@huawei.com/T/#u

Yup, inevitably hit send and only then notice this :)

Cheers, Lorenzo

