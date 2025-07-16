Return-Path: <stable+bounces-163138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC83B07611
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 14:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6859D58423A
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 12:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5985E1411EB;
	Wed, 16 Jul 2025 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="pEfunAq+"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D747B15E90
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669994; cv=none; b=Lyn+79KRdBTqIOmNWWveNkjCqtp04u20eRubjCKl4tXIbB1BIOLCyas7q1KQ+Nxr/gcx9Ot+9ZtOmj+4ImKGzvM767V68oVcMe34bTsVVxbf3eWuqLynM4MYcFK6YB3JAvqwmtybLXoImADrTk6djSgDjAFv5wN3TRAdafKQczY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669994; c=relaxed/simple;
	bh=kldBMSjY+iw0RuNOsix21ynpw+7IPPHEZmi7n3jVZnk=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=YZ5RC3wTfjEbiVa3D+cnVjO6cHbUXdeycS00ryaxPmCYM5beswA56/H7wGAc3uQwZOVpBzqTkNffQ09pWuB18HY/lqDjDLAX6PG6XnQ+C5oeVUYdsRLK7cKk4gWECSsQVRzV87l91dFnK69Q1Y66Ibhs1F0HO4JrNIpPYKR7Wn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=pEfunAq+; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2ffa81b41d7so543176fac.0
        for <stable@vger.kernel.org>; Wed, 16 Jul 2025 05:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1752669991; x=1753274791; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kldBMSjY+iw0RuNOsix21ynpw+7IPPHEZmi7n3jVZnk=;
        b=pEfunAq+Qab2PAOhB0fuh7IgU1FneE81n4P824zNBam8I8MT88vlJXiALeOmbHX2+E
         mIhBE76a5tl9PNJ+VDeGsMWIvo33blLaP79PXO/cl1Fo5o/S6Q8ZF2d+skRAze3OUHen
         8gos2n9iGxWMMQUrd2JfxYzqm7mrEo0u3zor8SJDJCBdKKeaGCnn0n1TmHCvnB2ZprTZ
         l2VXgJ+eoRdsnA+OYo9fwpUjmoB14T7T/TpSqGgAbqMSPI9ybqZNt2ZOkcx97gPJoM0Z
         5ajXdqNCUy+wH7cv/wG2sC77eXFL6wypX11F4AZIjBkORrJvrsmWmYI301mlLM9BRURo
         gDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669991; x=1753274791;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kldBMSjY+iw0RuNOsix21ynpw+7IPPHEZmi7n3jVZnk=;
        b=Z4iq5XSLa21fgs0+EV9ab/bYTN+K49BPBX6VFHzHaO9oFSJtengbWUOeits3HLUTET
         87i3j7t3jIkpHx5GuWLj7cvCc4hWuBtDUJCZR46I5TdsKK8nV8d9cHQTO0dTkEf5ayi0
         54TtrCNvszBynY28DL9MngIxbrNxqnERXa8QYI/IDlagnJixNDjOq0y23nBSgzA9om6k
         qyVIiJc6dXQZhp9X8xfk2HhNmL2Uc/rxQlKswyzw9DdZ1TsqzAom/+rgRUqN3oqMCnCv
         qp06KhDnFHcej2tUiWh5xw+9b94uhi/fN0Ig50m772zavcnOhjrSiCzVOUtAbVeSDBDl
         HR2g==
X-Gm-Message-State: AOJu0Yx4w8tlB+c+Wy6K8i4FF+euh6YaRn8rAbzmG7J0NbhH6/a4xlTN
	xuUd2DOl4YJ9uMV/jUJg5kplznjJtcM1OJAIEyhqKphY+vX+VTWOmy1/6WY5HCux1c0=
X-Gm-Gg: ASbGnctM+iEDlrBOhXnQ5pjyXlZ/7NOG1ak0wAP/lDy3P7qByLe+UaiVvgkULEsOoq0
	wZebRFsiwiNDEUqvjcDusaKtXIi8xIfLMVRDHinMloXBoW65OGv7BQ5Svazjlv/gD8UoJ6A2p2v
	Cr3YXdZFq5E/ByOBRyRjU9k1A8wtKkWgI1ieBIwhxERFUFW4VSabM2amTOshVl3OJq3DMUAf9Zq
	mUFwk0FfR3bYI0S2GlNw2k5Ma84AxHxOk4EFoKXRw/G5N2q5HRYUXFVNABnaE4/L+2DIpT3gmvQ
	gDKdEE0uq9raNQD/aqiOQDsuNalaz7PBY24KnrcQxtGQ5gKFGVyCMJ895KN2ENkDQAkfKeKZmTd
	Cb1/5dyrl652KKQ==
X-Google-Smtp-Source: AGHT+IEHO1TIrEXrUqSudmJ4sZk4OU63htbIwTLzWjj+150bWGfTNJdjP6x0kDsq7FqU7BNIYw1xWw==
X-Received: by 2002:a05:6870:44cc:b0:2ff:a7a8:faea with SMTP id 586e51a60fabf-2ffaeec2234mr2332344fac.0.1752669990630;
        Wed, 16 Jul 2025 05:46:30 -0700 (PDT)
Received: from poutine ([2804:1b3:a701:6ff9:81e1:aa01:e63a:53e3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e5fc7c942sm991336a34.31.2025.07.16.05.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:46:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [TEST REGRESSION] stable-rc/linux-6.12.y:
 kselftest.seccomp.seccomp_seccomp_benchmark_per-filter_last_2_diff_per-filter_filters_4
 on bcm2837-rpi-3-b-plus
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 16 Jul 2025 12:46:28 -0000
Message-ID: <175266998670.2811448.3696380835897675982@poutine>




Hello,

New test failure found on stable-rc/linux-6.12.y:

kselftest.seccomp.seccomp_seccomp_benchmark_per-filter_last_2_diff_per-filter_filters_4 running on bcm2837-rpi-3-b-plus

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
branch: linux-6.12.y
commit HEAD: d50d16f002928cde05a54e0049ddc203323ae7ac


test id: maestro:687779f42ce2c1874ed2365d
status: FAIL
timestamp: 2025-07-16 10:14:31.303039+00:00
log: https://files.kernelci.org/kselftest-seccomp-6876c79234612746bbcf9a7e/log.txt.gz

# Test details:
- test path: kselftest.seccomp.seccomp_seccomp_benchmark_per-filter_last_2_diff_per-filter_filters_4
- platform: bcm2837-rpi-3-b-plus
- compatibles: raspberrypi,3-model-b-plus | rbrcm | bcm2837;
- config: defconfig+arm64-chromebook+kselftest
- architecture: arm64
- compiler: gcc-12

Dashboard: https://d.kernelci.org/t/maestro:687779f42ce2c1874ed2365d


Log excerpt:
=====================================================
t_is_kill_inside pass
seccomp_seccomp_bpf_global_unknown_ret_is_kill_above_allow pass
seccomp_seccomp_bpf_global_KILL_all pass
seccomp_seccomp_bpf_global_KILL_one pass
seccomp_seccomp_bpf_global_KILL_one_arg_one pass
seccomp_seccomp_bpf_global_KILL_one_arg_six pass
seccomp_seccomp_bpf_global_KILL_thread pass
seccomp_seccomp_bpf_global_KILL_process pass
seccomp_seccomp_bpf_global_KILL_unknown pass
seccomp_seccomp_bpf_global_arg_out_of_range pass
seccomp_seccomp_bpf_global_ERRNO_valid pass
seccomp_seccomp_bpf_global_ERRNO_zero pass
seccomp_seccomp_bpf_global_ERRNO_capped pass
seccomp_seccomp_bpf_global_ERRNO_order pass
seccomp_seccomp_bpf_global_negative_ENOSYS pass
seccomp_seccomp_bpf_global_seccomp_syscall pass
seccomp_seccomp_bpf_global_seccomp_syscall_mode_lock pass
seccomp_seccomp_bpf_global_detect_seccomp_filter_flags pass
seccomp_seccomp_bpf_global_TSYNC_first pass
seccomp_seccomp_bpf_global_syscall_restart pass
seccomp_seccomp_bpf_global_filter_flag_log pass
seccomp_seccomp_bpf_global_get_action_avail pass
seccomp_seccomp_bpf_global_get_metadata_Kernel_does_not_support_PTRACE_SECCOMP_GET_METADATA_missing_CONFIG_CHECKPOINT_RESTORE skip
seccomp_seccomp_bpf_global_user_notification_basic pass
seccomp_seccomp_bpf_global_user_notification_with_tsync pass
seccomp_seccomp_bpf_global_user_notification_kill_in_middle pass
seccomp_seccomp_bpf_global_user_notification_signal pass
seccomp_seccomp_bpf_global_user_notification_closed_listener pass
seccomp_seccomp_bpf_global_user_notification_child_pid_ns pass
seccomp_seccomp_bpf_global_user_notification_sibling_pid_ns pass
seccomp_seccomp_bpf_global_user_notification_fault_recv pass
seccomp_seccomp_bpf_global_seccomp_get_notif_sizes pass
seccomp_seccomp_bpf_global_user_notification_continue pass
seccomp_seccomp_bpf_global_user_notification_filter_empty pass
seccomp_seccomp_bpf_global_user_ioctl_notification_filter_empty pass
seccomp_seccomp_bpf_global_user_notification_filter_empty_threaded pass
seccomp_seccomp_bpf_global_user_notification_addfd pass
seccomp_seccomp_bpf_global_user_notification_addfd_rlimit pass
seccomp_seccomp_bpf_global_user_notification_sync pass
seccomp_seccomp_bpf_global_user_notification_fifo pass
seccomp_seccomp_bpf_global_user_notification_wait_killable_pre_notification pass
seccomp_seccomp_bpf_global_user_notification_wait_killable pass
seccomp_seccomp_bpf_global_user_notification_wait_killable_fatal pass
seccomp_seccomp_bpf_global_tsync_vs_dead_thread_leader pass
seccomp_seccomp_bpf_TRAP_dfl pass
seccomp_seccomp_bpf_TRAP_ign pass
seccomp_seccomp_bpf_TRAP_handler pass
seccomp_seccomp_bpf_precedence_allow_ok pass
seccomp_seccomp_bpf_precedence_kill_is_highest pass
seccomp_seccomp_bpf_precedence_kill_is_highest_in_any_order pass
seccomp_seccomp_bpf_precedence_trap_is_second pass
seccomp_seccomp_bpf_precedence_trap_is_second_in_any_order pass
seccomp_seccomp_bpf_precedence_errno_is_third pass
seccomp_seccomp_bpf_precedence_errno_is_third_in_any_order pass
seccomp_seccomp_bpf_precedence_trace_is_fourth pass
seccomp_seccomp_bpf_precedence_trace_is_fourth_in_any_order pass
seccomp_seccomp_bpf_precedence_log_is_fifth pass
seccomp_seccomp_bpf_precedence_log_is_fifth_in_any_order pass
seccomp_seccomp_bpf_TRACE_poke_read_has_side_effects pass
seccomp_seccomp_bpf_TRACE_poke_getpid_runs_normally pass
seccomp_seccomp_bpf_TRACE_syscall_ptrace_negative_ENOSYS pass
seccomp_seccomp_bpf_TRACE_syscall_ptrace_syscall_allowed pass
seccomp_seccomp_bpf_TRACE_syscall_ptrace_syscall_redirected pass
seccomp_seccomp_bpf_TRACE_syscall_ptrace_syscall_errno pass
seccomp_seccomp_bpf_TRACE_syscall_ptrace_syscall_faked pass
seccomp_seccomp_bpf_TRACE_syscall_ptrace_kill_immediate pass
seccomp_seccomp_bpf_TRACE_syscall_ptrace_skip_after pass
seccomp_seccomp_bpf_TRACE_syscall_ptrace_kill_after pass
seccomp_seccomp_bpf_TRACE_syscall_seccomp_negative_ENOSYS pass
seccomp_seccomp_bpf_TRACE_syscall_seccomp_syscall_allowed pass
seccomp_seccomp_bpf_TRACE_syscall_seccomp_syscall_redirected pass
seccomp_seccomp_bpf_TRACE_syscall_seccomp_syscall_errno pass
seccomp_seccomp_bpf_TRACE_syscall_seccomp_syscall_faked pass
seccomp_seccomp_bpf_TRACE_syscall_seccomp_kill_immediate pass
seccomp_seccomp_bpf_TRACE_syscall_seccomp_skip_after pass
seccomp_seccomp_bpf_TRACE_syscall_seccomp_kill_after pass
seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl pass
seccomp_seccomp_bpf_TSYNC_two_siblings_with_ancestor pass
seccomp_seccomp_bpf_TSYNC_two_sibling_want_nnp pass
seccomp_seccomp_bpf_TSYNC_two_siblings_with_no_filter pass
seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_divergence pass
seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_divergence_no_tid_in_err pass
seccomp_seccomp_bpf_TSYNC_two_siblings_not_under_filter pass
seccomp_seccomp_bpf_O_SUSPEND_SECCOMP_setoptions_Kernel_does_not_support_PTRACE_O_SUSPEND_SECCOMP_missing_CONFIG_CHECKPOINT_RESTORE skip
seccomp_seccomp_bpf_O_SUSPEND_SECCOMP_seize_Kernel_does_not_support_PTRACE_O_SUSPEND_SECCOMP_missing_CONFIG_CHECKPOINT_RESTORE skip
seccomp_seccomp_bpf pass
seccomp_seccomp_benchmark_native_1_bitmap pass
seccomp_seccomp_benchmark_native_1_filter pass
seccomp_seccomp_benchmark_per-filter_last_2_diff_per-filter_filters_4 fail
seccomp_seccomp_benchmark_1_bitmapped_2_bitmapped pass
seccomp_seccomp_benchmark_entry_1_bitmapped pass
seccomp_seccomp_benchmark_entry_2_bitmapped pass
seccomp_seccomp_benchmark_native_entry_per_filter_4_4_filters_total pass
seccomp_seccomp_benchmark fail
+ ../../utils/send-to-lava.sh ./output/result.txt
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=shardfile-seccomp RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_kcmp RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_mode_strict_support RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_mode_strict_cannot_call_prctl RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_no_new_privs_support RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_mode_filter_support RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_mode_filter_without_nnp RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_filter_size_limits RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_filter_chain_limits RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_mode_filter_cannot_move_to_strict RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_mode_filter_get_seccomp RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_ALLOW_all RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_empty_prog RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_log_all RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_unknown_ret_is_kill_inside RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_unknown_ret_is_kill_above_allow RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_KILL_all RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_KILL_one RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_KILL_one_arg_one RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_KILL_one_arg_six RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_KILL_thread RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_KILL_process RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_KILL_unknown RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_arg_out_of_range RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_ERRNO_valid RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_ERRNO_zero RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_ERRNO_capped RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_ERRNO_order RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_negative_ENOSYS RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_seccomp_syscall RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_seccomp_syscall_mode_lock RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_detect_seccomp_filter_flags RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_TSYNC_first RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_syscall_restart RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_filter_flag_log RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_get_action_avail RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_get_metadata_Kernel_does_not_support_PTRACE_SECCOMP_GET_METADATA_missing_CONFIG_CHECKPOINT_RESTORE RESULT=skip>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_user_notification_basic RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_user_notification_with_tsync RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_user_notification_kill_in_middle RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_user_notification_signal RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_user_notification_closed_listener RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_user_notification_child_pid_ns RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_user_notification_sibling_pid_ns RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_user_notification_fault_recv RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_seccomp_get_notif_sizes RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_user_notification_continue RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_user_notification_filter_empty RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_user_ioctl_notification_filter_empty RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_user_notification_filter_empty_threaded RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_user_notification_addfd RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_user_notification_addfd_rlimit RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_user_notification_sync RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_user_notification_fifo RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_user_notification_wait_killable_pre_notification RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_user_notification_wait_killable RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_user_notification_wait_killable_fatal RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_global_tsync_vs_dead_thread_leader RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TRAP_dfl RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TRAP_ign RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TRAP_handler RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_precedence_allow_ok RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_precedence_kill_is_highest RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_precedence_kill_is_highest_in_any_order RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_precedence_trap_is_second RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_precedence_trap_is_second_in_any_order RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_precedence_errno_is_third RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_precedence_errno_is_third_in_any_order RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_precedence_trace_is_fourth RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_precedence_trace_is_fourth_in_any_order RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_precedence_log_is_fifth RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_precedence_log_is_fifth_in_any_order RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TRACE_poke_read_has_side_effects RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TRACE_poke_getpid_runs_normally RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TRACE_syscall_ptrace_negative_ENOSYS RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TRACE_syscall_ptrace_syscall_allowed RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TRACE_syscall_ptrace_syscall_redirected RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TRACE_syscall_ptrace_syscall_errno RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TRACE_syscall_ptrace_syscall_faked RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TRACE_syscall_ptrace_kill_immediate RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TRACE_syscall_ptrace_skip_after RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TRACE_syscall_ptrace_kill_after RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TRACE_syscall_seccomp_negative_ENOSYS RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TRACE_syscall_seccomp_syscall_allowed RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TRACE_syscall_seccomp_syscall_redirected RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TRACE_syscall_seccomp_syscall_errno RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TRACE_syscall_seccomp_syscall_faked RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TRACE_syscall_seccomp_kill_immediate RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TRACE_syscall_seccomp_skip_after RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TRACE_syscall_seccomp_kill_after RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TSYNC_two_siblings_with_ancestor RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TSYNC_two_sibling_want_nnp RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TSYNC_two_siblings_with_no_filter RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_divergence RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_divergence_no_tid_in_err RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_TSYNC_two_siblings_not_under_filter RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_O_SUSPEND_SECCOMP_setoptions_Kernel_does_not_support_PTRACE_O_SUSPEND_SECCOMP_missing_CONFIG_CHECKPOINT_RESTORE RESULT=skip>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf_O_SUSPEND_SECCOMP_seize_Kernel_does_not_support_PTRACE_O_SUSPEND_SECCOMP_missing_CONFIG_CHECKPOINT_RESTORE RESULT=skip>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_bpf RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_benchmark_native_1_bitmap RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_benchmark_native_1_filter RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_benchmark_per-filter_last_2_diff_per-filter_filters_4 RESULT=fail>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_benchmark_1_bitmapped_2_bitmapped RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_benchmark_entry_1_bitmapped RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_benchmark_entry_2_bitmapped RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_benchmark_native_entry_per_filter_4_4_filters_total RESULT=pass>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=seccomp_seccomp_benchmark RESULT=fail>
+ set +x
<LAVA_SIGNAL_ENDRUN 1_kselftest-seccomp 1575830_1.6.2.4.5>
<LAVA_TEST_RUNNER EXIT>
/ #

=====================================================


#kernelci test maestro:687779f42ce2c1874ed2365d

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

