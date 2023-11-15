Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1287DF597
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 16:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjKBPDw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 11:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjKBPDv (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 11:03:51 -0400
Received: from mail.flyingcircus.io (mail.flyingcircus.io [IPv6:2a02:238:f030:102::1064])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7865D193;
        Thu,  2 Nov 2023 08:03:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
        s=mail; t=1698937422;
        bh=P+tj398I5i3YozrQjUqZOpwRemov8iwZB6DBDr3ZVZc=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=ISK9fpZOL77xhBwQuEdY4YI+c1+zygp9UO9AW3QtqOekMebcdtBRxt5UkFbOvsYdo
         SRG1aTXy6PfqHA3hpCms1ojE34S5qZ6z5+ObYW0omK8oGtWU82ogUCEGuHnA5dL3Xj
         y6RR+bBqNv8npNwrx5r5/dgh+RKVX7pJ0c1UpVD0=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [REGRESSION] Backport? RIP: 0010:throtl_trim_slice+0xc6/0x320
 caused kernel panic
From:   Christian Theune <ct@flyingcircus.io>
In-Reply-To: <F5E0BC95-9883-4E8E-83A6-CD9962B7E90C@flyingcircus.io>
Date:   Thu, 2 Nov 2023 16:03:21 +0100
Cc:     linux-block@vger.kernel.org, yukuai3@huawei.com,
        ming.lei@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8624167B-9565-40C7-B151-1FD56EA65310@flyingcircus.io>
References: <F5E0BC95-9883-4E8E-83A6-CD9962B7E90C@flyingcircus.io>
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

> On 2. Nov 2023, at 15:53, Christian Theune <ct@flyingcircus.io> wrote:
>=20
> Hi,
>=20
> I hope i=E2=80=99m not jumping the gun, but I guess I=E2=80=99d be =
interested in a backport to said issue =E2=80=A6 ;)

It appears I jumped the gun. :(

I guess 6a5b845b57b122534d051129bc4fc85eac7f4a68 mentioned in =
https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.1.61 is the fix =
for this.=20

Sorry for the noise and mea culpa.

Christian Theune

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick

