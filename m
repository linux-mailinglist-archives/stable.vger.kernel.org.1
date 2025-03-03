Return-Path: <stable+bounces-120259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAF2A4E53F
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC9EE7A4445
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B58283C90;
	Tue,  4 Mar 2025 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="QD19GFDn"
X-Original-To: stable@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC7E235BE4
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103548; cv=pass; b=h5IjHdDaKdZOvGpZQZJ9WGf/MoHs9Eizn5LaUX6iITbVD6lL6nugp2Yp6SLDiRH9PDkMmul218CbP0X8W7lbwBh3uBYaHOyU6a4JKAF9MeyVKgcBIACDAIEnvn+4z7dmGYCTBoU7iMwmkgfo6AVZQ+BLuy1XkokeUDGurFwtHuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103548; c=relaxed/simple;
	bh=n8yWBSeNdY0rOI4vvSlBkN6YAykxmLACOqUxhNgRe44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGsgOrnrVzoqC/bLGoH042HGoN5NovevL9EQzILOtGLUfApPf0AxHM/h9ZIL8BfmTdT3gQ7XivkkgIk3Bv2jKTHSFNQpjDjMqTkq5yjqFpakAmxNUQ1MI3E2X2/8/RhIZ7U7W9bvpSAzA4i9CIeJAwiAmz9mvvBW6u43LPMRquQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=QD19GFDn; arc=none smtp.client-ip=83.149.199.84; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 7A44240D287E
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 18:52:25 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gB11Zb2zG1dC
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 18:50:17 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 7C08C42741; Tue,  4 Mar 2025 18:50:08 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=QD19GFDn
X-Envelope-From: <linux-kernel+bounces-541261-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=QD19GFDn
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 97CEC42C5E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:20:09 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw1.itu.edu.tr (Postfix) with SMTP id DC9F93064C08
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:20:08 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D36757A2F9F
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E471F0E47;
	Mon,  3 Mar 2025 09:19:57 +0000 (UTC)
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC4D2E630;
	Mon,  3 Mar 2025 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993594; cv=none; b=oEgbW9v+QspnkOCa3fVxlSWuBN8mdB/8/Ue9VzVJTR4d3K823pXdLMt6yA4Si9+LCCoaRqPzfzuo8icCdEU7Tn2eU4AyOqzxZ16loP3L2jINB9ufs/aZ1RfUJuEQa8jGUGFa7lhtJQuXUr648sFW/SIm4DQ7S3VqRvgec247i3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993594; c=relaxed/simple;
	bh=n8yWBSeNdY0rOI4vvSlBkN6YAykxmLACOqUxhNgRe44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dG0XbB12fOyc2Gv7vWxexp3Bes+9hKCM22D1A+op3cMaok9NPXtQMGdj5FspGOfPwGKp2cHlkDT1zLd4dELYCC95rOP7p8Xsg77c7RgNTrNYNDK2KEdBFKvpJg6Sjz0au8ohVQ596kF6yBkkE9hD26HhqcmhlWjGlJdVOCSQ5gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=QD19GFDn; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.8])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8831B40777AA;
	Mon,  3 Mar 2025 09:19:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8831B40777AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1740993587;
	bh=yIKMCXjADGPI9vSNBDHS/nd+SYypPRjQI0Yuanov3Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QD19GFDnVVSEW2TPegnX5m+IPQD8wVX37hdWPaB/UAca3TyA7LdBSYAGiq90pL1UE
	 1EFflh50LWMZruaNbXDPr/WkuGwxpJq8R46YRtYmvz1OM7gawDBePpqo56iGTdn0r1
	 ldKi4jkplYJ34W28PyZRfaZniDUKOhvTrTERuJdA=
Date: Mon, 3 Mar 2025 12:19:47 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Alexey Panov <apanov@astralinux.ru>, stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Max Kellermann <max.kellermann@ionos.com>, 
	lvc-project@linuxtesting.org, syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com, 
	syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com, Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, 
	Yue Hu <huyue2@coolpad.com>, syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 6.1 1/2] erofs: handle overlapped pclusters out of
 crafted images properly
Message-ID: <whxlizkpoqifmcvjbxt35bnj5jpc5cx6wzy3nq47zteu5pefq3@umdsbzhl3wqm>
References: <20250228165103.26775-1-apanov@astralinux.ru>
 <20250228165103.26775-2-apanov@astralinux.ru>
 <kcsbxadkk4wow7554zonb6cjvzmkh2pbncsvioloucv3npvbtt@rpthpmo7cjja>
 <fb801c0f-105e-4aa7-80e2-fcf622179446@linux.alibaba.com>
 <3vutme7tf24cqdfbf4wjti22u6jfxjewe6gt4ufppp4xplyb5e@xls7aozstoqr>
 <0417518e-d02e-48a9-a9ce-8d2be53bc1bd@linux.alibaba.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0417518e-d02e-48a9-a9ce-8d2be53bc1bd@linux.alibaba.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gB11Zb2zG1dC
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741708232.42502@/1d6L0vSXVf5KqhzNBHsVg
X-ITU-MailScanner-SpamCheck: not spam

On Mon, 03. Mar 08:31, Gao Xiang wrote:
> On 2025/3/3 02:13, Fedor Pchelkin wrote:
> > My concern was that in 6.1 and 6.6 there is still a pattern at that
> > place, not directly related to 2080ca1ed3e4 ("erofs: tidy up
> > `struct z_erofs_bvec`"):
> > 
> > 1. checking ->private against Z_EROFS_PREALLOCATED_PAGE
> > 2. zeroing out ->private if the previous check holds true
> > 
> > // 6.1/6.6 fragment
> > 
> > 	if (page->private == Z_EROFS_PREALLOCATED_PAGE) {
> > 		WRITE_ONCE(pcl->compressed_bvecs[nr].page, page);
> > 		set_page_private(page, 0);
> > 		tocache = true;
> > 		goto out_tocache;
> > 	}
> > 
> > while the upstream patch changed the situation. If it's okay then no
> > remarks from me. Sorry for the noise..
> 
> Yeah, yet as I mentioned `set_page_private(page, 0);`
> seems redundant from the codebase, I'm fine with either
> way.

Somehow I've written that mail without seeing your last reply there first.
Now everything is clear.

I'll kindly ask Alexey to send the v2 with minor adjustments to
generally non-minor merge conflict resolutions and the backporter's
comment though.

And again, thanks for clarifying all this.


