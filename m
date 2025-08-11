Return-Path: <stable+bounces-167050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF667B210B0
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 18:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559363E794B
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 15:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CC12E6131;
	Mon, 11 Aug 2025 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HVnT9QbA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916D12E6134
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926292; cv=none; b=UAje3EuuXk9tkkv53gcvcTk+z/jRDStLLm3kSYkR1K9N6ZT/pODJHcA/ad55CPN4kRLMGWBwQSjuLd7+CEwR6HsbYqY7x009evE0oU5yTxdMVpSX5hb/FBt5DpoX9w/AjHwz+E+yYakP3w2rmgqIQrzJghf0Ct5yP896FOzkF2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926292; c=relaxed/simple;
	bh=PpnQIX9Kg2x3jykNkGXI86lw0SusGSG519cPWSoxcK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBOSzydTg/JPf8fN2JFQBqTiAAvPPa6PVVufuH28bKFpwzKX1Cb6cX1pEc+/+ke1ONhKX/rJpBhQr0TMP0SA3w6AaJ/cf5O9NEfra2yHvzFecze8WhO8ZE+1ClyPOkO3Hs973fq9XRQ//uTvJfKSVQoe0yyss5N+g+DP2iR3zC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HVnT9QbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D42C4CEED;
	Mon, 11 Aug 2025 15:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754926292;
	bh=PpnQIX9Kg2x3jykNkGXI86lw0SusGSG519cPWSoxcK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVnT9QbAjqLu3LIeM3cMb1e24skYFm4/Ww5EU+LfBoaXR7qGmEyuggAi+6HMUOHV2
	 p2xWRu1f0neWY4gQFp3C1eT42fEtWkv9oORSPrnf0crr66Nd9opj55P1i0ZSCZKD21
	 AdJTpIzJ1f+A76hX/cMgNMEXvDGVc/3DYgVZxoEs=
Date: Mon, 11 Aug 2025 17:31:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Qingfeng Hao <Qingfeng.Hao@windriver.com>
Cc: "cve@kernel.org" <cve@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"He, Zhe" <Zhe.He@windriver.com>
Subject: Re: [PATCH vulns 0/1] change the sha1 for CVE-2024-26661
Message-ID: <2025081122-mobility-facsimile-abb2@gregkh>
References: <20250801040635.4190980-1-qingfeng.hao@windriver.com>
 <2025080132-landlady-stilt-e9f2@gregkh>
 <DS0PR11MB79597F9B511913D0EF4DDA458826A@DS0PR11MB7959.namprd11.prod.outlook.com>
 <2025080251-outright-lubricant-1e05@gregkh>
 <4be58827-6794-401b-9a9e-e1ffd66a6a89@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4be58827-6794-401b-9a9e-e1ffd66a6a89@windriver.com>

On Mon, Aug 04, 2025 at 03:47:16PM +0800, Qingfeng Hao wrote:
> 
> On 8/2/25 16:19, Greg KH wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > 
> > On Fri, Aug 01, 2025 at 12:04:54PM +0000, Hao, Qingfeng wrote:
> > > Hi Greg,
> > > Thanks for your check and comments. Sorry that I mistakenly changed
> > > the files of .dyad and .json. I'll pay attention next time.
> > > The original fix 66951d98d9bf ("drm/amd/display: Add NULL test for 'timing generator' in 'dcn21_set_pipe()'")
> > > or fb5a3d037082 for CVE-2024-26661 didn't fix the CVE (or even made it worse) because the key change
> > > is to check if “tg” is NULL before referencing it, but the fix does NOT do that correctly:
> > > +       if (!abm && !tg && !panel_cntl)
> > > +               return;
> > > Here "&&" should have been "||".
> > > The follow-up commit 17ba9cde11c2 fixes this by:
> > > -       if (!abm && !tg && !panel_cntl)
> > > +       if (!abm || !tg || !panel_cntl)
> > >                  return;
> > > So we consider that 66951d98d9bf is not a complete fix. It actually made things worse.
> > > 66951d98d9bf and 17ba9cde11c2 together fix CVE-2024-26661.
> > > The same problem happened to CVE-2024-26662.
> > > If you agree with the above analysis, should I append 17ba9cde11c2bfebbd70867b0a2ac4a22e573379 to CVE-2024-26661.sha1 ?
> > I think that the original CVE should just be rejected and a new one
> > added for the other sha1 you have pointed out that actually fixes the
> > issue because the first one does not do anything.  Is that ok?
> Thanks Greg.
> Just to be clear, 66951d98d9bf was supposed to fix CVE-2024-26661 but it
> failed
> to do that. Then 17ba9cde11c2 was added, together with 66951d98d9bf, finally
> fixing CVE-2024-26661.
> 
> 1) I'm OK with rejecting CVE-2024-26661 and creating a new CVE.
> BTW, since I'm new to kernel CVE management, why do we reject a valid CVE
> just
> because the initial fix doesn't work ?

Because almost all CVEs are tied to the commits that resolve them.  But,
we do have a way to have multiple commit ids for a single CVE, as you
point out, so we should probably just do that here as well.

> 2) If we do need to reject CVE-2024-26661 and create a new CVE, is there
> anything I should do ?

Nope!

> 3) I just did some search and found that some sha1 files contain multiple
> commit ids. The sha1 file should contain all of the commits that fix the CVE
> ?
> Or just the last commit of the commits that fix the CVE ?

Let me just go and add this id to the CVE itself, as it makes more sense
as you point out, both commits need to be present here to resolve the
issue.

I've now done that, but note, it didn't change anything here, the fixes
and vulnerable entries still all remain the same, so no one really will
notice this :)

thanks,

greg k-h

