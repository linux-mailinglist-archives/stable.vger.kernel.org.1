Return-Path: <stable+bounces-196969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 012D8C88634
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 08:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D9364356DBF
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 07:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAD229E0F8;
	Wed, 26 Nov 2025 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uqITr1BT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700D828D82A;
	Wed, 26 Nov 2025 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764141437; cv=none; b=S0cYP0tjKrEGsfUkK63wXesg3/Aa1dq4fGEfEqsHNXE9QJWCmaru6wrOwxfVO+AsmNrw1n/5W6qCibKO83xsc3au6lsepMRJj6snoLBrtWA7jXR26I0qGpDCJXW60pKrMM0zcEbqFzVcpT+zeiRMzih/b6Vfq9X2NKGWlnPXyXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764141437; c=relaxed/simple;
	bh=lZVJ2cpnsI8ZVQI7FPRnQ0U4EeO/hgr8ItzeLdu6NM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwrXetRvGWZE9CoBdV6jdwhNXhPrDAsyz6acLp9+dkUCYFd93Bf8wbJ7aZYGCRSL4dlNsA442Fw54VlPHrMOymbGm4uAay6qyZMuDlOltCnS4+O4hIzR9t98yyxsrZMWOOYgFfGOl6BwqwITBEBsOxR/8tfJm/YkZkYjN1FCJf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uqITr1BT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814A1C113D0;
	Wed, 26 Nov 2025 07:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764141436;
	bh=lZVJ2cpnsI8ZVQI7FPRnQ0U4EeO/hgr8ItzeLdu6NM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uqITr1BTGuQAQuZFPiADldUhOgWw3eSwHuI8QL0ONUUIXpoZhQzUxpj2ZS4u+UBbx
	 XYeG9ZFl1Lm5Tb0bMeyGaKDaRVALhp60UyAYOIYiXBlYzmvde3uuM8otwssL12aE9G
	 Ge2z1tkOkBORQwjjtNjmogVTa4XT237UeZL5qfdY=
Date: Wed, 26 Nov 2025 08:17:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y 2/2] Revert "block: don't add or resize partition
 on the disk with GENHD_FL_NO_PART"
Message-ID: <2025112659-oxidize-turkey-c005@gregkh>
References: <20251126065901.243156-1-gulam.mohamed@oracle.com>
 <20251126065901.243156-2-gulam.mohamed@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126065901.243156-2-gulam.mohamed@oracle.com>

On Wed, Nov 26, 2025 at 06:59:01AM +0000, Gulam Mohamed wrote:
> This reverts commit 1a721de8489fa559ff4471f73c58bb74ac5580d3.
> 

No reason is given, which is not ok :(

