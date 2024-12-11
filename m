Return-Path: <stable+bounces-100686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4AA9ED350
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 18:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372C0162793
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690481FECA1;
	Wed, 11 Dec 2024 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spNaWYUa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212B51FE47C;
	Wed, 11 Dec 2024 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733937823; cv=none; b=Z8ESPHZ4IMS5tTsa2t1ULXMJd/Q9i6/3ckUCcxZwGSWkmiHbRPqeV/sjM5UMOTgpea1d7KTjC51MLduiRXVHautOKbmTm2MIJI97SA2k+XZGOmMhX1/egIOiVbjoP57/TPKWHg+ymrpHherCBIj/fXH4J0a+ly/khiDMbwil3Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733937823; c=relaxed/simple;
	bh=IYsNBdQdVcowQwyGpXBzqBBm2krl0bXJAf/tpHDwcCA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jrLjy1s5KobtbAQ1ZEb9Tc6nvpVmXvXBCmCZBrGEuUPr1CDoSJNJYmesjsfbZxBAmOOMSLRvxveR6F9vr43TgNwM8ohIp8nS+lCIXN0ii/QnIz/cEkFqJZaHXFilKQbGyiukaIF3zo4lQJiKlJAEpR4HHQ6GZFFrG1frKzDzrmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spNaWYUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3221BC4CED2;
	Wed, 11 Dec 2024 17:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733937822;
	bh=IYsNBdQdVcowQwyGpXBzqBBm2krl0bXJAf/tpHDwcCA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=spNaWYUaRWPqAmhzHL5sA7xXHoFpdSsRPnZot2GlOiJPZTkaOMNKsdF1CkwC8XtVM
	 p2gwDBMXv+Zri82X4AfO9cU32czdCliJ36eEYvEOlZTjoeKIxIU9a2jdm/Nk5u3Tv0
	 QWLbMo41wIZvqcAEarvfDPtjqdq1BZUKrtmXon9eq8Hk4K6n0xoZ5+jWiVYwgNKU7G
	 UmYJzpbQ6Sj45B4og+zikyO++NsGAHoaz9oEk19uj8+reAKrN+8BWgXobBWSFndoZm
	 3fDDdaroy+CrOJdtE2qB51ZE8qVFNi2gQoUqeFAxMbz4cXZa8uTXI6PuvnRhjc2Zk7
	 ucjK21dGiylEg==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
 jolsa@kernel.org, irogers@google.com, kan.liang@linux.intel.com, 
 adrian.hunter@intel.com, jserv@ccns.ncku.edu.tw, chuang@cs.nycu.edu.tw, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20241209134226.1939163-1-visitorckw@gmail.com>
References: <20241209134226.1939163-1-visitorckw@gmail.com>
Subject: Re: [PATCH] perf ftrace: Fix undefined behavior in
 cmp_profile_data()
Message-Id: <173393782213.3536107.18239500348967688224.b4-ty@kernel.org>
Date: Wed, 11 Dec 2024 09:23:42 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 09 Dec 2024 21:42:26 +0800, Kuan-Wei Chiu wrote:

> The comparison function cmp_profile_data() violates the C standard's
> requirements for qsort() comparison functions, which mandate symmetry
> and transitivity:
> 
> * Symmetry: If x < y, then y > x.
> * Transitivity: If x < y and y < z, then x < z.
> 
> [...]

Applied to perf-tools, thanks!

Best regards,
Namhyung


