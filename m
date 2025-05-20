Return-Path: <stable+bounces-145010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C650ABCFB4
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 08:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B70164806
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 06:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0991025D210;
	Tue, 20 May 2025 06:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gknGP1Uh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC8725CC6F;
	Tue, 20 May 2025 06:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747723419; cv=none; b=UwUxSo1ojdQ1wgJZpGAAjUsIPoUag1YX8qqqnVdLF6Jm9taXJxCf2tMBeB1HJoyg5ASlKgLIjes+0VN0w1VrQl/0wCTsa9w5JkhQ2aFAJcrmE5zBEGlhsWshiiCy+HNf6E7SEZ59CK/n/N6f5y1UUQyKh3kKA9ri4m/5FXW0FPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747723419; c=relaxed/simple;
	bh=lY3O1CWHTSNuq6UpwI5nlLtOeI/tSa63qY6yy5s5xRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZ5AkiIs5pExfzbhaM1el886/IjbYZVNJ/erjtVD92z/Cdne9/pUHy83c/20Hn6LxiZewqAQ0Zgx/BDtX2xJnz2cxHg9SN3k7LtycykoV6y8+XuwI3HXRfFJXVIXnATKCQ113AbM7bRRVvsf1Na5Ph6kN7IKeVE0Las7Xxi3gPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gknGP1Uh; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742b0840d98so2833040b3a.1;
        Mon, 19 May 2025 23:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747723417; x=1748328217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVAADZ+DZdJAVlxmj1VcJLlCKq/OE7KCAxW96dgUzaI=;
        b=gknGP1Uhrtegv9OvxdNvTZxFklubzB+i85qA4AUW2itARW4CYhrggyjeL3+Ul1Weu4
         fpPIrgpyC+HXyzYkdQDJPg9tQkuUNvxIZDn7+J4EvBO2F0+7Me+sii2F4gGW5cnnbjlG
         xveyzpUBqeQHJCyQacSyv1Wz7+VwunjdGL85BBJqMn/SLbLv40UKaNk5bIzKsJfhqCgB
         75c90cb6RS/Rv38w8IckCOnXYIPg92OCcA7+5vAQ9DZAMwL1xfkD/FAG3BAIg9Iafda1
         MDUJRK6XjWG2B9tWfdHg48oWlvThTe5HrhHCPR29sldPPnW2f5I6tMmdvRlVWrhoECfu
         yR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747723417; x=1748328217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVAADZ+DZdJAVlxmj1VcJLlCKq/OE7KCAxW96dgUzaI=;
        b=trBFm34WPmJyDSMzO6NJZCoTX3oH9INurRJxsnUhyy+vLqRK9A3RSKp9ZNNBF/DyDV
         /AKsNP9kS+2LjwGE9c+lR55D5te+N/n6RAkof/KzFE/phyhMoTk1ctdXdA+N7/NxC+X6
         Vnp/5a1XODq7HuZeloZNqMdv528AGSndserVKFgtShJ5BUvKSHS6EXyaO6hB4qtUfZ6U
         FX8pfH2za2alIaDsYEPVm2gbgLy+GGjUGrZ8LhbqzGhj9CBiRECW+vt3gPErA14owlRu
         jpUF5ZBJhBZdyT3+qDb7XyOxpEy9TuNwdYWNRTuWHKnb6NHa5x1MKfKeE0lK5fLSyOL9
         L7qA==
X-Forwarded-Encrypted: i=1; AJvYcCVIFA1eg98gjTThqkB9b4mn3OzVnKnZMWYsKZR6+j03Kw4LTjOB7KmzExppPu0i7OoEBVtC7EA1Sug3v9g=@vger.kernel.org, AJvYcCVKeP7FTV3R5VDW8GnegX6QeRfCRMUXw9Nl+0NCMHrtQQ0xUIiBifmAQBV6hkXRIkKHFMI4TMV/@vger.kernel.org
X-Gm-Message-State: AOJu0YxKhrQY/u+AfHopz4RbHY8ZzMcWF0PLS+owuwQS4r1iNxhpSQJt
	HLJJUywrU4ABWHcq3oS5rIqFFa3XE10rniHRe+bU2+kUFAPzw5xdqw8/r3KV5e/5
X-Gm-Gg: ASbGncuzOYyfCJBVd0sVHdyRJ63rCMssu6mRwywvGa55RkNCvRPdLo9CSOP+i+SWjAh
	xL25hbGbOThWpWqEhdo/9Lf2haDNdztMT/O1VpeM3ksWl1TyBzwRvY8f9rw/ZVC9/xAJUP61RJn
	+732CjzmNyn9oFQn6movag4YZ0FM68SPyAbaQmcjHAkjDBNi7ZrvbQxthCj0LmTDjxAhs1gYmeb
	qmpbCILpMOJD8WBwTrQ8L+0VLofTEeSMAe1dkn6Qj33CJ9vNyyG7e2xSLw+n8r56B/UgwgQyZxX
	83ry7f84wHjsE5idT8LEajUezWO86/JJmQVgg7D+jzygJN9JqkTW4KqPk8FFviS5cgS9aP+vp72
	l
X-Google-Smtp-Source: AGHT+IEK+A0glrId1LYWSyrVjj4wZeJO3Kbmc/hL8aa08Ad//62xIXdd9IJciHnD8jIVLxb+NrzsSg==
X-Received: by 2002:a05:6a00:3e0b:b0:736:51ab:7aed with SMTP id d2e1a72fcca58-742acd50ac5mr22053218b3a.16.1747723417492;
        Mon, 19 May 2025 23:43:37 -0700 (PDT)
Received: from pc-lmm.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98770eesm7189963b3a.154.2025.05.19.23.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 23:43:37 -0700 (PDT)
From: limingming3 <limingming890315@gmail.com>
X-Google-Original-From: limingming3 <limingming3@lixiang.com>
To: peterz@infradead.org
Cc: bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	limingming3@lixiang.com,
	limingming890315@gmail.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	rostedt@goodmis.org,
	stable@vger.kernel.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: Re: [PATCH] sched/eevdf: Fix NULL pointer dereference in pick_eevdf()
Date: Tue, 20 May 2025 14:43:29 +0800
Message-ID: <20250520064329.831391-1-limingming3@lixiang.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250519093857.GC24938@noisy.programming.kicks-ass.net>
References: <20250519093857.GC24938@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 19 May 2025 11:38:57 +0200, Peter wrote:
>
>On Mon, May 19, 2025 at 05:25:39PM +0800, limingming3 wrote:
>> pick_eevdf() may return NULL, which would triggers NULL pointer
>> dereference and crash when best and curr are both NULL.
>> 
>> There are two cases when curr would be NULL:
>> 	1) curr is NULL when enter pick_eevdf
>> 	2) we set it to NUll when curr is not on_rq or eligible.
>> 
>> And when we went to the best = curr flow, the se should never be NULL,
>> So when best and curr are both NULL, we'd better set best = se to avoid
>> return NULL.
>> 
>> Below crash is what I encounter very low probability on our server and
>> I have not reproduce it, and I also found other people feedback some
>> similar crash on lore. So believe the issue is really exit.
>
>If you've found those emails, you'll also have found me telling them
>this is the wrong fix.
>
>This (returning NULL) can only happen when the internal state is
>broken. Ignoring the NULL will then hide the actual problem.

Thank you for patiently reply, I thought before the curent flow might
not deal with the case when curr and best are both NULL.

Now I got your mean, the current flow would never return NULL except
the internal state is broken.

>
>Can you reproduce on the latest kernels?, 6.1 is so old I don't even
>remember what's in there.

We have not reproduced it on the latest kernels.

We merged the eevdf to our kernel 6.1, and we just encounter several
crashes on our server, and all of them  are at the boot up time.

Maybe there are some bug on our portings and I would add much more debug
info in pick_eevdf() to debug.

