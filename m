Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3711C7EE95F
	for <lists+stable@lfdr.de>; Thu, 16 Nov 2023 23:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjKPWkO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 16 Nov 2023 17:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjKPWkN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 16 Nov 2023 17:40:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5055C127
        for <stable@vger.kernel.org>; Thu, 16 Nov 2023 14:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700174402; x=1700779202; i=donatusmusic@gmx.de;
        bh=J8l9eaDyAHA3a36Csw+3n95hNrvIqGDpkFKWPMoFGCk=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=d5A5/5XQ79bBWND+GtYFYBpZPaeNfx+4ILikayLR7dHbtcLCkTzZv6DacX+B6iM2
         u8G9ciTpOfsrwpOy9D07Pg3zCTy2kAsQKqqKDeaxblvGcwZXeyCER/VYOMBto0SWQ
         xVdG/68yi0mPgjJbLh6no7iQb/1e6g3H/fc/Dv+f73LzDq0/npT9TgTUtTdqwwZIv
         gVhlFNxQ2Gv3RH4WMcLTyS0AsvcxwZsH+Ld6841o7B7I0tUSLN7P3Kq1ql9n/vSYX
         mngOGL68n7xITZHCeKjYkzgvi6cQuP7mLQfKu9yTZgL3kGByipKCU+37Ce9z/YQDf
         MoE5ibBhExaeTe0Ajw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.24] ([93.119.250.221]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVvL5-1quF2F29x7-00RpLy; Thu, 16
 Nov 2023 23:40:02 +0100
Message-ID: <bd1a6eb1-a8af-4181-b9e4-c7b8d3af1eea@gmx.de>
Date:   Thu, 16 Nov 2023 23:41:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     stable@vger.kernel.org
Cc:     regressions@lists.linux.dev
From:   =?UTF-8?Q?Andr=C3=A9_Kunz?= <donatusmusic@gmx.de>
Subject: Found a bug with my gaming gear
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:diqmZkfT3UW/wdbSpx7OORG4bVC96dKVd+C8mVJeNk4TSowU263
 jwC6JcN+DtuObgqieHGg84GWgFJpiS7yfiBIniQ5vLZ8TkyTN1yFaQVWEB5jkh7nMinn53p
 epFEmMAcuPk+mRgp1RGZMSXn0ymiQryTy1GWZ6QZo87+0mg+LMUkf88Fpzge9kMwf/m7PzJ
 p1m7jIWtSkft9VNMnwqyw==
UI-OutboundReport: notjunk:1;M01:P0:FdAsOmKFEBs=;p6KpN6VWc58gZzlPMis4TKdmKZs
 haoxa+j2I+ezdUtt+h2pIMugWbp75iJxQO67DC7EZ0l/ca8tm2kkcWYAgA8ftUGKKj9VykAD5
 zMssEB321slSJTxxRLKLHkprQlSfiOWih35P3Nh9Z1huJ2wTpdU0W4lMhfGmeOilN11eAomM2
 WNSqplM9qyiqZ/DMfapwvV/g6eYAmeuMMl60+HuoUVhYqEEMZaDHR6A3w/XwNS+LkJemignlF
 dkfSaAJDr5UXZN26clIwwArbPnudcKbmN8/KEqNiXPcj5bQvQC5KI+XNGrLBbv19VmTyrRACp
 YLbmeUeOAdYmGGbkUNtTNV64T4NOS/M0Cltx31o687JSp073mC/bL+E+xAVkU3PU/BmgvhzXJ
 pyBbWtoKdQWvgG9tSNE503V8VQXcmAiT3PbGyn8a4aSuVc1JdjeKnu9a7/QM9oVD3zEJMXOTb
 2ZKymOTy/LP8k2uRqVbcN1OJTHMlJzyyEboB0G15fgfWaswtdpkuXp4VC260yeaoN7FphxAxd
 ni6BGKcQtKBpX6GDzxTspEeQ3juCqSUtkPd33v3jDZjnY09pYoi/eGDHZ6v6dHajAeEwI+7U3
 MDZ5+emrhqgY1zx6UsMvKNKdkxkint7rObqJjpM2Np1zyBEEDCp3GJvHG0FzUZQLjFyXKHxoi
 EG9YULDWlGKkinxdDCljO5mx0++1NmSAj+bUUyUIT7foCMaQuLdP+YqDuOEvusgjTPOfp7qbD
 1iVvbqZqroQjuiL0MegTWhSBDd0wB7WZ6syU1WR6Aeai5vca60uq2ilaIWaUgVbwV6QGgL/wn
 kHnsV6S0uwoxlbsVepBoERXBXV568mU7G+WocP5R7W+ZwiCBtuwImE1ATuLTEgsOCNMtAphvo
 i+9/WAFdNmo61E/bgeIorU/+MXv///iIauncYBmLZUf2E0fXNw3MjKXY2jZz3lEDmqur/zH2p
 m15YCrdNO8OG+2SSO+a0ElPEmBE=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hey there guys,

This is my first kernel "bug" report ever, so please bear with me if I
didn't catch the precise right way to report this.

The bug I've found:

I'm running stable kernel 6.6.1-1 and as soon as I install it, many of
my mouse's hardware buttons stop working. I have a Logitech G502 X Plus
(it's a wireless mouse). As soon as I install 6.6.1 the mouse's hardware
buttons won't work, i.e. only the two side-buttons would work, not the
buttons (and/or my created profiles/macros) would. I have a few macros
assigned to some buttons, which work perfectly fine under 6.5.11 (and
earlier), but as soon as I'm on 6.6 they'd stop working.

Just wanted to report this and I hope there can be a fix.

I hope this email was not too much out of the ordinary.

Have a great evening guys!

Best,
Andr=C3=A9

