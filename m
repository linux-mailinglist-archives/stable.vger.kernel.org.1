Return-Path: <stable+bounces-81152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4089913FA
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 04:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5312B1F23F46
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 02:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3937725761;
	Sat,  5 Oct 2024 02:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="UQ9pC6hQ"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CC51C6A3
	for <stable@vger.kernel.org>; Sat,  5 Oct 2024 02:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728096093; cv=none; b=HzUjvRKEn6Zvx0ITLpIp7fK2mTRO8hIikS8c0rCJ2i7o9BJSRK1kBNAUGMNP4U3cMBDvDOk3tsTNZKrJ2b2XyfOIWXIe3yf4nwzl1mkRHvm6qqYlf6uyMLulf1HEY/Ds3LxAybAEFsRk3PcuS6KNKN7MpOzyQ+X2S75FfabA34o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728096093; c=relaxed/simple;
	bh=sEc1Mud9OIn2GrJ98M9tAdApwsApW0Xub5TYGwZiI2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kkdubB2fCCFYLTz1pD/udxt6wFiR2HKbTnyJGjPX/1BWIhjk6LdPVNOrlHw3W8hxyvNOnm4PxwnvCw/puY0NfhRX0rRv3oGIa2QczTUyY79UqVafRruBC5HM/iH4kKBf9dq4r1WOvmRHQf4CHMZl2yOJ0IHvgse0yakQ3+c+4T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=UQ9pC6hQ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-178.bstnma.fios.verizon.net [173.48.111.178])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4952ekl8023934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Oct 2024 22:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1728096051; bh=D7qNvMDnML2OmVh2lSkLCFOR0s3St60SrRd9iM1JlZM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=UQ9pC6hQWWkQ2EIUhyPwiZqYAAfsTM/9GmVILak9oWlq9u39InM16xAymTCQ37Rnv
	 ITvHC6bhTZlgcjYT2Jy5/3cFoavgNR9oE89qJsXuiQSB5E8ajE6bCVqI4DPLb8ePyl
	 z8IG820zhA+DpN9OT+nGBZZFjOzLjYUBHXP3kyfudYxrSQcHleGbaQBJceX7FhEQ6Z
	 ++AxvrqErVXgqG9vk/W8LVpd4xJaBNSdiDqfn7cVqVjb7hoS2m9eMTXzUaqpRLo8rL
	 Fx5qvhXVXpjhLusJuHEoSF9BRSR4b6NzyxWIMSHvTwSZGQiU58yam+da0VcJSlvzag
	 As61vcjI12MZA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E697E15C6668; Fri, 04 Oct 2024 22:40:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, libaokun@huaweicloud.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>,
        Wesley Hershberger <wesley.hershberger@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
        Eric Sandeen <sandeen@redhat.com>, stable@vger.kernel.org,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH v2] ext4: fix off by one issue in alloc_flex_gd()
Date: Fri,  4 Oct 2024 22:40:36 -0400
Message-ID: <172809600230.505638.16626414897244702690.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240927133329.1015041-1-libaokun@huaweicloud.com>
References: <20240927133329.1015041-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 27 Sep 2024 21:33:29 +0800, libaokun@huaweicloud.com wrote:
> Wesley reported an issue:
> 
> ==================================================================
> EXT4-fs (dm-5): resizing filesystem from 7168 to 786432 blocks
> ------------[ cut here ]------------
> kernel BUG at fs/ext4/resize.c:324!
> CPU: 9 UID: 0 PID: 3576 Comm: resize2fs Not tainted 6.11.0+ #27
> RIP: 0010:ext4_resize_fs+0x1212/0x12d0
> Call Trace:
>  __ext4_ioctl+0x4e0/0x1800
>  ext4_ioctl+0x12/0x20
>  __x64_sys_ioctl+0x99/0xd0
>  x64_sys_call+0x1206/0x20d0
>  do_syscall_64+0x72/0x110
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> ==================================================================
> 
> [...]

Applied, thanks!

[1/1] ext4: fix off by one issue in alloc_flex_gd()
      commit: 6121258c2b33ceac3d21f6a221452692c465df88

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

