Return-Path: <stable+bounces-104010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7B39F0AAB
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC7016998B
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45D51C3C05;
	Fri, 13 Dec 2024 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MoFAcTxU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1B61B6547;
	Fri, 13 Dec 2024 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088530; cv=none; b=kjBs0zWgWhzwb/tLmwJr9Yk2tiAdSaXKnpt12IhF0eDHsljswT2kBOsK1dNtT220lbpnz70XygNg2vscRAfV/Xfs8RMfCZZOQfkrpMrU+3a1U3q3sLxvttMU40zPcH5auGtXdAPt2IpeZSKwx/un7pxCwt2OlYxP6afPbZ/1mIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088530; c=relaxed/simple;
	bh=BTlSxEGtHZYuTq7GAzKkcSl04qcfdN+0PqhmkCjEG9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HszG4a8uE/zwE1snwZGJOjAHeDRvOWCQq9bmUu5Y+mX4B+IYwvZh+gE7BSoFFytx2l8rqsrgOXEJotCAWxWCsUX//fAgczmSN34ngYot617zVw5hft9msByBG8XvyfODtyadMiTtk3xT3GmWuRYjWiIxY7EMrTldt8KJR+/r0S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MoFAcTxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB90C4CED0;
	Fri, 13 Dec 2024 11:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734088530;
	bh=BTlSxEGtHZYuTq7GAzKkcSl04qcfdN+0PqhmkCjEG9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MoFAcTxUm3bJTSh4WmQp1AqUGanXxrkwEhu8I2hNKlWwymLHHcB4/1R12KuSRg5Wn
	 A2OTXSOSYWGUfPYGJbvF2CZgDLoqR57wP4R5PGqznRJimxPRFLEEyTlgcAmn9VAWc3
	 0LRVW5lT26J8+nrY4AX6n1CY7XeDnu5S5hVfjVao=
Date: Fri, 13 Dec 2024 12:15:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: haixiao.yan.cn@eng.windriver.com
Cc: nathanl@linux.ibm.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
	paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	haixiao.yan.cn@windriver.com
Subject: Re: [PATCH] powerpc/rtas: Prevent Spectre v1 gadget construction in
 sys_rtas()
Message-ID: <2024121322-epileptic-feeble-75e8@gregkh>
References: <20241213034422.2916981-1-haixiao.yan.cn@eng.windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213034422.2916981-1-haixiao.yan.cn@eng.windriver.com>

On Fri, Dec 13, 2024 at 11:44:22AM +0800, haixiao.yan.cn@eng.windriver.com wrote:
> From: Nathan Lynch <nathanl@linux.ibm.com>
> 
> [ Upstream commit 0974d03eb479384466d828d65637814bee6b26d7 ]
> 


Now deleted, please see:
        https://lore.kernel.org/r/2024121322-conjuror-gap-b542@gregkh
for what you all need to do, TOGETHER, to get this fixed and so that I
can accept patches from your company in the future.

thanks,

greg k-h

