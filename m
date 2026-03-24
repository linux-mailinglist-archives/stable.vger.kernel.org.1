Return-Path: <stable+bounces-230113-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BHKCnBtwmmncwQAu9opvQ
	(envelope-from <stable+bounces-230113-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:54:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A95B0306D0B
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BA983032E4B
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 10:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F31835A939;
	Tue, 24 Mar 2026 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckQAvdy3"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB4C37BE93
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349677; cv=pass; b=RxNoh3CLFzAQUxSjcHj7BAVmat3GjHHmfQcJ6ruFe4vj7mOfCr5Zl0JtkRkZ6L5SIS3ZKJgFMEpL0/Bc88TQCdWJo9PLQsEQoAE99kphgZ+Ju7LFSjgh4G6tkoj6fNOCJ0ZkTOVV0noBokkcWyPuT0B+55MzsicEtuP4DdHR1lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349677; c=relaxed/simple;
	bh=RES/GDDu6KBclak6NqQ4jqepO12FsJpn6soJLgJMk2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmXWIhNdpJ+ghChas0jw6UAIpG70EEupAhyz9XAELCFHtCClUQtCrgzF11wIKVyloFrbQ+g6dAHXGMtT2XXrHh6SPc/6UBxdIlQqJLfcMq+dnbzATjF9s/CXWk+bqrzuYqbGvd/3+ggAtvsZcT7Ul19l3Pjvgs3KkW+MF01eqgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckQAvdy3; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-67c27a90a60so682620eaf.0
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 03:54:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774349675; cv=none;
        d=google.com; s=arc-20240605;
        b=IYhhR7O+reGVy7P/GzKHMqCz0vx/8r5ytfPFujCzMgbEXgEYI6Jn3lCmOIjjwrnU/2
         0e5JK2sCEn8QlyAhIYqwH4LLvAQnDSycRXVYjiCPhRvL6dibrpwMTzmhJhxir9RyTo9A
         b9VQ7BkH8HcY75NglFRjlTMQnuWmkSaI4+qW6uDjiI79gX5EensFcKZR0/eGLyGXU0RO
         B9nL64nRL/aqgs2RI7NdE+G7U6YizubqJlV2lANF4Yp8NIKUbIpA0XhVo10d09t5gI8n
         bpSrPqTGst8eNYhCA7uOp2MyGX6JWAQymuwPVUuSMYoGRKjdASngPNTqmMptyK8fvWHC
         BNLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4xZa/0j22+oqg1nMErzFxx2lp9k+a1i473iPRNI2fUs=;
        fh=NWM6pcbs2oFBL/lbwckz/uUcYVNTMqcnxO/10Kx05G4=;
        b=ThD0u8SreMQZgZe/7RaxG5BhMO4mElk3dnJ/kIV6vbpaKxarJhmK2thv1Y3J3c8iAz
         LuMw6OjOa/4whfmp99xnJLvG9EPlq6gFWRRzZSTye176KwbQQ/5BTX2Mtt0WKEVyvvaU
         XzELGYecwHdwuZcp2Dak+x2Vri/wjZ2WoDykVS7w49Xxtt8yIYDg8tJwpfSwl8DMK6FX
         gB+s8oJGbBdb+j0MvVm+c1o3pcTL6/TqiobSWSPMX/gk+W/X2njMimnBpxYZuGSVEseh
         Bkc7FUI3aSSwKqUqGj3ayo5rRV77EoRTlFZuN2TeGgkW8RdjmPRE64ynwYvzn2GiV8pA
         wsSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774349675; x=1774954475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4xZa/0j22+oqg1nMErzFxx2lp9k+a1i473iPRNI2fUs=;
        b=ckQAvdy38lli33/q2BN7/gzyr9w/E6vO2tyRAgVRK4h5rx3/afA8MxOhTajgGI3tTz
         zYS7RfnA11vN8iTjejGH56A6zp/WqUgtDrnNu7j6y7T1flbDU2Nv8rHaRf+WeqTuP2qz
         rR2s6AVflbM+m0cMo2jQ+KBxp0Ug9prk766PevFyow24G2hB1D6b0gAb12TehIU+bLR3
         8NqheZlBD/e5nWAn5c6GjuRGM7Rlr9Yn2oAOnG4yRgZNiA9CZP5HutLGj7/zzJpkFzMR
         tRqQgi9WCAUXY51IgOoF6hKpwNOTowgS0QDiRaT1xLqoA3YWEEJKmMNxBONv9VWPvcKV
         uR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774349675; x=1774954475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xZa/0j22+oqg1nMErzFxx2lp9k+a1i473iPRNI2fUs=;
        b=BLCAVEnYqfp4OPYTkM4jLJsCbF9VUZtKmqe5UVettgatuLVjQPlDrf48ThjBsdOKBJ
         hXtUTlWte3QWQsaXVIi016dMX6T6cjNZT29ujTIv620axcbWW24TI99OKi70AWTA25/W
         yyZUBmZcFltgXO4x3r2Qk4EIIiExAvuY9QOUuNdTmK/FX76ymc+WRfzIJEIBbWwqatpI
         L05F0VXP0Xqj3U/YypjxgR115Q95zG20Zh14PASen7xR8WfvtoSFlRxaIp4pJeDS9qjU
         nnm84CHA5eonpLFzpurXrk45QVBnZX3m1iuGzokzca8vJ9IOEIf7CHVlJp8RSBDfGOV3
         iEtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWenQh4tFoiBc5srkBtXN824PDFdj3j0FamT9Tr4QJoONtvKoMlmdbcXSEEeumC3gan1tPJz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd3rHnIqr57KvVQgPRAkcT1tdDCNArcv2iQygF2MLv4tf1r/wJ
	lAyog9+kp8k25y2nwVrSR6NjyA7XA6+rbe0NAIuOZV3KQ4ES8YJ+L1DOViIduZBuH2Fn6Bc4kqZ
	rMN1yzKTzWWq05bwIjbRw15ChW3ZHcII=
X-Gm-Gg: ATEYQzx7rraUee9+RkeHf4VM+HtjO0Qmm+G53OuceJHfvG6nHLI19J+bdhwa3y74Hmg
	tsV7qtXvjpVBWc3o+UFHOExhu0wrKCwTBVtpXZZdmuGjpPoE9mwekwwSurB5W12zXEwuK51pZzb
	35diaXAlslz+C8Kysby9rZUF822eCgWCGmOzCIM0cNN8SnjOPNOHl0WmTkIloEvFhfunzfRQAfL
	j0iKFxBakKRoGrFt+KGGMAlE7sJX7V2gZKBer0+KinfoXjvRH/YNcSF+JMrNVCNBIbnYyStrpe8
	qVdEtysddSkeO+3kRYc45aQHrpRGvQt5x+QPovvo9/npC2IW
X-Received: by 2002:a05:6820:2d4a:b0:677:98b4:79ab with SMTP id
 006d021491bc7-67c22f74118mr13202109eaf.33.1774349675421; Tue, 24 Mar 2026
 03:54:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322164943.37460-1-devnexen@gmail.com> <202603241635.qNXDPwjs-lkp@intel.com>
In-Reply-To: <202603241635.qNXDPwjs-lkp@intel.com>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 24 Mar 2026 10:54:23 +0000
X-Gm-Features: AaiRm50vrYNk_mlAnRdMfp0nxFOpfo962oTnSfj2Jot4SGUmcie4lybU4o5qGTY
Message-ID: <CA+XhMqzK39zZu7_KG37RJSeiR56fUON2CQsDN_L1W3+BuZzHmA@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: fix obj_cgroup leak in mem_cgroup_css_online()
 error path
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Qi Zheng <zhengqi.arch@bytedance.com>, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, 
	Linux Memory Management List <linux-mm@kvack.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230113-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A95B0306D0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Dan,

On Tue, 24 Mar 2026 at 09:10, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> Hi David,
>
> kernel test robot noticed the following build warnings:
>
> url:    https://github.com/intel-lab-lkp/linux/commits/David-Carlier/mm-memcontrol-fix-obj_cgroup-leak-in-mem_cgroup_css_online-error-path/20260324-010357
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20260322164943.37460-1-devnexen%40gmail.com
> patch subject: [PATCH] mm/memcontrol: fix obj_cgroup leak in mem_cgroup_css_online() error path
> config: arm64-randconfig-r072-20260324 (https://download.01.org/0day-ci/archive/20260324/202603241635.qNXDPwjs-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 14.3.0
> smatch: v0.5.0-9004-gb810ac53
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202603241635.qNXDPwjs-lkp@intel.com/
>
> smatch warnings:
> mm/memcontrol.c:4180 mem_cgroup_css_online() warn: variable dereferenced before check 'pn' (see line 4176)
>
> vim +/pn +4180 mm/memcontrol.c
>
> 6f0df8e16eb543 Johannes Weiner  2023-08-23  4168         * regular ID destruction during offlining.
> 6f0df8e16eb543 Johannes Weiner  2023-08-23  4169         */
> e77786b4682e69 Shakeel Butt     2025-12-25  4170        xa_store(&mem_cgroup_private_ids, memcg->id.id, memcg, GFP_KERNEL);
> 6f0df8e16eb543 Johannes Weiner  2023-08-23  4171
> 2f7dd7a4100ad4 Johannes Weiner  2014-10-02  4172        return 0;
> 098fad3e1621cb Qi Zheng         2026-03-05  4173  free_objcg:
> 098fad3e1621cb Qi Zheng         2026-03-05  4174        for_each_node(nid) {
> 098fad3e1621cb Qi Zheng         2026-03-05  4175                struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
> 59f75a1877fbf7 David Carlier    2026-03-22 @4176                objcg = rcu_replace_pointer(pn->objcg, NULL, true);
>                                                                                             ^^^^^^^^^
> Dereference
>
> 59f75a1877fbf7 David Carlier    2026-03-22  4177                if (objcg)
> 59f75a1877fbf7 David Carlier    2026-03-22  4178                        percpu_ref_kill(&objcg->refcnt);
> 098fad3e1621cb Qi Zheng         2026-03-05  4179
> 4a2f95f5c79e02 Qi Zheng         2026-03-09 @4180                if (pn && pn->orig_objcg) {
>                                                                     ^^
> Checked too late.
>
> 098fad3e1621cb Qi Zheng         2026-03-05  4181                        obj_cgroup_put(pn->orig_objcg);
> 4a2f95f5c79e02 Qi Zheng         2026-03-09  4182                        /*
> 02b5fc7885d9f8 Andrew Morton    2026-03-09  4183                         * Reset pn->orig_objcg to NULL to prevent
> 02b5fc7885d9f8 Andrew Morton    2026-03-09  4184                         * obj_cgroup_put() from being called again in
> 02b5fc7885d9f8 Andrew Morton    2026-03-09  4185                         * __mem_cgroup_free().
> 4a2f95f5c79e02 Qi Zheng         2026-03-09  4186                         */
> 4a2f95f5c79e02 Qi Zheng         2026-03-09  4187                        pn->orig_objcg = NULL;
> 4a2f95f5c79e02 Qi Zheng         2026-03-09  4188                }
> 098fad3e1621cb Qi Zheng         2026-03-05  4189        }
> a0dd8b1942f5bf Muchun Song      2026-03-05  4190        free_shrinker_info(memcg);
> da0efe30944476 Muchun Song      2022-03-22  4191  offline_kmem:
> da0efe30944476 Muchun Song      2022-03-22  4192        memcg_offline_kmem(memcg);
> e77786b4682e69 Shakeel Butt     2025-12-25  4193        mem_cgroup_private_id_remove(memcg);
> da0efe30944476 Muchun Song      2022-03-22  4194        return -ENOMEM;
> 8cdea7c0545426 Balbir Singh     2008-02-07  4195  }
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

Seems Smatch is flagging the inconsistency, but pn cannot be NULL at
the free_objcg label because all nodeinfo[] entries were fully
allocated in
  mem_cgroup_alloc() before css_online() runs. The old pn && check was
unnecessary defensive code.
Kind regards.

