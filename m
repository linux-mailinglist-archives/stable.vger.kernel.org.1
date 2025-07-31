Return-Path: <stable+bounces-165703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6FCB17922
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 00:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 486917B3FAE
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 22:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB1E27E040;
	Thu, 31 Jul 2025 22:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l7DURx8l"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46F221CFF6
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 22:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754001106; cv=none; b=TFlgwFdt775VLXr5kx6Pv33vd/kJQPYIPSn7S9zxgpeRe5CKcZEsEd/hzzVuORzi/FkwSHMh6IzGAij7cubTZE3ftzMrk08ruf0t+UVIA1xwml+sqOHuMhtJ0KCqSFj/E1YsNs8NnLHxZZduW0urTyGQkoNSJi/ekPsCo3JS7lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754001106; c=relaxed/simple;
	bh=V88Xz2IVNFWtSxc1E/peEKh9xtpEYQ6L5LEkV/XWJ8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5wVOdMQxF8DFCEILilsmYiF7TKGXfn1eu0MMbhVPF4oyB/BbuRybuUCFYgXzxnkDaYTDIYRi0hiMSjCDOjGXN1GRES67lIqWO7w5S98nJSXspLw/AvhHwoCBGsA3U0tiU0JoOaUIMKjHKEXiYPzSS65HEy/mxsnMV57Jzi4BRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l7DURx8l; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24070dd87e4so61785ad.0
        for <stable@vger.kernel.org>; Thu, 31 Jul 2025 15:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754001104; x=1754605904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dmz3rRRo1iGk4Bkn+XaZWCGWfP9o/IvKxOlu+wl3FL4=;
        b=l7DURx8l+1zzSNH/Y0f8fq7l5LvLhkhAWf3P4weHQ1LbOSmv7mu6JJsuCVaUJbh0lq
         sNCIZulvPfUWPfZ90t7kpnRxIltVZGewoVuzU2E6PYAZ5jkVjbNN238aDiDGjPh/Nj4a
         jaUV8xAeJ4ui7KRw3w4q1W/1r+y+7LgzrvPvBshPYmsu9CMM2JVQX8A4VmtUBEOIbqxE
         upLTu+7DXqBiXZHYFFBXBFvF7TjLR/aFVWf3H+uE/+GPyLodJEUOKCbNr9RFaVnvAjdP
         GfLJh6d6kLC0L1MCNLWTueAAvJXq0j5SxIm+ZIFFBQRdH2/wPVOGR3agw1+ub8T5t2wq
         KOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754001104; x=1754605904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dmz3rRRo1iGk4Bkn+XaZWCGWfP9o/IvKxOlu+wl3FL4=;
        b=C1RqVCaF6KGuhvoqHcg/IhXXhBSHqaQvMoqT6HsWDyQHyfv3/LMap1kAuCLOGyOxkB
         n98LcITvnJ3QzLh/HxGF49mdC5VKLIAK8ie27XTAQ/Xkj+0QL3Eb68Vjp7QeDQMn7PHR
         TZncc8zGGXAL3yuuh7XFA9UGmmCmQcmXZZclA5ygI2ObxyWEySrry22mFGeXzhWBvWSu
         A1lNeCFcLC8itJ7Lrp38S5jYdHIZ5kI7u/KnvFZp6faMA4a5CA5A2gLysdsl1365SUPF
         5j6VCh/MXhZyfHF1FpUU6wuAMrJrHehdVcj/KuuF3H9FQGTCt4pKK8Jm5WgqkC1bUekQ
         uUxw==
X-Forwarded-Encrypted: i=1; AJvYcCX06FD/h257LoO7knFiv0EJq+FExblR9I99r6HGJyJqo/5/uZKWAUtKLfLydT3ChXoZGt3bZ4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4DM7QcIG2JDAKW0VoprOHGSJY6VOqe3IcOqUTUIyMIEFIEu7X
	fiXq6q/qVly/lbZxq/8en9PPBLSdMTqB3bwUu0GNRDd1q2vvWsb6CranNZNYunzrXg==
X-Gm-Gg: ASbGncuwOBP4b3uQGdCR1cO5U0HCz9WdPoGAQnrBFBr4rJhM1vQRcabZBAcU5SOSxs6
	tkMHkxvUn2Ezdod4WR7qBT3dW7RAqg32MCLFPndv63AjWR5686TramXQIfQ7jr7NxZsiTsDsj8j
	HxNfW53ecy3Zp6erj/p89bGBXGcTAE7MuwBMVJnIWsRkH6JYY5GaKLekBeJF86v63fTBV0k1bD3
	Z3DDAq+SUFd9Hd4uR2EvhKZyS9kcirXRki6D70Tbrsm0GdJ3qhKBM/sl64EkLQvHr8Hh54H/PPb
	4qo+CHx74vJxziH8mEs2HLHQDT1/hQPg9lSUjVE6NPJzKUVm/RtXjBXznaBL9KyG1SvGnV6Y4Jf
	N+YbCSLZip9G+1l4Ytcho9QqxMYAcniSCvtligH91s63wHTAiO+AvGO6LPtzOG1SAjTMFYbtKBQ
	==
X-Google-Smtp-Source: AGHT+IFWCtKBf+vvEYOI4A4CICLQLDvH4Pfc5QQIQtFJHb1xrK6jUevGcCx+8VyM7qERSU/tHNMpMg==
X-Received: by 2002:a17:902:c40b:b0:223:ff93:322f with SMTP id d9443c01a7336-24227b2c79dmr1204955ad.2.1754001103709;
        Thu, 31 Jul 2025 15:31:43 -0700 (PDT)
Received: from google.com (135.228.125.34.bc.googleusercontent.com. [34.125.228.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e897690csm26801135ad.99.2025.07.31.15.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 15:31:43 -0700 (PDT)
Date: Thu, 31 Jul 2025 22:31:37 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Jann Horn <jannh@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] eventpoll: Fix semi-unbounded recursion
Message-ID: <aIvusYlauznxttGc@google.com>
References: <20250711-epoll-recursion-fix-v1-1-fb2457c33292@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711-epoll-recursion-fix-v1-1-fb2457c33292@google.com>

On Fri, Jul 11, 2025 at 06:33:36PM +0200, Jann Horn wrote:
> Ensure that epoll instances can never form a graph deeper than
> EP_MAX_NESTS+1 links.
> 
> Currently, ep_loop_check_proc() ensures that the graph is loop-free and
> does some recursion depth checks, but those recursion depth checks don't
> limit the depth of the resulting tree for two reasons:
> 
>  - They don't look upwards in the tree.
>  - If there are multiple downwards paths of different lengths, only one of
>    the paths is actually considered for the depth check since commit
>    28d82dc1c4ed ("epoll: limit paths").
> 
> Essentially, the current recursion depth check in ep_loop_check_proc() just
> serves to prevent it from recursing too deeply while checking for loops.
> 
> A more thorough check is done in reverse_path_check() after the new graph
> edge has already been created; this checks, among other things, that no
> paths going upwards from any non-epoll file with a length of more than 5
> edges exist. However, this check does not apply to non-epoll files.
> 
> As a result, it is possible to recurse to a depth of at least roughly 500,
> tested on v6.15. (I am unsure if deeper recursion is possible; and this may
> have changed with commit 8c44dac8add7 ("eventpoll: Fix priority inversion
> problem").)
> 
> To fix it:
> 
> 1. In ep_loop_check_proc(), note the subtree depth of each visited node,
> and use subtree depths for the total depth calculation even when a subtree
> has already been visited.
> 2. Add ep_get_upwards_depth_proc() for similarly determining the maximum
> depth of an upwards walk.
> 3. In ep_loop_check(), use these values to limit the total path length
> between epoll nodes to EP_MAX_NESTS edges.
> 
> Fixes: 22bacca48a17 ("epoll: prevent creating circular epoll structures")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---

Hey Jann,

I've bisected an LTP test failure to this commit and I can't find any
reports of this. The test is epoll_ctl04:

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c

This is what I get:
  ####################################################################3
  root@debian:~# ./epoll_ctl04
  tst_test.c:2004: TINFO: LTP version: 20250530-116-g91e6272fe
  tst_test.c:2007: TINFO: Tested kernel: 6.16.0-rc1-00017-gf2e467a48287 #28 SMP PREEMPT Thu Jul 31 21:12:22 UTC 2025 aarch64
  tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
  tst_test.c:1825: TINFO: Overall timeout per run is 0h 00m 30s
  epoll_ctl04.c:59: TFAIL: epoll_ctl(..., EPOLL_CTL_ADD, ...) with number of nesting is 5 expected EINVAL: ELOOP (40)

  Summary:
  passed   0
  failed   1
  broken   0
  skipped  0
  warnings 0
  ####################################################################3


I haven't looked much into this but it seems the test expects EINVAL at
nesting depth 5 and is instead getting ELOOP. Any chance there is an
off-by-one error in ep_loop_check() as it fails with depth=4 and
upwards_depth=0, which isn't correct?

---
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 44648cc09250..811960b2a74c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2237,7 +2237,7 @@ static int ep_loop_check(struct eventpoll *ep, struct eventpoll *to)
        upwards_depth = ep_get_upwards_depth_proc(ep, 0);
        rcu_read_unlock();

-       return (depth+1+upwards_depth > EP_MAX_NESTS) ? -1 : 0;
+       return (depth+upwards_depth > EP_MAX_NESTS) ? -1 : 0;
 }

 static void clear_tfile_check_list(void)

