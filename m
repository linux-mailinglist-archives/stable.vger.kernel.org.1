Return-Path: <stable+bounces-110178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 782C1A193A2
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 15:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771BF3AD377
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BEB213E67;
	Wed, 22 Jan 2025 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBeFTwW2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3CE2135CA
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555386; cv=none; b=uyB3m9tKZHYf6aa9BsIM9yHPu0hS4Gp+LOWdq7fBcdNDSQc1owi1exAv0bKcbeizuDlhO7tcugVZeSZX2WrU0tFLka11EM0RvVXVBpcCLZp3mMKCk3ohtVGYUlQ74kRb72RueK62I/Uwuy0hSrIA0fXl2F3tPyB3ll5lBFPyMeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555386; c=relaxed/simple;
	bh=5CGREItGbE8OAaJTNgyg9O9BorpY3zmGQeRk5d3jaiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qA5EdQraUgUt3PRqRtA2Yvht5grZHgCT3+n8x4hEE/qzs4j0ZAV+p1wLH1Cdv8pDfV/6s/u8MJ1ajo8xdROWkKUCa3oxMpvpTt8tiUfE7eaMsiG3eybnX+aCnaktkO1u/vy+MEGiVdnGHDjDAoANHDU4fmbLJU8Zjfu66k596lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBeFTwW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1748C4CED2;
	Wed, 22 Jan 2025 14:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737555386;
	bh=5CGREItGbE8OAaJTNgyg9O9BorpY3zmGQeRk5d3jaiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lBeFTwW2jXvxq2hq0FIS14NhGDVEX7fpiEKKAnC1dFHpWvK9NtoGrYLBJMayNxiKh
	 CDDi6t4PzgMNwB6Paz3aWbfRXuAV2AGWxKRdggHr6bPTHQxX4exPra/pWebGg2q3l6
	 nOlUGw8dGTu2rcWC/mr59sEYn1iKYIwqrStOijp5xab1Ax2evPb+bXRPNk46fRbb1L
	 4XythBi1J1Dr9GwW2vhKT9ZFGJj+rpf4i41Ws+zmXX3mp0vDXY3KMel1ZG0Y1UkUPk
	 nhnR06D2prAcuRIv3NGF2NyD7EEpIkpx+4kW65pUIkWDFu9ddxd/FFGlXDFi8gBXd/
	 8VF1k/PxaqoTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Denis Arefev <arefev@swemel.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10] serial: imx: Introduce timeout when waiting on transmitter empty
Date: Wed, 22 Jan 2025 09:16:24 -0500
Message-Id: <20250122075707-de20e4a8c2154637@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250122113927.301596-1-arefev@swemel.ru>
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

The upstream commit SHA1 provided is correct: e533e4c62e9993e62e947ae9bbec34e4c7ae81c2

WARNING: Author mismatch between patch and upstream commit:
Backport author: Denis Arefev<arefev@swemel.ru>
Commit author: Esben Haabendal<esben@geanix.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 982ae3376c4c)
6.1.y | Present (different SHA1: 7f9e70c68b7a)
5.15.y | Present (different SHA1: 7f2b9ab6d0b2)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  e533e4c62e999 ! 1:  703b785835e66 serial: imx: Introduce timeout when waiting on transmitter empty
    @@ Metadata
      ## Commit message ##
         serial: imx: Introduce timeout when waiting on transmitter empty
     
    +    commit e533e4c62e9993e62e947ae9bbec34e4c7ae81c2 upstream.
    +
         By waiting at most 1 second for USR2_TXDC to be set, we avoid a potential
         deadlock.
     
    @@ Commit message
         Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
         Link: https://lore.kernel.org/r/919647898c337a46604edcabaf13d42d80c0915d.1712837613.git.esben@geanix.com
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    [Denis: minor fix to resolve merge conflict.]
    +    Signed-off-by: Denis Arefev <arefev@swemel.ru>
     
      ## drivers/tty/serial/imx.c ##
     @@
    - #include <linux/slab.h>
      #include <linux/of.h>
    + #include <linux/of_device.h>
      #include <linux/io.h>
     +#include <linux/iopoll.h>
      #include <linux/dma-mapping.h>
      
      #include <asm/irq.h>
     @@ drivers/tty/serial/imx.c: imx_uart_console_write(struct console *co, const char *s, unsigned int count)
    + {
      	struct imx_port *sport = imx_uart_ports[co->index];
      	struct imx_port_ucrs old_ucr;
    - 	unsigned long flags;
     -	unsigned int ucr1;
    +-	unsigned long flags = 0;
    ++	unsigned long flags;
     +	unsigned int ucr1, usr2;
      	int locked = 1;
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

