Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88C97B48A8
	for <lists+stable@lfdr.de>; Sun,  1 Oct 2023 18:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbjJAQva (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 1 Oct 2023 12:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjJAQv3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 1 Oct 2023 12:51:29 -0400
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [IPv6:2001:1600:4:17::42a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7321C6
        for <stable@vger.kernel.org>; Sun,  1 Oct 2023 09:51:24 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Rz98V5RxQzMq1NM;
        Sun,  1 Oct 2023 16:51:22 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Rz98V18cgz3j;
        Sun,  1 Oct 2023 18:51:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=delahaye.me;
        s=20230709; t=1696179082;
        bh=h3W/JMfCLQZT2NWv/zSS6y/3OtjGM8DWBw14k/u41Sg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GIcc9y2orrHIK5QlPiKymmMVk6EgEk1NJp3q5zvbWRodZFXe/0CtZSW6tvK1Gap24
         v578DgW4yF8qCmWNfFm1iJ3EHChkr67WeNphwBGFkpt1WJrpSaoySsxjaA+fPfBLkV
         l5e3q2fWCPCNYlIPfFtf3IOWIhQz04F9QwHwue6jTCVxTqDDODJpzxJx4dk03FodKG
         w0coWMJ4T2/YpyZ/YQ+s13cnli54G/7S2GZiHOm3slJkkd0MSkG9si5TU+Vz4YZLbs
         etGWRXVMYweGue66Wldfte1q8vpiBY0+eS+QoSMxgCrVd/JcnZKtgo7S5/2MZGOW2y
         Ryjk3pSZqu4Tw==
Message-ID: <35a24c8387bb519c5a3325dc7cb83492ffae1ebe.camel@delahaye.me>
Subject: Re: [Kernel 6.5] Important read()/write() performance regression
From:   Florent DELAHAYE <florent@delahaye.me>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, regressions@lists.linux.dev
Date:   Sun, 01 Oct 2023 18:51:21 +0200
In-Reply-To: <2023093036-swear-snowbird-aeda@gregkh>
References: <28df26a419a041f3c4f44c5e2a6697adbaee83f3.camel@delahaye.me>
         <94a7f9171b60c0d2430106632db84276f516d454.camel@delahaye.me>
         <2023093036-swear-snowbird-aeda@gregkh>
Autocrypt: addr=florent@delahaye.me; prefer-encrypt=mutual;
 keydata=mQINBFiOKngBEADTLMfJdCgTqe1aHNZ09D3kFyMXx9UvKP25RbQUhzZdC7Z2YzRJImp/KXeuLtqRYONxzrmdVRnX4YvnohdE8NgvFnp4O6Jqn2VnkGj2ezl7tQgaVyMbl+frPQn39PgdeWWuhMrvYcVRSPAdKBulLp9W3zUshyVks6pVYImZfaqojCazuCj1kA1FVwt0VGbVUS4M1SER2EbCufbwIHbxFQVbHEGc6LTyOTJAPr44rEGapkQTdIC90gXFk7wO33vbJUaTi8wkMYLSiY4K2vAtYeqrmrauEn8plgV97gwuWx5DxIKp0J/Fgs5GsgbLFAssnNOxkatvlx+qWL8XYMlQ6dRpJdsAQ6C585vIfljvE6sI1WfvBM0jI9oPWxIK4Py4Nrq7SMRGGv9pyz7zxNgoW5aFiivxTvnESIW2ZAqr+G6AGVir3dj5HoQ05Rm+Y87tuqkFu1Vp8poiC33JUP/DvfgLxCryH6UTAU2QmTzVGBMxz3eSVS5qa5Y/ySLj11PG47LqN68nXjR/NcpkpYQXLZzz9JtVhppp8o5arQL1hK0u8rAlRUlddb6Whd0ErKRAnIE6JNyxWZAsftimkx/2hWCmoM9kM5RTQgwA0H1OZn/2zszWC3pXsuEKe9SzdAiOAQhwDbSh4b3aR6+O8EHpTz37EJLxZ079SeCNGvuID7jwfwARAQABtCZGbG9yZW50IERFTEFIQVlFIDxmbG9yZW50QGRlbGFoYXllLm1lPokCVAQTAQoAPhYhBCEQSCRTDLM0FBnp770r9ueawshnBQJdimV+AhsBBQkOYjwRBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEL0r9ueawshn6uQQAM6JERU6CC70AiFv7nz9PmDCYF7lRxS15EKI30HfXeRp+RriQMYeNsk6/pUqJRReYcCgz9zyEj4JE+E8B52mtX+CtvLRmRmbwurGs38G9CnrkWZkhQXoO
        e5F+woA0SX8+rBpixPbXrlBHv1PV4tYCet+P1lBFkcSPyWmskRbbpYiJV13MVxrFaEfQvGXIgdE9wzKtJIwEXOLZm7gUW6uLHHDtNZgo4CwJL371XD3vKwrEFOh4ptyMGaxYqN6nlWvc0+u9Zfnqo+0sCumP8DydNrAZ4KyTfzgo8YfChQE6/DHN9PTfNSREKhcUCar6GHAaI++v91EhkAsuvlP7Uiia4oH5ZPOBBKD7aDnWwIlZMjFt8AGJf0gDPmcg+yIS8MzF2GBMRt3zIS9hamRxF/+x8zBVK2DTIqt4zmKVde5pAWLV4N98m59HfvJKgiwXNoWc4Na61FA0FN39uqD+PTo9dm9a37JcnFrSXfoAjTQJ/aupwyS8z5FuWdDuLuqE0sLzvLC2Mu6HOh7aSEUaxQWWlBm3rvAa2n1YtYZ6yFxfyrlVnqjZsTTJp0DLBKUXfRQ2bXv42oC7WbooX1X0wU649DWPVODfWJScIsGh3i/unl8HEb/3aiKpeJa4frHunZzlrFq7Lmuybpoyx0E2lOqeF6XbqxPQOQdpeNsaQmbS+nV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Le samedi 30 septembre 2023 =C3=A0 20:33 +0200, Greg KH a =C3=A9crit=C2=A0:
> On Sat, Sep 30, 2023 at 07:07:06PM +0200, Florent DELAHAYE wrote:
> > Hello guys,
> >=20
> > During the last few months, I felt a performance regression when
> > using
> > read() and write() on my high-speed Nvme SSD (about 7GB/s).
> >=20
> > To get more precise information about it I quickly developed
> > benchmark
> > tool basically running read() or write() in a loop to simulate a
> > sequential file read or write. The tool also measures the real time
> > consumed by the loop. Finally, the tool can call open() with or
> > without
> > O_DIRECT.
> >=20
> > I ran the tests on EXT4 and Exfat with following settings (buffer
> > values have been set for best result):=C2=A0=20
> > - Write settings: buffer 400mb * 100=C2=A0=20
> > - Read settings: buffer 200mb=C2=A0=20
> > - Drop caches before non-direct read/write test
> >=20
> > With this hardware:=C2=A0=20
> > - CPU AMD Ryzen 7600X=C2=A0=20
> > - RAM DDR5 5200 32GB=C2=A0=20
> > - SSD Kingston Fury Renegade 4TB with 4K LBA
> >=20
> >=20
> > Here are some results I got with last upstream kernels (default
> > config):
> > +------------------+----------+------------------+-----------------
> > -+--
> > ----------------+------------------+------------------+
> > > ~42GB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | O_DIRECT | Linux 6.2.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Linux 6.3.0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > |
> > Linux 6.4.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Linux 6.5.0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | Linux 6.5.5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > +------------------+----------+------------------+-----------------
> > -+--
> > ----------------+------------------+------------------+
> > > Ext4 (sector 4k) |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > |=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > Read=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | no=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 7.2s (5800MB/s)=C2=A0 =
| 7.1s (5890MB/s)=C2=A0
> > > |
> > 8.3s (5050MB/s)=C2=A0 | 13.2s (3180MB/s) | 13.2s (3180MB/s) |
> > > Write=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | no=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12.0s (3500MB/s) | 12.6s (33=
40MB/s)
> > > |
> > 12.2s (3440MB/s) | 28.9s (1450MB/s) | 28.9s (1450MB/s) |
> > > Read=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | yes=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6.0s (7000MB/s)=C2=A0 | 6.0=
s (7020MB/s)=C2=A0
> > > |
> > 5.9s (7170MB/s)=C2=A0 | 5.9s (7100MB/s)=C2=A0 | 5.9s (7100MB/s)=C2=A0 |
> > > Write=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | yes=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6.7s (6220MB/s)=C2=A0 | 6.7s (629=
0MB/s)=C2=A0
> > > |
> > 6.9s (6080MB/s)=C2=A0 | 6.9s (6080MB/s)=C2=A0 | 6.9s (6970MB/s)=C2=A0 |
> > > Exfat (sector ?) |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > |=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > Read=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | no=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 7.3s (5770MB/s)=C2=A0 =
| 7.2s (5830MB/s)=C2=A0
> > > |
> > 9s (4620MB/s)=C2=A0=C2=A0=C2=A0 | 13.3s (3150MB/s) | 13.2s (3180MB/s) |
> > > Write=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | no=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 8.3s (5040MB/s)=C2=A0 | 8.9s=
 (4750MB/s)=C2=A0
> > > |
> > 8.3s (5040MB/s)=C2=A0 | 18.3s (2290MB/s) | 18.5s (2260MB/s) |
> > > Read=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | yes=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6.2s (6760MB/s)=C2=A0 | 6.1=
s (6870MB/s)=C2=A0
> > > |
> > 6.0s (6980MB/s)=C2=A0 | 6.5s (6440MB/s)=C2=A0 | 6.6s (6320MB/s)=C2=A0 |
> > > Write=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | yes=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16.1s (2610MB/s) | 16.0s (2620MB/=
s)
> > > |
> > 18.7s (2240MB/s) | 34.1s (1230MB/s) | 34.5s (1220MB/s) |
> > +------------------+----------+------------------+-----------------
> > -+--
> > ----------------+------------------+------------------+
> >=20
> > Please note that I rounded some values to clarify readiness. Small
> > variations can be considered as margin error.
> >=20
> > Ext4 results: cached reads/writes time have increased of almost
> > 100%
> > from 6.2.0 to 6.5.0 with a first increase with 6.4.0. Direct access
> > times have stayed similar though.=C2=A0=20
> > Exfat results: performance decrease too with and without direct
> > access
> > this time.
> >=20
> > I realize there are thousands of commits between, plus the issue
> > can
> > come from multiple kernel parts such as the page cache, the file
> > system
> > implementation (especially for Exfat), the IO engine, a driver,
> > etc.
> > The results also showed that there is not only a specific version
> > impacted. Anyway, at the end the performance have highly decreased.
> >=20
> > If you want to verify my benchmark tool source code, please ask.
>=20
> Have you tried something like fio instead of a new benchmark tool?=C2=A0
> That
> way others can test and verify the results on their systems as that
> is a
> well-known and tested benchmark tool.

I understand. Yes I did and had similar results however I just ran it
again to record the average results. I have run following fio commands:

write: fio --name=3Dtest-write --filename=3Dtestfio.out --readwrite=3Dwrite=
 -
-blocksize=3D400m --size=3D41943040000 --ioengine=3Dlibaio --iodepth=3D2 (-=
-
direct=3D1)

read: fio =E2=80=93name=3Dtest-read --filename=3Dtestfio.out --readwrite=3D=
read --
blocksize=3D200m --size=3D41943040000 --ioengine=3Dlibaio =E2=80=93iodepth=
=3D2=C2=A0(--
direct=3D1)

See results below.

> Also, are you sure you just haven't been hit by the spectre fixes
> that
> slow down the I/O path a lot?=C2=A0 Be sure you have feature parity on
> those
> older kernels please.=C2=A0 Many of the ones you list above do NOT have
> those
> required changes.

Indeed! mitigations=3Doff clearly mitigated the performance loss, thank
you! I thought it was not very relevant nowadays but it clearly still
is especially from 6.4.0 to 6.5.0, however there is still a trend as
you can see here (fio results with mitigations=3Doff):

+-----------+----------+-----------------+------------------+----------
--------+------------------+
|   ~42GB   | O_DIRECT |   Linux 6.2.0   |   Linux 6.3.0    |   Linux
6.4.0    |   Linux 6.5.0    |
+-----------+----------+-----------------+------------------+----------
--------+------------------+
| Ext4 (4k) |          |                 |                  |        =20
|                  |
| Read      | no       | 9.0s (4620MB/s) | 9.0s (4600MB/s)  | 13.2s
(3180MB/s) | 13.6s (3080MB/s) |
| Write     | no       | 12s (3490MB/s)  | 12.2s (3430MB/s) | 12.0s
(3500MB/s) | 11.0s (3820MB/s) |
| Read      | yes      | 5.9s (7070MB/s) | 5.9s (7070MB/s)  | 5.8s
(7200MB/s)  | 5.8s (7200MB/s)  |
| Write     | yes      | 6.4s(6500MB/s)  | 6.4s (6530MB/s)  | 6.5s
(6430MB/s)  | 6.9s (6070MB/s)  |
+-----------+----------+-----------------+------------------+----------
--------+------------------+

-> So basically there are similar direct read/write timings, cached
writes are roughly constant too however cached reads take more time (9s
> 13s, +~50%).

How to make sure I have feature parity across all kernels? I run a
simple "make menuconfig" and exit with default options for compilation.

Regards

Florent DELAHAYE

