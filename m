Return-Path: <stable+bounces-106797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFCCA02237
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 10:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5F318851EE
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 09:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF421D90B3;
	Mon,  6 Jan 2025 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R/LRhzBp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D201D88D7;
	Mon,  6 Jan 2025 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157155; cv=none; b=TEmXKoXZqm1CncW9fIiFstldJCRXisHOAFyc4y1toWFO68Mg6YBRvrJW+Fjz8PDkQokyzHAhRj1bulu6K+F/v5wA2tgX7zdrU0sQqAeyewZw4rtEN9cjw/vsusZNfdxmXBZaQ96xzlq9gSqLQuDwN834l/VgSDUCu2AW1zA3Od8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157155; c=relaxed/simple;
	bh=820CrXNTGNBNEepgfRcK78cM3v0TjRNoIqaNjVG4qwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UF8rYvY1qe9Rfv7CaF15YaDYVgr0BfZY338+QPRS7NazqWqvS6csQ1R0mRAPoEETmOAq6GWv9qEd945nHARvWgHp0DSXg0tf4iNVz0ZQLD+FDcyTs3aeYai2MkmyDQDDBPb9OM5EU846i9KIvSdx8fRfHVj9YjI6qVvfJgknPEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R/LRhzBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC85C4CED2;
	Mon,  6 Jan 2025 09:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736157155;
	bh=820CrXNTGNBNEepgfRcK78cM3v0TjRNoIqaNjVG4qwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R/LRhzBp+XyZEuK5ccfnlPwSxTO70eLIT9Qh9RQHyonWRYT80MqfxTewrES4cq0n2
	 hoL52gRxK88VpwfR2DgToNuPf3HYrROhzwnEp+QPBhFszFYuKsxLTk3tlnlwXhdLrR
	 2oHrMPw1OB9nmLdzq241IkTQg5AgYqyuvte2relc=
Date: Mon, 6 Jan 2025 10:52:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: wujing <realwujing@qq.com>
Cc: sasha.levin@linux.microsoft.com, mingo@redhat.com, peterz@infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	QiLiang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH] sched/fair: Fix ksmd and kthreadd running on isolated
 CPU0 on arm64 systems
Message-ID: <2025010651-baton-cardinal-a952@gregkh>
References: <tencent_521DBA5B61506A63077CEC4EE730C53BCD09@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_521DBA5B61506A63077CEC4EE730C53BCD09@qq.com>

On Mon, Jan 06, 2025 at 05:24:21PM +0800, wujing wrote:
> This bug can be reproduced on Kunpeng arm64 and Phytium arm physical machines,
> as well as in virtual machine environments, based on the linux-4.19.y stable
> branch:

Again, 4.19.y is long end-of-life.

Also, always do your development work on the latest kernel version, this
is documented well in the source tree, right?

thanks,

greg k-h

