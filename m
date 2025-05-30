Return-Path: <stable+bounces-148132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CBEAC8708
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 05:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174C79E3ABB
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 03:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7350154652;
	Fri, 30 May 2025 03:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ipOCa0lu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2488D33F9;
	Fri, 30 May 2025 03:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748576876; cv=none; b=b/EksPPydzvrG6AaAB0DwZYBpW9hB09HiXjffzdoX/vvSuFY/3FpoSlEA2DjNKmoIA7vAhqF93sH6HBWPQaBFZlMo1tvrH/YbRukf0B/MKRsXbWuRy9FsrYDoNqPh9ZUZOTtCJ8MlkpVlO1kKRFufLZWnqbD+IJ6Sscl/XUP4sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748576876; c=relaxed/simple;
	bh=Hb97F5GkYpcc48N6f3tWzBC3BkuaZ0i7TfPlpBexI/g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UTc6dV6HdMYOeQDJDEgO3zgKO+C2bIxeDu6t/JxARsZzmLz/2k8z7vMKHI4CRoxWCa7zUI5B9dKeifrgrGDg/Gvsq+DFzPAbU+KDRrAGk33MNjo9Ahz30Z9O6hr5bsOQN2dCVAJ6f1dbhnU7iuyrT1tVbNYO7fN+HWHXXoZ57sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ipOCa0lu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074CBC4CEF0;
	Fri, 30 May 2025 03:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1748576875;
	bh=Hb97F5GkYpcc48N6f3tWzBC3BkuaZ0i7TfPlpBexI/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ipOCa0luwWgZ5Jq3z4iLedmlMD4HEMnw9X/sWU8k81ZBz9iizBTsblXMuUBy+19aX
	 LcQgSctHDRRNjrpNxZBVmW3UEKN8CsLXmB1MsOEbNiThlNsIK9PEue/rj4oT4h9ypC
	 A0SeNcpnLTDoSOuXCg3ECYX6AXy0Y4fuAXlGNV3s=
Date: Thu, 29 May 2025 20:47:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 jannh@google.com, pfalcato@suse.de, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, pulehui@huawei.com
Subject: Re: [PATCH v1 2/4] mm: Expose abnormal new_pte during move_ptes
Message-Id: <20250529204754.f3cd5d72cd68755e6753d378@linux-foundation.org>
In-Reply-To: <263929f5-bde6-48fb-a162-298a9f83bf5b@huaweicloud.com>
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
	<20250529155650.4017699-3-pulehui@huaweicloud.com>
	<20250529121944.3612511aa540b9711657e05a@linux-foundation.org>
	<263929f5-bde6-48fb-a162-298a9f83bf5b@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 May 2025 09:24:54 +0800 Pu Lehui <pulehui@huaweicloud.com> wrote:

> > check that patch [1/4] is working?  Perhaps VM_WARN_ON_ONCE() would be
> 
> Agree, should I respin one more?

That's OK, I added this:

--- a/mm/mremap.c~mm-expose-abnormal-new_pte-during-move_ptes-fix
+++ a/mm/mremap.c
@@ -237,7 +237,7 @@ static int move_ptes(struct pagetable_mo
 
 	for (; old_addr < old_end; old_pte++, old_addr += PAGE_SIZE,
 				   new_pte++, new_addr += PAGE_SIZE) {
-		WARN_ON_ONCE(!pte_none(*new_pte));
+		VM_WARN_ON_ONCE(!pte_none(*new_pte));
 
 		if (pte_none(ptep_get(old_pte)))
 			continue;
_


