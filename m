Return-Path: <stable+bounces-164881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D82FAB13425
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 07:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D30647A5906
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 05:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448D721C173;
	Mon, 28 Jul 2025 05:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="RQpCBHsY"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C51E5710
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 05:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753680388; cv=none; b=qrJiei12eXbb8krErWgEgI1gONPnh9VNeMXrJeYwkA/HBgqvEn40F9PouRMjYqQHrKgbNFz32rjB1jx18H60kGBiQ5s8WdWqyBn1nDc4iXOOBwqH7jbkUyB0VXHozuhfwZINsl2PggsBJEks3olh7vihBrPjRfAis0Bn7UGwkmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753680388; c=relaxed/simple;
	bh=1+znes2LiqmsTd1xM44OKOUr2AzPnGM2g+MW6XYhpU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X7nsboOwsrOgj+ESCDs5GM5PfNV0Q47Q0AnXC5C+2dBHpZTL/yyH6Bu2lhZoi1CAKL77INnqQOtw3kuU9wxh2r7fkP6cMr92XIIw+kzftGlNW4v3ThZ178xZL+KQdC3YZrvUeG1n0ooWQHe2Z9uastxfCbQmWoTR45rzvu7lVAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=RQpCBHsY; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-87c6dcde264so8989339f.2
        for <stable@vger.kernel.org>; Sun, 27 Jul 2025 22:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1753680385; x=1754285185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAImW6vPKOZ9kBIaqbsIiNeP0VJi3BxJxQfpo7XZEDY=;
        b=RQpCBHsYlbGQEWGNt31dlm+aenLEt8hekBMRRy6n1cDWRLIRK+ctKB+IPU4UrYlWcL
         2hG3dOXDMtrSAYCv8Qf+NIF5nUogtat98xySTZymeFzRu1iNmK5Z5PTW/axk7YbrOUvq
         a+FXEjOTvP39RjoOQP9mk1tGNPF4MB2A7iTqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753680385; x=1754285185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAImW6vPKOZ9kBIaqbsIiNeP0VJi3BxJxQfpo7XZEDY=;
        b=vakFEXqjG2uwvqleFCqlVudK1iz3C1L8zkYIxucOHm5LQCRm5I/ljyPwDc3xikXM43
         4T2JnDpQ47fe41+tHzgjKLAOiGk0S9CQNhyGAYX0Bhdu4RIUigkigIkU63MhCWPEAVsA
         xju5mYqNBW2k9+L3HnyZkIz0Q3IFCVISZeNR+rqlRckreNRrtFgRPCPQ8tm9k39Z4riK
         T16klJs307Rfs+mIceCdIz18m8vGkIFOYww27cuYK/mmehFAJ9BqGlFSOEnzxkN5W8wr
         55a9CeYLsp0/9wrngXMwTAFufWkhDrQ5cotEQAWcISOrvNt9gX6xYC8dRFx11n5y83X9
         /Qxg==
X-Forwarded-Encrypted: i=1; AJvYcCVUuL8xuPJEvncLBQNBg+pYUdC19+485xVrU0eDxTKjS0mfZWHosbsqiIThCCQufbvAnMZor9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymvh5Pc/3biReBv5aMr8Ld4tPsMWKbpzd92mtonwzAoL1cE25J
	yS0z4gp90pN9fFZQgMX3mAkCH2gsMcLE19jRjEhzqVBBr6GwLm+DLnz4cKqTgsXubzh6UlyTHUS
	w32m97yE=
X-Gm-Gg: ASbGncswHJoksAUKo+dRw/36dBGP7ZxEmPQXCqCYTgfXMzYB5TyiX0xwj1kdlL4Md0h
	mpzxK5C6OhXw9ocwTL+bYL5imHdh/7gJ3BHyRCSjIQyXnAemhE21oQldynRUNKZIR0NVFrQjqmG
	GGz7xnbEDgbbGICMGkb6zU1VH0Sy9nnWyTXNTNJb0WP9tz8vyt1xNnN0/LZ5aP4qPKJej9rwbAr
	nql6Jt0/zbgPwZVbNEEi7w+bnPtFpWkBXl9F6Tp1GuUC99mPObBm+jEDKsapcJtUFj3zvCYRRB6
	3kC6enRujY7AiJ0R7OyjmljEJYg6bEmeCMEAsABlRVSDulO+FGrb2Wj+HXHIHhGmJ+zeotL3v+6
	U351aO/KeWfBXAXT+BmkFXpB4RHK098mGpg==
X-Google-Smtp-Source: AGHT+IH2vXSDwun8gVqZcHjKrDDlz5NyFT2kjrJSVYD/I9s37OCklCKIV48q7LFB5s7B6bsR8TIqPw==
X-Received: by 2002:a05:6e02:1a6d:b0:3e2:9af2:9a53 with SMTP id e9e14a558f8ab-3e3c530ea2emr41779075ab.4.1753680385456;
        Sun, 27 Jul 2025 22:26:25 -0700 (PDT)
Received: from MVIN00025.mvista.com ([202.179.69.88])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e3cab1a079sm22635415ab.22.2025.07.27.22.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:26:24 -0700 (PDT)
From: skulkarni@mvista.com
To: sashal@kernel.org
Cc: skulkarni@mvista.com,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 5.4.y 8/8] act_mirred: use the backlog for nested calls to mirred ingress
Date: Mon, 28 Jul 2025 10:56:18 +0530
Message-Id: <20250728052618.171895-1-skulkarni@mvista.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1753464140-e7196da4@stable.kernel.org>
References: <1753464140-e7196da4@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My apologies for sending the HTML content in the previous email/reply which was rejected by the stable mailing list.
Here is a resend without HTML part:
---

Hello Sasha/Greg,

For the "found follow-up fixes in mainline warning" for this patch:
"Found fixes commits:
 5e8670610b93 selftests: forwarding: tc_actions: Use ncat instead of nc"

While analysing the patches, I actually had noticed that the commit 5e867061 is a follow up i.e. "fixes" commit. But this commit  5e867061 is not part of the next stable kernel v5.10.y and as per my understanding, we are not allowed to backport a commit which is not in the next stable kernel version. Thus I haven't included that commit/patch here.

I am new to the process & learning the rules. Can you please let me know if any action is required from my side for this patchset here?

Thanks,
Shubham

