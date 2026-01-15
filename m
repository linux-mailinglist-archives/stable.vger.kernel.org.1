Return-Path: <stable+bounces-208419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A228D22786
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 06:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E870B302687A
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 05:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D429283FCD;
	Thu, 15 Jan 2026 05:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GLsVxRdl"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4BD1FC8;
	Thu, 15 Jan 2026 05:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768456654; cv=none; b=I6BjuSz6tdlVRM+M1BBHvWXXoaRwQHPhZKNkL2naXI+xkvn7Fwv16RLliBZ3c41PMn9dP4gx7Gg0LnOBzuG0tacunlN7Qpc3NtID0euU9PGWxdfZX5Ao7ogcKYPq4JsfS5HTbYtiTWFW7YaDFtjPtCMn7f3bxScplpxtyBcNLc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768456654; c=relaxed/simple;
	bh=qa/591coTB/6k+u6J/aC/Wx1kILLrBPmfxuxKkf+6KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIUX+gJgHyXVdThTxXqKddS2V0INaJ7/YocTquUr3ifGTb2URqp/yxAckdWkVFn/DG3VZ86IQrGrh/X1hErawxHmjKuP5hZdfXyvJ7KGQrK+8xi81RCU/kEaJBSGrw8MkY+050fKqO1czbpwyZ0rR0WUyuUWUDw2vnAGr5Qmk40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GLsVxRdl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aO8IjEV3AqaUA0VAtyH8dY/Ue4Mm0DNZe+SgvViKDiA=; b=GLsVxRdlINgsZk8FkEJlY5nY1L
	pockPlKwDJGFY6IYuwUcG8wytD9keK+kxdBhlyowFAGYqkf7+vP2dlbA0GDAeBi6PUTOD8mDKLzVQ
	ihdt4lIZfZnjl25nQosn1LR5St0WHx2jSZvsxnbFrlq3BRCvrLOQTBY+MXPLLCUPM+NY3bMz6ky6a
	8ekt7ybnielyOFl6c7kVnoMuwaPtLqJQE3Lx6qB8MUTrn+xaQiywvEuwEZbKEVjcZXAid1Ul82332
	6Lrodjb4XaYIjnQTbFpVFCpceorf4cP4WhVivwqevRVss1wCn2DKr7cxSN8qJLRFtvc4v3Ru5dVEr
	Muy6BCGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgGMB-00000007HBi-29MT;
	Thu, 15 Jan 2026 05:57:19 +0000
Date: Thu, 15 Jan 2026 05:57:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net,
	ranxiaokai627@163.com, ran.xiaokai@zte.com.cn,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] Docs/mm/allocation-profiling: describe sysctrl
 limitations in debug mode
Message-ID: <aWiBv4A4QGJ1pr1l@casper.infradead.org>
References: <20260115054557.2127777-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115054557.2127777-1-surenb@google.com>

On Wed, Jan 14, 2026 at 09:45:57PM -0800, Suren Baghdasaryan wrote:
> +  warnings produces by allocations made while profiling is disabled and freed

"produced"

