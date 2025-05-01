Return-Path: <stable+bounces-139339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E46AA6298
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E92986DE9
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4443521B9C2;
	Thu,  1 May 2025 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gcg0pviR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D0D2DC799
	for <stable@vger.kernel.org>; Thu,  1 May 2025 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746122683; cv=none; b=nIX3YYnl3grJudiIMn4TFdJPTa9LMCcpQ5HFnGN5XP0mvjg4Ury7BTBelJddhYGtFEoTYXFdXcuDzils266s0PPaHmu4WBhNYgsB7TGdTxnbijHQQVt0yQtwaMXGa4ZHMvtjo91HmswmxYk80FEgEw+NEB+8UPC6xc9LX1lOCWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746122683; c=relaxed/simple;
	bh=N9impHQHj2UF6Io5Ay56OSR+QHtrMIg6acWCBbzx1jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9kkpQFyqx4C2yT1l4PsNSA7u3U0r8tYazpoIRPkc3XVYzqiIhKlFHuGeQHumERv2KK5eQFcg6G+w9Vsx/rpKBSLykNqbWPQreoOgFcDgOOp8+W3eI0Sd9mKog8PBomkQLE53/v/owlZsgjIoSak18zqM1TuWeGVeQCkoyceN5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gcg0pviR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767CBC4CEE3;
	Thu,  1 May 2025 18:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746122682;
	bh=N9impHQHj2UF6Io5Ay56OSR+QHtrMIg6acWCBbzx1jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gcg0pviRgwixze/2V8RB44FOfBeXDQcVMVOoQM5DIzIbssTW8zHHAHfuw+HVF/T/G
	 880qzscWu0JvF+SsUGZ7zP/Wf7N6XqZKJqrJeU6PPtKHahDdP3i+GwwI1n9WXE1Fe8
	 nzUUzan2VUjIbod4VrFnti/YiS6eSdtEfr4hUzQ4=
Date: Thu, 1 May 2025 20:04:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: stable@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: Please backport 980a573621ea to 6.12, 6.14
Message-ID: <2025050151-recharger-cavity-b628@gregkh>
References: <CAAH4kHb8OUZKh6Dbkt4BEN6w927NjKrj60CSjjg_ayqq0nDdhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH4kHb8OUZKh6Dbkt4BEN6w927NjKrj60CSjjg_ayqq0nDdhA@mail.gmail.com>

On Thu, May 01, 2025 at 09:48:59AM -0700, Dionna Amalie Glaze wrote:
> 980a573621ea ("tpm: Make chip->{status,cancel,req_canceled} opt")
> 
> This is a dependent commit for the series of patches to add the AMD
> SEV-SNP SVSM vTPM device driver. Kernel 6.11 added SVSM support, but
> not support for the critical component for boot integrity that follows
> the SEV-SNP threat model. That series
> https://lore.kernel.org/all/20250410135118.133240-1-sgarzare@redhat.com/
> is applied at tip but is not yet in the mainline.

How does this fix a bug in these stable branches now?

> I have confirmed that this patch applies cleanly. Stefano's patch
> series needs a minor tweak to the first patch due to the changed
> surrounding function declarations in arch/x86/include/asm/sev.h
> https://github.com/deeglaze/amdese-linux/commits/vtpm612/
> I've independently tested the patches.

Have you read the stable kernel rules text?

totally confused,

greg k-h

