Return-Path: <stable+bounces-35904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B55E58983DA
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 11:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABA828A31C
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 09:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7F97353B;
	Thu,  4 Apr 2024 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bZX/+rKE"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D17A71B27
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712222143; cv=none; b=tDXORkz4Q7bviMI9Fax/b4wS8bBCs94YKkDFGDSCBAym2h5XbR2oeYj9pv41vPkWzt+dtnUQTm8ebHC6yMM9J7/J2AWneQKpWDPseWheJnsaiTxYi6CoY734ptZo7kPtwbR+er0cD34q3ceCDwr+8Q+T0BdOfhTtWZvc7wuCQNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712222143; c=relaxed/simple;
	bh=CFOhO9rMjBqt26zwN13mQsw0ALrTDb4wCGJysZZmmfc=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vF92rPhj2zNcIGL8n6MmepZBu6dHIjUIbyUwKyQ1OXzApo2PW7IQU5toSPRHDfIVNJp/bn5gKcvZ/zJDZkDhYCuf7anVtvhcTM2M6DIOSs95CInvashOHRF5fOPVqqD4IJSg/R313XziZ5d+MK4Veu/u1Xp9MCvVUByPEzIY4KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bZX/+rKE; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712222143; x=1743758143;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=q17zD8zeQWBUAQMkLzyyB+SxQTcEnm8AgXUOq/YxrT8=;
  b=bZX/+rKENBXCZ8DPr5ONTrns2U8plvyYwGYqjfjYJd+3BSW3/FIgR0i9
   seNcyxPGTA+FVmtuK0oFvKFFssRWEuOe0+b9LqdG8kpd7OVffk3MG1POj
   xf0wnzVZJLtZcdg0q/JvCh7IhhSNo9iqP5EyQaiffxtkjraEKrb6bPMWq
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,179,1708387200"; 
   d="scan'208";a="398109458"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 09:15:29 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.0.204:6130]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.45.125:2525] with esmtp (Farcaster)
 id d627aa2e-7cde-48b2-80ad-88227e5c090e; Thu, 4 Apr 2024 09:15:26 +0000 (UTC)
X-Farcaster-Flow-ID: d627aa2e-7cde-48b2-80ad-88227e5c090e
Received: from EX19EXOUEC002.ant.amazon.com (10.252.135.179) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 4 Apr 2024 09:15:26 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19EXOUEC002.ant.amazon.com (10.252.135.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 4 Apr 2024 09:15:25 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 4 Apr 2024 09:15:25 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
	id 85F998FF; Thu,  4 Apr 2024 11:15:25 +0200 (CEST)
From: Mahmoud Adam <mngyadam@amazon.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>, Theodore Ts'o
	<tytso@mit.edu>, "Darrick J. Wong" <djwong@kernel.org>, Leah Rumancik
	<lrumancik@google.com>
Subject: Re: [PATCH 6.1 0/6] backport xfs fix patches reported by
 xfs/179/270/557/606
In-Reply-To: <CAOQ4uxjFxVXga5tmJ0YvQ-rQdRhoG89r5yzwh7NAjLQTNKDQFw@mail.gmail.com>
	(Amir Goldstein's message of "Thu, 4 Apr 2024 08:45:27 +0300")
References: <20240403125949.33676-1-mngyadam@amazon.com>
	<20240403181834.GA6414@frogsfrogsfrogs>
	<CAOQ4uxjFxVXga5tmJ0YvQ-rQdRhoG89r5yzwh7NAjLQTNKDQFw@mail.gmail.com>
Date: Thu, 4 Apr 2024 11:15:25 +0200
Message-ID: <lrkyqh6ghcwuq.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Amir Goldstein <amir73il@gmail.com> writes:

> On Wed, Apr 3, 2024 at 9:18=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
>> To the group: Who's the appropriate person to handle these?
>>
>> Mahmoud: If the answer to the above is "???" or silence, would you be
>> willing to take on stable testing and maintenance?

Probably there is an answer now :). But Yes, I'm okay with doing that,
Xfstests is already part for our nightly 6.1 testing.

>
> Mahmoud,
>
> I assume that you are running xfstests on LTS kernels regularly?
> In that case, you should have an established baseline for failing/passing
> tests on 6.1.y.
> Did you run these backports against all tests to verify no regressions?
> If you did - then please include this information (also which xfs configu=
rations
> were tested) in the posting of backport candidates to xfs list.

Yes, I did run the full xfstests to confirm no regression. we do
regularly run the latest stable xfstests version with loopback
setup. and we run 'xfs/quick' group over x86_64 & arm64 to catch any
regression. I'll make sure to post to xfs list first next time :)

our setup looks similar to this:

sudo fallocate -l 5G $MOUNT_POINT/block-xfs.img
sudo mkfs.xfs -f -m reflink=3D1 $MOUNT_POINT/block-xfs.img
sudo losetup -f $MOUNT_POINT/block-xfs.img
sudo mkdir -p $MOUNT_POINT/test
sudo mount /dev/loop0 $MOUNT_POINT/test

sudo fallocate -l 5G $MOUNT_POINT/block-xfs-scratch.img
sudo losetup -f $MOUNT_POINT/block-xfs-scratch.img

local.config:
    export DISABLE_UDF_TEST=3D1
    export TEST_DEV=3D/dev/loop0
    export TEST_DIR=3D$MOUNT_POINT/test
    export SCRATCH_MNT=3D$MOUNT_POINT/scratch
    export SCRATCH_DEV=3D/dev/loop1

Thanks,
MNAdam

