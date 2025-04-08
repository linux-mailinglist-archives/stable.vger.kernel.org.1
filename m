Return-Path: <stable+bounces-131794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC729A81077
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 17:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810743AB103
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D9A222592;
	Tue,  8 Apr 2025 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="DMizq3nk"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F831E2843;
	Tue,  8 Apr 2025 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126763; cv=none; b=BavAeg1nkP6brQwc9tIrQLGvPESS57Q5jLk5/8qh0YT3bib1z5JTcJC6TmH/+MwJzHwhTnI/Tr5UGKxGYYwMjJUtUp1XHu0ovcqaAfd/K8s17oWpYp4ug4cYg9iy8aO8rficfAnAV2IV2fro07dD3JhR8cqCC7oCWvoVNk4R2eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126763; c=relaxed/simple;
	bh=T/c7YMnzvl7JCkQrC3lv7tQpT4cRqXNQDxlAHzzG+jM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcZj/O4GbVhUHZFW4B+7Qng+JxGwshYk1vbrhjJHk292YSnG3tPEfO+cKwv4vuxyV/6EP8V3nViljKpIVeQwwgBBYQWmhXDzKU/v4R5tNclFl4BahlQWpZjm6k+L5eTHwyteiWbCuYOFDCMBThYp/AjoDqMUF+B59vtq5PANlwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=DMizq3nk; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Tue, 8 Apr 2025 17:39:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1744126754;
	bh=T/c7YMnzvl7JCkQrC3lv7tQpT4cRqXNQDxlAHzzG+jM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=DMizq3nkpnPTg5BBVOmrKqePhHUKYmpTzFd1xRWKLd+qIYdgQzZekcks7uQbyT9Hh
	 IzPdh5hGPosvcRbFkt7ERBlMQdTQqik91+zQ+j4qc6zI8gkp0QIdY3PWLtO+kjUR85
	 R3XIsd6iSMtBuK9sTyd8cIwiwBUPSwaNEq2Au4CPpPeSnpfvdG4ALjZUyw4BZG3vui
	 Ix+R5XH0c/sG4NmFRVNG4UoQ/Nz8IZWO02brfLyHpfGAMxDWFO49Oy45+OpXcqqZZo
	 LcQmVSB4/9BZplMXgFqH3vHe7vGzm/6kl5R8hs1GuuP2m3fVp4cdLeLVlt5ideftuY
	 9gbybqnbHSjCg==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12 000/423] 6.12.23-rc1 review
Message-ID: <20250408153912.GA19185@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250408104845.675475678@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.12.23 release.
> There are 423 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Apr 2025 10:47:53 +0000.
> Anything received after that time might be too late.

Hi Greg

6.12.23-rc1 compiles, boots and runs here on x86_64 (AMD Ryzen 5 7520U,
Slackware64-current), no regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

