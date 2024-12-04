Return-Path: <stable+bounces-98581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652909E48B0
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1DF281D39
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63C61AFB36;
	Wed,  4 Dec 2024 23:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slgEz23m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F0E19DF66
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354591; cv=none; b=c76eMIRb1mAk7ngBLu9/ogRB+PN2kj+8yptrwgFq7SI7vk+JiroQjNKXeaQba/T8v0rRrR13Sli8hOlxgprYAmSN3PBo55R+Z5zLyToOW0lEkAt6DhVWn1xYH3RmkSbGj2Gwy18xslpd4z0c65ilW5o4ttWFnMLIC5wDqihg0qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354591; c=relaxed/simple;
	bh=SDxqTNOBfJp5rQDoZ33oJmtHH1FgABKnQQzrgLB1XOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELVZ8KAN8ZNr8cJrHvR1f3dRUTF3bi3E9eZykeTC2eMQD8BAObe9Bm3VIxB1wdwqxjElxUSMIygdgHuQCrJ0M6RYwCpQDvnPjNx/84eyGiHOoD/0NlsKoBkTkHS3eNm6tFxq7Oadd2XhoOrbi0eEg4ur0bciJvjBUMvq9h5t0F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slgEz23m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CEBC4CECD;
	Wed,  4 Dec 2024 23:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354591;
	bh=SDxqTNOBfJp5rQDoZ33oJmtHH1FgABKnQQzrgLB1XOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slgEz23mKz1lQ3sATVrFIW1g5AT/KlJsK8SmblAUhqy6gVU56WR9SIXOTmHn7OXlK
	 mnXnEUcnBSXFnMSzZnXfYWWIGLY6hfQQ3v70PCg3hRHGtruRM+cc7HrMAIfzGUED2R
	 A9+kdhd5D809BHxdMPbJBfqTuZz66RymNWFcv/+dexXtKe4Ratc70/OIK6FKl0nZvo
	 Bea7SDtJP02uYiWW2VkM2LBis2VL1V+Mbq5yU7VPCYJc2o52+7K+q/f4g/XZppAxUr
	 rts4MJ9gn5BglRqu9FrUGfyGWleUtM5juC+WdcHMIuVTFA5EoinRa3lwtSWw5/skgQ
	 NfNJkVmMvp9kg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19] perf/x86/intel/pt: Fix buffer full but size is 0 case
Date: Wed,  4 Dec 2024 17:11:51 -0500
Message-ID: <20241204160811-7c261423eb5dcf59@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204181126.61934-1-adrian.hunter@intel.com>
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
4.19.y | Not found

Note: The patch differs from the upstream commit:
---
1:  5b590160d2cf7 ! 1:  787e984867a5b perf/x86/intel/pt: Fix buffer full but size is 0 case
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
    -  * @stop_pos:	STOP topa entry index
    -  * @intr_pos:	INT topa entry index
    -  * @stop_te:	STOP topa entry pointer
    +  * @stop_pos:	STOP topa entry in the buffer
    +  * @intr_pos:	INT topa entry in the buffer
    +  * @data_pages:	array of pages from perf
     @@ arch/x86/events/intel/pt.h: struct pt_buffer {
    + 	local_t			data_size;
      	local64_t		head;
      	bool			snapshot;
    - 	bool			single;
     +	bool			wrapped;
    - 	long			stop_pos, intr_pos;
    - 	struct topa_entry	*stop_te, *intr_te;
    + 	unsigned long		stop_pos, intr_pos;
      	void			**data_pages;
    + 	struct topa_entry	*topa_index[0];
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-4.19.y       |  Success    |  Success   |

