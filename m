Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760757D871D
	for <lists+stable@lfdr.de>; Thu, 26 Oct 2023 19:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjJZRB4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 26 Oct 2023 13:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJZRBy (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Oct 2023 13:01:54 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED6F187
        for <stable@vger.kernel.org>; Thu, 26 Oct 2023 10:01:52 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41c157bbd30so7864231cf.0
        for <stable@vger.kernel.org>; Thu, 26 Oct 2023 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1698339711; x=1698944511; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PX9hCbQzOCAAp8/TZvbTUNhrQAcNp/mMdq/OSUzd0BA=;
        b=cJCZXKqJxLn+UI/UI5uJ4ddt42okyd3lFFifUse7PihgTDG4TBV0QQ7Bw7mXOgvtDF
         oNl3mCvbXyfaEa2IRM9H5CfI20Hr9/ApxfWmCKEulCVYhJ7wAMmRhLS/2WR9ax9rVsHn
         rc7kmHB511E2Aer5yWXszq/CiSz0oaGH+bAW8LJZ5jjrfHPZFDHgeVO8kTIUCvjTZAd7
         B7RjcBKsdrkdv4/tEFbmUwgm8qSebrYFJufPX9CJ13yAMeN0+7phoYcO1GytMKRKQ8nH
         ckTRmpeHTYosi83V9/0ZoGa17HXU8XsQCq3ZUOkFlgWKU0nxlw1owvBk/AybNSAWqcGg
         R/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698339711; x=1698944511;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PX9hCbQzOCAAp8/TZvbTUNhrQAcNp/mMdq/OSUzd0BA=;
        b=AShxaBgs0MXr2wndOh3k2FHaZDr4oDwsyJbJYC/42cYfFveTkOyUf9zWA5BHhwaxr1
         10w4v7DwHTt2zqvy1bELfauGohJkxvGtPSSKBj0pEY2a/KgMKh1Ktz7yfMEFdCR9OVGf
         dPLbbGCXL5WoSgeU3AxxLhABVQc0PDlaqd2GhYIRTLW3rgKXyzilNBH7HzpbwQMSZ0Ph
         94WSkYBQ/7+DFR3FhOuDSBu2zuj7rFi4H+a86ucInAwSt5zPjW9HFKRGZSZTTKGaHVyP
         icNN+Ph5/yDvZFG+oL6VWnfLT6JAgsmz2p7mcyFMieED4bnz7K/QU8kTq20cXZI42LR6
         QdKA==
X-Gm-Message-State: AOJu0YzHgQPvkiPzdplghG4vY+uQ1E7d1QJGEKenSC3+RV5qvwyocn6v
        Fw+/GqfIxpgVqDnDj5l40dohQA==
X-Google-Smtp-Source: AGHT+IE3aqTrtSDrRzzNoYcyHcNXkpYQT8nqtlG4jrupu4w5pJjuRtfWWyzx75CxC0cMn6YciKGhIw==
X-Received: by 2002:a05:622a:104b:b0:41e:196c:3a37 with SMTP id f11-20020a05622a104b00b0041e196c3a37mr141415qte.35.1698339711510;
        Thu, 26 Oct 2023 10:01:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:a294])
        by smtp.gmail.com with ESMTPSA id kd8-20020a05622a268800b00419ab6ffedasm5101533qtb.29.2023.10.26.10.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:01:51 -0700 (PDT)
Date:   Thu, 26 Oct 2023 13:01:50 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Luca Boccassi <bluca@debian.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] sched: psi: fix unprivileged polling against cgroups
Message-ID: <20231026170150.GA2161924@cmpxchg.org>
References: <20231026164114.2488682-1-hannes@cmpxchg.org>
 <CAMw=ZnQ56cm4Txgy5EhGYvR+Jt4s-KVgoA9_65HKWVMOXp7a9A@mail.gmail.com>
 <CAJuCfpFJgzRE5jcg0dKi9J+1e1cJxRPeSW56A4G-fV44zivT_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFJgzRE5jcg0dKi9J+1e1cJxRPeSW56A4G-fV44zivT_Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 26, 2023 at 09:55:23AM -0700, Suren Baghdasaryan wrote:
> On Thu, Oct 26, 2023 at 9:49 AM Luca Boccassi <bluca@debian.org> wrote:
> >
> > On Thu, 26 Oct 2023 at 17:41, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > 519fabc7aaba ("psi: remove 500ms min window size limitation for
> > > triggers") breaks unprivileged psi polling on cgroups.
> > >
> > > Historically, we had a privilege check for polling in the open() of a
> > > pressure file in /proc, but were erroneously missing it for the open()
> > > of cgroup pressure files.
> > >
> > > When unprivileged polling was introduced in d82caa273565 ("sched/psi:
> > > Allow unprivileged polling of N*2s period"), it needed to filter
> > > privileges depending on the exact polling parameters, and as such
> > > moved the CAP_SYS_RESOURCE check from the proc open() callback to
> > > psi_trigger_create(). Both the proc files as well as cgroup files go
> > > through this during write(). This implicitly added the missing check
> > > for privileges required for HT polling for cgroups.
> > >
> > > When 519fabc7aaba ("psi: remove 500ms min window size limitation for
> > > triggers") followed right after to remove further restrictions on the
> > > RT polling window, it incorrectly assumed the cgroup privilege check
> > > was still missing and added it to the cgroup open(), mirroring what we
> > > used to do for proc files in the past.
> > >
> > > As a result, unprivileged poll requests that would be supported now
> > > get rejected when opening the cgroup pressure file for writing.
> 
> Ah, I see the problem. In our discussion
> https://lore.kernel.org/all/ZADj4YX4uftK%2FFrh@cmpxchg.org/ we decided
> to have the check in open() to fail early but we never considered
> unprivileged processes which only poll and never create any triggers.
> Makes sense.

Yeah, the two patches just ended up clashing. We made that open()
decision before unprivileged polling was merged, then ended up merging
it before the window patch.

Thanks!
