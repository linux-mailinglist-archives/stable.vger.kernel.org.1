Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4836578DB0F
	for <lists+stable@lfdr.de>; Wed, 30 Aug 2023 20:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbjH3Si1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 30 Aug 2023 14:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbjH3QqP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 30 Aug 2023 12:46:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257FECC2
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 09:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693413927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2kcdAhul63F+gq9DZ4acKwcsYj0UGqnNLCr2y+dE+Js=;
        b=B7VE+48XaSljjWpUiD8ylQhWR4/0fZeeiJaKDLpI8+EL2MTUtyCFLfVZPidFBIuXvAimn0
        7v2kI1DTvX9h+ET+jY6NSiaFDw3rL1/LKzmGYHt35tKuwf1XcqZDZ4qZ6sdtMy+P8G5iV5
        CP6COiNCK7pNBbo1RK0zEnP3Agn5m6Q=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-8ViYY_muM0GuO-60UU90hw-1; Wed, 30 Aug 2023 12:45:25 -0400
X-MC-Unique: 8ViYY_muM0GuO-60UU90hw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-651760e36feso9137396d6.0
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 09:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693413925; x=1694018725;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2kcdAhul63F+gq9DZ4acKwcsYj0UGqnNLCr2y+dE+Js=;
        b=XHxfIOdj1ia1kg2/mtxFnUVvxEU9CPmLAkLkjYVSojb3ozvMQVhV9fV4wf9OojPHBa
         N2bRC/Kh75anBFaJkW0Czp/XvAefMjRrZv/ix3FjuketS1o0uNrWnnC4VrLKsojANIsE
         LcZJvYsQlv0tPQ8hwbk0J5331eLS1UjatcRAhIo248vfQIo1QU8Y4ysOAr9gWQc7Zwec
         SPc7/0idiUFhQ7q/BCVLk+HTrsukgE8yPOTsbkVP6xHVoWTQkmlvSAiENfNxjauif/oU
         kov536bY9+MiELD11VuW24UGxLsUBMPIozWEnQgoxkHxM9ZK9X9JFTN61NlUCQP8hlRI
         sm1A==
X-Gm-Message-State: AOJu0YwYJxF6g0TDnlftC3wOdnDjqAqVE2niOZrW9FZYoEGdA+SSaj/c
        gAVFnpCM+gUjbZTk6jFEhyzvmICL58OMHqgSg/B6rkXkCm3ARKuZCb526G0FgBk14KOoS0EXnoc
        1qXk1SH/WIijbPRqb
X-Received: by 2002:a05:6214:27c9:b0:651:66a3:64bd with SMTP id ge9-20020a05621427c900b0065166a364bdmr196218qvb.29.1693413924845;
        Wed, 30 Aug 2023 09:45:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnCvIEzPGc5rHAL2vsQBMugMyi/n5SuZwZyTezJhJjpxOHcoiAWXL9olYFTddaJkJYQlIVMQ==
X-Received: by 2002:a05:6214:27c9:b0:651:66a3:64bd with SMTP id ge9-20020a05621427c900b0065166a364bdmr196198qvb.29.1693413924599;
        Wed, 30 Aug 2023 09:45:24 -0700 (PDT)
Received: from thinkpad-p1.localdomain (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id m4-20020a0cf184000000b0063cfb3fbb7esm4224108qvl.16.2023.08.30.09.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 09:45:24 -0700 (PDT)
Message-ID: <03e51c6072d80931a6b532ce1d4d7388a6f84d32.camel@redhat.com>
Subject: Re: [PATCH v3 1/3] cacheinfo: Allocate memory for memory if not
 done from the primary CPU
From:   Radu Rendec <rrendec@redhat.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
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
Date:   Wed, 30 Aug 2023 12:45:22 -0400
In-Reply-To: <20230830154707.dyeihenolc5nwmi2@bogus>
References: <20230805012421.7002-1-ricardo.neri-calderon@linux.intel.com>
         <20230805012421.7002-2-ricardo.neri-calderon@linux.intel.com>
         <20230830114918.be4mvwfogdqmsxk6@bogus>
         <23a1677c3df233c220df68ea429a2d0fec52e1d4.camel@redhat.com>
         <20230830154707.dyeihenolc5nwmi2@bogus>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 2023-08-30 at 16:47 +0100, Sudeep Holla wrote:
> On Wed, Aug 30, 2023 at 08:13:09AM -0400, Radu Rendec wrote:
> > On Wed, 2023-08-30 at 12:49 +0100, Sudeep Holla wrote:
> > > On Fri, Aug 04, 2023 at 06:24:19PM -0700, Ricardo Neri wrote:
> > > > Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary C=
PU")
> > > > adds functionality that architectures can use to optionally allocat=
e and
> > > > build cacheinfo early during boot. Commit 6539cffa9495 ("cacheinfo:=
 Add
> > > > arch specific early level initializer") lets secondary CPUs correct=
 (and
> > > > reallocate memory) cacheinfo data if needed.
> > > >=20
> > > > If the early build functionality is not used and cacheinfo does not=
 need
> > > > correction, memory for cacheinfo is never allocated. x86 does not u=
se the
> > > > early build functionality. Consequently, during the cacheinfo CPU h=
otplug
> > > > callback, last_level_cache_is_valid() attempts to dereference a NUL=
L
> > > > pointer:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 BUG: kernel NULL pointer dereference, addr=
ess: 0000000000000100
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 #PF: supervisor read access in kernel mode
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 #PF: error_code(0x0000) - not present page
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 PGD 0 P4D 0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 Oops: 0000 [#1] PREEPMT SMP NOPTI
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.=
4.0-rc2 #1
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 RIP: 0010: last_level_cache_is_valid+0x95/=
0xe0a
> > > >=20
> > > > Allocate memory for cacheinfo during the cacheinfo CPU hotplug call=
back if
> > > > not done earlier.
> > > >=20
> > > > Cc: Andreas Herrmann <aherrmann@suse.com>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Chen Yu <yu.c.chen@intel.com>
> > > > Cc: Len Brown <len.brown@intel.com>
> > > > Cc: Radu Rendec <rrendec@redhat.com>
> > > > Cc: Pierre Gondois <Pierre.Gondois@arm.com>
> > > > Cc: Pu Wen <puwen@hygon.cn>
> > > > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > Cc: stable@vger.kernel.org
> > > > Acked-by: Len Brown <len.brown@intel.com>
> > > > Fixes: 6539cffa9495 ("cacheinfo: Add arch specific early level init=
ializer")
> > >=20
> > > Not sure if we strictly need this(details below), but I am fine eithe=
r way.
> > >=20
> > > > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > > ---
> > > > The motivation for commit 5944ce092b97 was to prevent a BUG splat i=
n
> > > > PREEMPT_RT kernels during memory allocation. This splat is not obse=
rved on
> > > > x86 because the memory allocation for cacheinfo happens in
> > > > detect_cache_attributes() from the cacheinfo CPU hotplug callback.
> > > >=20
> > > > The dereference of a NULL pointer is not observed today because
> > > > cache_leaves(cpu) is zero until after init_cache_level() is called =
(also
> > > > during the CPU hotplug callback). Patch2 will set it earlier and th=
e NULL-
> > > > pointer dereference will be observed.
> > >=20
> > > Right, this is the information I have been asking in the previous ver=
sions.
> > > This clarifies a lot. The trigger is in the patch 2/3 which is why it=
 didn't
> > > make complete sense to me without it when you posted this patch indep=
endently.
> > > Thanks for posting it together and sorry for the delay(both reviewing=
 this
> > > and in understanding the issue).
> > >=20
> > > Given the trigger for NULL pointer dereference is in 2/3, I am not su=
re
> > > if it is really worth applying this to all the stable kernels with th=
e
> > > commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU=
").
> > > That is the reason why I asked to drop fixes tag if you agree with me=
.
> > > It is simple fix, so I am OK if you prefer to see that in the stable =
kernels
> > > as well.
> >=20
> > Thanks for reviewing, Sudeep. Since my previous commit 6539cffa9495
> > ("cacheinfo: Add arch specific early level initializer") opens a door
> > for the NULL pointer dereference, I would sleep better at night if the
> > fix was included in the stable kernels :) But seriously, I am concerned
> > that with the fix applied in mainline and not in stable, something else
> > could be backported to the stable in the future, that could trigger the
> > NULL pointer dereference there. Ricardo's patch 2/3 is one way to
> > trigger it, but you never know what other patch lands in mainline in
> > the future that assumes it's safe to set the cache leaves earlier.
> >=20
>=20
> Fair enough. I agree with you, so please retain the fixes tag as is.
> Please work with x86 maintainers to get it merged along with other patche=
s.
> Let me know if you have other plans.

Thanks, Sudeep. Technically, these are Ricardo's patches, so I will let
him engage with the x86 maintainers and drive the integration work. But
the plan looks good to me, and I will stand by and offer any support
may be needed for the fix patch.

--
Regards,
Radu

