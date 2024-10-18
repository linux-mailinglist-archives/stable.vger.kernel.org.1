Return-Path: <stable+bounces-86817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 236A19A3BC7
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 12:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FCD1C23B87
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 10:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E9520126E;
	Fri, 18 Oct 2024 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pwCw9MD2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316502022CB;
	Fri, 18 Oct 2024 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248113; cv=none; b=HKYhwFVbTOGcVn5Dh6TaeibBzgjYWRJBfNFm2rtK6GLFNC/36gWA+dY4AacJnSwQs5L6ptnjCRz9q0CgpbqkoiE5PJ4IFLrNlWaduwHpk1xQg1FbrI+wwmfiUnefQwRAaqNrV0y2LbL+/dnj3YtIVEaV5VIcudKyxUo7eujbooE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248113; c=relaxed/simple;
	bh=sr/BqtxMCR11V6SjYSbSySGb/n4Fu150mjsfTGBju+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GG3cY1/3o/MtLk421NcjhD5kqzPTXfCX07dA53W3JgzPQc5uenCTR/2/sm0B1fiCd2I3v9iznMuJz/ONL3J6YGDZDmnbvQkmEDdsSi9luvj+qhNOov1zqCWac1lKCiO91WEJQ6ib5cj70klVBhb1KVXV14m1i9vjXODwF9td4kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pwCw9MD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A756BC4CED1;
	Fri, 18 Oct 2024 10:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729248113;
	bh=sr/BqtxMCR11V6SjYSbSySGb/n4Fu150mjsfTGBju+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pwCw9MD2EC1AqclQNxxO3IMXVp5XcwrZ6DyGrbetsi6LJOp+zdNd3XEdCFtVPCI/I
	 EXqrlRaKHjvAwy1UjOzKKsRaR8H1p+OGb7ru1u2cAzAam1wkcVQ6QJMQG1gRkJBvLp
	 0aT8qN1YcnpA2oNOlRMYjGfc6jr/bRmMSGc6KxYY=
Date: Fri, 18 Oct 2024 12:41:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com,
	Cong Wang <cong.wang@bytedance.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.11.y] mptcp: prevent MPC handshake on port-based signal
 endpoints
Message-ID: <2024101822-oxidizing-remover-3040@gregkh>
References: <2024101809-refinish-concave-f892@gregkh>
 <20241018103356.2167155-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018103356.2167155-2-matttbe@kernel.org>

On Fri, Oct 18, 2024 at 12:33:57PM +0200, Matthieu Baerts (NGI0) wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> commit 3d041393ea8c815f773020fb4a995331a69c0139 upstream.

Now queued up to 6.6.y and 6.11.y, thanks.

greg k-h

