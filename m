Return-Path: <stable+bounces-106143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5CB9FCBB2
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 16:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1628D1883302
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 15:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2E3126C02;
	Thu, 26 Dec 2024 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lig9ew/N"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C312E5B
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735228593; cv=none; b=tgPY1FsK07DM6kKoU4/vJt5HKarInIfilFWOsiXkGXlsEfOLOgWOrv047cPbiidtSBP9Z4VF+T9rBIEab7qbZZkSDnKqRxqTP3LmjzvKUHyy9SPsvyionFS3E5zxpKJL493GI+dVJUSLQKyo4YdmgYY5rro/2gkTTqinkClOAXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735228593; c=relaxed/simple;
	bh=Z1E7wOFusf02uZPhEjpfw3Zg536Sev2b5MYrYBr22NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqwRMIUqO83HRyyUURjHoVteveujfvt8iWiCRtWA4xGLs3+KqeFTpdhxFHAax2NI0SCgBOmhlQa95mX9E1b1cYu/0RunCI9uiIBYOo3wUEend7kSBzipj/Hhe8zXxrBTEGLs1e3ZLvsBMpGabxdnppTH8ckYvnEAoy4O388S2EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lig9ew/N; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6SrMnZfIWhOBA5+CRBZEMSEpRV/wGl0a9aXOi3cN0e4=; b=Lig9ew/ND8dkwKhEAuvJk+nflj
	SM/+38pwRwR6tJw1OtFxiN3AOEMo+j8o1VTCIfSf+IizesE8vDbnV1WfeCndQzp3VgMa3DEsE0Xd3
	bmEiBsD5fHYgGB31p9WEVE3y+YvA0ZLCh0n5qIy8ev6MRiDOgyFlRME0SD6bg3avFBNCQLDorW4Do
	X6m90WR3Ex3WxdQ7TzIB5KMaxNl/0KhrCfwV/Dg3j3QyBqaAEqKyO9lZ3VaMRJsSPQX/AIpPE8KBH
	WjSOu7jnW5KUleuV9UuY5wp7BsZhk0YEFU19lYAFeqvTk4tN7Hpjyp/7cqTw+LAj10DECMsF/zlaO
	lZT8dxaA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tQqDm-0000000Br3U-3vDE;
	Thu, 26 Dec 2024 15:56:22 +0000
Date: Thu, 26 Dec 2024 15:56:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] vmalloc: fix accounting with i915
Message-ID: <Z218psbww0eNEkhs@casper.infradead.org>
References: <20241223200729.4000320-1-willy@infradead.org>
 <20241225183106-cee20b35fc2f9d72@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241225183106-cee20b35fc2f9d72@stable.kernel.org>

On Wed, Dec 25, 2024 at 08:21:56PM -0500, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Found matching upstream commit: a2e740e216f5bf49ccb83b6d490c72a340558a43
> 
> WARNING: Author mismatch between patch and found commit:
> Backport author: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Commit author: Matthew Wilcox (Oracle) <willy@infradead.org>

Do I need to adjust my tooling, or do you?

