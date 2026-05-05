Return-Path: <stable+bounces-244202-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFsjMqMO+mntIgMAu9opvQ
	(envelope-from <stable+bounces-244202-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:37:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 402AB4D04BD
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36EFC301A161
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D8C480DE9;
	Tue,  5 May 2026 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="e2IXY38l"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0933139D6FA
	for <stable@vger.kernel.org>; Tue,  5 May 2026 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995425; cv=none; b=FdPePSmHXhTi5zBD23y0X8HQRrzuMUmfX/o+0Kzp3VakhLSXCMk7oA7skj15MjoXfgslTeDzWtPQ9Y1yyQRCwGD7VFEzHR3sOQeWI7AHdnzfydJvyHpeUtKQSsJP3HiGDsBC0WgAbEL76Zik8qHe3FQHeD/eI0plnCTnxC+9kGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995425; c=relaxed/simple;
	bh=oheuWaY1jxMSviQLJSPxHGYWp/ROJZOBu1lavLnz/Ok=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l4rzztW7jgsauyTyTflPU3hImOtbU4C/wYms4AmxJoVNj+Q1XSEja2Oo87+hLJE2Q1gWQNLlMbCmQvQJMOkXxKPQMcF/e9G0y/HFE0X39+aBRNq2ThOBlBHSYBsDOXpKBdPlsiMkuz7Pm/15FDmGLfHEhTAD0MxrviDGq8cP7Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=e2IXY38l; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8ef0ba61d46so611025085a.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 08:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777995423; x=1778600223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Xp95Do87GefisQWCOnrXqWboy1FPW36B7zu3IiHqEM=;
        b=e2IXY38l1qMT2UoEGgaiPfLz6k8kQA7kNpoFxxmSd39tZZnMMKQhuU/mVVDdYqzwoR
         YxunGIxJ2b0O5utXDp3NDh4ZH5vEH5dNXcB5C12bC5LBErjBJl4J/UGKs3+Rz6LchCC5
         IyXp2P43NpOyDQo0P4z6VKWl3YXXgIdfSCmUQlZMWR9cHmPorfSL/IzjalnRGrhqlHv/
         Hlw0vGVw86+hNsvSfX+0Nl/WHvbcDXAYm/aZKKPU/oBCJpBgwKl2/aIxKZdk4BDtsE7A
         txggG30eBUDF5y7yL+PfzLR0YZwKaFyOfp8UTyu7B6JoXaGDxe8vpuLQ7G0Ei8ZY3V3W
         qqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995423; x=1778600223;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Xp95Do87GefisQWCOnrXqWboy1FPW36B7zu3IiHqEM=;
        b=np8L8mz87O2WXtI0uQweCHo+KxppqWfg0bEfS8WZeDlagu87hBxl3tJ1tx+gMUbZmf
         p+0no15yElxyjVEAv5g3veNfYw1qXMjZyHUp7G2yT3F6SF0OUMJvmLurepdXJ33W+0jH
         Max1Z5Egl4PQ/OSZmwjfmIWHzW1/lNq9g9uv2wrQCHrwiQy25MfZEJ/N7EWHcQDFhdWu
         qC91eZ54oyzE4ceNlEnoE5qqaOgGdiIpjuSHxleHmclpCg15LdAYiPCSqcM9D+x9F/k4
         bW4P1Gl+sSGyEqKi5DXiPiwcfXDZbWk+IVn2QJg2VYRL4Lw+Vodk/i+GcLyABSSW2/xR
         PJ5w==
X-Forwarded-Encrypted: i=1; AFNElJ9qNuq2hpqHgTcSCQ1c/WpJeFryLQcRMNKFAugdFu2SR23krCGznJIfi5OxUc+uX3SVkfbB/eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsFi6VQncsuUK8SR9nCyuTSp6iBugi0VQaS4UyB0j/P4cyV7lv
	EQztLy4D0tfGeUEDk1bN5nfh7GpoFAQ4erbwNnBvz0fb+fFODkVxvvTipj8O4jfgpXk=
X-Gm-Gg: AeBDietAgSVx44cAWCAIpVMj2CJtI1KvsBcI4XCvf+t4q/+VC+9pmjf0P/Ibwn06u2y
	duF8RyzMMqwNwsVvqUjh9xtjub3crEDapujkByW7ThRyLcB5isbL1fv8q8DOplB4co9u8pHsNul
	pOsotDd9HSIadB4OVAkq9XNnfQcC+BD8Z9ZaxBJqB1gYcJPcFJ5hP0eN/+YEMdNAiQqKPw9ny8S
	ASNy18i8d8crJKnLFGWQDD9cQeO2+VS9ad2H3QTvn0e2iTpS9IkKBcELw3no4k8nrYTRG3EQJxT
	+r+xBhPW3sVjeaFdePlbkdOqIY3hebf+Uf2zjArcBKUdZ6wWeIGOXb2z2z2ur1ZHwZYT+LU7tCD
	cL4cFZnQ8kzwjqoVSfB6s2rBtOiNmSQZsW+nW2oiOp/roRJiGnMFUMuEFxY1riDtoKGbCZ0AUZA
	dwaRttKRCpmmnCstsusdpt6QZBUtgCzG75UAr2NX+n7ij/XtbdmgEbPys1riIFOpItsp29faU=
X-Received: by 2002:a05:620a:4591:b0:8e4:ebbb:b162 with SMTP id af79cd13be357-8fd15ada964mr2204638085a.9.1777995422947;
        Tue, 05 May 2026 08:37:02 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91fb3bsm1350515585a.41.2026.05.05.08.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:37:02 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@google.com>, 
 Kees Cook <kees@kernel.org>, Pratyush Yadav <pratyush@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Brendan Jackman <jackmanb@google.com>, Greg Thelen <gthelen@google.com>, 
 stable@vger.kernel.org
In-Reply-To: <20260505133922.797635-1-pratyush@kernel.org>
References: <20260505133922.797635-1-pratyush@kernel.org>
Subject: Re: [PATCH] memfd: deny writeable mappings when implying
 SEAL_WRITE
Message-Id: <177799542165.635180.17809433268620237886.b4-ty@soleen.com>
Date: Tue, 05 May 2026 15:37:01 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 402AB4D04BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[soleen.com,reject];
	R_DKIM_ALLOW(-0.20)[soleen.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[soleen.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244202-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pasha.tatashin@soleen.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,soleen.com:email,soleen.com:dkim,soleen.com:mid]


On Tue, 05 May 2026 15:39:20 +0200, Pratyush Yadav wrote:
> When SEAL_EXEC is added, SEAL_WRITE is implied to make W^X. But the
> implied seal is set after the check that makes sure the memfd can not
> have any writable mappings. This means one can use SEAL_EXEC to apply
> SEAL_WRITE while having writeable mappings.
> 
> This breaks the contract that SEAL_WRITE provides and can be used by an
> attacker to pass a memfd that appears to be write sealed but can still
> be modified arbitrarily.
> 
> [...]

Applied, thanks!

[1/1] memfd: deny writeable mappings when implying SEAL_WRITE
      commit: 73f496662a9848021e75742a69a3239ea850c3ee

Best regards,
-- 
Pasha Tatashin <pasha.tatashin@soleen.com>


