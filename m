Return-Path: <stable+bounces-100474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0922B9EBA14
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 20:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E34188870F
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 19:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A14722617A;
	Tue, 10 Dec 2024 19:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYh1QdWn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE296226169
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 19:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858696; cv=none; b=T0UHeD1Rak764cPesBgNHdfgAkM/5I1v2Xw3QGbR2+j6FIPX78XdrtsfdBEBFpCJB4Vo8//2N5skTQF5ieozAJMQnVUJJveRHadPJg8rC+yoDgxbwzz20dK2zE84NuJtix/BamDcLoPRmqr4nZhNF17gL2YEj3YJoncVvSV/5Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858696; c=relaxed/simple;
	bh=RM5zVN9U4YwVyCmZDcnevfZ6H2WF2ieuf1gsgGlFhLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HR3KDM5TRMwdfPrAiCdGoVureaHNRiWdOvlMWmWgbQyN1Mi6LfH8hpJp8sO0yIhwW9CeUquIx4gh1/ofolJLn6oUU6NxytmS0i5WjkZ6nc2gqSG1nLSYyikfTdb1vHYnTz4ewVVJjFvt912ikW2kNfAWAjKuoZLrtYGrE/D0owE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYh1QdWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195A7C4CED6;
	Tue, 10 Dec 2024 19:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858695;
	bh=RM5zVN9U4YwVyCmZDcnevfZ6H2WF2ieuf1gsgGlFhLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pYh1QdWnXCxz6gQWg+4aBQ+tjM3G0Pn8Q1YieIlehwesm0aMroCyk9lBH5t5Afgpf
	 v9VMMr1shVgGMeD88ATcoI9HjszTk2gxtqodqqeCvLbzLalbwIOoDqDxvA4CTC1opZ
	 a/zJfqgsBFta3XjOl/98x20iEkUY5d28BPEIMse4RScpdq7qmYa2z3bcHId8lFAx6c
	 wNJE+nTC8HqcVB9Q+6Pm2GdYeupVpn+XsMOin7E9TCVrOYzh+4Up0qIwJFz4Ma3fM8
	 Ag1GjvRcyZysDcsgUQtWwWM+rtX1J7OLbxA/TiFrScDj+o06DYssF9KXqCPbTpfyKk
	 GUvGKTR5zZUFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: libo.chen.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] fou: remove warn in gue_gro_receive on unsupported protocol
Date: Tue, 10 Dec 2024 14:24:53 -0500
Message-ID: <20241210093903-480486a2590ab12d@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241210062550.1341881-1-libo.chen.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: dd89a81d850fa9a65f67b4527c0e420d15bf836c

WARNING: Author mismatch between patch and upstream commit:
Backport author: libo.chen.cn@windriver.com
Commit author: Willem de Bruijn <willemb@google.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 3db4395332e7)
6.1.y | Present (different SHA1: 5a2e37bc648a)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  dd89a81d850fa ! 1:  9e6170db49f05 fou: remove warn in gue_gro_receive on unsupported protocol
    @@ Metadata
      ## Commit message ##
         fou: remove warn in gue_gro_receive on unsupported protocol
     
    +    [ Upstream commit dd89a81d850fa9a65f67b4527c0e420d15bf836c ]
    +
         Drop the WARN_ON_ONCE inn gue_gro_receive if the encapsulated type is
         not known or does not have a GRO handler.
     
    @@ Commit message
         Reviewed-by: Eric Dumazet <edumazet@google.com>
         Link: https://lore.kernel.org/r/20240614122552.1649044-1-willemdebruijn.kernel@gmail.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Libo Chen <libo.chen.cn@windriver.com>
     
    - ## net/ipv4/fou_core.c ##
    -@@ net/ipv4/fou_core.c: static struct sk_buff *gue_gro_receive(struct sock *sk,
    + ## net/ipv4/fou.c ##
    +@@ net/ipv4/fou.c: static struct sk_buff *gue_gro_receive(struct sock *sk,
      
      	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
      	ops = rcu_dereference(offloads[proto]);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

