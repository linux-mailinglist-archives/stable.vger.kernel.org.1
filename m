Return-Path: <stable+bounces-124723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3A3A65A96
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 18:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03DDA8A0DC7
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CC11B423D;
	Mon, 17 Mar 2025 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a14U00Eq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0FD1A2C0B
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231813; cv=none; b=k+WF5YI0+ywBeLtBz4iw3ZMirLU8etoBhD6+om2yQqiNFqy7+BaNysfOsl3psvU6g6U/30pmpEDCxS5QhlVplpkM2kGJaqKX3AWuQXYNea4TlldQTbSZVzFKCBE1L+9D1UVEc5bcZ+/+By7m9/eSzcybEhQxq/gSY+iH36WAbss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231813; c=relaxed/simple;
	bh=RkzF02Z36CRTUI3s0P999oTTFkNADYZXTw0YeR1dz7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/QGb/EApx8ynhgNdBAQV4N2Rqnrw1b0JiCupdy2XGgwAZolSUk/5dhHvJbciTmkqmWjsLrSmjRXe9K695wSH1WeAxHV+xgvsCEknPSVCZcH6+Q04Ex2p6jAO9PlXCCFQBM/t3vHd/AQIAxsfiZSu0jpITbVrjF2cXUy74EcrqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a14U00Eq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB47C4CEE3;
	Mon, 17 Mar 2025 17:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742231812;
	bh=RkzF02Z36CRTUI3s0P999oTTFkNADYZXTw0YeR1dz7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a14U00EqeHbNfkbAmsUN5/wkFpE544VrdLCgzQZvqaqaCKuaRDCnFa8Zgipu8D+Rp
	 D/6t21f8IqzLNuDDiGA/rUhWMYwcSjGiGPOzlPxOsIbc/ZMTDmkNSgfErVF5S3rcn9
	 ip2GADBLfRaHCkQkN9/eW3RTmxDb13Kfjbi5OUNgmeE3Dszcj6CtQfdha/5c1e7t83
	 OWmzoOjvjrlb7t1OOYjlGfAu4qmf7vRXLryv4WeucuuoA52oEf5UIGSFzhhBr6nTgX
	 vi0B29+dt/LAYvBT8BcOJe+1ax8KPbbR02qH1drRp/ne+l85xuVzlR20TpZryIYwPR
	 2wJZyLm+DiJtg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	florian.fainelli@broadcom.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.10 1/2] net: openvswitch: fix race on port output
Date: Mon, 17 Mar 2025 13:16:50 -0400
Message-Id: <20250317130355-d7cb31444bd62013@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250317154537.3633540-2-florian.fainelli@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
❌ Build failures detected
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 066b86787fa3d97b7aefb5ac0a99a22dad2d15f8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Florian Fainelli<florian.fainelli@broadcom.com>
Commit author: Felix Huettner<felix.huettner@mail.schwarz>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: 644b3051b06b)
5.15.y | Not found

Found fixes commits:
47e55e4b410f openvswitch: fix lockup on tx to unregistering netdev with carrier

Note: The patch differs from the upstream commit:
---
1:  066b86787fa3d ! 1:  8d256ecd249c3 net: openvswitch: fix race on port output
    @@ Metadata
      ## Commit message ##
         net: openvswitch: fix race on port output
     
    +    [ Upstream commit 066b86787fa3d97b7aefb5ac0a99a22dad2d15f8 ]
    +
         assume the following setup on a single machine:
         1. An openvswitch instance with one bridge and default flows
         2. two network namespaces "server" and "client"
    @@ Commit message
         Reviewed-by: Simon Horman <simon.horman@corigine.com>
         Link: https://lore.kernel.org/r/ZC0pBXBAgh7c76CA@kernel-bug-kernel-bug
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Carlos Soto <carlos.soto@broadcom.com>
    +    Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
     
      ## net/core/dev.c ##
     @@ net/core/dev.c: static u16 skb_tx_hash(const struct net_device *dev,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-5.10.y:
    net/core/dev.c: In function 'skb_tx_hash':
    net/core/dev.c:3189:17: error: implicit declaration of function 'DEBUG_NET_WARN_ON_ONCE' [-Werror=implicit-function-declaration]
     3189 |                 DEBUG_NET_WARN_ON_ONCE(qcount == 0);
          |                 ^~~~~~~~~~~~~~~~~~~~~~
    cc1: some warnings being treated as errors
    make[2]: *** [scripts/Makefile.build:286: net/core/dev.o] Error 1
    make[2]: Target '__build' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:503: net/core] Error 2
    In file included from ./include/linux/kernel.h:15,
                     from ./include/linux/list.h:9,
                     from ./include/linux/kobject.h:19,
                     from ./include/linux/of.h:17,
                     from ./include/linux/clk-provider.h:9,
                     from drivers/clk/qcom/clk-rpmh.c:6:
    drivers/clk/qcom/clk-rpmh.c: In function 'clk_rpmh_bcm_send_cmd':
    ./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
       20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
          |                                   ^~
    ./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
       26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
          |                  ^~~~~~~~~~~
    ./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
       36 |         __builtin_choose_expr(__safe_cmp(x, y), \
          |                               ^~~~~~~~~~
    ./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
       45 | #define min(x, y)       __careful_cmp(x, y, <)
          |                         ^~~~~~~~~~~~~
    drivers/clk/qcom/clk-rpmh.c:273:21: note: in expansion of macro 'min'
      273 |         cmd_state = min(cmd_state, BCM_TCS_CMD_VOTE_MASK);
          |                     ^~~
    drivers/firmware/efi/mokvar-table.c: In function 'efi_mokvar_table_init':
    drivers/firmware/efi/mokvar-table.c:107:23: warning: unused variable 'size' [-Wunused-variable]
      107 |         unsigned long size;
          |                       ^~~~
    make[1]: Target '__build' not remade because of errors.
    make: *** [Makefile:1837: net] Error 2
    make: Target '__all' not remade because of errors.

