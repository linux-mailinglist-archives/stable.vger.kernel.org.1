Return-Path: <stable+bounces-222910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHYbLxERp2k0cwAAu9opvQ
	(envelope-from <stable+bounces-222910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 17:49:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FD21F41C5
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 17:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 961BF3004601
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 16:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DAA47A0BE;
	Tue,  3 Mar 2026 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EfyJmHYm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BCA370D77
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556558; cv=none; b=M1CJmki+CdyIXZ01VP/Pv0Qk0nASD1zteG2lJXeerrj5PUu95R1UjVQ9t4yNT2Lz+UqVZe2MOwrsEwb7ZTxDd5NFh5m3aqq28Z4M9IQegWI7rslW4qh3fkzLnwQRATFVhWi4QjgRzxsMTLNIjfKdGMY+a9CGn0+4ki+vzmQXt7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556558; c=relaxed/simple;
	bh=ZKCWZSj/PczLmXnVNY3jNOC5MMSfKavBW3XMC08RcWU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NXRji5SW27oV0F/PhfoadctUeZFvdtV4E5QzIy5p1QbrDaU2hsrRCAd7QUgAp6+rxMN9hA/h9c6nLc49EHykNiuqZFKaYWb5xIqFLKtTTyeWv7mmSa6yRlA0rqZCGADyOqrejYIxRc4xVY4dnsdxoU8X9r3LwJuXRrayphugW3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EfyJmHYm; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so3742327a12.3
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 08:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772556557; x=1773161357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SEHyvGe5cSi/xW6lB+JhvVS9IlC90KwrfzMekawFEjI=;
        b=EfyJmHYmDKBLqzRnBFedgwG/9sz0rEhISkh5Avy7xvpOHSPFEPP282Y8z5lIyFKOST
         VdT1ry0ujy60sUHoZzPEGvBhXHZXPsYfdx121xBMsOcID5QqCYwkeC853C8+unhT4/nk
         ryd5XM15kqmNkcj1xOiEEkihbLx03Flwzv7aKkKpkk547L2+tks82i6wbkzAxuV/90Ao
         Patz09QlYC1dG2GzolwB9ZzJoeuJCM0Go+AUis63U5pU2Enhej0WET1vG0Vr+Alr8HAS
         8ZaaFBn3bn4THCM8Eq89bEfkz+xEMA7+KNNtCuHnWKHcpekiXUSvTFRGvc5CDyDdC/Y3
         OCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772556557; x=1773161357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SEHyvGe5cSi/xW6lB+JhvVS9IlC90KwrfzMekawFEjI=;
        b=msjIx7iBUlCQCV3IQDwsL9AReVxoZVBXmzO2DDSvWpZsRjJFO8xYdHMPQng73zeRS8
         GUtiPy11SrT2L8QCWW6YtrjjnYEQ32YqK5Swa/zVsA9+48RtynpwUnw/IzOF4NNKs4jK
         1EDTZ1Ej6YeQMudrJW6K2wj8k+DdvXLws7GLKqR53NH/1W8ec9i9mVLD/V1zsJM77mMq
         zamG9cSTTr7BDYfsVvwOpT+64q7hwxuBpeHbJ/rFpCQVpf4Q7vWKrRKr+5e4omk87iWu
         VqaooFehaKkAgGAG4aIL2lw30NF+sf380z7S1ypZW4+7PZZ4noDQz0TWc4xkfSlB4pcT
         duEg==
X-Forwarded-Encrypted: i=1; AJvYcCVXWNPHbcrg7b1uQ1S4hZjB3hYBWdSOLV9gniCskJtE9YjcRd9zTPb8EMqHyL+tqX8ja118ZYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC2EA4DmNDzmM1+Er3OFv/7p6qDe7aCVSiHfbNj2BeyNiDMUFL
	1TkErG2BiUwRXm8tIbf4SznicygJOK2ypUTIo2/V1dNeEMsD81wdGjT8HLiT0x2kBn1VTnxxuHL
	qP8VVdg==
X-Received: from pgnh6.prod.google.com ([2002:a63:3846:0:b0:c6e:7961:10d6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9145:b0:35e:5a46:2d68
 with SMTP id adf61e73a8af0-395c39df07amr14500338637.9.1772556556966; Tue, 03
 Mar 2026 08:49:16 -0800 (PST)
Date: Tue, 3 Mar 2026 08:49:15 -0800
In-Reply-To: <20260303003421.2185681-10-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260303003421.2185681-1-yosry@kernel.org> <20260303003421.2185681-10-yosry@kernel.org>
Message-ID: <aacRCz2bmxbma6g4@google.com>
Subject: Re: [PATCH v7 09/26] KVM: nSVM: Triple fault if restore host CR3
 fails on nested #VMEXIT
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Queue-Id: 66FD21F41C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222910-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026, Yosry Ahmed wrote:
> If loading L1's CR3 fails on a nested #VMEXIT, nested_svm_vmexit()
> returns an error code that is ignored by most callers, and continues to
> run L1 with corrupted state. A sane recovery is not possible in this
> case, and HW behavior is to cause a shutdown. Inject a triple fault
> ,nstead, and do not return early from nested_svm_vmexit(). Continue

s/,/i

> cleaning up the vCPU state (e.g. clear pending exceptions), to handle
> the failure as gracefully as possible.
> 
> >From the APM:
> 	Upon #VMEXIT, the processor performs the following actions in
> 	order to return to the host execution context:
> 
> 	...
> 	if (illegal host state loaded, or exception while loading
> 	    host state)
> 		shutdown
> 	else
> 		execute first host instruction following the VMRUN

Uber nit, use spaces instead of tabs in changelogs, as indenting eight chars is
almost always overkill and changelogs are more likely to be viewed in a reader
that has tab-stops set to something other than eight.  E.g. using two spaces as
the margin and then manual indentation of four:

From the APM:

  Upon #VMEXIT, the processor performs the following actions in order to
  return to the host execution context:

  ...

  if (illegal host state loaded, or exception while loading host state)
      shutdown
  else
      execute first host instruction following the VMRUN

Remove the return value of nested_svm_vmexit(), which is mostly
unchecked anyway.


> Remove the return value of nested_svm_vmexit(), which is mostly
> unchecked anyway.
> 
> Fixes: d82aaef9c88a ("KVM: nSVM: use nested_svm_load_cr3() on guest->host switch")
> CC: stable@vger.kernel.org

Heh, and super duper uber nit, "Cc:" is much more common than "CC:" (I'm actually
somewhat surprised checkpatch didn't complain since it's so particular about case
for other trailers).

$ git log -10000 | grep "CC:" | wc -l
38
$ git log -10000 | grep "Cc:" | wc -l
11238

