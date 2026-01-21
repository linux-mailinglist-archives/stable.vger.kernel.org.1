Return-Path: <stable+bounces-210747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL09KQHMcGkOaAAAu9opvQ
	(envelope-from <stable+bounces-210747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:52:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAF5571A6
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6598349051
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 12:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245C147AF5F;
	Wed, 21 Jan 2026 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="TsbuY5Rb"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3247D330305
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999386; cv=pass; b=e+eDD72K++AWBnfuGDI/dhdp9nRUkR0RrfXOXTo2V7PbVBMRvm6pnlq57IeJ9qLpJrjXdzdAdNTjqZnoDJySS6woKN6bwIJHulOo8jowGGcxa5aORROLewAon69/4+nTIFCruT7eF4T+0gpI0rTAermS6sEsxXV7z2fesva9buI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999386; c=relaxed/simple;
	bh=F4W8QEgzjnO8NfDhGCcs69hZH5D3mlX7mCIdRwUXGEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gigqft/lNa+YoDmDIxtlBC9slquFSc9mfcz0/6kCgMpErUvfRYyqef+fjHEEncYINGRuILH+1zDOYIU1bc7JXuDpmx82O3LgNgO/hZk1U/PjgCnQJN7Py27sGnLGbKstXs0awfGlOA/AqjDAh2rlpen38zmxBeORsIWqh7hDdeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=TsbuY5Rb; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6446c924f9eso5422835d50.1
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 04:43:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768999384; cv=none;
        d=google.com; s=arc-20240605;
        b=IHATZZ5fiZ83uR+jcKGFdnJwR+xBuR9ACaMcDRhVHkudVqW5mscIdv7tumn7LJdEQz
         2oC1xJzTK7hXszqEKJxAfJ6ACo1qc7L02FJ3Kj2mNxa3WEHPjptX/R2cu6ZsspO61SJh
         S+6l6PTfkfAw18Z92JMKsLCLwbGg/em0o4oYrWPhJnqNMdRfHxku+Zf6GKZ5DMJRaBoo
         J3VAKhik/iHI0A2ozYsAKWTvOiFhxjIBA0F/RQ4bxVcysj2LSS5+Pzz3wdImkgzKDqlu
         Q8v2zD8MLf1dwyDXT4GKJ+TIVkWIrQb8qruyxhs9VcMvdEwtR3lFz4zvPwe9onfboz1W
         JZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zzquMhNeBJPqbj4nPsbpAdeLaivWEBnUHnDMfWUomS8=;
        fh=8LX2N4heL1Rw6pLxDrf3uE0ui8BjyUSsizC8wQ0JsV4=;
        b=hk/TU06AfpdlR958vIGrA7pDYZDzp8KNHGb+95UwhH6MRnIiu3KfXnAXqNGEsPo6UN
         eRzfFwuY+rx55osksMufUrWSV2qZhdDIYwPStQ2rFHsYlkJt9NbfTj2poVGU3y1nFCqm
         1jJmSfOCd7x46r2roS9pV5gaxOb4YJSPXabpmJkQ0DBePAXBONgqAoapV+BSrzZ4vibx
         Mg8b7LZY4c8BZddRrfe5o87qSdE51nUoMfrmh5aG6TAWddg+2vP1Ts+3erKPXpFicDmP
         Jerf77nLX7rH9OVo5vW1x+D6WgJLfaDUjohqAxVqR9sEPX61SJ1lMt9x5hhpVxSuXnvU
         VaHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1768999384; x=1769604184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzquMhNeBJPqbj4nPsbpAdeLaivWEBnUHnDMfWUomS8=;
        b=TsbuY5Rb+KFhYuvC8KhNTsrPdEJw1hJdvtnItIE63h5atl8t1tKFEfgXRbVycRm7P6
         8GVCnbd3+VyYeGy040QMlvDeOtBlPhwAFrHDeytyu5d9pnlJKOQlo70uU8ITGVE5F0kq
         T8iBRpq7KkDVtlZJcCKdqhk6dQOKcwsyeDpSbDCsktGp+fUMWq4YP8KJEcbAyWIggOvN
         SNLWK6O7DqWhkTHU/VUx9gCXZe3+/mxcdblex2S0dlhDATmApBjdH86W2qHP4PVdgRJG
         mF1qE6k6meLeUThbxj0OuSNyXvlR4+olbrMg+CrEFwjTKGQKUFuAhl364FbC7subqop8
         Qzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768999384; x=1769604184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zzquMhNeBJPqbj4nPsbpAdeLaivWEBnUHnDMfWUomS8=;
        b=PFZBNHosxemmJm1aGLb4QN600bU4v4eqyv9h0LuowTWi8Ll63zfevFFy7HNwIsHZ+0
         vDxBEbRE/bsWjrDhTyB4xpKwC9oA9DWw3bv3p74ghV+2AnpOvWAgK4zkxeYqt+yBjqkr
         JGrlLllCBcWriirAKG7OS6b1GL+Dgi4pgnH6NUDBUKaIjWF6sbXB8b2iLYe2+d+zafYP
         67eCZfeat15sfC0Oh2MAex0OGeDciVldnrnAYfxEuXBh+oIpiB/fJvKqKfDUM/5ZHAnh
         5ySSJayzQ23QRMtjmHZNMNHkOQ/nEaBPoEMN9a0nGcz81cP8rMj0gOXsF7o0eRETQppj
         B/sw==
X-Forwarded-Encrypted: i=1; AJvYcCWcKpRf9xlGGQuXtfhrRcUm9SoWQuEJfbo2W8qDyLp3vup84J4F4kCGA4hFkQHXg9hHgU6lULM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylEdpA3L25PcBnFvwzbIhoRes+93xzPY9bmf6wIIAxAMrPp3by
	PEhhE94NeynuQYxBKXucvk3B4l/grun6uC3te5S4A4XK+eWsa5Mqk+V4ZZzgeOecZDmjstLIUZF
	8+hWnGDrf+tjSc+UosrQjBBblcmrVrDD48JqJAyUz
X-Gm-Gg: AZuq6aJwaK0svIxiRRyWUs8R0s2+QqcACdSuSSOdjrV5BIvi6UTyy9oMwiMmf3F26XY
	2oe8ct0lElDH12G3F89i00p4h9coD7eQ6UN1UvvrpkfWw9NXDDPSCpNP4Qs9tPWIKGYQa1XMzb4
	L4N+bm9qI/7DHRHK0NSjrO9BBMVgLd9hnqGZTfNAKM8xriRmLNeAF7DmzcnJ2uaHZ2wXWihAjmA
	YzFycexeEOW7RuUyInTLV4eREORbyPeZjRuiWOr32Niec0qFcaNklZHdFn12N3AWlphBTm8NdhM
	c6piJRbGXQ==
X-Received: by 2002:a05:690e:e8b:b0:646:4f86:4f1b with SMTP id
 956f58d0204a3-649164cd9e6mr15934562d50.61.1768999384151; Wed, 21 Jan 2026
 04:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120004720.1886632-1-p@1g4.org> <20260120004720.1886632-2-p@1g4.org>
 <bff53f0a-2c94-46b2-bb49-b05d10ae420e@mojatatu.com> <4v-I_ZuHhZBLG3lGttZ9HHAT8n_AggP70Rw2IDrj5w6BK_Ol2VoPsR9eP-BKBlLToLNNCElTtbXdTRdD1wsR3QzlCoSaBi6R7SCPn6CDk5c=@1g4.org>
In-Reply-To: <4v-I_ZuHhZBLG3lGttZ9HHAT8n_AggP70Rw2IDrj5w6BK_Ol2VoPsR9eP-BKBlLToLNNCElTtbXdTRdD1wsR3QzlCoSaBi6R7SCPn6CDk5c=@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Wed, 21 Jan 2026 09:42:53 -0300
X-Gm-Features: AZwV_Qg7ofwKki90DQFLtomP2kQYfAp7dIw3Gs39PWW6oR7LS18XId3KbNW5jeQ
Message-ID: <CA+NMeC-wBDTvwvxAy5Za5Dq0wXpqYHNVPV_wKk-kfpSyAWCPPw@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-210747-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,1g4.org:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 5AAF5571A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 10:00=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
>
> > Also, the AI review [2] pointed out a real issue.
> > It's easy to reproduce by running something like:
> >
> > tc action add action gate base-time 200000000000ns \
> >   sched-entry close 0ns index 10
>
> This was never allowed. A zero interval has always been invalid for a gat=
e schedule entry

The issue is not whether this is valid or not (as you said, it isn't).
The issue is that, with your patch, this will result in a null-ptr deref.
You can avoid this by initialising the timer before calling tcf_idr_release=
.

> [...]
> I will prepare and test v3 with your first 8 suggestions and await furthe=
r input on best practices for avoiding a monolithic patch and on appropriat=
e levels of validation in this specific case.

Ok, the main suggestion is to logically break down (as much as possible),
the introduction of RCU and the other additional cleanups/checks.

cheers,
Victor

