Return-Path: <stable+bounces-210449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA31DD3C0BD
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 08:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79DC55050A5
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 07:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40683A1CE7;
	Tue, 20 Jan 2026 07:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NkviSA1r"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307EF200110;
	Tue, 20 Jan 2026 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768893960; cv=none; b=OI5oVjONtkHb7MkGlAJvG89zFkMk45fZ9Y0GYj61k/3pxryN+73LqDih2wAgF4awLMeN5dAmhlM8G2BX/QxyQ9v0YLP2n3TTVF2v10m8K8WvDj0EX+vqZxvJ0QE/4ax/+BpdKZrelr4+iI4XWFVqbBb5xCRWAX+OItmF7tsXqHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768893960; c=relaxed/simple;
	bh=jsBRg6f0YTkrNT/9MFBOU/q5ahgIx9WSGncILIpJAlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGk992sQPX/1BWinv94qS3HUikrxp+KQiSkXVe6a4T1wknMhYdD0nP84FLjvrHlJExP5ztNWlUGszp5hRtDS7H0hEtR83ppv+wEgmiBWuHvpJVH2FfTdryREd94oLo0gpU+7kz3soVGQJzePICpX5LusOulJdVWus1V65CC8CfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NkviSA1r; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768893956; x=1800429956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jsBRg6f0YTkrNT/9MFBOU/q5ahgIx9WSGncILIpJAlU=;
  b=NkviSA1rc4XqN9JxdYLQpbmkClElXy2IJOL/iicCJeTx1xFolqsF2q60
   1sGjn//ZzcqlXvc88CH3oTJuA9cYODWPP6v9XHlbdWxfTyNSYMK5UJ2An
   ezO8j6Tp9YBWqApfM06eHFf+qW0J2Kqars26gO/EjD5I4cYB/a6UaPWOM
   Mo92YiZzJ0vv+fAmoQ2mzedVDXdqX3imeedrRKI9j+t0PWPP/9Sx/MJdB
   JaaEEkKPi0FyLAluYrwM5Wf0kVMeL9ZH6A2j6V7Y7BfpAXXy0jXjkVVmL
   dulh7ow83XEgo94cKNkh/ZjJycu9QKzHOVbUNYCZ4iC/TrFtqTF2tYvAz
   w==;
X-CSE-ConnectionGUID: Vs60q6eEQEiw0bbHZyM/Ag==
X-CSE-MsgGUID: olHuiESSTumIUPmnXh7b2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="81533549"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="81533549"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:25:49 -0800
X-CSE-ConnectionGUID: +hhkSHnqSzasGiyYpqf6CA==
X-CSE-MsgGUID: OWy5N6TMQUKLL2Iga7twsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="205845611"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 19 Jan 2026 23:25:46 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vi67T-00000000OgP-0oks;
	Tue, 20 Jan 2026 07:25:43 +0000
Date: Tue, 20 Jan 2026 15:25:40 +0800
From: kernel test robot <lkp@intel.com>
To: Paul Moses <p@1g4.org>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] net/sched: act_gate: fix schedule updates with RCU
 swap
Message-ID: <202601201522.IMzUdE7V-lkp@intel.com>
References: <20260120004720.1886632-2-p@1g4.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120004720.1886632-2-p@1g4.org>

Hi Paul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Moses/net-sched-act_gate-fix-schedule-updates-with-RCU-swap/20260120-085120
base:   net/main
patch link:    https://lore.kernel.org/r/20260120004720.1886632-2-p%401g4.org
patch subject: [PATCH 1/2] net/sched: act_gate: fix schedule updates with RCU swap
config: powerpc-randconfig-001-20260120 (https://download.01.org/0day-ci/archive/20260120/202601201522.IMzUdE7V-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260120/202601201522.IMzUdE7V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601201522.IMzUdE7V-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/sched/act_gate.c:499:24: warning: result of comparison of constant 9223372036854775807 with expression of type 'u32' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
     499 |                         if (entry->interval > (u64)S64_MAX) {
         |                             ~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~
   1 warning generated.


vim +499 net/sched/act_gate.c

   292	
   293	static int tcf_gate_init(struct net *net, struct nlattr *nla,
   294				 struct nlattr *est, struct tc_action **a,
   295				 struct tcf_proto *tp, u32 flags,
   296				 struct netlink_ext_ack *extack)
   297	{
   298		struct tc_action_net *tn = net_generic(net, act_gate_ops.net_id);
   299		struct nlattr *tb[TCA_GATE_MAX + 1];
   300		struct tcf_chain *goto_ch = NULL;
   301		struct tcf_gate_params *p, *oldp;
   302		struct tcf_gate *gact;
   303		struct tc_gate *parm;
   304		struct tcf_gate_params newp = { };
   305		ktime_t start;
   306		u64 cycletime = 0, basetime = 0, cycletime_ext = 0;
   307		enum tk_offsets tk_offset = TK_OFFS_TAI;
   308		s32 clockid = CLOCK_TAI;
   309		u32 gflags = 0;
   310		u32 index;
   311		s32 prio = -1;
   312		bool bind = flags & TCA_ACT_FLAGS_BIND;
   313		bool clockid_set = false;
   314		bool setup_timer = false;
   315		bool update_timer = false;
   316		int ret = 0, err;
   317	
   318		INIT_LIST_HEAD(&newp.entries);
   319	
   320		if (!nla)
   321			return -EINVAL;
   322	
   323		err = nla_parse_nested(tb, TCA_GATE_MAX, nla, gate_policy, extack);
   324		if (err < 0)
   325			return err;
   326	
   327		if (!tb[TCA_GATE_PARMS])
   328			return -EINVAL;
   329	
   330		if (tb[TCA_GATE_CLOCKID]) {
   331			clockid = nla_get_s32(tb[TCA_GATE_CLOCKID]);
   332			clockid_set = true;
   333			switch (clockid) {
   334			case CLOCK_REALTIME:
   335				tk_offset = TK_OFFS_REAL;
   336				break;
   337			case CLOCK_MONOTONIC:
   338				tk_offset = TK_OFFS_MAX;
   339				break;
   340			case CLOCK_BOOTTIME:
   341				tk_offset = TK_OFFS_BOOT;
   342				break;
   343			case CLOCK_TAI:
   344				tk_offset = TK_OFFS_TAI;
   345				break;
   346			default:
   347				NL_SET_ERR_MSG(extack, "Invalid 'clockid'");
   348				return -EINVAL;
   349			}
   350		}
   351	
   352		parm = nla_data(tb[TCA_GATE_PARMS]);
   353		index = parm->index;
   354	
   355		err = tcf_idr_check_alloc(tn, &index, a, bind);
   356		if (err < 0)
   357			return err;
   358	
   359		if (!err) {
   360			ret = tcf_idr_create_from_flags(tn, index, est, a,
   361							&act_gate_ops, bind, flags);
   362			if (ret) {
   363				tcf_idr_cleanup(tn, index);
   364				return ret;
   365			}
   366	
   367			ret = ACT_P_CREATED;
   368			gact = to_gate(*a);
   369		} else {
   370			if (bind)
   371				return ACT_P_BOUND;
   372	
   373			if (!(flags & TCA_ACT_FLAGS_REPLACE)) {
   374				tcf_idr_release(*a, bind);
   375				return -EEXIST;
   376			}
   377			gact = to_gate(*a);
   378		}
   379	
   380		if (ret != ACT_P_CREATED)
   381			oldp = rcu_dereference_protected(gact->param,
   382							 lockdep_is_held(&gact->common.tcfa_lock) ||
   383							 lockdep_is_held(&gact->tcf_lock) ||
   384							 lockdep_rtnl_is_held());
   385		else
   386			oldp = NULL;
   387	
   388		if (tb[TCA_GATE_PRIORITY])
   389			prio = nla_get_s32(tb[TCA_GATE_PRIORITY]);
   390		else if (ret != ACT_P_CREATED)
   391			prio = oldp->tcfg_priority;
   392	
   393		if (tb[TCA_GATE_BASE_TIME]) {
   394			basetime = nla_get_u64(tb[TCA_GATE_BASE_TIME]);
   395			if (basetime > (u64)S64_MAX) {
   396				NL_SET_ERR_MSG(extack, "Base time out of range");
   397				err = -EINVAL;
   398				goto release_idr;
   399			}
   400		} else if (ret != ACT_P_CREATED) {
   401			basetime = oldp->tcfg_basetime;
   402		}
   403	
   404		if (tb[TCA_GATE_FLAGS])
   405			gflags = nla_get_u32(tb[TCA_GATE_FLAGS]);
   406		else if (ret != ACT_P_CREATED)
   407			gflags = oldp->tcfg_flags;
   408	
   409		err = tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
   410		if (err < 0)
   411			goto release_idr;
   412	
   413		if (!clockid_set) {
   414			if (ret != ACT_P_CREATED)
   415				clockid = oldp->tcfg_clockid;
   416			else
   417				clockid = CLOCK_TAI;
   418			switch (clockid) {
   419			case CLOCK_REALTIME:
   420				tk_offset = TK_OFFS_REAL;
   421				break;
   422			case CLOCK_MONOTONIC:
   423				tk_offset = TK_OFFS_MAX;
   424				break;
   425			case CLOCK_BOOTTIME:
   426				tk_offset = TK_OFFS_BOOT;
   427				break;
   428			case CLOCK_TAI:
   429				tk_offset = TK_OFFS_TAI;
   430				break;
   431			default:
   432				NL_SET_ERR_MSG(extack, "Invalid 'clockid'");
   433				err = -EINVAL;
   434				goto put_chain;
   435			}
   436		}
   437	
   438		if (ret == ACT_P_CREATED)
   439			update_timer = true;
   440		else if (basetime != oldp->tcfg_basetime ||
   441			 tk_offset != gact->tk_offset ||
   442			 clockid != oldp->tcfg_clockid)
   443			update_timer = true;
   444	
   445		if (ret == ACT_P_CREATED)
   446			setup_timer = true;
   447		else if (clockid != oldp->tcfg_clockid)
   448			setup_timer = true;
   449	
   450		if (tb[TCA_GATE_CYCLE_TIME]) {
   451			cycletime = nla_get_u64(tb[TCA_GATE_CYCLE_TIME]);
   452			if (cycletime > (u64)S64_MAX) {
   453				NL_SET_ERR_MSG(extack, "Cycle time out of range");
   454				err = -EINVAL;
   455				goto put_chain;
   456			}
   457		}
   458	
   459		if (tb[TCA_GATE_ENTRY_LIST]) {
   460			err = parse_gate_list(tb[TCA_GATE_ENTRY_LIST], &newp, extack);
   461			if (err <= 0) {
   462				if (!err)
   463					NL_SET_ERR_MSG(extack,
   464						       "Missing gate schedule (entry list)");
   465				err = -EINVAL;
   466				goto put_chain;
   467			}
   468			newp.num_entries = err;
   469		} else if (ret == ACT_P_CREATED) {
   470			NL_SET_ERR_MSG(extack, "Missing schedule entry list");
   471			err = -EINVAL;
   472			goto put_chain;
   473		}
   474	
   475		if (tb[TCA_GATE_CYCLE_TIME_EXT])
   476			cycletime_ext = nla_get_u64(tb[TCA_GATE_CYCLE_TIME_EXT]);
   477		else if (ret != ACT_P_CREATED)
   478			cycletime_ext = oldp->tcfg_cycletime_ext;
   479	
   480		if (!cycletime) {
   481			struct tcfg_gate_entry *entry;
   482			struct list_head *entries;
   483			u64 cycle = 0;
   484	
   485			if (!list_empty(&newp.entries))
   486				entries = &newp.entries;
   487			else if (ret != ACT_P_CREATED)
   488				entries = &oldp->entries;
   489			else
   490				entries = NULL;
   491	
   492			if (!entries) {
   493				NL_SET_ERR_MSG(extack, "Invalid cycle time");
   494				err = -EINVAL;
   495				goto release_new_entries;
   496			}
   497	
   498			list_for_each_entry(entry, entries, list) {
 > 499				if (entry->interval > (u64)S64_MAX) {
   500					NL_SET_ERR_MSG(extack,
   501						       "Cycle time out of range");
   502					err = -EINVAL;
   503					goto release_new_entries;
   504				}
   505				if (cycle > (u64)S64_MAX - entry->interval) {
   506					NL_SET_ERR_MSG(extack,
   507						       "Cycle time out of range");
   508					err = -EINVAL;
   509					goto release_new_entries;
   510				}
   511				cycle += entry->interval;
   512			}
   513	
   514			cycletime = cycle;
   515			if (!cycletime) {
   516				NL_SET_ERR_MSG(extack, "Invalid cycle time");
   517				err = -EINVAL;
   518				goto release_new_entries;
   519			}
   520		}
   521	
   522		if (ret != ACT_P_CREATED &&
   523		    (tb[TCA_GATE_ENTRY_LIST] || tb[TCA_GATE_CYCLE_TIME] ||
   524		     cycletime != oldp->tcfg_cycletime))
   525			update_timer = true;
   526	
   527		p = kzalloc(sizeof(*p), GFP_KERNEL);
   528		if (!p) {
   529			err = -ENOMEM;
   530			goto release_new_entries;
   531		}
   532	
   533		INIT_LIST_HEAD(&p->entries);
   534		p->tcfg_priority = prio;
   535		p->tcfg_basetime = basetime;
   536		p->tcfg_cycletime = cycletime;
   537		p->tcfg_cycletime_ext = cycletime_ext;
   538		p->tcfg_flags = gflags;
   539		p->tcfg_clockid = clockid;
   540	
   541		if (!list_empty(&newp.entries)) {
   542			list_splice_init(&newp.entries, &p->entries);
   543			p->num_entries = newp.num_entries;
   544		} else if (ret != ACT_P_CREATED) {
   545			struct tcfg_gate_entry *entry, *ne;
   546	
   547			list_for_each_entry(entry, &oldp->entries, list) {
   548				ne = kmemdup(entry, sizeof(*ne), GFP_KERNEL);
   549				if (!ne) {
   550					err = -ENOMEM;
   551					goto free_p;
   552				}
   553				INIT_LIST_HEAD(&ne->list);
   554				list_add_tail(&ne->list, &p->entries);
   555			}
   556			p->num_entries = oldp->num_entries;
   557		}
   558	
   559		if (update_timer && ret != ACT_P_CREATED)
   560			hrtimer_cancel(&gact->hitimer);
   561	
   562		spin_lock_bh(&gact->tcf_lock);
   563		if (setup_timer)
   564			gate_setup_timer(gact, tk_offset, clockid);
   565	
   566		gate_get_start_time(gact, p, &start);
   567		gact->current_close_time = start;
   568		gact->next_entry = list_first_entry(&p->entries,
   569						    struct tcfg_gate_entry, list);
   570		gact->current_entry_octets = 0;
   571		gact->current_gate_status = GATE_ACT_GATE_OPEN | GATE_ACT_PENDING;
   572	
   573		goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
   574	
   575		gate_start_timer(gact, start);
   576	
   577		oldp = rcu_replace_pointer(gact->param, p,
   578					   lockdep_is_held(&gact->tcf_lock));
   579	
   580		spin_unlock_bh(&gact->tcf_lock);
   581	
   582		if (oldp)
   583			call_rcu(&oldp->rcu, tcf_gate_params_release);
   584	
   585		if (goto_ch)
   586			tcf_chain_put_by_act(goto_ch);
   587	
   588		return ret;
   589	
   590	free_p:
   591		release_entry_list(&p->entries);
   592		kfree(p);
   593	release_new_entries:
   594		release_entry_list(&newp.entries);
   595	put_chain:
   596		if (goto_ch)
   597			tcf_chain_put_by_act(goto_ch);
   598	release_idr:
   599		if (ret == ACT_P_CREATED) {
   600			p = rcu_dereference_protected(gact->param, 1);
   601			if (p) {
   602				release_entry_list(&p->entries);
   603				kfree(p);
   604				rcu_assign_pointer(gact->param, NULL);
   605			}
   606		}
   607		tcf_idr_release(*a, bind);
   608		return err;
   609	}
   610	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

