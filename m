Return-Path: <stable+bounces-238226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Al1JEsO4GmzcAAAu9opvQ
	(envelope-from <stable+bounces-238226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 00:16:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA389408813
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 00:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC61E30DA59C
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 22:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E05838F631;
	Wed, 15 Apr 2026 22:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m86eovh8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0126938D69E
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291305; cv=none; b=LirXqip2e40Sc0Kif6dJWcFcFMkMvprMmILq44YysYh8jgANoqrsmilRQLqD9QtiPWvEKgC+hMw6KPgP0WEUAIUq9he8BIeskYvPDdjFNiL4CcgZHdQPJNg4r9+g+QDUKdLEtb2R/OYr5g5CSjNHVOfrGIqrOetBoGZ5FcWZJ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291305; c=relaxed/simple;
	bh=vdpdh0xkIajBHZM7qoM+xUEgxrphiImhs+GqNY7hsgk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KPeJVnQbpqX6t8PaLWoskF0x9l3WSW5wYEruJtJDm9QV4iYT1WK7+QmBDACXsmL2cMZ4pQ/5nW5SzxyYJJjKouZ7Scg/EoFMYfppCxtJ6gTtYIeLVeLq7wiUrbVn8WjDanhjVXNdKj/3ESSQ2sqynzVMnJ5iQSrQ7TpEanxYZ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m86eovh8; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7963d8d167so279032a12.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 15:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776291303; x=1776896103; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QToygMVPGVk7KubMavoRHu5zoGCxschPTOHOfHs+CAE=;
        b=m86eovh8ogYowY0tzQ6FROQDvE9t4A1wL3zbX85Wmy34yKkRulRZLNfes5y3L+Kpil
         5Fr4KWWWwPk/D8ieVgvke/Aa1yYYJSm0nuQfivMdvSWhD3uXa9S2axthTfsuXwpfFq/Y
         aBaHiAlb6cB/le0x9VZtXdcngBqG1AMiiXBiYyNgD7K8RzBbSdAYgGIqiBg5Fsdlw2fH
         0Ar6JIZ7DZiVw2F6K8Lj7lKg4HXAH9pH2zT3Wo36W8jSlF3Z/dbztLuXHkqP/1T3hlTj
         Vi4nYIcR0+UCTGM/w15YNPLGPnXa7OKhMMZ2R8yM0e/2rGBn79J/6pOZlcm3GSqZIgZC
         io0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291303; x=1776896103;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QToygMVPGVk7KubMavoRHu5zoGCxschPTOHOfHs+CAE=;
        b=SL5GyDFt+AHwqYT+mw7DBjZPzEO/r6iVUdCJoLI6o6MV66YUJOtkZeOrxNDyhB8Txi
         GsKnl4lIGeaKLJnkikDggtItDwrHhNtH8yn4WxxIHJOMiJUf3GMAhxv/Jj2OgQ2eN8wT
         qHdA4VoOY+A4N0tgj49rLa4wSYMtF+1snHRRbapmOILm9+0UehBB+haNbhmpY07UhfHw
         GMeA/EkY8+pUcl1E+dL1JvDIs5DN8i4tUwltrHe0izQ1Jk2k9r8B+BWgulHpOhPghr4G
         lqeOtpuOI5VlrNZkhmVfz5tSSK3QdwdUdfxH2/IB1EwND1RPXm9kNA3lgtyDL1O7WMOR
         MTfA==
X-Gm-Message-State: AOJu0Yyihb+jUQV6iYnGg4sy+/8K3DCBjksdpL60smhC+fwVg0cYTd1W
	bG/IZP2ElQI1xPtgXhYazBPlsRdrsbhV/h6NIxnFqpop46sVakW8AFJfkP/FbTLTMYuslifc0UF
	TTzHSeQ==
X-Received: from pfqn4.prod.google.com ([2002:aa7:9844:0:b0:82f:423b:4e94])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:130f:b0:82f:5a77:10e8
 with SMTP id d2e1a72fcca58-82f5a7718f8mr7125611b3a.20.1776291302998; Wed, 15
 Apr 2026 15:15:02 -0700 (PDT)
Date: Wed, 15 Apr 2026 15:15:01 -0700
In-Reply-To: <20260413140746.2904035-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026041318-chowder-paper-ef87@gregkh> <20260413140746.2904035-1-sashal@kernel.org>
Message-ID: <aeAN5USkyhv5B9kh@google.com>
Subject: Re: [PATCH 6.12.y 1/2] KVM: Remove subtle "struct kvm_stats_desc" pseudo-overlay
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Bibo Mao <maobibo@loongson.cn>
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238226-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brainfault.org:email,msgid.link:url,loongson.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA389408813
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit da142f3d373a6ddaca0119615a8db2175ddc4121 ]
> 
> Remove KVM's internal pseudo-overlay of kvm_stats_desc, which subtly
> aliases the flexible name[] in the uAPI definition with a fixed-size array
> of the same name.  The unusual embedded structure results in compiler
> warnings due to -Wflex-array-member-not-at-end, and also necessitates an
> extra level of dereferencing in KVM.  To avoid the "overlay", define the
> uAPI structure to have a fixed-size name when building for the kernel.
> 
> Opportunistically clean up the indentation for the stats macros, and
> replace spaces with tabs.
> 
> No functional change intended.
> 
> Reported-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Closes: https://lore.kernel.org/all/aPfNKRpLfhmhYqfP@kspp
> Acked-by: Marc Zyngier <maz@kernel.org>
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> [..]
> Acked-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Link: https://patch.msgid.link/20251205232655.445294-1-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: 2619da73bb2f ("KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI structures with VLAs")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

