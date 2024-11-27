Return-Path: <stable+bounces-95645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F319DABAD
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 17:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E419CB238A5
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 16:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F3120013B;
	Wed, 27 Nov 2024 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3Wh02QS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBD81FE45B
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724407; cv=none; b=Y2pFLtwYKjrt7md07YzUJLfiJEvDElPfXaDf3yTfTyU6lkX1ZDLzZYvcPL8geAaVgx+3GnxQ+Pa4L5Um10NZ0aCppW6ZhseqLUAqAO8MIC+4YIsBgWbI3exO3WQ6D1miQV0Vk9wZka8Xh2i97ZdeAFY8D5kYRDgr4z19Fqws4po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724407; c=relaxed/simple;
	bh=JzeYaGpuCjaSCJSUCHDXiTJk+HnfRjks8VytTguwMNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQuiDcbUQPJ9NaTYXNDOPAtUccnQY0MXDRGepRxmKGICi3hTnfHlTwZVDcqR9R2LDhiKghZgrA57YtGW3dA6ztmMOazG0YhQShhcthjb9scO29SwkLTgRsZGnqwhOVWS/ngMeS4DWnNIkmwZLKZr5ADjjYKi71Qa6VlpMhBgY6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3Wh02QS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51607C4CED2;
	Wed, 27 Nov 2024 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732724406;
	bh=JzeYaGpuCjaSCJSUCHDXiTJk+HnfRjks8VytTguwMNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l3Wh02QSmS8Yjf9A93+zxQFyhJYxujU39c1zRiDO31H6VqoLuyqCu19uZy0QqSZhY
	 oacUz1wdrDF1vK8B3etSS1K+RqLWn2TslNPO3s0j362zj7WSu96QGeOia+a3Wqk4tD
	 W9sJ2petu3G2ACYTVpM22z0RFLwz0W+kOMWndt0fTvn8/Cv9Mv7UfQWt3BHiijhGlf
	 /ZGQNezefwoqoYmOLaRNPvr7B3XWLlLBkbXCXESIVf+I1px6OwwILZws8sD4OGPtR0
	 g7qBr+ifij9U0eHRrw9gOisiEbPGhTL+hFw4KoMBmt4KtStQGik2pX6YEIXnbVzpgR
	 68Bx3pjrH6vHQ==
Date: Wed, 27 Nov 2024 11:20:05 -0500
From: Sasha Levin <sashal@kernel.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Hao Luo <haoluo@google.com>,
	Eduard Zingerman <eddyz87@gmail.com>, Hou Tao <houtao1@huawei.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: Re: [PATCH stable 6.6 0/8] Fix BPF selftests compilation error
Message-ID: <Z0dGtWhX9kdsm2IJ@sashalap>
References: <20241126072137.823699-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241126072137.823699-1-shung-hsi.yu@suse.com>

On Tue, Nov 26, 2024 at 03:21:22PM +0800, Shung-Hsi Yu wrote:
>Currently the BPF selftests in fails to compile (with
>tools/testing/selftests/bpf/vmtest.sh) due to use of test helpers that
>were not backported, namely:

What was the offending backport? It might make more sense to just revert
that.

-- 
Thanks,
Sasha

