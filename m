Return-Path: <stable+bounces-165602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B86AB16901
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 00:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442C75A3F75
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 22:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672E52264D0;
	Wed, 30 Jul 2025 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4L8iQLhA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF21224B04
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 22:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753914370; cv=none; b=fOjMzyBjuBqor/dQHjZHxKqdrNPy50CPhhaxQFZtDgC0DM3CsmOqlsFhvl8J44wZNUz4ppYZUwuDplYXg3ZALVzUZBw1AH77lEvPIWLY38CAasuKFNSSVQ6xitDUgO2UA5BEFWTF8dPHT9FTbeFFCiHVhyxnbQvFxKgns3KL+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753914370; c=relaxed/simple;
	bh=I1IpMiqpoKBm33rTZ+oMcFj9fDPtGpmJX2PTagB8X04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tB6LzdbQf69dCIjmG57WQYsuFMXvfahKbTbTIy/CaeX0s2TtR5XYepaNh0oCMmtAKjI0YNigPdx2+qdbmpnzaGve0TnYRvqPzgkuVdP9gYD+TsNu5NmdupUAfGMjR5k6laBCdNXcmMKgPTxOJDKzIvtRfnozNDduaeUY2rqVz0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4L8iQLhA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24070dd87e4so56015ad.0
        for <stable@vger.kernel.org>; Wed, 30 Jul 2025 15:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753914367; x=1754519167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uWgbn51tj8/R+WgZVKq4LF2OHJt7uGtmnafFEn6VfJI=;
        b=4L8iQLhAejleWxe0MSRapJK9gGwiCjh6IK4TypCM6MO1kF7BVjaCQlsJP6VLzTYxP0
         O8n9zhyJg+qST1lvbpd/pxcbU47BkFo3LSsfda5o69MPaF9Py3Xt6ZkJEPp0sC6qjmjx
         LzuiwNonm63tPfyOLBSk0Apa7E9+Z2glImJp7jGjcPB/o4vb4QA4P1UEZ8RhINWJF8Ks
         FqeE3bkp1zzQXgiPYbbDByssbnCf6lu+flnWsEd2/pSu7lrr5jiAX2AtGPBsXE/4uAMH
         kj9205nr6ESe0tP6IxE+Tk8AoQdH1bBF+uUksO7icOnEdANh8yHz0bxjM25TJpU2ub7v
         6CXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753914367; x=1754519167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWgbn51tj8/R+WgZVKq4LF2OHJt7uGtmnafFEn6VfJI=;
        b=IzWgNygzH5dFQMwiuiiAiutJfBJsjkhBWghN+pBNfebxwyhBuHcbYmUPX+67CUKncW
         al4xfR5ppRpxFoPgOUplHsKhi8l9WFWmfoVuwCDYzZtDdwdfZXCPaLZQVCVWtklINvAO
         GXtKlq3DRw+apiYUM65wfxPPKLyt0ZPHO8mbbTHcEvZXlzcmW4J/OoY22qUsnsEyPNTm
         H2p2YMGbhFil2jZLKzatYRjNYy7e55PmnUz5hTkArV2Pbk+qBmR93KflbjvzWdtZXJSc
         5XpWmfS+MVY9ulwV6dsh5FmfLiBdvTup+Q/2TY1ZmUV/fdd4sm/rXyqMW8NQK4gcnKHA
         pq8w==
X-Forwarded-Encrypted: i=1; AJvYcCXmVrqjzwGoggnZRFwVME0oqiVjClvle9+g3dd0lIG7OaKgJ+Ekhn0gDFXV9Wif+kotzq3r8P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVsonxcvzEBhLajh9EeCBFS2BNoRmSeIYewFSZJzdg3Gx9HbE1
	lFUjrcYfrIB5iEAD3zPsi3X+RKA3IlN+sZYweTZNMXhBuU/ErleJeUoCs9r/FeCvAg==
X-Gm-Gg: ASbGncsMofErP5eIUcVVcXeJp5/pYvLkKNJVGxguCpZJOUOGTTUoPbgy+Rak9e7OZd5
	dGUP6JtzLC7f78yB8ysGCd4qVM4BtRFKUjlPhAsjGB4QYo2MCT7u6jGuxA+E5QnRda2Wt4ggzlf
	QchWLF+9U37Bbkt4N4gIeDYKCNZ2lx7HCWv5pkJlq50j1WajSMOUI9kNWLSBDjOsysma9s6Ud/1
	k3baZ7+6G9D7aBbYa+IfNMh2gQleR+emOu3KdzbE4Zjj4Y2gZ1pZBqowwkXrktNF2JgVn2SQi88
	IoqRFpOIvhw8pPz7k4Bo/ektnMD+JC5mbq0bBnYUDPmncsaOw6CnS8osegEpMwMeouf3XdiwIdC
	kNkHX8StwB762Y3VXgzBYyf+UF6vQNlWSHXg1N2OTjIfWXsjZ6Aw01z9DWbFD7gw=
X-Google-Smtp-Source: AGHT+IF7GIX6tFBmXMXWlNufFCJ9b8Nzm8c5k/dWc/ynk1aExv7w6ih9jVmipAivHuc3sqA81rAOew==
X-Received: by 2002:a17:903:18e:b0:240:22af:91c1 with SMTP id d9443c01a7336-241ff0c2267mr312105ad.22.1753914367224;
        Wed, 30 Jul 2025 15:26:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e51:8:9606:2f93:add0:9255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975ad9sm1226855ad.98.2025.07.30.15.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 15:26:06 -0700 (PDT)
Date: Wed, 30 Jul 2025 15:26:01 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: gregkh@linuxfoundation.org, aliceryhl@google.com, surenb@google.com,
	stable@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 5.10.y 0/4] Backport series: "permit write-sealed memfd
 read-only shared mappings"
Message-ID: <aIqb-bDjsXppmyPN@google.com>
References: <20250730015406.32569-1-isaacmanjarres@google.com>
 <c99af418-946d-40c4-9594-36943d8c72bf@lucifer.local>
 <aIpVKpqXmfuITxf-@google.com>
 <d8bfc16a-466d-43b9-9021-91f6b65a3a81@lucifer.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8bfc16a-466d-43b9-9021-91f6b65a3a81@lucifer.local>

On Wed, Jul 30, 2025 at 08:34:02PM +0100, Lorenzo Stoakes wrote:
> > >
> > > Having said that, I'm not against you doing this, just wondering about
> > > that.
> > >
> > > Also - what kind of testing have you do on these series?
> > I did the following tests:
> >
> > 1. I have a unit test that tries to map write-sealed memfds as
> > read-only and shared. I verified that this works for each kernel version
> > that this series is being applied to.
> >
> > 2. Android devices do use memfds as well, so I did try these patches out
> > on a device running each kernel version, and tried boot testing, using
> > several apps/games. I was looking for functional failures in these
> > scenarios but didn't encounter any.
> >
> > Do you have any other recommendations of what I should test?
> 
> No, that sounds good to me! Thank you for taking the time to implement and
> carefully check this :)
> 
> In this case I have no objections to these backports!
> 
> Cheers, Lorenzo

Thanks Lorenzo! Just to confirm, is there anything required from my
end for these patches or they'll get reviewed and merged over time?

Thanks,
Isaac

