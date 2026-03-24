Return-Path: <stable+bounces-230096-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECRhJI1XwmmGbwQAu9opvQ
	(envelope-from <stable+bounces-230096-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 10:21:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C1E3057C4
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 10:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DDB5310B9DD
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 09:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1513DBD52;
	Tue, 24 Mar 2026 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qwwxKL3u"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9543DB63A
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343463; cv=none; b=FQeQ5b83XWKoIFGgjBxuI2ix0d2V96Hlg+4JQd6dtoozFMx5unNxF+hak3zZemf7PaI1QAXHXlNBojLcNnB2wbn2uiRaQq1Vhu5CHvnlfvYt3/neuaUFXang0mQEKsw3qt4uM44jAWujiGZbYdY2/g1A+ZC3P84813EnTmesBjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343463; c=relaxed/simple;
	bh=kdMOtPk2CJNdzK5TAPoFyAepYVoHlWSZWSQYeczlyIA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eyuFD2bfc4rSbZMkWb2uNVZ8V67utrUu791IKk7SQ7RPFyOvhKyEKQSPQWRi1wxwy1WQ4ALrmoqab1L7TWF1Haje757FtEa4kwgf5DFQzO2FMnlg+1fe4SHisrZ0WoHYu7zQH+wXebLVNypELDSiKnC9hFgO21Kt8TF/9NyaXh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qwwxKL3u; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fe36cfabso19977145e9.1
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 02:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774343454; x=1774948254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ySFCnBOOL5CefvlohZg7FDp7ZB+X1Q7Muut2F1vaWbU=;
        b=qwwxKL3ueOVVtil1WSpF3OnWEb3KwGAtG6JzyrqAVBtIwPN631O6+N+F7/l2r+Rl+5
         N63Avp+BMuZo/iw9s+FVhZDrQbJm0P4JFaLPBlJqFtf/rgD3Jk60aYZNFpbcG/G/sLvY
         XGw1PpgfIvY3J8q7KfL1iZBJp6oR5W7UdhvJaqoNa0Tufnaus0PMann4fyOwd8HYYmh6
         nNc1jIMYUpt7NT63XSDIoiH3654N9BjNChyfIfMm7wi/BXJ1ho2TGyzKD/7FfU6X5Gs7
         IgWzQauqgk+rPdD6du9jLYc9KRmsRQB4Bdl1KB/syKq/gGHH6OrcX81pjhk5EXsWhleV
         H8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774343454; x=1774948254;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySFCnBOOL5CefvlohZg7FDp7ZB+X1Q7Muut2F1vaWbU=;
        b=dzP2xVwzb99H8euS2XsspCZmscB+YoUTcSifaW6zchIjOIrYFhOgEIAAqAym+Saa2Y
         oHKmB1Gk4v7jqDn63daz6GdNX7Ad+p2VT6wVd1eOVPG1cmYZNgjbcIrrEOkGe/AmyihA
         1We6Uu3q6SLcGPK7gRXR+QnX03Ir3wr3JkVJGBl/7SLU+B+jBpTdxL49PLokjsRYmVSq
         8lowZpzUHbeFmv4513dIPbxoHZnbd8MnwbaUb+4ZhH8+Cc7QdaHOE6MIBkvZdeD+w607
         GDCZaHmxovAPlQ+jB1izL6e70ELF15NJuniUNzQD8nZ10xS8B3LbYWuBbTVq6aotuHHP
         Clsg==
X-Forwarded-Encrypted: i=1; AJvYcCUcAg+sE0+G5BMfkFVIHr4VGLhdIVSpSz3ooYIbJaW4w3xOrsWtWMYNZcm5v6dpUhQdJYyEFCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoBeqHV0iSrtWcT+T/R1M3qxKedDlYkM7cB5RcqIH1RHIDLIea
	4MhVqfVFYXpbxT2Pqg4iAnyAF3KlmNPgK4SoRMmvim3s4YeT7A1Cn54LaF6Dtn0BVvo=
X-Gm-Gg: ATEYQzyDOAkaNLEXpRnRrRAJH95jiKV3wB/AuX5syGyIOQOCX3ixm8OFDVj8mZVzmOH
	c8q1lqgiNvaQ5I+qb0MkQwY/eK/5UwbJmzdCosUqe23JCmmY676Y11XV9vKPWp894+i8EQ0g+oc
	83g/8/EGUYdL7M/Yv8a17zayou737a2z9lo/bqWCrIQt0V53lK59iUL9QX/cMKo+h/ELPn5hFIt
	UTUMoQQmucKpRHweUINQQ59A24t/VPN0ApxmIDKDwysT8B7yMF0uoXtPcYY930uuh9hmjkc9Rqf
	b/dNpO4Hk/w+X3I7a4WXqhkgH/lH/Rf4WDxqFOXAxQec/W3+kmEnn2Xs7NYZ/C/NBts2t++26Gp
	qgP9EVPxBBh4JbHuZv8AdAxgIZxEyoC/MJsNTwYasxM7R23QZTMSFnZoAjlSyzNze+7idf0XeFV
	QjQgKDHHyNmbl+5objL4Z/JFrxi44BD2jEJRh622M=
X-Received: by 2002:a05:600c:154b:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-4870f212c1emr37488815e9.13.1774343454041;
        Tue, 24 Mar 2026 02:10:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871174f2desm44785325e9.9.2026.03.24.02.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 02:10:53 -0700 (PDT)
Date: Tue, 24 Mar 2026 12:10:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, David Carlier <devnexen@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	David Carlier <devnexen@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/memcontrol: fix obj_cgroup leak in
 mem_cgroup_css_online() error path
Message-ID: <202603241635.qNXDPwjs-lkp@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322164943.37460-1-devnexen@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230096-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[lists.linux.dev,gmail.com,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lists.linux.dev,kvack.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:email,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 04C1E3057C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/David-Carlier/mm-memcontrol-fix-obj_cgroup-leak-in-mem_cgroup_css_online-error-path/20260324-010357
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260322164943.37460-1-devnexen%40gmail.com
patch subject: [PATCH] mm/memcontrol: fix obj_cgroup leak in mem_cgroup_css_online() error path
config: arm64-randconfig-r072-20260324 (https://download.01.org/0day-ci/archive/20260324/202603241635.qNXDPwjs-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.3.0
smatch: v0.5.0-9004-gb810ac53

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202603241635.qNXDPwjs-lkp@intel.com/

smatch warnings:
mm/memcontrol.c:4180 mem_cgroup_css_online() warn: variable dereferenced before check 'pn' (see line 4176)

vim +/pn +4180 mm/memcontrol.c

6f0df8e16eb543 Johannes Weiner  2023-08-23  4168  	 * regular ID destruction during offlining.
6f0df8e16eb543 Johannes Weiner  2023-08-23  4169  	 */
e77786b4682e69 Shakeel Butt     2025-12-25  4170  	xa_store(&mem_cgroup_private_ids, memcg->id.id, memcg, GFP_KERNEL);
6f0df8e16eb543 Johannes Weiner  2023-08-23  4171  
2f7dd7a4100ad4 Johannes Weiner  2014-10-02  4172  	return 0;
098fad3e1621cb Qi Zheng         2026-03-05  4173  free_objcg:
098fad3e1621cb Qi Zheng         2026-03-05  4174  	for_each_node(nid) {
098fad3e1621cb Qi Zheng         2026-03-05  4175  		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
59f75a1877fbf7 David Carlier    2026-03-22 @4176  		objcg = rcu_replace_pointer(pn->objcg, NULL, true);
                                                                                            ^^^^^^^^^
Dereference

59f75a1877fbf7 David Carlier    2026-03-22  4177  		if (objcg)
59f75a1877fbf7 David Carlier    2026-03-22  4178  			percpu_ref_kill(&objcg->refcnt);
098fad3e1621cb Qi Zheng         2026-03-05  4179  
4a2f95f5c79e02 Qi Zheng         2026-03-09 @4180  		if (pn && pn->orig_objcg) {
                                                                    ^^
Checked too late.

098fad3e1621cb Qi Zheng         2026-03-05  4181  			obj_cgroup_put(pn->orig_objcg);
4a2f95f5c79e02 Qi Zheng         2026-03-09  4182  			/*
02b5fc7885d9f8 Andrew Morton    2026-03-09  4183  			 * Reset pn->orig_objcg to NULL to prevent
02b5fc7885d9f8 Andrew Morton    2026-03-09  4184  			 * obj_cgroup_put() from being called again in
02b5fc7885d9f8 Andrew Morton    2026-03-09  4185  			 * __mem_cgroup_free().
4a2f95f5c79e02 Qi Zheng         2026-03-09  4186  			 */
4a2f95f5c79e02 Qi Zheng         2026-03-09  4187  			pn->orig_objcg = NULL;
4a2f95f5c79e02 Qi Zheng         2026-03-09  4188  		}
098fad3e1621cb Qi Zheng         2026-03-05  4189  	}
a0dd8b1942f5bf Muchun Song      2026-03-05  4190  	free_shrinker_info(memcg);
da0efe30944476 Muchun Song      2022-03-22  4191  offline_kmem:
da0efe30944476 Muchun Song      2022-03-22  4192  	memcg_offline_kmem(memcg);
e77786b4682e69 Shakeel Butt     2025-12-25  4193  	mem_cgroup_private_id_remove(memcg);
da0efe30944476 Muchun Song      2022-03-22  4194  	return -ENOMEM;
8cdea7c0545426 Balbir Singh     2008-02-07  4195  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


