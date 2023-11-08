Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8E17E5EC8
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 20:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjKHTkT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 14:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKHTkT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 14:40:19 -0500
X-Greylist: delayed 8924 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Nov 2023 11:40:16 PST
Received: from smtp.inaport4.co.id (smtp.inaport4.co.id [103.219.76.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F62D211D
        for <stable@vger.kernel.org>; Wed,  8 Nov 2023 11:40:15 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp.inaport4.co.id (Postfix) with ESMTP id EDA5582860F3;
        Wed,  8 Nov 2023 23:48:41 +0800 (WITA)
Received: from smtp.inaport4.co.id ([127.0.0.1])
        by localhost (mta-1.inaport4.co.id [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HXtdR4_oI9ME; Wed,  8 Nov 2023 23:48:41 +0800 (WITA)
Received: from localhost (localhost [127.0.0.1])
        by smtp.inaport4.co.id (Postfix) with ESMTP id 184168286104;
        Wed,  8 Nov 2023 23:48:40 +0800 (WITA)
DKIM-Filter: OpenDKIM Filter v2.10.3 smtp.inaport4.co.id 184168286104
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inaport4.co.id;
        s=67133E3A-D729-11EC-9A3E-209BEC03DFB2; t=1699458520;
        bh=xe95vPdfjPC6ObD/kc0mx5ViZOT1geyhmpeP94Caexg=;
        h=Date:From:Message-ID:MIME-Version;
        b=bkoggTkKZk2NNmVYL7symnJm4M25AkSRJX8xyAaFTwDIEss2gGMiyHDGGQRojtenw
         AvpnCIBLBjneGIHVOuq7tQB8mRElZFAUNhILu+OrkNsPyC1ojWACy8mNV2+4AjU2HW
         cvf4ph43QqN94+pfK7z1UjRiSl9dnH/KaDHFNHkDQoFOFMsuB3S5QBNOzjKD+LUxGd
         HSo/vegL+jUzKfcTEU/gS6sW3I0UWNKY46Ys6TaFJyp+iHF4smK7q+NJ3kKG1ntdwy
         rX6uQted/CHsKNM7gRLCNleagkGrLiksnAMRBzPmeYAW1JgVqmaT3YrVaqvSSoHgoj
         JlSX2ttO+mpRg==
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta-1.inaport4.co.id
X-Virus-Scanned: amavisd-new at 
Received: from smtp.inaport4.co.id ([127.0.0.1])
        by localhost (mta-1.inaport4.co.id [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4RaYyULu-GIL; Wed,  8 Nov 2023 23:48:39 +0800 (WITA)
Received: from mailstore.inaport4.co.id (mailstore.inaport4.co.id [172.10.1.75])
        by smtp.inaport4.co.id (Postfix) with ESMTP id A317B81C6CB6;
        Wed,  8 Nov 2023 23:48:34 +0800 (WITA)
Date:   Wed, 8 Nov 2023 23:48:34 +0800 (WITA)
From:   =?utf-8?B?0YHQuNGB0YLQtdC80L3QuNC5INCw0LTQvNGW0L3RltGB0YLRgNCw0YLQvtGA?= 
        <ahmad.rifai@inaport4.co.id>
Reply-To: sistemassadmins@mail2engineer.com
Message-ID: <185446474.23984.1699458514632.JavaMail.zimbra@inaport4.co.id>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Mailer: Zimbra 8.8.8_GA_3025 (zclient/8.8.8_GA_3025)
Thread-Index: /1pK/0nsTpItwqMGy34SoxctqzpPQg==
Thread-Topic: 
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

=D1=83=D0=B2=D0=B0=D0=B3=D0=B0;

=D0=92=D0=B0=D1=88=D0=B0 =D0=B5=D0=BB=D0=B5=D0=BA=D1=82=D1=80=D0=BE=D0=BD=
=D0=BD=D0=B0 =D0=BF=D0=BE=D1=88=D1=82=D0=B0 =D0=BF=D0=B5=D1=80=D0=B5=D0=B2=
=D0=B8=D1=89=D0=B8=D0=BB=D0=B0 =D0=BE=D0=B1=D0=BC=D0=B5=D0=B6=D0=B5=D0=BD=
=D0=BD=D1=8F =D0=BF=D0=B0=D0=BC'=D1=8F=D1=82=D1=96, =D1=8F=D0=BA=D0=B5 =D1=
=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C 5 =D0=93=D0=91, =D0=B2=
=D0=B8=D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=D0=B5 =D0=B0=D0=B4=D0=BC=D1=96=
=D0=BD=D1=96=D1=81=D1=82=D1=80=D0=B0=D1=82=D0=BE=D1=80=D0=BE=D0=BC, =D1=8F=
=D0=BA=D0=B5 =D0=B2 =D0=B4=D0=B0=D0=BD=D0=B8=D0=B9 =D1=87=D0=B0=D1=81 =D0=
=BF=D1=80=D0=B0=D1=86=D1=8E=D1=94 =D0=BD=D0=B0 10,9 =D0=93=D0=91. =D0=92=D0=
=B8 =D0=BD=D0=B5 =D0=B7=D0=BC=D0=BE=D0=B6=D0=B5=D1=82=D0=B5 =D0=BD=D0=B0=D0=
=B4=D1=81=D0=B8=D0=BB=D0=B0=D1=82=D0=B8 =D0=B0=D0=B1=D0=BE =D0=BE=D1=82=D1=
=80=D0=B8=D0=BC=D1=83=D0=B2=D0=B0=D1=82=D0=B8 =D0=BD=D0=BE=D0=B2=D1=83 =D0=
=BF=D0=BE=D1=88=D1=82=D1=83, =D0=B4=D0=BE=D0=BA=D0=B8 =D0=BD=D0=B5 =D0=BF=
=D0=B5=D1=80=D0=B5=D0=B2=D1=96=D1=80=D0=B8=D1=82=D0=B5 =D0=BF=D0=BE=D1=88=
=D1=82=D0=BE=D0=B2=D1=83 =D1=81=D0=BA=D1=80=D0=B8=D0=BD=D1=8C=D0=BA=D1=83=
 "=D0=92=D1=85=D1=96=D0=B4=D0=BD=D1=96". =D0=A9=D0=BE=D0=B1 =D0=B2=D1=96=D0=
=B4=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D0=B8 =D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=
=BD=D1=96=D1=81=D1=82=D1=8C =D0=BF=D0=BE=D1=88=D1=82=D0=BE=D0=B2=D0=BE=D1=
=97 =D1=81=D0=BA=D1=80=D0=B8=D0=BD=D1=8C=D0=BA=D0=B8, =D0=BD=D0=B0=D0=B4=D1=
=96=D1=88=D0=BB=D1=96=D1=82=D1=8C =D1=82=D0=B0=D0=BA=D1=96 =D0=B2=D1=96=D0=
=B4=D0=BE=D0=BC=D0=BE=D1=81=D1=82=D1=96
=D0=BD=D0=B8=D0=B6=D1=87=D0=B5:

=D0=86=D0=BC'=D1=8F:
=D0=86=D0=BC'=D1=8F =D0=BA=D0=BE=D1=80=D0=B8=D1=81=D1=82=D1=83=D0=B2=D0=B0=
=D1=87=D0=B0:
=D0=BF=D0=B0=D1=80=D0=BE=D0=BB=D1=8C:
=D0=9F=D1=96=D0=B4=D1=82=D0=B2=D0=B5=D1=80=D0=B4=D0=B6=D0=B5=D0=BD=D0=BD=D1=
=8F =D0=BF=D0=B0=D1=80=D0=BE=D0=BB=D1=8F:
=D0=90=D0=B4=D1=80=D0=B5=D1=81=D0=B0 =D0=B5=D0=BB=D0=B5=D0=BA=D1=82=D1=80=
=D0=BE=D0=BD=D0=BD=D0=BE=D1=97 =D0=BF=D0=BE=D1=88=D1=82=D0=B8:
=D1=82=D0=B5=D0=BB=D0=B5=D1=84=D0=BE=D0=BD:

=D0=AF=D0=BA=D1=89=D0=BE =D0=BD=D0=B5 =D0=B2=D0=B4=D0=B0=D1=94=D1=82=D1=8C=
=D1=81=D1=8F =D0=BF=D0=BE=D0=B2=D1=82=D0=BE=D1=80=D0=BD=D0=BE =D0=BF=D0=B5=
=D1=80=D0=B5=D0=B2=D1=96=D1=80=D0=B8=D1=82=D0=B8 =D0=BF=D0=BE=D0=B2=D1=96=
=D0=B4=D0=BE=D0=BC=D0=BB=D0=B5=D0=BD=D0=BD=D1=8F, =D0=B2=D0=B0=D1=88=D0=B0=
 =D0=BF=D0=BE=D1=88=D1=82=D0=BE=D0=B2=D0=B0 =D1=81=D0=BA=D1=80=D0=B8=D0=BD=
=D1=8C=D0=BA=D0=B0 =D0=B1=D1=83=D0=B4=D0=B5 =D0=92=D0=B8=D0=BC=D0=BA=D0=BD=
=D1=83=D1=82=D0=BE!

=D0=9F=D1=80=D0=B8=D0=BD=D0=BE=D1=81=D0=B8=D0=BC=D0=BE =D0=B2=D0=B8=D0=B1=
=D0=B0=D1=87=D0=B5=D0=BD=D0=BD=D1=8F =D0=B7=D0=B0 =D0=BD=D0=B5=D0=B7=D1=80=
=D1=83=D1=87=D0=BD=D0=BE=D1=81=D1=82=D1=96.
=D0=9A=D0=BE=D0=B4 =D0=BF=D1=96=D0=B4=D1=82=D0=B2=D0=B5=D1=80=D0=B4=D0=B6=
=D0=B5=D0=BD=D0=BD=D1=8F:@WEB.ADMIN.UA:@2023.UA.=D0=A1=D0=98=D0=A1=D0=A2=D0=
=95=D0=9C=D0=9D=D0=98=D0=99 =D0=90=D0=94=D0=9C=D0=86=D0=9D=D0=86=D0=A1=D0=
=A2=D0=A0=D0=90=D0=A2=D0=9E=D0=A0
=D0=A2=D0=B5=D1=85=D0=BD=D1=96=D1=87=D0=BD=D0=B0 =D0=BF=D1=96=D0=B4=D1=82=
=D1=80=D0=B8=D0=BC=D0=BA=D0=B0 =D0=9F=D0=BE=D1=88=D1=82=D0=B8 =D0=A1=D0=B8=
=D1=81=D1=82=D0=B5=D0=BC=D0=BD=D0=B8=D0=B9 =D0=B0=D0=B4=D0=BC=D1=96=D0=BD=
=D1=96=D1=81=D1=82=D1=80=D0=B0=D1=82=D0=BE=D1=80 @2023


