Return-Path: <stable+bounces-98858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D925D9E5F31
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 20:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8736128615E
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 19:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5371422E3F4;
	Thu,  5 Dec 2024 19:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QoJLV9Jg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7407522D4F2
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733428478; cv=none; b=LQAxOPFNOd5oc733oRZdqXKpTAciTMSExKsQxmr0BwT7s4hRgto4Hg8gSzFAMbPSrEwQIgn6X4qOC/ZOMV86toFE9jCXDNTke06wSuywmqpcpyrzfOQfUBMTNJunzpT2imlM0VXLRoRVoS6+2jPzTmRgVe7o0Waqt0VThWTekyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733428478; c=relaxed/simple;
	bh=vhbbHz1yBMg1oLY8i08EsGZhgnjN0h92EmEVlCnFACY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2uo1NIXD0F1oTJZF6ilEBAg2zgS6zpxAIsBMH6YCFTJu6SO5CSae+8Bo7aRZCPIrHp1smo3lf+gj50fKSJRr84ygACVcHuFdXO9K4enqMPtONGg6Gz02NHTMRt2QK8zkSblEDB6B5ESGy3ixAcxT+GEKQdBpL5EpfqBtmj559Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QoJLV9Jg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a9f9a225so9115e9.1
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 11:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733428475; x=1734033275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YV1GOShnKkFf0HLahvzq1w+GJ+Yzlm4X88Ky6h9+fMA=;
        b=QoJLV9JgDl34C7Ugqfm9XdnfyPQLc4Lm5yKF+NeashYgx195kbauZjmrx5UP3zT77I
         MdaKFvpzkMBSPBnwJ0274q8b1280iAjuwwu9WdBxR8UX+HcgBwwmDGS2Udjl3+ScHzDl
         oPhxNHzqhCee4nX1r5ToPNn/D88EklYAVlMbvCf52wwCzj4a//HTHo/c49JMm39lKl17
         bFYFYGWsbyIx+MyywsV+Vi+HKWVz0WkL9lh8mRsyu7mqgu/b/6MedyPTsN8Tgy/7iEsf
         IRAmwR3/NuK8IW5t4qId2sXvmwZJKjBWFKlLGDLsm3gLKTNRbRD/6jOv+ZkJlgeNzWf1
         t0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733428475; x=1734033275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YV1GOShnKkFf0HLahvzq1w+GJ+Yzlm4X88Ky6h9+fMA=;
        b=HeVuX6htpk8zUNeL1YntNkVEtw+NIhxxR4Fxrj0CVhcpcyPTfsRuHnu5/kb3uVUAVL
         tBukFlhR1H5vbeqJPVHzFF3FZAJornlBvPF9TKA7EyL1ljVEZaQvhblD4NnBXPR9s4HJ
         yMXKPUu6PE9PWIdzQ+tZfB8LzFH+5kn6KRuNgsdAHH7O/dxBvnbbDVkjAOpZ4RM3/XU3
         sBkclyNEffmBruV2ZV74YoSc5Dhk/Azu/tueIyevUxusZD2qB1LLxd2uHWHYMj+b3cja
         5PgZVxN0oC4Clb3ys27LBtngBcqNl6ngGFHnq8HbsZQ504SK0Xzz7HFr9lfs3CB8b2yu
         VYwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs9YriAvxnlSIA3FdYoP/gER9l/mzhUM75roSJZEZHiDOibgrgzOTngCRLUd6dV9NIgMFFkWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YztV6M6llBh8sKSenHMY7S68Dj5JyhUQpxbR3vggomPa2PEvMhT
	rTiWs+ijvXTL7fWjlt8DQfbykJzWTPJRnUyn2bxHYt46OhPrRkeMbm12jaVG73pb5TMmWkTJXil
	u6dmdRLQ13BDlCPhBPTr8RzvpGz64MLsTZBSG
X-Gm-Gg: ASbGncu8X7B9JChGEU8j69ig2G5iYMFsOGwPoylRZ9NLf4fD4FhuHQqzpSpJf1UIBSY
	JztKxiDac9hWCCrSbl/KdACIM09AoBaV37svaVw98pGIgilHt5CTvBap+bZuD
X-Google-Smtp-Source: AGHT+IEg8jS6R8nzvvgqFY4eAzSsGGb0NyqX/at7eAZ/z8kw1IzlpGFkHWMNC7b2JnZaKud2fJhzbW1s/D33iVi8sr0=
X-Received: by 2002:a05:600c:5846:b0:434:9e1d:44ef with SMTP id
 5b1f17b1804b1-434de647452mr97705e9.7.1733428474682; Thu, 05 Dec 2024 11:54:34
 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205192943.3228757-1-isaacmanjarres@google.com>
In-Reply-To: <20241205192943.3228757-1-isaacmanjarres@google.com>
From: Jeff Xu <jeffxu@google.com>
Date: Thu, 5 Dec 2024 11:53:57 -0800
Message-ID: <CALmYWFvGZj5Bc8LfveMCc=3ZAgd-Lqr=186K4swpnTc=2a-JkQ@mail.gmail.com>
Subject: Re: [PATCH v1] selftests/memfd: Run sysctl tests when PID namespace
 support is enabled
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Daniel Verkamp <dverkamp@chromium.org>, Kees Cook <kees@kernel.org>, stable@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, kernel-team@android.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 11:29=E2=80=AFAM Isaac J. Manjarres
<isaacmanjarres@google.com> wrote:
>
> The sysctl tests for vm.memfd_noexec rely on the kernel to support PID
> namespaces (i.e. the kernel is built with CONFIG_PID_NS=3Dy). If the
> kernel the test runs on does not support PID namespaces, the first
> sysctl test will fail when attempting to spawn a new thread in a new
> PID namespace, abort the test, preventing the remaining tests from
> being run.
>
> This is not desirable, as not all kernels need PID namespaces, but can
> still use the other features provided by memfd. Therefore, only run the
> sysctl tests if the kernel supports PID namespaces. Otherwise, skip
> those tests and emit an informative message to let the user know why
> the sysctl tests are not being run.
>
Thanks for fixing this.

> Fixes: 11f75a01448f ("selftests/memfd: add tests for MFD_NOEXEC_SEAL MFD_=
EXEC")
> Cc: stable@vger.kernel.org # v6.6+
> Cc: Jeff Xu <jeffxu@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> ---
>  tools/testing/selftests/memfd/memfd_test.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/s=
elftests/memfd/memfd_test.c
> index 95af2d78fd31..0a0b55516028 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -9,6 +9,7 @@
>  #include <fcntl.h>
>  #include <linux/memfd.h>
>  #include <sched.h>
> +#include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <signal.h>
> @@ -1557,6 +1558,11 @@ static void test_share_fork(char *banner, char *b_=
suffix)
>         close(fd);
>  }
>
> +static bool pid_ns_supported(void)
> +{
> +       return access("/proc/self/ns/pid", F_OK) =3D=3D 0;
> +}
> +
>  int main(int argc, char **argv)
>  {
>         pid_t pid;
> @@ -1591,8 +1597,12 @@ int main(int argc, char **argv)
>         test_seal_grow();
>         test_seal_resize();
>
> -       test_sysctl_simple();
> -       test_sysctl_nested();
> +       if (pid_ns_supported()) {
> +               test_sysctl_simple();
> +               test_sysctl_nested();
> +       } else {
> +               printf("PID namespaces are not supported; skipping sysctl=
 tests\n");
> +       }
>
>         test_share_dup("SHARE-DUP", "");
>         test_share_mmap("SHARE-MMAP", "");
> --
> 2.47.0.338.g60cca15819-goog
>
Reviewed-by: Jeff Xu <jeffxu@google.com>

