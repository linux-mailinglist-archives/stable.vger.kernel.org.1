Return-Path: <stable+bounces-267201-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DDbCJitGNGpCTgYAu9opvQ
	(envelope-from <stable+bounces-267201-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 21:25:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF7C6A2571
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 21:25:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=google header.b=E4AU9xGx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267201-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267201-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77D7E3019836
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 19:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E93432C302;
	Thu, 18 Jun 2026 19:25:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83C024E4A1
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 19:25:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810725; cv=none; b=mw8shKnNFDNcI/zjKUAepEF5llff5P5TCaVNBMPAJlsw/JxC4Tepd8+h8TKYCdaiDrkGbWlieCYT2prkZP4M5pORhTqPGvkIk4v1DXFdxMhYSt6nCJxKOZY4aKzELVsktS3G0EB67TiaHmecb8WtUXqQRoOaoUEaf8VVG0ylfJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810725; c=relaxed/simple;
	bh=MJ/atw/sjJbjgNUE/NJPSlbXr6d7eVv74PHfVe2Qqz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfgV1ZriwFKDWkpoN8BJRbBwCKjFateyO+PTw0/c7cvF2WVOfYIsJ6XJcKMt1qBVrcxevNXRMQDTZJbofMUmf74jLJ5yCKMWXM0WqWFNH2aytqhVwA4bKaXYZ6ywYJW6Ses1Cqey3PyGdntgo3NImkpHpUoqY+fS2WP3jwF7TCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E4AU9xGx; arc=none smtp.client-ip=209.85.218.41
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bec49f7e35eso186554466b.2
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 12:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781810722; x=1782415522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6gl/162Yyv89laBaNydReyy3xdtnaXM6oi2Bko2qKKQ=;
        b=E4AU9xGxnqZai2+JMxBxCKLKGw1fTlbShXmto3YMAJRIrTW1lfXacuH6Y4aZBKqU7V
         5M6guT8XlG8CQoXPPe1gw2BHod+eZxZTdyMD9+rVJYW5HD3WuIoEglCwWExWeKeeED3H
         7wre97/JQEZfmdwxfzFvI0SJ/s37z7gv2S+1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781810722; x=1782415522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gl/162Yyv89laBaNydReyy3xdtnaXM6oi2Bko2qKKQ=;
        b=RiAqiFZabdDnSEb7Xgd5YkIQDnqKoNwTeM86u0sDkWH/6V81h2wOV/YX/VpiMiwhMm
         wXZp45uXrIDkPWDQJVOu0mzqI6U4VV7pd+TRhdAcdu7F+XF0/XgwWKIRhjCzstUoZxCH
         Gq+AQDhFLBy4b8hZWFAH62ns9o/0WaW75VsqbXSTiRSQYN5GuZvHwVU1lt3HTsWYsh2P
         k377gigMIEp1hHNQg7kJxu9GTF4QFG2UeeK69Q8X05fQM7q4DeMhBDa6ynXXFi6rXL66
         EFsOvvTxY5kVhxRGSEvfpkHkWZreFL6+tc7dsRj0q5v2JLT7Oq7LFpCWAWUv634/PD8q
         9LMA==
X-Forwarded-Encrypted: i=1; AFNElJ+cZiAHYFeqlromqsANGh+8SRYjSvwZKlDR9r8wZuUW9Emr05Q8NgxnzQDIijQS9FD5T7HpUZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYuwUTwTj2OfbbUaXjdykWiKqAiy+C8wSh86eaCFhZ7NHuNMpN
	1ba/hr/bINUXWIUL5i1yXauxelQ6iuPo7/5cQuLG8JgmS87rFhaKMEzgBlu0d1xZ0cWO/LlbP27
	rlKaoBb8=
X-Gm-Gg: AfdE7clVgVFtqFP2rT7574o1mQPjs1iC5SuTqrLOht6giI4vUVDJSo+gs+8sB9bupGN
	42eVgpILT0FdzDVMJuYFKRXUw2pw44KGFPvP3LwB50Jn85c8j/wFbdp3A6wMjlDie/052Es/aK4
	FZ5JXhXa1Ok3Y0xXa9uanD9ZXVZDCmp0i+vQzaj3zA3wClFxYrsY8oraWoKT6EkecD5LblHkgKV
	YDmxIlImWGDXCmAt4Mj5l6pkYyZxnA9tNzCV6RS8Y7/wwXUAv/TFgYMUqlg07kjnu8gXhYYusP8
	UKLpRITSGII7Qwdt2SivReAb8mwD/BsRDu25AMsv4kph4S87zxZxeRT8GN44BFfwIfUb56YDy5N
	01y8h7AdGd+HhdRMws0SpA9OPIPZB4cLjoMZrGoB0dJvLNql7C4FPdJfgycq2n5jX9nTTUdH19y
	pVEwpLOHbUkMdwBkIjvnWAT1d5dV5GruW0ARXcOeyPk8YkW6W3LvprWam5dt++
X-Received: by 2002:a17:906:6a22:b0:c06:3880:69fb with SMTP id a640c23a62f3a-c097adf68f8mr29155566b.3.1781810722195;
        Thu, 18 Jun 2026 12:25:22 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb511b8aasm990884066b.24.2026.06.18.12.25.20
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 12:25:21 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bf046d4da1fso147539766b.3
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 12:25:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/evum7l6FpMtwTPKWk9qpPIJ4VW01j7KKzKbqbOqUun5c2zzB4di2wxNKQssvvZ54EXu2fhOY=@vger.kernel.org
X-Received: by 2002:a17:907:3cc2:b0:bfe:ed06:5a16 with SMTP id
 a640c23a62f3a-c098fed1511mr23022066b.52.1781810719995; Thu, 18 Jun 2026
 12:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618183442.BBCD71F000E9@smtp.kernel.org>
In-Reply-To: <20260618183442.BBCD71F000E9@smtp.kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Thu, 18 Jun 2026 12:25:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQ_10MRYYW+aRfLP4Ah9gDrShOvLESXtz+Q32-9M9Y9w@mail.gmail.com>
X-Gm-Features: AVVi8CfH2WnN-uQgGzjlFiJWeaLtj_2exZjAxtndehiWrEVgNpGbugy27v-vnzY
Message-ID: <CAHk-=wiQ_10MRYYW+aRfLP4Ah9gDrShOvLESXtz+Q32-9M9Y9w@mail.gmail.com>
Subject: Re: + userfaultfd-prevent-registration-of-special-vmas.patch added to
 mm-hotfixes-unstable branch
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, vladimirelitokarev@gmail.com, 
	viro@zeniv.linux.org.uk, stable@vger.kernel.org, peterx@redhat.com, 
	oleg@redhat.com, jack@suse.cz, david@kernel.org, brauner@kernel.org, 
	rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,zeniv.linux.org.uk,redhat.com,suse.cz,kernel.org];
	TAGGED_FROM(0.00)[bounces-267201-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:mm-commits@vger.kernel.org,m:vladimirelitokarev@gmail.com,m:viro@zeniv.linux.org.uk,m:stable@vger.kernel.org,m:peterx@redhat.com,m:oleg@redhat.com,m:jack@suse.cz,m:david@kernel.org,m:brauner@kernel.org,m:rppt@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[torvalds@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-foundation.org:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDF7C6A2571

On Thu, 18 Jun 2026 at 11:34, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Since VM_SPECIAL includes VM_DONTEXPAND which is set but hugetlb, exclude
> hugetlb VMAs from the check for VM_SPECIAL.

This seems bogus.

If somebody sets DONTEXPAND, then that mapping *is* special, and
userfaultfd should not mess with it.

It feels like hugetlbfs is just wrong to do this.

This has caused problems before, see MADV_DODUMP which has that same
"hugetlb doesn't follow the rules" check.

What exactly is it that hugetlbfs wants that DONTEXPAND thing to be?

That said, I don't like the VM_SPECIAL bit mask all that much, because
it doesn't specify *what* kind of "special" it is.

                  Linus

