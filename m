Return-Path: <stable+bounces-210788-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNsaBNT4cGmgbAAAu9opvQ
	(envelope-from <stable+bounces-210788-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 17:03:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 903F759A26
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 17:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49A8A7C5F00
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0E044D6BE;
	Wed, 21 Jan 2026 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7QS4Ry9"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B4A42315D
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010378; cv=pass; b=r9RFKJnWR4tElhCIcHnK9ZtEi1eisxJYpOCr/8+25NaqsO6iOxtBr0aYnVVo+cvALu5tVQu2GYhKpgcaDCn2PJ2OACljfCqdK01l/j+uWXsjhTC6DI0ZCbqTxmwV5ByMJkTs9BSO3bW0iD1znQ80PfYNetYYN1GqDSBKMHlQYi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010378; c=relaxed/simple;
	bh=F76WQcEbTi0hFR9Kp7bb0bNOcyvTQNB4ZDIxqiHVc3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fc8qUR8QX0eOTgIxaEslF/qxPEGt7NQwGNo0opgWPXSyeMlFeVXbUYz7f9c6ErPPgc70Rr3+ZzVOA0AtmLkRHYXFFfzcPlpw8dGG6Gzh5TAYMXsYUa0+q2crupWCZM9rrPpOOsZSUQsyasWEoUgurBM4MKROBbBMpYvZL8Sraos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S7QS4Ry9; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89473dca8aaso423526d6.0
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 07:46:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769010375; cv=none;
        d=google.com; s=arc-20240605;
        b=FUkfELqHnWcKha+XPbBCDMGWbqW2MjSsIHT4BGFs2TqSeb+Bns0dc9wivnbPwLV5vC
         oO+Dhbx4eoGoVrQTH6S+tJMS1Sa2t7vRKv4KAy+acttaH/na4j7TjCawTtQPXz8tBANB
         wVdduGqQqkGQncExM1iqrxgw3Xq+rNl/En40XoRAx7GAc8Qlk/6/6hYWMIE46PoWszER
         61UMWfIteJO6pB4gXeH0jPmBHipxhP51xPZhWx8kLQjWzzaGRsWKUhSvkFt26k3lzaEy
         fFiR+QJT6ujauIrOMJM3a3pOa8TuTS0aGE3huhoqAFqKE9mvF0BbZAohRhmb4HrFX2we
         rQ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vhc0v3X23UZN/O3bEf6Jea0gd4odiHJo/Sm51lqUpPU=;
        fh=5nRujV0mwQaioXGE0vvqtE7RcwAfrE0EwZcBDoGTMBA=;
        b=h5EU3xwdd9VHiu4mI54C+XLmJ8MwxRve0xaLjfm3MA19iJqqRuMbRWwzP9zTIiVzZp
         z1lLmAa6yCHq68B0SAyM4lc0hfj246EdaRgnqNtVmMhNHavrFNOKeid+N0GT3JLoiyNM
         lDiBi9G5Z2ZXnm1g5U8RlNQX+LtStL7qUPtHGkXrxHqpHw6cR9/58u9xM9oE5O/HZPLm
         F3tTpZCh/qJDFN5jsCBJ+fXsGorDpDm+11lKF2E3bjWwVIj0IqZM46Jzj7pYCQp2CWux
         pJpjiXSqOZAVcawxXaIEA0pTmpCSG54gjyxOxbzfbYA7uFU83Id1yk+GRo7b0csJ8AEd
         n2nQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769010375; x=1769615175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhc0v3X23UZN/O3bEf6Jea0gd4odiHJo/Sm51lqUpPU=;
        b=S7QS4Ry9G9tttdhIMMbZ9D9J1X7izg28LTajCUwExz5FGHANlJP/f64SNctYV7dCL4
         S0qp9xaComsjghR9tQaCnY6bzt3a5EYsMJLzVVEqoPqsuOyYmDviSlFzFcffxWnmSfg5
         ZgnzN5sDDSareWYoab7gjZ8z2DOSL2FQ2g2CVT7Vxn7o+Yv6wwrHfYAymjpYpGu+1fxL
         BjgxEfvuSOIocu4HPeF+Vjz0blDfSYVW/kHHO4yApzZ23AB5IkDhoXcBL7ADlB5h2mQE
         54IBNRz29ZS0rGmU6gcCkoO4Hk6F+/HT3lnF6r5sa+RzsUk/bY36nCDAZzTsSwYZTdFG
         N1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010375; x=1769615175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vhc0v3X23UZN/O3bEf6Jea0gd4odiHJo/Sm51lqUpPU=;
        b=S9Eg/G8CL2PKpJnGVt37/zODqI4C4YYNIeh2kPbS7Yzh0zGSaxEjWVlyswmugg6pIi
         q1xBQFf4toTnGH2ryJ4plaxaMa531xxyErToYojt3PJw/YKo8zqqBAzmTkG5wcyVC+ty
         whLKHd6pLMlYIDH+5znjWhh9wZ1T4CBLNjnpG01gg3DBXe56OXlWB9Y+GzeRIqsrNi7s
         3XWIa5oTY2nHAlvOQ1GLlFzKftqn6Dulio3EYKwty16nfyn6U/zyBjCNUt6jdhr72DKS
         6k21Om3G2apPtfagLYxjk3h1RxsXxyV+3BlpLM/3wUH5TBR0MdN7U89jN4nic+PuS8+4
         PBGw==
X-Forwarded-Encrypted: i=1; AJvYcCUVNPgCwRdtdB7PqUb+ppoOC+cibC93+WfFeGIWlSvC1ig7kDkPmYZH5XUmnYjNDw8/bi0L9m8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXPKheaPcpoM+3DxdndOjNwiU6n2S/FB7RozxN8jW7ZNyJ4v3B
	65RFEwu8pKeubO48OMmj29H2hcQ+X1MLVe+n3yTH1phsoZNZq3wINXZVWUPwcxcPvZXoRPN51Rs
	ypw7g+ne5hfLexn7TC05gUia9IucD7l06XnOBKFsd
X-Gm-Gg: AZuq6aLDtLyRQK/NCdGF87XdUACyDwwngiPMO5kqDXXAfZMHhe2cznHHog0aSG/jzM/
	qHF7G38uaogDDJ2pATFoYG7AXeak2ZUaRpVZ7Oi6vKJXkC0hjEXza3gOUwKmEgmugF6cFe2Fvua
	byfW/ctKw+C9Ad6t3CYX0U06wC+DPTQu/Hm1EMEHTSflG3n45Iez3u13UvZeko6Myydo2dMsCwE
	q1y2/5B7+LgImk8wWzLfoXPtYFhUBdNAJyV4xZFqOm8upoghiSrZqoY3sUGTtlWVU6eaco=
X-Received: by 2002:ac8:7d96:0:b0:4ee:4128:beb7 with SMTP id
 d75a77b69052e-502a1f99513mr236249041cf.69.1769010374538; Wed, 21 Jan 2026
 07:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121131954.2710459-1-p@1g4.org> <20260121131954.2710459-2-p@1g4.org>
 <CANn89i+8_ZDxVGwQmo_44iCRs5Wexwxy1Wfhw4WmYg3qA7_t1A@mail.gmail.com>
 <BSn2a6IWtM_DnDrcd-qDBm8cXAwXPo3xj1l4Eu4SWy3BS2UW8Aw7-gXW6uo_DaCipnvmSxgDeGEQrnZ-pjqRKSOPPUW0usVN8M1lp1J-soM=@1g4.org>
 <CANn89iK_VqOThsWX2b-JwvF8suBVmKEmMm9D9SeZJBamDwfPog@mail.gmail.com>
 <YAOV0f1EtmF5tiEGoQMdsnQAKJSrqcg3h9hqnxDdba8MmAprjNHfcDBKselH1vYNZLb672n_zDJZpgjkVn0nHDS0Jh7BKQrh0uGwJYp2hEk=@1g4.org>
 <CANn89i+zuXMZ1Jx226rPG0nHKmRjL1s-m56xk-KD6nWLdrY1Gg@mail.gmail.com> <iSkQcHVqeUy7WNAqfrY9xUAibm1YtrTUPIhZ_yjoHmyDissbQj04N2-quW8BURs4cddEB6bDp0BfXh0LfdYwUYKQudEaHv-4TjEOTI_rCic=@1g4.org>
In-Reply-To: <iSkQcHVqeUy7WNAqfrY9xUAibm1YtrTUPIhZ_yjoHmyDissbQj04N2-quW8BURs4cddEB6bDp0BfXh0LfdYwUYKQudEaHv-4TjEOTI_rCic=@1g4.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Jan 2026 16:46:02 +0100
X-Gm-Features: AZwV_QgeFGxLSKDrCfTC2_WdRJPmAZnyXy9FuDtyjRvMi3SE1BesfQq0PTs87k0
Message-ID: <CANn89iL7_c9FRFUjwacSGHS7K0psFiLKeD9-NcP6Aau14_i4GA@mail.gmail.com>
Subject: Re: [PATCH net v3 1/7] net/sched: act_gate: zero-initialize netlink
 dump struct
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210788-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid,1g4.org:email]
X-Rspamd-Queue-Id: 903F759A26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 4:26=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
>
> Was looking at tcfg_gate_entry and tcf_gate along with this instance of n=
la_put, but I can't find my notes and I don't see the path currently. Like =
I said, remove it, I don't care.
>
>     if (nla_put(skb, TCA_GATE_PARMS, sizeof(opt), &opt))
>         goto nla_put_failure;

To be clear : we have the same pattern in a dozen of net/sched/act_*c files=
.
syzbot already found the problematic ones :

- net/sched/act_ife.c
- net/sched/act_connmark.c
- net/sched/act_ct.c
- net/sched/act_skbmod.c

We already checked all other files.

Unless another maintainer proves me wrong, let's remove this patch
from your series.

>
>
> I have months invested into the UAF though and only just in the past 24 h=
ours was able to stabilize into user space, so no effort whatsoever has bee=
n put into defeating kaslr or anything requiring infoleak.
>
> Look forward to more input on the much larger issue at hand.

Sure, thanks for working on this.

