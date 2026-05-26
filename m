Return-Path: <stable+bounces-254262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGGmCjhKFWq+UAcAu9opvQ
	(envelope-from <stable+bounces-254262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:22:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 305525D1AE0
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EDC53004053
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 07:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1326D3B5319;
	Tue, 26 May 2026 07:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="vVyrEJhy"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3EB1AB6F1;
	Tue, 26 May 2026 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779780144; cv=none; b=u5xnjTTAXf7HJQ78XNeTsbFyOfJP6DZHCfLotKbpZlgH8LY2Ey3U1/qGlKnI491UuQfVxaVjf4pthkTWXpUjxyNd0PVOXS3JDkFscKy/t8g9XpbFhTDkElHbAiuYDosSM3RnUbVTK7tE3NJiD6ugVaNpcMxlA5nh2An4wV2bG2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779780144; c=relaxed/simple;
	bh=/4pfUWBNpU5VRKedqPpVBpHMbJhWlxwHXuuVRtTvg2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgNMQocYq6nhLpY14Ulkw8nma0VudGjr9j21ad78AVYmVi3Z8VtPUwgfJDdm8jIsMKgzRM/RVZrnvUQkOkd1+YwX5pXVNt4sxAwdI9lq3oX8qhJtAbImtnONmS+FVTejdAR9QYjIcRXcexjbGnUUf+JXcGr610N2qlcOCrL9gs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=vVyrEJhy; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779780136;
	bh=vCqvF5MGUdGL78o1u6AeSWyGcNyS3UnQyyyeBw+A7AM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=vVyrEJhy+2rAB5Zz1qF8uHbe4lUnXEcswipteHIG3vVWd0sOhjj7do1V5458pNgXf
	 dav8jjWBWBHcqqERiaEov3KwRdYDR5chjk0vgvnlo9KoEfLVXHfxNx92kAfbuSHid8
	 SdSjc6oQ+ALzwa5QetnD2coDmGk051CuHq7yGfIc=
Received: from [192.168.1.40] ([183.241.55.175])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 58D85461; Tue, 26 May 2026 15:22:13 +0800
X-QQ-mid: xmsmtpt1779780133t02pjz2vw
Message-ID: <tencent_B3019C5118AE0620DA8B9AF58F67C939EB07@qq.com>
X-QQ-XMAILINFO: NX3IH4pixvQAVADq1vvHCERuEIceXkQJ4Hnsi0ANjiogGCHB9gi/K1+QqMFmHY
	 fiz7/AwfNQNPLe1NJSK26VDmXBwXGjdC/q28Jw8TuStxxg5iiI27i0ILWJyn/kOE3VeK0b4N82QK
	 Der1l2oy1ICJ8wRCsm65PxB3L+JuVBu7hZPuIw42w+UmJAuDuULMGSYtXdRmjUftz5ev6wknRqbd
	 Pl09MRvRin8Ge741H/+FBghVajEAp/LgsG9q9DfSDKsVCwueMH3d6aZNCVgZWEce+X0dlunBlV8l
	 FnGCGHcpL75sHZfbq73SFnbUDyItSeF2Uju4HYCJdjSwir4O6un0GCK3JBbk4tmuOaNZZnZgzk2s
	 QebtD+IkP8+qwsLH85jb8xC72sh19VQ8Ng5Mt+ukrcn8Na9EVE9UnFMk0o48EHPMUVW3GrfsNZGN
	 9mhHOxt1hq2KW8P6xfuyfJpq1NPugaj1JE6jpSSHpp53SfP5qzlW1rGSShfGtOwFEswe2ayhqL+h
	 5huAsBXN/6ydHzmxb0pAvBKwQOQFhrhyk4+T3+KyG/8kAqzaebiioj0v8zKVlgp1Vq8zsuyJY5Hp
	 jG3rvMdMjhrtEnbZ8K9V3Xzjld0rTfGoXT07dNUfc+txRV+uW+rl+gG4MafTJKSz7NFh3cnvC5Na
	 QI38EtDg471HHb5CEDakETDKaNcAQD8TwoOu0Hwhh8noaSotmYR43LakF2sk9vl+Wxv3Dn670FLk
	 s5Zy2/s6jr6SDEvhMxu4GXUEGM5+DWEkXJFIFqKLpkoHdSDIZMk2ATrPebc3Gru1OVNUWemAeSes
	 h66BCbq7XlJB40vy0GwcFHOQD0AcctPrVdury+AabCOsoUj/Ik2iLjn5OMPuexG+pyhna6AI0MPK
	 qgEm+J3QUMaCbY7mh5g1KdJe0UIy7OHOyDC1JuvREHfPv7sCB99OjmVDI/W9k31bEn/kWoaGL15h
	 DwcKh2NMryH6kZrB9MToE2F3yQK+ls1/j6MVbcJF6oXaEALNWpm0BEYPL0/PfoFuqQgklNzqSW28
	 NesriP9gA8ckPfFL0gakNAj+b/B05Uj9hIxOeqrSWV8rDY/YjXlK9hSNCiyOw=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-OQ-MSGID: <0003d2e2-1c8e-4c92-9dc3-1297d5090768@foxmail.com>
Date: Tue, 26 May 2026 15:22:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y v2 0/3] ksmbd: validate owner of durable handle on
 reconnect
To: Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org,
 stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linkinjeon@kernel.org,
 stfrench@microsoft.com, d.ornaghi97@gmail.com, knavaneeth786@gmail.com
References: <tencent_290D1FB4A935031FBD9251D6D238B830AD08@qq.com>
 <20260525152512.agent5-0006@kernel.org>
From: Alva Lan <alvalan9@foxmail.com>
Content-Language: en-US
In-Reply-To: <20260525152512.agent5-0006@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254262-lists,stable=lfdr.de];
	FORGED_MUA_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DKIM_TRACE(0.00)[foxmail.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,foxmail.com:dkim,qq.com:mid]
X-Rspamd-Queue-Id: 305525D1AE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/25/2026 11:33 PM, Sasha Levin wrote:
> On Mon, May 25, 2026 at 06:38:58PM +0800, Alva Lan wrote:
>> This series backports three upstream commits to the 6.6.y stable branch
>> to address CVE-2026-31717.
>>
>> Upstream commits:
>> - 098c0ac3808c ("ksmbd: avoid reclaiming expired durable opens by the client")
>> - 894947e0736d ("ksmbd: add durable scavenger timer")
>> - 49110a8ce654 ("ksmbd: validate owner of durable handle on reconnect")
> Two notes before this can be queued:
>
> 1. The short SHAs in the cover letter for patches 1 and 2 do not resolve
>     in mainline. The correct upstream SHAs are 520da3c488c5 ("ksmbd:
>     avoid reclaiming expired durable opens by the client") and
>     d484d621d40f ("ksmbd: add durable scavenger timer"). Please fix the
>     cover letter on the next spin.
>
> 2. More importantly, this series adds the durable scavenger
>     (d484d621d40f) without its critical follow-up bf736184d063d ("ksmbd:
>     close durable scavenger races against m_fp_list lookups", Fixes:
>     d484d621d40f). That follow-up closes two KASAN-validated bugs in
>     the scavenger code: an fp->node list-head reuse that corrupts
>     f_ci->m_fp_list via list_add(&fp->node, &scavenger_list), and a
>     refcount race between scavenger qualification under global_ft.lock
>     and m_fp_list walkers that races to a UAF. Please include
>     bf736184d063d in the next revision so we are not knowingly queuing
>     the scavenger with these races still open.
>
> Also, given the patches are authored by Namjae, an Acked-by from him
> on the 6.6.y adaptation would be helpful before I pick this up.

Thanks for your review. I will add bf736184d063 ("ksmbd: close durable 
scavenger races against m_fp_list lookups")

in my v3 backport.

--

Alva Lan


