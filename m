Return-Path: <stable+bounces-121661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D51A58ADB
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 04:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B004B188A8F3
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 03:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC31156C69;
	Mon, 10 Mar 2025 03:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="ZkgF1m4h"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760F67E765
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 03:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741577557; cv=none; b=n7U1hLlaFMRl1Je1+ndfm4zfPfqcHOrur7E8Tue1ZZ4JfxlYhJvZGk7ea1JYvmoUDcqu/TXXT9bnV3703spryJ6eA25beJYfWCCgVhZgwIKcB4upifLew62kahLJi8IJ8cjVu2KnSW/fsk4SgmQVbZrWR9YRYr/rbsfrd0bQETQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741577557; c=relaxed/simple;
	bh=f0k56qvsMhHdVRFz0QM/+Bghg7k+qB60yoKABxJ9b1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ywy2vgLeMbc8kqlQ6YZ380T1z8qgc2WXP8ISLVyxhQf0VWXs8Maya7GIZQQ7e6qRsPbLIr9pvf8YDOT9lBYUh10I+NZwqS+/on6h+nQDDYhxaSOn+z/TFiUj7ovy8B6qVR34aP+FY57a8FbriXraXlfaN3Lh4vNkRDvo74Vgj30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=pass smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=ZkgF1m4h; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1741577547;
	bh=F5DYTblmaHizCFECd/mw4UoRe44G105xCaXSNa1BSk8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=ZkgF1m4huCwsp7ODGucbxUiRloU6UpcsERbncOiGHBwIbf8Z9+5xwX/eenIRsRZ3Y
	 rcZJttKbOUjflFz2HdkkpOiEUxKzGJAWUh0NzNj9d0GYUKq8+Uz4bqoz8xqYwATlBE
	 u9/jGxjNj/BTce7R0Y+IEHKHqhz0ezorqFXIoWD4=
X-QQ-mid: bizesmtp91t1741577543t5z8ofco
X-QQ-Originating-IP: +kaqd/DxV6IMruITGncQdVFlxOnMDUpyUV3edS5dF7k=
Received: from black-desk-ThinkPad-L14-Gen-2 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 10 Mar 2025 11:32:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11214409611350112389
Date: Mon, 10 Mar 2025 11:32:20 +0800
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sasha Levin <sashal@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Jann Horn <jannh@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] lib/buildid: Handle memfd_secret() files in
 build_id_parse()
Message-ID: <6C251C41A8C9FE1F+Z85dRCJilpuUgaWZ@black-desk-ThinkPad-L14-Gen-2>
References: <0E394E84CB1C5456+20250306050701.314895-1-chenlinxuan@deepin.org>
 <20250306150811.a2a5fbf0919f06fb5f08178a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306150811.a2a5fbf0919f06fb5f08178a@linux-foundation.org>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:deepin.org:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: OcNFEUcu5uzrK2I3tdT6RfAcrfei6Q7LGW/QCKI7V4jWf0PxKLj6Yeqv
	s8KtE8p9bGRNwRAYKe+QX9SAgTXbYCw2kM/ElcXr+7630VdI2XG+J4CIj6vbKXYqp+sKoSw
	cjz0r46ksvGR6k7j3y+1B7+byk/70r4KSiOmQLW1dy+zQycQh1tuZyzJQ7aSH8xw/oRGrtk
	4vcgvQ1TzgpuEtToI5tH04Jy7p9Az7RcGkz8g6DHuwFvh8/DiVFTKFFY1hR1HNtjOK8wFEp
	yTWj+PeNuX1tflJCZhzmczg4yJuQf/FFozVjLlNM3kp77mtJ4Fhl9XEX5v8PN0PT+3qOUpS
	LsYgD1nFQ3kI5O4JHiH7XGnIK40IutltKEmstHJyjFLeBNJB0jQIzX9gICF8+FGQ4QwTVDq
	UixNKslt6YLdtDf6FI9cNrJpPTnCniD0f0WodJRo+9s1P8PfJtaJxr894slXU5oRzg1noYY
	e/1Za6AVpNhO6mrmNqzieHhul2qTaNGrGh78ens6Bkg0dRt6Ck8yUxLQGqx2yazQAnpCOay
	eKPrCuTiuEFkqT86MlXhmqfhHOkazWXqZ21PPdIGgCUV9xO7jO5DxSvj77cj1aNee1Hlrcs
	Ep3NcRuHRBar5XgfRMuiWySmqtr0ChLOsxq11+6lSLF+ApWw8Cv8vOY4YpY0OrVjySwKUM0
	2ayJrXeOZ7XZ3y6zojSE5ROEUwIsUulJnRmyGrUQbIpgDpBDiMnIpf0a0kFJoXE35/SjZXu
	bAKruw7RNpzRLGW78XGd/HNuYb5QNn81s2I8/2vHghIYeAxaxN3wfoczNeWYfabQ4Cgq/IR
	F9RHGBARzppryho647UIJ6PVb4klfb/9OiYOxEUxMpnxOATW8Pp7L+RdcCE0Xr5jmvmrc+Q
	MenQjgo7tBFuUEhet1yCr7Z9bGo9QwFM76gqWMxwPEkfy8TNVeIDkUdFkj0lRHyUj0tf3kP
	Hh2qcd722HDuN9RnxqK894sn6+OBeso+ta90=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Thu, Mar 06, 2025 at 03:08:11PM -0800, Andrew Morton wrote:
> On Thu,  6 Mar 2025 13:06:58 +0800 Chen Linxuan <chenlinxuan@deepin.org> wrote:
> 
> > Backport of a similar change from commit 5ac9b4e935df ("lib/buildid:
> > Handle memfd_secret() files in build_id_parse()") to address an issue
> > where accessing secret memfd contents through build_id_parse() would
> > trigger faults.
> > 
> > Original report and repro can be found in [0].
> > 
> >   [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
> > 
> > This repro will cause BUG: unable to handle kernel paging request in
> > build_id_parse in 5.15/6.1/6.6.
> > 
> > ...
> >
> > --- a/lib/buildid.c
> > +++ b/lib/buildid.c
> > @@ -157,6 +157,12 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
> >  	if (!vma->vm_file)
> >  		return -EINVAL;
> >  
> > +#ifdef CONFIG_SECRETMEM
> > +	/* reject secretmem folios created with memfd_secret() */
> > +	if (vma->vm_file->f_mapping->a_ops == &secretmem_aops)
> > +		return -EFAULT;
> > +#endif
> > +
> >  	page = find_get_page(vma->vm_file->f_mapping, 0);
> >  	if (!page)
> >  		return -EFAULT;	/* page not mapped */
> 
> Please redo this against a current kernel?  build_id_parse() has
> changed a lot.

stable/linux-6.13.y and stable/linux-6.12.y has commit 5ac9b4e935df
("lib/buildid: Handle memfd_secret() files in build_id_parse()").

stable/linux-5.10.y and stable/linux-5.4.y do not have memfd_secret(2) feature,
so this patch is not needed.

> 
> 

