Return-Path: <stable+bounces-210745-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKxWBATJcGkNZwAAu9opvQ
	(envelope-from <stable+bounces-210745-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:39:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 933F156EC8
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B4424611A4
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 12:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFA3481241;
	Wed, 21 Jan 2026 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="nRZPBbDk"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D385D500963
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768998926; cv=pass; b=Hs2fYESqBVGOlw32tjTQ6QPe/pyM6k5sH54SmM0JYNC3vGeOgztKql7leAyY7Dn48YDbYvsTeU7G9oj+mIPeDIVZJ7wngoJG3J2EBNIrLjq1tB9wm+2cG/qvrqdShIVDA10qcOhpf05QdPclcy0lUA0fNUNYI3FUEGAt2RrCAFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768998926; c=relaxed/simple;
	bh=609IdniIhM5s9yVyBkRF8UQSbuSI291Te2DEagXPIwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFbUwiY8APDUFlF9WZQXryZ9m2NMIkjW6tqKXnUyl18YCeWTSWET/SbNbj/vG5tu6AYb6+EMUUk8FVxuKaeaAWNGrWCDH/ou4sD50aYafLSIzVHCPZktWDtevU5rLYCqu5VU/x9wZw1FaZ2JJ3bmBspOnUCK5/5V6Yh8uqFkjHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=nRZPBbDk; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78f89501423so8838697b3.1
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 04:35:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768998924; cv=none;
        d=google.com; s=arc-20240605;
        b=bZ3OmcVKQ/E9nutdfvDlTa1UIyOZqbJ6QuEsC2jSjFFWBylfQeUFNLEbpwwNyqC2q0
         0TrunOD036uBHFaVAy3H0mDjN5SlGPbbsxJHki4x50ht4U2guu+sqiPxdwF4SatlcuLU
         P3Wh46Ng4oIKioYjKavsgDAnP/Tj8LN1/yG4KY8lpB8lnV5uQeuxJlhYBvWzsGrcqcEP
         PrjhX8qZ2cfXDWAgy6Frsu7LlWxMkmOVnW6IUGJha79V9g63trAfnuiLCRg2c2WadH/y
         HbQLvBlwbFOBOBIinn27So41qv3ymLJGrRnu3KmQpNfBU1fIru9BzUvPSO9XwYmJAZvc
         7eGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h24m7IYRVboGNSvzoCdzZL4vm/l2kIr0FMfsrOCBUd8=;
        fh=rFuAMke60tNXEwq8BFv+recvLIN3avqokZlKSZJowy0=;
        b=d/IICRwL1lI4Eo3OLHRIWAErsgVTdXN4LeYHXct4k1SJRxJ0LFlKQfi/SNYinHAXfv
         8Rd8ByVTY13PTbPjENmVJscBsk59qiotGkxcbv/j0Ptzz5KCiPiQVOE9Ntq7qsWr4xQq
         zCYplFyGu6+B86w64mcp/RzAAMlwF+8MK3+j/XaDjaIKP0fGrtaFDG9w63mNcNAiFqKs
         s7+yPRRIIWTbQNiQ3Y0Nx3pjMqM7WHrFoN5ijXeRw46ApfE6vqHq/gaT9w3ou8nfvruK
         YxlpruIXxxWEYRefB9AkWkMxNT4lznCkuodptJNP9QOniOk/hLOFslw1l3zCbjUWO3jK
         rERw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1768998924; x=1769603724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h24m7IYRVboGNSvzoCdzZL4vm/l2kIr0FMfsrOCBUd8=;
        b=nRZPBbDkQqfy7W5qd1QsOz0qHVFqTKNEdPUVyw+7tvfeSyBPVPazf/pc646IsF7Fkf
         HkUC/PV7HdBW8EvakWRgxbsGpWuZakaa5q42XH6P/xz7LFlGm77kaSg2YngrXTuHfDhI
         +DxAjz3eWjVuhSHE01p2a4bAlvjLlPJm5MNwWXG8ufJ050ITcHEKoeBsj21Dv0lzfRa4
         o4zDzblcxc9CJAH8pL+puN3LnVaD1Nw/AS/HU6i8FMWTXUtBjdTAAyBm/WZVsGn+WPtO
         Z5lbE+DA5VnRAiTIvGJw9fgQOm0ex5lnS58HLsieLXfF6t1kOknvjM0e7TWo4rHJkJX7
         gb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768998924; x=1769603724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h24m7IYRVboGNSvzoCdzZL4vm/l2kIr0FMfsrOCBUd8=;
        b=h/BGgLQEqLj+S9MGBERGN14S29AcjnsFvAm2+pQiZ1ywrwimnvIeM6IP23Y57/Uwnt
         UsWuNoDS25hZSqlXLkrCLlUdDelo7vG8sQtubfHPvxCWLt7O05ZkNGwnoODSZReOlHww
         +nVTD4uUvNzfJ9WJGyX9/Dv8gTrL2dhzqWlPM0IoAqXjtj5931GKxG8PvXK8oJSzeNnr
         7hlZ2hCMMdjU01yNw9bxeou5szxqAXBSco18bUy4RbmOkP623mQQk1CJ2jyEAOtbrQaa
         XIJA0kibBpyshOwKWgtnnfYhUNx6mAyNWSlGcrJZhIfhgmkVl56Up0kdtmke0g0qM8Ns
         iWQA==
X-Forwarded-Encrypted: i=1; AJvYcCUMVxkQcr1i2hb/t7mlrn4Ghusd6HtemcfHSqbEYRyJTbN/LVWaHSTfV/zN3kGEb/rY90cQMeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEsCq4Mf2cNd8C6By6wp+cHUIGr8r4gkRMBz93gWa48zOPezzI
	Yep7rcKgSPi0xlDFEjz7GQwNxEU+VBsuPJxg4Dyq7sC+/i/Oos/edqEGF/3szVuLZg9+mxKAXhn
	YRC9sQLy4UBcjqhYiKY/no5UI0pcDDUh23ZRPTT9j
X-Gm-Gg: AZuq6aI58HtyLYINSgdaMR6mpOBUFOAevp7b6XTztNHj9POGXfTPJG+ZFs8e4Px4Gez
	mUL1YVvb7tqNL2Y6kequ1nwixUNKGQMMRP4NovmzeG/fXgpw8lh0wmfjFtHl3zBIc481sV5SMz5
	pchMXcohN/CMSvHdj15IkWQKmPwijstyrbO+0wuR5SRYvY18ZUqfaNT+9UBPjvccxfbSMhdcpzJ
	Uiw67/2jUG7P6J/Nj/3v4kabsXv8DT1VMzBQTy6lnqoXxjhwr6hIQYl6opF+fnUfagWABEBnxVd
	oYIUwi7Hig==
X-Received: by 2002:a05:690e:140f:b0:63f:b6c0:23f8 with SMTP id
 956f58d0204a3-6490a67fcf2mr14852507d50.33.1768998923702; Wed, 21 Jan 2026
 04:35:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120004720.1886632-1-p@1g4.org> <20260120004720.1886632-2-p@1g4.org>
 <bff53f0a-2c94-46b2-bb49-b05d10ae420e@mojatatu.com> <gwO399q2_pH73eDkd2OatN9SsR8aHtm8CbVIEPOf0nuxXjqbjY6vgCqNyFya75mMVicn8NwUgG8zaNFkR_JuZmFk0UcWNCHlpzSxFbaycf4=@1g4.org>
In-Reply-To: <gwO399q2_pH73eDkd2OatN9SsR8aHtm8CbVIEPOf0nuxXjqbjY6vgCqNyFya75mMVicn8NwUgG8zaNFkR_JuZmFk0UcWNCHlpzSxFbaycf4=@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Wed, 21 Jan 2026 09:35:12 -0300
X-Gm-Features: AZwV_Qg4IJvbjcPkkd12nOg6R7TlbuDONp9DjdoNwNbpgpNIh0g51NPdN2LFABU
Message-ID: <CA+NMeC__K6Z4MyEK8DPTQc38AejwzfyWHckyr63zwL8ZqT24_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] net/sched: act_gate: fix schedule updates with RCU swap
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210745-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid,1g4.org:email]
X-Rspamd-Queue-Id: 933F156EC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 7:47=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
> [...]
> I=E2=80=99m trying to strike the right balance of input validation for st=
able. I kept this as one patch because the validate and build before publis=
h path is part of making the RCU update model correct. I did try implementi=
ng the additional validation independently first, but it did not meaningful=
ly reduce the size or complexity because the RCU swap still requires a full=
y formed schedule object before publish. Without preliminary validation, it=
 is easy to corrupt the timer state or end up with undefined schedule behav=
ior. At minimum, I think we need:
>   - interval > 0: prevents zero length entries and immediate refire loops
>   - at least one entry: avoids empty schedule deref and undefined state
>   - cycle time > 0: required for division and close time computations
>   - overflow checks: prevent wrap or underflow in close time arithmetic
>
> I can do the conversion without these checks, but the resulting behavior =
would be fragile. If there is guidance on what validation level you would p=
refer here (minimal representable range checks vs stricter sane inputs), I =
am happy to align with it.

I'd say, for starters, try to keep as much of the original code as possible
whilst introducting RCU. If you think it's still not "ready", you can post
as RFC. Then we can add more checks (if necessary) as we go.
I believe this approach will result in cleaner, more maintainable code.

cheers,
Victor

