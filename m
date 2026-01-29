Return-Path: <stable+bounces-212750-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAF2Iuoge2lPBgIAu9opvQ
	(envelope-from <stable+bounces-212750-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 09:57:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AE3ADE05
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 09:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDBD530097DE
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 08:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2F9344D91;
	Thu, 29 Jan 2026 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEnUrwcg"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2742C08D1
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769677002; cv=none; b=sGnkQbozchi3D/phEiqmC8345u1LdIO/Dg15Hap/vfgbWrZVNOP0qIWNdDu+VM4f+FoF8yBLRgPVKqHqPxB00RH0cye/JxeVKY1LzcwfMd8C7XfpSEWdl1sEazP80oV2nTnsejVOdIv+pVMzITwkIlt/1/NBHXO1sCUZtsoAyIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769677002; c=relaxed/simple;
	bh=Jc+itJLFI7nZrOGiVGvgpQwW4Pcfy6oWEaHovGrRsyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXomC8mir7jp5x/FTqONeFDjXvX1Mk9YTn1Bwkwxf+dAJ5Ef2UE0V8et0tAuASTUGJjJYDWkQekKd7iqoAUOafdsfqhrVoit6vdeHnA4IcGuXTjrzbibHp908z7Ik9akp2key6WL2UIg7bsRt/I9h1MNdJf8SOyw1ePGY4Sh3H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEnUrwcg; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59dcdf60427so812447e87.3
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 00:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769676999; x=1770281799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KG9xWqkx9/gF4du2pqNNAT1bO7cWgGHdinzUlqAxblE=;
        b=TEnUrwcgzvqUEfeMUFi8oGZgANM0sLjjtuudMaMHNkHgNpzOy5YpPoxQBlv39UVSkX
         UVjEZohWgzfZc2C3I5oZcQXAaSnKEo3MGSxImtNh/WGDtYz7CZtMyvjHqPRturs3doOo
         U7nrbpQfGhRfKeeJXxhRL3kW/zONl47O0PHS4UvPk6NEJKgua6g3ZzHHrAanZ/GO+kv0
         hf0bOEMS593C8RDwcHniT5Hn+pZ6H3kmLxw8+nj7kT/YOONV9BKuotwE5YrRxplTO4U0
         S1wQXRUlk8epcsQ1SuPwJ1O2RqnKZrgkDY/U809s+3tQnTB7YAg7DR8TVJ86ne4/usNd
         HwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769676999; x=1770281799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KG9xWqkx9/gF4du2pqNNAT1bO7cWgGHdinzUlqAxblE=;
        b=g84gZ83UOCV734EJ3E4JQ3bWbdwvMUgSxdLLihm/eDn3JAXP7rsRvXNG0PcjMDxibN
         fjmPclBOiu2v+ZO/t9tjvI8Mx+I5tlp39zGPJ+5ltshrXjY35/x3CZL5vVzbOSSFvzNQ
         6pP3VQiNaooomaN51Lx6atHpck/Ajuc7NPo0uU7H73afyzg1n3lbZsiSRyz2HBF7DYzJ
         h1i4Y0goqwqaNe/4vVD+sMll3Nh5P3a8AsxuaZlvzTjNs64ixdNwD8/ftlRBV/Hy0/6W
         X6OEyzoIqR937uFXkHWBxda/oi2FQEUi1asV8v98pObwlV8Hk0OlKFxY1HAfT2X3ZlgK
         vr5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWP1mRPRZRAX996UYK6W+EOClygKTa5KMV/PTokGP3FoMItpMqtMuGk+G19uh5wFkf9fzh3zes=@vger.kernel.org
X-Gm-Message-State: AOJu0YycbodU0XjA0tAr/rqmQ9MBKIjqsmmwGV2B7hc45RKFR8NO2HkQ
	xUc0zUc/Z5U/W8vOj6SSquVrrnXYIXKtAOFuSKZCM1ZhdFXpKKKzwiMf
X-Gm-Gg: AZuq6aK6mpVQbabbNkkbgPPXpEgA1ZR11m0vSZ1HrJrPOe0GVj4KARuywix7OYqsbDr
	gwGKzvpbllsWN7w8nk/aYLfHTRHcbNQMgoeL/PpjUUBSHniQ/ThsKCfFJ9IX3rzJUV8/E0VHItA
	AAG7aPdPvyQP0x/Xh6EXmxJksv6Nd7Y1hTLYOZgh8DQ0UbIBsr+x5CsEeGadwoLmFv8LtXvMZs3
	mY5bamcRSrbqNSQKP5I6H967V+chCN0KG4M/E+qWDC+vQDZ3GbE1rbFYIz1ob3YHMPVSun2eS8S
	yVN+Z5FPZt98y87naH5SLpwg8bd7hNm1pg4n1gLfitupv7Qvhnlw3ydj+JUEgdkVvq2OCdZO80k
	Kx29bVxnZfOK/869fr8HCezxpNnvWsMmL0frj4vEFo+iVKT0oWKEp6t333s+BwZUwCFu655c1P2
	Yufd5mre2+dDB2vWQqpoSpdbM=
X-Received: by 2002:a05:6512:159b:b0:59d:d342:88af with SMTP id 2adb3069b0e04-59e04017dc1mr3548716e87.16.1769676999124;
        Thu, 29 Jan 2026 00:56:39 -0800 (PST)
Received: from foxbook (bgw148.neoplus.adsl.tpnet.pl. [83.28.86.148])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38625fcd5bfsm7575811fa.47.2026.01.29.00.56.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jan 2026 00:56:38 -0800 (PST)
Date: Thu, 29 Jan 2026 09:56:34 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: xhci: Fix memory leak in xhci_disable_slot()
Message-ID: <20260129095634.0775dc40.michal.pecio@gmail.com>
In-Reply-To: <20260109045410.1532614-1-zilin@seu.edu.cn>
References: <20260109045410.1532614-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212750-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michalpecio@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7AE3ADE05
X-Rspamd-Action: no action

On Fri,  9 Jan 2026 04:54:10 +0000, Zilin Guan wrote:
> xhci_alloc_command() allocates a command structure and, when the
> second argument is true, also allocates a completion structure.
> Currently, the error handling path in xhci_disable_slot() only frees
> the command structure using kfree(), causing the completion structure
> to leak.
> 
> Use xhci_free_command() instead of kfree(). xhci_free_command()
> correctly frees both the command structure and the associated
> completion structure. Since the command structure is allocated with
> zero-initialization, command->in_ctx is NULL and will not be
> erroneously freed by xhci_free_command().
> 
> This bug was found using an experimental static analysis tool we are
> developing. The tool is based on the LLVM framework and is
> specifically designed to detect memory management issues. It is
> currently under active development and not yet publicly available,
> but we plan to open-source it after our research is published.
> 
> The bug was originally detected on v6.13-rc1 using our static analysis
> tool, and we have verified that the issue persists in the latest
> mainline kernel.
> 
> We performed build testing on x86_64 with allyesconfig using
> GCC=11.4.0. Since triggering these error paths in xhci_disable_slot()
> requires specific hardware conditions or abnormal state, we were
> unable to construct a test case to reliably trigger these specific
> error paths at runtime.
> 
> Fixes: 7faac1953ed1 ("xhci: avoid race between disable slot command
> and host runtime suspend") CC: stable@vger.kernel.org
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

This looks like correct fix to an actual bug, but it seems that it has
been missed? I see it neither in usb-next nor usb-linus or mainline.

The leak is still there, even if arguably a small and rare one.

Regards,
Michal

