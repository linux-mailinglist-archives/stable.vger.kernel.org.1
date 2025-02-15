Return-Path: <stable+bounces-116473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CB2A36B56
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 03:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7996E1894732
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 02:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434AF38382;
	Sat, 15 Feb 2025 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="nX25qR1t"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D87D151998;
	Sat, 15 Feb 2025 02:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739585713; cv=none; b=K6D/wGbf4nPGo6Qq+8ejpRlvJNUGw9BVkp2WG/daUl9v1tWCsQ4fI3t97xOkF+SO4tqaQYnClnRtZimLHA+TJyrb7qowqiNn/YsuRjU+WZ7esPe4Ii5Nc7rTCnhTFLKuEwMu0N9RZ9Tz+xY4YEH9Uc+JS8y68TuZDM6BPMMPQM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739585713; c=relaxed/simple;
	bh=f/HFjrGZbsXz4gTQGvHCYTL/7eWhGkkflXSVPCcpWIg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+5fwzHkcHhV4i7I3SYmpWMp/rH+YITGd7UJeXAc0SQcPjm6W6pf2vWb01ZgIBJo0h3zxitxdVXKqh43PILAZx64NnZJKi+QjJ3mfTPxw3SzohljY9XYjTTg7nTzIR1OhmnkX069XSbWHPsKp8EyHoq+a1bahuzb7Kv2WfVBWsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=nX25qR1t; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Sat, 15 Feb 2025 03:05:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1739585126;
	bh=f/HFjrGZbsXz4gTQGvHCYTL/7eWhGkkflXSVPCcpWIg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=nX25qR1t0By4jFQtme5p9vdemxtjh6jOZl7YKFvaupfHyjrwTb/PM2Acgd3TLMPPG
	 fQaUTiIKqdq6I8ff8k5Lu973dJ/bRcEmHsydD8igbP1WkjbsrsRo/sDj2jowpXxwHR
	 5DC2VZNNNPTrJPTHWm2rTsesqCBHXfw9TVaCpit0gFqLdSWTDzzQ+yfZVub5jObwro
	 EeJuscbEoIzMl/uMDpnrmfwz5u3ZI/SIB01G0/HOTHUgwv08+ZXjzswCt/A/IUwfL2
	 dAnlKV7EhbC0rgiCtRIElirmPK+7JOxCdoW/Ghz2vKZXVgFYqhCjGLY9YpfJf8vfhO
	 YkTixwq13v75Q==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12 000/419] 6.12.14-rc2 review
Message-ID: <20250215020526.GA23322@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250214133845.788244691@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214133845.788244691@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.12.14 release.
> There are 419 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 16 Feb 2025 13:37:21 +0000.
> Anything received after that time might be too late.

Hi Greg

6.12.14-rc2 compiles, boots and runs here on x86_64 (AMD Ryzen 5 7520U,
Slackware64-current), no regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

