Return-Path: <stable+bounces-183359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E5DBB8B50
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 10:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E0F3BD91A
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C233244694;
	Sat,  4 Oct 2025 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="YaZxJuTK"
X-Original-To: stable@vger.kernel.org
Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1031F5851;
	Sat,  4 Oct 2025 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759567245; cv=none; b=t2iSgR3izDggFwPYh3vRqCk3w1QSi0Hd3zwgVUrqQZkdfq9G/SibokF+xpN0aUNxM63RX+cSG8XQMB49kTJ+qED2dT0s2m5Kms2OLXsvOZ+qYywVSruK8o9YwL9RivoQVOSrMBGbd5md/tNbha63lkJWPcxwkMQBayTkxhQ3uwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759567245; c=relaxed/simple;
	bh=zxbvHP+9YLMTvKq9WNEqCHLjpHhvEiTPvZG1TtH0/QA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmzc0WURTlcoSDndXTcKhSfIiKwnRVdm5oBTy+MLjAItJvK7LkO9/tfic2PmBbL5rIbK7KnDBzUjPp63dq37FcTVpWE3S4tgj6Hxjy5qUYZafu3313XNv5u+dTJTEZpLuwcZzqOwpgEyk3uyYwqlJ8EGiK+5t/rYu20Nfc46NIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=YaZxJuTK; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Sat, 4 Oct 2025 10:31:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1759566672;
	bh=zxbvHP+9YLMTvKq9WNEqCHLjpHhvEiTPvZG1TtH0/QA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=YaZxJuTK0FRsbivmHfUWNBVK7GfApz4JQGu/8wXCkvCb9QOvaZJmRHxQTBob5K9NH
	 0M2ZNOI6A4N/7R62fPQh4p+19aYw75z7UGKt9u4MJl/SWxu89eTcfUdyq6K0FNkPiF
	 SLfXajpxqDrLylqJyBZ5xsUpiAIBGXmV/JaQjx09OX6OdZ+ndUs1hZbiGaKX9raUQw
	 FWMMBACu6pXYlAn57TTEGgnVg66EB/cZj3BH+citwHy807ITAb0yQOq3Cc7WsOyJpS
	 RhPvDS5uHmaqSyEqpnDZuqHwoNqYuNA5DG/4DBBMiWtNkCrdYf6C4oOqXAaRAAvzrc
	 +k4VQnx+xgndA==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.16 00/14] 6.16.11-rc1 review
Message-ID: <20251004083111.GA18723@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251003160352.713189598@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003160352.713189598@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.16.11 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.

Hi Greg

6.16.11-rc1 compiles on x86_64 (Xeon E5-1620 v2, Slackware64-15.0),
and boots & runs on x86_64 (AMD Ryzen 5 7520U, Slackware64-current).
No regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

