Return-Path: <stable+bounces-238011-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLcoB4P53mmVNAAAu9opvQ
	(envelope-from <stable+bounces-238011-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 04:35:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BF23FFCD5
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 04:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A005301A2CC
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 02:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E8B301486;
	Wed, 15 Apr 2026 02:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxQFlZoR"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232471A01BE
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 02:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776220539; cv=none; b=Dx2nwCrPwaZHmV3zO7a3SBZI4dqSmVVCP2LtmQ2elZu+my2BZFijNJSGizQYdu29JksoK3hXg3ryRZKsGyE6XITvrkSi0jsOS3Lqi6ZYGRQRfZykREIi1ztACN0msg26uo3Vo9Y2mbqCa4JmNfjBpiyM0ugQEuqKKnCdD7OEQO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776220539; c=relaxed/simple;
	bh=N7nd/B1pYZ752n6f4YzwrOygZLD87ZZMTZQ8yqMGFMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRBYG8DUh6E91TjBIdAIhpq20luV052N8n8E/MNWwIOdONp8ULFCaZM1/rZ0l5JxEiFcOki0PTAs5BomXV/0SHtbYyaXENJN9Pw3KxAyS+P9Giwd6DUljDbLHW9CDBd7pyyCB2E+Jl9foT49HsUdDbY55WY+gRhoITrCVRAQnPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxQFlZoR; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50b2ebca625so55341131cf.0
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 19:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776220537; x=1776825337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxRyy2kZK3WlZTfAxVXCb9nX2k5y4s491rvePkeOc2c=;
        b=QxQFlZoRzLOGo7XEGFiTuu3ynPzC/dTjnOrTVpiFA3rXz6E+98yyKs2KbcjcKKs0/h
         9VVZsEQRpI/t1hUX416raV4knVLK4qEPTZ55ME0QWU1iTcJmLS/sG8OtzCn3mdhl1gtw
         XGf+GVRFcUfa47a81CtpgUUcy5xhBI+Adi8Z7G+s2cQnFbOzVji2JUY54Lw5y93mtoL2
         iQVkkzY6z0JDEXyoAb3DlFgoSeKJTwZHU7MmFAhnsL9eSSYRzQ5JCcoRALACdx7c01PY
         60syfQudK0MXpnYoqCJC0XoJ+RyQqkI5mdbARMCINmPx1wjBO7lJHxmHp97byldGUpvD
         +Wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776220537; x=1776825337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mxRyy2kZK3WlZTfAxVXCb9nX2k5y4s491rvePkeOc2c=;
        b=AXnChnO+nToQMwBHePyTVw/u0Radlxng9mWDjAk/HaoQ6LyukFwFzDq2B806GUY7WP
         ei3Iab9iegrof4VtQebY7qoPMThV/9ZoaQnRZEvvBMO0EaSRGLslJ+HMiGqy+Nzi2eeE
         k7p2TpxhC583C72o0wwDt7q/TDeFe9eWo1LZZuL5FYDgsaVlfKUUVW9sYqDir8C5+Gr3
         TaalGLMaumcB+U/BmydOJtBsHmShF4vSGu7+P/VgHTeWmTWJIM4IeWu/C3yexCIrwOfn
         qRf4ix64xXhFqoGkKSV34iS060ldcDwuIVKxKRsTcoSw5UeppqtsXumYmm0Pw9Rp5LDA
         T3Lw==
X-Forwarded-Encrypted: i=1; AFNElJ8aGpRXf8j0u0rqrIWgrt9Tku+nJorasZz1swS9jpl7cwOcP2mNeeI21Pwe3gHS70CsW0xvRI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHMOlwmzwNI6ZPvFrlbBii3xYqezM32KV6cD3wHD6n8FQXjQw2
	c5NM+fs+tywJYOUNrelKvh29E8NatBs59tKnRycdmCbpCqRUOxnbYeKv
X-Gm-Gg: AeBDietqxSVvMAgMvZQ7g3K5EvzztNaYIiWhO+K4umpxTgmAyqf1v9Ka1+DtYD+6z7x
	mPONN4Dg7l12ZKv03Td4bt4m3SekfAICEaFA4WpwQXCmKDAO9jzeGvNU2RWeEbGoAoHcp/TLE4i
	VygmQ1q1nXMcmt/Bh3VZwOnWuXHIjkNiikhM6h0bfkBlWloYUcpwMUljn8qjxhwez+SCW4Bnsut
	IFrKdeqASbTGG/bsiQgOvQnrufryRoO4PC7VfKzSB/i9aDYKnuQNUOt+k6mcWEHmy7Ra74hz5SA
	Hj09h0uyo/EG5npwCGsD8eDX+jDdkteDNKvpkpCoQIqCpTZx5dbaTj1s8uqVTEiIFKdAhzJedfS
	w3sL8y/jXRGwVP0gXdVdYMMgTh0kyBviM7iwhfJXWQEzov1AgbMyBvCB3D0J1vBS1FIP4FOL0mw
	QBgcGnR8j1M+JjaNbn3BZmgcW3m2Tj/DmaM0kqxTBDwIkVxvy4ZVOG3P+XWOZnIzUpWR3xN/+6W
	3K7W2lsLoMzEbOchLXeWRFpyYwnRgCFO052wAxcxA==
X-Received: by 2002:ac8:7c4e:0:b0:50d:5b0e:1ff2 with SMTP id d75a77b69052e-50dd6bb6139mr240699491cf.22.1776220537078;
        Tue, 14 Apr 2026 19:35:37 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1afdd385sm3024161cf.25.2026.04.14.19.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 19:35:36 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/3] ksmbd: reject negative ngroups in ksmbd_alloc_user()
Date: Tue, 14 Apr 2026 22:35:31 -0400
Message-ID: <20260415023531.2659989-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAKYAXd-pXiJy4S05C_s6sqz6FtnCeCh6Q2c4B7tPuHseA94mkQ@mail.gmail.com>
References: <20260414191533.1467353-1-michael.bommarito@gmail.com> <20260414191533.1467353-3-michael.bommarito@gmail.com> <CAKYAXd-pXiJy4S05C_s6sqz6FtnCeCh6Q2c4B7tPuHseA94mkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238011-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,chromium.org,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65BF23FFCD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 11:05:45AM +0900, Namjae Jeon wrote:
> With the previous patch ("ksmbd: cap response sizes in
> ipc_validate_msg()"), negative ngroups is now rejected early in IPC
> validation.
> However, ksmbd_alloc_user() still needs an explicit negative check ?

Yup, good point.  I originally wrote the tests and fixes independently
and missed the overlap, so if you accept the cap in patch 1, then we
can skip it.

Two Qs:

1. Should I add a comment in case someone refactors the flow to
emphasize that a check would be needed here if not covered earlier?

2. Do you want me to fold this into 1/3 above?

Thanks,
Mike

