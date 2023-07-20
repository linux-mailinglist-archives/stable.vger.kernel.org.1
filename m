Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D418A75B72F
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 20:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjGTS4J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 14:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjGTS4I (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 14:56:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77971705
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 11:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.at;
 s=s31663417; t=1689879364; x=1690484164; i=reinhold.mannsberger@gmx.at;
 bh=3zKu16pfUrrytu9Tcwl5JfS2CXatxGHmAmVagUWiOtc=;
 h=X-UI-Sender-Class:Subject:From:Reply-To:To:Date;
 b=Lvg/avVk55dBNwF40fbjXBOjNp3D510r1GpVt7O9CjTfnOVbMZT5KObaeqADFiq3gkU877j
 vQ/hPTfz0VBMULfwxHjC2W/pbrqhJs3UU7KQyiC/wos+Eo1KNMXsOtBou9ZxZ3UKQl3rIXRDg
 DOr5kMimZk+4q1s/vDqp0QqUbtufgrkAwXP95f5miY4pVvxlzcW0IHGyaad6r4k3FrS1MnH1W
 eZTh1KZbpfgCWLproXw1/TywnlNyiuZkQVEbsqJKQ69RjfSWjbdqvUX3vCybm1lJLG7cjj3xt
 CwkVV5+UvXuGnNvO3TulPX+BvkAOEW1jD3SY6pUejur3mhBhOjwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [100.64.100.6] ([194.5.53.166]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MplXp-1pYiPx20ib-00q8aq for
 <stable@vger.kernel.org>; Thu, 20 Jul 2023 20:56:04 +0200
Message-ID: <32933d9b5e1a46e4ec60189ea389e012a8fd65d6.camel@gmx.at>
Subject: cannot mount device with write access with kernel versions >= 4.20.0
From:   Reinhold Mannsberger <reinhold.mannsberger@gmx.at>
Reply-To: reinhold.mannsberger@gmx.at
To:     stable@vger.kernel.org
Date:   Thu, 20 Jul 2023 20:55:50 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:jXbxZEw5X7b9imjSnyTzLmUunCX0HbfwbeDR25vS/hHAFGALicM
 s8jkeI5Ql1GPlLBadPF3Jy7Akv+MmTDks+N01nzB5ArffJb8s7LT3gGBRanTgZiZzw2YFsU
 4z2dCklCpEjcP037pvD7DMlL4gnbhxWUVwE9AENcRtZlmAeGUSk/K1RzdP504KbBWhJMBWz
 NV2UWdxcp6hnO8WxzImRA==
UI-OutboundReport: notjunk:1;M01:P0:Kppq07Uk06E=;esh7aBGziUFohJF8IjvBF6KlGF1
 i3U7RJ0I5rHQ5Gv43Kiv/xKEyJggNH98FaVM3H4rK3slm/yks1MX2vzC+uoJVMHbPQi8SbSYs
 6s4Z1vmRpBJFfEOTpBXthBuzGrXy0yqiK1nWy3oXp4J0XVAR1G3/FQEk0cwQZnYOmVAxVKjBJ
 MW3HVtGwaNid1vCw4PMDih9G5ws7YoMVuemzd1ogqJ1+iGD2q2bbTqnxjRTzLGAhyZ6QhsVo0
 oW0lW+ThQWJ8lQcIYye6IS8gZWwmEWPj663ga/oZzlOfmKdMNYAHPQQr3ICIo3NiFcNq8rEcy
 Xz5jxtnlsoPXTCWku2CKjVyzgCx5nxqQPl3gvc/A4SwWnY0wi7Vk+oza9ftpKa8nVVSgvr4to
 oq6jmw1zDzstMv3JLNSAYXul7yvW/DtAd31xXPJhage9QBZX0EbpGorX/uZc2uZzaINtz9eCE
 +LN3keeIuv74OxI5h9shK0mBILGWI8sP+547aM6amgwy67pobdu3vd3vMKGbGIQ+YZH7gjT88
 zWgBIg/6zfOO8EXxJ/exSnVICMP6IQNAvSlVIUqe6kLjiX9eW94HQyuttmnuUg1rc+qlghXr7
 5jjF3jSak+hhJX5BpQH2PZ2igjV/e4syU2X3yT+1GccnYqI+gYX10KIfAfbOdKskv5Lb5ns7D
 sh7R0vX6DfPfZv2UTe62us3fXu/PrshCrUg8hFILDeRrD/ZuoyFDqM4UUDSccEQyHRWvD4HEO
 yt3oyKMHbDUGn0RI1I0DcLwCbuL8yHQ3YszrR34ede2tlZUTu0yTEkrhwfbR2sGLNWmE3G733
 5dlPH9iayT8kSFa75BpGOf6pAHSm7AwHr0nnpGb1DMv9sMHOBJjL1F5XYWTp7nfRPts4hKgiI
 L5H/0dyAfmz5RP7h1BdXrUnhx6FvtRam90xI5mty8Bk0HInvx8FfqQhuoaW21U0bQvPEF4VX8
 zqqmXg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Dear kernel developers!

Something unintended must have happened in kernel version 4.20.0.

On my PC I have an Iomega REV 35 drive. Up to kernel version 4.19.125
that device can be mounted with write access for the root user.
(Unfortunately I could not find a way to have write access as a normal
user.)=C2=A0

The command I use for mounting:
-----
sudo mount -t udf -o
rw,nosuid,nodev,relatime,uid=3D1000,gid=3D1000,iocharset=3Dutf8 /dev/sr1
/media/rm_l1604/REV35
-----

The very same command gives the following message with kernel versions
>=3D 4.20.0.
-----
mount: /dev/sr1 is write-protected, mounting read-only
-----

As a result there is no chance go get write access to the device. At
least I could not find a way to get write access.

Is there any workaround for this problem? Please let me know!


Thank you and best regards,

Reinhold Mannsberger
