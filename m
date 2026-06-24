Return-Path: <stable+bounces-268084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X00RCmSEO2p6ZAgAu9opvQ
	(envelope-from <stable+bounces-268084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 09:16:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D3B6BC148
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 09:16:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=dZpg8XTD;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268084-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-268084-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E65BD3010632
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 07:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768143911CD;
	Wed, 24 Jun 2026 07:16:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9903909A8;
	Wed, 24 Jun 2026 07:16:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285408; cv=none; b=pSJQdJQiDjLa6xH/7f2APbIS3ubhkM45T3CNGtoLQfh7msvb5LGrTm4zhdRAFkaMZzK6E+T0Xw+8nN6n1UaFP2sHBvLaDIE9uG2n/JUp2sJa0qPa71uCll4AcfMciLTPQ9kbU7F4uvJx4F+hhBPRLbpp+p3vUVV+03sjnGDSVeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285408; c=relaxed/simple;
	bh=v0fDDJQ04PKwVSy8FaBc7hyuhYILgq/Tj1wVcUxl7Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gym1ps2hczaI3HGQJhE9r7f7K5WYDokH+Fyj3YqzSgUl0N6OD1RoP6Mh9bqMZAKz23M9T8jhr4aoBpYJvXPgw65VSldVwFI3aLOwychOId/9v9/1LSKRcGFSaLoUyN4DGf5QVNLR7K+j/ODeMhgh6JTzF7nTFPmZi9bQpmFeCM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZpg8XTD; arc=none smtp.client-ip=192.198.163.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782285405; x=1813821405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v0fDDJQ04PKwVSy8FaBc7hyuhYILgq/Tj1wVcUxl7Aw=;
  b=dZpg8XTDjG7cnm0AmuYyVMAIXvYBUjREkABXvywd58SJDBWzzI1cAJb/
   qkhX6mia2waWAgo71J5vG0JEuQd+ilJn0d4cerS3Bm8S4pH5i2QSlcNKp
   tkYB/e/LHqr1UHQbHAlrgxtvMhoDe5JrnCoINxjzKKs6Wmy//1NhdkqRt
   1goSeF3g/1Rwr7DUVByL4d21eQ1RulS5zO1lEhNmeMosnRuivRrCLmZqS
   zXUc3mICb3EcF4sRIjLvEWFt19tQ5zAFtxPCOdEwB8xAhOlvtn6zb9+wY
   /0Wz0IWbniEKG//9lfSK8UBHJ+vJlv/96AcTBpBp9nrT1UzWzkVja2990
   A==;
X-CSE-ConnectionGUID: QxGE0AkGS0St7El9QLOcXQ==
X-CSE-MsgGUID: zt5JWIBqSFC7Sakt+tm0Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="85597904"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="85597904"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 00:16:44 -0700
X-CSE-ConnectionGUID: hDFeCcQlQDWw0v2XAfGzqg==
X-CSE-MsgGUID: g4G95db9RCihGO6rHjcS5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="245621915"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 24 Jun 2026 00:16:42 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wcHqd-000000003C1-4A5h;
	Wed, 24 Jun 2026 07:16:36 +0000
Date: Wed, 24 Jun 2026 15:15:36 +0800
From: kernel test robot <lkp@intel.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	victor@mojatatu.com, andrew+netdev@lunn.ch,
	zdi-disclosures@trendmicro.com, stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH net 1/1] net/sched: sch_teql: Introduce slaves_lock to
 avoid race condition and UAF
Message-ID: <202606241501.XQBMu4b8-lkp@intel.com>
References: <20260623184247.508956-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623184247.508956-1-jhs@mojatatu.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268084-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lkp@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:netdev@vger.kernel.org,m:oe-kbuild-all@lists.linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:victor@mojatatu.com,m:andrew+netdev@lunn.ch,m:zdi-disclosures@trendmicro.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,01.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77D3B6BC148

Hi Jamal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jamal-Hadi-Salim/net-sched-sch_teql-Introduce-slaves_lock-to-avoid-race-condition-and-UAF/20260624-024432
base:   net/main
patch link:    https://lore.kernel.org/r/20260623184247.508956-1-jhs%40mojatatu.com
patch subject: [PATCH net 1/1] net/sched: sch_teql: Introduce slaves_lock to avoid race condition and UAF
config: sparc-randconfig-r133-20260624 (https://download.01.org/0day-ci/archive/20260624/202606241501.XQBMu4b8-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 15.2.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260624/202606241501.XQBMu4b8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606241501.XQBMu4b8-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/sched/sch_teql.c:106:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/sched/sch_teql.c:106:25: sparse:    struct Qdisc [noderef] __rcu *
   net/sched/sch_teql.c:106:25: sparse:    struct Qdisc *
   net/sched/sch_teql.c:217:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/sched/sch_teql.c:217:17: sparse:    struct Qdisc [noderef] __rcu *
   net/sched/sch_teql.c:217:17: sparse:    struct Qdisc *
   net/sched/sch_teql.c:220:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/sched/sch_teql.c:220:17: sparse:    struct Qdisc [noderef] __rcu *
   net/sched/sch_teql.c:220:17: sparse:    struct Qdisc *
   net/sched/sch_teql.c:300:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/sched/sch_teql.c:300:17: sparse:    struct Qdisc [noderef] __rcu *
   net/sched/sch_teql.c:300:17: sparse:    struct Qdisc *
   net/sched/sch_teql.c:359:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/sched/sch_teql.c:359:23: sparse:    struct Qdisc [noderef] __rcu *
   net/sched/sch_teql.c:359:23: sparse:    struct Qdisc *
   net/sched/sch_teql.c:333:41: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/sched/sch_teql.c:333:41: sparse:    struct Qdisc [noderef] __rcu *
   net/sched/sch_teql.c:333:41: sparse:    struct Qdisc *
   net/sched/sch_teql.c:333:41: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/sched/sch_teql.c:333:41: sparse:    struct Qdisc [noderef] __rcu *
   net/sched/sch_teql.c:333:41: sparse:    struct Qdisc *
   net/sched/sch_teql.c:333:41: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/sched/sch_teql.c:333:41: sparse:    struct Qdisc [noderef] __rcu *
   net/sched/sch_teql.c:333:41: sparse:    struct Qdisc *
   net/sched/sch_teql.c:349:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/sched/sch_teql.c:349:25: sparse:    struct Qdisc [noderef] __rcu *
   net/sched/sch_teql.c:349:25: sparse:    struct Qdisc *
   net/sched/sch_teql.c:349:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/sched/sch_teql.c:349:25: sparse:    struct Qdisc [noderef] __rcu *
   net/sched/sch_teql.c:349:25: sparse:    struct Qdisc *
   net/sched/sch_teql.c:349:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/sched/sch_teql.c:349:25: sparse:    struct Qdisc [noderef] __rcu *
   net/sched/sch_teql.c:349:25: sparse:    struct Qdisc *

vim +106 net/sched/sch_teql.c

    89	
    90	static struct sk_buff *
    91	teql_dequeue(struct Qdisc *sch)
    92	{
    93		struct teql_sched_data *dat = qdisc_priv(sch);
    94		struct netdev_queue *dat_queue;
    95		struct sk_buff *skb;
    96		struct Qdisc *q;
    97	
    98		skb = __skb_dequeue(&dat->q);
    99		dat_queue = netdev_get_tx_queue(dat->m->dev, 0);
   100		q = rcu_dereference_bh(dat_queue->qdisc);
   101	
   102		if (skb == NULL) {
   103			struct net_device *m = qdisc_dev(q);
   104			if (m) {
   105				spin_lock_bh(&dat->m->slaves_lock);
 > 106				rcu_assign_pointer(dat->m->slaves, sch);
   107				spin_unlock_bh(&dat->m->slaves_lock);
   108				netif_wake_queue(m);
   109			}
   110		} else {
   111			qdisc_bstats_update(sch, skb);
   112		}
   113		WRITE_ONCE(sch->q.qlen, dat->q.qlen + READ_ONCE(q->q.qlen));
   114		return skb;
   115	}
   116	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

