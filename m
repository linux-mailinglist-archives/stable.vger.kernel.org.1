Return-Path: <stable+bounces-191606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAF0C1A87C
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 14:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA931A21C83
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 13:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FEB290DBB;
	Wed, 29 Oct 2025 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PD9Ztoc+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74719278E63;
	Wed, 29 Oct 2025 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742175; cv=none; b=nn/5qA61z0E8Bl3BVz/PRUsved2R1s6h9fgjNIiQjGQ1w16joSwUbOH1zui3gg9ZxHjRuNb54lCMU4fZ0+v0NjuJsafJRSSZYIbY+ewLx0LQf9ML7gdUi9K3CSnYbPW1iHJAyc3eGZsqXGWeSUq9lidS5Hejvhhj2nWa87sqzG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742175; c=relaxed/simple;
	bh=iQzV2NLoZPaisz7Etf4u3hrE9RWEY0la9fBujKqzgrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+LDq7pTdXrCvbV271AnyMGFc/IxIielgRkQAyd/IouH0G38auhbRsaNZ0k6AwiD3ig5cDjuACbqTx4I9CfEev8vMuQhRr+HwyCeXOGhQ5zsaQIH+ntg6FFuG1+SFLa+8rORl0TmoTCiwAcCcqv0rcf3o2SiMXLir9l89a2eJ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PD9Ztoc+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761742173; x=1793278173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iQzV2NLoZPaisz7Etf4u3hrE9RWEY0la9fBujKqzgrg=;
  b=PD9Ztoc+P77Pm7n5T+II12+jFmOBP6fTkFXOTF6dHEVr19KAZrc8U8Ym
   J+DdkaL93GPeLCjm1QXuU20ZF5CmCO8DBPR6CfRmDVP/dg5bLgX4aZu4u
   yepE7ZEt6K4z95pPX4zvE3pl8MfG2xuvn1sJYuyxZsk+yU2/uJP1Olu/Q
   9cVIHkwalFaAiKiGGxEBIVsN0qLExphN8ix4prZIAHBdPUS1jw7PV3Myy
   QA9IwPkT8PM56XwzGItBIKV2VcKm8oqmz/vryhAXwHdp2GDuUh4teJO4O
   DVcqpCzHvjwNjJmWoH+5mMt0AlY5bHza/KPdNYg6KfSfZhJFXVjGZopWk
   g==;
X-CSE-ConnectionGUID: RPMys1B+RPiBKEYnOlKMNw==
X-CSE-MsgGUID: atq6EPw+TpuTwpjldXyl/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="63956535"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="63956535"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 05:49:33 -0700
X-CSE-ConnectionGUID: LLWIa5E1SgqFiiHTHrZs/g==
X-CSE-MsgGUID: eUCMYAkYRxqaJK5Wnd9mpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="186006582"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 29 Oct 2025 05:49:29 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vE5cF-000KbJ-0F;
	Wed, 29 Oct 2025 12:49:27 +0000
Date: Wed, 29 Oct 2025 20:49:03 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] virtio_net: fix alignment for virtio_net_hdr_v1_hash
Message-ID: <202510292058.zgpkfnPq-lkp@intel.com>
References: <20251029012434.75576-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029012434.75576-1-jasowang@redhat.com>

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Wang/virtio_net-fix-alignment-for-virtio_net_hdr_v1_hash/20251029-092814
base:   net/main
patch link:    https://lore.kernel.org/r/20251029012434.75576-1-jasowang%40redhat.com
patch subject: [PATCH net] virtio_net: fix alignment for virtio_net_hdr_v1_hash
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20251029/202510292058.zgpkfnPq-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251029/202510292058.zgpkfnPq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510292058.zgpkfnPq-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/packet/af_packet.c:86:
   include/linux/virtio_net.h: In function 'virtio_net_hdr_tnl_from_skb':
>> include/linux/virtio_net.h:404:24: error: 'struct virtio_net_hdr_v1_hash' has no member named 'hash_value'; did you mean 'hash_value_lo'?
     404 |         vhdr->hash_hdr.hash_value = 0;
         |                        ^~~~~~~~~~
         |                        hash_value_lo


vim +404 include/linux/virtio_net.h

a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  376  
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  377  /*
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  378   * vlan_hlen always refers to the outermost MAC header. That also
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  379   * means it refers to the only MAC header, if the packet does not carry
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  380   * any encapsulation.
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  381   */
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  382  static inline int
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  383  virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  384  			    struct virtio_net_hdr_v1_hash_tunnel *vhdr,
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  385  			    bool tnl_hdr_negotiated,
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  386  			    bool little_endian,
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  387  			    int vlan_hlen)
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  388  {
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  389  	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  390  	unsigned int inner_nh, outer_th;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  391  	int tnl_gso_type;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  392  	int ret;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  393  
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  394  	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  395  						    SKB_GSO_UDP_TUNNEL_CSUM);
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  396  	if (!tnl_gso_type)
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  397  		return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  398  					       vlan_hlen);
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  399  
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  400  	/* Tunnel support not negotiated but skb ask for it. */
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  401  	if (!tnl_hdr_negotiated)
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  402  		return -EINVAL;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  403  
b2284768c6b32a Jason Wang  2025-10-22 @404          vhdr->hash_hdr.hash_value = 0;
b2284768c6b32a Jason Wang  2025-10-22  405          vhdr->hash_hdr.hash_report = 0;
b2284768c6b32a Jason Wang  2025-10-22  406          vhdr->hash_hdr.padding = 0;
b2284768c6b32a Jason Wang  2025-10-22  407  
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  408  	/* Let the basic parsing deal with plain GSO features. */
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  409  	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  410  	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  411  	skb_shinfo(skb)->gso_type |= tnl_gso_type;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  412  	if (ret)
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  413  		return ret;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  414  
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  415  	if (skb->protocol == htons(ETH_P_IPV6))
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  416  		hdr->gso_type |= VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  417  	else
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  418  		hdr->gso_type |= VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  419  
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  420  	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM)
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  421  		hdr->flags |= VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  422  
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  423  	inner_nh = skb->inner_network_header - skb_headroom(skb);
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  424  	outer_th = skb->transport_header - skb_headroom(skb);
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  425  	vhdr->inner_nh_offset = cpu_to_le16(inner_nh);
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  426  	vhdr->outer_th_offset = cpu_to_le16(outer_th);
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  427  	return 0;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  428  }
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  429  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

