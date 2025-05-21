Return-Path: <stable+bounces-145926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF468ABFC5F
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 19:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A36C1BA42D7
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5FA22E004;
	Wed, 21 May 2025 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="S5JAgwNm"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2488A1DF754;
	Wed, 21 May 2025 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747849047; cv=none; b=dJ59iZUlC5fSWDR5jg1864UIBJz3jUwVPeGnxvlIfSR+diejDs9Rs/N24batcAiGnwrh9kCeqMty0yEC9AvMiKm2Z6fW9BqpxtOGMgwwAFvz0dmUQ4lq15CjOho6AsmPeDdZWTrnlyvpe3wd9tPTGjjoD32nQcX7BcAnhZrGVeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747849047; c=relaxed/simple;
	bh=6DYtum/yE8yw0XIB5NJUai4hbQwmsNyiPVNlaXG29oo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0kYNwTKmc2fTCQNGA2/6FJFySPxi5VcRC0XxRsUccID1UEqhiMIs68yNdxW1S7SKlRrGXTbnFolgu2VwPCOJAq6DTK2AswJRqvduoe8zTr5LoSk8cNEbnCS8/3ejrHi/zh3PLPDlnCjolrxWZn3KiQBm9DzqJLxwfzicLqb1A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=S5JAgwNm; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Wed, 21 May 2025 19:37:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1747849044;
	bh=6DYtum/yE8yw0XIB5NJUai4hbQwmsNyiPVNlaXG29oo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=S5JAgwNmNEhNASMFkrf9O4xu04ayT8H1GkteUmvTVyIJjmL3z4+OSSWnzYBPooZHX
	 mVWVMgtwmrmxi4Y70JVxfM5j+aGp9DMVFf39aUyG/FE0DK4vehtwZ3fyEAeu/N0IFm
	 p7IR8qi2+ycD5sXsAFzgGRpo7+4MVnrJFQhahayB7QCdSNYEqbJOM/NaC0UC94+c2Z
	 u5FzRzwtcty5NepGUjkemQq5JAb5Al9tpcRe6M+ixKzz72iEHM01C8spCEm54bycFu
	 c4mhwPCGn/4K3/m71t960YteURf+TzsWzcIWmNJtUNrzeq63Q/kuWejiG0clIKa0kN
	 3z0e8docU6tJQ==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12 000/143] 6.12.30-rc1 review
Message-ID: <20250521173723.GB27779@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250520125810.036375422@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520125810.036375422@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.12.30 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> Anything received after that time might be too late.

Hi Greg

6.12.30-rc1 compiles, boots and runs here on x86_64 (AMD Ryzen 5 7520U,
Slackware64-current), no regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

