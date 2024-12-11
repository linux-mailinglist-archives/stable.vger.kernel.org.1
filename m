Return-Path: <stable+bounces-100664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29599ED1EE
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C7D166B03
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81CC1DD873;
	Wed, 11 Dec 2024 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSW7Co3s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6764C1A707A
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934774; cv=none; b=VTnGs31CJMdoYsxI67AJSQLhfi+3vKHnMSWGRQHGMTPMi2f7cWkGbY7cbnWPX9+aopN15F2s7l+wIVTuOaqoT0+jAXC8J7vQQrKsqYBy1+5ituPoJz1BsewaVaMoKi/buoDKSIvkZDD1AUoyBU2PXLdyP1wjrkjsf5ZrfUop1/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934774; c=relaxed/simple;
	bh=XHMuYpDmn6gihpqYon0q9X3RiNn5oBUO/ZF71c7yF6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feGwXEHWJBlDUiUjyJdPHYBxLsoA0axxWKjgNKBO4SRP0n1+2JpjgaJVjBUQiCtsETkulefTbatxP+cbiiG3WWa/gDPZ3PIouo4Gi0cPXXkACEfHZhIlOgax0gUtlczDerg7OrfDmuE6J6oEqeDZ8PLW1Yl5DLNCITVeDb29+D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSW7Co3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C860CC4CED2;
	Wed, 11 Dec 2024 16:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934774;
	bh=XHMuYpDmn6gihpqYon0q9X3RiNn5oBUO/ZF71c7yF6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nSW7Co3sS/AxIMkOTZAyga7D7aetplemJRXW0Oller+Fmrp5xe+b5R5J7/3WhqyN+
	 apVQtDBuaEDPQfwHy4LU5DWxRC0B9oo71L4TEjhaH4YYUiuFFPfuxnUohm2wqz0Ye/
	 grwnMPC1WESm0mUI7HJ4oZZadzfMvK98agEjM+CPaahoAOjCKFxfhFxu1GWc2j0lJ5
	 6lD6t5xNrfsmlHlIfBSRYUGszqVszUVslPtp0lzHaR8SWy+VoSM69XjQuN81faCesc
	 CtiaclsZw819YIgIfM/u5hifIDcFNQReoLmmPnaV6vqlnxo0IMs1avMVIKDbBC/cZv
	 oWK0MS7yvWm5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] net: napi: Prevent overflow of napi_defer_hard_irqs
Date: Wed, 11 Dec 2024 11:32:52 -0500
Message-ID: <20241211102502-a555951d23eeb28f@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211040304.3212711-1-jianqi.ren.cn@windriver.com>
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
1:  08062af0a5210 ! 1:  06c1e1d149b4f net: napi: Prevent overflow of napi_defer_hard_irqs
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

