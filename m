Return-Path: <stable+bounces-247294-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIgOMe1IBmo3hwIAu9opvQ
	(envelope-from <stable+bounces-247294-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 00:13:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E645475E2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 00:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B06153009CF9
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 22:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBD43D0C17;
	Thu, 14 May 2026 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OuvoCpLd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE94E3CF970;
	Thu, 14 May 2026 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778796774; cv=none; b=h5JJdZH3yE5bEgyd+tDuHjKLcOVQFQ1uSJwf0i7If6Xce7cpsGOAYmWt0F5uRg3W9l3FZZFe026gq5sAxCDNTr6e2q5Lr8SgMrWQ7aZoB0X8Q0eQwpoSy5n8xqsS8D0RmOsTAlEUT4ZKZXclMgCbmdRNbTkQeTtgh6/rTIzHx08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778796774; c=relaxed/simple;
	bh=C83HVAA5whDxjfDzoG0SwSDvI+bkZ1aQI11I2de9+a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vtg7GLJGuBXL+iRcMvvxnbino4Gdxe7bqQpubIV4+BwLO3tfmImtZlmXINnOwZFyhA3ZNEh2aWkoISkoTc82OxUyC0IJ/BkitDJfHAARgeoNzZKeQTsMZSxgTuIwKlt4zFgjdoOIlYkkA/ijA2410oiAIlVQqgLTHH9vL6HvRx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OuvoCpLd; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778796770; x=1810332770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C83HVAA5whDxjfDzoG0SwSDvI+bkZ1aQI11I2de9+a8=;
  b=OuvoCpLd4IUv7Ij2bIftrjmxuWKky0xMiKtpbwkvWq27u0vxL/uaRyfI
   WTfdY4lU4glct2BY9t5G1QF3vUcXlimNgwN80K3w2Ac2XL6w70qnktpn+
   0VzvosJ5rfbp6sO9jUOutN/SCQjqeO6KWrUJBscOUIdb1ODrS8ssluZWV
   zDCpzE+rMa3TVuGxkHaV+rygrhTVs2nYGETteER75Nxcy/C2OYocuft2C
   fnBH7yy5RufDth8ANzKfCaSLZlvz2WAMZfPiKkq7Do5Nl1LHgi4f/ZLNQ
   9F6Lxns9uJMai3MwgeKAgrRFAzcoHapHp7V5k5NEzsuBrf1MxptIwtrkd
   w==;
X-CSE-ConnectionGUID: A9yn86DDRBm74HjY5AKQKw==
X-CSE-MsgGUID: kEiMzrdBStO9IzvMJ+nWNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="83364350"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="83364350"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 15:12:49 -0700
X-CSE-ConnectionGUID: mOgdFv+TRTKLwRw16rkfhA==
X-CSE-MsgGUID: vUDgimDYQvW81FHF4oeGdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="243481817"
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 14 May 2026 15:12:45 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNeHX-000000000E5-0ELY;
	Thu, 14 May 2026 22:12:22 +0000
Date: Fri, 15 May 2026 06:11:24 +0800
From: kernel test robot <lkp@intel.com>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v2 net] net: core: dev: add reprocess depth limit for
 another_round in __netif_receive_skb_core
Message-ID: <202605150631.QDJOt3V7-lkp@intel.com>
References: <20260512022127.7818-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512022127.7818-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Rspamd-Queue-Id: 66E645475E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[lists.linux.dev,mails.tsinghua.edu.cn,google.com,kernel.org,redhat.com,gmail.com,126.com,tsinghua.edu.cn,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-247294-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim,01.org:url]
X-Rspamd-Action: no action

Hi Yizhou,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master horms-ipvs/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yizhou-Zhao/net-core-dev-add-reprocess-depth-limit-for-another_round-in-__netif_receive_skb_core/20260514-205938
base:   net/main
patch link:    https://lore.kernel.org/r/20260512022127.7818-1-zhaoyz24%40mails.tsinghua.edu.cn
patch subject: [PATCH v2 net] net: core: dev: add reprocess depth limit for another_round in __netif_receive_skb_core
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20260515/202605150631.QDJOt3V7-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260515/202605150631.QDJOt3V7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605150631.QDJOt3V7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/dev.c: In function '__netif_receive_skb_core':
>> net/core/dev.c:5982:13: warning: unused variable 'redirect_depth' [-Wunused-variable]
    5982 |         int redirect_depth = 0;
         |             ^~~~~~~~~~~~~~


vim +/redirect_depth +5982 net/core/dev.c

  5971	
  5972	static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
  5973					    struct packet_type **ppt_prev)
  5974	{
  5975		enum skb_drop_reason drop_reason = SKB_DROP_REASON_UNHANDLED_PROTO;
  5976		struct packet_type *ptype, *pt_prev;
  5977		rx_handler_func_t *rx_handler;
  5978		struct sk_buff *skb = *pskb;
  5979		struct net_device *orig_dev;
  5980		bool deliver_exact = false;
  5981		int ret = NET_RX_DROP;
> 5982		int redirect_depth = 0;
  5983		__be16 type;
  5984	
  5985		net_timestamp_check(!READ_ONCE(net_hotdata.tstamp_prequeue), skb);
  5986	
  5987		trace_netif_receive_skb(skb);
  5988	
  5989		orig_dev = skb->dev;
  5990	
  5991		skb_reset_network_header(skb);
  5992	#if !defined(CONFIG_DEBUG_NET)
  5993		/* We plan to no longer reset the transport header here.
  5994		 * Give some time to fuzzers and dev build to catch bugs
  5995		 * in network stacks.
  5996		 */
  5997		if (!skb_transport_header_was_set(skb))
  5998			skb_reset_transport_header(skb);
  5999	#endif
  6000		skb_reset_mac_len(skb);
  6001	
  6002		pt_prev = NULL;
  6003	
  6004	another_round:
  6005		skb->skb_iif = skb->dev->ifindex;
  6006	
  6007		__this_cpu_inc(softnet_data.processed);
  6008	
  6009		if (static_branch_unlikely(&generic_xdp_needed_key)) {
  6010			int ret2;
  6011	
  6012			migrate_disable();
  6013			ret2 = do_xdp_generic(rcu_dereference(skb->dev->xdp_prog),
  6014					      &skb);
  6015			migrate_enable();
  6016	
  6017			if (ret2 != XDP_PASS) {
  6018				ret = NET_RX_DROP;
  6019				goto out;
  6020			}
  6021		}
  6022	
  6023		if (eth_type_vlan(skb->protocol)) {
  6024			skb = skb_vlan_untag(skb);
  6025			if (unlikely(!skb))
  6026				goto out;
  6027		}
  6028	
  6029		if (skb_skip_tc_classify(skb))
  6030			goto skip_classify;
  6031	
  6032		if (pfmemalloc)
  6033			goto skip_taps;
  6034	
  6035		list_for_each_entry_rcu(ptype, &dev_net_rcu(skb->dev)->ptype_all,
  6036					list) {
  6037			if (unlikely(pt_prev))
  6038				ret = deliver_skb(skb, pt_prev, orig_dev);
  6039			pt_prev = ptype;
  6040		}
  6041	
  6042		list_for_each_entry_rcu(ptype, &skb->dev->ptype_all, list) {
  6043			if (unlikely(pt_prev))
  6044				ret = deliver_skb(skb, pt_prev, orig_dev);
  6045			pt_prev = ptype;
  6046		}
  6047	
  6048	skip_taps:
  6049	#ifdef CONFIG_NET_INGRESS
  6050		if (static_branch_unlikely(&ingress_needed_key)) {
  6051			bool another = false;
  6052	
  6053			nf_skip_egress(skb, true);
  6054			skb = sch_handle_ingress(skb, &pt_prev, &ret, orig_dev,
  6055						 &another);
  6056			if (another) {
  6057				if (unlikely(++redirect_depth > XMIT_RECURSION_LIMIT)) {
  6058					net_warn_ratelimited(
  6059						"%s: redirect loop limit reached, dropping (dev=%s)\n",
  6060						__func__, skb->dev->name);
  6061					drop_reason = SKB_DROP_REASON_TC_RECLASSIFY_LOOP;
  6062					goto drop;
  6063				}
  6064				goto another_round;
  6065			}
  6066			if (!skb)
  6067				goto out;
  6068	
  6069			nf_skip_egress(skb, false);
  6070			if (nf_ingress(skb, &pt_prev, &ret, orig_dev) < 0)
  6071				goto out;
  6072		}
  6073	#endif
  6074		skb_reset_redirect(skb);
  6075	skip_classify:
  6076		if (pfmemalloc && !skb_pfmemalloc_protocol(skb)) {
  6077			drop_reason = SKB_DROP_REASON_PFMEMALLOC;
  6078			goto drop;
  6079		}
  6080	
  6081		if (skb_vlan_tag_present(skb)) {
  6082			if (unlikely(pt_prev)) {
  6083				ret = deliver_skb(skb, pt_prev, orig_dev);
  6084				pt_prev = NULL;
  6085			}
  6086			if (vlan_do_receive(&skb))
  6087				goto another_round;
  6088			else if (unlikely(!skb))
  6089				goto out;
  6090		}
  6091	
  6092		rx_handler = rcu_dereference(skb->dev->rx_handler);
  6093		if (rx_handler) {
  6094			if (unlikely(pt_prev)) {
  6095				ret = deliver_skb(skb, pt_prev, orig_dev);
  6096				pt_prev = NULL;
  6097			}
  6098			switch (rx_handler(&skb)) {
  6099			case RX_HANDLER_CONSUMED:
  6100				ret = NET_RX_SUCCESS;
  6101				goto out;
  6102			case RX_HANDLER_ANOTHER:
  6103				goto another_round;
  6104			case RX_HANDLER_EXACT:
  6105				deliver_exact = true;
  6106				break;
  6107			case RX_HANDLER_PASS:
  6108				break;
  6109			default:
  6110				BUG();
  6111			}
  6112		}
  6113	
  6114		if (unlikely(skb_vlan_tag_present(skb)) && !netdev_uses_dsa(skb->dev)) {
  6115	check_vlan_id:
  6116			if (skb_vlan_tag_get_id(skb)) {
  6117				/* Vlan id is non 0 and vlan_do_receive() above couldn't
  6118				 * find vlan device.
  6119				 */
  6120				skb->pkt_type = PACKET_OTHERHOST;
  6121			} else if (eth_type_vlan(skb->protocol)) {
  6122				/* Outer header is 802.1P with vlan 0, inner header is
  6123				 * 802.1Q or 802.1AD and vlan_do_receive() above could
  6124				 * not find vlan dev for vlan id 0.
  6125				 */
  6126				__vlan_hwaccel_clear_tag(skb);
  6127				skb = skb_vlan_untag(skb);
  6128				if (unlikely(!skb))
  6129					goto out;
  6130				if (vlan_do_receive(&skb))
  6131					/* After stripping off 802.1P header with vlan 0
  6132					 * vlan dev is found for inner header.
  6133					 */
  6134					goto another_round;
  6135				else if (unlikely(!skb))
  6136					goto out;
  6137				else
  6138					/* We have stripped outer 802.1P vlan 0 header.
  6139					 * But could not find vlan dev.
  6140					 * check again for vlan id to set OTHERHOST.
  6141					 */
  6142					goto check_vlan_id;
  6143			}
  6144			/* Note: we might in the future use prio bits
  6145			 * and set skb->priority like in vlan_do_receive()
  6146			 * For the time being, just ignore Priority Code Point
  6147			 */
  6148			__vlan_hwaccel_clear_tag(skb);
  6149		}
  6150	
  6151		type = skb->protocol;
  6152	
  6153		/* deliver only exact match when indicated */
  6154		if (likely(!deliver_exact)) {
  6155			deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
  6156					       &ptype_base[ntohs(type) &
  6157							   PTYPE_HASH_MASK]);
  6158	
  6159			/* orig_dev and skb->dev could belong to different netns;
  6160			 * Even in such case we need to traverse only the list
  6161			 * coming from skb->dev, as the ptype owner (packet socket)
  6162			 * will use dev_net(skb->dev) to do namespace filtering.
  6163			 */
  6164			deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
  6165					       &dev_net_rcu(skb->dev)->ptype_specific);
  6166		}
  6167	
  6168		deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
  6169				       &orig_dev->ptype_specific);
  6170	
  6171		if (unlikely(skb->dev != orig_dev)) {
  6172			deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
  6173					       &skb->dev->ptype_specific);
  6174		}
  6175	
  6176		if (pt_prev) {
  6177			*ppt_prev = pt_prev;
  6178		} else {
  6179	drop:
  6180			if (!deliver_exact)
  6181				dev_core_stats_rx_dropped_inc(skb->dev);
  6182			else
  6183				dev_core_stats_rx_nohandler_inc(skb->dev);
  6184	
  6185			kfree_skb_reason(skb, drop_reason);
  6186			/* Jamal, now you will not able to escape explaining
  6187			 * me how you were going to use this. :-)
  6188			 */
  6189			ret = NET_RX_DROP;
  6190		}
  6191	
  6192	out:
  6193		/* The invariant here is that if *ppt_prev is not NULL
  6194		 * then skb should also be non-NULL.
  6195		 *
  6196		 * Apparently *ppt_prev assignment above holds this invariant due to
  6197		 * skb dereferencing near it.
  6198		 */
  6199		*pskb = skb;
  6200		return ret;
  6201	}
  6202	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

