Return-Path: <stable+bounces-100651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2EC9ED1DC
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3654E16656E
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6FF1A707A;
	Wed, 11 Dec 2024 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiWwyCSl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDF138DE9
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934743; cv=none; b=N0TTw0MXvTJBvQxUzt6hDx2gjeni0Y+fiZwCB+ojgouQLn9e91EkQq4oBEGvaDyw0rWlyRXEkig69tgJu1ZcU1ppX8A6Nh1YHzb86RCONNIHE2UdLNxJOazbiexTNfyiIQD8+LRfSPqblVrptcmWfkupUIP/CXOpYgL8DhD90fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934743; c=relaxed/simple;
	bh=/xdrymNbwGoYfRThtkGAsfiNuC/JAAYnsDnqnxR5aPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJVw8Zm8mokQvp/9R5u+aIzIa0OlQPh9lABAFI5XneKxf1pXqj59eWOKKYBTjoyLvbWQx1qxdJRPtwITd644LZSqHwZR08nfYIN9Zwcm4P5jgESzCT+CD9AnsYdaqTMAiGk8sJMC6WrLn2pw25KE0uk2oc/IA13j3PzjQyKr/1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiWwyCSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FD5C4CED2;
	Wed, 11 Dec 2024 16:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934743;
	bh=/xdrymNbwGoYfRThtkGAsfiNuC/JAAYnsDnqnxR5aPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EiWwyCSlXCe3vL1C5pnO86KIt6VQF82VjlNAGJvW+zzcCWoqhwjk8LIl/Ido6GAX+
	 V4CY0worp58CRUxN/8Um6H/pwfRMP2HIQvuXKOkbauHo4tJHoPDBkHxrt/KNKFzhrb
	 rq+mc08qa6/QMsiA4KhiNI01dnkQoAx5NxBajLu31KHZSHDG4LWDlajsN9H/xvFnDI
	 DokLx1yFaXq8ehNqdtYsBic+u1IySfuBTg5IoCfs9mj8pnh3xBsUvSw/nUgoFpZY9s
	 hkCbqbVchGn+R4hHF3QgN6GXPbYernvyQlCMaboeE4g5Zx8iuMrc6H3o2gJIeoYVDo
	 gLz462F0cV50Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] net: napi: Prevent overflow of napi_defer_hard_irqs
Date: Wed, 11 Dec 2024 11:32:21 -0500
Message-ID: <20241211085902-1f585196b9a0c2ff@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211101055.2070018-1-jianqi.ren.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 08062af0a52107a243f7608fd972edb54ca5b7f8

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Joe Damato <jdamato@fastly.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  08062af0a5210 ! 1:  c5ba7dcacb876 net: napi: Prevent overflow of napi_defer_hard_irqs
    @@ Metadata
      ## Commit message ##
         net: napi: Prevent overflow of napi_defer_hard_irqs
     
    +    [ Upstream commit 08062af0a52107a243f7608fd972edb54ca5b7f8 ]
    +
         In commit 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
         napi_defer_irqs was added to net_device and napi_defer_irqs_count was
         added to napi_struct, both as type int.
    @@ Commit message
         Reviewed-by: Eric Dumazet <edumazet@google.com>
         Link: https://patch.msgid.link/20240904153431.307932-1-jdamato@fastly.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    -
    - ## Documentation/networking/net_cachelines/net_device.rst ##
    -@@ Documentation/networking/net_cachelines/net_device.rst: unsigned_int                        num_rx_queues
    - unsigned_int                        real_num_rx_queues      -                   read_mostly         get_rps_cpu
    - struct_bpf_prog*                    xdp_prog                -                   read_mostly         netif_elide_gro()
    - unsigned_long                       gro_flush_timeout       -                   read_mostly         napi_complete_done
    --int                                 napi_defer_hard_irqs    -                   read_mostly         napi_complete_done
    -+u32                                 napi_defer_hard_irqs    -                   read_mostly         napi_complete_done
    - unsigned_int                        gro_max_size            -                   read_mostly         skb_gro_receive
    - unsigned_int                        gro_ipv4_max_size       -                   read_mostly         skb_gro_receive
    - rx_handler_func_t*                  rx_handler              read_mostly         -                   __netif_receive_skb_core
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
     
      ## include/linux/netdevice.h ##
     @@ include/linux/netdevice.h: struct napi_struct {
    @@ include/linux/netdevice.h: struct napi_struct {
      	int			(*poll)(struct napi_struct *, int);
      #ifdef CONFIG_NETPOLL
     @@ include/linux/netdevice.h: struct net_device {
    - 	unsigned int		real_num_rx_queues;
    - 	struct netdev_rx_queue	*_rx;
    + 
    + 	struct bpf_prog __rcu	*xdp_prog;
      	unsigned long		gro_flush_timeout;
     -	int			napi_defer_hard_irqs;
     +	u32			napi_defer_hard_irqs;
    - 	unsigned int		gro_max_size;
    - 	unsigned int		gro_ipv4_max_size;
    - 	rx_handler_func_t __rcu	*rx_handler;
    + #define GRO_LEGACY_MAX_SIZE	65536u
    + /* TCP minimal MSS is 8 (TCP_MIN_GSO_SIZE),
    +  * and shinfo->gso_segs is a 16bit field.
     
      ## net/core/net-sysfs.c ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

