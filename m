Return-Path: <stable+bounces-235947-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APBTKnGf3GkEUgkAu9opvQ
	(envelope-from <stable+bounces-235947-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:46:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4C93E87A6
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3E11300BBB0
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 07:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DAC39FCDD;
	Mon, 13 Apr 2026 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIXMj2Or";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPCnPm36"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87EA39EF1A
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066330; cv=none; b=ea2NiDzX/BZHhYLFWfK8ab78YdMtcVKLgRd0diHe+cGoOfNx1kFSeVHOv7q5dBfs2Wyw4F6nkaI1PX70SdcwF2lT2gWcadI5hmP+ghHbKGAuRbSdOuzBBJ45qpxnU2V9sbkyOKUYNTUS7qO3M9lz/euTeC/onbLoDaTqwAE74OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066330; c=relaxed/simple;
	bh=H53P5p+OtZnMsl2NEM/Tmrec0LxsCCr0R6/dwJEzMBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8d4F+xNH1UawG/jTcSgBzq10MNxx8/qpeRerUjyqmyXyQ/3TyZeUkXuliBv71LfRnQa8/u2RyvAGEgsss4pNApN5YRm3ibazBfuTfY/v4qr02O0EAztO71d3cyH+FRHXKf/QlAq2ujAYOkLjRvJOqFOwVZfNg54uF9odSc1kr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XIXMj2Or; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPCnPm36; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776066326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ym38mK7swp0+roV86qgOMSC1TWOUqeERTYCRgrFKlvM=;
	b=XIXMj2OrGtHelAcSLE/06SPu90xHoJS7TlSNI5eqjOrz3SySr08f83CBzIz0peYTQ74ML9
	oicj4PqnfQReqFEk7NUKWVHqSNOrnhY+HwUXdWdWqZInFVNVNTRix9aluP86JSyzQkVmoG
	nSOTR7cvlu5pvKg2XojiChNOV8EgwOg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-gHfDVlZYPl6td9wRqxGhUQ-1; Mon, 13 Apr 2026 03:45:25 -0400
X-MC-Unique: gHfDVlZYPl6td9wRqxGhUQ-1
X-Mimecast-MFC-AGG-ID: gHfDVlZYPl6td9wRqxGhUQ_1776066324
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d76eeb303so778531f8f.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 00:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776066324; x=1776671124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ym38mK7swp0+roV86qgOMSC1TWOUqeERTYCRgrFKlvM=;
        b=HPCnPm36150G3qI0cUwtknNqoJoEDCqpuCpYbZ5zM6uVzjZdkrPj5JM594KEAzkcFs
         FgfcnBWckACcZ92UTADQn29mqHdQiEvQaYwFLmLPzQKPOS7oqxTPKsK2/ojmEsC/1YIb
         1APDlRA0Mwxc/ssU11XBvDzr+IBdO6VMNy3L65v1xxReQSAoMGfSFD1uF7wrHbo/06fh
         PfYQj799pcYcYHwhJqsjzBG4G4miAIPMEgxBRSTe8Rmb3tuWAy2YdkFyD2jR6pii1j38
         LtCH3hB9GqjWVbT4+eMwR8qjKCc1//5kYLOSkeMmpOkIkk4asUOOq0nszumzLGpCyqlJ
         khjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066324; x=1776671124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ym38mK7swp0+roV86qgOMSC1TWOUqeERTYCRgrFKlvM=;
        b=FYmf25HZGc0WYFgy4EaW1kjP3rK1HVTkV7feKF6jC0q86HaqDARmxM51cRen+rL2dQ
         XKe7iKwBPWt9qxiaO7PFHN22F0XIR6XvVrNnf8FQjorB4wkSwiP1XXRhqg0ZV3RjAMHe
         u6/ZvXETQnaqQcwmo9jwUU4ChZG1qXn1IM7LHQACVR/5ewn30uILF6PGO5T9dDpAnpqj
         +Brn0YatMkpycgAxLJ18Y5zIT4+24jOi/mc+24tCIT7/iXTQxiDJOib90u6RL4q78mZo
         EHptxhzPSLXgeOoUaOPxo6988mtsRg+jM+aqcByxx1mARprvky6Aae6GVYdd29ENpx/p
         IkJA==
X-Forwarded-Encrypted: i=1; AFNElJ9qLiTw1uolpsjNBJrQGm494jC6WtOf31excRzAl/spYjLJHyzp4TVMQXLBjmbk5dAQi9JCZNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9lEUGKzezAFNdHO4LfT5EHzduLCM+0c+5lP55UwEmQxkDplW6
	/TdMf3oSgQuK8YnVhyOG1Cgrt7/hihLG5rA/t6u7eVvJcvFqBC5Ru18ZfG85c0cbQVEciRbmJm3
	gtwnWtPgm0U0QTNkTDcF0jFXo0sdaD6u3Gj0tdhLHwEYxClf/GncV7fpdUg==
X-Gm-Gg: AeBDiet4EEjrMiak5AJham9oS1H5JsmSVMpNUlkycq0Kd61E5ccVTPLWeL5hh60WMmQ
	shUYPXv6TI7mRQDlvoIKtJyLK0FKpllIMjvsMgWeC82aR3MRgjvqx3iEouMqWxpfOkChTtutBKf
	hoydogewxAXVXyrFSYRwEebUTvVMBfwzYxukuAZ02FVjKWHbGotyFQ8+F2MKVr0l03VfOR+aJo9
	BBgDXD3I/kGSJZ+xUADXaZLuhLZJDmu1qDKX3RHwkqpq4CUl0cLVihn5aPf4l7AvEZs9oSTFufA
	lga2ULhO4joOdImOyfpprTK7bl84y8PiemOv0QeL12+HwSim6zNhRyxjFTyiDxCUffVPS2BqQu6
	JUV5fM0IYv0e2nUeoM+PinBQdPG+QZ6DzpYSdqo2Zwvk=
X-Received: by 2002:a05:600c:8b27:b0:488:b1c7:b432 with SMTP id 5b1f17b1804b1-488d6881e82mr154803805e9.24.1776066324243;
        Mon, 13 Apr 2026 00:45:24 -0700 (PDT)
X-Received: by 2002:a05:600c:8b27:b0:488:b1c7:b432 with SMTP id 5b1f17b1804b1-488d6881e82mr154803455e9.24.1776066323683;
        Mon, 13 Apr 2026 00:45:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm32030537f8f.33.2026.04.13.00.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:45:23 -0700 (PDT)
Date: Mon, 13 Apr 2026 03:45:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] virtio_pci_modern: Use GFP_ATOMIC with spin_lock_irqsave
 held in virtqueue_exec_admin_cmd()
Message-ID: <20260413034046-mutt-send-email-mst@kernel.org>
References: <20260413072249.30433-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413072249.30433-1-guojinhui.liam@bytedance.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235947-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C4C93E87A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 03:22:49PM +0800, Jinhui Guo wrote:
> virtqueue_exec_admin_cmd() holds admin_vq->lock with spin_lock_irqsave(),
> which disables interrupts.  Using GFP_KERNEL inside this critical section
> is unsafe because kmalloc() may sleep, leading to potential deadlocks or
> scheduling violations.
> 
> Switch to GFP_ATOMIC to ensure the allocation is non-blocking.
> 
> Fixes: 4c3b54af907e ("virtio_pci_modern: use completion instead of busy loop to wait on admin cmd result")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> ---
>  drivers/virtio/virtio_pci_modern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 6d8ae2a6a8ca..db8e4f88b749 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -101,7 +101,7 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
>  		return -EIO;
>  
>  	spin_lock_irqsave(&admin_vq->lock, flags);
> -	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
> +	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_ATOMIC);
>  	if (ret < 0) {
>  		if (ret == -ENOSPC) {
>  			spin_unlock_irqrestore(&admin_vq->lock, flags);


GFP_ATOMIC allocations can and will fail. If using them, one must
retry, not just propagate failures.
Or just switch admin_vq->lock to a mutex?


> -- 
> 2.20.1


