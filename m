Return-Path: <stable+bounces-152656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E404ADA1DA
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 15:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718453AAB21
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 13:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC082686B7;
	Sun, 15 Jun 2025 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="LG8hnePZ"
X-Original-To: stable@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5119E269D09;
	Sun, 15 Jun 2025 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749993122; cv=none; b=h1ZcoQrVC2OKxS+mgcJV9BxGlnZ4T3XuB0DUBdtxSu+4/RZHQue5ymy6P3gtY9PLJFlWAeM4ryP6SdZ4L1r3C6t07NrruMQjeofmSUh/YHMRjxV05JCOWHK11EJR0k5X2n6Pxn5YDQ4/lNCFzZFHKLQkoSf3MSEvRB9bq0wFvvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749993122; c=relaxed/simple;
	bh=023GetsZf6cscG+JXHsOKyT+IWkQr/tiLPjsDQ0j7Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOPj23RTJ/1SOUo/ZY1BmmJeYA1OMKaQLug469lnR6sPsXmIUbz/bI0b+h1NLRB143wszOIQ1qvHJ1KMJ0/Jn3Yjgh2HjxeA64WbVH5mHovje2yH4nn02qp1hHZvuyAEfKkEK6ZPPRE2q2HdIeZ7mrJSwOQx9f7Kis/tq+OMTt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=LG8hnePZ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=5NsAEliAOkHs9GaOA5Vxw5jIu5Gqh2aTb6SxEvRRyT0=; b=LG8hnePZ/7qNT4S3
	0Qa2lfe6q6oUVCXs+Gn+bPNYv3F+EI3Q+aLbyu85TCvjDqh1iFDyM6ZO3HJNxqccCM9CRi4SpNlJf
	bLD7FFWL0zW0/O9PvZcEWE8E9/XXl8KJCZ7vgjoQ9FCIn8OF+g85DnaxkPbalmIw1xBS2MF6mbxqw
	isF9zNaALVFT/3+FCqkkQGJMGBB+ziKDevpl7b2Xu97bv0rpckSMsZTNDcddxttnW9q2NX8nO+6Gl
	EtOPn+S7FqDxKL6Cz34yJChwT6Vuh6Ny4143ekrjgqWZChF+W02/ZkW4kHDKVf178PevW8mFq98/v
	QIBMZFVeyDnKPlKkhA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1uQn9S-009hzb-27;
	Sun, 15 Jun 2025 13:11:58 +0000
Date: Sun, 15 Jun 2025 13:11:58 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: Patch "Bluetooth: MGMT: Remove unused mgmt_pending_find_data"
 has been added to the 6.6-stable tree
Message-ID: <aE7GnlRptm8hKcSa@gallifrey>
References: <20250615130736.1084177-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250615130736.1084177-1-sashal@kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 13:11:27 up 48 days, 21:25,  1 user,  load average: 0.07, 0.02, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Sasha Levin (sashal@kernel.org) wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     Bluetooth: MGMT: Remove unused mgmt_pending_find_data
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      bluetooth-mgmt-remove-unused-mgmt_pending_find_data.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

<rewinds, copies same message I did for 6.12 - please take this to mean all of them>

It's a cleanup only, so I wouldn't backport it unless it makes backporting
a useful patch easier.

Dave

> 
> 
> 
> commit af31788b431f56d9b304d32701f1f9143aae8f95
> Author: Dr. David Alan Gilbert <linux@treblig.org>
> Date:   Mon Jan 27 21:37:15 2025 +0000
> 
>     Bluetooth: MGMT: Remove unused mgmt_pending_find_data
>     
>     [ Upstream commit 276af34d82f13bda0b2a4d9786c90b8bbf1cd064 ]
>     
>     mgmt_pending_find_data() last use was removed in 2021 by
>     commit 5a7501374664 ("Bluetooth: hci_sync: Convert MGMT_OP_GET_CLOCK_INFO")
>     
>     Remove it.
>     
>     Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>     Reviewed-by: Simon Horman <horms@kernel.org>
>     Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>     Stable-dep-of: 6fe26f694c82 ("Bluetooth: MGMT: Protect mgmt_pending list with its own lock")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
> index 17e32605d9b00..dba6a0d66500f 100644
> --- a/net/bluetooth/mgmt_util.c
> +++ b/net/bluetooth/mgmt_util.c
> @@ -229,23 +229,6 @@ struct mgmt_pending_cmd *mgmt_pending_find(unsigned short channel, u16 opcode,
>  	return NULL;
>  }
>  
> -struct mgmt_pending_cmd *mgmt_pending_find_data(unsigned short channel,
> -						u16 opcode,
> -						struct hci_dev *hdev,
> -						const void *data)
> -{
> -	struct mgmt_pending_cmd *cmd;
> -
> -	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
> -		if (cmd->user_data != data)
> -			continue;
> -		if (cmd->opcode == opcode)
> -			return cmd;
> -	}
> -
> -	return NULL;
> -}
> -
>  void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
>  			  void (*cb)(struct mgmt_pending_cmd *cmd, void *data),
>  			  void *data)
> diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
> index bdf978605d5a8..f2ba994ab1d84 100644
> --- a/net/bluetooth/mgmt_util.h
> +++ b/net/bluetooth/mgmt_util.h
> @@ -54,10 +54,6 @@ int mgmt_cmd_complete(struct sock *sk, u16 index, u16 cmd, u8 status,
>  
>  struct mgmt_pending_cmd *mgmt_pending_find(unsigned short channel, u16 opcode,
>  					   struct hci_dev *hdev);
> -struct mgmt_pending_cmd *mgmt_pending_find_data(unsigned short channel,
> -						u16 opcode,
> -						struct hci_dev *hdev,
> -						const void *data);
>  void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
>  			  void (*cb)(struct mgmt_pending_cmd *cmd, void *data),
>  			  void *data);
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

