Return-Path: <stable+bounces-199950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5E8CA2099
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 01:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59C903010E44
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 00:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78E818871F;
	Thu,  4 Dec 2025 00:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YncNwaY2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90032398F8E;
	Thu,  4 Dec 2025 00:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764807921; cv=none; b=m3Bqiu7SX8Jzf1VUuCZYkZMBbBRTLkfg5cIId0Wbh7cC9PfXVuS1MnH0Z9Ba4FwAssFiL6O9+b5CjeQX++PWkbYPWgoNYMOAtmCL9F+fDZ6zECzrWfJ32vKMk4uXySAEpyF9N/LYBaB3Q2RbDPQRxp62T6m4lz8OdFiPTxPmvAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764807921; c=relaxed/simple;
	bh=eBv2KLILAAwrsekBAwnhrnIS3X/u71HS4CiL3wf36u8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gqV5W6uM5pII4ud0UrDYDuVYq7mBbqc8TS8IoqByjl4zJ9OpkoJo3sDfF+k8kHTJBEZxzNYg8ZCNiVk6CUQU+Cq7YUW9IQOUYf40T7pLbAb/1Ypa5nt3A4r65hptXj0Qr0fS2J7fbhB1fAQxBDD2SanhHiqHxF4GXDhZLIhgxnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YncNwaY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5428C4CEF5;
	Thu,  4 Dec 2025 00:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764807921;
	bh=eBv2KLILAAwrsekBAwnhrnIS3X/u71HS4CiL3wf36u8=;
	h=Date:From:To:Cc:Subject:From;
	b=YncNwaY2HWeKWEtFNeLkcvnNju7vECirG0PodmEOnWdHwGs7cq/U67M+shVS13dY8
	 vzDJRiv+RBYtMc9UFiojTU4OrPGH+uAKgyfWgD7vVw7sr8UcEtEKPmq480UvSrCV/c
	 P3XQMC10FEFz44escQ3nNnkyv7mNfI1J2Yt1Lanm53x5dLJQrvXEno0pCmYLZzKyeP
	 PWN4PPxW4XwTtnPlnF9L6HGgzzS0rVyk4sdGX3zJQcokvfxSjvN0dS3x1dgsYHNXLm
	 VRmDD2i3rO5EndRI+fqW7AvadlN8z1RnFHzrQCJSZeZgDPfw2XknV7peUOgqtJdycd
	 qFa02RZ/8vspw==
Date: Wed, 3 Dec 2025 17:25:17 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Please apply 5b1e38c0792cc7a44997328de37d393f81b2501a to 5.15
Message-ID: <20251204002517.GC468348@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi stable folks,

Please apply commit 5b1e38c0792c ("dpaa2-mac: bail if the dpmacs fwnode
is not found") to 5.15, where it addresses an instance of
-Wsometimes-uninitialized with clang-21 and newer, introduced by commit
3264f599c1a8 ("net: dpaa2-mac: Add ACPI support for DPAA2 MAC driver")
in 5.14.

  drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c:54:13: error: variable 'parent' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
     54 |         } else if (is_acpi_node(fwnode)) {
        |                    ^~~~~~~~~~~~~~~~~~~~
  drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c:58:29: note: uninitialized use occurs here
     58 |         fwnode_for_each_child_node(parent, child) {
        |                                    ^~~~~~
  drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c:54:9: note: remove the 'if' if its condition is always true
     54 |         } else if (is_acpi_node(fwnode)) {
        |                ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c:43:39: note: initialize the variable 'parent' to silence this warning
     43 |         struct fwnode_handle *fwnode, *parent, *child  = NULL;
        |                                              ^
        |                                               = NULL

It applies and builds cleanly for me. If there are any issues, please
let me know.

Cheers,
Nathan

