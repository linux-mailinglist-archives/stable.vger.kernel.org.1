Return-Path: <stable+bounces-6886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A00815BE4
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 22:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2644F1C210ED
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 21:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD44035291;
	Sat, 16 Dec 2023 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="incfyYvY"
X-Original-To: stable@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFAE3527A
	for <stable@vger.kernel.org>; Sat, 16 Dec 2023 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id B59B2240027
	for <stable@vger.kernel.org>; Sat, 16 Dec 2023 22:33:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1702762433; bh=TK1RY3lKhSz86ZmHPODSvQ3+ZlCBKcuzeEmTIxeoyOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:
	 Content-Transfer-Encoding:From;
	b=incfyYvYpUmEwqHErAXXE2WKTluFLHzXi37rqJuyVPAgUCqqyG8rBDLsQOsYtN0+8
	 KNAxI6pyY4LZtDBgYzvOSe/j7C7X13fNYbo/YT4Hkz9toFA0V2AX93VyOR5E1OWfpI
	 ctI1AVoVpnC7sXr34hMwi3/edFsbpoWmQ42lGVKwZwo2DBmg5er13PTQ7VcWWrqoLR
	 CBVrNmhg7IyMcRr1imNMo37yanRap7XAw3J+FXJLIiD1eHz+7ACFt4MRy3v8vgmvKe
	 qHNj9LTveF8QWAuwn0HKyXcLighSbAYwY4K69loSSqEQTFDrCqfDJ7Q/gJhfY5ZjKX
	 tNKEIOtkQLxiA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4SszqM6Sjfz9rxB;
	Sat, 16 Dec 2023 22:33:51 +0100 (CET)
Message-ID: <bfe2af35-b057-4335-ade9-8b8cf4d9532b@posteo.net>
Date: Sat, 16 Dec 2023 21:33:50 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Patch "nvme-auth: unlock mutex in one place only" has been added
 to the 6.1-stable tree
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
 stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20231216210540.1038298-1-sashal@kernel.org>
From: Mark O'Donovan <shiftee@posteo.net>
In-Reply-To: <20231216210540.1038298-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This is wrong. This patch should not be applied to 6.1

Mark

On 16/12/2023 21:05, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>      nvme-auth: unlock mutex in one place only
> 
> to the 6.1-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       nvme-auth-unlock-mutex-in-one-place-only.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit e85d53548a98fef7933fc10ff03f588037cafaf9
> Author: Mark O'Donovan <shiftee@posteo.net>
> Date:   Wed Oct 11 08:45:11 2023 +0000
> 
>      nvme-auth: unlock mutex in one place only
>      
>      [ Upstream commit 616add70bfdc0274a253e84fc78155c27aacde91 ]
>      
>      Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
>      Reviewed-by: Christoph Hellwig <hch@lst.de>
>      Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>      Reviewed-by: Hannes Reinecke <hare@suse.de>
>      Signed-off-by: Keith Busch <kbusch@kernel.org>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 9dfd3d0293054..7c9dfb420c464 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -758,6 +758,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
>   	dev_dbg(ctrl->device, "%s: qid %d host response\n",
>   		__func__, chap->qid);
>   	ret = nvme_auth_dhchap_setup_host_response(ctrl, chap);
> +	mutex_unlock(&ctrl->dhchap_auth_mutex);
>   	if (ret) {
>   		chap->error = ret;
>   		goto fail2;

