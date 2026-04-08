Return-Path: <stable+bounces-233946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMglF0KI1mmwFwgAu9opvQ
	(envelope-from <stable+bounces-233946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:54:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB213BF257
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20ACD3018BCD
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 16:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4293D3B3C11;
	Wed,  8 Apr 2026 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3jALH9s"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1882EF67A
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667063; cv=pass; b=Dd6anR0xcnWjFkd3otEYTVh7Q0k6h9UGBQWiwhnfbsScT05xHnEhU8LD43mwp4P+oFH7Etf9oiuGgsibSjwxJqCWfLVwfSWvuJtGhhtl3YfQLvIqGgLtPH8xUX7ogvcUhfuBajIUtJmXlyHJk31xYQEV5BeSXbZUOxcH9bwxkYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667063; c=relaxed/simple;
	bh=24YOzpmRyEHvEjJkSZJnP7gK2BXp91kfqUTaRLDAcag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrhsbLRXMqSPMQA23tRju1JPORRUwFnhaZ/FLnqVC+tsb2VRzl3zpv8nQHwg2KBPsZa4qZxiA7nYZSQvnKiLBH3vRyw+upUCUR+hBkS3K89eLGwhsCkiCyTRIQrkckSV/JeQLbhzeb/x82EUs9ED8PPuRVel//ARY/vtQI0nwhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3jALH9s; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488afb0427eso468295e9.1
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 09:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775667060; cv=none;
        d=google.com; s=arc-20240605;
        b=iZ2V0bCHw8yJqtYR6mIY3a57um2y3I6ydz0UU6lst6nJhDofckiyaZyc8H2zc6SkNs
         EEQDujFjI1rA/QyrRWWF9EnBLGvjkkzyPEyHzAnsd/jhuSN47utGu964WTibipgGOtEm
         rg80C+r6PS4YqOgv+5PO8HqJ72jJYNBmBz/o8hqulqg607YbYHbUaJObh8UAGIdIvuOw
         4VHe+RnjRl7zZGTJ/OUUc/2IFphjL5cZp/Dwc/HT0x5+ZKaEUUfRqlfGdjwyZZEeAawM
         r3xGuepkQDcwd6Hu6KIGt94CzitA/z6pgt/r2Xpb71nWHpHdBLWwh2ZRO7xroL5m9i/1
         JJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HuGzISQhn4e8gmKsfNeQIVwGu7MLjzqdvdYg7l0TjlM=;
        fh=MY0n1nJmHLRf/H5Nzzy//SBp6kLPu1Z2eFbEF73amvQ=;
        b=Z4dEiw/wT24eiFDaErtHjHB0kqZzf8U7d0jtIB7JAAYm8mT+g5utyV35YycVBxyoq0
         xzLBmnXG9/J/2TEl/vA07jnxP6cta1JC79+G6yqP9avptCTovGr6bvKF7Ed7dx1Myj0+
         94XHkr4ateClMygwodOdKFQ3QhLwdIHh2EMgMZmHdzvSe2ENIUXJSS4frtCUmUNkPEmi
         FtYmx3gIHDGKo5DpK76e7kK/cnxReYYYmA0wIZGNmWqfLKp/598+vrbwhHMT5t9p6PMD
         7CC0cZO5yExb4jzWBzY9fo8n7TXgmoIlmC1NE7b6xvuEHIVI7ISUz5qQk/J026Ps/MPw
         ka8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775667060; x=1776271860; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HuGzISQhn4e8gmKsfNeQIVwGu7MLjzqdvdYg7l0TjlM=;
        b=F3jALH9s+z+lKZD/1WjtJJWs5RtiBJFWOQ3f1IVIJBPbd3lOVnuQ1zi8mv4L6hRCiK
         Gwx601AOpd72vzxFIGAIbQStD1imhMP3BCpjzcbvcA7EoZgBRJB2DLntTUMNOgXtAaf/
         J3iIAKyKkFBiPPH7DETfquUgbW+cB4+3AYW65PtjCqE1ZJn2lPDMg2wbQDgQEA/DRnZn
         zczaWXSohExfOC+mN9kw6ynYAL0a0hjhWkihZBbT2O1dEMGrtHUBjwc5eWQf4oaEMPRp
         tJ6BabRPL7atQrK2zeP8l5BOhLI06rRN5tR8uFK0NvUEPC7KSe6N8QsCjjApELtR5HiJ
         NFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775667060; x=1776271860;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuGzISQhn4e8gmKsfNeQIVwGu7MLjzqdvdYg7l0TjlM=;
        b=j2c/qWcZwKh7q8rEue4chZ+e6DA3x1R3jPvNGCFA5wSMOc4M9d8UpbAcdS7M8r2aFV
         luwbuaM+/JVH60ITN6YyJuK1sPZIV+/gsMOVqVbrIExQsXv8RxAGGLwpkSuZz+FCgz6k
         WvhFdpptTLtFaumBiLtoLxag+dUSZPYTvplDBH5zQuWe+aZvskrxBlxaADBvLs2Nx7ty
         FG6W5moEWIkdy8R3oeBi+M4FlDWdl/NluAydz/C82fYYQmt1wC4cX8oToeUbXM2ECKff
         igKZ3qfO7EQ7uoNXgFdQH+jzKxpIOW5permDrf7SRWaU7OW19jQkbW4Hc8hhx+eh3y+E
         okwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUpgO9py0zrbekCjeYOV54DWMtfoz/XTG+2Wd6BTYkPvu4Mg2rN3n/sw5ZBjHMbHFhn0fWBe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHe37N4wzCOqF6Ds+PB+sjUEuyf0DCkstTizREHajwhOIYglAc
	XBOcHNjGLlBp4jW7ADSlpSV7Bxo/NDMfZmdMITdJXEGM8fftBI70GyMCScP2z8HeFHeQ99lam0M
	zXXECUVHdTaAbxWpTC1Ub68uCJUi6yKo=
X-Gm-Gg: AeBDieu3Ov2cu8wKeq8Uv0qp8/NZJIqCtDmOxDMKJMEHKwDvvZYZ9QohBMofJ/KMk4j
	1H8zTcHdfnymEvUfBdAO9J2hlUhU3Mb3aPQodspj6Pdq4Er+EtKIbzpf7KYrnwRHnUjQJ9G3Eha
	kkbvK0brO5tEojKbZz6suYXnUcOsroruKie/KY6hbWUZo4+pUsvwvL31dfAcZW/nFmfy7PinDdu
	/V9YVNiVFtSIfJI5czTT1iVXJ/E4cVrY7snwmbQ9ZB8a2PCLWkWCDMC52490flrdyqDGEajwuFI
	9bATOts66Q==
X-Received: by 2002:a05:6000:4010:b0:43d:1c7a:8b59 with SMTP id
 ffacd0b85a97d-43d292df72cmr33870067f8f.40.1775667059574; Wed, 08 Apr 2026
 09:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408075131.6221-1-kch@nvidia.com> <BN0PR01MB7007C5B4178BCD8619FC5D91C85B2@BN0PR01MB7007.prod.exchangelabs.com>
In-Reply-To: <BN0PR01MB7007C5B4178BCD8619FC5D91C85B2@BN0PR01MB7007.prod.exchangelabs.com>
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Wed, 8 Apr 2026 12:50:47 -0400
X-Gm-Features: AQROBzA63XUlo-BPA0YXAQEH4HZEsU1binjgE78_KDKkT5vFyUJeW05ZWH4g0AU
Message-ID: <CA+ysrS+6MdeKv0snUNcQ-2CJCmKbBAMaFCDvv-9nKBHSfoNfmQ@mail.gmail.com>
Subject: Re: Fw: [PATCH] nvmet-tcp: fix race between ICReq handling and queue teardown
To: Shivam Kumar <skumar47@syr.edu>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, kbusch@kernel.org, kch@nvidia.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233946-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kumarshivam43666@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,grimberg.me:email,lst.de:email,syr.edu:email]
X-Rspamd-Queue-Id: AEB213BF257
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

_______________________________________
> From: Chaitanya Kulkarni <kch@nvidia.com>
> Sent: 08 April 2026 03:51
> To: Shivam Kumar
> Cc: hch@lst.de; sagi@grimberg.me; linux-nvme@lists.infradead.org; kbusch@kernel.org; Chaitanya Kulkarni; stable@vger.kernel.org
> Subject: [PATCH] nvmet-tcp: fix race between ICReq handling and queue teardown
>
> nvmet_tcp_handle_icreq() updates queue->state after sending an
> Initialization Connection Response (ICResp), but it does so without
> serializing against target-side queue teardown.
>
> If an NVMe/TCP host sends an Initialization Connection Request
> (ICReq) and immediately closes the connection, target-side teardown
> may start in softirq context before io_work drains the already
> buffered ICReq. In that case, nvmet_tcp_schedule_release_queue()
> sets queue->state to NVMET_TCP_Q_DISCONNECTING and drops the queue
> reference under state_lock.
>
> If io_work later processes that ICReq, nvmet_tcp_handle_icreq() can
> still overwrite the state back to NVMET_TCP_Q_LIVE. That defeats the
> DISCONNECTING-state guard in nvmet_tcp_schedule_release_queue() and
> allows a later socket state change to re-enter teardown and issue a
> second kref_put() on an already released queue.
>
> The ICResp send failure path has the same problem. If teardown has
> already moved the queue to DISCONNECTING, a send error can still
> overwrite the state with NVMET_TCP_Q_FAILED, again reopening the
> window for a second teardown path to drop the queue reference.
>
> Fix this by serializing both post-send state transitions with
> state_lock and bailing out if teardown has already started.
>
> Use -ESHUTDOWN as an internal sentinel for that bail-out path rather
> than propagating it as a transport error like -ECONNRESET. Keep
> nvmet_tcp_socket_error() setting rcv_state to NVMET_TCP_RECV_ERR before
> honoring that sentinel so receive-side parsing stays quiesced until the
> existing release path completes.
>
> Reported-by: Shivam Kumar <skumar47@syr.edu>
> Fixes: c46a6465bac2 ("nvmet-tcp: add NVMe over TCP target driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>
> Hi Shivam,
>
> This patch is different than the one I posted.
>
> Posted patch :-
>
>
>                 iov.iov_len = sizeof(*icresp);
>                 ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
>                 if (ret < 0) {
>         -               queue->state = NVMET_TCP_Q_FAILED;
>         +               spin_lock_bh(&queue->state_lock);
>         +               if (queue->state != NVMET_TCP_Q_DISCONNECTING)
>         +                       queue->state = NVMET_TCP_Q_FAILED;
>         +               spin_unlock_bh(&queue->state_lock);
>                         return ret; /* queue removal will cleanup */
>                 }
>
> This patch :-
>
>                 iov.iov_len = sizeof(*icresp);
>                 ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
>                 if (ret < 0) {
>         +               spin_lock_bh(&queue->state_lock);
>         +               if (queue->state == NVMET_TCP_Q_DISCONNECTING) {
>         +                       spin_unlock_bh(&queue->state_lock);
>         +                       return -ESHUTDOWN;
>         +               }
>                         queue->state = NVMET_TCP_Q_FAILED;
>         +               spin_unlock_bh(&queue->state_lock);
>                         return ret; /* queue removal will cleanup */
>                 }
>
> It will be great if you can provide tested-by tag on this patch
> so we can merge this fix as well.
>
> -ck
>
> ---
>  drivers/nvme/target/tcp.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 69e971b179ae..98b2ce9a70ca 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -407,7 +407,22 @@ static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
>
>  static void nvmet_tcp_socket_error(struct nvmet_tcp_queue *queue, int status)
>  {
> +       /*
> +        * Keep rcv_state at RECV_ERR even for the internal -ESHUTDOWN path.
> +        * nvmet_tcp_handle_icreq() can return -ESHUTDOWN after the ICReq has
> +        * already been consumed and queue teardown has started.
> +        *
> +        * If nvmet_tcp_data_ready() or nvmet_tcp_write_space() queues
> +        * nvmet_tcp_io_work() again before nvmet_tcp_release_queue_work()
> +        * cancels it, the queue must not keep that old receive state.
> +        * Otherwise the next nvmet_tcp_io_work() run can reach
> +        * nvmet_tcp_done_recv_pdu() and try to handle the same ICReq again.
> +        *
> +        * That is why queue->rcv_state needs to be updated before we return.
> +        */
>         queue->rcv_state = NVMET_TCP_RECV_ERR;
> +       if (status == -ESHUTDOWN)
> +               return;
>         if (status == -EPIPE || status == -ECONNRESET)
>                 kernel_sock_shutdown(queue->sock, SHUT_RDWR);
>         else
> @@ -922,11 +937,24 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
>         iov.iov_len = sizeof(*icresp);
>         ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
>         if (ret < 0) {
> +               spin_lock_bh(&queue->state_lock);
> +               if (queue->state == NVMET_TCP_Q_DISCONNECTING) {
> +                       spin_unlock_bh(&queue->state_lock);
> +                       return -ESHUTDOWN;
> +               }
>                 queue->state = NVMET_TCP_Q_FAILED;
> +               spin_unlock_bh(&queue->state_lock);
>                 return ret; /* queue removal will cleanup */
>         }
>
> +       spin_lock_bh(&queue->state_lock);
> +       if (queue->state == NVMET_TCP_Q_DISCONNECTING) {
> +               spin_unlock_bh(&queue->state_lock);
> +               /* Tell nvmet_tcp_socket_error() teardown is already in progress. */
> +               return -ESHUTDOWN;
> +       }
>         queue->state = NVMET_TCP_Q_LIVE;
> +       spin_unlock_bh(&queue->state_lock);
>         nvmet_prepare_receive_pdu(queue);
>         return 0;
>  }
> --
> 2.39.5
>
Tested this updated patch - the handle_icreq race is fixed.
Tested-by: Shivam Kumar <kumar.shivam43666@gmail.com>

