Return-Path: <stable+bounces-233483-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGQ3G4hd1GlrtQcAu9opvQ
	(envelope-from <stable+bounces-233483-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 03:27:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFEC3A8B2A
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 03:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EF6B3015C96
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 01:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A754F21CA02;
	Tue,  7 Apr 2026 01:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MeN+zbgo"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252FF3BB4A
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 01:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775525250; cv=none; b=gotby9+hLs5TGhz8BpOn7Dih0No2PNtab/sd0QGRMSZZLCmrxxNnOSJxOdTzrKLAnxaz33bFqvZDcgJGsDDH4AH8mYJTuYDvRPeaqKcPaRC+jgzAoN9YxSaNr32lQAFJ+qGEH14pJrwRexm6SZtwdLZnt9/3zQe48ThhEdq2TZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775525250; c=relaxed/simple;
	bh=BjUSpePkCkB5vmcWx47KtX+UK36OJ3lAzsPDAAvsUs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KM3ABymxH9IC0CrzsmbzpJK0SnDne5avNLJXJURWXtmDcq6ZMc5btZZSycf+Fm+gqfykXNs/vdzTU65xw8+OVx76YQdQb+7ylDeJNMymUud/qjfzRDuVAcW+puXg8pqOEDwEPnUli49u12ZdpDb+xdwi6t9fm8yQrqySiuxqUgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MeN+zbgo; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c6f21c2d81so405569085a.2
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 18:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775525248; x=1776130048; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ixi2satCCLM0zP4HwmF9jYvdrFPFAVdMFkG7x9SwdJ0=;
        b=MeN+zbgob/ME7wSUXNlOIDjLoPZnqitKzi2R31hvTq0sYH2NrHAgeMQJ4oVMp/G7o7
         LLPz70tDUsYWtAd1iaUM4azkpctJKMcC+03p9zgmpxqPvlWJQ4AxwFi6c8kJRcVEvgN0
         4DcWJrbhFPrXZNBkJMHpL9NaadQsN/O0M0vYp3uo+7+RFO5v9kp/h3UdvVgDxj0LdHRz
         FZgJaFEQuAwUn4fendDeFbvQoWjrckjgEvFrW58Ke271qvPP6PkAj7N0njoLWSAwekLf
         P210+RZZf8ubsNZbe+bmWy7VQaqkkDClEazbBvhz8TcAESli8Cd19aSlIUHyx8m1tZah
         eIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775525248; x=1776130048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ixi2satCCLM0zP4HwmF9jYvdrFPFAVdMFkG7x9SwdJ0=;
        b=DSlf2tisoLPvu7IFM44+rtPwcKs7U8JvnKP39t7jPzrMK4hM+zKo5gLOGPu8S9BtP8
         qRbmgVJTtTmPbovWj9b7TZ8dfEPWaxfrGFElWVBZe54QtRg71MGtOZm/FaBl3ggGTVPO
         BTcSIoPmI4SIOhS23LNuvuwzfiYT3OE6v7Au3Fgdo3ls8wVTFsnajIo0ML5bRgeeDBWg
         pAFxS3BqjBgjV+4fah/7MfrvV91/DD99/S0UOJ/vS5rsDDbMTslv8UYtatL46v22S3qC
         jvTfdpAI8y4X5QossH3YbpejD4w0XLXqa4jjffRDiAqiGscCDd6WDHtSESzTPaQkp1uz
         cXfw==
X-Forwarded-Encrypted: i=1; AJvYcCVRkzThONsuHzA+2I7W/ga6D0Zjlx4ssETKoVlF4K/7VoRPGgVKp7s8aPrqw3egrQ65skDB7ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRg3wox+gp/opq6dEkB7KMurMJq5UbwWeSXiTirOqKwe2s/9I8
	sFFU7GkBOmNsc7k6xe+dWrJQtJx7L/8I8pqqHVSdySJ4koSC/TwDhptISxdFpfyHAYA=
X-Gm-Gg: AeBDies4riv46QbcZ61pKBIv+GogRuceNOnJUFA30e/1+NMRBToecc3vKpZuDiyiaSm
	FLULubFMNMjuR2O2fREBeJvQf9fADq6GEmQoGT9W0+lkAEO2MMPecr0Qdl1g3smhHyBixDU97x4
	rn+KK6W6LlKjNFpOdIetZKOsnvrPH1fKSwK+CmYNG6CZp/mdhAjbGFFdJfzbUh0G90HgUZMywYq
	S7T48qKZDdbKCGDA6lT7W484dFjauKQX41UDY/7tJAvAjb739mzUyXGl7TYY96nFle8uPDjb0j+
	KYL1Hw53xPF/bwJl2allLuVxPLpQ17jhp557CGAy+kB/nUPDRFNRW48pvzusOX0v/5RRAZut6TG
	CR/swgN6c+MVj1071q5g9761+TBwamoqEef7agkca/miryilJpvPWfcjpTjT0xzNX3+/RgpDDtV
	DD9bkKUi5kqJNuaJvhMlEeWGzeviJCNJnenEaxR2Y/FJ3E1iJvGrHu0W2svqmAgpUbp8S5I4lW4
	uJB+ZUx
X-Received: by 2002:a05:620a:28ce:b0:8c7:ad9:d0a2 with SMTP id af79cd13be357-8d41c3b5997mr2097077585a.22.1775525248097;
        Mon, 06 Apr 2026 18:27:28 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d5e69afdb6sm667396385a.40.2026.04.06.18.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 18:27:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w9vDy-0000000EAWd-481U;
	Mon, 06 Apr 2026 22:27:26 -0300
Date: Mon, 6 Apr 2026 22:27:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sina Hassani <sina@openai.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Aaron Wisner <awiz@openai.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Fixes a race in iopt_unmap_iova_range
Message-ID: <20260407012726.GN2551565@ziepe.ca>
References: <CAAJpGJTztK=BTvr6s_e4epJffKchmXmqba82wxE_SOXUN6FWYg@mail.gmail.com>
 <20260407011210.GM2551565@ziepe.ca>
 <CAAJpGJQXnMjhC4C7Z6bAQJN5y48fsbiwPd3YF5vft+1MBNFLVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAJpGJQXnMjhC4C7Z6bAQJN5y48fsbiwPd3YF5vft+1MBNFLVQ@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-233483-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:email,ziepe.ca:mid]
X-Rspamd-Queue-Id: BFFEC3A8B2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 06:17:24PM -0700, Sina Hassani wrote:
> On Mon, Apr 6, 2026 at 6:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Apr 06, 2026 at 04:07:01PM -0700, Sina Hassani wrote:
> >
> > > io_pagetable *iopt, unsigned long start,
> > >                 unmapped_bytes += area_last - area_first + 1;
> > >
> > >                 down_write(&iopt->iova_rwsem);
> > > +
> > > +               /* Do not reconsider things already unmapped in case of
> > > +                * concurrent allocation */
> > > +               start = area_last + 1;
> >
> > area_last can be ULONG_MAX so this literally overflows to 0. It is why
> > I formed the suggestion I gave as I did
> >
> Yes, in which case the  if (start < area_last) that follows will catch
> it. Are you suggesting I compare against ULONG_MAX instead?

iommufd does not have any overflows to 0 and rely on it tricks like
this. You should just compare to the existing iteration last

Jason

