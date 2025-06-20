Return-Path: <stable+bounces-154927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8697AAE1370
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1F24A0964
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17E121D5B0;
	Fri, 20 Jun 2025 05:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="d3awMKW9"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED01AE877;
	Fri, 20 Jun 2025 05:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398944; cv=none; b=sSr0U3Mbc7tu7gy0SeN7Y6XTWG8DJRhxaJe8txstwWEAacIucHzQUkbbN957x2SAQyVza2j62ZDhW3PMm/KgCNd4VOsLFAHCM9FOYHECLL9JaEfj+Z0NqBh7OGv7gzE9FGVpD2zn6bVh3T1GUAwErQCUqPNwaHUb3mADaySGgDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398944; c=relaxed/simple;
	bh=kxTTCsywDmf0XQKD9uUdRxnhzEQBXDlWIHzka79usK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRG+nTwOWuG1UiHHOA9tCOSd0cV2L6qelXgVps5W+iwHKMWE8J9lwuIjFsoj88lMvcLr5koM/HnXs0M+UXeKnZL6C5ZWRAm7YLkn4ZQUxdGtyq32CREfW52FHqZHjiBX1HTm9En6P/qU8y8cJ5+ZTrFdmowjFZCVhZaDfi24QEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=d3awMKW9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 01C0940E0169;
	Fri, 20 Jun 2025 05:55:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id k6Skc_eFbVCK; Fri, 20 Jun 2025 05:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750398929; bh=39uCIp5p9LapkY7vctw0FozBqgDAL63pgc0fQJ/Yuh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3awMKW9bVyXOP9wFWaWlw3Gs41ZXPEKopOIPOEoqRN1r7VkrUQzLuMTm7XaArhAz
	 KrOqSRgOi368fpdDumTq7hSSEXzhCpxp1LNJI9hIoZRRVbEeuFn9bsge+eFLUnx+V+
	 Xj55PSiRN5lh7YNFRGET1CGvzKiyQFLL3XPxiqdV8VwVaP+29ZIOU6RbpyB49R0elm
	 Mze3LPBMgHKFEtyjI36AER/7iVE+SGxhGbWaXo3QombX3QG1UaHEUeN3grM9BaFuFS
	 kuLEsE05CXlyWLfkJyYNDmUgJjg+uSuv437gy+FM1bgaMJz/em+OyT49+lzF67Itd4
	 /kT5pteqfNSx0R9MFP7GT8LLa/+NHcuMI82A0jjlK9Ty2h/PKcA2MU2w6xecuxH1EI
	 pgD/90odDLh0pYxomAbOmTW9MfDDR5vjKdSZphYHvjhGI0XO0Fa9VOTbn52+KIfDm2
	 vpb49lKQqyy8Qu2DI4TBirD0TjlBHTPWRmf3wBugI0UChve3H0jvV0ewcu/oLfYJgQ
	 0wYEVUQH9nI6gGidqfRFQwERqh9oZMs7n7jefeXFRTliHP5UKJ3RE4QxT5seGvioQI
	 OlntJzfVnvkv78Cz9OM2GYjdylzypCfQ6DXpCAx5NeUfJ1MKRLUaM4MnpU57RhvL8C
	 cDmYN4X/WgdGUvDcNJgQchhU=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5AB0340E00DA;
	Fri, 20 Jun 2025 05:55:22 +0000 (UTC)
Date: Fri, 20 Jun 2025 07:55:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Subject: Re: Patch "EDAC/igen6: Skip absent memory controllers" has been
 added to the 6.15-stable tree
Message-ID: <20250620055511.GAaFT3vwJHM3HIlwkS@fat_crate.local>
References: <20250620022630.2600530-1-sashal@kernel.org>
 <CY8PR11MB7134D06F062C1706175E0C13897CA@CY8PR11MB7134.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY8PR11MB7134D06F062C1706175E0C13897CA@CY8PR11MB7134.namprd11.prod.outlook.com>

On Fri, Jun 20, 2025 at 05:30:26AM +0000, Zhuo, Qiuxu wrote:
> So, please either do not backport this patch or backport it together with the patch 
> [1], which has been queued in the RAS edac-drivers branch.

This one will go to Linus this week.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

