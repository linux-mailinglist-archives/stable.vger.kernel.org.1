Return-Path: <stable+bounces-230516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLncNniAxWkk+wQAu9opvQ
	(envelope-from <stable+bounces-230516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 19:52:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3815C33A6F3
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 19:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3750305F7F1
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 18:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DEC364E88;
	Thu, 26 Mar 2026 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mGceCbta"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0E39A7FD;
	Thu, 26 Mar 2026 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774550688; cv=none; b=Q3JnmGrPpY/6b9BdyfjtzEs/pOmXzxzd2FkaJztEhtD7gQBf29Urb1xvKfg5bB+vX3+3OIpCWjnRfoISO1d4ek1xoiudZsNUNM1Q1s51q7pjZY/gd58fXod8uDO+0ZCV/NVkMhfI3gtJkEbcra/tzlpyTsrrdWpa2s2+kwbD8ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774550688; c=relaxed/simple;
	bh=vI80se4bLtnT+E6LjYZnwjZAkXt7xCbq1jvM5HcFlXk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=l8FeEynJmA/5gFy2ad+SdFPY1U79RU5lcS9YzxWfh3MgDmGPEPvz0jhjsl3HOZ2P55DR8XvxLzk+FPQD/V+U7oTQRbbVCgUQAGFHw3Wt15XOVwO0/5VMU8erMnLJ1n3QCj91Sg5e9onbZfqNosEaJnItiiTSSysI0XQsksYzCKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mGceCbta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDF9C116C6;
	Thu, 26 Mar 2026 18:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774550688;
	bh=vI80se4bLtnT+E6LjYZnwjZAkXt7xCbq1jvM5HcFlXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mGceCbtaL4t4Y2ZgyhjmkYb0BRtw34lQBPMNMuMESr7d+4Qn/0HIafbrKP8HVqK9w
	 d0UGddCa06h3+E7NSh4cVPXEe16jDP8tjxYkOf3PmjCutAWfIFufXSevaCeeRLT8qt
	 NFzR4Vw0kXZmcGkuepGt3IS/p7gSDdN4SW8cYm6c=
Date: Thu, 26 Mar 2026 11:44:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Josh Law <hlcj1234567@gmail.com>, Liam Howlett
 <liam.howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, Alice Ryhl
 <aliceryhl@google.com>, Andrew Ballance <andrewjballance@gmail.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org, Josh Law
 <objecting@objecting.org>
Subject: Re: [PATCH v3] lib/maple_tree: fix swapped arguments in
 mas_safe_pivot() call
Message-Id: <20260326114447.b5df309ae13ad5f92e9e0102@linux-foundation.org>
In-Reply-To: <cfbe0037-00a0-4837-9a70-575010c201de@kernel.org>
References: <20260306225849.2824409-1-objecting@objecting.org>
	<cfbe0037-00a0-4837-9a70-575010c201de@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230516-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,infradead.org,google.com,vger.kernel.org,objecting.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3815C33A6F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 19:02:35 +0100 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:

> 
> I'm not a maple tree expert but this looks obviously correct enough. So I
> won't speculate on the impact of this bug, but:
> 
> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> 
> I guess since it's old and not in mm-hotfixes, we can afford to wait for
> Liam who should be back before the merge window.

Yup, I'm keeping this parked until Liam is back on deck.

> I'm not sure how to
> handle the fact that this patch has been withdrawn [1] however.
> 
> [1] https://lore.kernel.org/all/E1A667AB-DCE4-4034-A36B-DAA458780A81@objecting.org/

Waiting to see what Liam says.  If he likes it then let's proceed.

