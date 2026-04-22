Return-Path: <stable+bounces-240353-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOhHAu7v6GkdRwIAu9opvQ
	(envelope-from <stable+bounces-240353-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:57:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F20064482D5
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90E073016B1A
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99276366542;
	Wed, 22 Apr 2026 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SkjhoE67"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71822D2483
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873431; cv=pass; b=VQQ38HsBO8MgTIUTv4jqGFAD613cORjbAzorMylANS25xNv9Y+8DxcKVyzlH4a2cRxEWUBE9dZsewRu/aOzdxm6TlhLBBC/QUqlpFC70XoOsyCEyPLcSrLGCTa0oRlBC+ff89QuSpT1YQ6lr/z5P6wtpJQfX35D5CDjaeV63b70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873431; c=relaxed/simple;
	bh=NieXPC3YS6T5Y8AdieDzRo0mzb0fpU++KX+cXLQAlNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bfxb4B+TwZDPHXGHc0fEa8R9RNmaybFXkVuKI6lYeoy7Tjx7etkQoFItogJ6vYIFMMgatFyJ1/Wi5A9OCKjQJANHLmNAq3yQLQLekqPsdlRnbvIidxe4zF5KBzlV1pRtbSpb09W6Z9tlQghGBJeSGYS97idVaG9ibKv6UYTbNXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SkjhoE67; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5062fc5d86aso45796771cf.1
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 08:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776873429; cv=none;
        d=google.com; s=arc-20240605;
        b=HL3NQAI1gO0hmmXhooYOkC2mcAucxRqA+FPk35YP6MCkvTH2f/IQDLJ2wu4iTioo18
         Na54emWrfu/YPtbyPDfnXCoNL/L7/o2hriM0EqUmBjTCz7aDymfByVrR6XIzH2Bw2TxK
         kz9u7eobqqskthmLF6GwTCBPplosK4+lQUnQ5tbHAk9dunkxn/p1gCXN28lhhPgtCAyb
         QqARTmtcG5uwlMQz8hBNwmnydQSsXuXjj8pTDRR6FadQZPRzMBEnAtiwln5Z4Z+5RBFf
         ADoa6AoxDFoewg+4sq3UYKF3YwpyPdZ/uNLFl2CnO4KLaEjG+3umLERr3/IUFr8TioSL
         3UVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NieXPC3YS6T5Y8AdieDzRo0mzb0fpU++KX+cXLQAlNM=;
        fh=2w44XS7012p1DwwxRcEK6jDvAhr9l8DHlSVqcJZ638c=;
        b=HeiAt/rBL9eK9EtxA/v8Wc+OmOAAs9fynTfBdw6xpji8UgbF5s3H3jGJi0OQr7mMtL
         yN8T108kRVeR2lzeEXzXfqVa60zKHsOZoKw1K7Ve7CzfFCfD/FwHHsjuWoC1mYI0qw+3
         dfrslsawfSXg7W+OdYJEb3RK8QCL4RliKzKW3lcKuEtCK7qfiHRnwc0Z97ls6k5di21F
         tMGd4+5yZ8eeP3+BXMP0qWHpb17nKVcdHVmVLX2JDi6r5ziM0SC7Csh8Vc3JRLtEhy4f
         mVAMiPrATmqeLMtameQzHDeuGwfwbRqTJ2rZFTbTWOePPW1bPYj3OLTEjz2ksgj2tFRa
         bwmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776873429; x=1777478229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NieXPC3YS6T5Y8AdieDzRo0mzb0fpU++KX+cXLQAlNM=;
        b=SkjhoE67dnRKt0g0ZeQ6NFvfbtBvQcZglYg3UgL8ahdJQXdxyy84Mbq8XO0OP88GuB
         HyJnMnGbCraKStvZ4L+7WOr7skiWRCrcgHyHk+tc1JjYhMHIoBtwLm6SG8b+olKPNZCW
         fZSlQ4s0jFwIlxklMcAwPnCr7hvyOAx2VOwgwD32AnZeVKf1pe7BgqQQkdCYGBI9+fh1
         GXMWI/W/myQflGSUzZUrJTOrOns/7itz3XCuV/eenXc2wgIeZsH1L8A4yTpTAZbWXPCI
         fMjxWVCEMHm7SVUSZJ3e7M1PSYKBUjmbgrlHjJ+WgebzeNccoNuwxjyqs7mYiOYy6nyH
         BvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776873429; x=1777478229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NieXPC3YS6T5Y8AdieDzRo0mzb0fpU++KX+cXLQAlNM=;
        b=Tgdwh8T0KSGY5tTDlgtRBeebwP0QgDI47y5+X0hbpvCEZ6koID/49n7qZBzsYfE7wD
         ILHiL+Pm9d6GVx8flsvii3phCzdQsa9Mlh2JJ5cCiS2iQAUT1OdMu/rHKr8jC6ZuxONv
         OnqBj8gkew+m/h11k/W1zShdx/efA4subYNFKHuSrhaJrjg8pswEMXk4l7sj7HQ0Xyfo
         mdX5oXmFYGYTn9h5ei85ScFXYQl136YG2TF8IaLc2tvFn+gDvk0eIv+8qUWv0GqPSsBN
         Cj9YjCcySWCo2+DOSm6iD9kaIdXoUvZl8xUUE9HwPE4ceixmipQLMzZfI9JxupY2cByt
         ULbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/He7tJIs/9/Cq++56UUb6Xy3FQCx3DYqMPkcUn41Aw3IaDEcBVaFIoM82CuptJDNTmcrsZQTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFU7YGWzyvId0CebYZ9vWXPlPAOIjHheNzAscbtvYvDnWdWXcr
	bybrP696QW0CrS1sil6utDLLddfLTgMyQOqqoIlJdsVjw34TudPVB3JnVLsZUtWhLkdcVzfMR+x
	GjlMuK1Z6/3R1NHPl/8pxGMDQbaQHctRjGfCS/wqy
X-Gm-Gg: AeBDietI/ZTWU7zgEHMFQdPHLi17lGJlTVyufCZUIMRGw9o9RDdJjC0M+zjBJ+uemq5
	CdwNa2Y8aAlyy29PnvdHcVI5TNGNJi5mBaialXD89Ax9JGX8ZmwmT25AyFT8hpJcMqei8h0ZbkH
	mXBH20OREI5kjwOAq4Rl1894lDoR0CPqh3wC3ncgABzwrwatG+ZIkHuI2RxhPsKQ5GHqr9bT3X0
	yFxVYKCWImH68SN6IFvSiczgCVhFaBhEMVz6yh4TbEeOQFngt9QhEoOASlaQK7oaFYzc8U64vKl
	4q+WivfBSZlyv6vmVxuNV3Lwr81T6Fty0VxcQpkXIkXD3e3MdpAMyXWWJKKk8EU6HKqKjU17cQa
	i3WtExvJU
X-Received: by 2002:a05:622a:4c87:b0:50f:bdeb:1e47 with SMTP id
 d75a77b69052e-50fbdeb24e1mr81744721cf.44.1776873428348; Wed, 22 Apr 2026
 08:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422024554.130346-1-jt26wzz@gmail.com> <20260422024554.130346-2-jt26wzz@gmail.com>
In-Reply-To: <20260422024554.130346-2-jt26wzz@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Apr 2026 08:56:56 -0700
X-Gm-Features: AQROBzAxAmfFhRZGfkUgjI6oI5pnFyMaVXwdwbwsAVkf7mnNe9dRlKDjPQZm21w
Message-ID: <CANn89i+RuNBmUuacPLv9oKNFA0g71z65Fy-tFRjW7gm0TSGbqw@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] tcp: call sk_data_ready() after listener migration
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, tamird@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240353-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: F20064482D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 7:46=E2=80=AFPM Zhenzhong Wu <jt26wzz@gmail.com> wr=
ote:
>
> When inet_csk_listen_stop() migrates an established child socket from
> a closing listener to another socket in the same SO_REUSEPORT group,
> the target listener gets a new accept-queue entry via
> inet_csk_reqsk_queue_add(), but that path never notifies the target
> listener's waiters. A nonblocking accept() still works because it
> checks the queue directly, but poll()/epoll_wait() waiters and
> blocking accept() callers can also remain asleep indefinitely.
>
> Call READ_ONCE(nsk->sk_data_ready)(nsk) after a successful migration
> in inet_csk_listen_stop().
>
> However, after inet_csk_reqsk_queue_add() succeeds, the ref acquired
> in reuseport_migrate_sock() is effectively transferred to
> nreq->rsk_listener. Another CPU can then dequeue nreq via accept()
> or listener shutdown, hit reqsk_put(), and drop that listener ref.
> Since listeners are SOCK_RCU_FREE, wrap the post-queue_add()
> dereferences of nsk in rcu_read_lock()/rcu_read_unlock(), which also
> covers the existing sock_net(nsk) access in that path.
>
> The reqsk_timer_handler() path does not need the same changes for two
> reasons: half-open requests become readable only after the final ACK,
> where tcp_child_process() already wakes the listener; and once nreq is
> visible via inet_ehash_insert(), the success path no longer touches
> nsk directly.
>
> Fixes: 54b92e841937 ("tcp: Migrate TCP_ESTABLISHED/TCP_SYN_RECV sockets i=
n accept queues.")
> Cc: stable@vger.kernel.org
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

