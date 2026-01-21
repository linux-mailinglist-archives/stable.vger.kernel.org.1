Return-Path: <stable+bounces-210762-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAzhNPHkcGk+awAAu9opvQ
	(envelope-from <stable+bounces-210762-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:38:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB2A58897
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33D19A43F0D
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11AA4949E9;
	Wed, 21 Jan 2026 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUU72z7Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A5349253F
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003332; cv=pass; b=OiqaCSL3BA9Hj56Hfg4K73qpWXTthCWpLm0c4FzlKdt8QtpidS0o4BLgGvr8eISja34+qPDClIiRTl45TjwimoJSVEKuD6Xo8UGIP3mc6EPfjTM1Ac0/wFyEe/XCYiele6oLzWcHzR/Yixv8cW7YfyYOmll7i05EBH/42zIWld4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003332; c=relaxed/simple;
	bh=cP7+lodeQJW67tiROuU4iCdrxhUkaMFq+EWtWSOxqhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBiV0C79OhIqhwrpczl/3/bMFvH0a0t9G5V2UqJaAx+OSDDdfZqI3yQsq5JQVGuIiD9eiOKUK+SVVU8y24SoVD1ofgLc42lqp5owumX6Y9Bflh020U+I/M93ghRc2Qa3Y7PJr01SVI14zSRl+OwEzchAdCDo1B+/pwfXKZ7xPjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jUU72z7Y; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50145cede6eso52653561cf.2
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 05:48:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769003329; cv=none;
        d=google.com; s=arc-20240605;
        b=TbY8OqFoY2fF+CIFtTp1UsSI5JWOrpRSXi8rgbrIAgJ6gHPlBI5sbUW7vHRb9NeT19
         fnJ9DZ5cAFQMSlgdr8dJZU/dFz8ggbxJZeGF0HZ5+bup0Uf+fTAk4AQtJHZFfF8u1UX9
         pqMJ+XO7DUFeR5KG1JzJBl7e2oSU1IMeaijujYOrXD1pTXE95sDWK+NCVQTIuDcV+NeT
         NujFyhTLciY9fW3xsFaT52R7eBTBwjQT/tB7Ec2w08+NF7t/bHjLff2ZZfHB1I/+hx51
         1VCfAprzF3QPJl7U0O7x8vvA9iWrpjHOTYnAz2fhUHMTjwiWUYfgD6elQPNNw9zk6KpD
         Vlpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cP7+lodeQJW67tiROuU4iCdrxhUkaMFq+EWtWSOxqhs=;
        fh=HJbUyrKQql8UP74XQpdCWnLxRVA3lk/bpMLlyUFcFAQ=;
        b=CcKel6FzjjzRG9ljZ6JOtu0D5JzAEyD4/O4sDq7bvuYr6KPMuITzTqj+6iH/Q2H8Wj
         C9Mx4anSefJNM9zIhdPve845uPi9wfnFoyEWCJc8cOiQiPWW+lzWWIzNFrOktGZjF4ad
         kNKWnH61MVM2nyeFDv/+QNa+GQGx9Fde8Dki74D+Xo2xTIoiU9eCp2BxhjJd0HGfTnY3
         Lur/X72xK90nQe+laQeDWrB035gYqOJCbWUm8yYCGTJjFxkGVXvE2qhHc+r25RvQ4gEx
         tiCURbhxTzFB7FbO5qNXzHfl+Fv7N6F3bQRQprgEBCimVe7gExneCbOEy71kWtCykzR0
         pLbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769003329; x=1769608129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cP7+lodeQJW67tiROuU4iCdrxhUkaMFq+EWtWSOxqhs=;
        b=jUU72z7YCEOCM9xWJ2XbVh3EiIW1784rDdoT76xjfSYFNyP76lTfW01kQ3H+GqW2+5
         /MRW+mdG5xOlvuKlFUyfRvFazbVT4K1Rn9NW/baH7V0kk6Qubc/PtkCJtIu7PYo0WDV8
         WnoCSg3glYDaSlpF8P9ZldT/fKVz98Eas9UBYxVKUQHFVyeso/b8nV9YIIOVrh6d1t+R
         e3ZsdJVipteGdcHEUDUq9u5HtWUQY8vB9CRY2sbGzCiAAHted5GJ+Z9eV2epMzKZTwRq
         tiUtpU6nwEba9hdOmkvm1A0Df+0QoNJQVnEHaChjMUSQXcJVF4DH40z8COSC8ofPDIPr
         6DkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769003329; x=1769608129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cP7+lodeQJW67tiROuU4iCdrxhUkaMFq+EWtWSOxqhs=;
        b=FCaW2vaz9XlGTP46mjU16gthh/7jHEbMChW/mfoJ6kkJXX6Vp+9IhKR/fB0mZUSW5w
         jM9dnCuMCw8aSVC62RltTjnlJORCVeBXZloyqVp/MZm6gUq+qI9nSX5SFlkhsIhGhvMK
         2p8KY4mO4m9mQB+wLgx/7uE3e21CvehhkVV/aGGg442phsm/3B4VYUtu1z4/t4ss5ltd
         h68x5e3nhoKCMP33CcyaHa45iCBZfHWY62hq1fZhjzQC+PZPoo30fUCU0cVLq1Qlf+ys
         xG96XgttZ6bXoNjC0htgPt0CdD2QmPonBsFuFPRoRrn1e2vxL4218AuHTnh1JjFkyLEz
         5IGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHB8l5eGrzDcfKwPXsEMALfx01Ua766CIcX893C4K9D8b6jDRA3mftNaZeaOhTiebGYM2XVLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/z1BBtjtBL5v/luWYHSnX5yVozFIb6lU8rjEehS9EPVfY+3U3
	kyriPc6O5R8rN4dMGj+4cc+LktFtEo2tq2uV7w8BXDrbt/MKgScCMNsA2cBZ3iflj09lX9D5P2T
	8nQY/i/MJVqlXNJvitLrzz3PEI0d8iSQBSRygceU/
X-Gm-Gg: AZuq6aKyn4nj/qNXTh7E3AXd52BmWEWXiym96rFBqp8X4V/dw5P6VU16lfo/B+pv0TT
	mRDi74Qovv945wyrFhhrmTmdszZKuG8dR8uP4wxUovFKKERUsaDGrO6vomIZwb0g0JH0ISskmrg
	VxH2jW0ZFWcpoLZHcdk19q7vK3XiaO6kvyj+MTnmpLpzU0A3iLvby2fctEsiT372cSSgz47UGaY
	msJHnPjxEm1WbRi9WquF7vjOSLYEa10jXbIXb0XAkZ1RAmqqruhIsID9Z9eR8SveIRndDQZWkHW
	6sZohQ==
X-Received: by 2002:a05:622a:1a9b:b0:4f0:2afc:3b80 with SMTP id
 d75a77b69052e-502a1f32911mr243056121cf.56.1769003329341; Wed, 21 Jan 2026
 05:48:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121131954.2710459-1-p@1g4.org> <20260121131954.2710459-2-p@1g4.org>
 <CANn89i+8_ZDxVGwQmo_44iCRs5Wexwxy1Wfhw4WmYg3qA7_t1A@mail.gmail.com> <BSn2a6IWtM_DnDrcd-qDBm8cXAwXPo3xj1l4Eu4SWy3BS2UW8Aw7-gXW6uo_DaCipnvmSxgDeGEQrnZ-pjqRKSOPPUW0usVN8M1lp1J-soM=@1g4.org>
In-Reply-To: <BSn2a6IWtM_DnDrcd-qDBm8cXAwXPo3xj1l4Eu4SWy3BS2UW8Aw7-gXW6uo_DaCipnvmSxgDeGEQrnZ-pjqRKSOPPUW0usVN8M1lp1J-soM=@1g4.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Jan 2026 14:48:37 +0100
X-Gm-Features: AZwV_QjfkzxcsqX79MNZYV42WjEJav4hyCpBb914c2qgdnj1wjV5tfKlXRSh1Pw
Message-ID: <CANn89iK_VqOThsWX2b-JwvF8suBVmKEmMm9D9SeZJBamDwfPog@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-210762-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cppreference.com:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid,1g4.org:email]
X-Rspamd-Queue-Id: 4BB2A58897
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 2:39=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
>
> Yes, it's not proven so you might be right, I knew it was 4 bytes at best=
. We can do next or toss it, I don't feel strongly either way.
>

These bytes are cleared by C compilers.

https://en.cppreference.com/w/c/language/struct_initialization.html

Only holes might be left uninitialized.

> On Wednesday, January 21st, 2026 at 7:25 AM, Eric Dumazet <edumazet@googl=
e.com> wrote:
>
> >
> >
> > On Wed, Jan 21, 2026 at 2:20=E2=80=AFPM Paul Moses p@1g4.org wrote:
> >
> > > Zero-initialize the dump struct before selective assignment to avoid
> > > leaking stack padding in netlink replies. This matches other actions
> > > (e.g. act_connmark) that zero-init their dump structs.
> > >
> > > Fixes: a51c328df310 ("net: qos: introduce a gate control flow action"=
)
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Paul Moses p@1g4.org
> > > ---
> >
> >
> > I do not see a bug to fix, current code is fine.
> >
> > act_connmark problem was that "struct tc_connmark" had a 16bit hole.
> >
> > No such issue for struct tc_gate.

