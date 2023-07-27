Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EC376450D
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 06:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjG0Es0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 00:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjG0EsX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 00:48:23 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E17F271F
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 21:48:22 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4036bd4fff1so179671cf.0
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 21:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690433301; x=1691038101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9HSIrtFkclUh08WUnO+B+BwRK/qFesZ9SqYpqIojYc=;
        b=lYZHABINhBqe1G2mHVSCBYrzOcWQYVQfYcYaDJNHjGJdTu9KeiY3yRKyAWhtUaN2ht
         Sab6Gf2VrE1ndiMbct5kct6iC1F1m87Z3yc9X3G6vaddsXvEo4LqVmm+ZmwpG8Ep91M1
         6exzt/amwArbgZJzW2lI4QLQEoIdUOM+25iiWAGXKv6bv491IrKi/KkQQG93y4Y6G/In
         kE/TfE2WaCxyMlu2SuAjndZTL+6/byI15lVfJ/ui3uLEUtNWDcqGHKNlv3QrOI9orn8P
         krI8ZQw8UCWfhfEewkfFcwKjznHIKiwzYSOuwwgODxBFQeW60kKQab2HR0q/uf4tZoOt
         BWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690433301; x=1691038101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9HSIrtFkclUh08WUnO+B+BwRK/qFesZ9SqYpqIojYc=;
        b=e5rk4O4gu8i6clUlAuImHicV9FXDNpSUHEBxlMUTcQh3J/wtmRBGhykkihNizvcpla
         tQGx9P6b3xARMCX2sUAClylvbQKrhZzA259YTBM0/6VNJwMNzXVNqUel4AMaRcu3ET7e
         P07stVlPzYXJIYz+yRMjTmf+k3uzVNtarwFk72KFYRwH9MEnDA7IvCRQvTorEcytGhZn
         /ISy824/zR8Ez1HXAh3MQG9z2r03t3NWBqkO2nwKDOpdu1SVP/9JsslvFmqHad+YitDU
         CQnKXODey/Ok+CXhGFSbAsbTg7o64qJvnO6fq11N3px9gbt2rmuhQCdZabznpRQ4vWiW
         6Vag==
X-Gm-Message-State: ABy/qLbmQCKBtIGIb+qkUJ6iZo6MNUqUUxONSM56IB51iqAgA9ZsF7PX
        /bnHWm97aetUbL+67pBrnMxyBjeGPxJzfr4hnKBMNw==
X-Google-Smtp-Source: APBJJlFZSj/4XZDQSkXKf9GLMLlJ1OhH7auW0F8ddBeujJvWq3cHpEA81n7a9v2R6peR2nyx3IoSQxBsrOHoKGEbQZc=
X-Received: by 2002:a05:622a:349:b0:3f6:97b4:1a4d with SMTP id
 r9-20020a05622a034900b003f697b41a4dmr86468qtw.23.1690433301294; Wed, 26 Jul
 2023 21:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230726133642.750342-1-namhyung@kernel.org> <CAP-5=fWM9Fhq5WvsBf2n=hGwwwRDt3-mUQ=_qzu8qYGtD1OeWQ@mail.gmail.com>
 <CAM9d7citVc4ad65MLBWxvE-_AbwxO1DQWHf5w+ofSgWnWSx=Fw@mail.gmail.com>
 <CAP-5=fVbwf9=ZFszgFpb_6Qb003WpZC3_vtO7fB1pL_vH-OhQw@mail.gmail.com> <CAM9d7chcrd8mN55yb+oCBi3=AF4-a=oCr66+cv7eaquzx0Kvpw@mail.gmail.com>
In-Reply-To: <CAM9d7chcrd8mN55yb+oCBi3=AF4-a=oCr66+cv7eaquzx0Kvpw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 26 Jul 2023 21:48:09 -0700
Message-ID: <CAP-5=fUPPRVSx9x4riCkkwEAza1N_r5qCxwqmdj0d7CEaKmCdw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf build: Update build rule for generated files
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Anup Sharma <anupnewsmail@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jul 26, 2023 at 6:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Jul 26, 2023 at 5:36=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Wed, Jul 26, 2023 at 3:57=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Wed, Jul 26, 2023 at 8:48=E2=80=AFAM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > On Wed, Jul 26, 2023 at 6:36=E2=80=AFAM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > The bison and flex generate C files from the source (.y and .l)
> > > > > files.  When O=3D option is used, they are saved in a separate di=
rectory
> > > > > but the default build rule assumes the .C files are in the source
> > > > > directory.  So it might read invalid file if there are generated =
files
> > > > > from an old version.  The same is true for the pmu-events files.
> > > > >
> > > > > For example, the following command would cause a build failure:
> > > > >
> > > > >   $ git checkout v6.3
> > > > >   $ make -C tools/perf  # build in the same directory
> > > > >
> > > > >   $ git checkout v6.5-rc2
> > > > >   $ mkdir build  # create a build directory
> > > > >   $ make -C tools/perf O=3Dbuild  # build in a different director=
y but it
> > > > >                                 # refers files in the source dire=
ctory
> > > > >
> > > > > Let's update the build rule to specify those cases explicitly to =
depend
> > > > > on the files in the output directory.
> > > > >
> > > > > Note that it's not a complete fix and it needs the next patch for=
 the
> > > > > include path too.
> > > > >
> > > > > Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file"=
)
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > ---
> > > > >  tools/build/Makefile.build  | 8 ++++++++
> > > > >  tools/perf/pmu-events/Build | 4 ++++
> > > > >  2 files changed, 12 insertions(+)
> > > > >
> > > > > diff --git a/tools/build/Makefile.build b/tools/build/Makefile.bu=
ild
> > > > > index 89430338a3d9..f9396696fcbf 100644
> > > > > --- a/tools/build/Makefile.build
> > > > > +++ b/tools/build/Makefile.build
> > > > > @@ -117,6 +117,14 @@ $(OUTPUT)%.s: %.c FORCE
> > > > >         $(call rule_mkdir)
> > > > >         $(call if_changed_dep,cc_s_c)
> > > > >
> > > > > +$(OUTPUT)%-bison.o: $(OUTPUT)%-bison.c FORCE
> > > > > +       $(call rule_mkdir)
> > > > > +       $(call if_changed_dep,$(host)cc_o_c)
> > > > > +
> > > > > +$(OUTPUT)%-flex.o: $(OUTPUT)%-flex.c FORCE
> > > > > +       $(call rule_mkdir)
> > > > > +       $(call if_changed_dep,$(host)cc_o_c)
> > > > > +
> > > >
> > > > Hi Namhyung,
> > > >
> > > > as we have:
> > > > ```
> > > > $(OUTPUT)%.o: %.c FORCE
> > > >        $(call rule_mkdir)
> > > >        $(call if_changed_dep,$(host)cc_o_c)
> > > > ```
> > > > I'm not sure what the 2 additional rules achieve.
> > >
> > > The above rule assumes the .c files are in the source directory
> > > (without $(OUTPUT) prefix).  It caused a trouble when the
> > > flex and bison files are generated in the output directory and
> > > you have an old version of them in the source directory.
> > >
> > >
> > > >
> > > > >  # Gather build data:
> > > > >  #   obj-y        - list of build objects
> > > > >  #   subdir-y     - list of directories to nest
> > > > > diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/=
Build
> > > > > index 150765f2baee..f38a27765604 100644
> > > > > --- a/tools/perf/pmu-events/Build
> > > > > +++ b/tools/perf/pmu-events/Build
> > > > > @@ -35,3 +35,7 @@ $(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS=
_PY) $(METRIC_PY) $(METRIC_TEST_L
> > > > >         $(call rule_mkdir)
> > > > >         $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS=
_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
> > > > >  endif
> > > > > +
> > > > > +$(OUTPUT)pmu-events/pmu-events.o: $(PMU_EVENTS_C)
> > > > > +       $(call rule_mkdir)
> > > > > +       $(call if_changed_dep,$(host)cc_o_c)
> > > >
> > > > If we add this, do the Makefile.build changes still need to happen?
> > >
> > > The Makefile.build changes are specific to flex and bison files.
> > > So yes, we need this for pmu-events.c to work properly with O=3D
> > > option.
> >
> > Got it, you are right I was confusing the flex/bison with the jevents
> > case. Can we get away with a single rule then:
> > ```
> >  $(OUTPUT)%.o:  $(OUTPUT)%.c FORCE
> >         $(call rule_mkdir)
> >         $(call if_changed_dep,$(host)cc_o_c)
> > ```
>
> Probably, but I wonder if it affects the normal .c files expecting
> them in the OUTPUT directory.

Hmm.. I think the longer matches may be necessary to trigger the "more
specific" ordering:
https://www.gnu.org/software/make/manual/html_node/Pattern-Match.html

I'm not keen on these extra rules that mirror existing rules, it is a
bit cryptic what is going on. I wonder if it would be cleaner just to
fail the build if the bogus pmu-events.c exists. For example:
```
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -12,6 +12,14 @@ EMPTY_PMU_EVENTS_C =3D pmu-events/empty-pmu-events.c
PMU_EVENTS_C   =3D  $(OUTPUT)pmu-events/pmu-events.c
METRIC_TEST_LOG        =3D  $(OUTPUT)pmu-events/metric_test.log

+ifneq ($(OUTPUT),)
+ifneq ($(wildcard pmu-events/pmu-events.c),)
+dummy :=3D $(error OUTPUT set but tools/perf/pmu-events/pmu-events.c exist=
s. \
+           This can mean the generated version of pmu-events.c is not
compiled. \
+           Try 'cd tools/perf; make clean; cd -' and then rebuilding.)
+endif
+endif
+
ifeq ($(JEVENTS_ARCH),)
JEVENTS_ARCH=3D$(SRCARCH)
endif
```

Thanks,
Ian

> Thanks,
> Namhyung
