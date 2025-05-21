Return-Path: <stable+bounces-145913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CDBABFB55
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 18:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D929E0AA7
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF4A2222C5;
	Wed, 21 May 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="ICpsUIlf"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9781E21E082;
	Wed, 21 May 2025 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747845322; cv=none; b=lukQ081si9MpiVXR3Zzpsry0DiiRhN5S7w3vr+ighTmWG2KfwUQC3RDZu4Y5FzlE+dIWdnHhYBickpu2Hp6Zrx9S2Ruqa+i0LSHc1+WjjgDCU1qLYTo5sTKwfIG+bVDGxOD9s/nTg8amVwUs/9dI7kK90TMZ4YcGFH8/VRW+4ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747845322; c=relaxed/simple;
	bh=Uw9iHsQ2aw0BHF9E4DMPSl01HEKN/4HPQgGh+Nt7wtk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeUHGI4SjsOTZ1GAD0eZu5cQ26PANA5LVMaKzqNUjw07KG21lQV7oNsvFjis5tzTBu7TZ+A/0Buxg38DBvxu6EDpW7aSJh1bXeaDTrVNCH+YZCveP5R+fTeacC4087TcRvggjP9B2T8kEfV9DAROVJBChP83VBxD68RXKQ1vQjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=ICpsUIlf; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Wed, 21 May 2025 18:25:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1747844729;
	bh=Uw9iHsQ2aw0BHF9E4DMPSl01HEKN/4HPQgGh+Nt7wtk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=ICpsUIlfERHJVl3wDTWncHZAN5u2Kwn3DklVvD1nOBWn8vQPHYcJ5jb3nuYHqDbsF
	 AXaOCb5Bwyle7jei+QGKuawijGzS5Gs/ETKo/OGsPGt+DL6itxMmvovBg5E52fhqwn
	 o62s3jUVKeX4vrShKUCvVcs/IL11mG08nGph/9FtEyM3pI72am+iw96EuSW2/U4pLy
	 mhLzNqtVAqR1FFN7j6G80HB4eeZe4Cg8ESx20cu63Uc1YQejYKA+2F0DZXzALbMwmp
	 kToh5g+/IGOI3T9QJk3VrTY3nYpfu5Vlqm1/HI/VneRJd7XBiLyPK1IfSpLX/C5nRI
	 sxaA7qbid//7g==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.14 000/145] 6.14.8-rc1 review
Message-ID: <20250521162528.GA27779@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250520125810.535475500@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520125810.535475500@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.14.8 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> Anything received after that time might be too late.

Hi Greg

6.14.8-rc1 compiles, boots and runs here on x86_64 (AMD Ryzen 5 7520U,
Slackware64-current), no regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

