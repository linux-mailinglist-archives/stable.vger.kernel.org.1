Return-Path: <stable+bounces-135212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B70A97B71
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 01:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6B33BFBF3
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 23:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03C121C9EF;
	Tue, 22 Apr 2025 23:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ppf2axPe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938FC21C184;
	Tue, 22 Apr 2025 23:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745366345; cv=none; b=rIhkvfgUmbLp6PzddoKWCTGXz3BnW2A5AnDK1kzcEfqPUrz5ncpXkyVQxfF1qNtRFK2oOPQ4poO2VXXftLnn3Gw/9XxrcTBnnzs1HXoU13iFstAPYsFwjOEPMlFSMQ0VsUdhmGO/upZfp7uTzM21sLziFYNb7Y7YJR36DRUB7hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745366345; c=relaxed/simple;
	bh=bcsA74p6mdOia99g9y4yQ41ip3b7W3gbxYlsNHWLkPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FA9b9etZMVhkwJX+iXuK/fvyNvq69m10noBEAQZbNKfpIhAnIv2atdPuTe8LiPmhufxlTg9IgfvjwoWCpYqZOOFMyB1noD07r2aNCS3CoJ5vgVxMJoqV7wzH63M8bbQ6gG1qy+NWjQURIgibVtP4mT9cAi4/W4ohNjHZ836n1oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ppf2axPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95459C4CEEC;
	Tue, 22 Apr 2025 23:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745366345;
	bh=bcsA74p6mdOia99g9y4yQ41ip3b7W3gbxYlsNHWLkPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ppf2axPejByY0HgRXfpMRFFqQXhT3xGxO1tMm5kxBJf4EIeV/vhhh0EVhcqC537qG
	 LVkbc07ZpLRt7iYmMC1wfrsiBuu925UCQM0NGLr14zZVpaLP8apaHeHy8Q8u+hZrUs
	 DYdtBf9KXFj632pgN6IWocCUB/aN3ILysD9+SiUcyWL2MjpxQovqkUSDZrmQC7UGKL
	 ap7NBA/PNxk+ERIDTn+IzOKTfV5q4gzXZ4nRVLX1dmelmKazu5oOBJjpMgHZhUGKfc
	 vYZoCVoEYqppZkoKT7N7vGChxZkXpmKW0aQl71dzep38X9YKjJlJqesAodR8Qjcdsn
	 VXUKQwji/nPqQ==
Date: Tue, 22 Apr 2025 16:59:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, stable@vger.kernel.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net v1 1/1] net: selftests: initialize TCP header and
 skb payload with zero
Message-ID: <20250422165903.5aa81b10@kernel.org>
In-Reply-To: <20250416160125.2914724-1-o.rempel@pengutronix.de>
References: <20250416160125.2914724-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 18:01:25 +0200 Oleksij Rempel wrote:
> Zero-initialize TCP header via memset() to avoid garbage values that
> may affect checksum or behavior during test transmission.
> 
> Also zero-fill allocated payload and padding regions using memset()
> after skb_put(), ensuring deterministic content for all outgoing
> test packets.

This has been applied, thanks!

patchwork-but is down, it seems, and it's out of our control :(

