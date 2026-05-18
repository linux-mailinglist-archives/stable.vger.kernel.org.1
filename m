Return-Path: <stable+bounces-249190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOqOIGOzCmpx5wQAu9opvQ
	(envelope-from <stable+bounces-249190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 08:36:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CF2566C25
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 08:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96D8B3038292
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 06:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D3130567B;
	Mon, 18 May 2026 06:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2JJ8bwB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AB030567F
	for <stable@vger.kernel.org>; Mon, 18 May 2026 06:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779086028; cv=none; b=Js8ZN4yZy8kZLldO1GRl3/q/7HPFg4aBZA6qk0TS0lIIHqBXm3sXds6WmT6f5+1GNuuoSD6oUVpz2Rmh9PJaB7XJJTfdoEyxlOjPxA7bwmTYyXxKkcE43zEa7WJianCR7dcHutj2uDo2PYVSaEKp9xYrOUQOlUOt1/X4SOlmgtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779086028; c=relaxed/simple;
	bh=GzirVmbbl19vb3T/f30XWXfsVpjcUcgMGXyjfyCBb7o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bo5b38gMa00SQKrHxFBytlMWeUL6fpYwQ8uvef0IuNvdVwjuaqgI4csXwX/X3DPBxQvm+WWIgtA7b8H7BDvOkn2ZVsQCJnLdUJVK8TL/ptqt1N4oPIxhLrwCnukssluCoSPAgMWcA7RtQpJM7c4ovLWTNAw395AEijBzlJChDcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2JJ8bwB; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-449de065cb3so1742683f8f.2
        for <stable@vger.kernel.org>; Sun, 17 May 2026 23:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779086024; x=1779690824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0+ToRarRTop3v5V07kaNb9bFJZRjYjBP/9rHn8kGX0=;
        b=X2JJ8bwB6ORESoUbTRIWqZNXHFo9iPp1kW1DIq6PJtrnmtn2RUa0bDJbR9emgP3b2+
         saorC1JEYfGyaw3YbFnR6uWm1R5VjZ732E5kBk5G1zWp2qJQZ3zxhffzCo9ewewJDSOC
         Eok30vrwwyZ+2C3GmHfBny6u1L4Bj+bZ/n6KV4p9C0mmiIR8xkaBIpLjyiJLIQonbskM
         u5YILvLDlrantHl0VRd3WIiguo+Nyb0mlSrvhB511frlQK3yNFcHFHvX+/uiuafD4dm7
         95caTkop9TDnEEVGOACnhiQiWmjVVsvNknNvLMRtzJkO+1RV002t8hGmYX7XtLAYSVWS
         f60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779086024; x=1779690824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R0+ToRarRTop3v5V07kaNb9bFJZRjYjBP/9rHn8kGX0=;
        b=gatL/COlBsPdwENMytfeZ15d8V2ddDMhBGz8f1ggazW7MTouC+kY4LoGnsLmVTtyla
         +AqYzw9XsPMGbgO2yJWmkuQ1UHDJ4i4ng2AmiD+qLU3FAIOroIQgFNvZ3pi+GO7Pfyhf
         q6vPRVlJjVvegGy+/g/CJJhC5Q9hYSBRcatbBEM/Gi71WLXyfeCehru6O0+eKD4SIaxX
         6aALtnLFCtunql2itBPqqMR8pMT32tTd/vO6oJqLxISpk9knTJxkxAAHfbaVHAsE+THQ
         /Y1zEosk/N4paZthHbwRkfkUydaww/5kE0cM1tlmrVDhBx3r502QvcsRx6ZFb4QjoGTO
         CwLA==
X-Forwarded-Encrypted: i=1; AFNElJ9JdNJn6iPo7bApUkWPmmQ/VYoriZSi6SSF1OZNqq4F+U9RmfTcgPsJDWKVr74qc7VCvto7kuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgRUK+l9kupYsai4sChAY9JhAAfit+R+cIW8J36Hh6eMICFswx
	AlQf19uE4Q6cpF2gwwJPDp5NoOj1v5QuaqqHjnBe1wO99Cl1xa26TLYU
X-Gm-Gg: Acq92OEAe1ENKoAwnJ7iH7YIW8xVkT+9atO6r4CRo00nL0FEm4OCouE0E5csjEr0Jjb
	pl2PtvRy8YevxSnINZlZgiqWb3AfPadY0wkF6hTyv9d7pCwOC3F8vWKw2Z1PhQIoVvsbcQlkYyX
	T7PLmtSq82L19Jq9MtFIiVwT82AT1vLwC4BHnJ5osXeIstZK4Z1YKUY6dV/yOmugpcKDSc4mTNp
	CcUhwjnqIcb7n3phcpEjR0GZbzD4Enz4wUlIBLS0iFgOckPyaF74MjQ7TxbIb63lrsQytjv/mAD
	hl1CJpKxKa84L2K0uGhqYQi9aH0Q19wZ5RtMj2BrxtkDgDaBB1ZKMCkhzcMNJ8nnSiNaJGNO+He
	TsoZ1U94ISz40h612Y9W3N0PBmJzmxsbFZZ6/Vnn8rc6fK00FI4bXnXkOlh9YvZES2X4WzdyOJL
	RQFX5PPdoJJRfDVXAuqNZJuLr/lvKNk5xX
X-Received: by 2002:a05:6000:2207:b0:45e:73eb:2a75 with SMTP id ffacd0b85a97d-45e73eb2ab3mr8485115f8f.16.1779086023636;
        Sun, 17 May 2026 23:33:43 -0700 (PDT)
Received: from foxbook (bfk48.neoplus.adsl.tpnet.pl. [83.28.48.48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39806sm33840751f8f.9.2026.05.17.23.33.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 17 May 2026 23:33:43 -0700 (PDT)
Date: Mon, 18 May 2026 08:33:39 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Desnes Nunes <desnesn@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH RFT RFC] usb: xhci: Kill hosts with HCE or HSE on
 command timeout
Message-ID: <20260518083339.507e24bd.michal.pecio@gmail.com>
In-Reply-To: <20260504093118.615ff480.michal.pecio@gmail.com>
References: <20260430014817.2006885-1-desnesn@redhat.com>
	<20260430104850.352bd946.michal.pecio@gmail.com>
	<CACaw+exdPSVSfdAob7+d-xH=JEjBbPpY_z1cPPU6rzXx4wUZpA@mail.gmail.com>
	<20260430235453.2288c973.michal.pecio@gmail.com>
	<CACaw+ewwM_5eqyGW5=+THwHsYPs7u3NT096AFQdt6x4E6HcWtA@mail.gmail.com>
	<20260502114644.76e6b5a3.michal.pecio@gmail.com>
	<CACaw+eyKh7buHDoDyTOe8O65FP5cSXYdzCcQvwqKw=1DwX26oA@mail.gmail.com>
	<20260502235517.089ba5bf.michal.pecio@gmail.com>
	<CACaw+ewOTVh49tnkz+cRr0SD_Z-LmYrMWhFUrsik6YF83mPBtA@mail.gmail.com>
	<20260503071749.6abda137.michal.pecio@gmail.com>
	<CACaw+ew8uV5g1G-6qZGtVBEYZ3k+fvFrOq3XMyq-Nuhbq5mdnA@mail.gmail.com>
	<20260503213111.117db3a1.michal.pecio@gmail.com>
	<20260504093118.615ff480.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E6CF2566C25
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-249190-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michalpecio@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,usbcmd.run:url]
X-Rspamd-Action: no action

On Mon, 4 May 2026 09:31:18 +0200, Michal Pecio wrote:
> Never mind, here's the smoking gun:
> 
> [...]
> [Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: // Turn on HC, cmd = 0x5.
> [Fri May  1 09:46:41 2026] DMAR: DRHD: handling fault status reg 2
> [Fri May  1 09:46:41 2026] DMAR: [DMA Read NO_PASID] Request device
> [80:14.0] fault addr 0x1001680000 [fault reason 0x39] SM: Present bit
> in Root Entry is clear
> 
> The chip IOMMU faults shortly after setting USBCMD.RUN = 1.
> Such fault is expected to cause HSE assertion and usually it does.
> You will probably find that HSE is already set while Enable Slot
> is being queued, even if it was clear in xhci_gen_setup().
> 
> 1001680000 is close to valid addresses like 100167e000 or 100167c000.
> 
> Possible causes:
> - xHCI or IOMMU driver bug
> - HW corrupted a pointer
> - HW accessed something out of bounds
> - HW dereferenced a stale pointer from the original kernel
> 
> Do you happen to have more of those logs saved, are they all like that?
> Any chance that 1001680000 appears somewhere in the main kernel's log?

Hi again,

I see a certain lack of interest in finding the root cause of this.

I have done a simple test on my own HW: writing bogus CRCR to cause
IOMMU fault when the first command is submitted. I found that not all
HCs reliably set HSE in this case, but obviously none of them ever
complete the command properly.

It seems that unconditional hc_died() on Enable Slot timeout may not be
a bad idea. Makes me wonder if the same shouldn't apply to all commands
besides Address Device, they typically only timeout due to HW issues.

Regards,
Michal

