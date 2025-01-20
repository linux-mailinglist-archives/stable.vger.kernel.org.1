Return-Path: <stable+bounces-109571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83A3A172AB
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 19:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83B53A5A7F
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 18:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A561EEA46;
	Mon, 20 Jan 2025 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQWB07SU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51B11E9B3A;
	Mon, 20 Jan 2025 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737397613; cv=none; b=PUXyCsf8Hlik3dpr+0eIm8Nu1vX1D+hVuUWf+NEALhuACA45zBxqP0Yio+IzIK3jvPz1hHXqG9nxuqMrCsiJpwPxRHJDrUuPCWWCoC8T9LKP0x/57u4pqqc8jFbIUM0Uu0HK7HM/Yy4U76IZ2GnDSL+htPmlzZniMMOZtV18C8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737397613; c=relaxed/simple;
	bh=oh4XG0k1wiyb4ciLC+LsJtjwpJlpzCNaNP0e4izg59E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nQXigULKd0ETdo8rjiYUwkGyz8wxDlx001gBNzs6auQ1vCaGS171N+qIIMirBKhf4RlkGoQ2NMpL9M8wwczX6V3lVlVeeJCDJ1asXXC/k3ldp1EwXrbbqCWPP51Y9H8fjzLv3GH9Wsyjh9nbHJJbncDqwcdOSfhlRphDqWb1f0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQWB07SU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B2DC4CEE2;
	Mon, 20 Jan 2025 18:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737397613;
	bh=oh4XG0k1wiyb4ciLC+LsJtjwpJlpzCNaNP0e4izg59E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PQWB07SUH1LhTBmx6q4Sn6iZ0i2WewQ4kDE7Srj4R6BVy8sRf4uVWGWWwt6tv1JYq
	 a1muJCItdAWAixDzEAhISFuErH23CLl+N6/SJmkTQuxUGPtAk8ai18IFW799Lg1owc
	 FpOVqVUjxyYFkdO3wPKHgE4x6BKUNwpttzPPnEbI2cq0RSHcLCtjXJq+K+z3HD2i/M
	 VyncKAYGPpyVCXzL3S5DC/I/SNVfIc4AAGltaKT9JHS+z4t90jjTocP9AZ0dTGpoVa
	 JGTei1QRwRSOWCT8V8K+mQCzrOW+HPcAYaZfHLU9jofbkGZopftkb/rj0jZrv2Lpw4
	 vrze8hFxuVRAA==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
 kan.liang@linux.intel.com, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
 Chun-Ying Huang <chuang@cs.nycu.edu.tw>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 stable@vger.kernel.org
In-Reply-To: <20250116110842.4087530-1-visitorckw@gmail.com>
References: <20250116110842.4087530-1-visitorckw@gmail.com>
Subject: Re: [PATCH v3] perf bench: Fix undefined behavior in cmpworker()
Message-Id: <173739761304.3950752.5970208244862437457.b4-ty@kernel.org>
Date: Mon, 20 Jan 2025 10:26:53 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 16 Jan 2025 19:08:42 +0800, Kuan-Wei Chiu wrote:

> The comparison function cmpworker() violates the C standard's
> requirements for qsort() comparison functions, which mandate symmetry
> and transitivity:
> 
> Symmetry: If x < y, then y > x.
> Transitivity: If x < y and y < z, then x < z.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung


