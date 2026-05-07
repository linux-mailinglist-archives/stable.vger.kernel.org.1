Return-Path: <stable+bounces-244473-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF5tB6ve+2k5GAAAu9opvQ
	(envelope-from <stable+bounces-244473-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 02:36:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BB64E1B80
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 02:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44A60302D085
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 00:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A131C84BC;
	Thu,  7 May 2026 00:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUq2LaUn"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF581C5D72
	for <stable@vger.kernel.org>; Thu,  7 May 2026 00:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778114190; cv=none; b=eFibF1JA7wDX3ulWUgsequ8NOcmmtN6mlvUcIWm/h9kUGor55PE6g7HLPjH+6s0yFcCjvR5JBvLOtt0PPIdb7/DOs+zPua1emjZ02e7E+eGgSygFY3jBNBg12V4WkN/3v5VqIO5quxBKF/qEvpzfALMTSY2GdcelKZWx9emnYcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778114190; c=relaxed/simple;
	bh=MkbujpTdxL4QeLpeuCj5rDWwhE50kHp8Ig1HE4ujlpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dcVMImj8YBtQgIT72sJQ1ITmHKcy3Cax0G99XPgM62JUS8sV8l5xNeFINEZSmxrOBLsSesqHo4/1rMwqTCqPYpFB1wocd+E4JicLFtTcCht+gVWtjCnfzsPWe6ESjlvuEZWP3zlus6qG/3/RpApz8x8vYXIkLO3K83+Uuhm5SFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUq2LaUn; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8d933da14f0so26210285a.2
        for <stable@vger.kernel.org>; Wed, 06 May 2026 17:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778114188; x=1778718988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkbujpTdxL4QeLpeuCj5rDWwhE50kHp8Ig1HE4ujlpM=;
        b=mUq2LaUng7nsI/KwPvlZQg9gBYsf3oNhisdSVhUZQAqGXpFzQ8xlFPsP5p0uDjvFed
         1x1ZRRuqCUgK4IumeI4Q2tC+zQ5frZVGVTsvUjRYV2LkMQ7Q7XAwQptWczcL6R0f0+Pz
         HO8rNQYnUCfH2UbR+8WuM+UJ/NUC64eVI+w1Ni/Cvzye0IL9ORbUZDQwjCaNcaYkDhjA
         +MgzkRne7qfPs14xn5vNbD2FJTdEHSEtajT0XvVBbmNXrOAzCxxCzoBAoqacW8FqOEAU
         Ef/bJtarU6ZYPGboDmw8eZujKda92cTUQs5ktls7sMrlrFI62RMQtmOsKmITfR6gTvu6
         Xjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778114188; x=1778718988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MkbujpTdxL4QeLpeuCj5rDWwhE50kHp8Ig1HE4ujlpM=;
        b=apMuA8ZS/j9Q7Y2UHdzsJkuWLRnaIyx+USJWXVqEiN0arsYm7uH4sM71cnalWNl3GX
         mUchepn+K7u5JJtdbAi3/PCLJORdGMsSeoh06KL2pLEXARMj8UOnev1yB5hQzw2v6D+2
         UqU7ezlkZ/BfO5MLoxBVNG7bqDGayYMw7imcIKyxUfy+bKTT2NzNODwKdyN+ttkhSGAa
         o9Xvcsp//X+YDt+tvMsb1jVzUbeRG6r4rB2O7AvBlmMRP5tuFAcr64PrNzk/wEZ2B/4C
         Mm7ad6rXyIYqY9ivLSdeYgzoJRfWZ54hbyG9W947NlY0Gflfztg981JkL8h1zkMEjdnl
         TEaA==
X-Forwarded-Encrypted: i=1; AFNElJ9bGkWVMPfblVbvNPqSL9BQW7PtjuHvBtWM22hhLOWiieRArJuhe0H9Oq4Tiw/+LLczpTjeRDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVhQ/bTJ6eBhfj7YGEmhQ1otFFC8/q7Jadg8I8vZK98WvNIfqG
	ew+5y2dVO7tzDD/imnYeuSG5xdiTgSEEa/ud4ZyQmQnEbO3mIkfXQ/O2
X-Gm-Gg: AeBDietK5pDcwoBXwd3zAQA8wbThIFv6pYnPB/kGat8foRVqbZiqvYV4BzSDlGXKXgC
	AHhQCy34ddYRPDWs6EnOH7/MfhuSa0Sg38zWEM2VkH+KqDx8ugXtS/2hR1VXT0GyQaAhmKGhCFj
	8uSjyHcFkh84oXhgJPoPAwquGV0Fr5yxulX0WxvwndKqHgQtd3zF3/iWitdMiJ8si8JmmwAPgdg
	4lyq+1K4YX0t/O+IGJd5xsSHB+k/WpEpg0pUNHQMX2/eMzkkL2blMBULuJeSK5KsVe2IZOm+ZLK
	HiQgAThOtje63I7f/Hnz7rrPtQ6rSvyyu9jhYFpNbJSWq+zwLRWNU9MVMTGQM5m6ssDetelHw06
	W6EtwhFxHzGphseCB04SueQPiiYjOrZraBQid6KuYfcqkdKhGHMXteAzzI/Go1yEWrt9eToM5Ol
	nYLdftoSGVkK+68ZDCT214W0FBYGsOMqseQf3iqf8E2uJIRSQ1lPvEw5/0ldzqYIErfcdNX84KN
	2b9uT8KJEtEWrVL8/x4C+HHmriT80Fq7JVxUaZ84RI8m8zQcw==
X-Received: by 2002:ac8:57ce:0:b0:50f:b3d2:6ee3 with SMTP id d75a77b69052e-514621fa8e9mr80391011cf.60.1778114187925;
        Wed, 06 May 2026 17:36:27 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040927789sm165399421cf.11.2026.05.06.17.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 17:36:27 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	lyude@redhat.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: Re: [PATCH] drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband reply parsers
Date: Thu,  7 May 2026 00:36:18 +0000
Message-Id: <20260507003618.986160-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410034123.2433769-1-ashutoshdesai993@gmail.com>
References: <20260410034123.2433769-1-ashutoshdesai993@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 71BB64E1B80
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-244473-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lists.freedesktop.org,vger.kernel.org,redhat.com,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi,

Just a gentle ping on this patch from a few weeks ago - no rush at all.

https://lore.kernel.org/dri-devel/20260410034123.2433769-1-ashutoshdesai993@gmail.com/

Happy to revise anything if needed. Thanks!

Ashutosh

