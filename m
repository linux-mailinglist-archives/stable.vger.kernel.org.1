Return-Path: <stable+bounces-110286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 023FFA1A5C3
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 15:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2A116929C
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCFD1EA65;
	Thu, 23 Jan 2025 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZmvLkWtC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8821CA8D
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737642654; cv=none; b=OAqDWZh1bzoJVlpDDEU1rAnzPjxwRiM7YhiawpRQx0h/uCrOPYtSgk1OvhyIesAaGNwJvI1igdEfbCClX4SXTwEYpI1LAtJZ/i22Jecx7fyqbJFsoAwZHjGTU/Iu/vzzzEFZH0Ofr1tko7XIfGbHRGBTGh2/tiG76mUBA/zY3uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737642654; c=relaxed/simple;
	bh=aGzr0nYYncve+lVcVzpJtw55rqjEZPGAnHedIkj+Nzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiMyF4r9umLnK/sPeMqtke1uTO4tpw9Tcar1YOqyKXs9s/GqJAPQAm3XmEPnT5dhUorR4TenJia0GLlGETEHnCO6Z88GDXtllRVP6w1TVA2e47X7UV9wYpd8zW+UbdozWSAKJDRdo092kScpFEfw9SfrXq14AakPIP++whjVoq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZmvLkWtC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737642653; x=1769178653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aGzr0nYYncve+lVcVzpJtw55rqjEZPGAnHedIkj+Nzg=;
  b=ZmvLkWtCrz0kXJojqwAPH4hT0gmU0sYEUZcgzdvwSmXtPZRVSbQdFC7N
   ruUw4e6r7wKz4RDw0Tw/KXASGv8HPfZfKH1WABddWSwcVvSY6bh8Y/Ke4
   Ca9/UG3PVoFRdpnAfE9eX5aITdTm4PZMR5ASWK7+CporIR6YQ+ct9Px+x
   wMe54grTNnzY+SAgp2LjnuM5YYJilGwcW9fDzXAkREixG0yr+INNfnU3Y
   Ksj/S2/OsKEd+1yiKEZ4PmeCRnvAOhmbKyBDVJkEqTAJJu+wedoHCkjlv
   xKP9HH8VrvQT6M0hXtu495P8/Johlpw54XXMhA59yEnhPr8/dtOFS1hRe
   w==;
X-CSE-ConnectionGUID: Mx8NRGVRSyGVzZiL+bqAaw==
X-CSE-MsgGUID: lh5ubvxjQSCWuDm18ndpfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="48731984"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="48731984"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 06:30:52 -0800
X-CSE-ConnectionGUID: 50uUyjreST675jxa1UQ3zA==
X-CSE-MsgGUID: pPYKQuyQQ+iSe0ahwHkFXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112115812"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.110.196])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 06:30:52 -0800
Date: Thu, 23 Jan 2025 08:30:46 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: "Souza, Jose" <jose.souza@intel.com>
Cc: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, 
	"Harrison, John C" <john.c.harrison@intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Filipchuk, Julia" <julia.filipchuk@intel.com>
Subject: Re: [PATCH 1/2] drm/xe/devcoredump: Move exec queue snapshot to
 Contexts section
Message-ID: <kw4rrdedc3ye5elnis6bjz2xg34ttrul2d6qye5lm3ixeee36l@ncfk65fdvb4s>
References: <20250123051112.1938193-1-lucas.demarchi@intel.com>
 <20250123051112.1938193-2-lucas.demarchi@intel.com>
 <f16aac40a9ea1ab40d1083228cd0b460e1d217e3.camel@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f16aac40a9ea1ab40d1083228cd0b460e1d217e3.camel@intel.com>

On Thu, Jan 23, 2025 at 08:14:11AM -0600, Jose Souza wrote:
>On Wed, 2025-01-22 at 21:11 -0800, Lucas De Marchi wrote:
>> Having the exec queue snapshot inside a "GuC CT" section was always
>> wrong.  Commit c28fd6c358db ("drm/xe/devcoredump: Improve section
>> headings and add tile info") tried to fix that bug, but with that also
>> broke the mesa tool that parses the devcoredump, hence it was reverted
>> in commit 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa
>> debug tool").
>>
>> With the mesa tool also fixed, this can propagate as a fix on both
>> kernel and userspace side to avoid unnecessary headache for a debug
>> feature.
>
>This will break older versions of the Mesa parser. Is this really necessary?

See cover letter with the mesa MR that would fix the tool to follow the
kernel fix and work with both newer and older format. Linking it here
anyway: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/33177

It's a fix so simple that IMO it's better than carrying the cruft ad
infinitum on all the tools that may possibly parse the devcoredump.


>Is it worth breaking the tool? In my opinion, it is not.
>
>Also, do we need to discuss this now? Wouldn't it be better to focus on bringing the GuC log in first?

That's what the second patch does. We need to discuss both now and
decide, otherwise we can't re-enable it and have either the guc log
parser or mesa's aubinator_error_decode_xe broken.

Lucas De Marchi

>
>>
>> Cc: John Harrison <John.C.Harrison@Intel.com>
>> Cc: Julia Filipchuk <julia.filipchuk@intel.com>
>> Cc: José Roberto de Souza <jose.souza@intel.com>
>> Cc: stable@vger.kernel.org
>> Fixes: 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa debug tool")
>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>> ---
>>  drivers/gpu/drm/xe/xe_devcoredump.c | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
>> index 81dc7795c0651..a7946a76777e7 100644
>> --- a/drivers/gpu/drm/xe/xe_devcoredump.c
>> +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
>> @@ -119,11 +119,7 @@ static ssize_t __xe_devcoredump_read(char *buffer, size_t count,
>>  	drm_puts(&p, "\n**** GuC CT ****\n");
>>  	xe_guc_ct_snapshot_print(ss->guc.ct, &p);
>>
>> -	/*
>> -	 * Don't add a new section header here because the mesa debug decoder
>> -	 * tool expects the context information to be in the 'GuC CT' section.
>> -	 */
>> -	/* drm_puts(&p, "\n**** Contexts ****\n"); */
>> +	drm_puts(&p, "\n**** Contexts ****\n");
>>  	xe_guc_exec_queue_snapshot_print(ss->ge, &p);
>>
>>  	drm_puts(&p, "\n**** Job ****\n");
>

