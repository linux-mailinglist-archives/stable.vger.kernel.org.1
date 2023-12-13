Return-Path: <stable+bounces-6541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C1B8106C2
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 01:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D02E2823B3
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 00:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E496394;
	Wed, 13 Dec 2023 00:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GER0MF1r"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD57EA
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 16:37:47 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso3035a12.1
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 16:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702427866; x=1703032666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1LnE6BidxYtGaY3naq+UID6BS2mBFdrix5t5XhfBs+I=;
        b=GER0MF1r3n4hbuvaztv/r7g9jGVPXuX+pJokY1ZkDTPPmo/wIIE7c3LqkFrIvPx7Ty
         UmLA14tAQQgXEpxv1asWdk6rQ9QS2lE3212qvuOC5Uqba7fKx8y01Dcai3PkJSVclyC4
         4d7V/natmrN/jvPJAp6oV71SbAhayZrmkPzjwkmmwXO9if/oJjJuGXYWgNKIQpkkvAnc
         J4vXJjAFWk9P/rxTN54I3hpjYqEZ23HiBM1rWIUZSMAdLfACuq0k0KHmiaBfY23LymOI
         v0G+TFSg5rUV7GY8TmIqZ/fk6B6mBxbGwbw7g+Svkh+7JES+wEZTsa8I91/Z8s0rEkl8
         rZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702427866; x=1703032666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LnE6BidxYtGaY3naq+UID6BS2mBFdrix5t5XhfBs+I=;
        b=E+677C/djcELRzmNqL4Mn3ClhnWt9nYD5KQhSBjrwVvLYEaubldAYhfVgb8z8cr1yR
         cC/fkcI2UiprHvxleDXIM6heFCnziiqnKAlF1DRBv5Ce4NjIFI7HL1PE7vtQysW92jE7
         DhR+t0dt9jF/jVPRVttKj3OXqZFSKu84urykxXBV+mQmfuv85Hgxm4cCFQHhUfr1AThE
         eGsoPplF+6vHx3k+CSm4ntY7IS6x7buGeP9UDHat7C+Z31NjzuI5XPxL/17eKAB9jdXF
         zji0HlOP4/rb5Y9bSaDQbKKDJggdrY504YQ5bzx82b3iPPnoNXdEme1fYy1uDIyvGJN1
         KCqQ==
X-Gm-Message-State: AOJu0Yxasj4uzAo9Bugwz2WQxnqoI+iZmERJzIH0sMXZunq+rLqcX73L
	xOidpVPBK9AAbrslzJrbDCQLACAzloVZ3o49NyyI
X-Google-Smtp-Source: AGHT+IGnMQRiKEPWZSvwWYwwY8FAhUWy825RQ67iHfal2GL8IR+NeDwrblzRUmQldUIwiAa92DPPmgK9pAj6EIrAdq4=
X-Received: by 2002:a50:d601:0:b0:551:f450:752a with SMTP id
 x1-20020a50d601000000b00551f450752amr37151edi.6.1702427866162; Tue, 12 Dec
 2023 16:37:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000b505f3060c454a49@google.com> <ZXfBmiTHnm_SsM-n@sashalap>
In-Reply-To: <ZXfBmiTHnm_SsM-n@sashalap>
From: Robert Kolchmeyer <rkolchmeyer@google.com>
Date: Tue, 12 Dec 2023 16:37:31 -0800
Message-ID: <CAJc0_fz4LEyNT2rB7KAsAZuym8TT3DZLEfFqSoBigs-316LNKQ@mail.gmail.com>
Subject: Re: IMA performance regression in 5.10.194 when using overlayfs
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, linux-integrity@vger.kernel.org, 
	regressions@lists.linux.dev, eric.snowberg@oracle.com, zohar@linux.ibm.com, 
	jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"

> Looking at the dependencies you've identified, it probably makes sense
> to just take them as is (as it's something we would have done if these
> dependencies were identified explicitly).
>
> I'll plan to queue them up after the current round of releases is out.

Sounds great, thank you!

-Robert

