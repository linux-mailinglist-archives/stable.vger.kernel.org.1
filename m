Return-Path: <stable+bounces-128330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9525A7BFF4
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 16:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FCAB1897FED
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 14:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD271F2C5F;
	Fri,  4 Apr 2025 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CwJ0rmQk"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF64D1624C9
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743778441; cv=none; b=UWnOJDt/mZPYseiax7eDuP8KvKCLmSiSBXXw7YExzv5VNUPVBPic+SLCAc84CIB+H67VX3+Vd7bFbUc9YIaBLZz4Sla6agwBNGloXiV5Kzg29SD/J7mXkNa2o2nWNYhXfVvt+FFw9+tafyNnDeAgkZ8pHgVblliM4t6eALvVIPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743778441; c=relaxed/simple;
	bh=OrWnd/AIVtyfUtf1QWN2C81czHbvbqvK7PUNeJ9GhF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFOidTJ3hz4DVugYBL40HxV7MhHncqtmG5zsFGOENDGWWv9aFkI8X8BiPQyb1OaDfBqdmo2i2bDe+k0QQN9JcApfJCCfPTHolsxrxQD+QS4cNZ5KCjDfAfyGy5dOgTGSPBCOcgZ0BBTXua6wGA9EfyL/1UFBfWqQoxQJJhhJRzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CwJ0rmQk; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 4 Apr 2025 10:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743778436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLg5PeIHaOFt5pMV3h7TuWebvpx5Qt/dpEM9TkWrbCE=;
	b=CwJ0rmQkxjYRT553nTryoJSNAzsdF8H2gJNSaJR/gcpqWQ94BABcs5MT+REOCYDXlygGQS
	yvcVVNZRGFvbzD8B0H0cihCjYmNC+tJ9GGtr/ucNRm/Gxpzdtrf7H/b+wWOAtACm0sa/wu
	cpVjy01KufTkkqf+CDOk6BKFmL24H+s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-bcachefs@vger.kernel.org, vulab@iscas.ac.cn, 
	stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bcachefs: Add error handling for zlib_deflateInit2()
Message-ID: <morzv5ulzvkdpkegs33bwdocnn3hftxviqmw4wkvlh2qnsfagd@trk7lpvqj37k>
References: <xjtejtaya3znotupznz4eywstkjvucxwyo2gf4b6phcwq6a2i5@pqicczp3ty5g>
 <667bcd67-aac4-425c-b100-d25dc86eb6a9@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <667bcd67-aac4-425c-b100-d25dc86eb6a9@web.de>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 04, 2025 at 04:20:18PM +0200, Markus Elfring wrote:
> …
> > > Add an error check and return 0 immediately if the initialzation fails.
> >
> > Applied
> 
> Did you try to avoid a typo in such a change description?

Typos add character :)

