Return-Path: <stable+bounces-53818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789EA90E8B6
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F20286A11
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C376913210E;
	Wed, 19 Jun 2024 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vbgezun5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860074D8B2
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794457; cv=none; b=X73PS2ml9puFQhQvrgDQ0PxtcBTFwwicZsWyrRJEoNA6SoGMLUzi4w0YoIREIkyFtEMRah3wkktPX/l8y/AN291wdPHtcpT3OCXLL2okck36d0pnG6q+O+HcXEcgBG80GR3vTlcvwMO70WrZLbMd4xEjgRzXLEkafAosjIO/Wk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794457; c=relaxed/simple;
	bh=AS4R5+Kn5AOXCP7/IDS2va+JS5CbricxGwIUkyXjNy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwQid4jWC7ZEhjwdU8iP01V+joBDnlr7/59L4oOWrUhjYe9BENC/bTV0YL0hUzsOuSwS21A/o0T2Zskx9xNrul53uGWQAzWe04FzmacGrpg9KUq4d4ESZFRTj8kQOBlNXg2beOldIvY8reaRE8Xudb8gP3wmkuVH5O5LDX5m6BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vbgezun5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920F7C2BBFC;
	Wed, 19 Jun 2024 10:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718794457;
	bh=AS4R5+Kn5AOXCP7/IDS2va+JS5CbricxGwIUkyXjNy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vbgezun5gw9O2Y7lIl1l0F7e3tHWSoBVJ/4CY014WnNgIFLw3GImd3qsmugaCbFZY
	 tcjX66kn103R9WG7l0JdSWJKeKeyFwrBuDijQp1gxdY2wBodVwpCEeG3JoMKP+tlpv
	 TuG9rzduGIOJoxqnXeLscagXX733ZrtmoKT+AfjE=
Date: Wed, 19 Jun 2024 12:54:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sam James <sam@gentoo.org>
Cc: stable@vger.kernel.org, leah.rumancik@gmail.com,
	Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH 6.1] Revert "fork: defer linking file vma until vma is
 fully initialized"
Message-ID: <2024061905-hatbox-congrats-2274@gregkh>
References: <20240614084038.3133260-1-sam@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614084038.3133260-1-sam@gentoo.org>

On Fri, Jun 14, 2024 at 09:40:28AM +0100, Sam James wrote:
> This reverts commit 0c42f7e039aba3de6d7dbf92da708e2b2ecba557.
> 
> The backport is incomplete and causes xfstests failures. The consequences
> of the incomplete backport seem worse than the original issue, so pick
> the lesser evil and revert until a full backport is ready.
> 
> Link: https://lore.kernel.org/stable/20240604004751.3883227-1-leah.rumancik@gmail.com/
> Reported-by: Leah Rumancik <leah.rumancik@gmail.com>
> Signed-off-by: Sam James <sam@gentoo.org>
> ---
>  kernel/fork.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Both reverts now queued up, thanks.

greg k-h

