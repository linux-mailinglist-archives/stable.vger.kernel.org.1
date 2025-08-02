Return-Path: <stable+bounces-165793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E80CDB18B37
	for <lists+stable@lfdr.de>; Sat,  2 Aug 2025 10:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBF7C7A46A5
	for <lists+stable@lfdr.de>; Sat,  2 Aug 2025 08:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC53A4A01;
	Sat,  2 Aug 2025 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F7SPtNah"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE428F7D
	for <stable@vger.kernel.org>; Sat,  2 Aug 2025 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754122773; cv=none; b=PiPqQbxyvr7hKGqBQRHm1aDGLndqhnsQxY6ry0bJLt2/TpIVM0pY9gZwYZ75CkoBCEClShq4iRHT/yOwWouxl49i2Uq5TZiCacJUxnROGPlDYkdZ/CCDRB8luVp8hSsUpYrO8GRIeYnKxnlJaMZi7e+Hxyv/1t8u6lzHKdr6WJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754122773; c=relaxed/simple;
	bh=26a/XwM9f+Pel2nEcX+CYgaMul57Q1tb8FeA/yg1bxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/PjbmQJUVWayJDmS8SmaMuIDCH/U6X5MVjD2hRgGUfp/RyJzSdoRnc+qAOvC0IOlH1XHIBpJmw9bzYYuTsLewKN0uig5W1Oai+85SaReUQeC/yafJ0UPHL8AcH8zZwdJqj0ikLymHnqiA2cZoKg6XmdqXMzhnx5E6TaOv0xWQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F7SPtNah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC17FC4CEEF;
	Sat,  2 Aug 2025 08:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754122773;
	bh=26a/XwM9f+Pel2nEcX+CYgaMul57Q1tb8FeA/yg1bxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F7SPtNahSx75Hz47T7nfXdEYJIIyvmeJ/YORcwZjQqHIAjmB1Iupc2l/DHAUOQ+k2
	 UzI8En7UYFLOccWbFk+G98lMhD/lmCCKXj8RMZbUhMKFDMwrsWpKqHbnJcRZQgOiCz
	 eMgGVd+5LCpPvJh1AY3pCksfqj/FsVme50HIGd5I=
Date: Sat, 2 Aug 2025 09:19:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Hao, Qingfeng" <Qingfeng.Hao@windriver.com>
Cc: "cve@kernel.org" <cve@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"He, Zhe" <Zhe.He@windriver.com>
Subject: Re: [PATCH vulns 0/1] change the sha1 for CVE-2024-26661
Message-ID: <2025080251-outright-lubricant-1e05@gregkh>
References: <20250801040635.4190980-1-qingfeng.hao@windriver.com>
 <2025080132-landlady-stilt-e9f2@gregkh>
 <DS0PR11MB79597F9B511913D0EF4DDA458826A@DS0PR11MB7959.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS0PR11MB79597F9B511913D0EF4DDA458826A@DS0PR11MB7959.namprd11.prod.outlook.com>

On Fri, Aug 01, 2025 at 12:04:54PM +0000, Hao, Qingfeng wrote:
> Hi Greg,
> Thanks for your check and comments. Sorry that I mistakenly changed 
> the files of .dyad and .json. I'll pay attention next time. 
> The original fix 66951d98d9bf ("drm/amd/display: Add NULL test for 'timing generator' in 'dcn21_set_pipe()'") 
> or fb5a3d037082 for CVE-2024-26661 didn't fix the CVE (or even made it worse) because the key change 
> is to check if “tg” is NULL before referencing it, but the fix does NOT do that correctly:
> +       if (!abm && !tg && !panel_cntl) 
> +               return; 
> Here "&&" should have been "||".
> The follow-up commit 17ba9cde11c2 fixes this by:
> -       if (!abm && !tg && !panel_cntl) 
> +       if (!abm || !tg || !panel_cntl) 
>                 return; 
> So we consider that 66951d98d9bf is not a complete fix. It actually made things worse.
> 66951d98d9bf and 17ba9cde11c2 together fix CVE-2024-26661.
> The same problem happened to CVE-2024-26662.
> If you agree with the above analysis, should I append 17ba9cde11c2bfebbd70867b0a2ac4a22e573379 to CVE-2024-26661.sha1 ? 

I think that the original CVE should just be rejected and a new one
added for the other sha1 you have pointed out that actually fixes the
issue because the first one does not do anything.  Is that ok?

thanks,

greg k-h

