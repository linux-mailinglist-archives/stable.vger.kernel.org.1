Return-Path: <stable+bounces-194615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D53C52428
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 13:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D4DF4E8C8A
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 12:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64D732C93C;
	Wed, 12 Nov 2025 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emjmLNL9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IdX11/Ai"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D492F5463
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762950377; cv=none; b=AFfuPGjpOF5CSiGQZJ1AOSqkWfjE/4jI0Y3YrBiYXST/H051YcWu3noG64doCj9Alm4dKHrqGbFijVl2+3/R/hpilUB0/8QxBNajf8b2XLOiPGAOUDqG6nJiU0BhL4bBlsB2loJb9sIAlRfnCiL9Q95pA3XpEaWs+vGbqegu47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762950377; c=relaxed/simple;
	bh=CqNDDDxa3uN4xlxw7lBpImiMSDLKKefKhEv5FAtJBl0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q5YKqDjJcbL/vY/HHe9T3WZ/oP3ATpgvp8qWMuAhMjgb6onR8bWoKpBRh9D3FQucx5VYDEe+FDYavo/x8K6XI+q62V0qzIPWzmPFXztoeLE1nL23kibeHrms18PqXjVlNfM7VIy9+n7Og0dX4ovk8cyc9j+4ptkaQvC1KVqFiEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=emjmLNL9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IdX11/Ai; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762950374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CqNDDDxa3uN4xlxw7lBpImiMSDLKKefKhEv5FAtJBl0=;
	b=emjmLNL9Fw0iqFfJXMEGxvOg2TK4+8fiFHrwbuEmj4pvqOwooudn3pXg2F+9844xciVFWw
	tOTQqaxcsPjMameLv/Wcc0XkVwSR0CnGfSPMmCzYjF1zZOSUgsh+CWh+ZLrucxEIlQ3MVn
	KsVyQSrTlq9HdiqVCc+1UYdJOw4DORM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-ZodK2ul5O-ikGyJ9ZZPl_A-1; Wed, 12 Nov 2025 07:26:13 -0500
X-MC-Unique: ZodK2ul5O-ikGyJ9ZZPl_A-1
X-Mimecast-MFC-AGG-ID: ZodK2ul5O-ikGyJ9ZZPl_A_1762950372
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297f3710070so22470215ad.2
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 04:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762950372; x=1763555172; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CqNDDDxa3uN4xlxw7lBpImiMSDLKKefKhEv5FAtJBl0=;
        b=IdX11/Ai+O+fNTRApPgb7/KmvnwdsmrGQAdi8Uevsv7yyy8d7I+gCPvq1HBH58wpEH
         I+OH874+DA0Tf865f3KDMsPQkaIEpedYPwVxKULFqhoqtTVjXx+baZ63E2jFutfhbZOW
         34wWaA2t5M0tVLzqLnrc7kpvnwFQl0CDgZM5Yc4O6GwRtF0EkOoTAiby6EcSOaE+41fa
         5e3si7EbYsmuo7skf+x01IS1hOmWgXw32tpvTIUTxWPQMky4Gqram6JLk9zT/GbuatOn
         LnwuHiATdwTVOA/P3Oc4hizHfzFTcbdm9oQIB4hInve45/ZH+M2yO4tBJ2kmEMp/hr/0
         PHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762950372; x=1763555172;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CqNDDDxa3uN4xlxw7lBpImiMSDLKKefKhEv5FAtJBl0=;
        b=sSs5iqU14Wan8P0NKZvDcIpOTMwdhoDNKL4gUFZ70BtLxX/DfibR7VLki+Mq5fwEdY
         G9gevpuDKf6MLxxmWN1710O0A6fd1aJjoYXZvXl/T2xPds6Tx4HixC0986HVFYPD+l+U
         X9q2VyxYcbR3/drQXmGfQ1McWHmdRCM7Z5kK7VUyj9JZiX7lFqSbY6WwuBDa7KY1FDU2
         k9IGnfP/ZYR9xt7wONc/65laDEEPnY15gGBwpWZorxAeR+eYjs8AyDnboPNd+xYB/hKf
         XWIDhN6NRdWdVaDBYClPZLoKVGSHiGp2vFA81/Bt6KtUdJAMSWKNfqdGx5mLCHXRJU3a
         1cRw==
X-Gm-Message-State: AOJu0YzaO3BPI9M/TLFAWXXO9+XQH9he52u8iHXjeooM+XZbJBJI60Xb
	fyh/G7G1cAc2JF5na/EZoHtG5bic8thbJfdkDInqYpzB/Rg3s3WwPBFlCsUnd1Y0NhCDsfV7jOH
	UosF0l0NuXCKXXeTR0t/vm6+4a9SL3P1ChUHQbxHqkazWfJxb2vMBWADBDQ==
X-Gm-Gg: ASbGncu2lQx2+C72aeNAxdHVDuJnHqzFa59HrHmyfzbcaKIKzJ5QgqyPm8PGAHtnmR1
	t9YQa4aVJIXV5U3RvPZvkH3yJTO7NAV+5/FXpvAH3c7AcET7Cw16I8h5hkCl+L7uVCoxdb1CS9Z
	i76U7wC0YGmfMLB5rL3HA332MjR2Au4HV8yp81pwlnzyWJibDxxACcyMZTHwtmPWZU6wt66MIpr
	Le+1CEKLuabj+oexAKn7fXotipxavn+UaR3q28IF5rJXTSFbHu3hMtKnU68RjcE4pJN06e7zRnr
	oeLgNwue9dHQ05PlErXVMN009h6/AQsIOmDQPM1c1gJkmxbaWaLjrAoBjy7kRoA+v7x1d3+4eV4
	k+EQCvwKuI4wjoQIMNjvFGW8/jw==
X-Received: by 2002:a17:902:ea09:b0:24e:3cf2:2453 with SMTP id d9443c01a7336-2984ee04f44mr35020315ad.61.1762950372264;
        Wed, 12 Nov 2025 04:26:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGotUeN2bXs86xhnkFf71Twk4l7K85JeCXAv2Ic+UsZ9JWvOMbc7w1rl78D10uve93JRS66cw==
X-Received: by 2002:a17:902:ea09:b0:24e:3cf2:2453 with SMTP id d9443c01a7336-2984ee04f44mr35019995ad.61.1762950371815;
        Wed, 12 Nov 2025 04:26:11 -0800 (PST)
Received: from [10.200.68.138] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dce80f3sm29309275ad.106.2025.11.12.04.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 04:26:11 -0800 (PST)
Message-ID: <3b1b371eed29291182e2e90451d262ed24d1e3ed.camel@redhat.com>
Subject: Re: [PATCH 6.12 084/565] drm/sched: Re-group and rename the entity
 run-queue lock
From: Philipp Stanner <pstanner@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Luben
 Tuikov <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 Sasha Levin <sashal@kernel.org>
Date: Wed, 12 Nov 2025 13:26:01 +0100
In-Reply-To: <2025111200-handoff-boxing-aa92@gregkh>
References: <20251111004526.816196597@linuxfoundation.org>
	 <20251111004528.857251276@linuxfoundation.org>
	 <b239f2abb28d4e5dfc36c67bb6b88975a63c11e6.camel@redhat.com>
	 <2025111200-handoff-boxing-aa92@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-12 at 09:59 +0900, Greg Kroah-Hartman wrote:
> On Tue, Nov 11, 2025 at 03:30:45PM +0100, Philipp Stanner wrote:
> > On Tue, 2025-11-11 at 09:39 +0900, Greg Kroah-Hartman wrote:
> > > 6.12-stable review patch.=C2=A0 If anyone has any objections, please
> > > let me know.
> >=20
> > This and patch 83 are mere code improvements, not bug fixes.
>=20
> But as the patch says:
>=20
> > > Stable-dep-of: d25e3a610bae ("drm/sched: Fix race in
> > > drm_sched_entity_select_rq()")
>=20
> That is a bugfix, right?=C2=A0 So this is needed here too.

I had a tag-overflow in my mind.

That one is a bug fix. OK then.

P.


