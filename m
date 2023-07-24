Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D475575FEAE
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 20:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjGXSBX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 14:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjGXSBW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 14:01:22 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18001E49;
        Mon, 24 Jul 2023 11:01:21 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b93fba1f62so66251981fa.1;
        Mon, 24 Jul 2023 11:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690221679; x=1690826479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THEbzcx3xoXEvYlAjRKvBcVanBYYoQVNYXaib1QFZgY=;
        b=S4ZsDsooAfiVuW6SIhRmX6Jzg5me/hpoTYcowI1a+YOD1gLtEYSNv+WQvJJR3kRMkh
         lk/L2fUU7hqas8A7mcOuWvAhME5SUxFL5qcAvXNff3ovTKJHoBrPjmy2Vrx7H2xoRmb2
         wu5NgQyU7RlmjUOa5R8m2FujkkIdUe8SHiRPZ5F1/aYTesU3yaGYZ3NLAdOHGuEX8c1G
         Pe2vK0kIdbVWFJONQvKMeFX34yxSBwow68wTs43iKeCVDGk1WZP85EJpspKQG+z00nlJ
         1hZbNpB914WkQbwtL7C8Vp8kWyMFEn1EqX2HGHKCckOzeN2/BGtQfvf29qOnoHyhvD9F
         YkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690221679; x=1690826479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THEbzcx3xoXEvYlAjRKvBcVanBYYoQVNYXaib1QFZgY=;
        b=XRxgq8xOXjCVHrdn9q5qlw/KT25O/vIKnVOGdyDr2rB3ohAPLrQ6Hhl32CEiKk2+7A
         tos7+1GAO+e3CulG+YEVkApOhCio0SmDagnas3+HVuYHQeZWS9zAGZoEUzOLvQtgAw77
         nXbZJodTdV7I6R7j9eGn2389gTTl+buBmYQI+rVZ4vSqE/VgiFqUxibP9ODeENlSP9FV
         4Wo6VUM8FrvYeLpyJozDD0+7RgHy4u27IxsacqqJBtDU/zmqwlRDSKMjOCNiB8Lqi0qa
         3+8A9F1zJv2FGjiRjXfIrfUJmzqAyIZBg374lY6/s93Cl7jcPKay3ENF+/SXrVzJguzG
         5ozQ==
X-Gm-Message-State: ABy/qLboR+AMb2Tplj9on1/ytKCEOMC1QedVjod1GTkBRttLZRysPdh1
        DUPxdh7K8g88PIV8kBC9XGvXTRGokfk0TvQDfJDA2g/0
X-Google-Smtp-Source: APBJJlFBD2oS1VJ5Yf0e+3TmKZzycugLFJ3BZomqEu/aJqn6J6keVWXnXu1FQ36IMm4aLPXpSnfo8szHcxSRSVyvrVE=
X-Received: by 2002:a2e:9e88:0:b0:2b6:dc55:c3c7 with SMTP id
 f8-20020a2e9e88000000b002b6dc55c3c7mr6471944ljk.20.1690221679073; Mon, 24 Jul
 2023 11:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230720085704.190592-1-jolsa@kernel.org> <20230720085704.190592-3-jolsa@kernel.org>
 <0b963b18-4933-3b70-3dc6-6c7150bcf7bb@huaweicloud.com> <ZLp91s9kuOp7kEEA@krava>
In-Reply-To: <ZLp91s9kuOp7kEEA@krava>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 24 Jul 2023 11:01:07 -0700
Message-ID: <CAADnVQ+sBYgDCBUsj8ShBQNYe39ZU=G8+f2XQP8M0fYx7Y34gQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf 2/2] bpf: Disable preemption in bpf_event_output
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Hou Tao <houtao@huaweicloud.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        stable <stable@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jul 21, 2023 at 5:45=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Jul 21, 2023 at 08:16:14PM +0800, Hou Tao wrote:
> >
> >
> > On 7/20/2023 4:57 PM, Jiri Olsa wrote:
> > > We received report [1] of kernel crash, which is caused by
> > > using nesting protection without disabled preemption.
> > >
> > > The bpf_event_output can be called by programs executed by
> > > bpf_prog_run_array_cg function that disabled migration but
> > > keeps preemption enabled.
> > >
> > > This can cause task to be preempted by another one inside the
> > > nesting protection and lead eventually to two tasks using same
> > > perf_sample_data buffer and cause crashes like:
> > >
> > >   BUG: kernel NULL pointer dereference, address: 0000000000000001
> > >   #PF: supervisor instruction fetch in kernel mode
> > >   #PF: error_code(0x0010) - not-present page
> > >   ...
> > >   ? perf_output_sample+0x12a/0x9a0
> > >   ? finish_task_switch.isra.0+0x81/0x280
> > >   ? perf_event_output+0x66/0xa0
> > >   ? bpf_event_output+0x13a/0x190
> > >   ? bpf_event_output_data+0x22/0x40
> > >   ? bpf_prog_dfc84bbde731b257_cil_sock4_connect+0x40a/0xacb
> > >   ? xa_load+0x87/0xe0
> > >   ? __cgroup_bpf_run_filter_sock_addr+0xc1/0x1a0
> > >   ? release_sock+0x3e/0x90
> > >   ? sk_setsockopt+0x1a1/0x12f0
> > >   ? udp_pre_connect+0x36/0x50
> > >   ? inet_dgram_connect+0x93/0xa0
> > >   ? __sys_connect+0xb4/0xe0
> > >   ? udp_setsockopt+0x27/0x40
> > >   ? __pfx_udp_push_pending_frames+0x10/0x10
> > >   ? __sys_setsockopt+0xdf/0x1a0
> > >   ? __x64_sys_connect+0xf/0x20
> > >   ? do_syscall_64+0x3a/0x90
> > >   ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > >
> > > Fixing this by disabling preemption in bpf_event_output.
> > >
> > > [1] https://github.com/cilium/cilium/issues/26756
> > > Cc: stable@vger.kernel.org
> > > Reported-by:  Oleg "livelace" Popov <o.popov@livelace.ru>
> > > Fixes: 2a916f2f546c bpf: Use migrate_disable/enable in array macros a=
nd cgroup/lirc code.
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >
> > Acked-by: Hou Tao <houtao1@huawei.com>
> >
> > With one nit above. The format of the Fixes tags should be 2a916f2f546c
> > ("bpf: Use migrate_disable/enable in array macros and cgroup/lirc code.=
")
> >
>
> right, sorry about that.. should I resend?

Please resend with fixes and acks.
