Return-Path: <stable+bounces-119572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A47A4513E
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 01:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA4816D17F
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 00:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DF71854;
	Wed, 26 Feb 2025 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZRs1ohv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753C31FAA;
	Wed, 26 Feb 2025 00:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740528624; cv=none; b=oJpjthmOWnYfk5eCT5JCAYGvxZzTVG8bZ+XrWCJTCSS4sPuIbNUQwDtjfHa2ixtd40dGx63555cY53UCzq8piz55ilp2d4myU0HeLyaUHxqqOBBabdCyViAhT7HZl52qBb9rximM6BhIT6YH9h4+2Pu2/Lmunn7pl74P1v9opKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740528624; c=relaxed/simple;
	bh=4i8/0kq5jqG0L6DboHzLqAXfVAyzJEGZ5MIpsyYxeeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVmzmBHDmlLbdeUQd3qe5wCPxJmJCC6Iba6VQ//X80t1JORDTNUUE6e0dqTdWy45sxgdTuIt16sCzjn6lbed5Vc2eSCTDnBEEvNYV2qJ6ieKvTQSY9/lX0a/i1vb3YGXixvTwjYoNf6567qw8JddMLVg8zJudrfeZIvNUoiaGpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZRs1ohv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220cd9959f6so15848825ad.1;
        Tue, 25 Feb 2025 16:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740528623; x=1741133423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBY2nfE7KwlFz4xK8WDp9wc2SavbvwNmlQeXQVB17oU=;
        b=lZRs1ohvzTw6kVpaPpjpMLSd0D6F2Ouxyeg03jf+8ijq++6YGMtLaJ6XY4IIXW6NLo
         qVfsCazWWP0d+yzu4XVWDadEAVr+bENRmlEMce36pENSyFnOyRzqvVKRJevru4VnxtxF
         2OzQPq4dgjVJuTQcvuU7uAskbm1AOe7od3cdtEAMDG2xg0hV/P7g2RnneoToep1HteKu
         LD7LvdpEsZx5P/HrFSBg6ktj6reUoWS1PFPBnmKboLXNB4TDcyWUnic9ErxKCcx8RqIF
         wGFxPDv7fc1uAZVOKUShHpViugcEerebVxIXl+vckwUp1bsWzKzpmpbIf8aJ41sG5NRK
         RuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740528623; x=1741133423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBY2nfE7KwlFz4xK8WDp9wc2SavbvwNmlQeXQVB17oU=;
        b=K9pVWAji4DwVg8QB54sN0E6ubnJrWodUf88+1q1VdRBrqPwj/PhI1JwjGNTVDA102D
         uAQxI3s+JlnjRiD3ikUyi6I5u6T/Zz38+mnFOTnv9XhhJta+OJQFU1byxdvUxFQ320uf
         bG2Ceocwyq5t2qNX7M2GKISzzgVie9J4BCkb+X3Bvjos3fHBqEK2STRS49rgdieyIX4a
         xYmlRR5gVisMFGpHEvdNsPC1gm9mqii5w2UmuXfPePsPNXnsN9LzufvaLKIUzS3u/U4N
         kj+SbC2AyM23/fyW/hxJ/rM77MePE5CR6ITxg7qcClHCCN/eVeyuvH4O8cjLPIJwgafw
         nVVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh7XurkTUoDhyghv4aboylb4eYRAGggi+QK6UEQOUKERbx2Xwv6HqZComkxgkEd+dYXbPwYKMZ@vger.kernel.org, AJvYcCVke9GJqz5N2iTBGe2hqU2qm5aw3UoBHALLJ66hSS/eKvYozSYV9GEZNtHpf23GZdvfo27+hrolQyFOxI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLnGPRy5QWc4ThPkCRDJUJ6OD8al/Sn1EPGImBfeM/XZUdxisU
	6NA3bMSI2fzHT5XNN62/kX9VIj1vMVV9udQCtOPzFnHvpOh27SWE
X-Gm-Gg: ASbGncsWs1QcUeLb+wFVZMAXZ7S8FvNHKWkBzo5l505LC0/3yBGrKNawxb9b+ksO228
	dgOZ4ZLIhj2l7KSIyFnlHjt8QtxHNqCzyV5v6DisA8qncW8K0V8y69uLqUhKe+yoZp/kuoNJZH4
	nHfMtMwysxoD0Z/mcdZc5oQ+2KnHzEQvc4mTKr0OGSSN6zuhS/EJSEDSLlk+FU8YcabXpMXdh90
	eJ6ZtfnhbEllk7n3Qs9dSK2ZDlkRKvAigaDLHw5bB6veiVzjv/dRJStfJRWbEBclTjbUeUT19UM
	losz2EryjCYH5HoVV1ArsNajaIZ5uddHiBKqYXd4Uoee
X-Google-Smtp-Source: AGHT+IH3TRviZoVQATCal1hTW8eJ1YFBaKLXfG5od1V9ifxhdFIJk1JzinmmHdL7QXxBqj+hhTlDbQ==
X-Received: by 2002:a17:903:1aee:b0:223:28a8:610b with SMTP id d9443c01a7336-22328a867c6mr1806235ad.14.1740528622703;
        Tue, 25 Feb 2025 16:10:22 -0800 (PST)
Received: from localhost.localdomain ([171.216.136.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223234b95e1sm2610165ad.33.2025.02.25.16.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 16:10:22 -0800 (PST)
From: Qianyi Liu <liuqianyi125@gmail.com>
To: markus.elfring@web.de
Cc: airlied@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	dakr@kernel.org,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	liuqianyi125@gmail.com,
	maarten.lankhorst@linux.intel.com,
	matthew.brost@intel.com,
	mripard@kernel.org,
	phasta@kernel.org,
	stable@vger.kernel.org,
	tzimmermann@suse.de
Subject: Re: [PATCH V2] drm/sched: fix fence reference count leak
Date: Wed, 26 Feb 2025 08:10:12 +0800
Message-Id: <20250226001012.111886-1-liuqianyi125@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2fabe78f-a527-494f-8c3e-f2226ecbc43d@web.de>
References: <2fabe78f-a527-494f-8c3e-f2226ecbc43d@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Markus,

>…
>> fence callback add fails.

>                     failed?


>> To fix this, we should decrement the reference count of prev when
>…

> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.14-rc4#n94


>> v2:

> Patch version descriptions may be specified behind the marker line.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.14-rc4#n763

Thanks for your comments, I will update these in V3.

> Regards,
> Markus

Best Regards
Qianyi

