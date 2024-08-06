Return-Path: <stable+bounces-65498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A2394972D
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 19:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00CDA1C2155B
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 17:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981207346F;
	Tue,  6 Aug 2024 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOrGkEHb"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37307580A
	for <stable@vger.kernel.org>; Tue,  6 Aug 2024 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967053; cv=none; b=Cth4dS18jPR9sGB8/yciAR91TyPbXWdWWl1KbPFsBUXEgP2gSd0RfkvdjeP7PflkhgpUBDDcBUnfs1ccy7RpHWue8qjmvjq1C99xJIa3VWm9eFcjUyTXAmx5+ocGhljzupozO1EeX/r3E6Z1d6YYPR2AMeX1o5w1Rr1s57qJdSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967053; c=relaxed/simple;
	bh=Y3kpDopP34wSS4aefVZmlrz8cQFzCX6exogFHU3d/Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mfL7kf6iYPWVd/5Tcr7KGnXfFb8fSC1myv6R3EVIP+TGJfLfANbNkfvRRyLarMfqfEDScyYB/XXwDYjVSZe7qFp9IsNhioCn4lJH4u0cr70reG1VGmqs9y3vhXSWwDlPdy2fhH+8UfImG0z+kV8nl06Dsa1MBKd8U0Z/SObf8rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QOrGkEHb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722967050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=PCE6y3gd/ZLdIqr+zXDfXpXA+sJAwSBPUwATht6B/14=;
	b=QOrGkEHbq18AlKXPOs5GgVYjKtcUBLYRET7OWvQPpOqEZ+FgEQR2WVsuWvotDJ+6iQUL/V
	Io6lMOFhkRfYwSoJF6BTijEFr6mXED1+pmh52s1YpeAlsvtpAf2zb1iAaFj9XcwUfTk/mw
	V+BSqEXJPq/O4XGQ59SRm8egiJryrjI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-XRBAc5QsNN6taO4G4ljrWQ-1; Tue, 06 Aug 2024 13:57:29 -0400
X-MC-Unique: XRBAc5QsNN6taO4G4ljrWQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5a37b858388so698274a12.1
        for <stable@vger.kernel.org>; Tue, 06 Aug 2024 10:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722967048; x=1723571848;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCE6y3gd/ZLdIqr+zXDfXpXA+sJAwSBPUwATht6B/14=;
        b=YkxsJBsCeFs0sbvzRE1Z4VOHoKMkWvpOi1mBicaDqPGMmYUgz85x1eS2/AczhS3Qof
         yoVbdxgsKevODfBzuZ28FFAnMzGq8OIqDPtjo+MY+GTU/Bjlg63XnoV9WMlCwYsYB3fC
         ApuDnYWj1yxU6WTDHvucuardO5zyvhkMpURt5FZrp2vx9xS5OhZ7W/KUXDjpVylfFzyB
         R33dou5IYG6GbFpQPpKrxESk/ILHIivMn7JTB2vsHm/Wc7bH7Q3kWPVn7UBoJk9BGFZP
         84SxLokYAtycTZV4urWRlORiCSbjL1V4eEC/I6ZP3jnc8FpTG4giCfYymR0stM/N2rVs
         7FKw==
X-Forwarded-Encrypted: i=1; AJvYcCU4ScIj6JM5if+oc0VcJvCS87HBdt1WmX5Lo8J0gqou0BarSaDDCm6Hlav4pGzI3u6BdIjhisUgGqSMz7yQnCqO9otMT0xU
X-Gm-Message-State: AOJu0Yxuq67ot7hK2Zpxavr00zUnHjywT6eR3GNALsxTbvzO0J1bhRH9
	jVfPusiZKgQ96d9H6Au2a/1nR3yYBEnlsyvWc4r7aMejwZjAISemHWwonBN0KrpyquPDqzjoim2
	Gkr+shownA/lYF8Ew8kFF+iJ9gbSmXsChwMNtxYwQxOwjbdRKQ9/q2Q==
X-Received: by 2002:aa7:dcd9:0:b0:5a1:40d9:6a46 with SMTP id 4fb4d7f45d1cf-5b7f5dc5d68mr10453925a12.36.1722967048117;
        Tue, 06 Aug 2024 10:57:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9wiBpXfkiQpEvZZyARq7/ap2Ik8pTsT+kT/0l0ZHqK+AvR7K5fHmkyUYpLFX0WwVH0aYZHw==
X-Received: by 2002:aa7:dcd9:0:b0:5a1:40d9:6a46 with SMTP id 4fb4d7f45d1cf-5b7f5dc5d68mr10453907a12.36.1722967047202;
        Tue, 06 Aug 2024 10:57:27 -0700 (PDT)
Received: from redhat.com ([2.55.35.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ba442ed7f1sm4421307a12.81.2024.08.06.10.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:57:26 -0700 (PDT)
Date: Tue, 6 Aug 2024 13:57:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	dtatulea@nvidia.com, jasowang@redhat.com, mst@redhat.com,
	stable@vger.kernel.org
Subject: [GIT PULL] virtio: bugfix
Message-ID: <20240806135722-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 6d834691da474ed1c648753d3d3a3ef8379fa1c1:

  virtio_pci_modern: remove admin queue serialization lock (2024-07-17 05:43:21 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 0823dc64586ba5ea13a7d200a5d33e4c5fa45950:

  vhost-vdpa: switch to use vmf_insert_pfn() in the fault handler (2024-07-26 03:26:02 -0400)

----------------------------------------------------------------
virtio: bugfix

Fixes a single, long-standing issue with kick pass-through vdpa.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jason Wang (1):
      vhost-vdpa: switch to use vmf_insert_pfn() in the fault handler

 drivers/vhost/vdpa.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)


