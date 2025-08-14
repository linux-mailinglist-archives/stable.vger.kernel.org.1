Return-Path: <stable+bounces-169521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DF5B260B9
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 11:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826C81C241AF
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 09:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596A12EA155;
	Thu, 14 Aug 2025 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhcIV5ZA"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CD92E613D
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163103; cv=none; b=bdSSAnzvFyM8cpnRtW2NKtKYmoRNIOrCqysL86UINxD8ZYlTg/IGoIZOsPHoGxTICMtKUVb5LaPOVT9IBGz11ebk8JUxOEDIftQuk8dkPW+azhmK22PCDsTzyAhaShCIvSnviQ3eUmjYAVlXV02JP8/0EnYX6thezjyfgncU070=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163103; c=relaxed/simple;
	bh=9jfsBBqeJOEl9hddqXnvpXQHYPzROEJTWzYp929WPI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTPSiEt43iO/Z4XDIzbPoRvl/voM14B1TL37AXFWrH5/qoRY8NH+I6zk/fvhMh+1xrh5sFug+kQSXnjsA73MSpCMU2DnsDgaI3++6WgQE6K8BtEaLl1ClHhHlg5S1yN7SSU9jtKm+IyqjNLko/ffUCPKwWR/phsWaBNvsfp4j2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhcIV5ZA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755163100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7KJnGM2svr7YW4cpJgDglh0IED9NSFfVKuR4V+h5zek=;
	b=RhcIV5ZA4obAKJb3JxOKbN8K4S1LxWLEo/4XV/+viPfjg4SBDzlEV4lIPq3ctE2twxeOW+
	vsewoOgIqPhKK2IVpEzu7rs8jlik7c7TSmH2arfo95u4L9N65jYUYYiOd131ryiD4yyL9i
	EbUFB1U3MZ+fsz4V26VsdJWXhMG7594=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-RC_AcYDiPlaMPQIqdWvKqA-1; Thu, 14 Aug 2025 05:18:18 -0400
X-MC-Unique: RC_AcYDiPlaMPQIqdWvKqA-1
X-Mimecast-MFC-AGG-ID: RC_AcYDiPlaMPQIqdWvKqA_1755163098
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e870317642so171763985a.0
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 02:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163098; x=1755767898;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7KJnGM2svr7YW4cpJgDglh0IED9NSFfVKuR4V+h5zek=;
        b=NgLJRYsJpoJwApYRoiSykEFzrAvrL2gapZaOJAkyzFizsHt7gkz05J4gY4rMY+tXA1
         tK37Gg+okgbq5/FuQtbx8MC54nBSk7uKgnPywXYnzcJ3ns6GYhFy+qxIPaJiVk28/ZCs
         p2uptWBnsRVAlXFfsayfnVvqGwkWOFU1vFFS52ytasogc5Kwlfp+UQmZpe/0vVFhlVW0
         AQuMk9TrUwVBR3jWNkmtlzncKKF8SHnqyPpkWJeo6gm28pK+Gl70dCRXDIIBSzAASwio
         QFLdTvVGjwH8JbJ0UB50LuIt0WaK42JXEdwxM+WyvQNaoIJnjFf57Wl4k0slcIoiJqPK
         dX7g==
X-Forwarded-Encrypted: i=1; AJvYcCU4sgyf1hKhQyhU6yipt0b9cAPOaxXsqVnPy4Rp9vrY+AnqVHsSDaQJjEPXzH4Q6UwmUt+d1iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYTAGAxxm3in+VEB1jDqQ0HAchs+aYzH1NpS5hIRPQU2A6u86i
	GVByOk/47pwc3TnJ5yv2cdmfzKN8woQGKe9hGyKvI2janpvvUo+LJEu+uZSVhCU3vhlls6OWOVh
	61tRdjf/HQ17hjdUU1Dy4QjGz5uWZtM8wymOW7gmvHvH8MpKFqeASmkXvDw==
X-Gm-Gg: ASbGncviOusRD2eU9xKGCqiUHEhQdF7xm4peu/BuqhaV4SHKo1geD7URKd77pzG7x7U
	xjonxUcwlksxek+V03Ezjth9AEnz8bVdkKUARwKsV+ttQYMXHGGYY0ZjtV7kI/vHsEDeSBx2oeG
	pDfGE2QAQ6IZK9R7RB8mh22/WBEJlSz08ljRBLXNXGXqRT/nqjGpP7+mxH9IOw97augiXoHGbxq
	71m3rSCpq33lWyEfruNbvbNaVnj5uQH719GuaillMlY10rQyXJrHXi+lyJft8Ccr8D6KLQqNpIb
	lNSEpDM2n2g1Hy2qpvF00X4cYavQYxCu+yG4Pdow7AKcAPgHuT+9hMZNt/fwwNOrA0Kc
X-Received: by 2002:a05:620a:4009:b0:7e8:710d:a514 with SMTP id af79cd13be357-7e871b61fd6mr232211085a.53.1755163097771;
        Thu, 14 Aug 2025 02:18:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/rNDxfUSF41mvaZG3MitrVFYLyJLI3VztVogKFuFPmYJr+uIbJGy5RLElJh3Ry5C/7l4gNg==
X-Received: by 2002:a05:620a:4009:b0:7e8:710d:a514 with SMTP id af79cd13be357-7e871b61fd6mr232208885a.53.1755163097411;
        Thu, 14 Aug 2025 02:18:17 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.57.34.72])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e81bc7a1e3sm1302247985a.74.2025.08.14.02.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:18:15 -0700 (PDT)
Date: Thu, 14 Aug 2025 11:18:10 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, Chris Mason <clm@meta.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.16 199/627] sched/deadline: Less agressive dl_server
 handling
Message-ID: <aJ2p0vhe6-2S2ZtJ@jlelli-thinkpadt14gen4.remote.csb>
References: <20250812173419.303046420@linuxfoundation.org>
 <20250812173426.853672780@linuxfoundation.org>
 <17955c87-1a82-4eae-94ee-3ac1447d4e71@kernel.org>
 <58c46200-95b0-4cd8-bb5e-44f963a66875@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58c46200-95b0-4cd8-bb5e-44f963a66875@kernel.org>

Hi,

On 14/08/25 10:37, Jiri Slaby wrote:
> On 14. 08. 25, 10:22, Jiri Slaby wrote:
> > Hi,
> > 
> > 
> > On 12. 08. 25, 19:28, Greg Kroah-Hartman wrote:
> > > 6.16-stable review patch.  If anyone has any objections, please let
> > > me know.
> > > 
> > > ------------------
> > > 
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > 
> > > [ Upstream commit cccb45d7c4295bbfeba616582d0249f2d21e6df5 ]
> > > 
> > > Chris reported that commit 5f6bd380c7bd ("sched/rt: Remove default
> > > bandwidth control") caused a significant dip in his favourite
> > > benchmark of the day. Simply disabling dl_server cured things.
> > > 
> > > His workload hammers the 0->1, 1->0 transitions, and the
> > > dl_server_{start,stop}() overhead kills it -- fairly obviously a bad
> > > idea in hind sight and all that.
> > > 
> > > Change things around to only disable the dl_server when there has not
> > > been a fair task around for a whole period. Since the default period
> > > is 1 second, this ensures the benchmark never trips this, overhead
> > > gone.
> > 
> > This causes:
> > sched: DL replenish lagged too much
> > 
> > Maybe some prereq missing?
> 
> Not really, this is present both in linus/master and tip/master.

https://lore.kernel.org/lkml/20250615131129.954975-1-kuyo.chang@mediatek.com/
should be addressing it, but still under review.

Thanks,
Juri


