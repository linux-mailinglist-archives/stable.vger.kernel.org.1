Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23777BB5AD
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 12:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjJFKwD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 06:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjJFKwC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Oct 2023 06:52:02 -0400
Received: from mail.flyingcircus.io (mail.flyingcircus.io [IPv6:2a02:238:f030:102::1064])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED75FF4;
        Fri,  6 Oct 2023 03:51:56 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
        s=mail; t=1696589512;
        bh=HGa8c10xvK/NHUXiTFrZYL/EKgFpWUXN0LPr1D3e83g=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=QcvC75h9aDKEOpxsnLcRCnTzd4FcEG9DzmGKpFecctFrBz0wlDuNXgjDOHmXZO+d3
         K94yYE3QMkKj0QL3hCX7mP1gTnZ0K2ibJLTLBeIKmFgKvfEsxOIYspM96W3OMHvtv6
         xjPAZ4x9k/3mY0O6O2M3JNbeplOOov29VXKkESGk=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
From:   Christian Theune <ct@flyingcircus.io>
In-Reply-To: <740b0d7e-c789-47b5-b419-377014a99f22@leemhuis.info>
Date:   Fri, 6 Oct 2023 12:51:32 +0200
Cc:     stable@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <BBEA77E4-D376-45CE-9A93-415F2E0703D7@flyingcircus.io>
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
 <207a8e5d-5f2a-4b33-9fc1-86811ad9f48a@leemhuis.info>
 <879EA0B7-F334-4A17-92D5-166F627BEE6F@flyingcircus.io>
 <740b0d7e-c789-47b5-b419-377014a99f22@leemhuis.info>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

sorry, no I didn=E2=80=99t. I don=E2=80=99t have a testbed available =
right now to try this out quickly.

Christian

> On 6. Oct 2023, at 11:16, Linux regression tracking (Thorsten =
Leemhuis) <regressions@leemhuis.info> wrote:
>=20
> On 06.10.23 11:07, Christian Theune wrote:
>>=20
>> it seems that 6.6rc4 is affected as well:
>>=20
>> ----
>> commit b3d26c5702c7d6c45456326e56d2ccf3f103e60f
>> Author: Budimir Markovic <markovicbudimir@gmail.com>
>> Date:   Thu Aug 24 01:49:05 2023 -0700
>>=20
>>    net/sched: sch_hfsc: Ensure inner classes have fsc curve
>> =E2=80=94=E2=80=94
>=20
> Did you actually try if the problem occurs with 6.6-rc4? That the =
commit
> is in there is expected (everything that lands in stable trees has to =
go
> to mainline first).
>=20
> Ciao, Thorsten
>=20
>> I have not found newer commits that would suggest they change any =
behaviour around this in any way, but I might be wrong.
>>=20
>> Christian
>>=20
>>> On 6. Oct 2023, at 11:01, Linux regression tracking (Thorsten =
Leemhuis) <regressions@leemhuis.info> wrote:
>>>=20
>>> On 06.10.23 10:37, Christian Theune wrote:
>>>>=20
>>>> (prefix, I was not aware of the regression reporting process and =
incorrectly reported this informally with the developers mentioned in =
the change)
>>>=20
>>> Don't worry too much about that, but thx for taking care of all the
>>> details. FWIW, there is one more thing that would be good to know:
>>>=20
>>> Does the problem happen with mainline (e.g. 6.6-rc4) as well? That's
>>> relevant, as different people might care[1].
>>>=20
>>> Ciao, Thorsten
>>>=20
>>> [1] this among others is explained here:
>>> =
https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-ke=
rnel-bug-reports-are-ignored/
>>>=20
>>>> I upgraded from 6.1.38 to 6.1.55 this morning and it broke my =
traffic shaping script, leaving me with a non-functional uplink on a =
remote router.
>>>>=20
>>>> The script errors out like this:
>>>>=20
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + ext=3DispA
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + =
ext_ingress=3Difb0
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + modprobe =
ifb
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + modprobe =
act_mirred
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc =
del dev ispA root
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2061]: Error: =
Cannot delete qdisc with handle of zero.
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc =
del dev ispA ingress
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2064]: Error: =
Cannot find specified qdisc on specified device.
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc =
del dev ifb0 root
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2066]: Error: =
Cannot delete qdisc with handle of zero.
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc =
del dev ifb0 ingress
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2067]: Error: =
Cannot find specified qdisc on specified device.
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc =
add dev ispA handle ffff: ingress
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + ifconfig =
ifb0 up
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc filter =
add dev ispA parent ffff: protocol all u32 match u32 0 0 action mirred =
egress redirect dev ifb0
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc =
add dev ifb0 root handle 1: hfsc default 1
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc class =
add dev ifb0 parent 1: classid 1:999 hfsc rt m2 2.5gbit
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc class =
add dev ifb0 parent 1:999 classid 1:1 hfsc sc rate 50mbit
>>>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2077]: Error: =
Invalid parent - parent class must have FSC.
>>>>=20
>>>> The error message is also a bit weird (but that=E2=80=99s likely =
due to iproute2 being weird) as the CLI interface for `tc` and the error =
message do not map well. (I think I would have to choose `hfsc sc` on =
the parent to enable the FSC option which isn=E2=80=99t mentioned =
anywhere in the hfsc manpage).
>>>>=20
>>>> The breaking change was introduced in 6.1.53[1] and a multitude of =
other currently supported kernels:
>>>>=20
>>>> ----
>>>> commit a1e820fc7808e42b990d224f40e9b4895503ac40
>>>> Author: Budimir Markovic <markovicbudimir@gmail.com>
>>>> Date: Thu Aug 24 01:49:05 2023 -0700
>>>>=20
>>>> net/sched: sch_hfsc: Ensure inner classes have fsc curve
>>>>=20
>>>> [ Upstream commit b3d26c5702c7d6c45456326e56d2ccf3f103e60f ]
>>>>=20
>>>> HFSC assumes that inner classes have an fsc curve, but it is =
currently
>>>> possible for classes without an fsc curve to become parents. This =
leads
>>>> to bugs including a use-after-free.
>>>>=20
>>>> Don't allow non-root classes without HFSC_FSC to become parents.
>>>>=20
>>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>>> Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
>>>> Signed-off-by: Budimir Markovic <markovicbudimir@gmail.com>
>>>> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
>>>> Link: =
https://lore.kernel.org/r/20230824084905.422-1-markovicbudimir@gmail.com
>>>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>>> ----
>>>>=20
>>>> Regards,
>>>> Christian
>>>>=20
>>>> [1] https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.1.53
>>>>=20
>>>> #regzbot introduced: a1e820fc7808e42b990d224f40e9b4895503ac40
>>>>=20
>>>>=20
>>=20
>> Liebe Gr=C3=BC=C3=9Fe,
>> Christian Theune
>>=20

Liebe Gr=C3=BC=C3=9Fe,
Christian Theune

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick

