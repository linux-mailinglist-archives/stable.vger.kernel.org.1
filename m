Return-Path: <stable+bounces-131860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51566A81854
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 00:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CBA3B963C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 22:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B48255229;
	Tue,  8 Apr 2025 22:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=infradead.org header.i=@infradead.org header.b="G5Cr5lfe"
X-Original-To: stable@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E547158553;
	Tue,  8 Apr 2025 22:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744150466; cv=none; b=jsUm/fvIIn92Lo4LQVV+nmXxDxWn4DElTLZGV7c4rvlh3zRvMoE5TNdpACorkYHI0IAsp8iPiyxbD8hbhMexf2+QGfIMqrudaTqlN4tE3HMBCn0jo6P3ow9frTZ8Yrp0qi8RyjRFbfFvPwVcvzaCftZezZ17IywlZWUf4/b5zg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744150466; c=relaxed/simple;
	bh=h6OUWfH9bkEVenvzKXPsteivr+5vcS2pdno177S4AFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEmC57+oqJ2YG8d/7y2HqUM17VV+am2Lvz8GXin+Nj0G4ONeK1xIP9PyvG/9lApTku65pJDqd6pwOiYtwylJ2ALKjFvBiC3wsM8ehqhtApTFLWy262/rBk2HSCI8UEeCjwo8SA/jCvJ7GffsaNrwJ4L1DY19zhTtWJhJiShAXwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=fail (0-bit key) header.d=infradead.org header.i=@infradead.org header.b=G5Cr5lfe reason="key not found in DNS"; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JJTPoSkqNHMtiX/zYtvMS3ntWOB/PD2FIjNm5ror4bg=; b=G5Cr5lfeQaUHq+CuFjulR5ofdq
	bkEJl7G4QcuJY1CLEz4bUAA/8VZfaVRTAU9AsF/BL9Q8jP5OSsZ55v2luwpuacvNYIch+toMNhohH
	0Od+7jglB3FFl8P19arusEFYHbBscJjfFBueZD3BFzX2witSdxd4ZiWJBa3dUQPGj3wZHqSpgrnkJ
	cbsmsryos5AYvuY4jqv7ZXyQeCHHrt//39Z5zKQdIxkfwMAV+Vy0J/x0qsFYaqyTfJw0kXX9dzVhL
	JTg5HYU98BdAT7igch3CSIUJQcsKGhN9Xu32BDFUNW5zWJwbAXRhq0Kdqwg3lmQiv3ZD9MLtR3ofd
	ZYevz/ZA==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2HD1-00000002ZwH-24Sj;
	Tue, 08 Apr 2025 22:14:19 +0000
Date: Tue, 8 Apr 2025 15:14:16 -0700
From: Joel Becker <jlbec@evilplan.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] configfs: Do not override creating attribute file
 failure in populate_attrs()
Message-ID: <Z_WfuMDl2IIxYEOd@google.com>
Mail-Followup-To: Zijun Hu <zijun_hu@icloud.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
References: <20250408-fix_configfs-v1-0-5a4c88805df7@quicinc.com>
 <20250408-fix_configfs-v1-2-5a4c88805df7@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408-fix_configfs-v1-2-5a4c88805df7@quicinc.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>

On Tue, Apr 08, 2025 at 09:26:08PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> populate_attrs() may override failure for creating attribute files
> by success for creating subsequent bin attribute files, and have
> wrong return value.
> 
> Fix by creating bin attribute files under successfully creating
> attribute files.
> 
> Fixes: 03607ace807b ("configfs: implement binary attributes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Reviewed-by: Joel Becker <jlbec@evilplan.org>

> ---
>  fs/configfs/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 0a011bdad98c492227859ff328d61aeed2071e24..64272d3946cc40757dca063190829958517eceb3 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -619,7 +619,7 @@ static int populate_attrs(struct config_item *item)
>  				break;
>  		}
>  	}
> -	if (t->ct_bin_attrs) {
> +	if (!error && t->ct_bin_attrs) {
>  		for (i = 0; (bin_attr = t->ct_bin_attrs[i]) != NULL; i++) {
>  			if (ops && ops->is_bin_visible && !ops->is_bin_visible(item, bin_attr, i))
>  				continue;
> 
> -- 
> 2.34.1
> 

-- 

Life's Little Instruction Book #511

	"Call your mother."

			http://www.jlbec.org/
			jlbec@evilplan.org

