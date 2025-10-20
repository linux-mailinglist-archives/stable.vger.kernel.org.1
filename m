Return-Path: <stable+bounces-188124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C70BF1A4B
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA974424129
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E9F246768;
	Mon, 20 Oct 2025 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="o3vsLHHC"
X-Original-To: stable@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DD531283D
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968197; cv=none; b=CAZbWVc/bLmQn7fLZqPgVFVHvio5rDDbx5WT2h5YZ5Nulg1Z6UG4nIBhOlTpGF3Nbg7jixazAfpWXcpHYhok4RzR3f1mUJ07FqdmyS6lmRlsHsoSx6cqAl1X3gZHXx49yVqU/GrpaGUtODwA8fdPIAYDBOXVfuMJdBbrMwIg0pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968197; c=relaxed/simple;
	bh=QaMeADkbNBwh7o2zDjO5fqhGVfK0SgOO1LAZga/mQwM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=BXVn4c5dSaDaPAm8jRAQGvttdVnzOLudawXc2sDqVpphCqhfGjqdMOGtvgq8lZ04K0JiEapvVpNHsLosCuR2CIk+GLpS7K2kvtsPEgWIT98CNzypynUeMjNUgY11YuK4VRogfKd9cWmwq+cPpv6Gtu+E6AnpmGdW33doLMFu1Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=o3vsLHHC; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 4D3F182887CE;
	Mon, 20 Oct 2025 08:49:48 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id NfTVKkO_5k7m; Mon, 20 Oct 2025 08:49:47 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 22BEF8288FEC;
	Mon, 20 Oct 2025 08:49:47 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 22BEF8288FEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1760968187; bh=AxelRAHujegHPzRc3KOcoEU3IhOnU2N/CPitGrK40iY=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=o3vsLHHCMccLHugs6s3lmnj5/QrbIxYbB6mda5Vt9H4yc/w8gfnp8tF9TsJW9UDDe
	 IPqJ9EWKvp/7+g1Z9DoxJHzdL4nv1Z76D5TA/us+dp50G4XWeX2PLKFXOpo0MajRpz
	 Mwe0qwzyJHYPV9UgIunAcXOyvpTj5UdY52HL9D4s=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TtRii8eSv9Rp; Mon, 20 Oct 2025 08:49:46 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 1978182887CE;
	Mon, 20 Oct 2025 08:49:46 -0500 (CDT)
Date: Mon, 20 Oct 2025 08:49:43 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>
Message-ID: <1646860374.1801652.1760968183087.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <2025102005-praying-overlord-eb5d@gregkh>
References: <389171823.1798956.1760724071998.JavaMail.zimbra@raptorengineeringinc.com> <2025102005-praying-overlord-eb5d@gregkh>
Subject: Re: [PATCH 6.12.y] drm/amd/display: fix dmub access race condition
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC141 (Linux)/8.5.0_GA_3042)
Thread-Topic: drm/amd/display: fix dmub access race condition
Thread-Index: wEGzqnSKjA8V7q9xxwtg6jNBMlU58g==



----- Original Message -----
> From: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "stable" <stable@vger.kernel.org>
> Sent: Monday, October 20, 2025 4:08:40 AM
> Subject: Re: [PATCH 6.12.y] drm/amd/display: fix dmub access race condition

> On Fri, Oct 17, 2025 at 01:01:12PM -0500, Timothy Pearson wrote:
>> +/**
>> + * struct dm_vupdate_work - Work data for periodic action in idle
>> + * @work: Kernel work data for the work event
>> + * @adev: amdgpu_device back pointer
>> + * @stream: DC stream associated with the crtc
>> + * @adjust: DC CRTC timing adjust to be applied to the crtc
>> + */
>> +struct vupdate_offload_work {
>> +       struct work_struct work;
>> +       struct amdgpu_device *adev;
>> +       struct dc_stream_state *stream;
>> +       struct dc_crtc_timing_adjust *adjust;
>> +};
> 
> What happened to the proper formatting of this structure?  You lost all
> tabs :(

I'm not sure.  Please accept my apologies.

> Please fix up and resend.

Investigating further after some additional crash reports over the weekend, it looks like there is a whole batch of patches needed to stabilize amdgpu on 6.12.  For now, I'm going to withdraw this until I get a better handle on whether we can reasonably patch 6.12 or just need to run 6.16+ with these GPUs.

