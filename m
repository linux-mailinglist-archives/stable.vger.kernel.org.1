Return-Path: <stable+bounces-78636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2FC98D22B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D1B1F2176A
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 11:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE40B1EBFE9;
	Wed,  2 Oct 2024 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bgjtZYob"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E191E7646
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727868115; cv=none; b=XE+084BECn25O0jJo8ycqQAw8Aj0VBK/IQRUk6Qvyq3sXWNRwpiBICf82rDtpktpgDwg/BMDNWbp+6nMh1BgqMDmUOk69y4iSZRUoAH1K5rWNZiN2+VJ8JoIX9+NgZZS6UwdM3SEc0AKIkSW/bZcwkXbqqDzmpEpSoUKlKto4Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727868115; c=relaxed/simple;
	bh=LeUqExmFTTxHBplRamalU2LLpa6PCOYyCs6unNadn24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHu/g9XWXe4KgdMN2crVjJtU5UYmc+L713YXSpU3kxj0LUc87X2FUrnCRq35smItwvlIYy6dW9QVcj0Z77BxxmVV/eCvhYdJyXG3vxBDUmINWnfyyxgAQeZBjy29FTsrziwj648rOb925FrmKuWoM1WKfdw8g99ZljR5XNBr18M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bgjtZYob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BFDC4CEC5;
	Wed,  2 Oct 2024 11:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727868114;
	bh=LeUqExmFTTxHBplRamalU2LLpa6PCOYyCs6unNadn24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bgjtZYobiCnkuQcLxqqXS8RQRvmSl1tWzsGWzziTLEUfu8GDDuZyuD8DrKYebuijm
	 pC5fJjS5hKnQb1jm20ZCKwMLMkM7wd1i915a4tX+fbpWTFxQ0htlo1z3B2ye8+J8BQ
	 G4EBn8nehJ5baLvucM7wqLT4BAbJgH3XGPEos6vI=
Date: Wed, 2 Oct 2024 13:21:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, jolsa@kernel.org, peterz@infradead.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] bpf: Fix use-after-free in
 bpf_uprobe_multi_link_attach()" failed to apply to 6.11-stable tree
Message-ID: <2024100244-encrypt-unmovable-2a7a@gregkh>
References: <2024100247-spray-enjoyable-b1d0@gregkh>
 <20241002103905.GC27552@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002103905.GC27552@redhat.com>

On Wed, Oct 02, 2024 at 12:39:07PM +0200, Oleg Nesterov wrote:
> Hi Greg,
> 
> On 10/02, gregkh@linuxfoundation.org wrote:
> >
> > The patch below does not apply to the 6.11-stable tree.
> 
> Please see the attached patch. Should work for 6.11 and the previous versions.

Now queued up, thanks.

greg k-h

