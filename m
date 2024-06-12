Return-Path: <stable+bounces-50263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 109C8905409
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 15:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB14E1F25A97
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 13:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C61917B511;
	Wed, 12 Jun 2024 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vgUEscgX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E039F1E504
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199899; cv=none; b=Ksg/EwJKFOHkMKrZwcU3wK/4yEbbwyDwcjP81/SW7yoXHBPxrhCA0c8ZWvnCOrdY3wP0G+cgVTxKr3gaK4utKCyH01+eUYNE91ErJdi/QAg6vXpYdtNKlvvxUhAFVM2twrEhNIIo/PZXC2IivyFY1gyEAsf3zQUgxr5PSGiZkTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199899; c=relaxed/simple;
	bh=+HW3jc2xtDD+v7KNX2M9eIcbVoYdAoqA2OoDTxaUdNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0oaVNmRq58wzqSFgbH/UtpBiTE8dixzQRorkO3tzSBjtr2+XKP2Lr42rlbNkKijraVz5OxC6AU5ud1U46MX79sLD04oEbkQV9Foe5inuMYew+O1bQp137MhC0ByEa+c85R1XpKmd0rpNYGconiazzPB73/Dmcf1mRlh+Wr+CSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vgUEscgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4BCC116B1;
	Wed, 12 Jun 2024 13:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718199898;
	bh=+HW3jc2xtDD+v7KNX2M9eIcbVoYdAoqA2OoDTxaUdNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vgUEscgXpAANc0M1uhFe4hhwLYEgKU9dMQoLvrOfvIKaFEPZScddoSWhmCsTzR5iO
	 VcGudFKzGSUfEtzGmwRk6kaCQtxAj5gDPx02oPR4cMG+mRg21lsAPM4NCtFUQaWSMU
	 5g1eyan8xHD4aL6qedyifXIRlBgpadAaOQCQvGk8=
Date: Wed, 12 Jun 2024 15:44:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y 0/4] Fix missing net_helper.sh for
 net/udpgro_fwd.sh test
Message-ID: <2024061247-caboose-rover-49f6@gregkh>
References: <20240529151603.204106-1-po-hsu.lin@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529151603.204106-1-po-hsu.lin@canonical.com>

On Wed, May 29, 2024 at 11:15:59PM +0800, Po-Hsu Lin wrote:
> Since upstream commit 4acffb66 "selftests: net: explicitly wait for
> listener ready", the net_helper.sh from commit 3bdd9fd2 "selftests/net:
> synchronize udpgro tests' tx and rx connection" will be needed.
> 
> Otherwise selftests/net/udpgro_fwd.sh will complain about:
> $ sudo ./udpgro_fwd.sh
> ./udpgro_fwd.sh: line 4: net_helper.sh: No such file or directory
> IPv4
> No GRO   ./udpgro_fwd.sh: line 134: wait_local_port_listen: command not found
> 
> Patch "selftests/net: synchronize udpgro tests' tx and rx connection" adds
> the missing net_helper.sh. Context adjustment is needed for applying this
> patch, as the BPF_FILE is different in 6.6.y
> 
> Patch "selftests: net: Remove executable bits from library scripts" fixes
> the script permission.
> 
> Patch "selftests: net: included needed helper in the install targets" and
> "selftests: net: List helper scripts in TEST_FILES Makefile variable" will
> add this helper to the Makefile and fix the installation, lib.sh needs to
> be ignored for them.

All now queued up, thanks.

greg k-h

