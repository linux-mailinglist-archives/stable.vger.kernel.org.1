Return-Path: <stable+bounces-50182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A09904791
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 01:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081271F24502
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 23:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8781155CA9;
	Tue, 11 Jun 2024 23:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ari/OIMh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E77155C9D
	for <stable@vger.kernel.org>; Tue, 11 Jun 2024 23:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718147655; cv=none; b=ibtHOVpLlmw6I5PMQXBYDutg8PcAAxm2WYZbTlZA9IJFCkKkHGsw1NThM1Q1/vt6OWTYgz/6tM9VhJOnYTv0YqW6eg5J3FrxIACKmKEuCyNNpM2IuMX3sCcGBiNEanqLmoc1t/QdCJwURMyN/j5Nf4t/++cBKzDHafLhzLkVayA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718147655; c=relaxed/simple;
	bh=09fFLlImvc5AWvxDOMhigK6VSklVfY6uLh1Xkf5JifI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kixIYyGWaDy8QzE5gECT6rmtwRLhLcqmeilfFk4sMdMuUKjwvpSLzzvJxsfwOqhAx2owZgJTsUnw8EWZhcFbZQTV/xsh3H/uo6VHlqurX4PFtzMxUe8UwvAD0+7VrLqF1+Bt8FjcEZiTLw0S9NvZla5pbt2ngHiVf2mLAOZDZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ari/OIMh; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6bce380eb96so1226115a12.0
        for <stable@vger.kernel.org>; Tue, 11 Jun 2024 16:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718147653; x=1718752453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6jnwWCUw6bY8DudkoKlTDtHqhRcmf76TPB9biPGxeZs=;
        b=Ari/OIMhGR5unn6sDl+LTTW8vPKuSRmeAZ0SBW8xfpNofH00LYklB+M/isvy1ZOlTg
         G1mhdwsqnPugdBm1L/LKaBfpf1yoBOK4qiYioOI2DD4oG0friVtTuyLN9yQUwhiiFt5M
         jlZZCJboxRcuanatv7IWb5o4UIN0oU2uMIhhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718147653; x=1718752453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jnwWCUw6bY8DudkoKlTDtHqhRcmf76TPB9biPGxeZs=;
        b=AIqdyNtrm2rMOyYDqMDwC/7uB2sYflm9zBfE6n5gt26F3GRY0HwbrCb21CEDZY8vMM
         rQO2AOke6W+/4lo5apSWPr+67bTNHMyaivWoarWrk17dIUJLi1owLcKRdZpbLZQ0U904
         1+FXm0LNvQnIxXUmYc5+jv1wjOBLHGiZw9DL/XFArFaH3TH0s34eoZU7YK3tDjnVCX4d
         HlFrx2yD/JCQN2Mju2RKU+7DNLQ9pVJzKfo9cewe127AvGZb/yxK3pM+H+p8Drr3ooJF
         LXI7PBzBYzR7Q6D8NedN7CN0xC34Fr7haq9fvri8pskay8VEANriZC5QK/6mdM20j5j4
         L3HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkDACw+IQWNVN4a88grS6K+An+WpT+ddSgUSZiEnFogmkikSXy+UCs24xgTjZp/3hC2WLV1VCj95Sd4vD/fu/pVVsCJZVq
X-Gm-Message-State: AOJu0YypSwidozHcxyGZ5C1NOQApEHpzQBxPRiqWsuUQM26DscsXP3kl
	NW8j455XaGTzdNEGKCBMVnZwzVJ2SSS2GhRex8dUVS+68V+uReXLeYbg9rvkpg==
X-Google-Smtp-Source: AGHT+IHYguKHLuIh89NwNAJKCtCRwqWJgjILC7+XuH+GWGrD+IKfhpzhHBp7k+ZPsUa1dQ+fmCW4ow==
X-Received: by 2002:a05:6a20:1584:b0:1b7:ffb9:fb30 with SMTP id adf61e73a8af0-1b8a9c29b80mr430973637.42.1718147653189;
        Tue, 11 Jun 2024 16:14:13 -0700 (PDT)
Received: from localhost (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-703fd394e95sm9533812b3a.56.2024.06.11.16.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 16:14:12 -0700 (PDT)
From: jeffxu@chromium.org
To: rdunlap@infradead.org
Cc: akpm@linux-foundation.org,
	cyphar@cyphar.com,
	david@readahead.eu,
	dmitry.torokhov@gmail.com,
	dverkamp@chromium.org,
	hughd@google.com,
	jeffxu@chromium.org,
	jeffxu@google.com,
	jorgelo@chromium.org,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pobrn@protonmail.com,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH v3 0/1] mm/memfd: add documentation for MFD_NOEXEC_SEAL
Date: Tue, 11 Jun 2024 23:14:07 +0000
Message-ID: <20240611231409.3899809-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

When MFD_NOEXEC_SEAL was introduced, there was one big mistake: it
didn't have proper documentation. This led to a lot of confusion,
especially about whether or not memfd created with the MFD_NOEXEC_SEAL
flag is sealable. Before MFD_NOEXEC_SEAL, memfd had to explicitly set
MFD_ALLOW_SEALING to be sealable, so it's a fair question.

As one might have noticed, unlike other flags in memfd_create,
MFD_NOEXEC_SEAL is actually a combination of multiple flags. The idea
is to make it easier to use memfd in the most common way, which is
NOEXEC + F_SEAL_EXEC + MFD_ALLOW_SEALING. This works with sysctl
vm.noexec to help existing applications move to a more secure way of
using memfd.

Proposals have been made to put MFD_NOEXEC_SEAL non-sealable, unless
MFD_ALLOW_SEALING is set, to be consistent with other flags [1] [2],
Those are based on the viewpoint that each flag is an atomic unit,
which is a reasonable assumption. However, MFD_NOEXEC_SEAL was
designed with the intent of promoting the most secure method of using
memfd, therefore a combination of multiple functionalities into one
bit.

Furthermore, the MFD_NOEXEC_SEAL has been added for more than one
year, and multiple applications and distributions have backported and
utilized it. Altering ABI now presents a degree of risk and may lead
to disruption.

MFD_NOEXEC_SEAL is a new flag, and applications must change their code
to use it. There is no backward compatibility problem.

When sysctl vm.noexec == 1 or 2, applications that don't set
MFD_NOEXEC_SEAL or MFD_EXEC will get MFD_NOEXEC_SEAL memfd. And
old-application might break, that is by-design, in such a system
vm.noexec = 0 shall be used. Also no backward compatibility problem.

I propose to include this documentation patch to assist in clarifying
the semantics of MFD_NOEXEC_SEAL, thereby preventing any potential
future confusion.

This patch supersede previous patch which is trying different
direction [3], and please remove [2] from mm-unstable branch when
applying this patch.

Finally, I would like to express my gratitude to David Rheinsberg and
Barnabás Pőcze for initiating the discussion on the topic of sealability.

[1]
https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahead.eu/

[2] 
https://lore.kernel.org/lkml/20240513191544.94754-1-pobrn@protonmail.com/

[3]
https://lore.kernel.org/lkml/20240524033933.135049-1-jeffxu@google.com/

v3:
Additional Randy Dunlap' comments.

v2:
Update according to Randy Dunlap' comments.
https://lore.kernel.org/linux-mm/20240611034903.3456796-1-jeffxu@chromium.org/

v1:
https://lore.kernel.org/linux-mm/20240607203543.2151433-1-jeffxu@google.com/

Jeff Xu (1):
  mm/memfd: add documentation for MFD_NOEXEC_SEAL MFD_EXEC

 Documentation/userspace-api/index.rst      |  1 +
 Documentation/userspace-api/mfd_noexec.rst | 86 ++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/userspace-api/mfd_noexec.rst

-- 
2.45.2.505.gda0bf45e8d-goog


