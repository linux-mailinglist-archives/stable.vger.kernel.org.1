Return-Path: <stable+bounces-250017-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PAzM3rTDWrA3wUAu9opvQ
	(envelope-from <stable+bounces-250017-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:30:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B0003590E1D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C70C30144E8
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5683EF648;
	Wed, 20 May 2026 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTJOwU5A"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F4E37267A
	for <stable@vger.kernel.org>; Wed, 20 May 2026 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290641; cv=pass; b=TYbIAMuVck1oT3NEue39AK3yivJPmfqT586oFM0PisuvsyhFNbHSgS2nD1gc55paeJxMM6RbsFX1dhcjgStDXXT0MEXsopJBHXqxj04OM0+b9f3kZzz1MGosgSTyYsdOVJc9qm/bYRXSxxPKxGZ4fEY9RRAkjqzxQLwCm/bYXwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290641; c=relaxed/simple;
	bh=nhJVaTSldyj4EE0+Nc297Wmb3CYpNc63fxJzjQnT2yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnXs5liqQ9yDNNvEtagrDp6Rb2JRgXptuvRN+1tfXwyxEtrAqJeQX9bBk714QjruLWVoJpGolNTCUIy6N/mt5AiNynkrZiELHoQeS+Voj9jy2vkejnCuu9PTfQ+/jvTq6BaWBpTnTSq+15HumUYThKz6VEPgGDdYiPy84fEVnwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTJOwU5A; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7cff695e6b1so18714707b3.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 08:23:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779290639; cv=none;
        d=google.com; s=arc-20240605;
        b=X/ZlQlYid79iVGdYR/sED74NMXF9cLw7oMYV6E4wutAhGo9jCX+6qvBt39jCZN/Qfh
         q9QNEk5zcLmBK/s26khlRrJxn0arApoiJr09/unpKeoyM1QUJmv4YCgB4258sS8RDit9
         5+4+7S4DAumzK9VDfL3QXBD6zZBtwMtA4IDZprLb8u2JbIreSMnWZf56d3kRoIdwbX7U
         mhYKYaN384pg9C05/yg+4zCMt76iPLCZ06VUHPr2vkme8MYTz+R7s67OjrCTqQFYH7oY
         UL4bdBBlVHFki2XdyZOnEEewdSXe1Yh4RGANK8FgcJ4iF/1sXzD+nSCuXDksVhSJ0paE
         OndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Euxc0H4BAZhBGnIdmaTMWo+RLwIiq4MS6lUzgVBLZco=;
        fh=9nFDpRQONZa0yWMNR7RkYlCa//bMqfCU6IFmmhdGzMQ=;
        b=CcoGv3yYKLaS96NG2++yC/IG1zBwE474xHOZU4/L71aZtZByHFifpTNQpPkX2XI+6z
         RHhQZLSZbmS5QaoUBlQA+ID8sMX1+zqcQ4NdM57jV//hmJGWXHN6pJn38tEXJZgArLTq
         4lqDUNUB669/51st/j4tr5zqzJ+7syayX2yF4eubTHLLr9N8O8f3JEdIh5IFZqCpVHKZ
         uujbF2nsdo8z8jBFzGUFIB7kM4v2RAvpU5SrB2NdvoY0qbJCfGvzveK4T4f9+uej8Bkr
         XdhRAYs/ikUNPakgqFTg5WIK9jSYyni+WYTQkB+t6PPO+7a8ySzOKEQN2lmMOvc/advL
         OkVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779290639; x=1779895439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Euxc0H4BAZhBGnIdmaTMWo+RLwIiq4MS6lUzgVBLZco=;
        b=FTJOwU5A5aFXGnZxjaBSE9HvcqwFUBXOmY0yi69GJe9N+VZUCmwwR3E7hBvW3MpGZp
         6qNpD/C0rZDRwPpJoeyIQP5znrZ+m5nUInBh9ywRIO4F9S1XVJaUMKdzBpqJIds0Bwye
         NZlXEi1PQl3yk+c8aFezB+4jLYIm0YDCocz6RKRWeMzDaP+v7WmXtCBmTWOJFjOgivNh
         ibg9tPh1ZavFmDZLl+R7gzj4QLqiBSWz6OeSW5INrcJE2RsAdCIsTlscWEAdqPhVeZ5v
         qpqph2ScaSicUqQvqhywPKeyTM+GYXCEW0lShPb/CdCAo+ChGoHvKTDB16MuuYNJTOFN
         hvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779290639; x=1779895439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Euxc0H4BAZhBGnIdmaTMWo+RLwIiq4MS6lUzgVBLZco=;
        b=UVf67ubE/cVB0VKBwba3MiHz39Wv3ApffUjrWwuufB8W6PXWvZDVsDxm4brYfACNYh
         VhszmXsI2kAlv+h3L2EKqxE2Mp1tpua81CW7hhk3mO3jZiWCF6NZbX38ju3ePCvBvATt
         Q0KyLjl536Xq0DZbwJkrrgvMbe50eJwsjkhaKuZRjcEryukh40uFcaQBJwpsKQ79B3u6
         0ZtiKSw+mzpGJrmDE6pDZIpTyShgCvg/IQqisbQ7nqMvTFJEJarnltzobFy1CcrSwLDb
         Y+m/wf0ImI2HxSBEhxf2FTYmaVBnRbgBemEcUQ3snoK5nTPEV2ps5W2HpMmSVlQBSahq
         NRsQ==
X-Forwarded-Encrypted: i=1; AFNElJ9NNckxMbZWCWl6GOQmPVi83dZ3IhBrAHi1OAYCGMdNT176K/D8Uy++Ox1hcMcmgAn0HcX7FlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4+pOJloVReuLt/9pl0mMWLoBq9oij9l3dxxUgTscv5lQ2W/MF
	LXXoZYZs5FYlV5BQQqiiMBh1oUQNSvMIg/x171A0Q/9eX6zXMVW3euQh5lW6dxjeHwCcdl5Gyr3
	UVxmtD5JV2HVEmjc+xJ4HS81UKTkFelo=
X-Gm-Gg: Acq92OH2vgJvtvKz3POBLa6zyUsrSl27GKn3wea5cbcs9GRy655IDRVspjoiJ7atbMA
	Ce14vtiDy1a8fivpEALAqyyEOsio5GpSP4iGh2EU6lGZFDrH+sI/Se5VPt0/kJHZfgrJpVHRAIn
	XgMGqkDJSKPHFDI3Uj2r5NLB8sW8KPEqD2TsB0jQ5VEk/v+gr02gII94dOsc/is+bIGkmFNvZEx
	lxJIWX5vN18BQIfgHJ+AcN+RbiULeC4TsvTuj74gFtpOyeE0rY/EiyWVlf7Y1tgaMlWHRcw8rgm
	CTo9vetBXenmIxpLpwSqmusCYPyNb4wi2cZx
X-Received: by 2002:a05:690c:5c07:b0:7b3:edc7:9b8f with SMTP id
 00721157ae682-7c9561735f4mr253587467b3.0.1779290638916; Wed, 20 May 2026
 08:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520135034.1060859-1-michael.bommarito@gmail.com>
 <CABBYNZLLw=VFfjaF_TXA=5ZgDt7rw=XgUULoc4JudMpUBf_BWg@mail.gmail.com>
 <CAJJ9bXw9r2XHYMkmjbJ9XAiGEG3VEWK6bjKHbHgwJqnOBzTu9w@mail.gmail.com> <CABBYNZ+q1c+3Su_3_ib=zbVMD35tgwMGjdV3OwM5a3GXOq1aRg@mail.gmail.com>
In-Reply-To: <CABBYNZ+q1c+3Su_3_ib=zbVMD35tgwMGjdV3OwM5a3GXOq1aRg@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 20 May 2026 11:23:47 -0400
X-Gm-Features: AVHnY4Ly9EYVafSVpHEUZjoh9JHHvcwwAHH-2CuJLkG1smBNZ9aE0PeIcKBo8bo
Message-ID: <CAJJ9bXykBr1FQP8++kUL7ceXKp2u92+zySCqVEQqCm_+KLXj0Q@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250017-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B0003590E1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 11:19=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> This coming from the spec is priceless because silently discarding the
> packets means the remote stack won't know the responses were
> discarded, causing the stacks to go out of sync. We also shouldn't
> process packets beyond the allowed MTU. Therefore, I strongly disagree
> with the spec requiring an identifier on the reject, as this implies
> that even if a custom MTU is set, the packet must still be processed
> if it exceeds that MTU to find the first request command within it.

Should I keep a verbose comment string about this rationale in the
next version?  This seems like something that might trigger questions
in the future if there are issues between Linux <-> noisy/buggy
stacks.

Thanks,
Mike

