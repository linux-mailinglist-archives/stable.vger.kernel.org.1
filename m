Return-Path: <stable+bounces-89557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55FD9B9D8C
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 08:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E245B216D3
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 07:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F057602D;
	Sat,  2 Nov 2024 07:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Rqv7k7GC"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8A21F94A
	for <stable@vger.kernel.org>; Sat,  2 Nov 2024 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730530969; cv=none; b=AM9q8pEYzX7wAViE/F9PgxCK8obYuv2tNokxyHYR+V+MFeW88k0V1mM92qKCguNMO0g53lHonpY3xR4LvcM/81x7nLtQNFJZpm7Pux36G0tAtdcNfo7IzKIZ2nhOzj8rDA8reODLzHaUf2/D4RF4IrHKGzFWZOSoi3safUesfjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730530969; c=relaxed/simple;
	bh=6qgIP8JEmjmucwFT9AXCLyUvK1DRDTiN4RH2aRExwxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELlPvPq6cNrUVy3C7AakOXqJphGZkuVVxR5h/7fnfX//W95z+sW6/Eg8aCtrRFID8HvK7+Wy11xJJk1AbP248hlMsqwRpN9UjPsWh4VqdjJp7CTYxyS8IpKQSd0JQE4oxhx7Zf7QLx72x/YoEborGhvir1iBOi9/LP4lxnie+N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Rqv7k7GC; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id DD3F614C1E1;
	Sat,  2 Nov 2024 08:02:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1730530965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wMxrZV+pjZ0+aq2vXiiJbHJNjQKrDjvPSdgBmRqBGtw=;
	b=Rqv7k7GCE/0AUTQ8ZwBt/DQ8V/gWrrGeddyFdzcthYOUcJqyGybc6J1Fchz3iaChl0ejh0
	rj+mUJByLa7cLec83M6dTbnz54H7cBRH6vYH5z6jVK57qVj63254Vuxg/lSCRAEaKszZdb
	ycCgRWxIHggYU6/BpHwsZnTcuQEjPOc33fPcvhphHfiFdi1Hknon4W8nUAYDv6Nvu0FnHR
	gJpBOiXkcRk9u6O5lEXR2fW+tSyfSCxFLG4zUmhPhxdwFiZPJUqRppzZe/qYc2faZvYOUN
	sa/SZ5Dc2tQ4+k+xTtpY0HdYORGb0Gk9FRCsiN8yxJocK9oWgLP2diFGpE+ayQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 1a7914d1;
	Sat, 2 Nov 2024 07:02:42 +0000 (UTC)
Date: Sat, 2 Nov 2024 16:02:27 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 6.6] SUNRPC: Remove BUG_ON call sites
Message-ID: <ZyXOg2gepysQBic0@codewreck.org>
References: <20241102065203.13291-1-asmadeus@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241102065203.13291-1-asmadeus@codewreck.org>

Dominique Martinet wrote on Sat, Nov 02, 2024 at 03:52:03PM +0900:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> [ Upstream commit 789ce196a31dd13276076762204bee87df893e53 ]
> 
> There is no need to take down the whole system for these assertions.
> 
> I'd rather not attempt a heroic save here, as some bug has occurred
> that has left the transport data structures in an unknown state.
> Just warn and then leak the left-over resources.
> 
> Acked-by: Christian Brauner <brauner@kernel.org>
> Reviewed-by: NeilBrown <neilb@suse.de>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

grmbl, missing my signed-off, sorry:
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

hopefully didn't miss anything else..

-- 
Dominique

