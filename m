Return-Path: <stable+bounces-110412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BA0A1BCFA
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 20:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032DD3A730A
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 19:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A009219A74;
	Fri, 24 Jan 2025 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYCS/jTj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2E84A1D
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737748317; cv=none; b=UtuVP+RM2XMexM8hR5PO8kOu3CDPCza0pz/8IvNT79X99vAwioovvfgGNgUzSGQGevZ9Jewrd6Kji3WT75/Jwkrrd0D2zkmTm+qowUVjHPz/Fw4uwz3AmNcsdpkG4y0cX5AzqirZ5rNrM7ZiutSqplddSovn7eVjQPcAHWyv7/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737748317; c=relaxed/simple;
	bh=5tms3yRuJYZgweKN7SGT0puqLVF6eunao2IRzOAiZHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m+8EAWrB1G+v9YBk6pSwg0zsPZ3cTCdSYtKPbup2tsFShf9bGgBuqgR2YwU0Lxlw2kGeMoa0i+dOB/jggZCFWbCWmuYkd8YGhuyKSDoYEdvafVRMsrZLjjxJoNootMsehFoQA7ovpb4vNmoAeMFuCcPee+PawtlZrfkL92Sexro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYCS/jTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD311C4CED2;
	Fri, 24 Jan 2025 19:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737748317;
	bh=5tms3yRuJYZgweKN7SGT0puqLVF6eunao2IRzOAiZHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dYCS/jTjhO6TL4zcJcYzUK6TSomHG1cYlu5bJddwyjvojxvZY88UNV5h3V2KsYT6m
	 T38LzdXbT+1wYSi7BnqK2uw9yn/3l8+aVZg7m55VzSTAEmCyhwwfrKZRA7gKO7IHCR
	 WaGwDBa3Z8P/IYPg6Q6CPbPORSfG5oPpnhMDXv+QpkOSP164HgraElxnDH7qa5iux6
	 igJOUs/BYS7oxePYYkuF2XKl/ECLGFXSaorfErhkC3S0wwG4jMeORA0QeYUZrQ4pRS
	 cZjxPnd/h/nWIN5OOQD+DFuo24zh+C2UHrpdeyjmKYZWuOwKaOsYJlQKMzy3KElFL0
	 EXAo0pmj4XulA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Keerthana K <keerthana.kalyanasundaram@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 v5.10.y] Bluetooth: RFCOMM: Fix not validating setsockopt user input
Date: Fri, 24 Jan 2025 14:51:55 -0500
Message-Id: <20250124100422-5f1abbf1f96313e4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250124072047.5320-1-keerthana.kalyanasundaram@broadcom.com>
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

The upstream commit SHA1 provided is correct: a97de7bff13b1cc825c1b1344eaed8d6c2d3e695

WARNING: Author mismatch between patch and upstream commit:
Backport author: Keerthana K<keerthana.kalyanasundaram@broadcom.com>
Commit author: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 4ea65e2095e9)
6.1.y | Present (different SHA1: eea40d33bf93)
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a97de7bff13b1 ! 1:  84bdcbff6c20c Bluetooth: RFCOMM: Fix not validating setsockopt user input
    @@ Metadata
      ## Commit message ##
         Bluetooth: RFCOMM: Fix not validating setsockopt user input
     
    +    [ Upstream commit a97de7bff13b1cc825c1b1344eaed8d6c2d3e695 ]
    +
         syzbot reported rfcomm_sock_setsockopt_old() is copying data without
         checking user input length.
     
    @@ Commit message
         Reported-by: syzbot <syzkaller@googlegroups.com>
         Signed-off-by: Eric Dumazet <edumazet@google.com>
         Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    [Keerthana: No changes from v1
    +                link to v1:
    +                https://lore.kernel.org/stable/2025012010-manager-dreamlike-b5c1@gregkh/]
    +    Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
     
      ## net/bluetooth/rfcomm/sock.c ##
     @@ net/bluetooth/rfcomm/sock.c: static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

