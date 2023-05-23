Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0153E70D128
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 04:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjEWCXn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 22:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjEWCXm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 22:23:42 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F78CA
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:23:40 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34N2NXsL010802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 22:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1684808615; bh=z6nU0CMVf5Yhynk19vFrsWGDcjsJods6p43GhHrZl6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RIwBUM21g1t6yKgybFfav7ZfSN1tJ1/lPS+Pc6MFGTxLTlf6xcaBLu5ciGHXlwgr3
         LadZP4m2CyzhXkIYol1gX3pqA5zzGW6tvAAqaZcOwSm7hhr2Hdiz7BlQgvHg9jMwPt
         vgmpxiSFM7ECe6jyR4Mpt3JJnezyClZBKodVGnksGtaSBIUFJ610pkCJNfV5a16ciU
         hxN/9/XV5V6q6FgP/BpxYbBFXadYyik+H50zCHbQ0m3Ry9l0r2xpczWqFcPMzWtzuu
         syufDWKt0jVviwEbn5LHGk2tPkqA/aZNe/WHGdX+UUKxR5+pPoU155pocSXvCMuM5l
         PIXohLPpTxUTg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8F92F15C052B; Mon, 22 May 2023 22:23:33 -0400 (EDT)
Date:   Mon, 22 May 2023 22:23:33 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org
Subject: Was there a call for 5.10.181-rc1 review?
Message-ID: <20230523022333.GG230989@mit.edu>
References: <20230522190354.935300867@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

I can't found a call for reviewing 5.10.181-rc1, either in my inbox or
on lore.kernel.org.

There does to be a 5.10.181-rc1 in stable-rc/linux-5.10.y, so did it
not get e-mailed out somehow?  Or did I somehow miss it?

Anyway, I tested this commit using gce-xfstests, and I didn't detect
any ext4 test regressions.

commit fd59dd82642d6c5b122f4f122a04f629155c1658 (stable-rc/linux-5.10.y, liunx-5.10.y, linux-5.10.y)
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Mon May 22 20:03:46 2023 +0100

    Linux 5.10.181-rc1

					- Ted

TESTRUNID: ltm-20230522175448
KERNEL:    kernel 5.10.181-rc1-xfstests-00154-gfd59dd82642d #26 SMP Mon May 22 17:42:27 EDT 2023 x86_64
CMDLINE:   full --kernel gs://gce-xfstests/kernel.deb
CPUS:      2
MEM:       7680

ext4/4k: 530 tests, 45 skipped, 4271 seconds
ext4/1k: 526 tests, 1 failures, 56 skipped, 4907 seconds
  Flaky: generic/475: 60% (3/5)
ext4/ext3: 522 tests, 132 skipped, 4079 seconds
ext4/encrypt: 508 tests, 3 failures, 151 skipped, 2739 seconds
  Failures: generic/681 generic/682 generic/691
ext4/nojournal: 525 tests, 3 failures, 111 skipped, 4172 seconds
  Failures: ext4/301 ext4/304 generic/455
ext4/ext3conv: 527 tests, 46 skipped, 4436 seconds
ext4/adv: 527 tests, 5 failures, 53 skipped, 4523 seconds
  Failures: generic/455 generic/477 generic/526 generic/527
  Flaky: generic/547: 20% (1/5)
ext4/dioread_nolock: 528 tests, 1 failures, 45 skipped, 4714 seconds
  Flaky: generic/604: 20% (1/5)
ext4/data_journal: 526 tests, 3 failures, 113 skipped, 4523 seconds
  Failures: generic/231 generic/455
  Flaky: generic/068: 40% (2/5)
ext4/bigalloc_4k: 502 tests, 50 skipped, 3804 seconds
ext4/bigalloc_1k: 502 tests, 1 failures, 66 skipped, 4460 seconds
  Failures: shared/298
ext4/dax: 517 tests, 1 failures, 146 skipped, 2700 seconds
  Failures: generic/608
Totals: 6312 tests, 1014 skipped, 77 failures, 0 errors, 49061s

FSTESTIMG: gce-xfstests/xfstests-amd64-202303031351
FSTESTPRJ: gce-xfstests
FSTESTVER: blktests 676d42c (Thu, 2 Mar 2023 15:25:44 +0900)
FSTESTVER: fio  fio-3.31 (Tue, 9 Aug 2022 14:41:25 -0600)
FSTESTVER: fsverity v1.5-6-g5d6f7c4 (Mon, 30 Jan 2023 23:22:45 -0800)
FSTESTVER: ima-evm-utils v1.3.2 (Wed, 28 Oct 2020 13:18:08 -0400)
FSTESTVER: nvme-cli v1.16 (Thu, 11 Nov 2021 13:09:06 -0800)
FSTESTVER: quota  v4.05-53-gd90b7d5 (Tue, 6 Dec 2022 12:59:03 +0100)
FSTESTVER: util-linux v2.38.1 (Thu, 4 Aug 2022 11:06:21 +0200)
FSTESTVER: xfsprogs v6.1.1 (Fri, 13 Jan 2023 19:06:37 +0100)
FSTESTVER: xfstests-bld 2e60cef3 (Thu, 23 Feb 2023 15:02:58 -0500)
FSTESTVER: xfstests v2023.02.26-8-g821ef4889 (Thu, 2 Mar 2023 10:23:51 -0500)
FSTESTVER: zz_build-distro bullseye
FSTESTSET: -g auto
FSTESTOPT: aex
