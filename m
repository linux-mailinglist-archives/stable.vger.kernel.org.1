Return-Path: <stable+bounces-228612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FZ2LMdPwWnLSAQAu9opvQ
	(envelope-from <stable+bounces-228612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:35:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 720AF2F4CD9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8862305D0D8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF14C2343D2;
	Mon, 23 Mar 2026 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="PxxLXx0j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uhEx8jWe"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F2D2C181;
	Mon, 23 Mar 2026 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275601; cv=none; b=cDxmbjeI3B1SOfxKWzfsKNtYmveh44GDceRg1i3OCodGLG8ZQPCi38Au4Z3U9RycHzpRk1aph/1q9AvDYFqbLApOJhsVNPVjaxMFsNwOvP36nLjEO1cmdffgnzWhcD/a+grvtx1fRi0CugxOlzND8KgViGY93f8w9P4uF1hMf0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275601; c=relaxed/simple;
	bh=C8hMLdzLpw3anbsB7wiVA4+wrsO3woB/ERHFNv7JDfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmJt+Cq5Wr6WiK9kDFly9Uj4EhUIfhIRZADH73lbpf01jDB0Z8mV4mMTRSTr/HQwLkU2DNP7lyZzgUz90CrgXSUuEbLwAI8isKpVxV9rBJTK/zeaIilkDkVQMUtVzi4LHEM9NNNJ8l7DV7u0RrCyhF6NcRBr/VOWSPPxGyhkk0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=PxxLXx0j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uhEx8jWe; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CDF9C7A024C;
	Mon, 23 Mar 2026 10:19:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 23 Mar 2026 10:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774275598;
	 x=1774361998; bh=q1XY9wBEkdkEyg2DP9g2df7Uy6DHiN7ksnRqJjq6duE=; b=
	PxxLXx0jqjjp1FjScKMdvZGg8KUoW7zOZOe5zogIbLDsXbZPRujPeBQBPUWLD25d
	YJ0sIPGK1HcMEyfw+NjEfv6KSLHd547cLQGxbTkDNhT0kwZCNS5zzUhCub7uHBmH
	/opV3tJWyVnHDhgaHDJdMMq3zzEunDc+TQ1s4Ofw/1Okg5LxeqUvDRjwdKoaxmet
	Pcx1+9W7Pa6odVZIP6Yf6510ETGqR9TtZ40jaddK01cCgPlxiu80SpK1PoMuiaN3
	xwVOZoTb6NSZe5Zpg/fhXV79qv8l+33aF6FIO4Ocdr01/+BvMTc4NcNyYNpn6EYv
	AM/6jWI8eA2gUvr3gRyoxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774275598; x=
	1774361998; bh=q1XY9wBEkdkEyg2DP9g2df7Uy6DHiN7ksnRqJjq6duE=; b=u
	hEx8jWeiKYvuzZbsh5YXnQpttXfu/kxYVie/NkHC6WiRJvkrMuNoFhQCQHFz5hiG
	JFOy21b+BxsrrHNSvtqWZILZQ+lWfqwacWBGSj48gYwBtcCKOX0HQr157We9yK1B
	Ne8DlzhnMX7CPnFEH83vlTZHRmd6CTshwVq2RgfO5m8wqOMsQH6W2hCZDCHufEU8
	0lfA97Xeuw5gPyx+Z+WFhTz+MIZ5S4eRRsNP27xxN1gA0GQgAzF24Q7ka3NaY/pQ
	NYav+9SnVmj+4MQphyMvEG7/3NG5ECOeCnviHn+Lb5iuIWwkTLkTdje5LMYuEca8
	t+Hzc9FXsaOXJyUy+T1yw==
X-ME-Sender: <xms:DkzBaUP3eJA8pkz0MZvqdh3Uq1gD9OMEBDom5JfE7PM-V_CHNd27CQ>
    <xme:DkzBaYyHixZ_bBP3RCk9A3LCVWEPFyjCVpV3ZdpqWmeKZPrKsRrPcTGj4jrNelPJ9
    wJa--0HrKomye9J329icXrVPgan1WH0i1jvqfaXgG_hD_2wa0bbKA>
X-ME-Received: <xmr:DkzBaVu0gf8Bc_yq-0pWzH4AZiAOmjEpOoRc2Nhf1WjiLxCKl8JB5Tt6QBZcsdcWTo2EHfeJtywvN_Y0k0PmfEA5QuDAKOYcGMKHwuNnDdagP4yWHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtg
    hpthhtohepmhhsiigvrhgvughisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsh
    htrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DkzBaZ7avc5_l96VUtVojF7n5V9Tsjo4U3hhLZKcAZDViQo7w9PKYw>
    <xmx:DkzBacQc067G6w4wjaLAP5KIz28OqfzndlDXc_vmTfpaj35CjB-SlQ>
    <xmx:DkzBaQo-mLPk7yNhLiu_dqOcEuy3BsNwWYXC5ZKSeSE7eFw7lW8bZQ>
    <xmx:DkzBaSL52b-BdeGwoazsxME7m_UbwMbmrt7KCix_bH5LXaCAi8g-QA>
    <xmx:DkzBaSdZoAe7uOq1yOLrnIdmFsGtT-Nl27VrTzeYKiysHLvBjyP8PCXS>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 10:19:57 -0400 (EDT)
Message-ID: <d603b62f-8ec4-4cc2-8f9f-2f304cbb74ad@bsbernd.com>
Date: Mon, 23 Mar 2026 15:19:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] fuse: abort on fatal signal during sync init
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260316165320.3245526-1-mszeredi@redhat.com>
 <20260316165320.3245526-2-mszeredi@redhat.com>
 <0fb13941-6fca-433f-a560-9da51113d88f@bsbernd.com>
 <CAJfpeguhwLHh=Fk+EGG_j9ap8yHgn9Mkocy-9X_0O-uuo_q3-A@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpeguhwLHh=Fk+EGG_j9ap8yHgn9Mkocy-9X_0O-uuo_q3-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228612-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 720AF2F4CD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/18/26 10:33, Miklos Szeredi wrote:
> On Tue, 17 Mar 2026 at 21:24, Bernd Schubert <bernd@bsbernd.com> wrote:
>>
>>
>>
>> On 3/16/26 17:53, Miklos Szeredi wrote:
>>> When sync init is used and the server exits for some reason (error, crash)
>>> while processing FUSE_INIT, the filesystem creation will hang.  The reason
>>> is that while all other threads will exit, the mounting thread (or process)
>>> will keep the device fd open, which will prevent an abort from happening.
>>>
>>> This is a regression from the async mount case, where the mount was done
>>> first, and the FUSE_INIT processing afterwards, in which case there's no
>>> such recursive syscall keeping the fd open.
>>>
>>> Fixes: dfb84c330794 ("fuse: allow synchronous FUSE_INIT")
>>> Cc: stable@vger.kernel.org # v6.18
>>> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>>> ---
>>>  fs/fuse/dev.c    | 6 +++++-
>>>  fs/fuse/fuse_i.h | 1 +
>>>  fs/fuse/inode.c  | 1 +
>>>  3 files changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>>> index 2c16b94357d5..f0631c48abef 100644
>>> --- a/fs/fuse/dev.c
>>> +++ b/fs/fuse/dev.c
>>> @@ -576,6 +576,9 @@ static void request_wait_answer(struct fuse_req *req)
>>>                       removed = fuse_remove_pending_req(req, &fiq->lock);
>>>               if (removed)
>>>                       return;
>>> +
>>> +             if (req->args->abort_on_kill)
>>> +                     fuse_abort_conn(fc);
>>>       }
>>>
>>>       /*
>>> @@ -676,7 +679,8 @@ ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
>>>                       fuse_force_creds(req);
>>>
>>>               __set_bit(FR_WAITING, &req->flags);
>>> -             __set_bit(FR_FORCE, &req->flags);
>>> +             if (!args->abort_on_kill)
>>> +                     __set_bit(FR_FORCE, &req->flags);
>>>       } else {
>>>               WARN_ON(args->nocreds);
>>>               req = fuse_get_req(idmap, fm, false);
>>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>>> index 7f16049387d1..23a241f18623 100644
>>> --- a/fs/fuse/fuse_i.h
>>> +++ b/fs/fuse/fuse_i.h
>>> @@ -345,6 +345,7 @@ struct fuse_args {
>>>       bool is_ext:1;
>>>       bool is_pinned:1;
>>>       bool invalidate_vmap:1;
>>> +     bool abort_on_kill:1;
>>>       struct fuse_in_arg in_args[4];
>>>       struct fuse_arg out_args[2];
>>>       void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
>>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>>> index e57b8af06be9..84f78fb89d35 100644
>>> --- a/fs/fuse/inode.c
>>> +++ b/fs/fuse/inode.c
>>> @@ -1551,6 +1551,7 @@ int fuse_send_init(struct fuse_mount *fm)
>>>       int err;
>>>
>>>       if (fm->fc->sync_init) {
>>> +             ia->args.abort_on_kill = true;
>>>               err = fuse_simple_request(fm, &ia->args);
>>>               /* Ignore size of init reply */
>>>               if (err > 0)
>>
>>
>> I haven't looked at the other patches yet, so basically the mount can be
>> aborted with ctrl-c, but no self abort in this patch yet.
> 
> This should work with all kinds of exit, since they ultimately
> generate signals on all threads.
> 
> So the rest of the patchset are not even part of this fix, they are
> just cleanups/improvements.

Ah right, my confusion was from my wrong thinking it would be the
"mount" process sending the init, but actually it is the daemon itself.


Thanks,
Bernd

