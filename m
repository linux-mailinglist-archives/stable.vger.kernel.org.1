Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998DE722D98
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 19:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjFERYc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 13:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjFERYb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 13:24:31 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C210DC
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 10:24:30 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6529316508cso1433050b3a.1
        for <stable@vger.kernel.org>; Mon, 05 Jun 2023 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685985870; x=1688577870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sunAtMQUn+DzaO8ajStod2kF2aP4fCt1Iiw+NA8rZMg=;
        b=giWnziu4j8mWNLVCq1TBgpv6oWL8Tru9TM2g82qvMJczEg7VhfzrzsslxpaizPh2V9
         Ul807anE8MhOMsPAeBpVtZvwsQcpUtz+azBd7BCJxgy4jcU8Xzdhyu8EyT98MMHJoGAG
         hck+UJlM6k9VOcJeKQ8/6xpk0jjqsHTG0jhY2P6hBDkzjkhTVUPk6X0Umz1Gcg4VdbAG
         jAQI4DEANm1aCNXw4x8mlqZKlJm2NFSQhij7S4mRMayYIJ4889jJAdtvYac6JiCc3fyD
         TrmkYxQE9J0rEOs286v3PjUW583uA4cWo0W/ox1U2MMPJ41gce4cK8LbzuAHve+qm3oz
         Y9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685985870; x=1688577870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sunAtMQUn+DzaO8ajStod2kF2aP4fCt1Iiw+NA8rZMg=;
        b=PDMUwyPJUobC86k4ysX+bi/ocFNOrPTrx+shRzmcnSenVlvOIM08jw2d2IboJz8fn0
         7JEno+5YupRzfK3ftFzY5wE0dxqvFHPvclwADeUAZXvvyALbE5hIo9t97ISSVCZ/jfr5
         6ulLBV8C1AM/d0DnjW8fUr+l3D73+HzSBWoCFs5eGZ7exvGPafVbyVr28cDeJKC7aogQ
         yLj/pLbxrsHabLt/G9vAl938DMGkQMps1VxPiZp2hh0exC+ibqnYPTSnQe7Zpc1A5wqm
         4C8P6H0WtCm4SL2SyFm9kMO4Zhfn6NCzaEWdHlMHDMMwZQzGK1bVkFxGwywNHWPyRfEl
         I73A==
X-Gm-Message-State: AC+VfDybwAQNWCP0dV5f88eVKEvkysQuIQhkCAqsO4ED3BwkEUjtORPh
        Py148YsUubz8M9T+TRsvtPdBodE=
X-Google-Smtp-Source: ACHHUZ7V30fwof0Bt+m6vB/RX3ft5BBiJb3MzqiYYZaqwtvuYx0PIgSZTNRHgi7IBAqjj1aAL2RypDQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:3a03:b0:653:a1bf:502f with SMTP id
 fj3-20020a056a003a0300b00653a1bf502fmr175831pfb.1.1685985870019; Mon, 05 Jun
 2023 10:24:30 -0700 (PDT)
Date:   Mon, 5 Jun 2023 10:24:28 -0700
In-Reply-To: <20230604140103.3542071-1-jolsa@kernel.org>
Mime-Version: 1.0
References: <20230604140103.3542071-1-jolsa@kernel.org>
Message-ID: <ZH4aTA0qV0YkoXaA@google.com>
Subject: Re: [PATCH bpf] bpf: Add extra path pointer check to d_path helper
From:   Stanislav Fomichev <sdf@google.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org,
        Anastasios Papagiannis <tasos.papagiannnis@gmail.com>,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 06/04, Jiri Olsa wrote:
> Anastasios reported crash on stable 5.15 kernel with following
> bpf attached to lsm hook:
> 
>   SEC("lsm.s/bprm_creds_for_exec")
>   int BPF_PROG(bprm_creds_for_exec, struct linux_binprm *bprm)
>   {
>           struct path *path = &bprm->executable->f_path;
>           char p[128] = { 0 };
> 
>           bpf_d_path(path, p, 128);
>           return 0;
>   }
> 
> but bprm->executable can be NULL, so bpf_d_path call will crash:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000018
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC NOPTI
>   ...
>   RIP: 0010:d_path+0x22/0x280
>   ...
>   Call Trace:
>    <TASK>
>    bpf_d_path+0x21/0x60
>    bpf_prog_db9cf176e84498d9_bprm_creds_for_exec+0x94/0x99
>    bpf_trampoline_6442506293_0+0x55/0x1000
>    bpf_lsm_bprm_creds_for_exec+0x5/0x10
>    security_bprm_creds_for_exec+0x29/0x40
>    bprm_execve+0x1c1/0x900
>    do_execveat_common.isra.0+0x1af/0x260
>    __x64_sys_execve+0x32/0x40
> 
> It's problem for all stable trees with bpf_d_path helper, which was
> added in 5.9.
> 
> This issue is fixed in current bpf code, where we identify and mark
> trusted pointers, so the above code would fail to load.
> 
> For the sake of the stable trees and to workaround potentially broken
> verifier in the future, adding the code that reads the path object from
> the passed pointer and verifies it's valid in kernel space.
> 
> Cc: stable@vger.kernel.org # v5.9+
> Fixes: 6e22ab9da793 ("bpf: Add d_path helper")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Reported-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Stanislav Fomichev <sdf@google.com>

One question though: does it really have to go via bpf tree? Can it
be a stable-only fix? Otherwise it's not really clear why we
need to double-check anything if the pointer is trusted..

> ---
>  kernel/trace/bpf_trace.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 9a050e36dc6c..aecd98ee73dc 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -900,12 +900,22 @@ static const struct bpf_func_proto bpf_send_signal_thread_proto = {
>  
>  BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
>  {
> +	struct path copy;
>  	long len;
>  	char *p;
>  
>  	if (!sz)
>  		return 0;
>  
> +	/*
> +	 * The path pointer is verified as trusted and safe to use,
> +	 * but let's double check it's valid anyway to workaround
> +	 * potentially broken verifier.
> +	 */
> +	len = copy_from_kernel_nofault(&copy, path, sizeof(*path));
> +	if (len < 0)
> +		return len;
> +
>  	p = d_path(path, buf, sz);
>  	if (IS_ERR(p)) {
>  		len = PTR_ERR(p);
> -- 
> 2.40.1
> 
