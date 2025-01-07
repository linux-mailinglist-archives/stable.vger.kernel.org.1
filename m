Return-Path: <stable+bounces-107881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1836A048F8
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 19:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E068A163721
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 18:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF587198A0D;
	Tue,  7 Jan 2025 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRqjdteA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF85653AC
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273418; cv=none; b=Dt1ar0+7PjyArVvD/TjEKksSFDXQrdjmK3bSIR86yNsYc/oxXz+v0LqMXDmJAJmbMJE/5Y5/FfhwEepzYPd7D+/SR4MCEatvWckjakBkcXNaZsl3crHi7cW8XulQHmqRJCqj31DVVp6H8trCL9ND0+Cru+DcUbxLAgG82sa3Qqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273418; c=relaxed/simple;
	bh=KdqzgflszYAnHXQUYYMHzrl0PrF3yHVf9KA3qTT+iCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p40UmEmhB8YtyHo/KMXYu9tJTVsV0o9rGcIq1y+BVV6Troyj33SPNeyQ2sY618AIODLkwfCdLmj1sI15tOHyLlgrqcMqFZDkPL/4kgy9jiuVH+HJ5ij/6yBTggEUSR/3/W0cqM7CpyQZiYdu7ADVnfRT3n/MyGZq3nspTQVK8MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRqjdteA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FDFC4CEDD;
	Tue,  7 Jan 2025 18:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736273418;
	bh=KdqzgflszYAnHXQUYYMHzrl0PrF3yHVf9KA3qTT+iCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRqjdteAV1ZEg042TsvNR54zFC6+3+RXavT01JLlugfqWJAJBlbtKSURNx9afV+Ec
	 a+QrCxYVn/JZ80zOaMIk8yPAJIOHp6JD1TqCceus8UZ+rXh7a28ADGBgcqtMCTO/Eu
	 fWXvY51UZ+upyIYjnbQhh9djrEQwDQkmwjqx0qQWwsfRfAR0BVVEWox5ALgIH2jZhY
	 ib/eN3omKTsx5e6HslvHf7g2Cvu/bulUaqhAdJG7ViyHQNUH70ObsXuyUGBMZ//4WF
	 vv66IQbHExyt2yGZchjSnD7N8fwszv1IUIJC68pozcd92PRN/XY3xM4QJj2LjkPFTz
	 vzBm8bLojq5jw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] scripts/sorttable: fix orc_sort_cmp() to maintain symmetry and transitivity
Date: Tue,  7 Jan 2025 13:10:16 -0500
Message-Id: <20250107081321-bdeb6457b2dbd8c8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250106175318.3256899-1-visitorckw@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 0210d251162f4033350a94a43f95b1c39ec84a90


Status in newer kernel trees:
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0210d251162f ! 1:  02225d4eea29 scripts/sorttable: fix orc_sort_cmp() to maintain symmetry and transitivity
    @@ Commit message
     
         The orc_sort_cmp() function, used with qsort(), previously violated the
         symmetry and transitivity rules required by the C standard.  Specifically,
    -    when both entries are ORC_TYPE_UNDEFINED, it could result in both a < b
    +    when both entries are ORC_REG_UNDEFINED, it could result in both a < b
         and b < a, which breaks the required symmetry and transitivity.  This can
         lead to undefined behavior and incorrect sorting results, potentially
         causing memory corruption in glibc implementations [1].
    @@ Commit message
         Transitivity: If x < y and y < z, then x < z.
     
         Fix the comparison logic to return 0 when both entries are
    -    ORC_TYPE_UNDEFINED, ensuring compliance with qsort() requirements.
    +    ORC_REG_UNDEFINED, ensuring compliance with qsort() requirements.
     
         Link: https://www.qualys.com/2024/01/30/qsort.txt [1]
         Link: https://lkml.kernel.org/r/20241226140332.2670689-1-visitorckw@gmail.com
    @@ Commit message
         Cc: Steven Rostedt <rostedt@goodmis.org>
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    (cherry picked from commit 0210d251162f4033350a94a43f95b1c39ec84a90)
    +    Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
     
      ## scripts/sorttable.h ##
     @@ scripts/sorttable.h: static inline unsigned long orc_ip(const int *ip)
    @@ scripts/sorttable.h: static int orc_sort_cmp(const void *_a, const void *_b)
      	 */
      	orc_a = g_orc_table + (a - g_orc_ip_table);
     +	orc_b = g_orc_table + (b - g_orc_ip_table);
    -+	if (orc_a->type == ORC_TYPE_UNDEFINED && orc_b->type == ORC_TYPE_UNDEFINED)
    ++	if (orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end &&
    ++	    orc_b->sp_reg == ORC_REG_UNDEFINED && !orc_b->end)
     +		return 0;
    - 	return orc_a->type == ORC_TYPE_UNDEFINED ? -1 : 1;
    + 	return orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end ? -1 : 1;
      }
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

