Return-Path: <stable+bounces-171816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AD0B2C870
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 17:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54C11BC6B1A
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 15:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B78C285CB5;
	Tue, 19 Aug 2025 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="KXBcISj7"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EC6280309;
	Tue, 19 Aug 2025 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617262; cv=none; b=NNlXjZV/RfzSQ5tmTRITiwQ4gFI9gg8zJNAaZh1A1yOQti7CeO+ZUKY/qkyaVFEIT7xElXh11bbjeVbmCUZ3xILg1EniRPszd7MX7NhDI0QOZDTvFD7a4r/dxxIyG20vJH8mbymn+uXNUO4jHplv0jteaQd6lb93q/U4IMd+ruA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617262; c=relaxed/simple;
	bh=JySNi7rTLvryde5oWBixj8+fd3d6Q6nPuQZ6kxBLGIM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uyn753lHwkl2jSsxjUWdPxF3lcMWofro5FagFRSiESqVXpvcrsGtcQP4oVSsNQ1WmF3uo5iK0DCbQpdKUFiW+yK+NJ47jXoyELSn60vqziCbSP27Gqu/GuUNogRBB02YRv5PKSNiDk6vwNNtr078Aj1XlC6u2Jx8lJNy/FoYJ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=KXBcISj7; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Tue, 19 Aug 2025 17:27:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1755617250;
	bh=JySNi7rTLvryde5oWBixj8+fd3d6Q6nPuQZ6kxBLGIM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=KXBcISj7hal+trjWQXgDgVMkKTrV+QGTWCDqv7fO3hOfxcut8E4oP4xAKotCphWkn
	 toEj1pMpJwrSep/QAq3ShPyfsBPs01IqQBu2VpyB6hCj7MN17U9AGkkJkD28lYONMb
	 W5Ctlt8Y0BoxOG9e/Q/yPvopWMQQzKrJircFp8f4W5QsaDmfX31N7pFuf5JR/DC+H4
	 VEltyybb2XWduBVYsyc1nRSncJk5Kg2bewT5jjI4sNXEHSVqjX9u9Y+WoofOSjvan1
	 HTKMl8Z8n/vtrH8MVqZHPOMoVkSoOhtOLOPxDbl/I20F2cWIRuT6wryciPR2cupBWy
	 MKosHlHMV4nOw==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.16 000/570] 6.16.2-rc1 review
Message-ID: <20250819152732.GD2771@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818124505.781598737@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.16.2 release.
> There are 570 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Aug 2025 12:43:43 +0000.
> Anything received after that time might be too late.

Hi Greg

6.16.2-rc1 compiles on x86_64 (Xeon E5-1620 v2, Slackware64-15.0),
and boots & runs on x86_64 (AMD Ryzen 5 7520U, Slackware64-current).
No regressions observed, apart from the already reported and being
worked on issue https://lore.kernel.org/stable/20250818011500.376357-1-wangzijie1@honor.com/

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

