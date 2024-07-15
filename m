Return-Path: <stable+bounces-59346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8F193139D
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 14:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399F1281216
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 12:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E97C18A947;
	Mon, 15 Jul 2024 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qFSFLGW0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363118A944
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721045376; cv=none; b=VDwWGFORv5UE6IW1CWxkZDbgmpxrc2f4+uS1M4uYW2vNJpx+UQovOF9PNPliscSPR4hT+MCanRYhfegAqG1UfxqI+X2KiQVNyf0VWmcvSS4kgvdOwDvhwEVZueiPEkHIEyBszv/OlEZbIcIgDKhf2rrtTB2NjRzSuneZtkca8G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721045376; c=relaxed/simple;
	bh=kwuB5bmg09SkmZ1lc33oMannjmwyd6VA3YcPMKqTp+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLfyv6L98mrMpofu9LctjX+oqmpL5BMzZFHDub2/irmumCFtG7fgW6yjK4Hiha+flFPIyg283SatAFAO37pil7qAeQqBCUazft1nzXGRwTHmIXuFhlXs7cb7N0fPVrTeM/IdawoqhX7xHpug15XwM5n+KheZTWtDw6NPvjtSoYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qFSFLGW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B3EC32782;
	Mon, 15 Jul 2024 12:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721045376;
	bh=kwuB5bmg09SkmZ1lc33oMannjmwyd6VA3YcPMKqTp+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qFSFLGW0l3y5LCUY4kgAJqkTB9abJ/lLB4g0Ll59DodYcbOGG96Oovm/iJ6R3veoe
	 laXpMTSoRRoxhUZCARP8vWEi9/sz6c46YZcT9rVUE3z0aZkV3nzEELUPz0bt9rEpgJ
	 lVCgOnH2ogxBIAjCjP7Rg71a/1RgyhLD0d4VvRaM=
Date: Mon, 15 Jul 2024 14:09:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, stable@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: Re: [PATCH stable 5.10] bpf: Allow reads from uninit stack
Message-ID: <2024071507-conical-issuing-2e8d@gregkh>
References: <20240711184323.2355017-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711184323.2355017-1-maxtram95@gmail.com>

On Thu, Jul 11, 2024 at 09:43:21PM +0300, Maxim Mikityanskiy wrote:
> From: Eduard Zingerman <eddyz87@gmail.com>
> 
> [ Upstream commit 6715df8d5d24655b9fd368e904028112b54c7de1 ]
> 
> This commits updates the following functions to allow reads from
> uninitialized stack locations when env->allow_uninit_stack option is
> enabled:
> - check_stack_read_fixed_off()
> - check_stack_range_initialized(), called from:
>   - check_stack_read_var_off()
>   - check_helper_mem_access()
> 
> Such change allows to relax logic in stacksafe() to treat STACK_MISC
> and STACK_INVALID in a same way and make the following stack slot
> configurations equivalent:
> 
>   |  Cached state    |  Current state   |
>   |   stack slot     |   stack slot     |
>   |------------------+------------------|
>   | STACK_INVALID or | STACK_INVALID or |
>   | STACK_MISC       | STACK_SPILL   or |
>   |                  | STACK_MISC    or |
>   |                  | STACK_ZERO    or |
>   |                  | STACK_DYNPTR     |
> 
> This leads to significant verification speed gains (see below).
> 
> The idea was suggested by Andrii Nakryiko [1] and initial patch was
> created by Alexei Starovoitov [2].
> 
> Currently the env->allow_uninit_stack is allowed for programs loaded
> by users with CAP_PERFMON or CAP_SYS_ADMIN capabilities.
> 
> A number of test cases from verifier/*.c were expecting uninitialized
> stack access to be an error. These test cases were updated to execute
> in unprivileged mode (thus preserving the tests).
> 
> The test progs/test_global_func10.c expected "invalid indirect read
> from stack" error message because of the access to uninitialized
> memory region. This error is no longer possible in privileged mode.
> The test is updated to provoke an error "invalid indirect access to
> stack" because of access to invalid stack address (such error is not
> verified by progs/test_global_func*.c series of tests).
> 
> The following tests had to be removed because these can't be made
> unprivileged:
> - verifier/sock.c:
>   - "sk_storage_get(map, skb->sk, &stack_value, 1): partially init
>   stack_value"
>   BPF_PROG_TYPE_SCHED_CLS programs are not executed in unprivileged mode.
> - verifier/var_off.c:
>   - "indirect variable-offset stack access, max_off+size > max_initialized"
>   - "indirect variable-offset stack access, uninitialized"
>   These tests verify that access to uninitialized stack values is
>   detected when stack offset is not a constant. However, variable
>   stack access is prohibited in unprivileged mode, thus these tests
>   are no longer valid.
> 
>  * * *
> 
> Here is veristat log comparing this patch with current master on a
> set of selftest binaries listed in tools/testing/selftests/bpf/veristat.cfg
> and cilium BPF binaries (see [3]):
> 
> $ ./veristat -e file,prog,states -C -f 'states_pct<-30' master.log current.log
> File                        Program                     States (A)  States (B)  States    (DIFF)
> --------------------------  --------------------------  ----------  ----------  ----------------
> bpf_host.o                  tail_handle_ipv6_from_host         349         244    -105 (-30.09%)
> bpf_host.o                  tail_handle_nat_fwd_ipv4          1320         895    -425 (-32.20%)
> bpf_lxc.o                   tail_handle_nat_fwd_ipv4          1320         895    -425 (-32.20%)
> bpf_sock.o                  cil_sock4_connect                   70          48     -22 (-31.43%)
> bpf_sock.o                  cil_sock4_sendmsg                   68          46     -22 (-32.35%)
> bpf_xdp.o                   tail_handle_nat_fwd_ipv4          1554         803    -751 (-48.33%)
> bpf_xdp.o                   tail_lb_ipv4                      6457        2473   -3984 (-61.70%)
> bpf_xdp.o                   tail_lb_ipv6                      7249        3908   -3341 (-46.09%)
> pyperf600_bpf_loop.bpf.o    on_event                           287         145    -142 (-49.48%)
> strobemeta.bpf.o            on_event                         15915        4772  -11143 (-70.02%)
> strobemeta_nounroll2.bpf.o  on_event                         17087        3820  -13267 (-77.64%)
> xdp_synproxy_kern.bpf.o     syncookie_tc                     21271        6635  -14636 (-68.81%)
> xdp_synproxy_kern.bpf.o     syncookie_xdp                    23122        6024  -17098 (-73.95%)
> --------------------------  --------------------------  ----------  ----------  ----------------
> 
> Note: I limited selection by states_pct<-30%.
> 
> Inspection of differences in pyperf600_bpf_loop behavior shows that
> the following patch for the test removes almost all differences:
> 
>     - a/tools/testing/selftests/bpf/progs/pyperf.h
>     + b/tools/testing/selftests/bpf/progs/pyperf.h
>     @ -266,8 +266,8 @ int __on_event(struct bpf_raw_tracepoint_args *ctx)
>             }
> 
>             if (event->pthread_match || !pidData->use_tls) {
>     -               void* frame_ptr;
>     -               FrameData frame;
>     +               void* frame_ptr = 0;
>     +               FrameData frame = {};
>                     Symbol sym = {};
>                     int cur_cpu = bpf_get_smp_processor_id();
> 
> W/o this patch the difference comes from the following pattern
> (for different variables):
> 
>     static bool get_frame_data(... FrameData *frame ...)
>     {
>         ...
>         bpf_probe_read_user(&frame->f_code, ...);
>         if (!frame->f_code)
>             return false;
>         ...
>         bpf_probe_read_user(&frame->co_name, ...);
>         if (frame->co_name)
>             ...;
>     }
> 
>     int __on_event(struct bpf_raw_tracepoint_args *ctx)
>     {
>         FrameData frame;
>         ...
>         get_frame_data(... &frame ...) // indirectly via a bpf_loop & callback
>         ...
>     }
> 
>     SEC("raw_tracepoint/kfree_skb")
>     int on_event(struct bpf_raw_tracepoint_args* ctx)
>     {
>         ...
>         ret |= __on_event(ctx);
>         ret |= __on_event(ctx);
>         ...
>     }
> 
> With regards to value `frame->co_name` the following is important:
> - Because of the conditional `if (!frame->f_code)` each call to
>   __on_event() produces two states, one with `frame->co_name` marked
>   as STACK_MISC, another with it as is (and marked STACK_INVALID on a
>   first call).
> - The call to bpf_probe_read_user() does not mark stack slots
>   corresponding to `&frame->co_name` as REG_LIVE_WRITTEN but it marks
>   these slots as BPF_MISC, this happens because of the following loop
>   in the check_helper_call():
> 
> 	for (i = 0; i < meta.access_size; i++) {
> 		err = check_mem_access(env, insn_idx, meta.regno, i, BPF_B,
> 				       BPF_WRITE, -1, false);
> 		if (err)
> 			return err;
> 	}
> 
>   Note the size of the write, it is a one byte write for each byte
>   touched by a helper. The BPF_B write does not lead to write marks
>   for the target stack slot.
> - Which means that w/o this patch when second __on_event() call is
>   verified `if (frame->co_name)` will propagate read marks first to a
>   stack slot with STACK_MISC marks and second to a stack slot with
>   STACK_INVALID marks and these states would be considered different.
> 
> [1] https://lore.kernel.org/bpf/CAEf4BzY3e+ZuC6HUa8dCiUovQRg2SzEk7M-dSkqNZyn=xEmnPA@mail.gmail.com/
> [2] https://lore.kernel.org/bpf/CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3rNV+kBLQCu7rA@mail.gmail.com/
> [3] git@github.com:anakryiko/cilium.git
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Co-developed-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Link: https://lore.kernel.org/r/20230219200427.606541-2-eddyz87@gmail.com
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> ---
> Backporting to address the complexity regression introduced by commit
> 71f656a50176 ("bpf: Fix to preserve reg parent/live fields when copying
> range info"), that affects Cilium built with LLVM 18.

All now queued up, thanks.

greg k-h

