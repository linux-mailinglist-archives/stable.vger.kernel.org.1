Return-Path: <stable+bounces-40729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090B28AF410
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 18:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE901F2370F
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 16:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE1813FD6D;
	Tue, 23 Apr 2024 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pziB/rfp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F112A13D625
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889579; cv=none; b=P12CxrMr8USGEjeJIKU/pAfaXrN63rQXq3P1yEqkMeAvC3Rb0sXWdtLMbTfFFbQOAr4c7ZJPyv6YmxQGt/Q5R9pXNNfoIAzTgR+dPjv+u3/wQgWW0AJVJD+VtPIMfGaGsXIfXguA8SFeaepAwS1yWBZNcJpeTrj5c9JT7Pp5Uds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889579; c=relaxed/simple;
	bh=3ejCtIa3kS8XdYzjRhvTdcsBZRC1V39ox830V48Crh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poMQI3qcfIOw5WvsONpq+O9UUNZbqJXnjQ6QzuXRhQnA1QttA240d4Qkz9riUN4upA1LoTN4C01RnHe3StR8GdURMV0/2AiEjAf4bJ81Ior1Ioiowg/U24G46NVXU0aGARjTAYRx6WgI6hyOwa2VYNLN+XSggX5Td7cQxZ7odLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pziB/rfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BC0C116B1;
	Tue, 23 Apr 2024 16:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713889578;
	bh=3ejCtIa3kS8XdYzjRhvTdcsBZRC1V39ox830V48Crh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pziB/rfpiWrTaMYc0gCbuiid//2Is/ToQ3GlQATO8aAn282ieVlVzfEgG7nVtFAdh
	 Bn6tKpG+CG70zwPyBw1mZmuCBBZPteqX48GUb8ZyrJtLEVseGdp2KPOGYwTXTMqhsN
	 vrdFbK6azLo0K9ZLp7w2kStPHKxL3M4x1taAYyX4=
Date: Tue, 23 Apr 2024 09:26:09 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: cel@kernel.org
Cc: stable@kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
	stable@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 6.8.y] NFSD: fix endianness issue in nfsd4_encode_fattr4
Message-ID: <2024042351-unfocused-respect-2dd2@gregkh>
References: <2024041908-sandblast-sullen-2eed@gregkh>
 <20240419160315.1835-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419160315.1835-1-cel@kernel.org>

On Fri, Apr 19, 2024 at 12:03:15PM -0400, cel@kernel.org wrote:
> From: Vasily Gorbik <gor@linux.ibm.com>
> 
> [ Upstream commit 862bee84d77fa01cc8929656ae77781abf917863 ]

that commit is in 6.7, so why would we need to add it to 6.8?

confused,

greg k-h

