Return-Path: <stable+bounces-116786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BED3A39E76
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 15:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A7C172B64
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 14:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374EE26A0BE;
	Tue, 18 Feb 2025 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b="SWIvw2eh"
X-Original-To: stable@vger.kernel.org
Received: from minute.unseen.parts (minute.unseen.parts [139.162.151.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244F2266F19
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.151.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888119; cv=none; b=O84r6RFQO42W20n74oojnbURzJTLIw2z/cbBh581ald42+zwvN6CBKgIunyLFbsU3jJyYohY7/1pvJvUw19Xf3x2V2XN9FA+28vTqgod6pbX577wpEtK1W2fRxI0twt0TbZlzaKN7vp+uLXQoyiBYPXDONik3MRcG63w6Y4cc/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888119; c=relaxed/simple;
	bh=GDKT822rN6XmFSdk9pc7uLHWMJcbcfaj0xL5xHlyX3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3+CaFT1i48vRIgu+ktQYzHcUnmMmgVDR2KPwV43fwQC9HrqLXELmfI/RHYPvhjZ1aImBbkQpNlxLr/oKUP/MPBxBYURX5mgW8QwUCbvpKu2TAav4ZDHnJW3JsKVgGpmtj63tL6iG6uULrbIvdcbEGEKRr6cQ9N0EjEf+gaIF2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts; spf=pass smtp.mailfrom=unseen.parts; dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b=SWIvw2eh; arc=none smtp.client-ip=139.162.151.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unseen.parts
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=unseen.parts; s=sig; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kDuaUjBKkfniwOL63PWXizVIL9kQq7TJasYwZpiiDAM=; b=SWIvw2ehFop2jQvJRe9vbASers
	pxeO+LdJj4YIJNvUDc/sbtQZBt3WdYj8sDlQsCoVWGi/HN7LRHFJNTxSAGFTfbxwc0YsW0zJFvwrI
	fWQcfc5OZumvlkgbITGSJucm26cazGcEPdDfuxVcq4zRlA0iJHgnHQNSNbbmyRoOZlvOwqeFfaQgL
	QNyPLl8NiEmXwzgyrQIJWds4WkTW4UFVgaXMqdnOvo1DrIQDghlU5Wlvw4cLg9/dlvpzQAEDsg8p0
	DGzPlEiXiEMQlJ0zAwif5ih4vh1+3fmVKqGO+0KxaaW55m/lihDZvkBY7SZ55qfIK80UjEQXfsaOp
	MeZBd9Yg==;
Received: from minute.unseen.parts ([139.162.151.61]:47592 helo=minute)
	by minute.unseen.parts with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <ink@unseen.parts>)
	id 1tkNq4-00057K-05;
	Tue, 18 Feb 2025 14:40:40 +0100
Date: Tue, 18 Feb 2025 14:40:38 +0100
From: Ivan Kokshaysky <ink@unseen.parts>
To: gregkh@linuxfoundation.org
Cc: linmag7@gmail.com, macro@orcam.me.uk, mattst88@gmail.com,
	stable@vger.kernel.org
Subject: Re: Patch "alpha: make stack 16-byte aligned (most cases)" has been
 added to the 6.6-stable tree
Message-ID: <Z7SN1kaT-1tuYyvL@minute>
References: <2025021844-cruelness-freedom-e051@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025021844-cruelness-freedom-e051@gregkh>

On Tue, Feb 18, 2025 at 01:55:45PM +0100, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     alpha: make stack 16-byte aligned (most cases)

Hi Greg, thanks for applying this!

> Patches currently in stable-queue which might be from ink@unseen.parts are
> 
> queue-6.6/alpha-make-stack-16-byte-aligned-most-cases.patch
> queue-6.6/alpha-align-stack-for-page-fault-and-user-unaligned-trap-handlers.patch

The third one (commit 77b823fa619f97d alpha: replace hardcoded stack offsets
with autogenerated ones) is also needed, but it won't apply as-is to 6.6
and older kernels.

Do you want me to provide the patches?

Ivan.

