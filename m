Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC0C798195
	for <lists+stable@lfdr.de>; Fri,  8 Sep 2023 07:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbjIHFpd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 8 Sep 2023 01:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjIHFpd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 8 Sep 2023 01:45:33 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC33419B6
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 22:45:24 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 137193F149
        for <stable@vger.kernel.org>; Fri,  8 Sep 2023 05:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694151923;
        bh=45vjpcw+xRo3eC7+D+kfKRYE6/jj4kl9eazD4IumkRA=;
        h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=vLBVqt6AgllFfd2IFhsaTVbY6qiuwMCcLLIbABSyEF3JroRxib1NqgqYSCqyONRpI
         W6Q+LzA9e/aKt6mLq6RNTNf1xTQL5hs5D4/I3mMumy9Umca5VPmH3ams1O8qDiCHcS
         7j4vdMOqknwAUyVwvDtY6hbD042qDLiHHRaJCGt8dNiXSPnKhAt+YlERaLRMGXvXzL
         +oL969Q7SJXej7EioOH6wgLzaBnbr926OQmUXArxYYOR1+XaXps1neRbV+wxBSpF52
         pgnYW4rJezGasY/ED3dGw5aIuVbcmk2XU6lRykiHU8qwYQodiVCoFqEmLRJLy2orik
         r0YW4xiOXDr4g==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-52bdadd5497so1226397a12.1
        for <stable@vger.kernel.org>; Thu, 07 Sep 2023 22:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694151922; x=1694756722;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45vjpcw+xRo3eC7+D+kfKRYE6/jj4kl9eazD4IumkRA=;
        b=EWpp429UPH0qs/ychsY1Uk6DyAFpAzIr+TYLgJ5gkgYw0/v6bvTbqTX6G8/saCyf8M
         DOANt1fNDBuo95KOt2zKZO1Pc6n1G5K+mtnYZRopECo5s2ps2wDbCGixXVcnbzXWX2HC
         laRSLCqTsQ14HJqGabzqUpr6mmyJWUVlJZfhWhWp27Qn9QwVD9St4q6Ex07ax47O8mS5
         nL9+y0LZaDlovBZwyhv1RZtcXJCnNQ5bYnKuwWoKkrYGcJXUr8IFxyHFWX8YzE1JafvV
         HNp6pL2zFVH9u/6Tkto3jWBAdTMQgTEkWKj1cAw6PzpzlSgMEeERyaNOBW6UuSXLz1NH
         9zjQ==
X-Gm-Message-State: AOJu0Yy0/HSJpv43htMC+yWJCbHShYhiazkHToWGQgtek/Xmyo8/v2BW
        zbM3VcWBj+zw19pyY6e2Lw23bPMSb1Wan1Tk28kjGPoYplZtsouMeBDGC81kaVcYJGgQ4TopVO8
        8F/WPhAVQQWB+qAOF90numLJmhsdxKV5q3YlYyN/v9g==
X-Received: by 2002:a05:6402:333:b0:522:3d36:ff27 with SMTP id q19-20020a056402033300b005223d36ff27mr949501edw.31.1694151922777;
        Thu, 07 Sep 2023 22:45:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3BAlDVxCSO9ZtnhKlhNs1u3J3RmyUtWOja1jkaSQo9qWkIfFp2cKJiV2kBzgWtPqzj98Lig==
X-Received: by 2002:a05:6402:333:b0:522:3d36:ff27 with SMTP id q19-20020a056402033300b005223d36ff27mr949488edw.31.1694151922445;
        Thu, 07 Sep 2023 22:45:22 -0700 (PDT)
Received: from smeagol ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b0052a3ad836basm563179edv.41.2023.09.07.22.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 22:45:21 -0700 (PDT)
Date:   Fri, 8 Sep 2023 07:45:18 +0200
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Hilda Wu <hildawu@realtek.com>,
        Max Chou <max.chou@realtek.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH 6.5.y] Bluetooth: btrtl: Load FW v2 otherwise FW v1 for
 RTL8852C
Message-ID: <20230908074518.66109038@smeagol>
In-Reply-To: <2023090700-wildfire-polka-1bc6@gregkh>
References: <2023083021-unease-catfish-92ad@gregkh>
        <20230906071129.37071-1-juerg.haefliger@canonical.com>
        <2023090700-wildfire-polka-1bc6@gregkh>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KHnWkUuzVcARqaW1R4wDCXl";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TRACKER_ID autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

--Sig_/KHnWkUuzVcARqaW1R4wDCXl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Sep 2023 11:18:13 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Sep 06, 2023 at 09:11:29AM +0200, Juerg Haefliger wrote:
> > In this commit, prefer to load FW v2 if available. Fallback to FW v1
> > otherwise. This behavior is only for RTL8852C.
> >=20
> > Fixes: 9a24ce5e29b1 ("Bluetooth: btrtl: Firmware format v2 support")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> > Tested-by: Hilda Wu <hildawu@realtek.com>
> > Signed-off-by: Max Chou <max.chou@realtek.com>
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > [juergh: Adjusted context due to missing .hw_info struct element]
> > Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> > ---
> >  drivers/bluetooth/btrtl.c | 70 +++++++++++++++++++++++++--------------
> >  1 file changed, 45 insertions(+), 25 deletions(-) =20
>=20
> What is the git commit id of this change in Linus's tree?

bd003fb338afee97c76f13c3e9144a7e4ad37179

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dbd003fb338afee97c76f13c3e9144a7e4ad37179


>
> thanks,
>=20
> greg k-h


--Sig_/KHnWkUuzVcARqaW1R4wDCXl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmT6tO4ACgkQD9OLCQum
Qrdtog/6AhbEckLcA9pbmCxOpYXCMaOEflvjldYyTUPjPiRQp+fZlSSOfQgtcPGo
s8lEO/dIbt6TQVNUyCyhmB7W1wmD9icwhoyfVagpkmYJCiYxoLKfU/crG0M05GVN
MDOMFiR/dQAPAK2bpFhufXGGvZhJQkma6BxJr0zr+q4UB314gSjV1P4hkclHo5Ei
pXnxpyTWsPTMnQLZd3SLnnDVmCagQepISXr1cOQ+8syv/ZjhnfZMLTKyfh5jWEp7
u7C3cLtQIExd7GVJPLjokossgy2LIPREzQQjQFC4rWhf+cjgCz+srLXkq3CrICKR
GyN9awXPU6GxpuGlXG3ZPK+EtXPSs363YO7B/8CUKNBQtwH9kM6GChTH3hcrXd7M
1UU+MevI6869q6huzkHvZXntKmatbfM9cIyPTy70opEQheTGFfqG3Bit/JWbqXLA
5fSSVBsHcol8RSAc2Ch04SJenvtUKNZ8eUkmxgpTTXptJEkLZ1URTHlb9LjuKXSR
vy1OE2kZEjUfnXX8iRKZC1fM9JkMK6ZM+PU00K6H1Kz3Z+iJ9xEHlIpiaoITekrm
OilP8S0AUqCahePMRJS87i8NmyhTl837dpD8aZsoGtVb7YqjC8zbCnHd39qC2K/5
llnklrvGmcWn4cX5GgF9kX4QcOTxDeET3nB6gj891Ih1rC+doPI=
=ypvC
-----END PGP SIGNATURE-----

--Sig_/KHnWkUuzVcARqaW1R4wDCXl--
