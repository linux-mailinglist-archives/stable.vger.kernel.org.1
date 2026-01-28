Return-Path: <stable+bounces-211912-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULXYDaN2eWkSxQEAu9opvQ
	(envelope-from <stable+bounces-211912-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 03:38:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A45C19C563
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 03:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E77C3031AE1
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 02:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63272C159E;
	Wed, 28 Jan 2026 02:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRVaoeKu"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3082C0F95
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 02:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567885; cv=none; b=E8Zos6Jkq0AHIATN1hdoUdXcxsvOnnn0VcQrOIQQp+rdFgXb2moAngcy70wxJAy2mpNTyHeio8zl5LPcY1dE8jofVEXzCkki2FkItpqfvL+qqDYqg9o2iEgeECiwIXbiviecguzt80nQMl1JSRSdsGtP+ln5pPdJPkRQ40ZX8B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567885; c=relaxed/simple;
	bh=TwSoeihKpQAs0Xculcg+xL4TrpYrf6SpB9Q3RJkipQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJRVXvh8hCzxVWYsoXP2OpDRYStRd2sR7+tiss+dM5XHnAwsKLYkQQYeD7dcE5ddZUd0eGp2zLI110eenLD7UxjaVX69e+MA1aRgYqKipeVmAhg0L8BkXnleZP3lwV/yFAT9cmL/DHKfew5p6frlmxvI68PbVxsc1n3MNuAcUoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRVaoeKu; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1233b953bebso2407563c88.1
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 18:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769567883; x=1770172683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6cfmUDBf1+qLRNX7vc1byRXhiT1ATCL/TBU1o+0kLY=;
        b=RRVaoeKu9NC5OoiU9WiyZ0cGih/jVa0ZZkrQ3nIFrhVB2RD4c8UZ3Ggy35CYqksb7y
         6evDHYXQlVHI9wwhM5c0WG3go/ShPWJSAlajY4CIBSY31Y5uFuh8iZTV60JY6j5ZpCOS
         JvPMSDTPJygx7b9J4NsR1C3tE8/VVcd+GcGNloJhxTgwVhX22/qcDuSzXyVYmeDqgewi
         yAqu7mMsgBxVc12Le2ccw3rhrnY7ea4tdsl7tZy8f1Jm8AkGcJ+rZXZw/t39j3/so5bT
         wfhmJObVSmG8EZSICJStdIZJpJnuGVBnOCYNOtNi7S9lOQF7bZfqnLCRgTAmBpnLC1qD
         GkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769567883; x=1770172683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r6cfmUDBf1+qLRNX7vc1byRXhiT1ATCL/TBU1o+0kLY=;
        b=pd6GL+/HFrGGEiiG6W2AJz74arVvvmZDwySNfzPQaa4v4gD8CG47H7/45MeZ4lBqzm
         CPmqwG3lY27wMBXc1WwNDuZDm2T7h1ELGmE2X2U9XcqgJ3zR1XMRnzaU1yPZVHorGrHh
         AiWJxnm2K7VSTPuds1aywPH/osja3NOsV7m+DD8sRF+7PxKuyyLX1xalj+22hutvuxhq
         08BHBSNh/fqHVzmHqGUTjG5iNd9Tr2RC5Y8UK6CMVgnG+/vFRf8DvpYvCHGGB7nnSroS
         zCKfEqgeVa5hVlW0bdnqDYMmZQSLSEdQf29ENkvO1kFE6d1VhfQMIRWcvqa4L5ZWisfY
         SGVA==
X-Forwarded-Encrypted: i=1; AJvYcCWlWWIbfwgMXpw001M72ttafryAgjbF+Sd3jwx11nwjie/Wse+zNik0XFBc7kKuJTwh5qI5lNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLF9/TJvbwfpQaXxJP3NKixjdcK2WK9H7uiFGxcle1Xx0Xx0l+
	+8ssler3JjYEfme4cFhWtfDGic6T+/S/IyL6VNHLJyfTk6cb1C+iMn/Ru6wgsfCZ21Y=
X-Gm-Gg: AZuq6aKjq+xHpLb9HRQOTBRPRngBtokDllor2ohEAThuEQfHBVeVX0B7vq3k5qnWSMG
	X0pn5ZZlJb9u68YxLj7GqlV3210yUV7skp5wwzXfmyTwPnsGRQnuU6DhhVIuUymjRhGcNgDkgYW
	3fgdDnmjZnT/IBbpBYk7fMO7uoXhdc/nYbD356LmXvekwW6Zz8orkCXJxX7tYGmD0Na6RX0Gpda
	leSGk0U2yTXloWCUNREL955xhzt/h4Mwb2kaIN6IsmCzdeRW+RI8BlpIU+iZN06hlj0LH+w7KHt
	13g5Bem7OX6JTAjdqDbfPESpSF71HRwXsBcWZLHF0uOCDxkcV4rdnEp2dXgxfjLU28Oix/tUEVC
	n1QtguQHocp57lFsiobt/dVAEtw0PBinaDM4wOKCbUfCXjxFNd2hwcBJlvMYmHa/MYQCY5L3Mez
	7M214=
X-Received: by 2002:a05:7022:f96:b0:119:e56b:c75c with SMTP id a92af1059eb24-124a00deeb4mr2362361c88.33.1769567882811;
        Tue, 27 Jan 2026 18:38:02 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9de948esm781862c88.9.2026.01.27.18.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 18:38:02 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: dianders@chromium.org
Cc: akpm@linux-foundation.org,
	lihuafei1@huawei.com,
	linux-kernel@vger.kernel.org,
	mingo@kernel.org,
	mm-commits@vger.kernel.org,
	realwujing@gmail.com,
	song@kernel.org,
	stable@vger.kernel.org,
	sunshx@chinatelecom.cn,
	thorsten.blum@linux.dev,
	wangjinchao600@gmail.com,
	yangyicong@hisilicon.com,
	yuanql9@chinatelecom.cn,
	zhangjn11@chinatelecom.cn
Subject: Re: [PATCH v4] watchdog/hardlockup: Fix UAF in perf event cleanup due to migration race
Date: Tue, 27 Jan 2026 21:37:52 -0500
Message-ID: <20260128023757.1693269-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAD=FV=U6sM71UuPbYZRWV87=p1ZO8-gpv3yzK8eMEv3dRNVgdA@mail.gmail.com>
References: <CAD=FV=U6sM71UuPbYZRWV87=p1ZO8-gpv3yzK8eMEv3dRNVgdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211912-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,huawei.com,vger.kernel.org,kernel.org,gmail.com,chinatelecom.cn,linux.dev,hisilicon.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A45C19C563
X-Rspamd-Action: no action

Hi Doug,

Thanks for your detailed feedback and for the patient explanation regarding the 
mainline workqueue behavior.

On Tue, 27 Jan 2026 13:37:28 Doug Anderson <dianders@chromium.org> wrote:
> Really, it matters what schedule_work() does on anyone who happens to have
> commit 930d8f8dbab9 ("watchdog/perf: adapt the watchdog_perf interface
> for async model")... we have to focus on supporting the mainline kernel here.

I completely agree that the focus must be on the mainline kernel. I've since
checked and confirmed that in mainline, schedule_work() is redirected to
system_percpu_wq (via include/linux/workqueue.h), which provides the
necessary CPU affinity.

> To ask directly: have you seen this WARN_ON in mainline, or is this
> all speculative?

To be direct: no, I haven't seen this WARN_ON on a pure mainline kernel. As
you suspected, the issue was identified in a downstream 4.19-based kernel
with different initialization timings and workqueue behavior. My assumption
that it would also affect mainline was indeed speculative and based on an
incomplete understanding of include/linux/sched.h's is_percpu_thread()
implementation on modern kernels.

> I'm still not convinced that there was ever a UAF in mainline nor that
> this actually "Fixes" anything in mainline. I do agree that the code
> is better by not having it write the per-cpu variable at probe time

Since the risk is not currently manifested in mainline, I have refactored
the patch as a "cleanup and robustness improvement" as you suggested. This
removes the fragile implicit dependency on the caller's context and makes
the probe stateless.

I have sent v6 with these changes. Please ignore v5 and review v6 instead.

v6 changes:
- Renamed the title to "simplify perf event probe and remove per-cpu dependency".
- Removed the "Fixes:" tag and "Cc: stable".
- Rewrote the commit record in the imperative mood.
- Updated the description to clarify that it addresses code brittleness
  rather than a confirmed mainline bug.

v6 link: https://lore.kernel.org/all/20260127025814.1200345-1-realwujing@gmail.com/

Best regards,
Qiliang

