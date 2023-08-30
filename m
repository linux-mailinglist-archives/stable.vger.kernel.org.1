Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C017F78DB5C
	for <lists+stable@lfdr.de>; Wed, 30 Aug 2023 20:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238680AbjH3Si5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 30 Aug 2023 14:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244015AbjH3MOI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 30 Aug 2023 08:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B97CDB
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 05:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693397593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1F78b5ofm2tptIlL2YKKfP4o/taKmISCGn7BNhmGQCw=;
        b=ZHVJmzUesX52T3zqLtWWK9VvHFw4PCZEelbfz7UFO3OKDoGcsYrQLyRDGWtwE0UCT9/yQ/
        PyvTQw4nmnCavglNm+rAFdu/Os9JTNB13upMr2aP26aJGT4kqYytkH/PKm7kZLVFh0daD3
        nv4cyONAGuBo+MJFV8A0ggHw4+69T9s=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-m_3dptnPM1WwxtEEfkucpw-1; Wed, 30 Aug 2023 08:13:12 -0400
X-MC-Unique: m_3dptnPM1WwxtEEfkucpw-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-44d5ac106ddso2350828137.3
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 05:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693397592; x=1694002392;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1F78b5ofm2tptIlL2YKKfP4o/taKmISCGn7BNhmGQCw=;
        b=Wp30SULUcOQscEJoCczAow2SWCpxEwc4PeT9xnsWP9M4l68Lj3eKD9EsTI0A788mx+
         cttZdrmSKu1nXOMWI8Ib+HS7TS8gADPeUIJh2I6jhad35SUMJm+yXqC0IBgFyFaa2IsE
         gilczW8KMeZTQiX2MkOmjqmWhvd3aVlDRQ2H2tPdnjVCw5VPpZnsgsvSlA7nUIW5B/FM
         Iqhvu51bgyQy183jSHvJjlZOE0FSCsqLYxLveNqoU+iEz77JP7EHQZDDqSNpp++1ZU8O
         r014ugDmEPiH3EflsYH2pk+lgBkT+KTcyMHJGBMln/e5Ked0d9vBRkJJQHPK/5mku2zB
         Fz/g==
X-Gm-Message-State: AOJu0YzZ8i7dRRoIduOqI/ABfToNbPhifP1ijFxZwrf5cuS1w/y22pxg
        kOXONfRaJ1GFjqS4fqYH9aJipEFbnnVrYCM/F3RkxFIp/dYggY9Bd4PrH+cSZidHzWgJMXFMjXg
        AUKjqi8qWqgcAxEOI
X-Received: by 2002:a67:fe16:0:b0:44d:4a41:893e with SMTP id l22-20020a67fe16000000b0044d4a41893emr2079396vsr.6.1693397591961;
        Wed, 30 Aug 2023 05:13:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3KC91P54oCWE0dAIrgANuObC46VEf28Zren2AZv5A+71k9buaZ36X0Yl2zi04wuYQwR4GDw==
X-Received: by 2002:a67:fe16:0:b0:44d:4a41:893e with SMTP id l22-20020a67fe16000000b0044d4a41893emr2079385vsr.6.1693397591709;
        Wed, 30 Aug 2023 05:13:11 -0700 (PDT)
Received: from thinkpad-p1.localdomain (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id j15-20020a0ce00f000000b0064713c8fab7sm4054290qvk.59.2023.08.30.05.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 05:13:11 -0700 (PDT)
Message-ID: <23a1677c3df233c220df68ea429a2d0fec52e1d4.camel@redhat.com>
Subject: Re: [PATCH v3 1/3] cacheinfo: Allocate memory for memory if not
 done from the primary CPU
From:   Radu Rendec <rrendec@redhat.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Pu Wen <puwen@hygon.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        stable@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Wed, 30 Aug 2023 08:13:09 -0400
In-Reply-To: <20230830114918.be4mvwfogdqmsxk6@bogus>
References: <20230805012421.7002-1-ricardo.neri-calderon@linux.intel.com>
         <20230805012421.7002-2-ricardo.neri-calderon@linux.intel.com>
         <20230830114918.be4mvwfogdqmsxk6@bogus>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 2023-08-30 at 12:49 +0100, Sudeep Holla wrote:
> On Fri, Aug 04, 2023 at 06:24:19PM -0700, Ricardo Neri wrote:
> > Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
> > adds functionality that architectures can use to optionally allocate an=
d
> > build cacheinfo early during boot. Commit 6539cffa9495 ("cacheinfo: Add
> > arch specific early level initializer") lets secondary CPUs correct (an=
d
> > reallocate memory) cacheinfo data if needed.
> >=20
> > If the early build functionality is not used and cacheinfo does not nee=
d
> > correction, memory for cacheinfo is never allocated. x86 does not use t=
he
> > early build functionality. Consequently, during the cacheinfo CPU hotpl=
ug
> > callback, last_level_cache_is_valid() attempts to dereference a NULL
> > pointer:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 BUG: kernel NULL pointer dereference, address:=
 0000000000000100
> > =C2=A0=C2=A0=C2=A0=C2=A0 #PF: supervisor read access in kernel mode
> > =C2=A0=C2=A0=C2=A0=C2=A0 #PF: error_code(0x0000) - not present page
> > =C2=A0=C2=A0=C2=A0=C2=A0 PGD 0 P4D 0
> > =C2=A0=C2=A0=C2=A0=C2=A0 Oops: 0000 [#1] PREEPMT SMP NOPTI
> > =C2=A0=C2=A0=C2=A0=C2=A0 CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.4.0-=
rc2 #1
> > =C2=A0=C2=A0=C2=A0=C2=A0 RIP: 0010: last_level_cache_is_valid+0x95/0xe0=
a
> >=20
> > Allocate memory for cacheinfo during the cacheinfo CPU hotplug callback=
 if
> > not done earlier.
> >=20
> > Cc: Andreas Herrmann <aherrmann@suse.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Chen Yu <yu.c.chen@intel.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Radu Rendec <rrendec@redhat.com>
> > Cc: Pierre Gondois <Pierre.Gondois@arm.com>
> > Cc: Pu Wen <puwen@hygon.cn>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: stable@vger.kernel.org
> > Acked-by: Len Brown <len.brown@intel.com>
> > Fixes: 6539cffa9495 ("cacheinfo: Add arch specific early level initiali=
zer")
>=20
> Not sure if we strictly need this(details below), but I am fine either wa=
y.
>=20
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > The motivation for commit 5944ce092b97 was to prevent a BUG splat in
> > PREEMPT_RT kernels during memory allocation. This splat is not observed=
 on
> > x86 because the memory allocation for cacheinfo happens in
> > detect_cache_attributes() from the cacheinfo CPU hotplug callback.
> >=20
> > The dereference of a NULL pointer is not observed today because
> > cache_leaves(cpu) is zero until after init_cache_level() is called (als=
o
> > during the CPU hotplug callback). Patch2 will set it earlier and the NU=
LL-
> > pointer dereference will be observed.
>=20
> Right, this is the information I have been asking in the previous version=
s.
> This clarifies a lot. The trigger is in the patch 2/3 which is why it did=
n't
> make complete sense to me without it when you posted this patch independe=
ntly.
> Thanks for posting it together and sorry for the delay(both reviewing thi=
s
> and in understanding the issue).
>=20
> Given the trigger for NULL pointer dereference is in 2/3, I am not sure
> if it is really worth applying this to all the stable kernels with the
> commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU").
> That is the reason why I asked to drop fixes tag if you agree with me.
> It is simple fix, so I am OK if you prefer to see that in the stable kern=
els
> as well.

Thanks for reviewing, Sudeep. Since my previous commit 6539cffa9495
("cacheinfo: Add arch specific early level initializer") opens a door
for the NULL pointer dereference, I would sleep better at night if the
fix was included in the stable kernels :) But seriously, I am concerned
that with the fix applied in mainline and not in stable, something else
could be backported to the stable in the future, that could trigger the
NULL pointer dereference there. Ricardo's patch 2/3 is one way to
trigger it, but you never know what other patch lands in mainline in
the future that assumes it's safe to set the cache leaves earlier.

> Since there are x86 changes and patch 2/3 triggers NULL pointer dereferen=
ce
> without this patch, I prefer you route all 3 via x86. So,
>=20
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Radu

