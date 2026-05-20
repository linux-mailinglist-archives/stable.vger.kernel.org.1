Return-Path: <stable+bounces-249743-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI7IOZM4DWpjugUAu9opvQ
	(envelope-from <stable+bounces-249743-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 06:29:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB895877E0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 06:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21224300EF7C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 04:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B7F35C181;
	Wed, 20 May 2026 04:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pf/xdFFt"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EEA3101A5
	for <stable@vger.kernel.org>; Wed, 20 May 2026 04:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779251338; cv=pass; b=PQglagUaQEZo5zPKP/YEk4pHMfwx6215/pP3otFCOahazbgxhtqzlktq7F4Nu0KOgtJ7rlVVwz4w1cAJ5pk8TaEMsLdqc5DhBoBz6OHxuKv6iSjp0fLGfLIbgghd4xESG2y0TPoLz/FwRogP1gyoU0pJWHB8Y9IFFf+bvMQw1VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779251338; c=relaxed/simple;
	bh=/JOTsuNNwm3OUcz8Y8bCu0RJEPYgzgrSgRWrrAjARiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUgNz1bxxADSK3TGc+zgK+Rq8IKC41ma+ho4iHqJytfm3zCe70KWUc31IORCB/rXrtVLX7EhXC2V5pXtbbs09wOVyv8Qb40GX85/mLVNl5XU8X92+gulwTFchgUrrL6dmFbvwlFDeaIfVhCWFy8jypV4hBJvS7LfKXzIrbn0vM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pf/xdFFt; arc=pass smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-5a995ab70d1so6687569e87.3
        for <stable@vger.kernel.org>; Tue, 19 May 2026 21:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779251335; cv=none;
        d=google.com; s=arc-20240605;
        b=ICSzNBzoNnHcnmlRIC1E0WTGhCnF+cF1h1hDVF1ssRjTfcu6S3CHdHy5YYd4XcbuzB
         Z6DQ8k8bSpGqN7J50eu89fD8HovKBOKnPFcL5EusIs7guj1mHiZG25Qpne14Yb16+Ibm
         bahqJ346DcY8RR1FmHG/xLZuuEqUU/tKLOIQFmQjuQgqqhEJrJKgTumWoY980/EALXs8
         BeqKQBMaJ+4M4PFcIksIf0xi8MpiZn8dPgQdVUL8IDnsQQmJlc474z2km4qw3qNxOdZV
         HG+tc8qF6L8BqUKHGSxQI8cMqnAsFcPe6MWwpanwwwu8fpKP21IXvzdT8oGbBKWpCH/M
         /LbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/JOTsuNNwm3OUcz8Y8bCu0RJEPYgzgrSgRWrrAjARiQ=;
        fh=qCF02cZRDYIIvjwi9zPIYJv2GfALKovLYT2EO+htzYU=;
        b=FIcyX2AHBGaKC4OnbWoXBzj2/nX4GF50F5qgHXHyTG6Ko2o2Hm/+/25tJ3RmGcpp6r
         gMFVVkC54ztNmS6PhGjzzs77N308J/bR5Tt7xpVbyxv7Cv1p6Y48RnRiRrnZl1j7aLhm
         BZlg8drE8tdVXNNrW7my/ST+TB8VrNZggv/UjkhM6KEg53rY9DbKaZiddhL7vFbDBY3h
         CkIuGkN23x18/zrmdEepmWcEt+b95OQCMyeB3MezH4RNXOa26CPKthDQLdWaU3uSP4dF
         2Qqrmq5Lc+KFatOUfv+3yNFPdPtzjwrNSxILxKisB/QzvZlk31pkk0i857T+s3saaYPt
         EvXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779251335; x=1779856135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/JOTsuNNwm3OUcz8Y8bCu0RJEPYgzgrSgRWrrAjARiQ=;
        b=pf/xdFFt04fdFs1N64CxC0xgaN2rRfa5Xp1aYJ0hEr0FlVQTG4l5JqWGzdYZxJai5O
         Q/PjDVKIg2BSkneXzSmJSgIIqHTVYLZJYj/Cx27CnPMhQltpP94bGk6zFv4n0ln5Bouy
         WnerPoDC9NnQfRUyilijsVOURO4dzwFlAfxIiPYZn1EHa4uhjt0kH8tGAKD8098ByXM6
         xnmm2kNQ2bUL3sHFZXHKMezzgrg/jpNeKN3kBpzTKfr4dg/z50C+bEULRrmCGod7mxLV
         il37h52WNVMJlIrMyVfQjKz4m9LGjjL1OeLlO3884O0Yl/Rsk8a74pqQVzE1F77lzvYu
         H8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779251335; x=1779856135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JOTsuNNwm3OUcz8Y8bCu0RJEPYgzgrSgRWrrAjARiQ=;
        b=hwh2Lp3nxgK0zd2no6AYzFHOv6l9mqh5nOp+tJcsdMtEGU3g4bg0uOUcKP/ndRJp9E
         452gQrFautUk2yx6B7Tx8HCSbYB5OT2FXlBnTNuVcQTnHqNe+kklZlyBpkL38bfV8V30
         Ti9L2tNJ4ZzmQBfrrJQR/xE5VzQOKNkrwjIAWHlN5sSb4XLqLFT981FU+QogJTR2hrk3
         yOkOUXyhgfyEUAt93iq8BsXbVRiqxrGS2LRWkParMDMXRlPt7XcG1cTAgtFg6cO9awLi
         NP8vLAMLL8zhm1zmRoHkXFWMIUDRcEKjFl81q+iGv2f/Z1OvvJEQycypUR/dcna/xrkE
         RX3Q==
X-Forwarded-Encrypted: i=1; AFNElJ/xdvARsH4raIDUO4TccdxH/4OL2/TX9Z1/8UNk9nFaFsKOC2xo380oITZZMTwS7morBsHlLAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzukbUsDsLL9eOiuXuzbd+rqxns/B/oOkHdiWfcg86LQYdeCEcP
	Fkeojwf+Vz/gE/ypSdX7HdJxXulpZ3P+q1GohybncK93eEf0PvLoayjyn1tyyPcSMICt4otLHNd
	XH8Tq0ukljePRKTIBheWpAmGt44i9Nl8=
X-Gm-Gg: Acq92OE1akxHGA19Y2ryIkd1+IGFWtQc2iNY0ofDaNw1a020Bjt0bT3XZL3uAsN+oMw
	h7glPJei/OqIeVdMk/VdG1RuWY61N+d1Yb5bFBhOGRjlC46cGpYsqkQj6MQIJ4+IYsnBiLg4s/+
	HVtZHe9Ih0noaRxt1o5Xv+lnUQJgVt2oMjk9YzLwrGoqXyzz3vSE//mvoYF8sM+r+UMvJMspQbe
	yZHnv0Pwyvn0EVYfS2wAP7iU9CUm2HwRT745bCBjvoPWifkM4UDuKb3xYnG8yaPPnTOTNJIhmJC
	OOfTc+yHfqmlE4Vq0mmCPM/xs4AW7A==
X-Received: by 2002:a05:6512:118a:b0:5a8:e32f:6edd with SMTP id
 2adb3069b0e04-5aa0e5baa13mr6949512e87.0.1779251335198; Tue, 19 May 2026
 21:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517121626.406516-1-rollkingzzc@gmail.com>
 <rclmtymkiaor247n7gwi6ggmpwi2hyu5hicggroopeohspfnyv@7ryrgezzs63q>
 <CAB7XQsGe8ZA_WRYcGgkOa--f+XdB6d98_g4VedbFPK01eH0rBw@mail.gmail.com> <rn5uidhakwmnjb4ngkyvzzjnwb573ie35xu34z4fbmlp7spd2o@hr4ifc4lqcj7>
In-Reply-To: <rn5uidhakwmnjb4ngkyvzzjnwb573ie35xu34z4fbmlp7spd2o@hr4ifc4lqcj7>
From: Cen Zhang <rollkingzzc@gmail.com>
Date: Wed, 20 May 2026 12:28:42 +0800
X-Gm-Features: AVHnY4KqC33UsVo9KfyspcxLS3cGw-I0fQb_5ohSI4s38uJsussh1K0hTuQ2Shc
Message-ID: <CAB7XQsEhgsgXTLvE=Dr92Ydex0e3jbZ1CeCs5NjWsJF6yBXn_w@mail.gmail.com>
Subject: Re: [PATCH v2] bpf, sockmap: keep sk_msg copy state in sync
To: John Fastabend <john.fastabend@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zerocling0077@gmail.com, 2045gemini@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249743-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rollkingzzc@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,cloudflare.com,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5EB895877E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi John,

On Wed, May 20, 2026 at 03:29, John Fastabend wrote:

>
> Great. I think its fine to address the tools extra callouts in a follow
> on PR if you want. If it helps get this merged sooner lets do that. All
> the tooling keeps hitting this and we have lots of duplicate reports.

Thanks.

Since we have not worked with the BPF selftest infrastructure before, it
may take us some time to prepare a proper test. To avoid delaying the main
fix, we will first focus on addressing the main issues in v2 and try to
send v3 soon.

We will follow up separately with a patch series for the selftest and the
extra issues.

Thanks,
Zhang Cen

