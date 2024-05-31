Return-Path: <stable+bounces-47756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3858D57A8
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 03:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375EE284CB4
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 01:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D927256D;
	Fri, 31 May 2024 01:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="pKUXJ4Tp"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E848468
	for <stable@vger.kernel.org>; Fri, 31 May 2024 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717118058; cv=none; b=BXlCDrSEts66VB4vkILlyVh7pmlk9Fb7GI7xb5v0HFfOp1SJDTUBmSGJZts/Jves9zJ/DXeQqj6OO/RoZAdbX5sukJBNcXZRJ8guvIuOAORjL4Y6ZqmM8iRssDlJPfXjSjDZ7RkUjnXPSiri4Ufxqxq4WfWXI3Le1SnGX73obI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717118058; c=relaxed/simple;
	bh=L+6mnjGLbR7EZ9LNFhyVcmByL9/0yyDfBA7JaEbMO00=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=eP/l4Pp1vQs9ITow3yAzuMXYGrmRbMwFE8wv9UUr8Mwxux3JVPpCwPvz9XGiWXeQ+3dfJ0eAYJt7gSuki3f9OJwakcRk4O793iPcL5GlNaHdl0AXi+jiCqHzYlZbI5x9V6NVpMGY2OjpAGrHvyHQlkphy+Gs5RscM/zd0/p5b+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=pKUXJ4Tp; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7e201ab539eso66516239f.1
        for <stable@vger.kernel.org>; Thu, 30 May 2024 18:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1717118055; x=1717722855; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mpCcqT5KSx7JMoRRNqMfc5HAgnOz09Z1n0NvkJxSBpc=;
        b=pKUXJ4TpY5uTYFby+kUin5uOVGci+F650KZsUJuxzvmdvOtx7Wpw5JynkxgITJfdI3
         UHcREQAfUK6hNhj8xjCzHzt8zK2iTK7e+kxEWmnk54qE3CxxhL9rLZuAF66o6FTfZPBR
         E0TI7NDo71y02P+5uMIWgjrLVe3KGJpZM8esLITsXF2YwHVZl/JCX6IZe1/1n8NuIuM2
         Rnr+nfkX9d6V6NnJoVNwmgE3wYXny/q5tQC3GPxIQWor/Jx6bmJ+bHb8h1V7TnuHhDk+
         NXOGeB4PaRCmST7VV1vGGzgrAE+GkEDVVHiUVVOTwq2ty+dTk6YmAg4qzxWE6+3EyjHd
         W4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717118055; x=1717722855;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mpCcqT5KSx7JMoRRNqMfc5HAgnOz09Z1n0NvkJxSBpc=;
        b=hRbZCktL7Ph6dxnT6EqOmKvXk5Do4w4Y0l/5rl+P0GxrsqUJLW7FIkzehSUYfz8aZF
         GzCBBpa0IdFSbQL1yDUbYLau+/ZbYvlZ6J2KUlHV9bA6yUfREYye2jHbUBPQp2qsla0B
         E2952cjO886Ovbn1AcxJtgVpbuftUVt9jZO4tsnsZerC8hvzwhuebLfATR+DpVIoB+nG
         rlXtHwIvFGMRKOBzXvZeHTOrwF/fNN2A3hXJTR57YVcB4pVyBDn5hP9Q28K4CrEGWyMd
         9cS2f2y8tL57BWhSTh1l5M8JQKIaWdg7X3j1LHuL+2d/v1GJfvPZka/s1zuMKd5NjxXB
         v2zA==
X-Gm-Message-State: AOJu0YzShoEf69etlrqWmcUNZhmqKbKRCVYu1biAbLVANfbzX+dSnuLY
	xg2P628Z/kvK7WaGwSlUnFBx0phuzWB5pdkIXZ7PNMZkQt2EQcJZAW1UD8MhjzyN+L1SeDTSscE
	KfiiWtqs02AoDQ/NvxdfG8T8Svd9HNnUlCICjNXRAuNT4PEsMklA=
X-Google-Smtp-Source: AGHT+IEnFm+nVG0Ad2pbqaydm3xG59zYC2oyj3AMWVCPYioRopeRVku9ScD+3G/j0GO9B7OtcTd8xBciCnaL+VqCWiA=
X-Received: by 2002:a05:6602:2d92:b0:7db:f651:2681 with SMTP id
 ca18e2360f4ac-7eaffed2153mr76075439f.11.1717118055173; Thu, 30 May 2024
 18:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ronnie Sahlberg <rsahlberg@ciq.com>
Date: Thu, 30 May 2024 21:14:04 -0400
Message-ID: <CAK4epfyYE=4PubEzyZw-LoSU6kuD3UCpHOWH8cWjw2pHxj19Bw@mail.gmail.com>
Subject: Candidates for stable v6.9..v6.10-rc1 KASAN
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

These commits reference KASAN between v6.9 and v6.10-rc1

These commits are not, yet, in stable/linux-rolling-stable.
Let me know if you would rather me compare to a different repo/branch.

The list has been manually pruned to only contain commits that look like
actual issues.
If they contain a Fixes line it has been verified that at least one of the
commits that the Fixes tag(s) reference is in stable/linux-rolling-stable

195aba96b854dd664768 KASAN, Out of bounds
2e577732e8d28b9183df Kernel panic, KASAN
20faaf30e55522bba2b5 KASAN, Syz Fuzzers, Out of bounds
c1115ddbda9c930fba0f KASAN, NULL pointer


-- 
Ronnie Sahlberg [Principal Software Engineer, Linux]

P 775 384 8203 | E [email] | W ciq.com

