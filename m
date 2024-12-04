Return-Path: <stable+bounces-98580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DA39E48AF
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5BE92815BE
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88DB1F03FF;
	Wed,  4 Dec 2024 23:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTCOtcK9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7999819DF66
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354589; cv=none; b=VuAxxFoVziGec3+tzj0Pgssf9sgFH5Ml/SBOPILtSeF+TJ/ZelwsnYvYavCBNDdGjIUtczxNO6pIEU+MWJAa3J7liP3tTGJtLYPwUFI75BTOQzh6Q0D6XXRsbcRmsCFMZES8loNaquyfKHbi77bF0lJrkKJf9DzwaMpztNTYD0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354589; c=relaxed/simple;
	bh=fcnK5EgYIDny/zAT0Dv9219HhlGKb+7TNKo32ALYxws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1ndfYo+GrjvVOWae35dJmyJ2sNIxxn7MdpZkR+AzJKBtQrK1MctOrPM1cInr2vO1v0pp4CO2mNnu3+F6MLurqAd+MGeixham6PwAy55cVc4BVU/Q+HPeHVdnptn75FhbyWwBeAOTlg0+MudPatM7CC+XPLlDgJqvrFctjPqycU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTCOtcK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F23C4CECD;
	Wed,  4 Dec 2024 23:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354589;
	bh=fcnK5EgYIDny/zAT0Dv9219HhlGKb+7TNKo32ALYxws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sTCOtcK90chtA/Od+1XRU08t0o/ucBv92efevNJDIQqUfT4d1PeqT/moTtquWud8P
	 vqAykMwyi6Ak+nnIR0NYHeYkrAvnOYs/dDbQcnFWwSLra0uqQ5fFc9yc5hOO3bJiCZ
	 ViGwLaWuf1vieyIBrRBDgLk8atGEHub4TQUi3XYTRJiUBfgvzYvcYShZ4KBho3Mwwb
	 3sRgX0cSmvk6Xkj8qhtl5WZOHnB8bvsyIJgnpBncTS6RzBEboQvWq2xJCT9WJ4ZE3t
	 MyQStc86eNhlaeSVbGuSvA9fMvQQxZNQ152vmVM9+oQz4wijSf46O3YkyzUFGhsEah
	 ZmnthbIFxGGKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4] perf/x86/intel/pt: Fix buffer full but size is 0 case
Date: Wed,  4 Dec 2024 17:11:49 -0500
Message-ID: <20241204161223-ec83dd38f8016b98@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204171249.59950-1-adrian.hunter@intel.com>
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

The upstream commit SHA1 provided is correct: 5b590160d2cf776b304eb054afafea2bd55e3620


Status in newer kernel trees:
6.12.y | Present (different SHA1: bd0081617661)
6.11.y | Present (different SHA1: 549225e02e9b)
6.6.y | Present (different SHA1: 1488d93e3e1f)
6.1.y | Present (different SHA1: bda8868213ee)
5.15.y | Present (different SHA1: 1b843f820f7a)
5.10.y | Present (different SHA1: b243226da582)
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  5b590160d2cf7 ! 1:  907198d6c6223 perf/x86/intel/pt: Fix buffer full but size is 0 case
    @@ Metadata
      ## Commit message ##
         perf/x86/intel/pt: Fix buffer full but size is 0 case
     
    +    commit 5b590160d2cf776b304eb054afafea2bd55e3620 upstream.
    +
         If the trace data buffer becomes full, a truncated flag [T] is reported
         in PERF_RECORD_AUX.  In some cases, the size reported is 0, even though
         data must have been added to make the buffer full.
    @@ Commit message
         Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
         Cc: stable@vger.kernel.org
         Link: https://lkml.kernel.org/r/20241022155920.17511-2-adrian.hunter@intel.com
    +    Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
     
      ## arch/x86/events/intel/pt.c ##
     @@ arch/x86/events/intel/pt.c: static void pt_buffer_advance(struct pt_buffer *buf)
    @@ arch/x86/events/intel/pt.c: static void pt_buffer_advance(struct pt_buffer *buf)
      
     +	buf->wrapped = false;
     +
    - 	if (buf->single) {
    - 		local_set(&buf->data_size, buf->output_off);
    - 		return;
    + 	/* offset of the first region in this table from the beginning of buf */
    + 	base = buf->cur->offset + buf->output_off;
    + 
     @@ arch/x86/events/intel/pt.c: static void pt_update_head(struct pt *pt)
      	} else {
      		old = (local64_xchg(&buf->head, base) &
    @@ arch/x86/events/intel/pt.c: static void pt_update_head(struct pt *pt)
     
      ## arch/x86/events/intel/pt.h ##
     @@ arch/x86/events/intel/pt.h: struct pt_pmu {
    +  * @lost:	if data was lost/truncated
       * @head:	logical write offset inside the buffer
       * @snapshot:	if this is for a snapshot/overwrite counter
    -  * @single:	use Single Range Output instead of ToPA
     + * @wrapped:	buffer advance wrapped back to the first topa table
       * @stop_pos:	STOP topa entry index
       * @intr_pos:	INT topa entry index
       * @stop_te:	STOP topa entry pointer
     @@ arch/x86/events/intel/pt.h: struct pt_buffer {
    + 	local_t			data_size;
      	local64_t		head;
      	bool			snapshot;
    - 	bool			single;
     +	bool			wrapped;
      	long			stop_pos, intr_pos;
      	struct topa_entry	*stop_te, *intr_te;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

