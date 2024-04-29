Return-Path: <stable+bounces-41725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924F08B5A22
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 15:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D2928462C
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0660D6EB44;
	Mon, 29 Apr 2024 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="chOAApEZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84F66BB28;
	Mon, 29 Apr 2024 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397630; cv=none; b=kytyUP+Hi1aV2JE79Ksl+4Ad2LHToEwAP/bOVjL9SHzywFjMK/yS0VayO5qYj8nX+UGzJoPPpvHvseFQs6qyuSEnDJyvtUa0FgDHAxPNFhm4qGKdZimcoIMfJ69DefFr8CPpRmJx99PFc057AjA9fKxmUPYKkkjczW08rr3LboA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397630; c=relaxed/simple;
	bh=dUUSNx3XxI/D2q2USJxLKmZslgo7OGYST793aounOCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyhhfD91YfztYuKSPQh6ciqC8mr60CuOuDWNMhkNgshFZkA/ks5qUs5ly0pPKXBcItv6tuStFMdaaArHv0cyehXck5afWSNC7REP3O8zCfT82Qybp7VyO+1I2itxYdZ7JfonS6RZxHUvlqb6Es/1f9s2AgYkxEl1DHRMJZ3/LGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=chOAApEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC212C113CD;
	Mon, 29 Apr 2024 13:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714397630;
	bh=dUUSNx3XxI/D2q2USJxLKmZslgo7OGYST793aounOCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=chOAApEZ79uR4pr3c8cEf5nq6WAvuAfP/sWielVmgADJU5UgTEePBqEWW65bUGJnt
	 FnfKdHxXNLKKGDbLZ3TDUEqSZkLOjsJy/Bj55RW7U7eElkJBAywgVm87U7FvFdIyWk
	 5j2IrcvVU+Gsnj9uX1HqgGgdJMFJogEU3c8Oqvt8=
Date: Mon, 29 Apr 2024 15:33:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: shaozhengchao <shaozhengchao@huawei.com>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, kuba@kernel.org,
	edumazet@google.com, kuniyu@amazon.com, weiyongjun1@huawei.com,
	yuehaibing@huawei.com
Subject: Re: [PATCH stable,5.10 0/2] introduce stop timer to solve the
 problem of CVE-2024-26865
Message-ID: <2024042938-overload-granola-24eb@gregkh>
References: <20240428034948.3186333-1-shaozhengchao@huawei.com>
 <2024042934-dreadful-litigate-9064@gregkh>
 <ee497098-6a14-f833-3c6f-a8b31259ad36@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee497098-6a14-f833-3c6f-a8b31259ad36@huawei.com>

On Mon, Apr 29, 2024 at 08:01:44PM +0800, shaozhengchao wrote:
> 
> Hi Greg KH:
>   Thanks for the heads-up. I will work for 5.15.y and 4.19.y.

Thanks for all of the backports, all now queued up.

greg k-h

