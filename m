Return-Path: <stable+bounces-121440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E75FA570D2
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 19:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2D73B8C75
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 18:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035342417E0;
	Fri,  7 Mar 2025 18:53:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF72D19DF4A
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741373604; cv=none; b=OsH45VTPwS12BKo00Gfw7Gi4mO5gLMrFwuPiFIqwy4XrgacpVMDQeCoViR6bl8vdtQU2wojCDZfnCitTcTtmN6jUEUBOvHhrhuDBAxkCXXsOcFxlOu93Hr74TyqWMjtyQS6y4W45AtKU6p60XUsPTExz8dUSLbEWeLyK22cedcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741373604; c=relaxed/simple;
	bh=f5RaltRUyV+F6beO9e29Vt/4W6TxbtImqz+l8hw5KvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3Wle0HvZ1A1HfKWX2kq/St8hwpyFth+Zki+cLPG9AgVB7N91SXaXupWE34p0mea0QBVCiDiPzkIxrPy7NmOgYTu7xEHA6SereiB2Ki+gCnZ2TQN3y6uh/zpjDot/HDBsWT3+6kXDVRhIKVwaW+UbhGAz35LP0agVEeNb/B+vrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D87DC4CED1;
	Fri,  7 Mar 2025 18:53:22 +0000 (UTC)
Date: Fri, 7 Mar 2025 18:53:20 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: gregkh@linuxfoundation.org, agordeev@linux.ibm.com,
	alexghiti@rivosinc.com, anshuman.khandual@arm.com,
	christophe.leroy@csgroup.eu, david@redhat.com, will@kernel.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm: hugetlb: Add huge page size param to"
 failed to apply to 6.1-stable tree
Message-ID: <Z8tAoJpyB8aye2uV@arm.com>
References: <2025030437-specks-impotency-d026@gregkh>
 <f1cbc610-e78d-44df-aba1-9c8b392670f2@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1cbc610-e78d-44df-aba1-9c8b392670f2@arm.com>

On Thu, Mar 06, 2025 at 03:52:09PM +0000, Ryan Roberts wrote:
> On 04/03/2025 16:41, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> From v6.1 it becomes non-trivial to backport this patch as it depends on a patch
> that is only present from v6.5; Commit 935d4f0c6dc8 ("mm: hugetlb: add huge page
> size param to set_huge_pte_at()").
> 
> Given this is fixing a theoretical bug for which I'm not aware of any actual
> real world triggering, I'm proposing not to backport any further back than v6.6.
> I've already sent the backports for v6.13, v6.12 and v6.6.

It makes sense to me. Thanks Ryan.

-- 
Catalin

