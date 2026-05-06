Return-Path: <stable+bounces-244386-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sODjDTtC+2lPYgMAu9opvQ
	(envelope-from <stable+bounces-244386-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 15:29:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD23F4DAF93
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 15:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87756301231F
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 13:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FAB477981;
	Wed,  6 May 2026 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTitGJBh"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573AF46AF2C
	for <stable@vger.kernel.org>; Wed,  6 May 2026 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074167; cv=pass; b=BmPevNUh/1xmasKR3hd0JIWkGy31HhCQgkeEyxdlFDjDFb/Op1Z5Kl9m7tEyKt7ChBxQyQJbhKBWjkzpWXdfqefeD7yFu441FGAUsP0JU02BaljP2ZgMqRv5FbvpNCqQp/bHnE1Nw6ASQ/GZF1BICU5ISixwapNOHE16yH6m7TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074167; c=relaxed/simple;
	bh=7alyTiuCbJiTCOYLhaXttQqzh7/Vh/2uu2iz06WTT8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHBBEFSO5t0zTXJLp2s6Ne8uGSfG5J3y7II61faAHE1I1uAzqRYT8WUA70EsHu56RgtTeqI9G6k2UBHHGFLzu/wJMYJsDV/OERzk2NlipWRcKUJSDCfK9kFcmdFpUE6G5aWmUV2JqiyCehkJgO4F6A9EZPzKS+YFm6XDxWxR9Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTitGJBh; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65c0bda7f15so6605812d50.0
        for <stable@vger.kernel.org>; Wed, 06 May 2026 06:29:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778074165; cv=none;
        d=google.com; s=arc-20240605;
        b=CgrNwAS0a1erohUtMgzELkIdZFNqx1UWScBENY+ZMKx7JzN9IYK8tXqwASrqQto9cZ
         BqCCzdwVNq94cP3fuLeVWfUDj3qau2VtxrZgKmPRaNwJ8UBXWyLDlVsD7w2f/vBJLAbC
         qV7kyUbBCeWk7bT4fiASH92aDTxSO2YQ7fnZrVwZZNxEtarYfdWkdJ5uWGpJOdXF6Ko5
         /3qS+c3XefWEizP6DVFpI5jztWKhlT8KNrMojvChVbuEWKEuAzPwZ+O3EN+BhvMgQba9
         j78HqhWdoInQ3uo8CHdOv5lBgsZV0U/r6lpVnoJ03Wq4ml798LPkE6xwgc6al42xlwon
         zflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7alyTiuCbJiTCOYLhaXttQqzh7/Vh/2uu2iz06WTT8c=;
        fh=KVj4VRn8NEgxDkejAYqWwDAseweY6O0AzHuCmfa9hfU=;
        b=Np72QKKOL/laEre5gcCXwhEAVGjApfu12HuQnNOTKAo6Y+KN5s1hIkdPV5eWT2NS4p
         GbWx/mCD8Es5J2knBlS8il/09D3qX+MJchmpA3YRtCw5fDd3RYQHRTZb2BMPwi2qMJED
         pX3wMVucVwVZKRr6XI/KhIsTbOMfbGWxCl4SKkHxJ1l1oLbfOeono61aGytUJ3+eAnI1
         vhjy7H0SSbmz7vg8G1Dq5bfkiqBcJNKPh1XjmY7Mdkz4Z5E8I2oKM2HaVp1M08WnTnqg
         10eZxMLRFWKjHWeGiw68/wUkLGRJ7Dob3/uokYxFQ6mmHvAX1q4mm+qgSAvq92A1sNGe
         I6bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778074165; x=1778678965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7alyTiuCbJiTCOYLhaXttQqzh7/Vh/2uu2iz06WTT8c=;
        b=VTitGJBht6GOzjKzC2gl6iuHdVWI/TP1NsifnIchPgbewt0oqqvesDvy5Z1xX0Cdc9
         b0i3BcWsutNn2vIteKmqrnNzZdL8UXuFd7Nh5cvae3x4/mnUv5CDQYHjIdxiSy8JsrfU
         ZQzXsNgiU0AtYBf1wAgdiDIyIM89WLFjWqWNVKOrChJxeovgydf9MSdpY4dgciRBbfSw
         ldhZEz5x3KAPNwup7qjuMIANn53wbY8174k7SWhVZatQxsbvDf3Q5OHy6OqJXoSrecv1
         /T4usS8sDFMJIoCz2la+9z3RBhkDQYmMEY1TEJdrASGGsgSq6N8dH3udDqVpOGumcyEj
         R3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778074165; x=1778678965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7alyTiuCbJiTCOYLhaXttQqzh7/Vh/2uu2iz06WTT8c=;
        b=se8ei0iTsWI1v6DQvwW8rdjSceW2T1BA9wpY/v1LVAeCkpbwsxFRMkKrJCfrA1MmFT
         dewolKLZO8ugU4n6hh0T77OH4PZLCW9Hyga9azphEVNvE1Q6lOz/NtYs8C5EHcXXDNzq
         xCtAAxBueJGCs2h7zGq0QElPDFGB6ssJoD3pRQGtaHrKk8FeoaPIRGSa+EFhc+QgHdzQ
         fffWDsuPoyaByNnJ3gkRJ9a2OlCi+d6DneRJDSh6ojub7N+TgYj5fJYz7d9xa+f9owkW
         Xt6wwM44fTcvK1ZrqIg8yR1lv5c/KuymGa9AX4cFpAclN4YtzhDLPz4PvV8D3cPBn6qA
         ZQEQ==
X-Forwarded-Encrypted: i=1; AFNElJ8RMMaTt0jj8vcGemV+rxZtesrpbLFWuZIbK6W8Jpoz/oi1QI6CPJGMm4tUKvLaG+q6NnoRZWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLzPm+q8pA689gBLhzHwu1nCshnPD9RwVkRVZhNkUzDhJ1wWHQ
	sUwooBIAHqMah0K2g8GeCXPDw4YQZODe1KRFh9blKSVddmVHNUjTH1H7zk87j/G0EYJdLhFGTPf
	cV4w3RIh2O+vyB0Fn56SdqN+dSwGW97I=
X-Gm-Gg: AeBDievvidWRmMzHywEoDGrh6yVR4CBXrh7sC0hexiC2uXNKavFhEwIDrUZKai736/S
	ZTCuINq0ACb/5Vz4YzaSFZyZxHbRn2AsYxq+50WlPimVIlk24Y/mBIeVA7N5Eq42WMSh7IpwLc9
	1v275APvtSt/QeZM6VlbxHQD2L0qb4ln3tWgFcKFeMJYYs5DlYYCyZaigkP7h+rgydz8vujekUZ
	uP0RnH/6i457kcjqZnt+Uu1ecb0DBFf1yoOZ7NBPykPqu1oGseMjR0YakVj2Cu6UvMiK1+Fn3Yn
	fUd4XmHis2peZYp7lxN0qt5mDof1Jo4qsKgC81npYS8VXPs=
X-Received: by 2002:a05:690c:6f06:b0:7b3:a5ae:4232 with SMTP id
 00721157ae682-7bdf5f1f995mr35858757b3.50.1778074165168; Wed, 06 May 2026
 06:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506120034.2146771-1-cuigaosheng1@huawei.com>
 <CALW65jYMfBN33qrWAMaNmnKfOd0eK4xA8KvCijkPS5mdBfoWSQ@mail.gmail.com> <6cd90b7e-473b-387f-7558-e5d14d531411@huawei.com>
In-Reply-To: <6cd90b7e-473b-387f-7558-e5d14d531411@huawei.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Wed, 6 May 2026 21:29:15 +0800
X-Gm-Features: AVHnY4IrKhRVdY6OeNVqSeZ595tsbEHCwaJbDJm4NPejk_BR5Na-c-htTE3eUic
Message-ID: <CALW65jYO_ShK91L1atmG8C_wrw4rXD1bbGZG0GEdTALQPcQshQ@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] Revert "l2tp: do not use sock_hold() in pppol2tp_session_get_sock()"
To: cuigaosheng <cuigaosheng1@huawei.com>
Cc: jchapman@katalix.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, gnault@redhat.com, 
	gregkh@linuxfoundation.org, lujialin4@huawei.com, gongruiqi1@huawei.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AD23F4DAF93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244386-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,huawei.com:email]

On Wed, May 6, 2026 at 9:11=E2=80=AFPM cuigaosheng <cuigaosheng1@huawei.com=
> wrote:
>
> Thanks for your time.
>
> ce63943f9bce removes sock_hold() from pppol2tp_session_get_sock() and rel=
ies on
> SOCK_RCU_FREE being set, commit c5cbaef992d6, which actually sets SOCK_RC=
U_FREE,
> has not been backported to v6.6, and after applying ce63943f9bce without
> c5cbaef992d6,the pppol2tp_session_get_sock() no longer calls sock_hold() =
but
> call_rcu(&ps->rcu, pppol2tp_put_sk) still exists and calls sock_put(),
> so backport this commit we need set SOCK_RCU_FREE and remove call_rcu cal=
lback?

call_rcu() here is like SOCK_RCU_FREE: it only invokes
pppol2tp_put_sk() after all pre-existing RCU readers have completed.
As the commit expands the read-side critical section, there is no risk
of use-after-free.

